Return-Path: <linux-kernel+bounces-721227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB119AFC65A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DD44A6167
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E1F2BF00D;
	Tue,  8 Jul 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="DIwHF74K"
Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D0013A3F7
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965033; cv=none; b=KPytJCtmPC9UbKlWNKJ8D+Jrh9HzJoOXRrCpvJxLNTsKWzoT4aZaNQ49L/HqxwHi5XY4WOte3HSVaSY2pfwlPT71eexU2uV3ls5KeO2skjnNbhJoPFqoT8AJ1/qqa4hFeP0YrTLtTnhr7Xm3OTu8C0R00rmwPZtPI8GHRy3L/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965033; c=relaxed/simple;
	bh=2VszeduhdHlPEwePAILM1Wuccyz5R7epZp7ZvpePINI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cE3OqsfO2Lp84Ij/hB5KOxGMnjSJrYljThCIZlHd1shkj7nhHXur1WSnQ4Ho6mD6JTewi7T5XeYEc7VefkGKUnF0kxah1KoljBtdxqPyRsMYq616Zb713qaMuYjfvMaLwAsf0ZhkUW0/HXuUIvYJ6SAiBEbWqt+SeN6hUJUycc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=DIwHF74K; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1751965022;
	bh=RYRLkbEQmLV1SnR/IzdEMotgg7VW9zGb9mSVmT7p2EU=;
	h=From:Subject:Date:Message-ID;
	b=DIwHF74KZYZXC9XqkXjGpZbkcGf7+Y9xqW8mPGcTUyOkQGQ/6mpbweYpcQ4IE4zGw
	 GoS0C0vRzjXPRtWIWYDSPBokHDMtQYHE7g1ZExo8HpK6Mr0l7suFvaVF1k7GPXpTDX
	 XByv1BO6AJXj9ZVda4IiH44ruLVeN2yX1GYJxJ0w=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.31) with ESMTP
	id 686CDD5200004B84; Tue, 8 Jul 2025 16:56:53 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 791236816358
X-SMAIL-UIID: E217354978E64BB396E8AF9ADB175C7F-20250708-165653-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/3] futex: Use RCU-based per-CPU reference counting instead of rcuref_t
Date: Tue,  8 Jul 2025 16:56:39 +0800
Message-ID: <20250708085640.2918-1-hdanton@sina.com>
In-Reply-To: <20250707143623.70325-3-bigeasy@linutronix.de>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon,  7 Jul 2025 16:36:22 +0200 Sebastian Andrzej Siewior wrote:
> +static bool futex_ref_get(struct futex_private_hash *fph)
> +{
> +	struct mm_struct *mm = fph->mm;
> +
> +	guard(rcu)();
> +
Like regular refcount_t, it is buggy to touch fph if futex_atomic drops
to 0. And more important guard(rcu) does not prevent it from dropping to 0.

> +	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
> +		this_cpu_inc(*mm->futex_ref);
> +		return true;
> +	}
> +
> +	return atomic_long_inc_not_zero(&mm->futex_atomic);
> +}
> +
> +static bool futex_ref_put(struct futex_private_hash *fph)
> +{
> +	struct mm_struct *mm = fph->mm;
> +
> +	guard(rcu)();
> +
> +	if (smp_load_acquire(&fph->state) == FR_PERCPU) {
> +		this_cpu_dec(*mm->futex_ref);
> +		return false;
> +	}
> +
> +	return atomic_long_dec_and_test(&mm->futex_atomic);
> +}

