Return-Path: <linux-kernel+bounces-774618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0532B2B519
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9A12A8380
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 23:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405BC2798EA;
	Mon, 18 Aug 2025 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j1hPDq6W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iD5SGn6F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337392765FB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755561253; cv=none; b=vFm1gOLjBoI8mpxqmRcfKWY7Wcd7udJI1LuPdyyqxxP1dfJOh8Bxx9hzT6zebdMLg3pFT/2goZbWAUyvlXjMGug2jq/rG39P/gQQfupPsKXK1vU/EZFADE0/TNp1foK3LwdHXXthAsCKzCGJ9Z33TklbZUJ88oO/wRmfXLIe0rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755561253; c=relaxed/simple;
	bh=zqAHT6AiuT5MP8JVehrehdLKfNM5JQQ5UZ9KOWS8B0w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KfnW+/rW9G8LPW8cyfNACmOM3tR+ENQ6dMzjjRdmTXFUshV7iChd8NQT2tRVLwjbRKo/5z3dL9UUcZGwNn31OW2k8kK3vjEEItsE1F0q7N9KVOacSJ9mlE8CWtwPG7iXIvMqt+wDzfv1MksU4aYRZMqCXoqdPtmcWmWXPr8gpd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j1hPDq6W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iD5SGn6F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755561249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z/Knmbly1FaZGEVMbJ6vEZ3SAh0Ya2E8sZf+uxcYOM=;
	b=j1hPDq6WB7znDPdilUxo2i6nNNuTziD5We/wvWl4/KzTUlXQZJt7Efj46PwY147YoH9F4K
	lCLDktC6jZ1acUA67mMe3sf+S51AtnT73fHyi9giWp8nOot5cn3FNs4/MV01SF7+7DETjG
	tQCj4ziL+jwvCM78IB+MTb5Aoii5qqApJzsZ6Y06jmS/iQR735Ia/zy4mQuN/f8X4rjFxy
	QOLym9nqwgINPjqypbz34Vg/JiGiSBRs4w37bYvljeQ8earQCd97VwPRk7d7XtvLd33Non
	xc++f+tQYsWmCCzqJvlqb9IsAIenQcbW0qZxvRRHsdzG2k62vm2m6/MP/oQIpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755561249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3Z/Knmbly1FaZGEVMbJ6vEZ3SAh0Ya2E8sZf+uxcYOM=;
	b=iD5SGn6F+Umv+wgUOQzgi+rBP0L8Cuxh93tSCmKvOMfHA+YZTkrihe0TgCsYcmYh14mTuy
	QPu93iw247rgt3CA==
To: Sean Christopherson <seanjc@google.com>, Florian Weimer
 <fweimer@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
 Michael Jeanson <mjeanson@efficios.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>, Samuel Thibault
 <sthibault@debian.org>
Subject: Re: BUG: rseq selftests and librseq vs. glibc fail
In-Reply-To: <aKOMlWxic86puw4C@google.com>
References: <87frdoybk4.ffs@tglx> <lhuect8sol1.fsf@oldenburg.str.redhat.com>
 <87cy8sy2n6.ffs@tglx> <lhuwm70qvac.fsf@oldenburg.str.redhat.com>
 <aKODByTQMYFs3WVN@google.com> <lhujz30qu9f.fsf@oldenburg.str.redhat.com>
 <aKOMlWxic86puw4C@google.com>
Date: Tue, 19 Aug 2025 01:54:08 +0200
Message-ID: <87349oxk2n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 18 2025 at 13:27, Sean Christopherson wrote:
> On Mon, Aug 18, 2025, Florian Weimer wrote:
>> You need both (extern and weak) to get a weak symbol reference instead
>> of a weak symbol definition.  You still need to check &__rseq_offset, of
>> course.
>
> Ooh, you're saying add "extern" to the existing __weak symbol, not replace it.
> Huh, TIL weak symbol references are a thing.
>
> This works with static and dynamic linking, with and without an rseq-aware glibc.
>
> Thomas, does this fix the problem you were seeing?
>
> diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
> index 663a9cef1952..d17ded120d48 100644
> --- a/tools/testing/selftests/rseq/rseq.c
> +++ b/tools/testing/selftests/rseq/rseq.c
> @@ -40,9 +40,9 @@
>   * Define weak versions to play nice with binaries that are statically linked
>   * against a libc that doesn't support registering its own rseq.
>   */
> -__weak ptrdiff_t __rseq_offset;
> -__weak unsigned int __rseq_size;
> -__weak unsigned int __rseq_flags;
> +extern __weak ptrdiff_t __rseq_offset;
> +extern __weak unsigned int __rseq_size;
> +extern __weak unsigned int __rseq_flags;
>  
>  static const ptrdiff_t *libc_rseq_offset_p = &__rseq_offset;
>  static const unsigned int *libc_rseq_size_p = &__rseq_size;
> @@ -209,7 +209,7 @@ void rseq_init(void)
>          * libc not having registered a restartable sequence.  Try to find the
>          * symbols if that's the case.
>          */
> -       if (!*libc_rseq_size_p) {
> +       if (!libc_rseq_offset_p || !*libc_rseq_size_p) {

If I make that:

+       if (!*libc_rseq_offset_p || !*libc_rseq_size_p) {

then it makes sense and actually works. The pointer can hardly be NULL,
even when statically linked, no?

Thanks,

        tglx

