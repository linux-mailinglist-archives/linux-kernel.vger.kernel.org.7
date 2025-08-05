Return-Path: <linux-kernel+bounces-756118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B77A4B1B039
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB13189B11E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B1E23908B;
	Tue,  5 Aug 2025 08:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LPCVLBLR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7vbjx/OD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED23C8CE
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 08:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754382699; cv=none; b=qAb1c5yrhkrNAtuhJcnq/5VF1RkKc7Y2fTlV9q3+GPReVElqqCBnMcj6tUtISSgWxQwK46r7qgpSW0eGCnH2u0PCGg3URwBD36uBQ2+1mru3Uxw3D30Oc93eWYnr/2UcfRweuN18kjIjXDf9c3dYr9S5LiVhEF4UdqJlMxSn6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754382699; c=relaxed/simple;
	bh=iTtqvNyWbJ9IkMyX4xULbw3Uvip/5Jol5LjztPeHMjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PZeLH/mQTnxYvNJn3/oTaavTazbqr7VJn1xxZjP+9gDymt2FL0n7mZt04ULcRA9y30kiyMc0XBiOSBxKchowYXRjyiVKuAviJcljxMMX4WQS4JvX4jeTjbFPWEimnW3WoRIZvOtLWFxfnCUl8Ss5ONon0j4kxYrd8FkCdUrgJ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LPCVLBLR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7vbjx/OD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754382694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTtqvNyWbJ9IkMyX4xULbw3Uvip/5Jol5LjztPeHMjM=;
	b=LPCVLBLRclUBvupbBbj1ydmGE+YnS7ZiprkW2S+3jmCFxRTi9l5wmf5xCGsfNukGB/kOtk
	VRLP02xDDn5NQp+OzgeEPgdZebeZQuB5+JAlv6JgxoDt95n3YTX1rXSiVB3VZGVFGi7xjW
	c2BKn6V224zxyop/X2DJisJffiqDvycQhcU9xXx8OG928Q6ffubi+IaukO/vjQaz6KuRy5
	QK6KPQ9sohhBRjdZhYWs9jAaKUPPD963QeVz+jFDiUX1zGLdC6bf8hIhY8hwnJWq2x7MER
	AkU4NZe8OkrswGWcPmMO+9qby6nG00E3HtHZkRs6jrIWrjf71+PmW2G080fuSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754382694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iTtqvNyWbJ9IkMyX4xULbw3Uvip/5Jol5LjztPeHMjM=;
	b=7vbjx/ODHtPVdqQPn+aZ5es1lKK0A/i2hqELrRoPrVzo1T7KNht3mPgcbL0G9M4BD3Voyp
	x+2TkIvX2yHIKWCA==
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] irqchip/msi-lib: Fix fwnode refcount in
 msi_lib_irq_domain_select()
In-Reply-To: <20250804145553.795065-1-lpieralisi@kernel.org>
References: <20250804145553.795065-1-lpieralisi@kernel.org>
Date: Tue, 05 Aug 2025 10:31:32 +0200
Message-ID: <87y0ryf9uj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 04 2025 at 16:55, Lorenzo Pieralisi wrote:
>
> msi_lib_irq_domain_select() is used in other arches, I could not
> test on those (don't know if they have non-[DT/irqchip/acpi] specific
> fwnodes) - from a fwnode interface perspective I think that this patch
> does the right thing, it should not add any issue to existing code
> to the best of my knowledge but it has to be verified.

fwnode handles are architecture and firmware agnostic.

