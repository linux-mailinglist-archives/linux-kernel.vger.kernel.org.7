Return-Path: <linux-kernel+bounces-774212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 301AAB2AFF6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0943B22F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D0C32BF31;
	Mon, 18 Aug 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="do5x4mwT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD55E32BF20
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540429; cv=none; b=Z6mgxhgaT+HkOy7PecCpJ77yJDAejFZLnrhLCkH7FrVXhbOCbKF8Bvd//6E6311uAv8ZNVxTq8dHTRz37CP3fRnNypEjDkZsUPLZ/a1eEOIIHTk9pOXJI7DRdWfXR6+RGSN5EawoDN7ip73vsCk/B1BEdq2j3iDIUo27vpc5LFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540429; c=relaxed/simple;
	bh=lMTqoKlk7xLY3zTY3FQIhHuKUdbPnwdeP9KDNAfowxQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LR+ZhUnkLrJXokclVLX9diggWuA3GtAxFReN9MS0GfnsMXQWBjW5/4ztsMYs7SwSEgtb5vioI2WoWS5qps2lW55MQT/b0hjkPR/tZKFXZ4TeQMEKSZLaKByg5ruVviI9Ll4KvwwOFnJKRjINoWgeXJTvHB1Svf/U0wG9PPHicxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=do5x4mwT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755540426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVK3uDEkCghC3XgwhOYge6qWtR3Uke3YIdcaNnS7G9w=;
	b=do5x4mwTBg/mG8FwBAI3WGIbp6MTT2ktWVFSvAKAUoQER+d9+fHo52vJoJL5dGsBUBcCLl
	btFR9n0pCU3jqhl0rOHVH51OXXHtQoilXELwBlC2Zt4P6dBgdeEvQa6vKF37Cr7nzl1E4B
	dUpOYBqIRvge9qVs3KF+FP1fcjhy3PY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-4pJ1EFrRMYu93xLhdsjvGQ-1; Mon, 18 Aug 2025 14:06:47 -0400
X-MC-Unique: 4pJ1EFrRMYu93xLhdsjvGQ-1
X-Mimecast-MFC-AGG-ID: 4pJ1EFrRMYu93xLhdsjvGQ_1755540402
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71e7d824c4aso20247197b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 11:06:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755540402; x=1756145202;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVK3uDEkCghC3XgwhOYge6qWtR3Uke3YIdcaNnS7G9w=;
        b=MkqdweW6Ja/ir3EZUUIFIyERknfORiEPZ60/nGcW6RHYPWhkVD9JhZfSWYnd9Gq7lP
         lcLFxAfr3kF2uW79Eyw1BS0c7w5nJhEnMsW+aNWxSxrzCfB/X7pYbHvCwNqnSqfmVHHx
         vQAPdwjlty/O0Tt7rFm1GusL6cveCgp9H8DWb+9+VOf3H+B3gyKzrZ7IZdeD56riMnUO
         p7NjYEkXQd0cm5vyttoOWhFVq50nTXlrEA31RcBtdpd4d+MPsynQHOKyNC2C7QGEmY1f
         3R3AnYipAe9vlc2aKWZzT+hizrnYuQKhyrbx7ufp+galHF/F/AOzXqqDjsin4H+XESp3
         1C2g==
X-Forwarded-Encrypted: i=1; AJvYcCVFemDDMUNxr8JHoSUAexO6TjnkYVI5WsgUp0kSWdVDGQVJoXPz74yrXfliAXk+s9r06/2Sx2NyYSPDMaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX25vzkxkIADL/1q3xhyz030vIKFItUz9A7TOwMEDIPaErlIZQ
	UABIB/LeYbYKFOFBLk0CxgaMwgBbn5knvCwVP367iBbNIUZXE9BcilO9apqHbyUor3dwBPTgX6W
	lIgnojzSKoNrn1LJvtrAYHN3nHmzd/Emw8M6nQH9O3aMIVEPH969fPRh5ouGQUVJYug==
X-Gm-Gg: ASbGncsNjvB6yqK76j3G8cN814PthGx5VOx2j0a8rI4v8CIAR0+k+ps4+krdB8rBhCc
	7dD4yhh7TeWxLrV5lCJiul5vy2iIAs1daTw9N+/E1lcB3Fn+xZzAxiGmLK+AGfBs+AEHWyzWLr9
	BctaTvpoHpzlmy0uPh7EwYAVaIc5W8ZG2qXlmPubZjcoM12L2mRIUtX19bToTXrwfLbMIOMOMv5
	cjR5ciozMzqpDqfR2g/VvOSJreKufRl7Y5OYn25S2lwRXFAFJNPKdnIhfU8CcMhLVoLNyYYLwEK
	diMyJDPLHnL+wAAF8L5XI+0AGj6rMXe7moXqmhZ9PS0mNmqTovTMUmALZdoi5Km6ILre3ve5mzc
	RZ3/bl9Ppzg==
X-Received: by 2002:a05:690c:6ac3:b0:71d:500b:d233 with SMTP id 00721157ae682-71e774ac6b0mr130377017b3.15.1755540401674;
        Mon, 18 Aug 2025 11:06:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZcm9I1hqrBEYRscTw5qICYVgLFE2dN4EwtkxH4owTrJSsthjzp+xz9xDEFbOj3GE+h1JnoQ==
X-Received: by 2002:a05:690c:6ac3:b0:71d:500b:d233 with SMTP id 00721157ae682-71e774ac6b0mr130376537b3.15.1755540401252;
        Mon, 18 Aug 2025 11:06:41 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6deb618dsm23430337b3.20.2025.08.18.11.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 11:06:40 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <db8defe4-14bf-4060-803f-e8b09a941d42@redhat.com>
Date: Mon, 18 Aug 2025 14:06:39 -0400
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
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Boqun Feng <boqun.feng@gmail.com>, Clark Williams <clrkwllms@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 John Ogness <john.ogness@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Will Deacon <will@kernel.org>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
 <20250815093858.930751-3-bigeasy@linutronix.de>
Content-Language: en-US
In-Reply-To: <20250815093858.930751-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 5:38 AM, Sebastian Andrzej Siewior wrote:
> local_lock_nested_bh() is used within networking where applicable.
> Document why it is used and how it behaves.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   Documentation/locking/locktypes.rst | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
> index 80c914f6eae7a..37b6a5670c2fa 100644
> --- a/Documentation/locking/locktypes.rst
> +++ b/Documentation/locking/locktypes.rst
> @@ -204,6 +204,27 @@ per-CPU data structures on a non PREEMPT_RT kernel.
>   local_lock is not suitable to protect against preemption or interrupts on a
>   PREEMPT_RT kernel due to the PREEMPT_RT specific spinlock_t semantics.
>   
> +CPU local scope and bottom-half
> +-------------------------------
> +
> +Per-CPU variables that are accessed only in softirq context should not rely on
> +the assumption that this context is implicitly protected due to being
> +non-preemptible. In a PREEMPT_RT kernel, softirq context is preemptible, and
> +synchronizing every bottom-half-disabled section via implicit context results
> +in an implicit per-CPU "big kernel lock."
> +
> +A local_lock_t together with local_lock_nested_bh() and
> +local_unlock_nested_bh() for locking operations help to identify the locking
> +scope.
> +
> +When lockdep is enabled, these functions verify that data structure access
> +occurs within softirq context.
> +Unlike local_lock(), local_unlock_nested_bh() does not disable preemption and
> +does not add overhead when used without lockdep.

Should it be local_lock_nested_bh()? It doesn't make sense to compare 
local_unlock_nested_bh() against local_lock(). In a PREEMPT_RT kernel, 
local_lock() disables migration but not preemption.

Cheers,
Longman

> +
> +On a PREEMPT_RT kernel, local_lock_t behaves as a real lock and
> +local_unlock_nested_bh() serializes access to the data structure, which allows
> +removal of serialization via local_bh_disable().
>   
>   raw_spinlock_t and spinlock_t
>   =============================


