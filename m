Return-Path: <linux-kernel+bounces-859463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B0BEDB9F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 22:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FF9B19A6E58
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 20:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96762D47EE;
	Sat, 18 Oct 2025 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="219YyT2k"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E22D979F;
	Sat, 18 Oct 2025 20:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760819931; cv=none; b=Fj+XWlnaxyOcuyXZQ6IaH+eF8o5yfCxKLVLjneDag7ZEtRiReNcV52mUv5Bts0ACnHVprtS9L51FLW334SsAocGLnW/+1SZBzx9igx77l1LTr2jJW+Fa56duuLMcEnW/w/OVXjrznSogZc75j5VSdYUTd4Zt8Y+j4rh+1FR14Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760819931; c=relaxed/simple;
	bh=BDlTXnZyPJ6jOypQ1rfy1Sp9exNrdfpte5pqalUxZvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syGrB7Pcja0woidbDa6HxtZbI1QTsHYusuEPO+S02kk9dSGzz0fd5VebHaZ6MD11R8vWEfq/lkZZYsrFbICWNhZ/tXVEg7McsqqkSydgVxVLHohXyTf89sI+SiemFTDdSE10xDRE/dXmhZwxayZwJ8z5H4mqR+LV1BwoOumu+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=219YyT2k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QO5CCKZz8K+FxHChucX6dPFxnD74Zj4nIadAyB4UqqY=; b=219YyT2koGh9ZG2kniua6hTtA3
	kytbSTUCvH09jHO6xXuf3x3Wc6W3WX0VChfdQ3HfTBaGmxtTF3F1A+cM12lNgHKF8d4kUx4gV6pGN
	HNsUb3N8w6uO6+o2yuRj2Ps5j/XN2dRTfCiXoXBz1mu5HGG5Y8Zmz1huUjGQhGi+zR64=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vADgv-00BOZC-9S; Sat, 18 Oct 2025 22:38:17 +0200
Date: Sat, 18 Oct 2025 22:38:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Han Gao <rabenda.cn@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>,
	netdev@vger.kernel.org, sophgo@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH] net: stmmac: dwmac-sophgo: Add phy interface filter
Message-ID: <c16e53f9-f506-41e8-b3c6-cc3bdb1843e1@lunn.ch>
References: <20251017011802.523140-1-inochiama@gmail.com>
 <34fcc4cd-cd3d-418a-8d06-7426d2514dee@lunn.ch>
 <i5prc7y4fxt3krghgvs7buyfkwwulxnsc2oagbwdjx4tbqjqls@fx4nkkyz6tdt>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i5prc7y4fxt3krghgvs7buyfkwwulxnsc2oagbwdjx4tbqjqls@fx4nkkyz6tdt>

On Sat, Oct 18, 2025 at 08:42:07AM +0800, Inochi Amaoto wrote:
> On Fri, Oct 17, 2025 at 08:16:17PM +0200, Andrew Lunn wrote:
> > On Fri, Oct 17, 2025 at 09:18:01AM +0800, Inochi Amaoto wrote:
> > > As the SG2042 has an internal rx delay, the delay should be remove
> > > when init the mac, otherwise the phy will be misconfigurated.
> > 
> > Are there any in tree DT blobs using invalid phy-modes? In theory,
> > they should not work, but sometimes there is other magic going on. I
> > just want to make sure this is not going to cause a regression.
> > 
> 
> I see no SG2042 board using invalid phy-modes. Only rgmii-id is used,
> which is vaild.

Great, thanks for checking.

> 
> > Also, does the DT binding document list the valid phy-modes?
> > 
> 
> It does not list. Is it better for me to add a list for it?

It would be nice to list the valid modes, to match the code.

   Andrew

