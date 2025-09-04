Return-Path: <linux-kernel+bounces-801335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CF6B443D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D981C8101E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4342F5306;
	Thu,  4 Sep 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjCGahSX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4FF179BD
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005282; cv=none; b=oQd1ft8I73iXvgluL4110CBc0CSl8kjbFgKbw45wavttT7Gw0/W1VePqKYF1iVWlrtJ7cTuGlyvigmD/HQ1Y17HyPLSggMlLqZ3op2M+UqAqBWl5Y6dZtiE/Y8IxkrKMGXsjfzXRcNLHivoNxXwlJxG015CygrbEut4yIwoMCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005282; c=relaxed/simple;
	bh=XsNVYcFkMwgvIWxi5eljqSnCfBPOXUsAzMK3JZ2r/Pc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=REynRvjkRfeYlMBo6PD4rkh3mhovT155LDrWJ8JHGxuiHJtbywqSbGG12lVAA7LS8NvkFofa8ch5ECK9hRRCgNy/ZDeeFRlza+SEIBjnZwqfWG9mYT5Fj7S3Ii16n58ZAs44spI6Xvil2r4KjT3fopPAuBVZwFVV+sui/comq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HjCGahSX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757005278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Niav0ATlEBKdCItFrUg8rsQz8TWll74zvUAX+a0WdaU=;
	b=HjCGahSXzYwCyrX7gkZvT85x+ArlwviCMHPG1+xcdab7BoFRnjt66W36p2614E9nv3ge2b
	hU33rP90NW4FSoInCTHOCQBvN1RXJ9U6l54b7GNQ8Y+H/q4t2OyU8rvuj1oL6Qkc1qKj4C
	fLUUPTT0tuyGP1jEQV53Y5OzmY0txoU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-WQs1NXtjPyGClaMc025qAw-1; Thu, 04 Sep 2025 13:01:15 -0400
X-MC-Unique: WQs1NXtjPyGClaMc025qAw-1
X-Mimecast-MFC-AGG-ID: WQs1NXtjPyGClaMc025qAw_1757005275
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b30cb3c705so31116331cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757005275; x=1757610075;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Niav0ATlEBKdCItFrUg8rsQz8TWll74zvUAX+a0WdaU=;
        b=ZwwZMrxSGPbzicTCZmBGDBqKqSyzcQEo7zN8HZKXOkWL79zE1EK/trOltEk23JpBAB
         k2JQqEgY0AnFlncuv36z7dFZNnJP40bhag/K2YqJtm+fZbfnErcZRf3yQZ5nbCzrEzW/
         TGRbMNw3Gxl6VwiDt6nO+qKbNRjbr91E9Db+my0ew9DveljqYYRM/yKrfHqEuBAKo6IZ
         kOmMrrpYQ/mMmwi3tiBLbLrV+8w3GiCJkiwbXt7SfprjYqQrIRl/hlwZ4GPRzKNvOpi6
         AVc/gnjuAF9L6nbfcH/AdZO1seV4/v9MprwxoHUnJWv6iZPsJgsgUzqWHDZ9uqNqrVJr
         116g==
X-Forwarded-Encrypted: i=1; AJvYcCW3J07NqfVfVsCDu58neBDc0lY1YvwI965OF8K/uZ1QPNVxfFogxY5d4uUnhLm79otghyUCsnBvmhbH5KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnFZckEgtFfMVCKDKt3ZEmNi1qynyajq6Z1xMLAyWm9TVMc7QY
	v7CfppGbF+9r2scaTUN3IZJ/4aWbCwB8OGtdCnbE6kAqQUOcsOHUZ/gxjjfmtX/q8/p+KywElpu
	l2cFdLOWc0Sray4V0+3eY+lYpZKGuyd0gh2vhrsseJxbpm6L1MIx1HPEwRINl2vTByQ==
X-Gm-Gg: ASbGnctfJ6FitsoM6+9VnjZHjwizMChSQ/20y4GhNuxezdd9kbifHBjXzL9Fqrpep8C
	I1Qaqp9CNt9GUlKYH7Iv3NkBOYgQe1inkIJG7JuVc+sM2AU3QlUISt7Zmo9TEBxWU/0nl7semJ9
	tXWy7dvP4r6xTKM4qUo59IjcLHCfYJoSfvljmi3OijEVdSvXF0rDCQKOlZ091WAI0TsYjuDzPmN
	TkLJmZCRnZP0cDnjraj0Yxqzg10wxVZ95Dsgl9DqaEp1j90WLzZwRyUNaHTmuSKWy5/u7dD3q93
	ynW7t9N3hpMmQmVrvcm+Gm7M/TVUfZAy7+zNORIyrbiVsG9ObnpMn6xAdakd5Nr3s2UbuH3db3W
	Oc/sAusqbrw==
X-Received: by 2002:ac8:5d0e:0:b0:4b2:fcf4:44c9 with SMTP id d75a77b69052e-4b31da5650amr214726511cf.60.1757005274337;
        Thu, 04 Sep 2025 10:01:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFaesmaq6KAwyGOPb5DBWKEIJyIi9iUdnGmI+ZPoRW+SfTro75Z667S+NxlSH9nfaJLOme7A==
X-Received: by 2002:ac8:5d0e:0:b0:4b2:fcf4:44c9 with SMTP id d75a77b69052e-4b31da5650amr214725361cf.60.1757005273322;
        Thu, 04 Sep 2025 10:01:13 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f7ac508sm30238881cf.48.2025.09.04.10.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 10:01:12 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <69dc7ed3-9ac9-4519-a4d5-c31e62696235@redhat.com>
Date: Thu, 4 Sep 2025 13:01:10 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] selftest/futex: Make the error check more precise
 for futex_numa_mpol
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 kernel-dev@igalia.com
References: <20250904165556.56926-1-andrealmeid@igalia.com>
Content-Language: en-US
In-Reply-To: <20250904165556.56926-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/25 12:55 PM, André Almeida wrote:
> Instead of just checking if the syscall failed as expected, check as
> well what is the error code returned, to check if it's match the
> expectation and it's failing in the correct error path inside the
> kernel.
>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> Changes from v1:
> - Use error code mnemonics instead of numberic values
> ---
>   .../futex/functional/futex_numa_mpol.c        | 36 +++++++++++--------
>   1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> index 802c15c82190..dd7b05e8cda4 100644
> --- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> +++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> @@ -77,7 +77,7 @@ static void join_max_threads(void)
>   	}
>   }
>   
> -static void __test_futex(void *futex_ptr, int must_fail, unsigned int futex_flags)
> +static void __test_futex(void *futex_ptr, int err_value, unsigned int futex_flags)
>   {
>   	int to_wake, ret, i, need_exit = 0;
>   
> @@ -88,11 +88,17 @@ static void __test_futex(void *futex_ptr, int must_fail, unsigned int futex_flag
>   
>   	do {
>   		ret = futex2_wake(futex_ptr, to_wake, futex_flags);
> -		if (must_fail) {
> -			if (ret < 0)
> -				break;
> -			ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, but didn't\n",
> -					   to_wake, futex_flags);
> +
> +		if (err_value) {
> +			if (ret >= 0)
> +				ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, but didn't\n",
> +						   to_wake, futex_flags);
> +
> +			if (errno != err_value)
> +				ksft_exit_fail_msg("futex2_wake(%d, 0x%x) expected error was %d, but returned %d (%s)\n",
> +						   to_wake, futex_flags, err_value, errno, strerror(errno));
> +
> +			break;
>   		}
>   		if (ret < 0) {
>   			ksft_exit_fail_msg("Failed futex2_wake(%d, 0x%x): %m\n",
> @@ -106,12 +112,12 @@ static void __test_futex(void *futex_ptr, int must_fail, unsigned int futex_flag
>   	join_max_threads();
>   
>   	for (i = 0; i < MAX_THREADS; i++) {
> -		if (must_fail && thread_args[i].result != -1) {
> +		if (err_value && thread_args[i].result != -1) {
>   			ksft_print_msg("Thread %d should fail but succeeded (%d)\n",
>   				       i, thread_args[i].result);
>   			need_exit = 1;
>   		}
> -		if (!must_fail && thread_args[i].result != 0) {
> +		if (!err_value && thread_args[i].result != 0) {
>   			ksft_print_msg("Thread %d failed (%d)\n", i, thread_args[i].result);
>   			need_exit = 1;
>   		}
> @@ -120,14 +126,14 @@ static void __test_futex(void *futex_ptr, int must_fail, unsigned int futex_flag
>   		ksft_exit_fail_msg("Aborting due to earlier errors.\n");
>   }
>   
> -static void test_futex(void *futex_ptr, int must_fail)
> +static void test_futex(void *futex_ptr, int err_value)
>   {
> -	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
> +	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
>   }
>   
> -static void test_futex_mpol(void *futex_ptr, int must_fail)
> +static void test_futex_mpol(void *futex_ptr, int err_value)
>   {
> -	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
> +	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
>   }
>   
>   static void usage(char *prog)
> @@ -184,16 +190,16 @@ int main(int argc, char *argv[])
>   
>   	/* FUTEX2_NUMA futex must be 8-byte aligned */
>   	ksft_print_msg("Mis-aligned futex\n");
> -	test_futex(futex_ptr + mem_size - 4, 1);
> +	test_futex(futex_ptr + mem_size - 4, EINVAL);
>   
>   	futex_numa->numa = FUTEX_NO_NODE;
>   	mprotect(futex_ptr, mem_size, PROT_READ);
>   	ksft_print_msg("Memory, RO\n");
> -	test_futex(futex_ptr, 1);
> +	test_futex(futex_ptr, EFAULT);
>   
>   	mprotect(futex_ptr, mem_size, PROT_NONE);
>   	ksft_print_msg("Memory, no access\n");
> -	test_futex(futex_ptr, 1);
> +	test_futex(futex_ptr, EFAULT);
>   
>   	mprotect(futex_ptr, mem_size, PROT_READ | PROT_WRITE);
>   	ksft_print_msg("Memory back to RW\n");
Reviewed-by: Waiman Long <longman@redhat.com>


