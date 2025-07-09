Return-Path: <linux-kernel+bounces-724295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEBBAFF0E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15E83BF4FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA0323908B;
	Wed,  9 Jul 2025 18:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KY3Mz/Pu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A500B21C161
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085702; cv=none; b=ZpHKUX5iU6X7VFYvTkJOO3hau1ETw1PujxFvVzvmvrVEjxfS9BwqVID4WTJE0P/aPXm3dqZNm8a2lz6VLegUHDnTtDGo0y22dErJej6DCL0+u553CPPfp3tkm9X+ecdfJSzvSrkOY4Vh0LBPpwsIjkhHptYOHntTlDBvkmiWHN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085702; c=relaxed/simple;
	bh=dKX8gzXfarQgmmuuB0RsHMccpb+YBuMvQwS8B3FzqgU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=quaYUPRyfTNgB207g3A7ok2N05WkN5Sv8sAutoymexjJzYgk9ICMUkYOBmG32kDYK1Pfg1PwY4xZfjQFxQFSPVH2PNhrKAgV+aCJgWZDsTasHaoA7TuPhdtEifOzZD6tfKO6vltk7ZsyPrO8PmiwGPrn9P3YXUUMTEVfe5IIMo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KY3Mz/Pu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752085699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NTpQrtg95kpBADHc+5OI/w0ENxi/NiihyaZUfC7Yj2M=;
	b=KY3Mz/PuCvozOxMtG2dSUzGnu7XdbqxVlHlvs68eiVJNZNHDlM69hlbklK6u0fodHKucfF
	7DGlNadr5vyR9dj4aX9X/KQszPpLO4BG459Tms8q2dIjekh/rL+4lbmHNfxTP4IZDEwV0A
	eAgZLW1CIQ+QxPGKAJ49HPqvnSaLEKw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-UeCUH4bZPUqIzxX8EZzXRQ-1; Wed, 09 Jul 2025 14:28:16 -0400
X-MC-Unique: UeCUH4bZPUqIzxX8EZzXRQ-1
X-Mimecast-MFC-AGG-ID: UeCUH4bZPUqIzxX8EZzXRQ_1752085696
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fad9167e4cso4072106d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085696; x=1752690496;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTpQrtg95kpBADHc+5OI/w0ENxi/NiihyaZUfC7Yj2M=;
        b=PpwifW5GnAZK1TNwyv0xUNtWDTQa8Wcpo2sB3Hke8wd2C1Oh+55F065QWIW6HpUXH5
         AoxRqnxSAZrGq6TaxK6VlGTzS4GfUWjOQ1ZnpfLLw114DvskCql9Kq84rQNqDuDuAKv+
         Z21bKvHDBiX8kd+l/8KDA43dxf9J6Da1S0lScd0tQAvUwMCZpCKpADAWv0PY3jNKWJXf
         of/lHn/JTq1XYkX1ivCzN0niripgXrUR5YYhjJ507hdNIy43UnOOn3ETaWH1euaYtuvn
         q9drE3R/k4ZOTIg5PSJNN+gyP5tDIqS5wyllyvY/2TZ/xgjjCUOlFrnZ/kfMYa6dzjU6
         hGLg==
X-Forwarded-Encrypted: i=1; AJvYcCUnHTAh1YRhi45EzdHx9Je2o1MYeCvBOIww4B10VTXOxbrxtVhYcULICOMgXSYQMpo4JLb9vwuY0xMYj3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+IhFseWJIxbIebsGfhF3Czznw4i7+4wVimMVclYekxDmjhNGB
	APqakxKDKVZTilRKtcMgfA7dX75HKteKpu4f1F5ugvqKccssifE9GvPdRDyU5IHd8BfZykpxCfM
	Fm2Ynq48/3DeV6UD3tpulXXseXL7QpVjm1JCkUwzYrTAzKpXrfJ6Cdw6KrswzFD5qNA==
X-Gm-Gg: ASbGnctU8qky1ZV3h4lc3IdEuDR8Sv0v9IcnRp7HX0rapqF0KcN1jABVr10YFDRziNo
	TPwgYD7EC3456uzmBA9mWOhYpkH8kh+oTwq+Fj/oEHP4dTMemnvXQkKJY04gkmN3dWZPmbECI7v
	xJ9QDiZ+kOS9fKIZevPPGNt3mTJK7icKq5OX4auBOcWmfz6HL6/pNR0KLL8q/e0hFGxl1VMtZKD
	BC+PO97EnK/n+zjgBZ8MTHrbcnBo+wRAxs6dn0+lytjJbUFu/rzSF9QVwnnvmHtHws22D9h11Gi
	p6EN6auEWdPRjjDRMy0nyXZuXoOOkwxDm52JHMw/I1vMhA5CVB6wSPwcYOaiGh33GHt6
X-Received: by 2002:a05:6214:21c5:b0:6fd:ace:4cfb with SMTP id 6a1803df08f44-70494f80620mr16633516d6.27.1752085695731;
        Wed, 09 Jul 2025 11:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7p4Sb17fzr1Qre5xY2iSNC7fP97zjrUse3FOgYAisSiJi7Y0DOPfnFLh3yImLGHnpBKc6ww==
X-Received: by 2002:a05:6214:21c5:b0:6fd:ace:4cfb with SMTP id 6a1803df08f44-70494f80620mr16633166d6.27.1752085695365;
        Wed, 09 Jul 2025 11:28:15 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d50f7esm95924946d6.59.2025.07.09.11.28.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 11:28:14 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1f329aff-efd1-4996-9194-9e35030e9faa@redhat.com>
Date: Wed, 9 Jul 2025 14:28:13 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] locking/mutex: Disable preemption in
 __mutex_unlock_slowpath()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
 Jann Horn <jannh@google.com>
References: <20250709180550.147205-1-longman@redhat.com>
 <CAHk-=wimw8A1ReDPMyAVPrB3rEzenkk-u21RN123BGmnGBwjiQ@mail.gmail.com>
 <CAHk-=whVBKwK83R_7+52qzZb3DpFWGG8L=V5bDG6VS44e3=1-A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHk-=whVBKwK83R_7+52qzZb3DpFWGG8L=V5bDG6VS44e3=1-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/9/25 2:21 PM, Linus Torvalds wrote:
> On Wed, 9 Jul 2025 at 11:19, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> I absolutely detest the notion of "let's make locking be tied to
>> object lifetimes".
> Side note: I wonder if there's any way to detect this kind of race in general.
>
> And I suspect it would involve the exact *opposite* of your patch:
> make mutex_unlock() actively cause preemption after it has released
> the lock but before it has done the final accesses.

I think we can do a a cond_resched() under CONFIG_DEBUG_MUTEXES and 
CONFIG_KASAN. We certainly don't want to do that with a production kernel.

Cheers,
Longman


