Return-Path: <linux-kernel+bounces-721679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D725AFCC63
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF555167CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C75C2DEA75;
	Tue,  8 Jul 2025 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtfMb9yi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DB22DA15
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982338; cv=none; b=js732fptJl9AssZJiYtfm1fGUyC9EgNHC5YeLZPRY21uEZ2jYoGJf6W+LGespkCNxXMPuCQfy2sz19bGAmkMoHLJesJzzVAbk2RdUW9yqbjxGPwO5rZoEBcL3uSwUQe1+8jnfgRt1NX53YhEBESOJYXkyB7VjGK+yubeBdclMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982338; c=relaxed/simple;
	bh=X5fpNU/Ox9vxzbF+/rA/645fTB3BTnOoS91KgiqpMGY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=s7X8IMQqpC8d9TbgSRmSxcuqYT6N+RPT3mD/iSTKAYNj/LNh6OW3Cairkc33t5PrfkepKygQsSX5TAoWUW5fky6wsgiKFY4w7/nTzr5DWoCJdzrql7YFKnl/UDx8A/tODFCpbk5HfUwlbOdlPQPGlxPLmqwjoSrCecs0U4se+D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CtfMb9yi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751982336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ywes+eKwmYdfnaaqPKO+KMtbf6zMeQrUUYpmrlcbi0k=;
	b=CtfMb9yii/tC7eGt3HlJby2i0sgQeFAVYX1iLqXxT9TB68yQr/qS5/WAoLeJmzAXAs9VgP
	6Uav3YdTbVdKHLQaNDnK7/NR7yGOj2xJwD/pq98V0HhelNtdvlv5QV8wW9xyMhPzosaDxt
	Tqzd8LgPcILAXXg5AZ8L86h/Bt/AY6U=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-UL_yDtN7O2Cf-vfIwznRFQ-1; Tue, 08 Jul 2025 09:43:48 -0400
X-MC-Unique: UL_yDtN7O2Cf-vfIwznRFQ-1
X-Mimecast-MFC-AGG-ID: UL_yDtN7O2Cf-vfIwznRFQ_1751982228
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-611a646d93eso3618534eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982228; x=1752587028;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ywes+eKwmYdfnaaqPKO+KMtbf6zMeQrUUYpmrlcbi0k=;
        b=O+yEGR+DYi9d6wNUL+5zHND5KV+xlh7oyYT6d+4Hj5a0whJ1A/bKCAbOuv9SgsrYkZ
         GEFOkX/EvV96WfOpDp/L3fGR6a/CQ4pFkudKackJ//aQJq+lkD1OlTVZ1L5BvgZgexYZ
         MMQ5Vp8HAO+hKdSkHdG7+q3QDG+QHbzNvoXuNDNpNKKfAXAxqyhiAq73BFFtldOUcOLR
         XkHauh22x5ScfuP8/MM/rySrz2KDCsiuh1fvEHRSDExJvNo3E8GBIYjk+XBcioxug6Dh
         gbpJ3rBAwbFxjmg/IRlVSttDuwlxP9zYYvRLrihCf1g+NxaPCRNmg6e1soQ68W4aF7X4
         MtMw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0YDeuv1wPeOZlJVwPxV8TFvWunyOvZKxdIdYPvvORwzqn+cxLKA6ikylbj5tTAIpFLcrutW/A4FOQeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwT75xFUvQfLKN8Myk5MSpft8R5nQWZfa1c4w6WUayYxyxTfrW
	a/AFD+j/ua6mlkS4FIYy6kDCLcHaIaMw+I2Rf65tvpu1Xc2Zc2SNDDyvYe0Syus2HDWxAYOCv6D
	2Mdy9J0Qd8QLGsS3MO0kCtDDrjg9kDInTUY01DoM5p4tZhJPNhCxFPnPX+TvFI/KNig==
X-Gm-Gg: ASbGncvZKuEHmgLTQhDs6gD25r2qDr2gWYo8vsksRbFMxK5aKJ3dfR5stwMiYuSVV2n
	kWXNIjn6jvjIYxylJpRSE/x5Rrl51agpzqgI/XhJ08yG9NEhPw1+O7aCaTNKMuF0lcUgnwGhgJV
	6StOKJ6ujRtJJdyTOvVaE4pU3DzrjD0i8FkOmGjMBAW2PckVnzmqUIINk+lFUlQVzGkIT5Qikl6
	3wmbVlkQTwNsH/i/kxIZ9GtxL7Wt7mAcBAeddIkbHbPtcPs4s7rQVF7cziJWA2TOHC9rv8Xtt5M
	lkyUntLV8uS1vX7g8dF6CQ8kC16cFuboc5qqcn/11D4LU9TeQ/SkFJ/R8ko6pV4Pq62I
X-Received: by 2002:a05:6871:149:b0:2ea:6ec5:f182 with SMTP id 586e51a60fabf-2f79209ddbfmr12155665fac.38.1751982227830;
        Tue, 08 Jul 2025 06:43:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+4leZ83beYzoORW5rMI4CQJVhLvPxrBYE+knQbmHg8bfTHBfXuzO16QOh8RYr1ltpMh4/9A==
X-Received: by 2002:a05:6871:149:b0:2ea:6ec5:f182 with SMTP id 586e51a60fabf-2f79209ddbfmr12155648fac.38.1751982227492;
        Tue, 08 Jul 2025 06:43:47 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2f78ff47158sm2847127fac.13.2025.07.08.06.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 06:43:46 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2f0fc991-0e70-4bb3-bdcc-f87293cb6471@redhat.com>
Date: Tue, 8 Jul 2025 09:43:44 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] futex: Use RCU-based per-CPU reference counting
 instead of rcuref_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>
References: <20250707143623.70325-1-bigeasy@linutronix.de>
 <20250707143623.70325-3-bigeasy@linutronix.de>
Content-Language: en-US
In-Reply-To: <20250707143623.70325-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/7/25 10:36 AM, Sebastian Andrzej Siewior wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
> The use of rcuref_t for reference counting introduces a performance bottleneck
> when accessed concurrently by multiple threads during futex operations.
>
> Replace rcuref_t with special crafted per-CPU reference counters. The
> lifetime logic remains the same.
>
> The newly allocate private hash starts in FR_PERCPU state. In this state, each
> futex operation that requires the private hash uses a per-CPU counter (an
> unsigned int) for incrementing or decrementing the reference count.
>
> When the private hash is about to be replaced, the per-CPU counters are
> migrated to a atomic_t counter mm_struct::futex_atomic.
> The migration process:
> - Waiting for one RCU grace period to ensure all users observe the
>    current private hash. This can be skipped if a grace period elapsed
>    since the private hash was assigned.
>
> - futex_private_hash::state is set to FR_ATOMIC, forcing all users to
>    use mm_struct::futex_atomic for reference counting.
>
> - After a RCU grace period, all users are guaranteed to be using the
>    atomic counter. The per-CPU counters can now be summed up and added to
>    the atomic_t counter. If the resulting count is zero, the hash can be
>    safely replaced. Otherwise, active users still hold a valid reference.
>
> - Once the atomic reference count drops to zero, the next futex
>    operation will switch to the new private hash.
>
> call_rcu_hurry() is used to speed up transition which otherwise might be
> delay with RCU_LAZY. There is nothing wrong with using call_rcu(). The
> side effects would be that on auto scaling the new hash is used later
> and the SET_SLOTS prctl() will block longer.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This looks somewhat like what the percpu refcount does (see 
lib/percpu-refcount.c). Could this be used instead of reinventing the 
wheel again?

Cheers,
Longman


