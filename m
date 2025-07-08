Return-Path: <linux-kernel+bounces-721616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329C0AFCBAC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57CA16AA51
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960602BE046;
	Tue,  8 Jul 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cigMvJIZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="otE6iNtq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BE47DA66
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980567; cv=none; b=cPJ7mgTxXHoOdM53q1qGgpaMWlJnO+YqOzczv9Sp5JElZGEHsfw4bqvjuqllXGluaD7Bxz5NLe/UEHSep3659vYMKy2YjOWuDUpAfDbyujwVGia/FMlX3s+4QN4H43M8yXaQdCjHkNuOR4AylYLxsMVwsot+WDTIjQGm+gISKFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980567; c=relaxed/simple;
	bh=gMllxXFj8ipNioE3GOSe8Z4g91SL3lZ3HyXzxom4pNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ip+7OCcsWhs85IHfrYT2by2o7sj5PepfMyFJWg1dZk2n5znP1zBV8XRD3zrOBwDAR2q3qqAQPBymysAgWfRlNZzmxdnZ5Q3g8rxou8r6MigzF9qodHfBGBQzguWa8cFMM4+rWaZGig3DjAYfWHwYJwiOlDFrXqD+weqxIeckCGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cigMvJIZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=otE6iNtq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 8 Jul 2025 15:15:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751980560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GddXy/fMB3fYnRODNc2XuusBsv0iBX3tQCdOWxZ75kc=;
	b=cigMvJIZLjBfcy/eAYD/W+xX79hbX7tSkqEULMgpA9xnccpDvue9Hfrv2MR2uZEbeAUtzS
	eQyLn7TN+jG67qMPP14rrTGRPqJqjpULnXtKNZuMWNxBLEvtV6eRTDVJQ1J07hrD81hFB9
	NnQV4DCjgde6WwUXOqGqQRlOez7S0FRL9bENeDscWTuzwa0PKP/89FYAqCWa9H6T8Ua8bj
	mqBt06QkLSnzY3EqOzVW0SIf/OKUfP8V8gI1cMwH70KtQRSKt5lN/m0ZrVMj3qENtn+Bh9
	jTVGSIK3TCdlmNPBwdEFAjGBtbyxPnglOjAntF+4sfoWG9uLsKQ01sdnq+FhzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751980560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GddXy/fMB3fYnRODNc2XuusBsv0iBX3tQCdOWxZ75kc=;
	b=otE6iNtqz66XbBdc6W7yqgD9khnvdtuPLQO6wug7ejDlSr079aA6PNABd+q+xEA9LcJNSv
	CUlF8i4dAh3wGpDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/3] futex: Use RCU-based per-CPU reference counting
 instead of rcuref_t
Message-ID: <20250708131558.K7QEhtjc@linutronix.de>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
 <20250708085640.2918-1-hdanton@sina.com>
 <20250708120156.2938-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250708120156.2938-1-hdanton@sina.com>

On 2025-07-08 20:01:56 [+0800], Hillf Danton wrote:
> On Tue, 8 Jul 2025 11:16:26 +0200 Sebastian Andrzej Siewior wrote:
> > On 2025-07-08 16:56:39 [+0800], Hillf Danton wrote:
> > > On Mon,  7 Jul 2025 16:36:22 +0200 Sebastian Andrzej Siewior wrote:
> > > > +static bool futex_ref_get(struct futex_private_hash *fph)
> > > > +{
> > > > +	struct mm_struct *mm = fph->mm;
> > > > +
> > > > +	guard(rcu)();
> > > > +
> > > Like regular refcount_t, it is buggy to touch fph if futex_atomic drops
> > > to 0. And more important guard(rcu) does not prevent it from dropping to 0.
> > 
> > What is your intention with this? There is an inc-if-not-zero to ensure
> 
> I am just simply wondering why get and put do not work without the rcu guard?

To ensure every get/ put user within this section observed the switch to
atomics. There is this call-rcu callback which performs the switch. This
one will be invoked after every user, that was user the per-CPU counter,
is gone and using the atomic one.

Sebastian

