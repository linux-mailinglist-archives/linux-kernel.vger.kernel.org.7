Return-Path: <linux-kernel+bounces-737349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E20B0AB38
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95DA33BD93D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8393E21C9E5;
	Fri, 18 Jul 2025 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zAwC1zJj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AXTToW9r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1151F91C8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752872235; cv=none; b=C8VGoN2KH7ivatAd7xxvYU2Kegyle7cx0qvXWp/y0z/IULdZkbkxykVp8YmTj7JZfPx/cI+Be+G5Fx4Tnol6GwBQtkmCYvlzPWWtPajAnBMiNKda7sD34NZfSpVAfOnPp7VL2hulad+8ng2wdSUN/SbciAEtiCtfGUiUOSCBFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752872235; c=relaxed/simple;
	bh=qkv13khyS+s/7ulRTvXj3RRmhZ/vI/gUDBF4fgMR4dY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F243mY35IdwmoDCnDWSSabpEOfxqmG8AR94IImm/tLAN4gqdHYCtqhlt4yj5VBvhZ0DdeCNCxFAPLFmm3upVJ+jkzFvqRpvyJpEHBIUJyrz2Pdni8c7iZOfGc68IBbGOe1uflulj5ex+qCUtDJ3pzOPHwEjzeHknYjTEdHdEg0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zAwC1zJj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AXTToW9r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752872231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgJy0+Ak08s/B1gTJlFV2wzNA1cGTTofN2IFWk+lZFY=;
	b=zAwC1zJj7GQK7ZWUcjeUliO3rW+8EGzK+Vh17u2j2XABhmXEIysb2KuhjJ2UA7Mat3z6CM
	bbE5Q0DCOqaQH58mfnB9kK3BvDILrba0121+5I70eJRD9vvKVu3t45EEkfyTGgGgNxWTck
	bguPCeP50QRT4ZhwkP1Sbdl7fdM/mfisKcfOeTyac4Irz1E2KKJYMMLESnR4b1SNi+guAr
	4ZVFIdtteEtZQq85GoKzngAVj6SGgkebulVG9UNQnElNRbK51OzB4jPXElz8B3A+blJXU+
	MpA4XtRJbus0NWAVS4wi6UkzkU4E0U57HZ3JsKxRytSPN6Itbloeni/F92hSOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752872231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgJy0+Ak08s/B1gTJlFV2wzNA1cGTTofN2IFWk+lZFY=;
	b=AXTToW9rfnNj5ebh/Wc33yVNaYg7popffNgnVuaPoCrrUh3uD7deKepTjyF4hgYMExwdTe
	q6138p3Flde1mGDw==
To: Guillaume La Roque <glaroque@baylibre.com>, vigneshr@ti.com, Nishanth
 Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Tero Kristo
 <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH 1/2] kernel: irq: msi: Export symbols for TI SCI INTA
 MSI module compilation
In-Reply-To: <20250707-timsi-v1-1-80ae43b2c550@baylibre.com>
References: <20250707-timsi-v1-0-80ae43b2c550@baylibre.com>
 <20250707-timsi-v1-1-80ae43b2c550@baylibre.com>
Date: Fri, 18 Jul 2025 22:57:10 +0200
Message-ID: <874iv9w72x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 07 2025 at 17:35, Guillaume La Roque wrote:

The made up subsystem prefix is not really useful. See:

  https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-subject

> Export MSI domain management functions to allow the TI SCI INTA MSI
> driver to be compiled as a module. The following symbols are now
> available for module use:

While symbols is technically correct, it's way simpler to understand
that these are functions.

> - msi_domain_insert_msi_desc

And with that you want to use function notation, i.e. foo() instead of foo.

Thanks,

        tglx

