Return-Path: <linux-kernel+bounces-763562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B32B2169E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413683BD492
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 20:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851592DEA73;
	Mon, 11 Aug 2025 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIZzW7+N"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB831459F6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944740; cv=none; b=Pap7MkRgi6a3wbHLKXUEEPd3+MbRZKzyWLfW6AwPBSkn5vuh/5ErMPohv81Cll4rTuhpQJF2xr5i8mpYVjxBTiS54bePk8sWKcZ3vEV4IWL9tXHXgKtLcYKgVgtxijWgqDIUm+Y6SJyV0cmxXonhanshmv2DASAv7aCP7cEQV+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944740; c=relaxed/simple;
	bh=BeN3m0xadz9YvYUbHvxtp57LYioc/6gT4/yHr3BKzFM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nuc4leNuIvN/yLY3jWT2XGhwzOt0QTiFu95aBTzhvIrnuNQelR/LcwL9MCWhQ9reZtzlelGjS/yJeou049kBmcNxuI6K0JxeoKdEV9tDCuIZXX1O/9UmYnIcG3n6E9QkeRtuyCN534BmKi0xiq4BOBae81zpmWvethNJaVHZCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIZzW7+N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754944737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZVTZDqLOIqGDACKJQ4iW2Xgu+XIsc1WR3tvSI8VBgFw=;
	b=FIZzW7+NpVLKigKFiF6FBY0KwUnaImM0i+bWiTRDtAdLGSHsoxoJbi3wJFhWAm8dGJmSKu
	G4HYv0y+wBD+H5232B/m/n4oUJHaYcQQ8hyHH1IIslgPi/MD2TK/bv5H+QLhxoKFI5wEtD
	RGvh98p16u+JmYSM7SWryFOCPuX0Uao=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-MVO15QqCMEmzJ0KlrUCytA-1; Mon, 11 Aug 2025 16:38:56 -0400
X-MC-Unique: MVO15QqCMEmzJ0KlrUCytA-1
X-Mimecast-MFC-AGG-ID: MVO15QqCMEmzJ0KlrUCytA_1754944736
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e7fd5f63a0so463423985a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754944736; x=1755549536;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVTZDqLOIqGDACKJQ4iW2Xgu+XIsc1WR3tvSI8VBgFw=;
        b=pxTBa96IWd0LIyXR6XZtFJAnCAiwKAKDosXoeR7Zn4iYPGk+qtLM42/VJcnIZNzwA+
         apuyolhFgHc6sZ5pfpXYhCqmar1qLzH3U8osX6Pdst4yHZoVmYN3CmV56Drr7MszmwmZ
         6ALVmdU2DMZVsWqwQvAbPdIvBo5C4iRT4/mjE/V/ZVkbPlUADwH6qqDBOXXpMhWMGJ3e
         RUf9OWeN/J519C3AZnNQc8Kd8bQrOe7vgCArZgMgJziVjfZIjQSZFGehfQcX0ctOllvb
         jJA1U43z58hKJaaeJKRgKSgBNmYU0OzPXVSdfs5KGYmN8EzGhflKJYCdDWWO+YOMx6E9
         7Fzg==
X-Forwarded-Encrypted: i=1; AJvYcCXBegixApUuokq5j1XuVYlz8gbF1i6GQ2MlkctR3Q9COYYWzfr+AXDtJ+7MhAg39Gl1kXleQi4dF6lSF7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDleVDne98zmhEu1HJJq1Gp6vyUcS5SHbaM8IMsMKsA3YvJCBo
	rf28qAP7Ng6lVTOIeJTcqVUh2YGfiSTIS+EO/ATG1I1UXfHgHO79SUgP9LKcyYYfLVFJo+GxWUG
	fRino5jHQZtiTAHiHDQeqw3uL3Pw4vvgLmWdXkNwPPwBomd5bsYizPhZYb9dFRydQWw==
X-Gm-Gg: ASbGncvAtrL5dXIltWToKtmrLafnXnV3iF7eQSjGf59CVm6otupDAMEspaTscDqGGOa
	2Ln4/OEP5BSIZtasChWnzjPruO8pv5dUUzLCZVfGm5hjmx4Jvo/iqGCoLJ+iOzBAAlwkv2Z0vOP
	CK/5tGNBz+6GtdU/RNl0wPurPwMe9ME8So+zwaNvP3lfRNavI9exG0iXNDIYJfGo0d/yp4IqaM6
	Rt0mEHtHmC0P3LWKSLlHW1MuA/axv42TA78IxyudFIopXp5DX8ZJn1f4SXDaHaTsDvQXQQQHhdJ
	l3rzL7TjIyVZK8Gzr2GOGLxdbPU+ZVmbioomz7n6JkyOxXfdZ5O0Xlcui3wHn8vMwLhmUYMSSg1
	AWIg8Sylk0g==
X-Received: by 2002:a05:620a:3190:b0:7e8:46ff:a520 with SMTP id af79cd13be357-7e846ffa5f3mr1032836185a.59.1754944735851;
        Mon, 11 Aug 2025 13:38:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6TJypRwgs9RgO0ZOhG4M9sxvgnyPxPyFGPY0oojF+MNjTWDK6x8l3AWs8blAumYeOx/efOw==
X-Received: by 2002:a05:620a:3190:b0:7e8:46ff:a520 with SMTP id af79cd13be357-7e846ffa5f3mr1032832285a.59.1754944735406;
        Mon, 11 Aug 2025 13:38:55 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e856555efbsm102176285a.11.2025.08.11.13.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 13:38:54 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8f357de1-72ba-497f-997a-f9a61aec6190@redhat.com>
Date: Mon, 11 Aug 2025 16:38:53 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: Add CPU Isolation documentation
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Marcelo Tosatti <mtosatti@redhat.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Michal Hocko <mhocko@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-doc@vger.kernel.org
References: <20250809094247.8384-1-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20250809094247.8384-1-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/25 5:42 AM, Frederic Weisbecker wrote:
> nohz_full was introduced in v3.10 in 2013, which means this
> documentation is overdue for 12 years.
>
> The shoemaker's children always go barefoot. And working on timers
> hasn't made me arriving on time either.
>
> Fortunately Paul wrote a part of the needed documentation a while ago,
> especially concerning nohz_full in Documentation/timers/no_hz.rst and
> also about per-CPU kthreads in
> Documentation/admin-guide/kernel-per-CPU-kthreads.rst
>
> Introduce a new page that gives an overview of CPU isolation in general.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Thanks for working on this document. It will be really useful for those 
customers that need CPU isolation.


> ---
>   Documentation/admin-guide/cpu-isolation.rst | 338 ++++++++++++++++++++
>   Documentation/admin-guide/index.rst         |   1 +
>   2 files changed, 339 insertions(+)
>   create mode 100644 Documentation/admin-guide/cpu-isolation.rst
>
> diff --git a/Documentation/admin-guide/cpu-isolation.rst b/Documentation/admin-guide/cpu-isolation.rst
> new file mode 100644
> index 000000000000..250027acf7b2
> --- /dev/null
> +++ b/Documentation/admin-guide/cpu-isolation.rst
> @@ -0,0 +1,338 @@
> +=============
> +CPU Isolation
> +=============
> +
> +Introduction
> +============
> +
> +"CPU Isolation" means leaving a CPU exclusive to a given userspace
> +workload without any undesired code interference from the kernel.
> +
> +Those interferences, commonly pointed out as "noise", can be triggered
> +by asynchronous events (interrupts, timers, scheduler preemption by
> +workqueues and kthreads, ...) or synchronous events (syscalls and page
> +faults).
> +
> +Such noise usually goes unnoticed. After all synchronous events are a
> +component of the requested kernel service. And asynchronous events are
> +either sufficiently well distributed by the scheduler when executed
> +as tasks or reasonably fast when executed as interrupt. The timer
> +interrupt can even execute 1024 times per seconds without
> +significantly measurable impact most of the time.

"significantly measurable" looks odd to me. Maybe "without a significant 
and measurable impact most of the time".

> +
> +Tradeoffs
> +~~~~~~~~~
> +
> +In terms of cost, this is the most invasive isolation feature. It is
> +assumed to be used when the workload spends most of its time in
> +userspace and doesn't rely on the kernel except for preparatory
> +work because:
> +
> +- RCU is slower due to the locked, offloaded and threaded callbacks
> +  processing (the same that would be obtained with "rcu_nocb=" boot
> +  parameter).
Should be "rcu_nocbs". The '=' is optional.

Cheers,
Longman


