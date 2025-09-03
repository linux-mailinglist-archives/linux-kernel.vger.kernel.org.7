Return-Path: <linux-kernel+bounces-798176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF45B41A55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9751A85E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9129A2ED84F;
	Wed,  3 Sep 2025 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmffAbaY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UWZAizU8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943E226AF3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756892688; cv=none; b=YAGOnCvXY0j4IvxGzS+q9+oB2EyQZQ0KotEjpMhBaHlfeQue8hEnWrarnx9F5vqRkvChN/i0sxOR8wOA/kCkeOVr76eMMphM2uPJhgKzOXzmCqBRP/G/oVi7YDCwjUC8F2P4KOMkdjY1TLe4Pch9stm51TV1BY6uysqQLVBAyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756892688; c=relaxed/simple;
	bh=gxMQwaK4UzF6M0O69NPcmbws49XtTDtQ7wt3MY/8d9s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Obl91uFY2xQS6xoMmhgkKTUa7yzAwuBTq0bpCJze70+zmZDxEyfsS50SvrwV00VuZDJQ0b/La/95K0Q3EmTugdTUrxl23KQdWh44O90oniAd09qXSYGBT0P+8BQpV8n5y1k0LcOlYd/Ao/SIB0UJHlgXzgAe+/L21iJ85g8cNyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmffAbaY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UWZAizU8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756892682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNzUH3rzrGFTDrMkVZm6xGkNoz+KsR/o/BnTXMf3rvA=;
	b=NmffAbaYRJ/BLwiaYCX7+off0Sl2s5QpfYS+7lHWaovOb+vz3snoPbardObenRD4PB+8+4
	5R8qY6NAvop+PQ1pBgCsPdDc0/NjK21ANJuNRkIpk094g9OC5NiaSrF1HDJ527nvamXujT
	eSW6D6K0atpAewG8C56AZVLabwFlklwiNnBnopjQoPUG11KpPVdkEOspNskKAqNBo+/75v
	fMzvksOOauWZuoQm0TfIAi4qCGeNuxjVu+Lp/LBU86yzrlj6xcAEQK5aQ+CGrPB06ccho4
	aUT8ZP+heVtxpbJR8FTRtA07//6vnyED7iuAzXQaJEVpzA9BZGa8jXPuKtKTvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756892682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aNzUH3rzrGFTDrMkVZm6xGkNoz+KsR/o/BnTXMf3rvA=;
	b=UWZAizU8tA08seZmWpTGdsvblCGJ08Rg6lPXSSCjDbxUVVTvy431UBPZFEUnQT7rUNfNyB
	DtauH6sSIsjn0oAg==
To: Guillaume La Roque <glaroque@baylibre.com>, vigneshr@ti.com, Nishanth
 Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Tero Kristo
 <kristo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Guillaume La Roque <glaroque@baylibre.com>
Subject: Re: [PATCH RESEND v2 2/2] soc: ti: ti_sci_inta_msi: Enable module
 compilation support
In-Reply-To: <20250902-timsi-v2-2-a5bf0f32905b@baylibre.com>
References: <20250902-timsi-v2-0-a5bf0f32905b@baylibre.com>
 <20250902-timsi-v2-2-a5bf0f32905b@baylibre.com>
Date: Wed, 03 Sep 2025 11:44:40 +0200
Message-ID: <87cy87zx87.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 02 2025 at 16:43, Guillaume La Roque wrote:
> Add module support to the TI SCI INTA MSI driver:
> - Change Kconfig from bool to tristate to allow module compilation
> - Add linux/module.h include for module functionality
> - Add MODULE_LICENSE, MODULE_DESCRIPTION, and MODULE_AUTHOR macros
>
> This allows the driver to be compiled as a loadable kernel module
> named ti_sci_inta_msi.

No objection per se, but looking at this "driver" just makes me
cry. There is zero justification for this to be separate from the actual
ti-sci-inta irq chip driver, which selects this monstrosity
unconditionally.

All of this code can be moved into the irq chip driver and thereby
consolidated to do the chip initialization and the domain fiddling in
the related data structures instead of doing it programatically.
Consolidating it reduces the number of exports and makes it one module.

No?

Thanks,

        tglx





