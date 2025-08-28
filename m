Return-Path: <linux-kernel+bounces-790516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2D1B3A993
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3266B5652CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC52C26057C;
	Thu, 28 Aug 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gr7B/J58"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234E3FE5F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756404427; cv=none; b=traRPjHK0nh9HOSgGVBxxUsX208zEW+nhvxH22BKDT5nqzBqCOETR0TOsL6jBP90cAnA62ms7+pX1iBvA3MCHAnAwK48grBG9i6iAbzuzA8MVZ569In3DucJvam9yHFR5yH4v4UZiNA1fb2a4+kk+GzpflbrP5qM3vTX6KbmjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756404427; c=relaxed/simple;
	bh=LY7y3LM/grDdn6hgVqztkzevtPnwuAjoyR2a5p3+h8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPkDyu1/hv0KRZEg0yQSKTFActf/2Y38Hu9vYD3hT4SNMnhryVJrxG4t0gqrcz9RiCEGTVUDyvDycYJJ8zmWnoZXmsAOe9T3VrEIHHO6lqL5t3qAn/GpFn2+N1xejtyMI5M8f31JETqFXgoHr55KCI7GnjQX8dCFRsC6rJJCMnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gr7B/J58; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tazbAhD0D0KuGzpBvdCnSKFxuXK7QWXkBeqei2bKBwo=; b=gr7B/J58sCRQ6XkeHfouuV2GPW
	IRQja+wMbA/HHFkSEbpZJ1GubfXkDQsFnE6jAtWiIfwuEyOgts9LfCNGJU203G2+xuegPKk5kIT35
	Rn+7zplQHXobo/N0/2Y8nyoHFF5NlhBFRJvDh9i+I/dtf1Q1uJYaGCSpNEyJ+b2koD2aqJ8I9Kt1B
	yLjve1O1fbmRGeJx0vmaXoQAI3Ne3Iub1tbV3u5ktly9d9MXrmfmcEjLOH4+mgPamEyE7JSAuuzF5
	ug/UrqWOzTfqerLArGyn4I98KxmHnS32nS68mgO3FDESIU22D3NBx9r3eSxBhOcwfl2lnBLx0HKbl
	WRAX4prA==;
Received: from [187.57.78.222] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1urh1B-0035yz-6r; Thu, 28 Aug 2025 20:06:37 +0200
Message-ID: <61725722-f933-447c-a041-71b2d28e7f90@igalia.com>
Date: Thu, 28 Aug 2025 15:06:26 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/futex: Fix futex_numa_mpol's memory out of
 range subtest
To: Waiman Long <llong@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Borislav Petkov <bp@alien8.de>,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org
References: <20250827154420.1292208-1-andrealmeid@igalia.com>
 <9d4c0d27-0ebd-4c6d-af38-d32ef420fde4@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <9d4c0d27-0ebd-4c6d-af38-d32ef420fde4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 27/08/2025 14:58, Waiman Long escreveu:
> 
> On 8/27/25 11:44 AM, André Almeida wrote:
>> The "Memory out of range" subtest works by pointing the futex pointer
>> to the memory exactly after the allocated map (futex_ptr + mem_size).
>> This address is out of the allocated range for futex_ptr, but depending
>> on the memory layout, it might be pointing to a valid memory address of
>> the process. In order to make this test deterministic, create a "buffer
>> zone" with PROT_NONE just before allocating the valid futex_ptr memory,
>> to make sure that futex_ptr + mem_size falls into a memory address that
>> will return an invalid access error.
>>
>> Fixes: 3163369407ba ("selftests/futex: Add futex_numa_mpol")
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> This patch comes from this series:
>> https://lore.kernel.org/lkml/20250704-tonyk-robust_test_cleanup-v1-13- 
>> c0ff4f24c4e1@igalia.com/
>> ---
>>   .../futex/functional/futex_numa_mpol.c          | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/futex/functional/ 
>> futex_numa_mpol.c b/tools/testing/selftests/futex/functional/ 
>> futex_numa_mpol.c
>> index a9ecfb2d3932..1eb3e67d999b 100644
>> --- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
>> +++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
>> @@ -143,7 +143,7 @@ int main(int argc, char *argv[])
>>   {
>>       struct futex32_numa *futex_numa;
>>       int mem_size, i;
>> -    void *futex_ptr;
>> +    void *futex_ptr, *buffer_zone;
>>       int c;
>>       while ((c = getopt(argc, argv, "chv:")) != -1) {
>> @@ -168,6 +168,17 @@ int main(int argc, char *argv[])
>>       ksft_set_plan(1);
>>       mem_size = sysconf(_SC_PAGE_SIZE);
>> +
>> +    /*
>> +     * The "Memory out of range" test depends on having a pointer to an
>> +     * invalid address. To make this test deterministic, and to not 
>> depend
>> +     * on the memory layout of the process, create a "buffer zone" with
>> +     * PROT_NONE just before the valid memory (*futex_ptr).
>> +     */
>> +    buffer_zone = mmap(NULL, mem_size, PROT_NONE, MAP_PRIVATE | 
>> MAP_ANONYMOUS, 0, 0);
>> +    if (buffer_zone == MAP_FAILED)
>> +        ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
>> +
>>       futex_ptr = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, 
>> MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>>       if (futex_ptr == MAP_FAILED)
>>           ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
> 
> This patch makes the assumption that consecutive mmap() calls will 
> allocate pages consecutively downward from a certain address. I don't 
> know if this assumption will be valid in all cases. I think it will be 
> safer to just allocate the 2-page memory block and then change the 2nd 
> page protection to PROT_NONE to make it a guard page.
> 

Thanks for the feedback! I will send a v2 addressing this by next week.


