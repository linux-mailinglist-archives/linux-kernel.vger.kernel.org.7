Return-Path: <linux-kernel+bounces-766204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A65DB243A9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB1A7B0817
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A227C2E424B;
	Wed, 13 Aug 2025 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="k4ogtrMR"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C0229BDA9;
	Wed, 13 Aug 2025 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755072308; cv=none; b=ZZdsI2emHoZ89cMtORq/xftQWJVdWlzQrRvIM1m7RfJ7KquNQ8PQFX5FgZ0kE0Kwby5X5EhYCzAJS6jpWQ4H/tB8WMBy/MNPsP5Dna8b4oO+V18x+zA4IaKvQTmGvwhuEyXMgbX3j0OwVQHJH67pO/yOI2gKGpisdMyz0cD3LM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755072308; c=relaxed/simple;
	bh=k2quWAYJN0mrhO2L7Dv5sP0satmZdXbTO0q0ocGDgtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgHqyYy0AO0iShuwUX+LM666uCFK7fV6iwgOyuZtG4VefBDaF0GKs93mHLwCQxB4t8nmRdC/8wkqVMc7j1u1Lyij8lSvMDpwWuKqsWN6cZFLouBrohvRMPD3VgOISBErXzkXtG8Rz5ZBhRiA4BMIXjGmVC9AlIKLtg4TrwZRgD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=k4ogtrMR; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9EC9422C21;
	Wed, 13 Aug 2025 10:04:56 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xzpl8vKaCdHJ; Wed, 13 Aug 2025 10:04:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755072295; bh=k2quWAYJN0mrhO2L7Dv5sP0satmZdXbTO0q0ocGDgtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k4ogtrMRjSJ5MfXdfmM5BKOEHMD5g1sbgCnqNumpW8UxbDKtqGIMwc2bx7LVnpas3
	 lAEcXvaOTtGZP4eOXLlSTRdNPuvd6HkZgc4EFJcaE7V5vAPOhGtbzsZVocRlOu39dl
	 CsfzFUbpEm7ny8K6kStxfq8PMLOVC3H7sIG6w+leI+P1cCuhPVCbHNio/Mq0lFSJ3Q
	 On/CBEUQZdPS7GPWgftu+PlPFEUqjh4uoosC15CTZfQP7O8qtLikL5vRyFsNoTpqKR
	 g3CA3+mN1JFVjcS6P0dugxfce8oERJfekAVYqX01bv3DyHn/TDtn0SVyaP6DsNxPgv
	 LVJI+xPSfDtfw==
Date: Wed, 13 Aug 2025 08:04:40 +0000
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH] reset: thead: Scope TH1520 reset driver to VO subsystem
Message-ID: <aJxGnnwlE1sWarXa@pie>
References: <CGME20250810211419eucas1p173e5fefcfaae437d8b5531d1406ff6a6@eucas1p1.samsung.com>
 <20250810-fix_reset_2-v1-1-b0d1900ba578@samsung.com>
 <aJrTq775sXTrsepl@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJrTq775sXTrsepl@x1>

On Mon, Aug 11, 2025 at 10:39:55PM -0700, Drew Fustini wrote:
> On Sun, Aug 10, 2025 at 11:14:19PM +0200, Michal Wilczynski wrote:
> > The reset controller driver for the TH1520 was using the generic
> > compatible string "thead,th1520-reset". However, the current
> > implementation only manages the resets for the Video Output (VO)
> > subsystem.
> 
> Looking at Section 5.4 on Page 451 of the TH1520 System User Manual [1],
> it does seem like we would ultimately need 6 separate nodes for reset
> controllers:

Yes, this is true. And another six nodes for clock controllers (there's
already one).

>  0xFF_EF01_4000: AP_SUBSYS
>  0xFF_EC02_C000: MISC_SUBSYS
>  0xFF_E404_0000: VI_SUBSYS
>  0xFF_EF52_8000: VO_SUBSYS
>  0xFF_ECC3_0000: VP_SUBSYS
>  0xFF_EF04_0000: DSP_SUBSYS
> 
> Maybe we should take this opportunity to document the bindings for all
> the resets that the REE (e.g. Linux) can control?

It's worth noting that with either mainline U-Boot or vendor U-Boot, no
core is configured to run as REE. IOW, AON_SUBSYS could be accessed by
AP cores as well.

I think introducing read-only clock support to Linux could help us to
correctly describe pvt clocks which are now replaced with a aonsys
placeholder and resolve issues like what is described in 0370395d45ca
("clk: thead: Mark essential bus clocks as CLK_IGNORE_UNUSED").

Futhermore, there may be downstream projects, e.g. U-Boot, make use of
these TEE-only devices, which could benefit if we have these devices
documented and described in devicetree, too. Thus I think the AON clock
and reset controllers should be documented as well if we're going to
document every reset/clock controller in a batch.

> It seemed like that was overkill for the 2 resets needed for the GPU,
> but, as Krzysztof noted in this thread, problems arise when bindings are
> introduced that are not complete.
> 
> Thanks,
> Drew
> 
> [1] https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/blob/main/docs/TH1520%20System%20User%20Manual.pdf

Best regards,
Yao Zi

