Return-Path: <linux-kernel+bounces-824505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EECF8B896C6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B899E58653F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3764E3101D7;
	Fri, 19 Sep 2025 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mkKPuCmj"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45045270EBC;
	Fri, 19 Sep 2025 12:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284446; cv=none; b=m4iUpeNXcpOsloNOX1PbBJol7MF4JZjSQiNn8EqcXDiHANRLWPiFNcnZjZC3OvrzgxFGlOPHyeYm/7/B5FxV8sz8XiN4YGPO42snd0g+QULhyqPWaLp7Uou3wd62rNN+vwMj8Xa6EAu4KlSFSaqM5lsEPP2mPs/oytWy9shflns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284446; c=relaxed/simple;
	bh=U2vAZU5qyR8n6Sg+IjocQID7zfyrYA2NzI16U5IRGgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQdD3+/aTDkWojC+/6BDJdxXZiawLdrbqy/B5JgahncV4UrEu0i7Ql7CggEDUHkavRp3/ca7M3FnxTsJKjOp0qSM6iXSl3PTmRTCrzLFYS5a2LU2IejLnOGb49fTFu7iB26JbHD3QCzBrMtVj48BMQfxAzcj/21ffikjIjgjTIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mkKPuCmj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Gyhc5JpmuafQ1hv3mATi4//QrUF7MvrRrvt3Qg8U5rA=; b=mkKPuCmjDEUdGxT1Vj5V54mZSY
	q5RCKzvwPmp2on7S4N/gUOeEHuE/AYlDt4s1Ou2pzCAPyNEzDQfAuEeTKYSBT+Q6w8lDPMOvk/N1F
	ezGMLicml16VbZSd4WRGSgWYokiheCfzCN2CmbXtgdr+LFZlLkgFV7XHmse9IrxX2vt4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uza67-008vz9-OO; Fri, 19 Sep 2025 14:20:19 +0200
Date: Fri, 19 Sep 2025 14:20:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, lantao5@huawei.com,
	huangdonghua3@h-partners.com, yangshuaisong@h-partners.com,
	huangdengdui@h-partners.com, jonathan.cameron@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 3/3] net: hns3: use user configure after hardware
 reset when using kernel PHY
Message-ID: <c0c20c46-a4c5-4838-a0c0-f2d5932c2ae8@lunn.ch>
References: <20250917122954.1265844-1-shaojijie@huawei.com>
 <20250917122954.1265844-4-shaojijie@huawei.com>
 <5188066d-fcd2-41e7-bd8a-ae1dfbdd7731@lunn.ch>
 <59d9add5-a4f5-4ee2-9fd8-a2ced4cbe0d4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59d9add5-a4f5-4ee2-9fd8-a2ced4cbe0d4@huawei.com>

On Fri, Sep 19, 2025 at 02:07:34PM +0800, Jijie Shao wrote:
> 
> on 2025/9/18 1:11, Andrew Lunn wrote:
> > On Wed, Sep 17, 2025 at 08:29:54PM +0800, Jijie Shao wrote:
> > > When a reset occurring
> > Why would a reset occur? Is it the firmware crashing?
> > 
> > > Consider the case that reset was happened consecutively.
> > Does that mean the firmware crashed twice in quick succession?
> > 
> >       Andrew
> 
> Actually, We can trigger a reset by ethtool:
> ethtool --reset ethx...
 
For that, RTNL should be held. So the configuration cannot change
while the reset is happening. Two resets in quick success should not
be an issue, because they will be complete sequential, one finished
before the next one started.

	Andrew

