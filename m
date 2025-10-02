Return-Path: <linux-kernel+bounces-840261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C17BB3F74
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655BA17557C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DD73112C9;
	Thu,  2 Oct 2025 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DyYU3RF7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39438460
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409998; cv=none; b=bWMCtXW0DlQzgJzuWhCJ6/J42/Rx9DaDQBEd+1hY+2eeTKf4UMF6yx5mk7I9rkRd5PYIPyT21fRWj41aj2Bb919+WTRaoW480WQEzlp08thdX7A24Y8PWFcdN3NRNs4ki3cw9mOL723V73tFckyU+QfUQG+JEU1MMoW9valjl7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409998; c=relaxed/simple;
	bh=izX3nCCQaqLS1Jv7FgSEyJsaMPy1OCmhp0N5oaV0p48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqKTAi/JuB2O6MCQEC5zCD3vSLS8tKr9WNqUzTEIsZkMMgPgsu45uUKlwlUkBejefoFBqXHpAipAIyUuqzapCNxqhr8sqV4oKzs5XuS9lsq6oK+1zB7PDg/tAtAB3EnARKoo3bLstenpvcOatqVQhL5pYogM9R+/2ReN2o9R2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DyYU3RF7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759409995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/c91IugN/DI5pCPN1gXYDk1M0pOWQHJBq9ic4Sn4yGc=;
	b=DyYU3RF7QQtjk2Y02lC7wJ60mKTH8gRrMHCSIqn9cmEbTUU6G1HPuQSGjr/mbhqmSNGbf0
	llcAsbwRNX+kI11CavvV28LkhsP7yuXGuQn2QDXAjqkd9UVXNeXtImstoXMEOpkoKmJWgl
	LJicTpeCa1nvYqsZ9WcQSML/TeZTD2c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-NywhOiU_PxGhYHzv7celCg-1; Thu,
 02 Oct 2025 08:59:52 -0400
X-MC-Unique: NywhOiU_PxGhYHzv7celCg-1
X-Mimecast-MFC-AGG-ID: NywhOiU_PxGhYHzv7celCg_1759409991
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFEBF195608E;
	Thu,  2 Oct 2025 12:59:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.40])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1A6361954126;
	Thu,  2 Oct 2025 12:59:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  2 Oct 2025 14:58:29 +0200 (CEST)
Date: Thu, 2 Oct 2025 14:58:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, David Howells <dhowells@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Li RongQing <lirongqing@baidu.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/1] seqlock: make the read_seqbegin_or_lock() API more
 simple and less error-prone ?
Message-ID: <20251002125823.GC32506@redhat.com>
References: <20250928161953.GA3112@redhat.com>
 <20250928162054.GB3121@redhat.com>
 <20251001130229.GO3245006@noisy.programming.kicks-ass.net>
 <20251001131337.GC20441@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001131337.GC20441@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 10/01, Oleg Nesterov wrote:
>
> +static inline int xxx(seqlock_t *lock, int lockless, int *seq, unsigned long *flags)
> +{
> +	if (lockless) {
> +		*seq = read_seqbegin(lock);
> +		return 1;
> +	} else if (*seq & 1) {
> +		if (flags)
> +			read_sequnlock_excl_irqrestore(lock, *flags);
> +		else
> +			read_sequnlock_excl(lock);
> +		return 0;
> +	} else if (read_seqretry(lock, *seq)) {
> +		if (flags)
> +			read_seqlock_excl_irqsave(lock, *flags);
> +		else
> +			read_seqlock_excl(lock);
> +		*seq = 1;
> +		return 1;
> +	} else {
> +		return 0;
> +	}
> +}
> +
> +#define __XXX(lock, lockless, seq, flags)	\
> +	for (int lockless = 1, seq; xxx(lock, lockless, &seq, flags); lockless = 0)
> +
> +#define XXX(lock, flags)	\
> +	__XXX(lock, __UNIQUE_ID(lockless), __UNIQUE_ID(seq), flags)

Or, better

	static inline int xxx(seqlock_t *lock, int *seq, unsigned long *flags)
	{
		int retry = 0;

		if (*seq & 1) {
			if (flags)
				read_sequnlock_excl_irqrestore(lock, *flags);
			else
				read_sequnlock_excl(lock);
		} else if (read_seqretry(lock, *seq)) {
			retry = *seq = 1;
			if (flags)
				read_seqlock_excl_irqsave(lock, *flags);
			else
				read_seqlock_excl(lock);
		}

		return retry;
	}

	#define __XXX(lock, lockless, seq, flags)			\
		for (int lockless = 1, seq = read_seqbegin(lock);	\
		     lockless || xxx(lock, &seq, flags);		\
		     lockless = 0)

	#define XXX(lock, flags)	\
		__XXX(lock, __UNIQUE_ID(lockless), __UNIQUE_ID(seq), flags)


With this version the change in thread_group_cputime() even shrinks .text a little bit.

I'd like to send the patch, but I still can't find a good name... Peter, will you agree
with SEQBEGIN_OR_LOCK(lock, flags) ?

Oleg.


