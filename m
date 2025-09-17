Return-Path: <linux-kernel+bounces-820785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E45B7F244
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F837A4D74
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1705B126BF7;
	Wed, 17 Sep 2025 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2u6bRTg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769782BE039
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115175; cv=none; b=gIEEnZ3y1dAQ3gTLcOX8GyWXyF7pEeJqXA9b5XynqayZxVquBsMfjjWuX7yNZGsiuo9kbDJg+TaKni/4GhW0yZRjYmTrJFNXQVqnEto345XCwLzX8VCy5POtb613IQtuVha3KG6CSMt2mLBGeRgNWFsBnQHbUKf4fZaOMcvgHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115175; c=relaxed/simple;
	bh=L1BLH7R69fWaQWMvoUNCnxKjvsyGng5HKxb5JdcsUvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSxbHjGnf009aVGyaqIy3SuWy6PEUNcXvN8yHicrxcfGCyQVMJb51RQ+xZYnyanVfmuGSIKaOxjs/9eO2szbmA/OYb73bjKSRs61iUlxPkbtj9J/3d7fOt+PxeEEzklIywJ8wcGx+VtGMZkNRkfYnlD5djMm/ISuk+U4xPMhF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2u6bRTg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758115171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GnzUrOdcBemtX94K3X42zgRnlnpIqExLzJ+Ix1CFZmI=;
	b=I2u6bRTgbZbgcgONGVRpekryMGKwNziScr/jxTL+cInFhV7zPDEriOj+3J9ZLMTmlkjykT
	qR/DRbdZzfkRSLT933p4MqrFS8YWo5jpGoJcM9PdWtf7DtYGITjwqlUGSHRTy1+Baecpo7
	4J5pBBsYXWcYRXXy6MehGSdQMH+FJVQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-437uo3gMM_-Cw0DMTQyEpg-1; Wed, 17 Sep 2025 09:19:30 -0400
X-MC-Unique: 437uo3gMM_-Cw0DMTQyEpg-1
X-Mimecast-MFC-AGG-ID: 437uo3gMM_-Cw0DMTQyEpg_1758115167
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45ceeae0513so41554235e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115167; x=1758719967;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GnzUrOdcBemtX94K3X42zgRnlnpIqExLzJ+Ix1CFZmI=;
        b=GLKIu5VB9IBorvxudvMH20YCIUK/kJUHnnBJQ8OsFlnncrL7fkQGU7jex2DBcNJ+KE
         PePxU2IdptB7nKCak9tL1X/J33SFAfnKfX2aoibhyRZBiJKnXg8oPuWj/iVoFQRbvJ8K
         wxscnruJMbUCh2TyKWHfqGtdi2obtrzw3lSvoXNv+KEpbkXOYD9jOCxk/UWZWXokXHMe
         KgnHtdbHh5/fkLHAW+Ayh2WbjNBMGgUW5rqWxuAwDq1IV9yH958/JJ07pT5ZgW+Y97v3
         PJbQV02qBexfpB/tpqv1iBe/Q1znaaD6jLfe2ai1UxOEbnz1RBRZ1HlJCIaqYGdMnBFb
         z+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCX1YKzutSZUJilVdCOQIDH00ep+wPlPUyZOvmcVDfBfpPR0QiXJF1hXR3rjRr8VmZn+NgUMjsvfSm+w4i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUCNQ+IvCrE3dHKsnYMCBem5yV1cQSfmcn1FLPDb8XjpSIoJUM
	7uEIlMT8pUyrNEtzKhl0wr77+A5rECNF6s3Xr2iZo9PvPTRY3cm+irxknt/CZ4RI7zd5ff53fN2
	YyhOYAot2Ii1WGBR7jru+XAXkbVM5mIOMGz34aJeKUUcDTSA/pKjMFjf9X163kOhztQ==
X-Gm-Gg: ASbGncuYvumYpMoOjJ0gZW0V99qTdurxWT3AXLK3WY7pGZpEGe13c8ImlC0IQ0mbhaQ
	xDCrloAlZIab/DrmNYYM9QHIH7KEr8deOOLfpJBdCDGztlEdkr8l4oJBYb/uHiCU/Gd4+/A1abQ
	7cEwS+D4eMhsaHSbM/othNEWOMCNvScUdy8n8mQR9b0SXdqlse6uPy+A49bYmEte/RycbV2NojL
	Nie4hRaZx4R1W5ABvTTEInzMXnVLbj0rTUzO6msppOawSybz4Z7Ev6qBoP4LPuCwDzG0MH/r9RB
	VaEVHflq2ajiMBFJ4oxt/dROrSiG346wI8t/U16maXzuWg43xA7Xu8p9RHrKuankHC2cQV4KWHF
	dWssmDsAod2MIEoIG21LiAAdm3COk0X+Kj/vhCNnkvwWXXZ93befTAPvyNYTFkiX0
X-Received: by 2002:a05:600c:680a:b0:45b:83fe:9cf7 with SMTP id 5b1f17b1804b1-4625a2e5059mr21772715e9.6.1758115167346;
        Wed, 17 Sep 2025 06:19:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbHkHsqmSE1TzQcAUHd1ErKND4A6lwO0ygnBDKXF3NTBgJ2UsMnDHnhZBoD2TXSixnzV02Ng==
X-Received: by 2002:a05:600c:680a:b0:45b:83fe:9cf7 with SMTP id 5b1f17b1804b1-4625a2e5059mr21772025e9.6.1758115166573;
        Wed, 17 Sep 2025 06:19:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd0a7sm25851981f8f.39.2025.09.17.06.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:19:26 -0700 (PDT)
Message-ID: <d4988c21-1e1a-4de2-a1c0-7d78525d2939@redhat.com>
Date: Wed, 17 Sep 2025 15:19:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/mm: Added fork test to verify global
 ksm_zero_pages counter behavior
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Wei Yang <richard.weiyang@gmail.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
References: <cover.1757946863.git.donettom@linux.ibm.com>
 <5910cb6bfc7c43b169b679a0108667a56d7ebdb8.1757946863.git.donettom@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <5910cb6bfc7c43b169b679a0108667a56d7ebdb8.1757946863.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 17:03, Donet Tom wrote:
> Added a selftest to verify the behavior of the global KSM zero-page
> counter during fork. When a process forks, the per-process zero-page
> counter is inherited by the child, and the global counter should be
> updated with this inherited value. This test ensures that the global
> counter is correctly updated after fork.
> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   .../selftests/mm/ksm_functional_tests.c       | 74 ++++++++++++++++++-
>   1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index 645cefba2126..f23597ac8066 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -602,6 +602,77 @@ static void test_prot_none(void)
>   	munmap(map, size);
>   }
>   
> +long ksm_get_global_ksm_zero_pages(void)
> +{
> +	int global_ksm_zero_pages_fd;
> +	char buf[10];
> +	ssize_t ret;
> +
> +	global_ksm_zero_pages_fd = open("/sys/kernel/mm/ksm/ksm_zero_pages",
> +								O_RDONLY);
> +	if (global_ksm_zero_pages_fd < 0)
> +		return -errno;
> +
> +	ret = pread(global_ksm_zero_pages_fd, buf, sizeof(buf) - 1, 0);
> +	close(global_ksm_zero_pages_fd);
> +	if (ret <= 0)
> +		return -errno;
> +	buf[ret] = 0;
> +
> +	return strtol(buf, NULL, 10);
> +}
> +
> +static void test_fork_global_ksm_zero_pages_count(void)
> +{
> +	const unsigned int size = 2 * MiB;
> +	char *map;
> +	pid_t child_pid;
> +	int status;
> +	long g_zpages_before = 0, g_zpages_after = 0;
> +
> +	ksft_print_msg("[RUN] %s\n", __func__);
> +
> +	/* Unmerge all pages before test */
> +	if (ksm_stop() < 0) {
> +		ksft_test_result_fail("KSM unmerging failed\n");
> +		return;
> +	}
> +	/* Get the global zero page count before test */

That only works when "use_zero_pages" is enabled, no?

> +	g_zpages_before = ksm_get_global_ksm_zero_pages();
> +	/* Let KSM deduplicate zero pages. */
> +	map = mmap_and_merge_range(0x00, size, PROT_READ | PROT_WRITE, KSM_MERGE_MADVISE);
> +	if (map == MAP_FAILED)
> +		return;
> +
> +	child_pid = fork();
> +	if (!child_pid) {
> +		exit(ksm_stop());
> +	} else if (child_pid < 0) {
> +		ksft_test_result_fail("fork() failed\n");
> +		return;

Cleanup missing as for patch #2.

> +	}
> +	if (waitpid(child_pid, &status, 0) < 0) {
> +		ksft_test_result_fail("waitpid() failed\n");
> +		return;
> +	}
> +	status = WEXITSTATUS(status);
> +	if (status < 0) {
> +		ksft_test_result_fail("KSM unmerging failed in child\n");
> +		return;
> +	}
> +
> +	/* Verify global zero-page count remains unchanged */
> +	g_zpages_after = ksm_get_global_ksm_zero_pages();
> +	if (g_zpages_before != g_zpages_after) {
> +		ksft_test_result_fail("Incorrect global ksm zero page count after fork\n");
> +		return;
> +	}
> +
> +	ksft_test_result_pass("Global ksm zero page count is correct after fork\n");
> +	ksm_stop();
>

What stops KSM from merging pages in other processes by accident 
concurrently and giving false failures?

Likely you would want to stop ksm before the fork.

-- 
Cheers

David / dhildenb


