Return-Path: <linux-kernel+bounces-799204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77E9B42867
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B589D7B36D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48F8352065;
	Wed,  3 Sep 2025 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7EYAZNQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4E29BD81
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922232; cv=none; b=P1v8FJpK/d+wbLeVlyC3thLaCJk7fqMQ5nGPAIt7FNuFe2l2G7ZOUDsGevphmI/ZMQ0wzuZwqR32hUZ7+R+OFiTpl3Xd5B18DZ8vvFQeeqeFbj2cmjibbuL0vr7SfSl1mLFbzoOsuMJvmGEqcOK+KMQ2QZZJjrGt6ohibF94DFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922232; c=relaxed/simple;
	bh=IcmvkO2Fpy8iWtZerAoBhAIqmHzHxZDl6OGdkccGEAw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SZFAGcWil4qaNoA4K/PPG3tKW2Q1IeoGq0pDvONUfqwExiw47eXTQS9ia1U7lax8yBWSErmCRh7xkeuwBJ6chDqLQAGnRMqOX8iOvrbEs2P3NGgW84j/vPgBvqu/T6oNwHr8RhbcSbgApjIPE2hgxsCoVR95nw8qgpt9bO26N9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d7EYAZNQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756922229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n5RnBvLiDZw7UN+IlblSrymF9ON+Vp1wy+fcOX1Lbps=;
	b=d7EYAZNQW7zuCItMWiB7EU0XF5DC4miGvhRxvZ00H1OiZi0SGp82ZSvDu43IXXxh9Egao+
	IcdLLsgQpvTiurRCJv6tI0PkTQnVow48I/lhFy/dOR3lNWA70u8S+WzucIrLkff6j+Gcjq
	78gtykJWi2h7KApB3E/ciajmwjO/f+Y=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-vuTghh1zNLmrIJWtgl3-ng-1; Wed, 03 Sep 2025 13:57:08 -0400
X-MC-Unique: vuTghh1zNLmrIJWtgl3-ng-1
X-Mimecast-MFC-AGG-ID: vuTghh1zNLmrIJWtgl3-ng_1756922227
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70faf8b375cso2088546d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756922227; x=1757527027;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5RnBvLiDZw7UN+IlblSrymF9ON+Vp1wy+fcOX1Lbps=;
        b=RGdihnJP2zlr6DlU++Bg7xkIdszA2JkqFTX7qp8Tqa76LapKkcanEDbxR5kfHr5R64
         GrLlPn0zVsoJ2nU/F0eHKvmU3zSiSTOXyQIg1RSZ8Df0Xv25c3pkjS4AUW+KEvhizi3u
         dnCV9fBUymPJgk8HdgYwxCzG17/And54oQ9ObD5WpYIKO7OpAdB/brqvD5CYWr36wwe3
         hBQALpkZxvSjG2YLw9qYRL5p2KrqWk2+Y9C/bvQI/y0JF5xzdhiXKlVtXQQ0PPWRIF0X
         5bZg96XcgZP7ibvxtaTAmEE9a16dyg54SiRofdqjMTuHbJPYTireP8AsxtB6PU1Jh7hT
         53kg==
X-Forwarded-Encrypted: i=1; AJvYcCVFWrA/+8kJIMJiTk+Da4b3lk8rufjVl9Tq5Yl96Z0WKXF9mDfXdraoTnT1735+sAYLBSXwF1ph1eund0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBoayKx+j5cQjpbVAbLMFUjv93Qn//fRPONMhDjqorNMhYPK0
	EO5mS24nHICCXOPmMOVmJfdmkS7QWgj4vTI8G+n1Osa8KaQOra5CJCtGtapwS2zwW8MpoMkevsu
	0Xb+r2WkGAprbfQh1f40Oh9VH5yxWjBxA4CeYoDPNUSSqittFapoC/1fXzHKqa5XsGQ==
X-Gm-Gg: ASbGncsP6LyxTsB6BRWmYrVY9AtEkyNZn9WxLIoXEMysjM63//Inmrm7IKRlVCZWmOw
	2FNRv48m45CegbGzj1yjHnTS4qepIEvolOZUYStodjr28zkGSkjgIf7cQUpMN9f9pqcrPyxxtSC
	ua16gOsllrWh8syEF8sX//L60nnWfNBMEAjI9oWgDIKyYMguP1Hd/gkeDDg6IzpQpk574vWOVis
	6KJLqa7jh8dlTyNyCGUPs6Nc7PWt3At6GYgKeCt3N/4VPa7/rMYYJ1xosavX0R59RjrDWBJ1JwY
	t9adplJe1SgJoxeMUdCJES2bP13g79NQDSbN0mVU6OpKTDzUEJfvZQwp7gIhGPSGfqCVChMv48l
	5rCKOQJhSdQ==
X-Received: by 2002:a05:6214:21c8:b0:725:16ca:a76a with SMTP id 6a1803df08f44-72516caace5mr38224486d6.3.1756922227596;
        Wed, 03 Sep 2025 10:57:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbKYHo8AzRs8wvpbKWXB+dwEP5GqvkulURSJby/zvhgQVxXnCKPrsk7paQVeQMpUGZI8dCNg==
X-Received: by 2002:a05:6214:21c8:b0:725:16ca:a76a with SMTP id 6a1803df08f44-72516caace5mr38224056d6.3.1756922227050;
        Wed, 03 Sep 2025 10:57:07 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b4947b1asm32261896d6.41.2025.09.03.10.57.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 10:57:06 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f00c7f8c-a596-4d96-8e45-43fc3fb4736a@redhat.com>
Date: Wed, 3 Sep 2025 13:57:05 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftest/futex: Reintroduce "Memory out of range"
 numa_mpol's subtest
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 kernel-dev@igalia.com
References: <20250901203327.53887-1-andrealmeid@igalia.com>
 <20250901203327.53887-2-andrealmeid@igalia.com>
Content-Language: en-US
In-Reply-To: <20250901203327.53887-2-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/1/25 4:33 PM, André Almeida wrote:
> Commit d8e2f919997 ("selftests/futex: Fix some futex_numa_mpol
> subtests") removed the "Memory out of range" subtest due to it being
> dependent on the memory layout of the test process having an invalid
> memory address just after the `*futex_ptr` allocated memory.
>
> Reintroduce this test and make it deterministic, by allocation two
> memory pages and marking the second one with PROT_NONE.
>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> This patch is aimed for 6.18
> ---
>   .../testing/selftests/futex/functional/futex_numa_mpol.c  | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> index c84441751235..e4b840184b1d 100644
> --- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> +++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> @@ -174,10 +174,13 @@ int main(int argc, char *argv[])
>   	ksft_set_plan(1);
>   
>   	mem_size = sysconf(_SC_PAGE_SIZE);
> -	futex_ptr = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
> +	futex_ptr = mmap(NULL, mem_size * 2, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>   	if (futex_ptr == MAP_FAILED)
>   		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
>   
> +	/* Create an invalid memory region for the "Memory out of range" test */
> +	mprotect(futex_ptr + mem_size, mem_size, PROT_NONE);
> +
>   	futex_numa = futex_ptr;
>   
>   	ksft_print_msg("Regular test\n");
> @@ -192,6 +195,9 @@ int main(int argc, char *argv[])
>   	ksft_print_msg("Mis-aligned futex\n");
>   	test_futex(futex_ptr + mem_size - 4, 22);
>   
> +	ksft_print_msg("Memory out of range\n");
> +	test_futex(futex_ptr + mem_size, 14);
> +
>   	futex_numa->numa = FUTEX_NO_NODE;
>   	mprotect(futex_ptr, mem_size, PROT_READ);
>   	ksft_print_msg("Memory, RO\n");
Reviewed-by: Waiman Long <longman@redhat.com>


