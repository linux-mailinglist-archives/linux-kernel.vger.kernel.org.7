Return-Path: <linux-kernel+bounces-788805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03643B38A81
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C638017CF32
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4462D97A1;
	Wed, 27 Aug 2025 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+1n6XpV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8074E2641E3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756324356; cv=none; b=CHUyYQThSLddMJplGNCHuSMWBvXBl6sbTsZWsSGt2kdR5oV5NZqFe+Ewa7ew2OUM/muOx3YCderOOJznhV6Dn0z36mHlBhYM1yRY5X3vxg7KlDkvUz2rJ3ysWqEyTyo3jBdgs9oVjnFOkyd9jMIpPDjE+2BIjqtP+jymq83TCyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756324356; c=relaxed/simple;
	bh=Zy3NK3eckHDQcyhisiUVwCj5uitIj+kU1sct6OhMgRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=az9+sNbITtKpCr6HXqJVYwAzUveX7KvLAGT9ajCM0AeMSCG9tZMQQFRMjD61QzW0sv0qiPpMjrrK9tNwlcsy2pv8LWMe27jFkyLxFTaAuJ6QzRnLB42/C7vcyvdqNSZB437SOmZWWDyJ8syy0LmeDx3LrTgiD6mLCSXNuvfevsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+1n6XpV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756324353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3adSLXzKxLve+Tl6EOUNKBa4NcgcImbT9v/YY0PzQ48=;
	b=O+1n6XpVeXObDcHNkK9leXEUiUmupJWrKR+iP+Bk7EssNG0s32KuRhm1c27MNl3XPRsaot
	WCDye2ZvwOLKeh2SDn9yWEk7/bu4vjYjfBQxaQA8h+i5T5di9n/eiXQgBOllCstfTBpK2I
	brWaFBh1zgPRdtsNLo4/9mryg1qk7so=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-MiivvYuJNNW4EisvIHye_Q-1; Wed, 27 Aug 2025 15:52:32 -0400
X-MC-Unique: MiivvYuJNNW4EisvIHye_Q-1
X-Mimecast-MFC-AGG-ID: MiivvYuJNNW4EisvIHye_Q_1756324351
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e9538359d12so300397276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756324351; x=1756929151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3adSLXzKxLve+Tl6EOUNKBa4NcgcImbT9v/YY0PzQ48=;
        b=PjUgH3ZNd1EIqiEbnsz22XjRYoMdfMOyu5Ufozgn6t5ab4HdmW1xwjkRugBeWnPTzA
         bCccuXL+kx0zjmiEqjYHVlIyotfIKmG7YUJYJcAGOG3ygMJvSqWj1F4AlPuVeGvFv9pJ
         fPAltrC1HmOrGKXzsXSdH+dpmheTND9lqnBMuR4YHgrQVa4KHE5rkBffG9hmp8Swe2H/
         7xR0JZeRS/ay6f25eWAAPxyGe8926a+A0o3fT1nkzxDQsl8NkZVZN8v9yDUWpEb1ipmC
         nju+AZgozzEorBJg4QUiYnEHTy534xIqWs6tSCnrDVa0auScXJGem3yNLsbrtIzVFKnu
         m+OQ==
X-Gm-Message-State: AOJu0YzILHJ+IJ6OBc5t2xsjcziM0dFiuzweN00Rj1SxvE2W/thFV9yH
	r2n9eNIC/V2E5ABymsdv3FpV68Vq59bhLvD0IeDdprUuUx8EAGvTTtAVj42hQqCSfSCm7fkAt7R
	hb2qxnZi9+jcwMsMl1uFLXM3qt5f4vl+t+RBZQ9W0iopubkRRM4nEoiHtXqFBL8IQ0Q==
X-Gm-Gg: ASbGnct5sEzGgHjkgzhsAcnAqhhqyXtb42R8c+fKxApvCwMjuNf5VFQjs+cMY23pekA
	I+9mvNq62JZ6Yb1mEAwsTvQQ8MySPxlHJrtkO6VJ9y9O/ixu/PpyxRlmKnZS92NlBBiFzwGSi7L
	mE1exaO7M1u/N0LSb0VkHuEmyDreGymdwDXDqRPJbYlYM6sVkyUyzgCNILHePzq9XOLWW7PoBDs
	UZWHsgs7Wumy3m8PXJANzGGeJTUZYedW8lv3ejY63MokAeYzcJkQHzDJ1QuJ4va3Fyps0FqQUa6
	PLlXPuI2XV5YXwwFGnCk
X-Received: by 2002:a05:6902:540e:b0:e93:49bf:d6e7 with SMTP id 3f1490d57ef6-e96e4793c3cmr6354057276.8.1756324351104;
        Wed, 27 Aug 2025 12:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGox0zgD9ExYnZymkesyjj7m2z4rytVLbDtGVRMVRb7/f4JXHmCgEWbY57s2K44U6zJJXzkA==
X-Received: by 2002:a05:6902:540e:b0:e93:49bf:d6e7 with SMTP id 3f1490d57ef6-e96e4793c3cmr6354004276.8.1756324350009;
        Wed, 27 Aug 2025 12:52:30 -0700 (PDT)
Received: from thinkpad2024 ([71.217.50.90])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96ecb01d6esm1001032276.33.2025.08.27.12.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 12:52:29 -0700 (PDT)
Date: Wed, 27 Aug 2025 15:52:27 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v11 0/8] timers: Exclude isolated cpus from timer
 migration
Message-ID: <aK9h-_1jO_pHSmLS@thinkpad2024>
References: <20250808160142.103852-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808160142.103852-1-gmonaco@redhat.com>

On Fri, Aug 08, 2025 at 06:01:34PM +0200, Gabriele Monaco wrote:
> The timer migration mechanism allows active CPUs to pull timers from
> idle ones to improve the overall idle time. This is however undesired
> when CPU intensive workloads run on isolated cores, as the algorithm
> would move the timers from housekeeping to isolated cores, negatively
> affecting the isolation.
> 
> Exclude isolated cores from the timer migration algorithm, extend the
> concept of unavailable cores, currently used for offline ones, to
> isolated ones:
> * A core is unavailable if isolated or offline;
> * A core is available if non isolated and online;

Hello Gabriele,

I tested your v11 patchset against 6.17-rc1-rt1 to see if it was the same issue with rtla-onoise getting latencies in the 20,000-40000 us on RHEL 10.2. It seems to have resolved the issue. Adding my tested-by tags and test results.

rtla osnoise top -c 1 -e sched:sched_switch -s 20 -T 1 -t -d 30m -q

CPU Period       Runtime        Noise  % CPU Aval   Max Noise   Max Single          HW          NMI          IRQ      Softirq       Thread
  1 #1799     1799000003      3382675    99.81196        2840            9        1578            0      1799012            0        24369

Tested-by: John B. Wyatt IV <jwyatt@redhat.com>
Tested-by: John B. Wyatt IV <sageofredondo@gmail.com>

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


