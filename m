Return-Path: <linux-kernel+bounces-819325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8880EB59EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 19:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC1B582270
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B71371E96;
	Tue, 16 Sep 2025 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNU2i1yR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD8932D5D7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041941; cv=none; b=f7LwvIiY7AIy1FwNRXgd84hh2GYCqdPHNRyBVvjWHvoMUfLH3Ai6NgfnGYkNGZOJtT8zNjdcxuN4oa6BoUlcOLrnqgRpuH1KkrGMrR55b/t8/xhmKQK9g86oRnhixcxTf7JZ1uPF3FfdhpOhozrNVGm3yy4ay8Tol9wqrGHt0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041941; c=relaxed/simple;
	bh=1ESSDa9T5TZiLkRJ/FOm3n3uUjBAWGWKFOXKlYOnIc4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LUUK8qwDhj5JxIJ8fptAa4eWjIdJ2JovtN77Y5AzXbhvBi8mJNTzK1r94HO2yLySl3ZzxwjWbrRN3oykvJ1AcgdLEr2VkBIvcSOXrkZszLdl4f9F+1HOiiQoKAIsmAhkqS6QQQWafmDF2CoELmgJl0nwkXBD71Zs1I2NXONONXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNU2i1yR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758041939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/EZc4VD3I6Rvd/hwPueys9LNwaukhCSs8uHwuxzrAI=;
	b=eNU2i1yRmNSUlxF1calqB8PLVXOzm8AZkkPymFeMVGv+fZapDhPnm1QFbJlGY34Hm+wUmR
	2g8uy7UsaLKyBnyBIltvZapa5JRC6aNVLDlpG+Jr74T7AdnzkZ/MSz2HGu/rhc/ClR+cOH
	gAmCKB3D/z0Fm0NQmF4atVeeleEsLKI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-gpm-o4_HONuUpjUskPdwAA-1; Tue, 16 Sep 2025 12:58:57 -0400
X-MC-Unique: gpm-o4_HONuUpjUskPdwAA-1
X-Mimecast-MFC-AGG-ID: gpm-o4_HONuUpjUskPdwAA_1758041937
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-77766aadfd4so34200586d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758041937; x=1758646737;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/EZc4VD3I6Rvd/hwPueys9LNwaukhCSs8uHwuxzrAI=;
        b=DSuJVGGkLld3E1GSbPykkuop8qjTspblMOh9AwUEcGi4wICyBRthzVeBVhnv/D+NW4
         tNMlxqG+dsPA7PZI5l5nsJfbHBT6nJMrtpUCxVP3uE6UdJquU6jM7/LwOIIJIg8+2PBR
         PczSXGwrkFcRVKqZm8FdV4i+yjBbJpjus8yyRZnt/yiG7VujPR/Iw1WVucGzLNz3aRjR
         G3KFPNIMAmOSHOdkfjqb+E9jqOt3AsAnLRg9e9O/E8XkxanDtkLlUP4BPuDneD9mRP/q
         x46TngEH3GSYJzmnRQScRY7XnkTJEviLPAjvqn2hpmQquuTt6K9E265uGL6UXtWDiIQ3
         tHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl3YmXCgGbVQV7a2vNZcnO0qLAaSJ0dul2wnrHwXgWWlfTFcuc7VsEmtuOCWn78dkv98xE86F/bFJuvSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSm7p5+ybgKPkDzuqqdc6wmWfIAXXiB8W883QVlWuchYESyH+m
	8OKwK5ZIRoc2WbSqmfpMIwkFS/bT372yXmykqXCra9IrTbiKABrgxrUwn10auRQAkNoyCKOCvVR
	CD/EM/GuAJC2wkHrpxY7KJXaLjKQfvJkC/LpN/5UbN3unaDmVRklApZPp/Qd/Zc22Kw==
X-Gm-Gg: ASbGncuvUFaZ6B3xUDvsCm2Ost9VEOU8PN1gA+t5nERnHL3I0VX9Ff6mNVCeuN0ymcd
	HGlycsubPeIm9bGl26vu73VFLTO0pgIXlyR7RmwKU0r0dluXafl+qtVjP3TGoD2YjGG6fRrjc+7
	grLqwHSuZhg635vDNqTeODjVl4IAcyYCjy7hbtHIduyY5y876dpHOUUEUpyxRhu3HA52aGVISHa
	7kHEGhvxbCA5v4LzQqoyovhEeinYcGAZ+3ljRPOv+osb+mE2SH1YthzExqyK+9cgIvUgN/jLqEh
	641Ltj9okktDxdwMgqNEI7roXYnMp6jNG9tdyhcFJhOxFUmGnLNSodJy1ySSaCNZ0XMUAaempkO
	ImSgLC12qWQ==
X-Received: by 2002:a05:6214:e85:b0:758:2117:887a with SMTP id 6a1803df08f44-767c5622e1bmr202158836d6.58.1758041937113;
        Tue, 16 Sep 2025 09:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxei0FEEqUvZjdq9XLJMNLngrWTypPoizScTxs9as/2F2uiQ+je0ZPIhRgPrZ72mzjcrKQNw==
X-Received: by 2002:a05:6214:e85:b0:758:2117:887a with SMTP id 6a1803df08f44-767c5622e1bmr202158396d6.58.1758041936534;
        Tue, 16 Sep 2025 09:58:56 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7843978ab05sm37136006d6.30.2025.09.16.09.58.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 09:58:56 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f971b01a-2d76-4511-8880-0f4de2a042d9@redhat.com>
Date: Tue, 16 Sep 2025 12:58:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/qspinlock: use xchg with _mb in slowpath for
 arm64
To: Peter Zijlstra <peterz@infradead.org>, pengyu <pengyu@kylinos.cn>
Cc: mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com,
 linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 t.haas@tu-bs.de, parri.andrea@gmail.com, j.alglave@ucl.ac.uk,
 luc.maranget@inria.fr, paulmck@kernel.org, jonas.oberhauser@huaweicloud.com,
 r.maseli@tu-bs.de, lkmm@lists.linux.dev, stern@rowland.harvard.edu
References: <20250916033903.3374794-1-pengyu@kylinos.cn>
 <20250916141032.GJ3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20250916141032.GJ3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/25 10:10 AM, Peter Zijlstra wrote:
> On Tue, Sep 16, 2025 at 11:39:03AM +0800, pengyu wrote:
>> From: Yu Peng <pengyu@kylinos.cn>
>>
>> A hardlock detected on arm64: rq->lock was released, but a CPU
>> blocked at mcs_node->locked and timed out.
>>
>> We found xchg_tail and atomic_try_cmpxchg_relaxed used _relaxed
>> versions without memory barriers. Suspected insufficient coherence
>> guarantees on some arm64 microarchitectures, potentially leading to
>> the following issues occurred:
>>
>> CPU0:                                           CPU1:
>> // Set tail to CPU0
>> old = xchg_tail(lock, tail);
>>
>> //CPU0 read tail is itself
>> if ((val & _Q_TAIL_MASK) == tail)
>>                                                  // CPU1 exchanges the tail
>>                                                  old = xchg_tail(lock, tail)
>> //assuming CPU0 not see tail change
>> atomic_try_cmpxchg_relaxed(
>> 	  &lock->val, &val, _Q_LOCKED_VAL)
>> //released without notifying CPU1
>> goto release;
>>                                                  //hardlock detected
>>                                                  arch_mcs_spin_lock_contended(
>>                                                        &node->locked)
>>
>> Therefore, xchg_tail and atomic_try_cmpxchg using _mb to replace _relaxed.
> Yeah, no. We do not apply patches based on suspicion. And we most
> certainly do not sprinkle #ifdef ARM64 in generic code.
>
> There is this thread:
>
>    https://lkml.kernel.org/r/cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de

Ah, I was not cc'ed on this email thread. That is why I was not aware of 
this discussion about xchg_tail(). It is an interesting read.

Anyway, this particular problem may be about the clarity of the arm64 
memory model and whether any microarch's strictly follow it or not.

Cheers,
Longman


