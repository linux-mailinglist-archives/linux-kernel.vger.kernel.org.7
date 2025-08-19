Return-Path: <linux-kernel+bounces-776279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D522CB2CB30
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 698994E1B24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01E130F80C;
	Tue, 19 Aug 2025 17:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5tbWiD/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866430F7F8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625147; cv=none; b=bhvlBm1ILLuhI0NbFNOj5GbmFa/Ze/wU4K4HC7zM4nNqUZLy6ngOg26VDJgjgbXgvxDG0v3VHm5+ZWn44kJ4AELKanLc8DxvlmG+H/7kgMmgoi2+GMv9YYoLgBVo7ExBz8dA+bUOxutoH1wvFk7CqmFvV/WC2PIt5cHKI26m5Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625147; c=relaxed/simple;
	bh=n5fZDRdhpblR94HQcrZl3tuMZof3rDV6okZIfBL90lU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GNj0BQecEA19mOi40iSQyCVdsRTW9pxZ1HrqQZh1TpmIF82Hh5aTsX5GO+cX3xBVFWiFaoQjetehVt6g71z91ad9h1yEQpiKHNubDdDtDp5brBFtvAiP1qYEQgSWfofRgwJWbZ/WmciA85Bkh8M6Ip2gySRX1KfaOpTAPgJf+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z5tbWiD/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755625144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1lVHf9B3MwbthIpxwmrqwUHvb4qbpr6q9mIydElOc0=;
	b=Z5tbWiD/ta46cStGZ7dC8p4OaNSoW6f0souxLxOzvxBxBZAPXXMY3e5hjpq/U8EChmDcqG
	4ozrSUCO5wAGyzNoTrJFPYvyVKpQaAs+CdwambOqjXT4P3nn3/sLk1g8lL5OpFcyHz0vH5
	ouj1eQJyCop1r6Vtm0pEPYZpgk+w424=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-7p3HTCxbMQiNO6wtva_DEw-1; Tue, 19 Aug 2025 13:39:02 -0400
X-MC-Unique: 7p3HTCxbMQiNO6wtva_DEw-1
X-Mimecast-MFC-AGG-ID: 7p3HTCxbMQiNO6wtva_DEw_1755625142
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e870324a51so1676303785a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625142; x=1756229942;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1lVHf9B3MwbthIpxwmrqwUHvb4qbpr6q9mIydElOc0=;
        b=nbnYKhzugULbgG4+kOFRgaasC2jDkrCeSmcwywRH2GxphS3l4Mr7jKMqwhs9bc/nFC
         lxABFGqRO5KRUkCD6fqGsRpkG8/i+rXiL6xZt4YUj66DOGQN2Add64ygCagU7gh9tXvu
         IxDaUDKzeHwSRK8vCOy30BJF47jsT/NpZ3fFOQn4cPHBl9TXHrqE8Wbf074Dyc0YdBmM
         BREdX4N9pJuzPnKF3DFddqPuinc7QgCvkwMRLh1eTU5c9RFx0QxamzjMUT846gLQ8gYK
         BPb9yTmOzML9R9BISws1fiOCyYOXNe5D/JY9unIBU8iIQ4SUiBXV7q+fFt5mac5GGLbZ
         WSJA==
X-Forwarded-Encrypted: i=1; AJvYcCX2WP8Hcv9rjw8iLSTJrXrBkxsNG6OZHktKIfJIPjwwqfRREiQyAH1z4avyRQmrqR5dngBb7W+gCGxvtx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV5ZmrNJhfaIzC1AgCVhcglPzG63BESnYJ3mvK9cDq0TA6nWjS
	wQSwrziHdK/ke8s5YqdU9nBrHGGHGFl8iHNSmqxjEIcFo4kCMoNfH4PyVjby7hHkWLV7C5ecXoC
	x9CXZbrCBuY6ubu292XFXJ59FP+fBdMMINlNeORbRaqXcQXTmXTydMZ82Ef0x+cD1zA==
X-Gm-Gg: ASbGncvK9xfdcy8qhiUcjFHUv2Zt4KVFGh4SIjb6MM6ZloM2QjdgWA7R6Iuff2f/t3I
	bkEYiTkzL8OOb8M3wUEBrNR88aQUPJLM8binZTz2YSi90riWj8kvkQM5FA4PM9d9EM8xuhysM80
	u9UR2gRBgGZXMJF8yBwi8VLbd+jhqRLpkr2KZY3aSw5iOzra1zeTIH3/hs4ZGLmu2XxfZiIVf6H
	bOBP88DF/BmhkTUR001THu3I5m8qUMQjCLBLf1h9I7brK3/gO2ow4lR9OLIgCYuQwsu//JYxzDL
	pkWFYoD1VDMa6lLoXRIY0fMtHiWkm+ra0ejgjW9BHXcft6yHdepVCj/hq4zZVDWxL+zTWVP84O0
	ln0bkt1ZdTQ==
X-Received: by 2002:a05:620a:2683:b0:7e6:8f41:2055 with SMTP id af79cd13be357-7e9fca94459mr16689885a.21.1755625142078;
        Tue, 19 Aug 2025 10:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgQk4w8WKFv31m629AzJg48gzsT3wV9vO3Klej86l6vqDXynU+1bYT1HQpPIZsZ30MYOYE+w==
X-Received: by 2002:a05:620a:2683:b0:7e6:8f41:2055 with SMTP id af79cd13be357-7e9fca94459mr16660385a.21.1755625138182;
        Tue, 19 Aug 2025 10:38:58 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1e15besm805438385a.72.2025.08.19.10.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 10:38:57 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8f36131b-e326-4d0e-96d6-9067b6c439d8@redhat.com>
Date: Tue, 19 Aug 2025 13:38:55 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] Documentation: locking: Add local_lock_nested_bh()
 to locktypes
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
 Clark Williams <clrkwllms@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 John Ogness <john.ogness@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Will Deacon <will@kernel.org>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
 <20250815093858.930751-3-bigeasy@linutronix.de>
 <db8defe4-14bf-4060-803f-e8b09a941d42@redhat.com>
 <20250819100046.ymb_o7VA@linutronix.de>
Content-Language: en-US
In-Reply-To: <20250819100046.ymb_o7VA@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/25 6:00 AM, Sebastian Andrzej Siewior wrote:
> On 2025-08-18 14:06:39 [-0400], Waiman Long wrote:
>>> index 80c914f6eae7a..37b6a5670c2fa 100644
>>> --- a/Documentation/locking/locktypes.rst
>>> +++ b/Documentation/locking/locktypes.rst
>>> @@ -204,6 +204,27 @@ per-CPU data structures on a non PREEMPT_RT kernel.
>>>    local_lock is not suitable to protect against preemption or interrupts on a
>>>    PREEMPT_RT kernel due to the PREEMPT_RT specific spinlock_t semantics.
>>> +CPU local scope and bottom-half
>>> +-------------------------------
>>> +
>>> +Per-CPU variables that are accessed only in softirq context should not rely on
>>> +the assumption that this context is implicitly protected due to being
>>> +non-preemptible. In a PREEMPT_RT kernel, softirq context is preemptible, and
>>> +synchronizing every bottom-half-disabled section via implicit context results
>>> +in an implicit per-CPU "big kernel lock."
>>> +
>>> +A local_lock_t together with local_lock_nested_bh() and
>>> +local_unlock_nested_bh() for locking operations help to identify the locking
>>> +scope.
>>> +
>>> +When lockdep is enabled, these functions verify that data structure access
>>> +occurs within softirq context.
>>> +Unlike local_lock(), local_unlock_nested_bh() does not disable preemption and
>>> +does not add overhead when used without lockdep.
>> Should it be local_lock_nested_bh()? It doesn't make sense to compare
>> local_unlock_nested_bh() against local_lock(). In a PREEMPT_RT kernel,
>> local_lock() disables migration but not preemption.
> Yes, it should have been the lock and not the unlock part. I mention
> just preemption part here because it focuses on the !RT part compared to
> local_lock() and that it adds no overhead.
> The PREEMPT_RT part below mentions that it behaves as a real lock so
> that should be enough (not to mention the migration part (technically
> migration must be already disabled so we could omit disabling migration
> here but it is just a counter increment/ decrement at this point so we
> don't win much by doing so)).
>
> I made the following:
>
> @@ -219,11 +219,11 @@ scope.
>   
>   When lockdep is enabled, these functions verify that data structure access
>   occurs within softirq context.
> -Unlike local_lock(), local_unlock_nested_bh() does not disable preemption and
> +Unlike local_lock(), local_lock_nested_bh() does not disable preemption and
>   does not add overhead when used without lockdep.
>   
>   On a PREEMPT_RT kernel, local_lock_t behaves as a real lock and
> -local_unlock_nested_bh() serializes access to the data structure, which allows
> +local_lock_nested_bh() serializes access to the data structure, which allows
>   removal of serialization via local_bh_disable().
>   
>   raw_spinlock_t and spinlock_t
>
> Good?

LGTM, thanks!

Cheers,
Longman


