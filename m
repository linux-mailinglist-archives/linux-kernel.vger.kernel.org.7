Return-Path: <linux-kernel+bounces-844656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9005CBC26FA
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 83B174E2E8B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FFE2E92AB;
	Tue,  7 Oct 2025 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bx6o5vSn"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C091821ABDC;
	Tue,  7 Oct 2025 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759862957; cv=none; b=ohKSFB2YIPhvYHw1pcffP8RNFw8eyz5es4K6BSf6lOgxxNStJZNkgV44cjMGYkxe46yKxRAYUY6VBNjToUsHiuGhovfxoIQMZF2jiJ3FVjARFgf2Dx0N69+9G8GVjAcN4TjDcOXDDPfUC+37J/yROi+7hYqc/XRjlfRWwLDUsEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759862957; c=relaxed/simple;
	bh=82kY1etFyb4wOK8eKtxnpslydiETAafQa/2oCtM91hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUw9VYyWjuI+kM7g4csEpGYqceotFS9miV5K2qoDtSLEoldvDRoQa71hTdf59iUd9Ry++bRnMKaWhsbwWhy7tXZRvaBWmj1Ne4FOdOE7tPmagljMXDhUCyZE/KXgX+oHkTW1Xdiqha+BkuyBSEObGtBtsW/SfvAudQ9KM0S93js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bx6o5vSn; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HECpRpZSpa+f0H4gV1fc3tmnVQkPn2s2nhW1AKTcDnI=; b=bx6o5vSn01IQbjGoB8XJhuNYeh
	IoVN1U0YYCP/YYrMiR8MQHu6/bIEACcfqW98kmcVigwJE127t2FLo8TTeDd7bwz4k0Pa7le/dLhL1
	gIppZ+XPiraOqpksZirTfMKUY2SI7zm3TrqqDDzH477Sdcbcsacuz1dDmBGn5Ar57o6WntFnSM4Z+
	rLvC552t2JKy16XZWZv5eIa/qFjuSlIveu8BSK8wUyS/qdU6m53seBcEirsB7Pojn8qQZFM57Z2nn
	DjI+ghdar0HWgdFbV4WasE4O4+ZWaNQrWocXBR/80mgLr6bqsYrEfXwv17kI/VAXcqQFRpo/DalZ7
	OZQcLyGg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58056)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v6Cjz-000000005Ro-1dgJ;
	Tue, 07 Oct 2025 19:48:51 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v6Cjq-0000000038S-0fQf;
	Tue, 07 Oct 2025 19:48:42 +0100
Date: Tue, 7 Oct 2025 19:48:41 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: jjm2473 <jjm2473@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, heiko@sntech.de, quentin.schulz@cherry.de,
	kever.yang@rock-chips.com, naoki@radxa.com, honyuenkwun@gmail.com,
	inindev@gmail.com, ivan8215145640@gmail.com,
	neil.armstrong@linaro.org, mani@kernel.org, dsimic@manjaro.org,
	pbrobinson@gmail.com, alchark@gmail.com, didi.debian@cknow.org,
	jbx6244@gmail.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] arm64: dts: rockchip: add LinkEase EasePi R1
Message-ID: <aOVgid5q0_AhPXFB@shell.armlinux.org.uk>
References: <20250929065714.27741-1-jjm2473@gmail.com>
 <20250929065714.27741-4-jjm2473@gmail.com>
 <d8ad476c-d0c7-4e97-9e76-540a539ffb52@lunn.ch>
 <CAP_9mL4ofig-X-w9wx1A5D_eVXROo6AVFBSwp4mh=kj7webpPA@mail.gmail.com>
 <7e219aef-88a0-4184-9553-30dcbc8dbd79@lunn.ch>
 <CAP_9mL6utQjN_2EZ4vs3K8jzcxHxvKWNTNEXZ9fAx4HuA=DNXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP_9mL6utQjN_2EZ4vs3K8jzcxHxvKWNTNEXZ9fAx4HuA=DNXA@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Oct 08, 2025 at 01:29:57AM +0800, jjm2473 wrote:
> > Vendors get things wrong, including this. 'rgmii' means the PCB adds
> > the 2ns delay. Nearly every Rockchip board follows Rockchip broken
> > vendor recommendations, and then i come along, point out how it is
> > wrong, and ask for it to be fixed, before being merged to Mainline.
> 
> I will try `rgmii-id` and rescan {tx|rx}_delay, just like
> https://lore.kernel.org/all/20250925092923.2184187-3-heiko@sntech.de/

The current situation is...

https://lore.kernel.org/r/20240304084612.711678-2-ukleinek@debian.org

Notice that the tx_delay and rx_delay are removed - because with
"rgmii-id" the stmmac glue driver ignores the delay values.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

