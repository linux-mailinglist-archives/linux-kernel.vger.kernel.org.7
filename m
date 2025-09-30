Return-Path: <linux-kernel+bounces-837206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4F8BABAFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399561885A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 06:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A3029B781;
	Tue, 30 Sep 2025 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fS9QuAhQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I9G996un"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE368298CDC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759214502; cv=none; b=NjomxAjaCsieHktPUrqjBw9YNpfctnqZWelfTHiofemifyTJjSlRg1sEg0y8Jl62aDGurjWo+U8yIhwKL+Y2tWnJyxLnLCIxUdJzyAtHNnACFKVep591EIV90xqxbdzoT2bu+KXPKsZc8wn4iuZDwyUBuBpqQ8M2kozlVwtphZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759214502; c=relaxed/simple;
	bh=hukKmM0TepfR/MUgVmRyq7OFgcoZWcgIjKnfeWGQaXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inbdQM+iGP1yf6tKW0IdFUhHb+8gkPjS8RkLM5Nkhw/169XdXOv3TpkmoQWKxWCiODgR+ee4VMiHz1UGz7AzUFOxYVzkJUwfeiH8PcAfblt5oeR9mXmGKDyewTkCgY6Oc/ROwV3THY+K1RKdRAOVN8kwebLQVkdaGsHHDlydXX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fS9QuAhQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I9G996un; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Sep 2025 08:41:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759214498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hukKmM0TepfR/MUgVmRyq7OFgcoZWcgIjKnfeWGQaXc=;
	b=fS9QuAhQWTzjAuBqwvVgBLgWvMIcpZpud1Z/r9qeQQ5PGahYtLOalqKxnLAYwSEbRGMcUX
	IBKdUQV+uyp3nu448mWMy6alGMYf4UFjOjP9HUBDV+eK0D8hEz+02xPlSOyx0JxYRt7zcn
	sV3EoxSDmVAhWDXbD+Spf8u+E/fioa7A4YIjyCtVdX3TXR1XyQGscCUjbLPO1nmiU4FKyd
	/pyKNoG6ue9F15riY3vo1btFORU6J3PJLBJXTksufAzLKq6p0NuXjyKNaR/w7Yd/HoEXH6
	TuMDaLJK6pxfinbMHpr2YydrLfiAsXkLv74VuDhm/6rpupa0KJBP8tqI4WOZww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759214498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hukKmM0TepfR/MUgVmRyq7OFgcoZWcgIjKnfeWGQaXc=;
	b=I9G996un9Gmq2TDw8KDPZf85hW5yKOjw5y56s6Px+WHT+dSMvPOGozyhoBQjcYBGq8fxY3
	d5w2OkbKFUrtIoBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce
 risk of shadowing
Message-ID: <20250930064136.c_4utjiu@linutronix.de>
References: <20250925-local_lock_internal_fix_shadow-v2-1-d3b85ee775a4@kernel.org>
 <6c49739d-6f2a-4c49-a04b-9774f10a6925@suse.cz>
 <15ca65ee-6a2c-419d-8ef3-bca2c44bc42c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <15ca65ee-6a2c-419d-8ef3-bca2c44bc42c@kernel.org>

On 2025-09-29 17:50:47 [+0900], Vincent Mailhol wrote:
> On 9/26/25 11:16 PM, Vlastimil Babka wrote:
> > +CC LOCKING PRIMITIVES maintainers. Looks like local_lock files were ne=
ver
> > added to the section, should we?
>=20
> Shall I=C2=A0resend with the correct list of persons in CC? Or is it OK a=
s-is?

I think you you got them. I didn't have the time to look at this yet.

> Yours sincerely,
> Vincent Mailhol

Sebastian

