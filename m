Return-Path: <linux-kernel+bounces-798792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BBBB42304
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC993A17A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A049330E829;
	Wed,  3 Sep 2025 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CkBog7u5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mGWZvAVj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93326248F58
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908291; cv=none; b=nPGdjJLIpOXekwK4juG2tFvLCyFSeb1t+U13I+ue7G8hjOchvjiuqf8soPe5yymkY/n3DYIrOlXsp7BEzxBnOI4S2fAOgFvk6z5K4srgkQR8P/9oSkkVtDpiYUM+R+o5cwyCJBJZkvgcLLTkEdIfRlUXONWrea21xFdbewJgR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908291; c=relaxed/simple;
	bh=p+ZEH/ZcrVhCVIXUI5Udnarys1NFmWVLqksBWm1fQpc=;
	h=Message-ID:From:To:Cc:In-Reply-To:References:Subject:Date; b=O2I1Glfzry7FgPM3EG3Ew3MuUj7KxDGcSgbcj01RWLe3+rIdVMiF++loJ6uNl+KtcvFKp0C/xqu+A6+I9lvMGHvWVlDQKDciYUJvOQCkee0PRFWuDSZOBYVPbgNjUQhxeSNBu/NEPcz8kIMNJ2eZ8ujbonQKvVQ31sxUBztTUhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CkBog7u5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mGWZvAVj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250903134437.863638669@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756908285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=C7+UkxIpU7THzOpGEj2MPmejivydauZV25aptIvN9c8=;
	b=CkBog7u5wJ8+iYsrCv3fsDaau3KE5zj5l9Ccalx6p1opdIRLiSC7D6fbtnmyuJ5EmLbRM7
	qzJm88TE03pt0RIV1Hcgdi/PJkNOaXhxCjB3tHVwfdEYQjDYMbJOr5cmCYNSO+jIK5/Ido
	2FdfcoW4CoXUgJl2YyWrBgsjfiiBQFCA+APN6OJZi5PuFc2K2LzW85WQuUkT/4m/TlrMwB
	3GGh4q5BfZLkcL5ySjeNH5YISw5u6bSoGV836aFE8IbJm0nf+J+d7kIUfKvIYE+5dwVhpr
	41I4VtlacPAgQn3S3MAtey6jbQDnozHxS1us7dudfIPtFT01SkJbAZ3pMoD8Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756908285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:in-reply-to:in-reply-to:references:references;
	bh=C7+UkxIpU7THzOpGEj2MPmejivydauZV25aptIvN9c8=;
	b=mGWZvAVjftTGjwUq7bCqUp28wwcUqAYtBIqdsNIblbwkDkmwo3GmnQJ8/N9QGfqmIVmaqK
	IU5uUaOy3a2okyDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <87ecv1ob9q.ffs@tglx>
References: <86o6vjelw2.wl-maz@kernel.org>
 <87ecv1ob9q.ffs@tglx>
Subject: [patch 0/2] PCI/MSI: Avoid PCI level masking during normal operation
 if requested
Date: Wed,  3 Sep 2025 16:04:44 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up to Marc's attempt on this:

     https://lore.kernel.org/lkml/20250517103011.2573288-1-maz@kernel.org

Now that the PCI/MSI side has irq_startup/shutdown() callbacks, which do
the [un]masking at the PCI level, let the MSI parent domains which insist
on being in charge of masking do so for normal operations.

That avoids going out to the PCI endpoint in the case that an interrupt has
to be masked on arrival of an interrupt in software (lazy) disabled state.

That's achieved by overwriting the irq_[un]mask() callbacks in the irq/MSI
library.

As a consequence the conditional mask/unmask logic in the regular
irq_[un]mask() callbacks of the PCI/MSI domain is not longer required.

Thanks,

	tglx
---
 irqchip/irq-msi-lib.c |   14 ++++++++++++++
 pci/msi/irqdomain.c   |   20 --------------------
 2 files changed, 14 insertions(+), 20 deletions(-)



