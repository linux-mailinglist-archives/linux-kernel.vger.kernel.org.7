Return-Path: <linux-kernel+bounces-799200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C791B42860
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4EB57AEC74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C28334712;
	Wed,  3 Sep 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6qZFRfJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A632ED5F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756922028; cv=none; b=Wl3NwvEkC/ouxcn7/8L8PMicA+CfrDAKYRu4e6TCWhz6grHHVQJDkqrSNTA2AWemo6dx4dlly+VIimfQKft3V4xRwCnt2HXDNs2Zr727pyg7z2KSe4fheX9aHKiAnmCVYXhh6skQimm8sthkFF/XZoFrGXsxynUu940U+zUFZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756922028; c=relaxed/simple;
	bh=/83N8HR+6B6EwoYonXhaV0zEGFElkCq/JcHdHoQsWoE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=goZzwdtiJ8zCVYQnKaP2z8TJOcNGCnftLhgeeVOyz2dpCEw9T+mj0v77xVKUh7odIHgcBWOLkqOEJZwz6LKaz7E+peVrZXVpxVEq3W5gesP65VA35c8pDerT/5eDKNRREj6dsX0QAx6coeAOQhLkBx4RqXkArCvGPTWCTGXV43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d6qZFRfJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756922025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHf6w6BeNVd76PuF6Lt1MMsd3gwo6PG3EjXNqrkFd7M=;
	b=d6qZFRfJUPC0kSbwgRwFWHacmGLX9ohxrC2XUQs/NOuooQtO1N+I5kLgva8cnuSwcyDKTy
	BAc4UzfyXMDj2BsYy2iUCODERap9PbVzyksN30OvHwkaywt9+5Gd/0e22qntTs3jaivpkH
	Y7ZYpAi+uYGONEYvt7184C9L1M1SUt8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-PRrWIhIRO0yb_tD-kD5EuQ-1; Wed, 03 Sep 2025 13:53:44 -0400
X-MC-Unique: PRrWIhIRO0yb_tD-kD5EuQ-1
X-Mimecast-MFC-AGG-ID: PRrWIhIRO0yb_tD-kD5EuQ_1756922024
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70faf8b375cso2027956d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756922024; x=1757526824;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHf6w6BeNVd76PuF6Lt1MMsd3gwo6PG3EjXNqrkFd7M=;
        b=M5EYIp8Y17qKF3oY5dVZGiCxQkEmh3Uhq2Y+BMmorYThlI8R16Z/WTrJ+r1xbomss1
         inmSFMzoRgjAyQk9HVqM2EK8n41iGxqoa7s8m8DYZ90pHLnkmkC/XohlTeyQTDeNXD0m
         KqNzjSJ4usr9WT8yYzpIT5+ODGpza0zYVB0Ni1bWNSwme3cEpleYAEpuKaIur3A8zoDA
         D4Ebv+4mEvE1DahfLac83N35il+rnWIvflo18tpBPxFRqO2uSn4sCXJn3Alw0DozUI3Z
         YNz3ye9Hj/2OVGA8Ysx2oTyLFirbOM4IkATiMwiobpLMmE5T00BHztWEn180OYoCKdMv
         CvAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs0FqmaFWGd75+K4Aa7o6qNx9LdRHqkgZpn+R4/LQAHEHLqEm1u/8mo9kJpJwWfC07iT+DE9Sn9VVxNQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6bDKUpHbJEeh/CeRLANR20wrF+wCmB3vmxH+pfz/aEyK1mnh
	TcNf55s5NoHVQbMLpNjyMxqW7uazVkVqmDvc9IsitjySiI5XX+BT4YLqfthPUcdwT9ukC89+SFz
	ilEgoBEiYbkh2gcp/Ww1jKAjuLIpIGp5rvznscsmDKOxYkLdFboz/1ZijLCtwr0omoA==
X-Gm-Gg: ASbGncumoAd6OLYu4W7O4UA4IGOSIyf1KFaebWyK1NkVk/ey1ieLaOP3FHiA2HVfKLU
	ZQdiC+NzS7ZcVJpBVYPzO5sQvFN+PRvYiBZMBrjaBJNzWF2o53GZqS0IXPsloyDYbBoeo/6fbob
	TdeQlR1UGOLLCpiMbq9cd6cP6Z863RDFvddYMOfTcJmeMNmHWTcxD6Nc7cAy8Hoi0HmYtnLPbyD
	3WCdiBVTB9+mk79n747SIyhU7w1Pd/RQIs/mBLHIp87a9Kp576DsMCo8tPyL8RUCl54rCDtHN9p
	FAwLSkNr/gD/5D9LcRuukEziIXDAHU1DZ5gpkQH9rb87vmFsTlZqERDkH/NzMXZUXO4EcWIDQ+U
	DmysSnKkdAQ==
X-Received: by 2002:a05:6214:21c8:b0:725:16ca:a76a with SMTP id 6a1803df08f44-72516caace5mr38093216d6.3.1756922023968;
        Wed, 03 Sep 2025 10:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWlYTmYR/Ozknp6DAO3Jcq4MmA66Pmd5HK7J8ip6ku8lde6KBTR2pBXQNxOmRjAOZpDmLpyQ==
X-Received: by 2002:a05:6214:21c8:b0:725:16ca:a76a with SMTP id 6a1803df08f44-72516caace5mr38092866d6.3.1756922023437;
        Wed, 03 Sep 2025 10:53:43 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ad5b0386sm32184246d6.25.2025.09.03.10.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 10:53:42 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1d6a0c1e-5fa2-4c21-b3c1-7bfb2f9dd669@redhat.com>
Date: Wed, 3 Sep 2025 13:53:41 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftest/futex: Make the error check more precise for
 futex_numa_mpol
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 kernel-dev@igalia.com
References: <20250901203327.53887-1-andrealmeid@igalia.com>
Content-Language: en-US
In-Reply-To: <20250901203327.53887-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/1/25 4:33 PM, André Almeida wrote:
> Instead of just checking if the syscall failed as expected, check as
> well what is the error code returned, to check if it's match the
> expectation and it's failing in the correct error path inside the
> kernel.
>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
> This patch is aimed for 6.18
> ---
>   .../futex/functional/futex_numa_mpol.c        | 36 +++++++++++--------
>   1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
> index 802c15c82190..c84441751235 100644
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

If (ret >= 0), the 2nd (errno != err_value) failure message will likely 
be printed too. Should we use "else if" so that only one error message 
will be printed?


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
> +	test_futex(futex_ptr + mem_size - 4, 22);
>   
>   	futex_numa->numa = FUTEX_NO_NODE;
>   	mprotect(futex_ptr, mem_size, PROT_READ);
>   	ksft_print_msg("Memory, RO\n");
> -	test_futex(futex_ptr, 1);
> +	test_futex(futex_ptr, 14);
>   
>   	mprotect(futex_ptr, mem_size, PROT_NONE);
>   	ksft_print_msg("Memory, no access\n");
> -	test_futex(futex_ptr, 1);
> +	test_futex(futex_ptr, 14);
>   
>   	mprotect(futex_ptr, mem_size, PROT_READ | PROT_WRITE);
>   	ksft_print_msg("Memory back to RW\n");

I believe it is better to use the error number mnemonic (EINVAL & 
EFAULT) instead of 22 and 14 as argument to make the code easier to read.

Cheers,
Longman


