Return-Path: <linux-kernel+bounces-867253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82081C02061
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DEB23B6892
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700602D9795;
	Thu, 23 Oct 2025 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aUJAjj3Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F6p8wHI6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568A6332EBD
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232013; cv=none; b=sdXtd233C0CL1NmyUenZzJj2OGONNDKBXVaqeVP/T6jgRgStrUwZ2VyKfqRLOOErTH6VbC+HXgxh2+X8fZx6eWx9HMo30TGAH66zw3Am8+QxzHGAcZRn6hn9Pwp7ahwJPPvOeEZBHt2lZX3BlJOR/c5SiRCnm+PXy47/OpRAlC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232013; c=relaxed/simple;
	bh=/ezP4oTRD23gtRkBqSnuAJOUv4bJhmOvmu9Hn5f8leg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LtWp9JUzsD+rMGUHYlo8ZOF8Wo2bKIy3dTOMoJra32rj0R4waqF1q/rOOwM7Dpf9VfmVtLIaJCkboUGX7DAoXzfCDsr96QroxGWWDUR3pCtDuX3PEM70jg2EuHS/JEjJIZ+K15ouwxYLyjwvTrYKgMLsGgRKwqrPprnneJGumck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aUJAjj3Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F6p8wHI6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761232010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYPhGAFKndgERkLTCrZGpcJ0Ot2g9eQ24KEX8bs13/U=;
	b=aUJAjj3Zyl+wRC93q+DVUk3NGa6QzjseS12sAYTirPGliaWzH20DM10Phxyq7e/YGCf5hl
	9ptJOOHPiKuwmc0pcVR2u5fCCOv/xNC/BXZclx0hKMaEczhNTJWmrHA6q4cswquvleYS5b
	DbU+dDZ4vh+f7bKGEfGLykwfwEsO76mhKmT3wpNlP4Wbd1cwNKnTRLXi4z+zQ4yEXdcB1g
	KYnR2rnLoLJ88wrEqP9OF+pBwhr/erEqU0x44AWlxAyNmoi1XJSfeEQySnNoCWzlxDPJaK
	MTHlr43ewHEn4Gow76f056Ye8FCU/LYhpPdAj4YC3gFY2uazJAykW7EkBTQonA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761232010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OYPhGAFKndgERkLTCrZGpcJ0Ot2g9eQ24KEX8bs13/U=;
	b=F6p8wHI6STs+GbYOeirmpELw8Ip8WQidbp31imoaCxRlShE9g8czn+jhwCVdLKOtbBxqFg
	/9c9fbpnVapTkTDQ==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Oleg Nesterov
 <oleg@redhat.com>, Petr Mladek <pmladek@suse.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
In-Reply-To: <20251023142655.FvZkeSa-@linutronix.de>
References: <20251022154115.GA22400@redhat.com>
 <20251023103234.GA27415@redhat.com>
 <20251023142655.FvZkeSa-@linutronix.de>
Date: Thu, 23 Oct 2025 17:12:49 +0206
Message-ID: <87wm4lbqt2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-10-23, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> @@ -3016,7 +3017,7 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
>>  static inline void printk_legacy_allow_spinlock_enter(void) { }
>>  static inline void printk_legacy_allow_spinlock_exit(void) { }
>>  #else
>> -static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_SLEEP);
>> +static DEFINE_WAIT_OVERRIDE_MAP(printk_legacy_map, LD_WAIT_CONFIG);
>
> We could use this lock_map_acquire_try() directly but okay having it in
> one spot with a comment might have its benefit. But _why_ is here a
> CONFIG_PREEMPT_RT? This is supposed to work in both cases. Should a
> legacy driver be invoked on RT then the comment is not accurate, lockdep
> won't yell but we still have CONFIG_DEBUG_ATOMIC_SLEEP making its own
> judgement.

With PREEMPT_RT, legacy console printing is forced into its own
dedicated kthread. At runtime this is checked via
force_legacy_kthread(). So with PREEMPT_RT there is no need for special
lockdep trickery. Once we can get all the consoles switched over to
nbcon, !PREEMPT_RT will also not need this lockdep trickery.

John

