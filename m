Return-Path: <linux-kernel+bounces-801149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6D8B44072
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436851C8623C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06911239086;
	Thu,  4 Sep 2025 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YD37XtqA"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C994F23DE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999446; cv=none; b=n9GrlrplNQerT5ZF7yn3/S/lsHmQI1Zedo7vwe32BnFzVNEdvAGQcyxlmxpE1LzeFNEMMimS6kp64Dgl8nir4RnXCYURWnCHM4cizdHSzRxqmF4NeIHDN8jtnlErezqvRG1w8YZz6adnCPAvN9yqA/4xJkI7iSBnn4jhJVmp7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999446; c=relaxed/simple;
	bh=ecSzBaZ8jvTqDYnQRxMAK2mLhfK+H1RCJrQAxiugV4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OGRkfKympbiXBqSEEGBpwGfUXREwOlf/BGb8j7bsPlOAbUT6Cg9W5YiqYg3mrbnrUbsvSdvMojFbQ3sbkxNvjJnA/3HZ9SY7/VvbdeM+kNGF8nnBxtS6vOCWavLVJIj929QNUheaBrHU2Pt5OEbfEQpkCJrTQOyFteESDLemYFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YD37XtqA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mU4yHl8LpU7prXYd/c2AQg7fxbTD3YKb5v5qmT7KSDY=; b=YD37XtqA0Fx/dEHeMxa3sxZcFB
	HaDK0VllVXFPf1mwFgcTl6HACXlp0ZH3E3aUwl7wiBmcQP6mjoexCr40FiPN68sy89576VxBARcjN
	fvcFQLmsOV4UyV9F5jhwFJlDDkgEysPDNBTgx952q4KMK+SN2nAb3wEd0vaoCY4n6sig/c53OCjo5
	2mKLvuGp7fpV9SAtMk/KPXYso+igXPQP3a44GkknEzQdR19Bxenbr7ylGctEWSoooYQDKjbh/jEj1
	LR3+k3XebGr8d7kM9Z8fNgQbCDK47Ep0Fxf67yXkz6DEYTrDhPbm2ctVN6oaVODeibEVnL1DR7RCq
	2G5szxlA==;
Received: from [177.139.20.31] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uuBod-006rKV-Bl; Thu, 04 Sep 2025 17:23:59 +0200
Message-ID: <fd720337-ebc8-4039-b9bf-062be642f5d3@igalia.com>
Date: Thu, 4 Sep 2025 12:23:53 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftest/futex: Make the error check more precise for
 futex_numa_mpol
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 kernel-dev@igalia.com
References: <20250901203327.53887-1-andrealmeid@igalia.com>
 <1d6a0c1e-5fa2-4c21-b3c1-7bfb2f9dd669@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <1d6a0c1e-5fa2-4c21-b3c1-7bfb2f9dd669@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Waiman,

Thanks for the feedback!

Em 03/09/2025 14:53, Waiman Long escreveu:
> On 9/1/25 4:33 PM, André Almeida wrote:
>> Instead of just checking if the syscall failed as expected, check as
>> well what is the error code returned, to check if it's match the
>> expectation and it's failing in the correct error path inside the
>> kernel.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> This patch is aimed for 6.18
>> ---
>>   .../futex/functional/futex_numa_mpol.c        | 36 +++++++++++--------
>>   1 file changed, 21 insertions(+), 15 deletions(-)
>>
>> diff --git a/tools/testing/selftests/futex/functional/ 
>> futex_numa_mpol.c b/tools/testing/selftests/futex/functional/ 
>> futex_numa_mpol.c
>> index 802c15c82190..c84441751235 100644
>> --- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
>> +++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
>> @@ -77,7 +77,7 @@ static void join_max_threads(void)
>>       }
>>   }
>> -static void __test_futex(void *futex_ptr, int must_fail, unsigned int 
>> futex_flags)
>> +static void __test_futex(void *futex_ptr, int err_value, unsigned int 
>> futex_flags)
>>   {
>>       int to_wake, ret, i, need_exit = 0;
>> @@ -88,11 +88,17 @@ static void __test_futex(void *futex_ptr, int 
>> must_fail, unsigned int futex_flag
>>       do {
>>           ret = futex2_wake(futex_ptr, to_wake, futex_flags);
>> -        if (must_fail) {
>> -            if (ret < 0)
>> -                break;
>> -            ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, 
>> but didn't\n",
>> -                       to_wake, futex_flags);
>> +
>> +        if (err_value) {
>> +            if (ret >= 0)
>> +                ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should 
>> fail, but didn't\n",
>> +                           to_wake, futex_flags);
>> +
>> +            if (errno != err_value)
>> +                ksft_exit_fail_msg("futex2_wake(%d, 0x%x) expected 
>> error was %d, but returned %d (%s)\n",
>> +                           to_wake, futex_flags, err_value, errno, 
>> strerror(errno));
>> +
>> +            break;
> 
> If (ret >= 0), the 2nd (errno != err_value) failure message will likely 
> be printed too. Should we use "else if" so that only one error message 
> will be printed?
> 
> 

ksft_exit_fail_msg() calls exit(), so the code will exit before 
executing the second failure message.

If this was a  ksft_test_result_error() call, then the message would be 
printed twice.

>>           }
>>           if (ret < 0) {
>>               ksft_exit_fail_msg("Failed futex2_wake(%d, 0x%x): %m\n",
>> @@ -106,12 +112,12 @@ static void __test_futex(void *futex_ptr, int 
>> must_fail, unsigned int futex_flag
>>       join_max_threads();
>>       for (i = 0; i < MAX_THREADS; i++) {
>> -        if (must_fail && thread_args[i].result != -1) {
>> +        if (err_value && thread_args[i].result != -1) {
>>               ksft_print_msg("Thread %d should fail but succeeded 
>> (%d)\n",
>>                          i, thread_args[i].result);
>>               need_exit = 1;
>>           }
>> -        if (!must_fail && thread_args[i].result != 0) {
>> +        if (!err_value && thread_args[i].result != 0) {
>>               ksft_print_msg("Thread %d failed (%d)\n", i, 
>> thread_args[i].result);
>>               need_exit = 1;
>>           }
>> @@ -120,14 +126,14 @@ static void __test_futex(void *futex_ptr, int 
>> must_fail, unsigned int futex_flag
>>           ksft_exit_fail_msg("Aborting due to earlier errors.\n");
>>   }
>> -static void test_futex(void *futex_ptr, int must_fail)
>> +static void test_futex(void *futex_ptr, int err_value)
>>   {
>> -    __test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | 
>> FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
>> +    __test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | 
>> FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
>>   }
>> -static void test_futex_mpol(void *futex_ptr, int must_fail)
>> +static void test_futex_mpol(void *futex_ptr, int err_value)
>>   {
>> -    __test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | 
>> FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
>> +    __test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | 
>> FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
>>   }
>>   static void usage(char *prog)
>> @@ -184,16 +190,16 @@ int main(int argc, char *argv[])
>>       /* FUTEX2_NUMA futex must be 8-byte aligned */
>>       ksft_print_msg("Mis-aligned futex\n");
>> -    test_futex(futex_ptr + mem_size - 4, 1);
>> +    test_futex(futex_ptr + mem_size - 4, 22);
>>       futex_numa->numa = FUTEX_NO_NODE;
>>       mprotect(futex_ptr, mem_size, PROT_READ);
>>       ksft_print_msg("Memory, RO\n");
>> -    test_futex(futex_ptr, 1);
>> +    test_futex(futex_ptr, 14);
>>       mprotect(futex_ptr, mem_size, PROT_NONE);
>>       ksft_print_msg("Memory, no access\n");
>> -    test_futex(futex_ptr, 1);
>> +    test_futex(futex_ptr, 14);
>>       mprotect(futex_ptr, mem_size, PROT_READ | PROT_WRITE);
>>       ksft_print_msg("Memory back to RW\n");
> 
> I believe it is better to use the error number mnemonic (EINVAL & 
> EFAULT) instead of 22 and 14 as argument to make the code easier to read.
> 

Good call, applied.

Thanks!
André

> Cheers,
> Longman
> 


