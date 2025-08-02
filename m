Return-Path: <linux-kernel+bounces-754234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB9FB1904F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 00:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1C117A50D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 22:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D936327A92A;
	Sat,  2 Aug 2025 22:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZyELAxe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F7l4SGYr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82672CCDB
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 22:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754173169; cv=none; b=q0dpphPrIppP/S1PtNbvwRQunpfzvu7Pk7ouN3mhIMx0W6rBZtuN+WtvLPtb+U1yCP8FCH/az6Ka+daFuGwfg8uOXtjBNXWJhb2o+Mhf1wNQP0iKjlZ0QjWu8QDJQIduCE/IngzC7SG/yM3hpKqpFfLWajquYpMdK5tmi7v0Gkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754173169; c=relaxed/simple;
	bh=JMK52b/lb74S68maMysCoTDTMa9VFbbFcvHTMCK/q6s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ISp71eL7vOnSC0wfiAOonmYJ6JpuQ67aVDujTjCSMME0/LxqJBth1tzVGLq4q+9MZXOBGvhQB1a0DlzZkOcYnn72LxXXaoj3sGk/qbr7VmQNwxSEwuGAO4fl9pNTyaGoYQm75jVw45goZbjOqWaGAObx3rZFRHnqarpFBshXB+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZyELAxe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F7l4SGYr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754173165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYn4+AjuXVa10cV2piAdZD+Z/476ZDmv3ExwRX5MbZ0=;
	b=oZyELAxeu2s8rN1OMEHcckNbKDTT3nx5fo9vgEJGiRpDCFD4QzRCFX4cqpDK1vxP+nvLIf
	pABU5mzFGBvxBozMiPJJdSWvTeTZni07md/enETwncVAE4kBzBnive2/SvbJYhZHtlZnYm
	udWj5FYHnPxUfW2wgf5E3f7PgXUDLlaESTSlINWu9GOOpwwSq7S3YB1Ih4Idtl5naLkPQT
	isUiErFKChf3U0MA3vD8lFKc6CYlRRAKseZ7vnkGyTQ14XQjznWz0Db1Ieug2+pkQkWVy3
	8TrkixNAKYktW9F9A5VkydRx+qYlqFiVqYuZefRi1HBexQvaIMT5EH9JhVFkjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754173165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYn4+AjuXVa10cV2piAdZD+Z/476ZDmv3ExwRX5MbZ0=;
	b=F7l4SGYrgWUt4RvEHbyLwattwfCgtV95skBBsvOQ2spHGUH75LT7qP62f6anPzcPE7N6zn
	jne92jcSEaEuWlCg==
To: Kuan-Wei Chiu <visitorckw@gmail.com>, anup@brainfault.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, maz@kernel.org
Cc: jserv@ccns.ncku.edu.tw, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>, kernel
 test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] irqchip/riscv-imsic: Fix 'imsic' dereferenced before
 NULL check
In-Reply-To: <20250801172459.94708-1-visitorckw@gmail.com>
References: <20250801172459.94708-1-visitorckw@gmail.com>
Date: Sun, 03 Aug 2025 00:19:24 +0200
Message-ID: <87ms8hgydv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Aug 02 2025 at 01:24, Kuan-Wei Chiu wrote:
> Smatch reported a warning in imsic_irqdomain_init():
>
> drivers/irqchip/irq-riscv-imsic-platform.c:317 imsic_irqdomain_init() warn: variable dereferenced before check 'imsic' (see line 311)
>
> The variable imsic was dereferenced before being checked for NULL.
> To fix this, move the initialization of struct irq_domain_info after
> the NULL check to avoid accessing imsic prematurely.

It's fixed already w/o moving the struct into the middle of the code:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=irq/urgent

But thanks a lot for caring!

Thanks,

        tglx

