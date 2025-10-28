Return-Path: <linux-kernel+bounces-874244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF01C15D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17664243EC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00019286405;
	Tue, 28 Oct 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QhPaMBkG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H3KRRrfr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0478A70809
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668914; cv=none; b=JFI7Q5JZJQjA/idV7EBx60mg+JHZMXelMd4/UGUQ+2a1zCuK5lnYzVGxC8DucAwLavLr+F0QcQnlCw7MpbnmTleljid+PUFKLTAB6bszfUgMQhZ9RRl+6Va8VxdhygJzGOL2Zj66ZdOrpQOVls8FEVjOfTe9cS1KM5aGX3MuvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668914; c=relaxed/simple;
	bh=0mIrr02eodkLo0bX8l125ntXc8AWzKAXKalUzWyE7N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6YNY7U9h2EE12z0anCh9hb8v88FYEh4OqxK3qaj8aMFs0RuzYj1Dz6FlN5LiyOgFy/p1MO3Iq5FVY3P1YdDBJqz+LqhZjn4qnZ3KEaipzsSvRJWmEaOQzo1WoQb6zetq7JQ8zS1XFBrTFQYecFxj1/3DXqqhtMjOtSs8bMLWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QhPaMBkG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H3KRRrfr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 Oct 2025 17:28:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761668907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6FQw10WQ1dcKekY0WJxe794H5jIcScg92QUjH/W0WlQ=;
	b=QhPaMBkGY9zFrl/+OkoBxbpmtIiqQaNgThGZ2IehOdExen53N+8PiWuChp4GfWZY+3PSYC
	ZX+aMtY3f171EvWtBIdek+gFxbe3ZqZHQQVuAgd9Ww/7xieD23D26/Bqf3bn1pasirpF9H
	yLcnNLtZ8E1wW6ON7n/bj6P6vU1Ohj8ZxQkSIV/d7j42UYn9QSEjGieZ/r4awIalP+1FRv
	4kHGhS4ucZOBP11Ja7yIzoXyg8AihAk6I1EfDmNFJllFvNG0OYbRlvLZujome498c2wvUU
	7lqpM8WvoSOJ+IGlc2Gihq4CbP99cSaV55J/s+8jVRDna/DoQxYC8Guv6kGyZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761668907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6FQw10WQ1dcKekY0WJxe794H5jIcScg92QUjH/W0WlQ=;
	b=H3KRRrfr1ebqtnrUOyJXz/0MsInJvdsW3vJvDy55ltG7ttVpLhXg8VAIAMrNppSgCDOqrJ
	Xpohfn51lLT2cmCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: rmk+kernel@armlinux.org.uk, linux@armlinux.org.uk, rppt@kernel.org,
	vbabka@suse.cz, pfalcato@suse.de, brauner@kernel.org,
	lorenzo.stoakes@oracle.com, kuninori.morimoto.gx@renesas.com,
	tony@atomide.com, arnd@arndb.de, akpm@linux-foundation.org,
	punitagrawal@gmail.com, rjw@rjwysocki.net, marc.zyngier@arm.com,
	will@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, liaohua4@huawei.com,
	lilinjie8@huawei.com
Subject: Re: [PATCH v2 RESEND 1/2] ARM: spectre-v2: Fix potential missing
 mitigations
Message-ID: <20251028162825.x-4ryn3p@linutronix.de>
References: <20251016121622.8957-1-xieyuanbin1@huawei.com>
 <20251028162005.bLKC89Hy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028162005.bLKC89Hy@linutronix.de>

On 2025-10-28 17:20:06 [+0100], To Xie Yuanbin wrote:
> The requirement is to invoke the mitigation callback of the right CPU.
> What about disabling preemption before getting the callback and doing
> the invocation?

Something like this:

diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -20,8 +20,10 @@ typedef void (*harden_branch_predictor_fn_t)(void);
 DECLARE_PER_CPU(harden_branch_predictor_fn_t, harden_branch_predictor_fn);
 static inline void harden_branch_predictor(void)
 {
-	harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
-						  smp_processor_id());
+	harden_branch_predictor_fn_t fn;
+
+	guard(preempt)();
+	fn = per_cpu(harden_branch_predictor_fn, smp_processor_id());
 	if (fn)
 		fn();
 }

Sebastian

