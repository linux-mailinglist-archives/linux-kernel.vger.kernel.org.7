Return-Path: <linux-kernel+bounces-752532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 849D8B176BA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 21:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FC11C26EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 19:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EB32459E5;
	Thu, 31 Jul 2025 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIyTR+hh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0F242927
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 19:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753990959; cv=none; b=P5ik6bqm47zRT2/ZN+lae3lpX89ev3b0FGzQEXeME+XuRTk0iDhkW/GgD6FCn7JSzGV02xsKv8W0bwLRpNqJYaAwV922dFLN7NVwRO1XOi1mG5rD2tutQ5t/FUP5QwGXUFCRfD/M24Dmvjp8agza7IiRYo/S84EwvndyktSlzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753990959; c=relaxed/simple;
	bh=VkEWgW/eK14SmOPl7L+IrnEyXPwK8c8jGmJow64gejc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bj4xZxnYt0oHChEL1q5dDiiHLY+8FMryp8yVlz2mpn66It1SVpXd/OVfJotQLlFXqSJ+TZkiTiBvVG2TtKVsE7S05ZtFyDwIzgWYqMuz+ZIlNmSBLzmnPY0TaNtEGEhtBsmi6wdrtuq2JBJE1XmxljCaO12myF14ATvqwZRmdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIyTR+hh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753990956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ycs1g1B6Cy7/P7AyjBWJe4E4Uc8WvaNBjZRl6rpbaFI=;
	b=MIyTR+hhjyV0ivJf+kCJjounB7cmWHDjevnMcyP8Bo0M93kvmanfDlf+2x3S/vaQCkutwo
	iHsQf4alYWTSVBxqUSH5LPnd2NUQPvvTtqT3R/kurq/soN1thkSW9DM9S7w+u6Z9fc2B7F
	BXAdMlips5az5eodtjNfZvmqj5ZBIGU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-MJKfFj4lOuq3besdt7VmVQ-1; Thu, 31 Jul 2025 15:42:34 -0400
X-MC-Unique: MJKfFj4lOuq3besdt7VmVQ-1
X-Mimecast-MFC-AGG-ID: MJKfFj4lOuq3besdt7VmVQ_1753990953
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455e9e09afeso2808165e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753990953; x=1754595753;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ycs1g1B6Cy7/P7AyjBWJe4E4Uc8WvaNBjZRl6rpbaFI=;
        b=J7V+96sqeWQqRrDWxMmbHYP4D1gBPQxUQQv5Atvr27o7CZay0hLi8uXDWD+Oj8vpx5
         cj7uFqO2FhW+xKCGjDM2V8sTMDnUH3FpCZvRFaYkk5hCfhMPtKTZBAbh+kY0tcBlyQgI
         4vePkFDHsnvRFOhFa3T0MhyU1g1Hh7VKD05WV/NzHXktQxZFTSCMvU3Za3rqBklpYJrq
         FBu55Etaxc6pzVqXJ/hd908daka7wlERG3rfKLkmniuEpxTkRRbR44RuDxNeAXyV51d6
         Vpi3LPBlU83KmhhfB5oqPFdc6s0GrHb6TrGna1ynvUNLGp0/wXlDIl22w+cFLwQT5Wyw
         okQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkdi2y0UzV0ijnVHvAY+g+s7wjljG37u991RV1S1AtijjbuIQeO+9mOYsxrVsVeaHDA56eyfP3c1CbEEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXYtfeLxdFOqSJ/dHQ6wXywwgKkHllXt0vyLfEEBb+j25+Pl0
	c4xmDgiFOnX0uij/XkzsGXUE5Q3KpVn3LJHiNUEXRCOh02+9JZwASkCeJSTcQuwycWWJq+OwJ6y
	1kraZ8eT4Xy/S4q4yxSYG3LlG1hOfd1fw004GirAD4CvLG7QVNnCfUJjSrZ3BdnL0pw==
X-Gm-Gg: ASbGnct2jpSKhtV+sligJhYNOrC9axak8aWvGRqBaaPPuyBRaHqZ0jYikj51PM2+ogF
	du5rgP6pHR8mYMxHFxBUUMOJLpMB8tmwRed/plNcwle0okbW4/9l1UfyHTZWKhWnuLIVnMe+txG
	LcrkyLSPhMRRbIOKMgdOcP6xpCDHwUjvdUXTbfdORJWumzueIspsejWKxHJ6B8QPIGbKeQShg2+
	WHZdfVcPuhBwgyHwrpmm91MrK7IJ9qv0FmFku8Zf2eekFrFTW6A2BSpWaTbDBp6Rih+U5FC2gUl
	EBMOAn1S0lRnjVTYEp2RGAOzZO5xTo5uu7mD+PaOyDhOJ+j/GChVSExsbJVnnNnw/2ZR87OwVSW
	m6FIpr/x+Iq3rzYzo5dFS1nSDZz3DV2ILMNT41ePwuIYLy5+ugw+mrjELplvF1nvytHY=
X-Received: by 2002:a05:600c:4f0d:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-45892b91175mr93599895e9.4.1753990953304;
        Thu, 31 Jul 2025 12:42:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0ShMhh6tiZwFcRCf+53pVIS0KqyVNX0UpSosXnZYpZI3UF4O5k5pa7V7O4sOynwE9eweSmw==
X-Received: by 2002:a05:600c:4f0d:b0:456:207e:fd83 with SMTP id 5b1f17b1804b1-45892b91175mr93599625e9.4.1753990952854;
        Thu, 31 Jul 2025 12:42:32 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3700:be07:9a67:67f7:24e6? (p200300d82f443700be079a6767f724e6.dip0.t-ipconnect.de. [2003:d8:2f44:3700:be07:9a67:67f7:24e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458a99ce1d2sm415915e9.23.2025.07.31.12.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 12:42:32 -0700 (PDT)
Message-ID: <7b13d8b5-a534-47f8-b6c5-09a65bffc691@redhat.com>
Date: Thu, 31 Jul 2025 21:42:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] selftests: prctl: introduce tests for disabling
 THPs completely
To: Usama Arif <usamaarif642@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, vbabka@suse.cz, jannh@google.com,
 Arnd Bergmann <arnd@arndb.de>, sj@kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kernel-team@meta.com
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-5-usamaarif642@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250731122825.2102184-5-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.25 14:27, Usama Arif wrote:
> The test will set the global system THP setting to never, madvise
> or always depending on the fixture variant and the 2M setting to
> inherit before it starts (and reset to original at teardown).
> 
> This tests if the process can:
> - successfully set and get the policy to disable THPs completely.
> - never get a hugepage when the THPs are completely disabled
>    with the prctl, including with MADV_HUGE and MADV_COLLAPSE.
> - successfully reset the policy of the process.
> - after reset, only get hugepages with:
>    - MADV_COLLAPSE when policy is set to never.
>    - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
>    - always when policy is set to "always".
> - repeat the above tests in a forked process to make sure
>    the policy is carried across forks.
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---

[...]

Looks much better already. Some quirks.

> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <sys/prctl.h>
> +#include <sys/wait.h>
> +
> +#include "../kselftest_harness.h"
> +#include "thp_settings.h"
> +#include "vm_util.h"
> +
> +static int sz2ord(size_t size, size_t pagesize)
> +{
> +	return __builtin_ctzll(size / pagesize);
> +}
> +
> +enum thp_collapse_type {
> +	THP_COLLAPSE_NONE,
> +	THP_COLLAPSE_MADV_HUGEPAGE,	/* MADV_HUGEPAGE before access */
> +	THP_COLLAPSE_MADV_COLLAPSE,	/* MADV_COLLAPSE after access */
> +};
> +
> +enum thp_policy {
> +	THP_POLICY_NEVER,
> +	THP_POLICY_MADVISE,
> +	THP_POLICY_ALWAYS,
> +};

Couldn't you have reused "enum thp_enabled" end simply never specified 
the "THP_INHERIT"? Then, you need to do less translation.

> +
> +struct test_results {
> +	int prctl_get_thp_disable;

The result is always one, does that here make sense?

> +	int prctl_applied_collapse_none;

"prctl_applied" is a bit confusing. And most of these always have the 
same value.

Can't we special case the remaining two cases on the current policy and 
avoid this struct compeltely?


> +	int prctl_applied_collapse_madv_huge;
> +	int prctl_applied_collapse_madv_collapse;
> +	int prctl_removed_collapse_none;
> +	int prctl_removed_collapse_madv_huge;
> +	int prctl_removed_collapse_madv_collapse;
> +};
> +
> +/*
> + * Function to mmap a buffer, fault it in, madvise it appropriately (before
> + * page fault for MADV_HUGE, and after for MADV_COLLAPSE), and check if the
> + * mmap region is huge.
> + * Returns:
> + * 0 if test doesn't give hugepage
> + * 1 if test gives a hugepage
> + * -errno if mmap fails
> + */
> +static int test_mmap_thp(enum thp_collapse_type madvise_buf, size_t pmdsize)
> +{
> +	char *mem, *mmap_mem;
> +	size_t mmap_size;
> +	int ret;
> +
> +	/* For alignment purposes, we need twice the THP size. */
> +	mmap_size = 2 * pmdsize;
> +	mmap_mem = (char *)mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
> +				    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (mmap_mem == MAP_FAILED)
> +		return -errno;
> +
> +	/* We need a THP-aligned memory area. */
> +	mem = (char *)(((uintptr_t)mmap_mem + pmdsize) & ~(pmdsize - 1));
> +
> +	if (madvise_buf == THP_COLLAPSE_MADV_HUGEPAGE)
> +		madvise(mem, pmdsize, MADV_HUGEPAGE);
> +
> +	/* Ensure memory is allocated */
> +	memset(mem, 1, pmdsize);
> +
> +	if (madvise_buf == THP_COLLAPSE_MADV_COLLAPSE)
> +		madvise(mem, pmdsize, MADV_COLLAPSE);
> +

To avoid even mmap_mem to get merged with some other VMA, maybe just do
before reading the smap here:

/* HACK: make sure we have a separate VMA that we can check reliably. */
mprotect(mem, pmdsize, PROT_READ);

or

madvise(mem, pmdsize, MADV_DONTFORK);

before reading smaps.

That is probably the easiest approach. The you can drop the lengthy 
comment and perform a single thp check.


[...]

> +
> +static void prctl_thp_disable_test(struct __test_metadata *const _metadata,
> +				   size_t pmdsize, struct test_results *results)
> +{
> +
> +	ASSERT_EQ(prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL),
> +		  results->prctl_get_thp_disable);
> +
> +	/* tests after prctl overrides global policy */
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize),
> +		  results->prctl_applied_collapse_none);
> +
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
> +		  results->prctl_applied_collapse_madv_huge);
> +
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize),
> +		  results->prctl_applied_collapse_madv_collapse);
> +
> +	/* Reset to global policy */
> +	ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL), 0);
> +
> +	/* tests after prctl is cleared, and only global policy is effective */
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize),
> +		  results->prctl_removed_collapse_none);
> +
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
> +		  results->prctl_removed_collapse_madv_huge);
> +
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize),
> +		  results->prctl_removed_collapse_madv_collapse);
> +}
> +
> +FIXTURE(prctl_thp_disable_completely)
> +{
> +	struct thp_settings settings;
> +	struct test_results results;

Is this "expected_results" ?

But again, hopefully we can remove that and instead just base it on the 
polocy that we configured.

-- 
Cheers,

David / dhildenb


