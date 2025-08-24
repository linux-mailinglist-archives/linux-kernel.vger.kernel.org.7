Return-Path: <linux-kernel+bounces-783519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 927C9B32E8B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 10:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D71B77B3850
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C948260586;
	Sun, 24 Aug 2025 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4n536GwY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vLI+jrIS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1832625CC6C;
	Sun, 24 Aug 2025 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756025790; cv=none; b=c5bjQXs23UryHSg9KEQMS5FymOQ2S9NsFb+ggO2kS81SijGNFVT68FfMHzLodS76eZ2cPM3IdfaNp7auhG0RgMPf6VNWswLCc+rrZcLmbcf+SzESHtormE6YYxCnEYX0T5FZBFXxpsdeS5qjDiCH4Mk8AW0xLZcedY1ZLu/fBL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756025790; c=relaxed/simple;
	bh=wW2Nsi8g54U7aMB8h3ti3jH7CynIouD64O2dk82/8rE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U0x6lWsunbdztyAvl4qybCOb97FmAaZnaiKlxAdoLQ+UaB+3DkFjPfY0IS9qeVHzZlWBLbsXUV5Yj+TeP6et8LvDtVnTwT18CG7pF0wlXnAZx4eiXaIY5XPnhv2Tqh1iiGzgmMqBPJgWOel6AmJiByL5Ts28burnnoqR6gndps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4n536GwY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vLI+jrIS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756025786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bBpIwJuz3DbYEaP26/bWChJ0cjV2K/N4eN4y5+1NDLI=;
	b=4n536GwYkvbLwvdv+vqmVfBOP3uNQLiZzq2FL8QoNPAjnX3Tj/7xJYdHQ5dS8YUvfaX7ik
	OGsWXfFDek/awOEe+38Migkl1Nw1HRsVjivYm8xTx34tuzz2l1yAyKJgxhp2mtzdUVqVVT
	GrlFQbKPp9LaxBSjxaWNZsyfy/mz+wMJn61LZ7jH0VyDGrdbXASaS5Oyl7xVmWrC4JwEOX
	dQXCzvS+2CMAek3g8uU5g1D76w3idohRZ4gp6wCbwIz/wvPJ7Nz7YRta+N0h4+tz4z3Fcw
	raMvAnwOQv2H6cWUrSwTyicQfn8elTtZb8USiAgAkhffomfzC/mwnYgSVSerXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756025786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bBpIwJuz3DbYEaP26/bWChJ0cjV2K/N4eN4y5+1NDLI=;
	b=vLI+jrISeoNNmvB9tfK3kDd0BuynX0VGAXpbiVVR1tOIffXrnc8z4kL8J7NE07PAzztN9r
	JHf1yQTDn5L33HCQ==
To: Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] of/irq: Convert of_msi_map_id() callers to of_msi_xlate()
In-Reply-To: <20250813185244.GA553867-robh@kernel.org>
References: <20250805133443.936955-1-lpieralisi@kernel.org>
 <20250813185244.GA553867-robh@kernel.org>
Date: Sun, 24 Aug 2025 10:56:24 +0200
Message-ID: <87v7md2j47.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 13 2025 at 13:52, Rob Herring wrote:
> On Tue, Aug 05, 2025 at 03:34:43PM +0200, Lorenzo Pieralisi wrote:
>> With the introduction of the of_msi_xlate() function, the OF layer
>> provides an API to map a device ID and retrieve the MSI controller
>> node the ID is mapped to with a single call.
>> 
>> of_msi_map_id() is currently used to map a deviceID to a specific
>> MSI controller node; of_msi_xlate() can be used for that purpose
>> too, there is no need to keep the two functions.
>> 
>> Convert of_msi_map_id() to of_msi_xlate() calls and update the
>> of_msi_xlate() documentation to describe how the struct device_node
>> pointer passed in should be set-up to either provide the MSI controller
>> node target or receive its pointer upon mapping completion.
>> 
>> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> ---
>> As suggested by RobH:
>> 
>> https://lore.kernel.org/lkml/20250627213241.GA168190-robh@kernel.org/
>> 
>>  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c |  2 +-
>>  drivers/of/irq.c                            | 25 +++++----------------
>>  drivers/pci/msi/irqdomain.c                 |  2 +-
>>  include/linux/of_irq.h                      |  6 -----
>>  4 files changed, 7 insertions(+), 28 deletions(-)
>
> Looks good to me. I'm happy to take it with some acks.
>

Acked-by: Thomas Gleixner <tglx@linutronix.de>


