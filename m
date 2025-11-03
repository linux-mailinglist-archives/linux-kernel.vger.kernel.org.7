Return-Path: <linux-kernel+bounces-882281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3188C2A0E4
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 06:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69AAA3482FA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 05:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362632405FD;
	Mon,  3 Nov 2025 05:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT532m20"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DAE28DB3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762147448; cv=none; b=nVCYX66zgAWxblVVCtFOkYQi3a7X8ysVYvl6qqfRqYdaEcdaF+hZPAoy3+vLWOjw3ZgwsWXldNTZulH11wUWh2DWIEkRfIMoZ2/DVjnGKivzUeJi6w7EyFfIybP3ZzO5N3oHfyJoq4GG5KhJ/Fmk5QjB5f/vl5yUwH/XGFnM3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762147448; c=relaxed/simple;
	bh=o80hdJ41nxlCAkFvBtv84SAT41bB1GPwLUrKbTDmsE0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=GxKW2FnCFvSv29qZDY2XT4nSy42IvdZ1VmchSXC6ombgFjTG/MPz6wHdbueorlbUcD2hDmSou1gmiCpaxDPyYcyeO1KQNJHussAggaPX+UrOvrc5kbpZLlyR3MjH07GFDHKgVTcstm8yqUhv9BmOqOr1e0WojeDikrwu02nSeDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT532m20; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so3688130b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 21:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762147445; x=1762752245; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hxlaLhA1KNd3P6ts8pPE7iFrzEvkZDWndI4E+RtwM3c=;
        b=gT532m20vgzfDCWCg6FBHlM7hIu2HwoUttC3b4cJ6lfsg2pldOmDPxEpaSk1KA8SER
         frX3XmaUV5uHFdNQiUhrLYh5uv6NCkMpA2ACWya30ljD6wWojNWxW3Lg7qYFW3k+mUdg
         kVPwE0aSJ1bhwmJuS+7/iTW8ja/LniZQeDfb/3KpeunRHDBYjID0KsZG3bWn0dMUX0xJ
         C13ZZuEMI3PiCBtXUpfApvPiZ/TBldtGYYAgeOBfsoBZUg4f5E5OrkR6qrZYOMkLCAog
         pfBEsme/gZlByJ9MWpj/aHIpZiAHjWSD+K6EIGR+sGhWDkVOffgwaY1XzRwcfXhkbyPY
         Xorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762147445; x=1762752245;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hxlaLhA1KNd3P6ts8pPE7iFrzEvkZDWndI4E+RtwM3c=;
        b=GcJ9m1LcuZ5O7XkCzxPGJ1Qnm0ktbC1fZ01FjzsbL5bcnUBooQttNfNGSzaOwXCbQJ
         wT8zmI1NqAJ05detY85loXkKcQBF2s/uwI0vlJS7CZAmueKuylgi3QFyDd1X5iORV4el
         9IDtiJWO0e9b30/L0ZVsO+Jp2We1BgZleroWMzHUxo2igGl4ZiORLBy2PDF/tO6DS2nz
         ILRf7Lx/G8ZwA3ucNoVjuUpEOg90ojY7VmVP261LP5IY6zf7jNq/vPTzcoaIP9xWaUKY
         v+s1Rm6bR10EfFH3bXnGD0zi2Z5HMDdWglejAy/fZA/rwo2px3wx827PDPYjlTgGWIlY
         sYsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4qobGyKjK0mukbhtmzgHsfK5HoS7onm79JibFjd7XRADd/qE/DzY8yO+zlLhzEIxZCtt5UIPWKGfi6EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM+D5dQiWRMchVEcgMndEKSTqQEEwbNbw1dEepXm29fnJRaRjf
	4OoyWvmU6IPP7P2arK+ekif51H4QMi1jN4IBTtCH2ySQXkC6PhZFRts4
X-Gm-Gg: ASbGnctIYN5yhXfWIM+1Y++mFbm0Dupi7m2+nZ7XzJcKR8lqKyw0ovdT22iCGYXP/ov
	b5FwKkv/o2+WmG3jWHk+j4PTpMzgCkA4muqsD9wBa+n8xGi/u2KcdxFGtYaK2joaYiSKqHbgqT5
	csyJTGNqxnsZfOZJI+Mg5VT2f+uojsiNDaHkqi3dHbpt93Cvb+tuce4JGk8BbMG5V4GQbhK2lQK
	QupGLVHr5kdEqfE6FTtBycb7BteK8SjrNIbJYXhkp0ekjOJLopXT18SdkawK2V9xIJ/C7wgqiah
	o3ypMpWDnyKm4o5lNqU3cGFMpHJmg6ssBBrfS/iRpZFw5ruFS7wMQYAVFaBYp4AdRglOZ2NcOoK
	ICKrAOswfSRoLymhAM0N9ra9IBVEIpeW4LdFz/ENylZb5fgKm1McK93LDAVyyMzrtxdI75aHXR7
	QIuTo/
X-Google-Smtp-Source: AGHT+IGLt4dkwu/l/f8pyXhwZlNlKn0W2O0qaUgnRSLR4mLq5jyeTb1X/5S+ByPTtg2TX/kY2ScSqw==
X-Received: by 2002:a05:6a00:b87:b0:77d:6a00:1cd1 with SMTP id d2e1a72fcca58-7a777b47d9dmr14621942b3a.12.1762147444828;
        Sun, 02 Nov 2025 21:24:04 -0800 (PST)
Received: from dw-tp ([171.76.85.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db86f0fesm9646002b3a.60.2025.11.02.21.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 21:24:04 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Heiko Carstens <hca@linux.ibm.com>, Luiz Capitulino <luizcap@redhat.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, David Hildenbrand <david@redhat.com>, osalvador@suse.de, aneesh.kumar@kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
In-Reply-To: <20251030145505.2764038-1-hca@linux.ibm.com>
Date: Mon, 03 Nov 2025 10:29:29 +0530
Message-ID: <87zf934spa.ritesh.list@gmail.com>
References: <20251030145505.2764038-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Heiko Carstens <hca@linux.ibm.com> writes:

> As reported by Luiz Capitulino enabling HVO on s390 leads to reproducible
> crashes. The problem is that kernel page tables are modified without
> flushing corresponding TLB entries.
>
> Even if it looks like the empty flush_tlb_all() implementation on s390 is
> the problem, it is actually a different problem: on s390 it is not allowed
> to replace an active/valid page table entry with another valid page table
> entry without the detour over an invalid entry. A direct replacement may
> lead to random crashes and/or data corruption.
>
> In order to invalidate an entry special instructions have to be used
> (e.g. ipte or idte). Alternatively there are also special instructions
> available which allow to replace a valid entry with a different valid
> entry (e.g. crdte or cspg).
>
> Given that the HVO code currently does not provide the hooks to allow for
> an implementation which is compliant with the s390 architecture
> requirements, disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, which is
> basically a revert of the original patch which enabled it.
>
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/20251028153930.37107-1-luizcap@redhat.com/
> Fixes: 00a34d5a99c0 ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Yup architectures like aarch64 and PPC64 keep it disable for the same
reason. However patch [1] allows for enabling similar optimization for
DAX vmemmap "ARCH_WANT_OPTIMIZE_DAX_VMEMMAP", if DAX is supported.

I see in 6.18-1 pull request s390 had "Add DAX support for DCSS memory
block devices".

[1]: https://lore.kernel.org/all/20230724190759.483013-8-aneesh.kumar@linux.ibm.com/T/#u

-ritesh

>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index c4145672ca34..df22b10d9141 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -158,7 +158,6 @@ config S390
>  	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>  	select ARCH_WANT_KERNEL_PMD_MKWRITE
>  	select ARCH_WANT_LD_ORPHAN_WARN
> -	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>  	select ARCH_WANTS_THP_SWAP
>  	select BUILDTIME_TABLE_SORT
>  	select CLONE_BACKWARDS2
> -- 
> 2.48.1

