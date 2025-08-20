Return-Path: <linux-kernel+bounces-778649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F05B2E872
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA585C7D0B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83362BE64E;
	Wed, 20 Aug 2025 23:06:18 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDE42652A4;
	Wed, 20 Aug 2025 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731178; cv=none; b=E7R8aH4sM+xIt7pIpbGu+ux5e6r8OQnG+8giX6jVber+ApIpN6q10lPHzOiLOTrJvlfMPTiRk0blaX2K0Fq5bMpjVDMDEjIUa9bPFsdUpMu9fr6Fo7ccW+NBKrKp9QR7ZOtTN/qxmtwKJvbgu5P+S6LK4bbADXOYmPgvD+jZSHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731178; c=relaxed/simple;
	bh=IPNGiRZlBWsys+6A4RC5NJaTA8reA7X3ygHjS5i3+N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEg6MnaKDLGYMEcp8pVb5VHKTFvkLNgXKU+5b9Ub2Oq51lF76zcPt12Qi8bAur6xE39aKhDrggIgAF7cFwm79Zmyjq0Hqv4vt6mlLYAeOo8hwOFl/CabiwSwAEyVS2+3YQf/eoriGFmcYkYg1MqoAg9K1jyj3jOFh87ZGMjAycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [180.158.240.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C986933BEB9;
	Wed, 20 Aug 2025 23:06:15 +0000 (UTC)
Date: Thu, 21 Aug 2025 07:06:05 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alex@ghiti.fr, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, elder@riscstar.com
Subject: Re: [PATCH] riscv: dts: spacemit: add UART resets for Soc K1
Message-ID: <20250820230605-GYA1065530@gentoo>
References: <20250807191817.157494-1-hendrik.hamerlinck@hammernet.be>
 <1a4a25d2-25a1-4d06-bba6-50f51cfbb619@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a4a25d2-25a1-4d06-bba6-50f51cfbb619@hammernet.be>

On 20:27 Wed 20 Aug     , Hendrik Hamerlinck wrote:
> Hello,
> 
> On 8/7/25 21:18, Hendrik Hamerlinck wrote:
> > Add reset control entries for all UARTs in the SpaceMIT K1 SoC Device Tree.
> > UART0 was functional as it did not need a reset. But the other UARTs were
> > unable to access their registers without the reset being applied.
> >
> > Although perhaps not needed I did add the reset for UART0 as well,
> > to ensure consistency across all UARTs. With the current-speed set to
> > 112500 baud rate, it matches the factory U-Boot settings.
> > This should not give issues with early console usage. But perhaps it could
> > be a good idea to let somebody else confirm this as well.
> I have tested this version for a while and no longer see the need for
> additional confirmation.
> 
> >
> > Tested this locally on both Orange Pi RV2 and Banana Pi BPI-F3 boards. 
> > I enabled the UART9 and was able to use it successfully.
> >
> Just a gentle reminder about this patch.
> 
> All UARTs are listed in the K1 device tree and probed by the 8250_of driver,
> but without reset lines most of them are non-functional. Adding the resets
> makes them usable when mapped to devices.
> 
that probably due to other UARTs are in assert mode by default, while
UART0 already configured by bootloader..

> This patch is limited to DTS reset handling, so UARTs are usable in the
> current state. I’m aware Alex Elder is assigned to the UART peripheral on
> the wiki and will likely handle the broader driver improvements (DMA,
> clock updates, full baud-rate support), so this should not interfere with
> that work.
> 
> Thanks for taking a look!
> 
> Kind regards,
> Hendrik
> 

-- 
Yixun Lan (dlan)

