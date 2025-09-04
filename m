Return-Path: <linux-kernel+bounces-800222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84647B434D4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A0104E4052
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD842BE7B8;
	Thu,  4 Sep 2025 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="kBZsKGUT"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B769432F775
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972739; cv=none; b=aZvcOM1UHm/2PVX1prAlJGMVVoOS6uBCVcyG5JoMQBAGrn15mcNmyXkv4otB/gY6nvVrO2guNottouNeaF3AQAPGhLxBPz2ydfKmlOIZXLjDmzC6rEC4McYgQ3i1OqNYGLzbhu3aCZwecb4RfvCvGXG9+42IiirhQ4nxr70HqXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972739; c=relaxed/simple;
	bh=N6Npsnyc7bgvqYUsjSHBHbabPLRsCgibAzS96LtiKs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCHkRfsB0q0wNzEOR03yqcyNsmolJ9JYtg7yDI5o+0mOoPms3rVJrXOq5t4UyPMCRFnxk8/+RT3MABJF+ZXVusgFkGrS1/J7jqo95gpoxDcPE9N16tYamthiAWjv5rulhzyL4Ug7Pqb+WmskBHSnRZH7XTjAu7C/bv/H3uL2r+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=kBZsKGUT; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3FAD1480743;
	Thu,  4 Sep 2025 09:58:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1756972733; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=+X43dhWbmJe9Xz++Pv2ayZuVgsAdoCm6ORyQ6/XM/ek=;
	b=kBZsKGUTXh40axdPM+jwNAUPcrKpHtV+eLyOGobFw9fzq5Nw0GoG8Hom5cCSOzzfoCAScQ
	lBtuzBDJWEPaH6wszhHWWr5kpl5b0/ODwsgRKdY4yU+QR1MyncGvbzcNxSojV0JvcEvQyO
	upSNBPm85nflPkb7bnlvMw5iWWv3LBJxPyqkyi4yF+WqgEeeqrxJXah1WJyk7pFQbfh+XK
	S1nPs5MfHrvkX+ZsVT7eMDfjYu45Z3XGB6tIPFArPzFHKVXyo6O3Hp+MRfK/nB9Ewso1m0
	AbNTKhAQaHJBbu1c75R+cchVAJUg1tdzQuxYonbZ/5qxeMET28GC0Vf+g36UYw==
Date: Thu, 4 Sep 2025 09:58:50 +0200
From: Alexander Dahl <ada@thorsis.com>
To: nicolas.ferre@microchip.com
Cc: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org, soc@kernel.org,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>, Alexander Dahl <ada@thorsis.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [GIT PULL] ARM: at91: fixes for 6.17
Message-ID: <20250904-comply-veal-99d4839588e9@thorsis.com>
Mail-Followup-To: nicolas.ferre@microchip.com,
	Arnd Bergmann <arnd@arndb.de>, arm@kernel.org, soc@kernel.org,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Vinod Koul <vkoul@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20250903173403.113604-1-nicolas.ferre@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903173403.113604-1-nicolas.ferre@microchip.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolas,

Am Wed, Sep 03, 2025 at 07:33:55PM +0200 schrieb nicolas.ferre@microchip.com:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Dear arm-soc maintainers,
> 
> Here are the fixes for 6.17. The addition of the Kconfig symbol is taken from a
> bigger series by Robert here:
> https://lore.kernel.org/linux-arm-kernel/20250813174720.540015-1-robert.marko@sartura.hr/
> It is needed because one patch of this series was taken before that symbols were
> defined properly (queued for 6.18). You can read the discussion here:
> https://lore.kernel.org/all/bac5390f-725a-43db-a2b6-17a68d0d733c@tuxon.dev/
> 
> Thanks, best regards,
>   Nicolas
> 
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:
> 
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-fixes-6.17
> 
> for you to fetch changes up to 217efb440933bf97a78ef328b211d8a39f4ff171:
> 
>   ARM: dts: microchip: sama7d65: Force SDMMC Legacy mode (2025-09-03 18:52:08 +0200)
> 
> ----------------------------------------------------------------
> Microchip AT91 fixes for v6.17
> 
> This update includes:
> - adaptation to the SDHCI capabilities on sama7d65 curiosity board DT as
>   SDHCI quirks are not in place yet. SD/MMC don't work without these
> - addition of one Kconfig symbol that is already used in DMA tree for
>   6.17. XDMA cannot be selected if not present.
> 
> ----------------------------------------------------------------
> Robert Marko (1):
>       ARM: at91: select ARCH_MICROCHIP

Tested on SAMA5D2 and SAM9X60 based boards.  Works for me.  Thanks for
taking care of it. :-)

Greets
Alex

> 
> Ryan Wanner (1):
>       ARM: dts: microchip: sama7d65: Force SDMMC Legacy mode
> 
>  arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dts | 2 ++
>  arch/arm/mach-at91/Kconfig                              | 4 ++++
>  2 files changed, 6 insertions(+)
> 
> -- 
> Nicolas Ferre

