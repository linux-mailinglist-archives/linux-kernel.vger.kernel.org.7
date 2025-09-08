Return-Path: <linux-kernel+bounces-806000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46201B4908B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F07188329B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC1E30BBA4;
	Mon,  8 Sep 2025 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="o8+m8Lzx"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22BC219A89;
	Mon,  8 Sep 2025 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339921; cv=none; b=njFOZuT2DgRv3ccMF5FNvciWMSzi9P3aw1pJEPjxRn2jbBHq/1sQPkEbUpTmllDaBfw4Dv2p7Kv2uggXpJvaVSdyqQIKqhr6iFR6QGtblq0pYZCTlfV5kPLpaWHJzk+Op7J/3roBv/75HKM/ZXq6TZ+ywWzvAc72lmAHJlbq00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339921; c=relaxed/simple;
	bh=ayrxFJGRNtBAz45zHsQEUaRKtCll3K3MyfPLaUqjqM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEwfoaGExv5yCMzUB3vwhJnEhHWZJtz0pBcPTIo39Rg8rGKTQmbnsN7ScTpkHEJabQppIHGUXddbP9uTt0EWhpKseDPH5yUXhvH+cR4/0/FdNarB6oDsIrUtb6CIgDh9uMF9wQ3FBuSv/hf65X05BNIpCGxAWJdB6LRd5oDKffo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=o8+m8Lzx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DkoRofTTaJEjiIcOQy7Byjln2nVcU088ET/Oi7Elhy8=; b=o8+m8LzxB84EaByAKWpWJ6ozr8
	aIegqjL31YTaZHmNteAMEOjr3rFBIrlFNKs4tkoZe1lGWb4Rugrih4h4wCH0uoFbIDdvjkGqouyKo
	aAjPMe7owJ7D4rtod19xjtqRkKMs0w78+G6naHEVLxCFrb2+hOBHEOpqm/4GB2NfRE5g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uvcO6-007g9S-Bh; Mon, 08 Sep 2025 15:58:30 +0200
Date: Mon, 8 Sep 2025 15:58:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: aquantia: delete
 aqr_firmware_read_fingerprint() prototype
Message-ID: <d793f0ec-d4f6-4375-8329-40c5dea124fc@lunn.ch>
References: <20250908134313.315406-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908134313.315406-1-vladimir.oltean@nxp.com>

On Mon, Sep 08, 2025 at 04:43:13PM +0300, Vladimir Oltean wrote:
> This is a development artifact of commit a76f26f7a81e ("net: phy:
> aquantia: support phy-mode = "10g-qxgmii" on NXP SPF-30841 (AQR412C)").
> This function name isn't used. Instead we have aqr_build_fingerprint()
> in aquantia_main.c.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

