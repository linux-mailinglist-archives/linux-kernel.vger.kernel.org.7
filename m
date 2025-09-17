Return-Path: <linux-kernel+bounces-820781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 314DCB7F391
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA451C25CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B69B30CB33;
	Wed, 17 Sep 2025 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQ1hpiuH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D4830CB31
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758114947; cv=none; b=gOpnVA2tCQ/X4A2sMfUpgiHkAEGaHVUmVDuXS4caAn64r3myPHdCXdFrny9vNLfXA3eNt67Xi1Z0glMHNB+I5EJzitJ7X368o7MkZ33UoMTuNz0WEVwBqRJ8uC4U1BHPq0RbrLgnsI2GRynIokvtwgmS52k2A8t7zXZeyqn3nzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758114947; c=relaxed/simple;
	bh=BpgS8/o0mgzSmV0Dc3oE0X0tikE/KWUDbIC15pV4T3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mk7ETgzNueNMgUaXcjIBzWrPyIVLZJw4h/O+Bt8Zxv4OHPe59jvvrjYqAH1wWu7UiUXXz6M2hot9ZUtf2lhm/X7bnJ54oeOapkgry7wzhQbA0NBD+yq1st8FvFIRMhyC/noczY/y7+3gP9ADlWWtlUFG2Pa9Aq4QMNFUzQ85qJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQ1hpiuH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758114944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sMaYWZd0QLs8dADNvsyko+Va2gVPuy/Cx2c1y+avoxw=;
	b=BQ1hpiuH1tnZr1+gYFZth1OurXjGbv/9iZWtn/BVeullsHKa+v0p7Uhs8jKof8oSgcmgCh
	AiRMco75VFP6M7emWoyyOW4rEcTY/SNuSDnrgAZpHofyz7KwO44/XqcCT5Gt9FmR2TVZ1K
	BPt+IdLApNbl/NRlWmQhqdPQyGB9iTQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-LTPNIC5yOd6OvhkaN0bEIw-1; Wed, 17 Sep 2025 09:15:43 -0400
X-MC-Unique: LTPNIC5yOd6OvhkaN0bEIw-1
X-Mimecast-MFC-AGG-ID: LTPNIC5yOd6OvhkaN0bEIw_1758114942
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45f2f15003aso21641365e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758114942; x=1758719742;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sMaYWZd0QLs8dADNvsyko+Va2gVPuy/Cx2c1y+avoxw=;
        b=DFhJDjiDIV2+3AHw1xpomEZR46c3AJtHc1eVQVo2L5JyjA07v4VmkmR3mG5kjOWgWS
         gEXx5WbHu5Eh+SAJNTnoEzzNNbCzdW3VPzWpOiiYMzVyOPyCH1PTGbXkYlkYN0/D/Zsn
         EV0RaSjcAV0aDXarx8MM42wX+H7L1C66guqmNoLjnuSlmk42e/9ABhTKg0YZTWQAYjQS
         H7LG4M2Gy+Esl9RIkrP3+4zLHqXmHiQEmOTFSzGk4wKbrUP2ghAIt/aWmZhUjvu/+tGi
         4LhsCFweuiZNKq3GaXBg4dRGBDs264qC9x6KVC20nNV1D2QlMgiXKYsIvIjvYskBtpWj
         ofpg==
X-Forwarded-Encrypted: i=1; AJvYcCUtp1GJs1SwJ+/PUZQuUGS/W/dTx4weszPtOgQGzu66ed0BqX2JXSAFH5nfG7N0xw46zd+s2/s80rJAntM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1Yx86bcTk4vXv4927RvDTmDXi5rVC0hzFgjVhBWXXGKGA8qF
	g2Dh/Gzlib2Uiq673aNJi98XUipyOe6WqvbLFF2eeTxohwlOUR7bmYDaiuFiFT+9Hr+PBGt1+dW
	1sPOacQ0vnP3dx9fXtcEPvBuZwKkkdc37kdjI4OMb2KiRuEbqkt5eOz+MEUD7iO23Tw==
X-Gm-Gg: ASbGnctsiay5rwp7FErlpJjQ3Wzi7NxN6j9yGTi37mGuT1Iq043E0fUSwres1hT+ezc
	cVbogmSVcZ7QgWFcL6uJp8YP10Kco6jQkKAImBd40EgkuYFWhFcz8Bo9l1V2LZwQeDaHIgYLP9n
	sxaGDvbu9izkpoXEICbCJdgwP1F/db9kyd5QnLlmb7uTsKn0pCIfnpwKVgLgzaj9OhfswK/6+W0
	hR1l+q2iYxzk5oQ7/uSInZ9tFmw0Yac23w5yKC6ml6c40DH8fPO0fiQ2jwE9T/42hbCZ7SkHAdZ
	0mZRRR9A6Cg7CuH/xIo+xLf4CIbzyrt69rOqpyfsWKqaCqwUX+euIda03pZOi0ewnBXu74/zjJx
	mDEuOIHAmKWjslsNFP1zq2UKhyg1fzOnvaklbi45VuXFyKtpYmOphm08nJqoNv+CQ
X-Received: by 2002:a05:600c:190e:b0:45d:d9ca:9f8a with SMTP id 5b1f17b1804b1-46206655f96mr16892015e9.27.1758114941958;
        Wed, 17 Sep 2025 06:15:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5Y51KOhOPin9iG2x0kvp8G6Ghirpgs3Z4uYc/yCFUHCmxcF2Vmqpp3hWYWkOPTWgVv8s0pw==
X-Received: by 2002:a05:600c:190e:b0:45d:d9ca:9f8a with SMTP id 5b1f17b1804b1-46206655f96mr16891655e9.27.1758114941524;
        Wed, 17 Sep 2025 06:15:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46138694957sm41910465e9.4.2025.09.17.06.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:15:40 -0700 (PDT)
Message-ID: <26e38fe5-e6c4-4678-8056-95c0ff4350e6@redhat.com>
Date: Wed, 17 Sep 2025 15:15:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/mm: Added fork inheritance test for
 ksm_merging_pages counter
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Wei Yang <richard.weiyang@gmail.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
References: <cover.1757946863.git.donettom@linux.ibm.com>
 <f07c901d4b6b1d1c15a8c1bbd324367d6135d0a3.1757946863.git.donettom@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <f07c901d4b6b1d1c15a8c1bbd324367d6135d0a3.1757946863.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 17:03, Donet Tom wrote:
> Added a new selftest to verify whether the `ksm_merging_pages` counter
> in `mm_struct` is not inherited by a child process after fork. This helps
> ensure correctness of KSM accounting across process creation.
> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   .../selftests/mm/ksm_functional_tests.c       | 42 ++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index 712f43c87736..645cefba2126 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -602,6 +602,45 @@ static void test_prot_none(void)
>   	munmap(map, size);
>   }
>   
> +static void test_fork_ksm_merging_page_count(void)
> +{
> +	const unsigned int size = 2 * MiB;
> +	char *map;
> +	pid_t child_pid;
> +	int status;
> +
> +	ksft_print_msg("[RUN] %s\n", __func__);
> +
> +	map = mmap_and_merge_range(0xcf, size, PROT_READ | PROT_WRITE, KSM_MERGE_MADVISE);
> +	if (map == MAP_FAILED)
> +		return;
> +
> +	child_pid = fork();
> +	if (!child_pid) {
> +		init_global_file_handles();
> +		exit(ksm_get_self_merging_pages());
> +	} else if (child_pid < 0) {
> +		ksft_test_result_fail("fork() failed\n");
> +		return;

Probably
	goto out;

in all these fail cases

> +	}
> +
> +	if (waitpid(child_pid, &status, 0) < 0) {
> +		ksft_test_result_fail("waitpid() failed\n");
> +		return;
> +	}
> +
> +	status = WEXITSTATUS(status);
> +	if (status) {
> +		ksft_test_result_fail("ksm_merging_page in child: %d\n", status);
> +		return;
> +	}
> +
> +	ksft_test_result_pass("ksm_merging_pages is not inherited after fork\n");
> +

And have

	out:

here

With that:

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


