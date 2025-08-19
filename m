Return-Path: <linux-kernel+bounces-776432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9068EB2CD37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 21:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D4264E4B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D182D26E70E;
	Tue, 19 Aug 2025 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J3go00Ix"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963312AE84
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632795; cv=none; b=ueR6YpT9ebCYQ2tEYuOhyPzxlbqhM8frirKs9ELAE9OOPwMWQTQ8LpNKpn+B+pcBuprDwoFGEde1ZKutaghlSCkZidrrFH7TrPJ8Yx/5cmoYlKe1LSvT4ox0LtRSrOVKpj8XuJkSXV9zUeS8PfjX4fvsRP8JM2YvglDw7xpFuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632795; c=relaxed/simple;
	bh=Reh6woerY8Lv+48u12oUpzwM9/rHYkBlDCEVqO22IGI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gMx7L4cZy66dsd9gIl0jKFodFef3Hbev/ZFDVTQKzXTk96wmIic61oMKvsNEGWtvWHaXAUw9mj/ELD9zPO0zK+0zN3qOxDOgq0rGzhHypZUFhfoIRagouPrttIpJ3Ugb0iynBhCxuajnXMWYhBmNG3o2jsE7vnlc/uD9Q3D7j0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J3go00Ix; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755632792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRCPrFoaBBwpzmKxk6u0SdsGAQYGGoKwbnSPzMSJ69w=;
	b=J3go00IxilZCYNS59vSbecW8xlOkij7ANqfA2ddYIhy8GUGiQnVMR3E10lwa05MvTXqXBP
	WAEfM0IQQ4p6HnNgetBNhi48mfVlTqjfGCDUcw4eMFff3iEdjG5h2ERs9Yv7cBpiQxlthw
	AtQ9dxgoAsxcmCIcQf6VEHVvFLHsOOQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-CT14S7yaMHSMYqbrnSmZ8w-1; Tue, 19 Aug 2025 15:46:30 -0400
X-MC-Unique: CT14S7yaMHSMYqbrnSmZ8w-1
X-Mimecast-MFC-AGG-ID: CT14S7yaMHSMYqbrnSmZ8w_1755632786
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e934a723240so4392515276.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 12:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755632786; x=1756237586;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRCPrFoaBBwpzmKxk6u0SdsGAQYGGoKwbnSPzMSJ69w=;
        b=kG9577ZXNYKzpFX8wl7cmRN9iJfmIEXcuJF6u3lCbOFZL3rQt5jgGIeyZX9r00ckdd
         EYvYHn0XYqKBaORyf+kBnTj2i/6vq2eZB34K2T+MNxxFNhfEfyZ61YuG4Wxzkpen6cQN
         LH+C1akLUuJWFXjR+I8eX8ib9cepoRAvKLdc9NvZMSZtFwCM5CWPsRBFtuMqZpEsvPju
         RUj/QkCcpHWgN1ifgu5wVCeJ7F9Vd0jat94sWbkENO5BP/zFjqJ1+9GThvg9uJYSMT1I
         EDWZMQbn4+z7X+OsehmMnAu6LybuZT8Rw0q1MOM6gAgWjB9ZX0dz1Aycrxk1D5zZgDjM
         bkJg==
X-Gm-Message-State: AOJu0Yw4Wy1TH5ZOhUQog7JPoQZvKh42RwwXri9IOCEWMwoiHGh04sPk
	Yd+5AJHesHfHO1UafwmyClptfExJhBnzY1GURvwznomNHscTV+q7XNsduNN1uv9Zk9L/jYV7dEU
	myPg9MJ3Ah607U8Py348Czb4SWIbRCHXKynx98M7pm1p8VWrtq1zFDuc12qHHejAMiQ==
X-Gm-Gg: ASbGncsuVwuINPxWCL8O50BJguuijnd+nfkfh4iMpT+V627E/itrfKEJI0UAxXVT8SC
	keVPd738NaeijTK5KPc8FbdOYdzOaIH+9Otd2shwk0SrHOiID/ZTFOyBe/Frh4VF+7DFUCx6E1z
	de+Tt1rNaKi6sIDeq6sGlaKmcxFTUPV3x0/NkyRRiDDDyibY5ttYKQKpXWm1KQX0Y8cNUckQfAG
	Gm4MdtSNg1MmOz9H1NIjfbBWfI7wejG1F9cnOrXgqXt3xV04iTUnzGiQdzTp0+5gK9+gVQY195W
	01il+zjCMbYpCmaCvN1/VKiQAPGPNXq9nzm3SA39VECTlQypKAgtX+Fl0m1UHSRcqhJtWWlJn4u
	SNELwxD/8BQ==
X-Received: by 2002:a05:6902:1a45:b0:e94:e1e5:930a with SMTP id 3f1490d57ef6-e94f67885e1mr308988276.50.1755632786516;
        Tue, 19 Aug 2025 12:46:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/yApBWBUl4/+8VqJ2IuV7TcAO9fqPR9IL1lHy26m2I23JsUFfrLO85d8Yg/YAOv2348jagA==
X-Received: by 2002:a05:6902:1a45:b0:e94:e1e5:930a with SMTP id 3f1490d57ef6-e94f67885e1mr308948276.50.1755632786097;
        Tue, 19 Aug 2025 12:46:26 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94ee7b9ec3sm554363276.17.2025.08.19.12.46.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 12:46:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <191b64e0-c15d-48ec-a947-08f2afd76cb5@redhat.com>
Date: Tue, 19 Aug 2025 15:46:24 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Fix some futex_numa_mpol subtests
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kselftest@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>
References: <20250810222742.290485-1-longman@redhat.com>
 <336a1a43-54ac-4f53-b3a8-5e46f6d45359@igalia.com>
Content-Language: en-US
In-Reply-To: <336a1a43-54ac-4f53-b3a8-5e46f6d45359@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/25 8:22 AM, André Almeida wrote:
> Hi Waiman,
>
> Em 10/08/2025 19:27, Waiman Long escreveu:
>> The "Memory out of range" subtest of futex_numa_mpol assumes that memory
>> access outside of the mmap'ed area is invalid. That may not be the case
>> depending on the actual memory layout of the test application. When
>> that subtest was run on an x86-64 system with latest upstream kernel,
>> the test passed as an error was returned from futex_wake(). On another
>> powerpc system, the same subtest failed because futex_wake() returned 0.
>>
>>    Bail out! futex2_wake(64, 0x86) should fail, but didn't
>>
>> Looking further into the passed subtest on x86-64, it was found that an
>> -EINVAL was returned instead of -EFAULT. The -EINVAL error was returned
>> because the node value test with FLAGS_NUMA set failed with a node value
>> of 0x7f7f. IOW, the futex memory was accessible and futex_wake() failed
>> because the supposed node number wasn't valid. If that memory location
>> happens to have a very small value (e.g. 0), the test will pass and no
>> error will be returned.
>>
>> Since this subtest is non-deterministic, it is dropped unless we
>> explicitly set a guard page beyond the mmap region.
>>
>>
> I had proposed a refactor of the futex selftests[1] and I spotted the 
> same issue with the memory out of range test. My solution for this was 
> to create a "buffer zone" with PROT_NONE to ensure that I would have a 
> invalid memory access:
>
> /*
>  * test_harness_run() calls mmap(..., MAP_SHARED, ...), which can create
>  * a valid access memory region just bellow the mmap() issue here. Then,
>  * the test for "Memory out of range" will fail because it will succeed
>  * accessing the memory address after the range. To avoid this we create
>  * a "Buffer zone" with PROT_NONE between the two mmap's.
>  */
> buffer_zone = mmap(NULL, mem_size, PROT_NONE, MAP_PRIVATE | 
> MAP_ANONYMOUS, 0, 0);
>
> [1] 
> https://lore.kernel.org/lkml/20250704-tonyk-robust_test_cleanup-v1-13-c0ff4f24c4e1@igalia.com/
>
That should work too.

I am fine with either my patch or your getting merged as it should 
address the test failure that I had encountered.

Cheers,
Longman


