Return-Path: <linux-kernel+bounces-798803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE34B4231D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9C53AACF6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC6B30E856;
	Wed,  3 Sep 2025 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L6y6BXTX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hYnhtyJa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479E72F4A0B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908469; cv=none; b=ufKOhwgcbERIJWSOkgV6iH4KPlY5OGXAhfeI4Y27BU9LS3CD94Umyl2tYjpv41lJaPzX9bs5UIkoDKpqEVYpu2Tm+8pYMNFM24kYugspzI7M/qaZO3AM7m/rHXeTVeexYMhufmSNIK3UEa0uWEb0Y9OO1p7xPuqKJ4hnq0EObQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908469; c=relaxed/simple;
	bh=xX8Cvmo5l2xm4cu0Tfp596ZVrvLrIsQ5oNhXG/WKsbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NXexQleTqx3dj+Csjpk9HNm5X3Yr7Afw7eEobWto5FmnhmX/ezXV2AhPllJe8VfiEBXiCaFGvKH+UIGCivo7sgjIUDFSRgcN6V5Qg2K/XwB7kiFyyZAoLz7v7+OHTkKTZjYPqZEqVjmMMxIwFSWd+1n+9cT0hsMmgjXDU5xxScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L6y6BXTX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hYnhtyJa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756908466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h99L/xUEMcKmLOyCiyNSDjuYt9VsaV2u8XsWO4O1chE=;
	b=L6y6BXTXt1GRUMgEfwZ4Rp+TOpn/kQyrz+HLBosMz3RKEXpVMMJ/IHf5J83kb9nBcCL56K
	8GlvsFTLpMKiw/ylzl26Qf+7pgjz4AUYlYv/xdMKHK0pcqsEv2NfptWjIRqINkLXb7+xXx
	jHeJ+3i4IXPwJVMl+DpeBxv+9zLcP+E4uib3ALcAyWyQHIHzPeJGjEycHM8wdIHjaj1W5v
	qSViy2u6XyKWEhc/Qb5Tj7cblJEsFst4g07QJXlp2LMGaWVaj5Y4NMPRFBZGUfT+E0x1t/
	Cl9LNQxV40M0vjnsBFMd3imurZJ1Ryahz618O8KSkcSxR6vlYCnP45r8ehUkZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756908466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h99L/xUEMcKmLOyCiyNSDjuYt9VsaV2u8XsWO4O1chE=;
	b=hYnhtyJamT7hva8b+XslxMzQ/xmvCo9csd0Por7h4e2LQ5X6wa/HMcuTvhJIO6+tJHiFxU
	4xnkJGlAjwoUwsBA==
To: Nam Cao <namcao@linutronix.de>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Marc Zyngier <maz@kernel.org>, Gautam
 Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH v2 0/3] powerpc: Cleanup and convert to MSI parent domain
In-Reply-To: <cover.1754903590.git.namcao@linutronix.de>
References: <cover.1754903590.git.namcao@linutronix.de>
Date: Wed, 03 Sep 2025 16:07:44 +0200
Message-ID: <87y0qvy6hb.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 11 2025 at 11:28, Nam Cao wrote:

> The initial implementation of PCI/MSI interrupt domains in the hierarchical
> interrupt domain model used a shortcut by providing a global PCI/MSI
> domain.
>
> This works because the PCI/MSI[X] hardware is standardized and uniform, but
> it violates the basic design principle of hierarchical interrupt domains:
> Each hardware block involved in the interrupt delivery chain should have a
> separate interrupt domain.
>
> For PCI/MSI[X], the interrupt controller is per PCI device and not a global
> made-up entity.
>
> Unsurprisingly, the shortcut turned out to have downsides as it does not
> allow dynamic allocation of interrupt vectors after initialization and it
> prevents supporting IMS on PCI. For further details, see:
>
> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de/
>
> The solution is implementing per device MSI domains, this means the
> entities which provide global PCI/MSI domain so far have to implement MSI
> parent domain functionality instead.
>
> This series:
>
>    - Untangle XIVE driver from Powernv and Pseries drivers
>
>    - Convert the Powernv and Pseries drivers to implement MSI parent domain
>      functionality

Polite reminder to the PPC folks. Can we please get this moving so we
can finally cleanup the pci_msi_create_irq_domain() leftovers?

Thanks,

        tglx

