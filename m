Return-Path: <linux-kernel+bounces-786696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BDCB36391
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 308053A4BEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C6929BDB6;
	Tue, 26 Aug 2025 13:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFhjuDCC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07A127EFE7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214542; cv=none; b=czcr96w05+hMT9OyWhbvfuf44cI4WD8Mgd4g3p1yivLC+rSdanjRiHjn367RasfZrxBYZTMWtPWYODmhCu3SAaR4G9gmPqrxRpEL5+E146HG8zo2+Fd+uvFoBBYe/pQGpe7htqrEzN9sc+PgsyvSn85lx4N4b/IbqK6ni4PYGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214542; c=relaxed/simple;
	bh=g9tkyhS/VnJww0SJjrmsAHTYkAN6tMd1DwEKWykS8Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTS/DCCNN44QV3M+D4AEvs5Eam0eNDlmccChXOotU71bIa6wn4w8Q/4w226Eg92E4YbCgf4B5/uOYm0F/h1oCdkRJ/bmIpADfULnk5m768rXPSULCbZMVDT/wz+FC1StnW+rkDzmos4WY7hP8phx0os0pN9qxq7BBeraBScrq/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFhjuDCC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756214537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ejwt2KXyE6SL3SffCoyBx/2GldVYshUfsPo38DTQflo=;
	b=TFhjuDCCo8pkEd2sCAGY0K3RQQGIzt4KwWsJfoAWo1Cqyx7CRYm5Y5yFl5D4vEEHYfT5Kj
	D915sbhS8z5/zI58NTWsdNxanvnTmAOe62JaXiCGmGX3yFj3YyWfBTQ3KRG7fMNVAgLCLl
	0O87aWGKyFt4/tzbuhDptZlov7YL570=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-DJFa0ljSPDOygPdQvsr00g-1; Tue, 26 Aug 2025 09:22:14 -0400
X-MC-Unique: DJFa0ljSPDOygPdQvsr00g-1
X-Mimecast-MFC-AGG-ID: DJFa0ljSPDOygPdQvsr00g_1756214533
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b629ed73bso12167595e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756214533; x=1756819333;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ejwt2KXyE6SL3SffCoyBx/2GldVYshUfsPo38DTQflo=;
        b=auWUeMGNhVYohmcn307SX10o38ESn/r9S+opGKclickG/NxP2aGPkFSzyeQwMj/QKf
         zjJn6JVmc7elC0ZjcKnqsVDkV7gCJL5ohaW1/jJavdPt9e/S8fRv00yJetxa54hTBg3k
         pDIbofLFL3i60i3WLnU/yppCGohPdUjlorX/jc4FeXEGGdJZD3RMblO+cmjv/HCki5hq
         M1ELeZb7VD1XVpCXpwfvLMr5F+5IhRRac/QsWLXPvJakcO54nAhg9eXZgCXnAOsfmFaE
         XChwzlZzJ68CYMhrACbO9v2ZnFAmRLzygPJ3iqahU2HYjOdJJkdGt5QfAs5oSDNzuTdT
         3Nfw==
X-Forwarded-Encrypted: i=1; AJvYcCX1fZALCMBCDmz19ettegG6+c9dwL9yavtAWo733dRv9lt3vLs1OjBv5mxNGCnXEX/bW2/kXUXyduT1Ln0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ocd7xCoY0FrpGslWIriAup/FM50qK4cjpOv9tnDYIEM5UWRP
	A6VevkKdjnUWCQhNK1UvFTfVV/3vfMYIzyMyb/a28wwWwko6JUF8UAIRi8r7ygtWxuqpdeZL+M9
	DJDQjHUoaj1crav9IR/3iuTrOsA1oXzH91v9/WxCvTgr/WtQf9YOOrdGNa5V9GwE0sw==
X-Gm-Gg: ASbGncuwK0p7+3T7Vt4aax7OH0MNNWrsNK9QxMRKpjuzQ38NYJrUNIdXP4tk/eILSkZ
	j95oawkeRTj3oaS09BrAlONWV+aX3wgOEVWm6BD++4gr8KaqtepuoMbYjfK+gVlFFvo0VOJkBfZ
	BdFN1mR30rEvJTe9/zpXmdFbIVBkBa5ep7MiGenH1VUeJh66jIJCB6zVbXDwQ9HyS8Jtk9DbMkZ
	NqLRjPqa8DShvukB56+rghsG139VKezm3sd4DzQuel2jb0f98wVxHL1HYB1ZBJ2Hh78TDxBBOvC
	3TKWBQfwrCkfXwMNd3ClB3l0aTQemVrYmrlZQsCd2Wc+xqgDlwwUOTMr+fX9m07a5Wbmfds4ig=
	=
X-Received: by 2002:a05:600c:1c09:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-45b68a59459mr15830105e9.20.1756214532902;
        Tue, 26 Aug 2025 06:22:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdhrt4HXHiQdFvEf1QK9x4hO8TiEtRV/0QYg6xcfCu7yN72HN+Y2pTEUqhcMa/Na09mCwQAg==
X-Received: by 2002:a05:600c:1c09:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-45b68a59459mr15829785e9.20.1756214532407;
        Tue, 26 Aug 2025 06:22:12 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7116e1478sm16178696f8f.46.2025.08.26.06.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:22:11 -0700 (PDT)
Message-ID: <ba6d3e50-d8dc-4ee4-ae44-bc1b57e4a2dd@redhat.com>
Date: Tue, 26 Aug 2025 15:22:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/mm: add fork inheritance test for
 ksm_merging_pages counter
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Wei Yang <richard.weiyang@gmail.com>,
 Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <2e662107e01417bf9af23bc7f52863cd538419be.1756211338.git.donettom@linux.ibm.com>
 <88d6d5f08ff119625fa9accaa7b849dd77f9df25.1756211338.git.donettom@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <88d6d5f08ff119625fa9accaa7b849dd77f9df25.1756211338.git.donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 14:49, Donet Tom wrote:
> Add a new selftest to verify whether the `ksm_merging_pages` counter

"to verify ... is *not* inherited" ?

> in `mm_struct` is inherited by a child process after fork. This helps
> ensure correctness of KSM accounting across process creation.
> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---
>   .../selftests/mm/ksm_functional_tests.c       | 42 ++++++++++++++++++-
>   1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index 712f43c87736..d971394c9567 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -602,6 +602,45 @@ static void test_prot_none(void)
>   	munmap(map, size);
>   }
>   
> +static void test_fork_ksm_merging_page(void)
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
> +		int mpages;
> +
> +		init_global_file_handles();
> +		mpages = ksm_get_self_merging_pages();
> +		if (mpages > 0)
> +			ksft_test_result_fail("ksm_merging_page in child: %d\n", mpages);
> +
> +		exit(0);
> +	} else if (child_pid < 0) {
> +		ksft_test_result_fail("fork() failed\n");
> +		return;
> +	}
> +
> +	if (waitpid(child_pid, &status, 0) < 0) {
> +		ksft_test_result_fail("waitpid() failed\n");
> +		return;
> +	}
> +
> +	ksft_test_result_pass("ksm_merging_pages is not inherited after fork\n");

Won't this trigger a fail in the child and a pass in the parent process?

You should likely instead let the child return the result (or the 
number) and check that here.

-- 
Cheers

David / dhildenb


