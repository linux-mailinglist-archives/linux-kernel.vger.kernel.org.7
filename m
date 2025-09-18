Return-Path: <linux-kernel+bounces-786751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07817B36783
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9AD1C219C1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7AB350842;
	Tue, 26 Aug 2025 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EiefoRnZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C737735082F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216622; cv=none; b=rz8UCIwtOSNkEsrv4HlRwkLSUNJv+sLRYpw9BCxEPz+JCodI3hAswiq63pgOTaAuIx5q/mbi/dkW0HNMRaa4qiJY+j2Z9gnsu2vPWXFLsqOL9znqhUOQP8RqLH9wPbN/k3gXa4gXRdNPYJ4swvObXVdaUG2N+tLizYSmP0L2YaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216622; c=relaxed/simple;
	bh=+P5vHOETwAKSKRJlgf+nPrVMZ5zSIuukmTd0STFP2Dw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pW1dcSGC4breHC97YoGG7Q3nIw9jQGX2TedqlmNdf3RfhitSRzBJSxRsXUWhovtVWeSB1OpludV6o6XCjEergwFBxdopYzmeQeaR0ZF/S5/wU4NYTTz7fl8cDjocJs3aVMLEQvNTKh/7RcHKpgTvOBfJzxhsIuSIlfS9W52rvp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EiefoRnZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756216619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+hqFp5clSfvaBsPmh8fou/H5segAzQ5q21O3ITIGIY=;
	b=EiefoRnZNFguzrXbkQwU07e4mru4Yzr2CFN0t1fful6QAhhLWyViB8pdPUI+x4ODiSE4wT
	NiHE4xKh++TLUF5WvZdyshVcXKTj+OFp0pYa35z7nzuM5WLjkB/ACCTIkKB9Tokgagfvso
	fii4Clikhh2YYjgRp+UJQtjoSHWGIC0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-mEnptHo-OPy0DPCPBy_3cA-1; Tue, 26 Aug 2025 09:56:58 -0400
X-MC-Unique: mEnptHo-OPy0DPCPBy_3cA-1
X-Mimecast-MFC-AGG-ID: mEnptHo-OPy0DPCPBy_3cA_1756216617
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e953a49de25so4081257276.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216617; x=1756821417;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+hqFp5clSfvaBsPmh8fou/H5segAzQ5q21O3ITIGIY=;
        b=BoNOwisJYmxj7z+k15OUGNu/CwHCufL+qPkE5/RQcP5HXOzKCCxbLjMUJOFgCMvQ/a
         SOC2ailPm1gS/REOmEwmzcFTFeRYT9KouAMN7K2L4jNP4V7NFDXJ3ofFhCNB00NhU88J
         IpeV62wqTj8ZlNZEWFcbHxQmjhI5Q6EZbaa8gDDXQD5amLvkQ+Y6BmrK8QzfNxqYPXgS
         h7L6JLYaqqaB5NulzHij4X2cT+Y/owmg1y6A+HuxrSOur+yHT+OdmR6Y0hlNH4GzTOxd
         foj5Hv0Fb8Wr6TkltYMsW5nzv8KWLL/OyRtPjntGhDzCcheG9uOx+n/kAnj/+Nc/Vtzm
         X/9g==
X-Forwarded-Encrypted: i=1; AJvYcCXJ/0fY4ILjwsyAIoBGJg89C6xIbMXyELLpVjQU/jQ2/rYIH7WnrSmRD00laVsOk0ADIRddEZ+P5wtp65k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsdL+/lqzP18GZGjgPveIdWlTJ+Tbqf+yP7OTb0OxQ4sr2YbeM
	5VvUrunHOlTURkikhAS/DGaNWuep705HOnKAfx+FCN2M8WlYJpYCbxpo2Kdn2KSFZQZcUYIxZik
	KRpgvM6FWclBx24M+hU4gCqt1rCfT9kYiMkhUW7w8pneNntdICTpaXLPOg3L6AdvdcQ==
X-Gm-Gg: ASbGncsvEfODtaf6+xC/7v9x3bg7bEx0RNOOaCQ/R5Mnx+NcmoZ1LWM6ItdhO/Wz5NY
	MJ/HMxtElFiLTzxwSYuJSI5UVLvi8My8CuU4OseUm+u60Jn8IhApLp6MKdr3F3psOMI2xiLaq9P
	twYMd0CqEMThsoeH7eU5YEv3SCqMiI7otv34mVxbYOhzrVzM+WAy6uNSfxGW7L3MEtIxhYP1IZP
	VvKrinMSRtO1QhKUA92NNLb7GvQV0aCooPK9dmavCf6gLbc4r711MNclLb4y9YDDfzs9F0TjEDU
	V1ttmOSjqOZwrOc8O2IQJ6I2qEapKKYnIDdfmNoFbQlP6IcA74PugFYwFsqDA07RGoKbZkCGQD/
	mZiucIWvucQ==
X-Received: by 2002:a05:6902:721:b0:e90:2c1:3120 with SMTP id 3f1490d57ef6-e951c3fa376mr15579696276.41.1756216617384;
        Tue, 26 Aug 2025 06:56:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3zLqxZMSvyIXEVi4FpdM9xLDyflJKPlcm0eu7rqoV5i0Pfv79OwW8p62aHBifSBon0GogXg==
X-Received: by 2002:a05:6902:721:b0:e90:2c1:3120 with SMTP id 3f1490d57ef6-e951c3fa376mr15579659276.41.1756216616894;
        Tue, 26 Aug 2025 06:56:56 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96d7dc1da1sm944431276.6.2025.08.26.06.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:56:56 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <396b8e64-86e5-4fda-8e5f-008f7118a3ef@redhat.com>
Date: Tue, 26 Aug 2025 09:56:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250825: arc: seqlock.h:876:2: error: implicit declaration
 of function 'spin_lock' [-Werror=implicit-function-declaration]
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Linux-Arch <linux-arch@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Ye Liu <liuye@kylinos.cn>,
 Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Dev Jain <dev.jain@arm.com>, David Hildenbrand <david@redhat.com>,
 Chris Li <chrisl@kernel.org>
References: <CA+G9fYuR9auMS=hg9Ri+A2SeCQ0jHkW7mN3k9RDG66vE5cfJdQ@mail.gmail.com>
 <CA+G9fYuLx27WRsS185pDnCVOtsLhn_WQRY4EoDBU8dT-hm88Rw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+G9fYuLx27WRsS185pDnCVOtsLhn_WQRY4EoDBU8dT-hm88Rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/25 8:42 AM, Naresh Kamboju wrote:
> On Tue, 26 Aug 2025 at 12:05, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>> The following build warnings / errors noticed with arc defconfig with
>> gcc-9 toolchain.
>>
>> Regression Analysis:
>> - New regression? yes
>> - Reproducibility? yes
>>
>> Build regression: next-20250825 arc seqlock.h:876:2: error: implicit
>> declaration of function 'spin_lock'
>> [-Werror=implicit-function-declaration]
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> arc:
>>    build:
>>      * gcc-9-allnoconfig
>>      * gcc-9-tinyconfig
>>      * gcc-9-vdk_hs38_smp_defconfig
>>      * gcc-9-defconfig
>>      * gcc-9-axs103_defconfig
>>
>> ## Build log
>> In file included from include/linux/mmzone.h:17,
>>                   from include/linux/gfp.h:7,
>>                   from include/linux/mm.h:7,
>>                   from arch/arc/include/asm/arcregs.h:149,
>>                   from arch/arc/include/asm/irqflags-arcv2.h:9,
>>                   from arch/arc/include/asm/irqflags.h:13,
>>                   from include/linux/irqflags.h:18,
>>                   from include/linux/spinlock.h:59,
>>                   from include/linux/sched.h:37,
>>                   from arch/arc/kernel/asm-offsets.c:6:
>> include/linux/seqlock.h: In function 'write_seqlock':
>> include/linux/seqlock.h:876:2: error: implicit declaration of function
>> 'spin_lock' [-Werror=implicit-function-declaration]
>>    876 |  spin_lock(&sl->lock);
>>        |  ^~~~~~~~~
>> include/linux/seqlock.h: In function 'write_sequnlock':
>> include/linux/seqlock.h:890:2: error: implicit declaration of function
>> 'spin_unlock' [-Werror=implicit-function-declaration]
>>    890 |  spin_unlock(&sl->lock);
>>        |  ^~~~~~~~~~~
>> include/linux/seqlock.h: In function 'write_seqlock_bh':
>> include/linux/seqlock.h:902:2: error: implicit declaration of function
>> 'spin_lock_bh' [-Werror=implicit-function-declaration]
>>    902 |  spin_lock_bh(&sl->lock);
>>        |  ^~~~~~~~~~~~
>> include/linux/seqlock.h: In function 'write_sequnlock_bh':
>> include/linux/seqlock.h:917:2: error: implicit declaration of function
>> 'spin_unlock_bh' [-Werror=implicit-function-declaration]
>>    917 |  spin_unlock_bh(&sl->lock);
>>        |  ^~~~~~~~~~~~~~
>> include/linux/seqlock.h: In function 'write_seqlock_irq':
>> include/linux/seqlock.h:929:2: error: implicit declaration of function
>> 'spin_lock_irq' [-Werror=implicit-function-declaration]
>>    929 |  spin_lock_irq(&sl->lock);
>>        |  ^~~~~~~~~~~~~
>> include/linux/seqlock.h: In function 'write_sequnlock_irq':
>> include/linux/seqlock.h:943:2: error: implicit declaration of function
>> 'spin_unlock_irq'; did you mean 'write_sequnlock_irq'?
>> [-Werror=implicit-function-declaration]
>>    943 |  spin_unlock_irq(&sl->lock);
>>        |  ^~~~~~~~~~~~~~~
>>        |  write_sequnlock_irq
>> include/linux/seqlock.h: In function '__write_seqlock_irqsave':
>> include/linux/seqlock.h:950:2: error: implicit declaration of function
>> 'spin_lock_irqsave' [-Werror=implicit-function-declaration]
>>    950 |  spin_lock_irqsave(&sl->lock, flags);
>>        |  ^~~~~~~~~~~~~~~~~
>> include/linux/seqlock.h: In function 'write_sequnlock_irqrestore':
>> include/linux/seqlock.h:981:2: error: implicit declaration of function
>> 'spin_unlock_irqrestore'; did you mean 'write_sequnlock_irqrestore'?
>> [-Werror=implicit-function-declaration]
>>    981 |  spin_unlock_irqrestore(&sl->lock, flags);
>>        |  ^~~~~~~~~~~~~~~~~~~~~~
>>        |  write_sequnlock_irqrestore
>> In file included from include/linux/sched.h:15,
>>                   from arch/arc/kernel/asm-offsets.c:6:
>> include/linux/rcupdate.h: In function 'rcu_read_lock_sched_held':
>> include/linux/preempt.h:227:49: error: implicit declaration of
>> function 'irqs_disabled' [-Werror=implicit-function-declaration]
>>    227 | #define preemptible() (preempt_count() == 0 && !irqs_disabled())
>>        |                                                 ^~~~~~~~~~~~~
>>                            ^
>> cc1: some warnings being treated as errors
> Anders bisected this and found,
>   # first bad commit:
>     [7cf258e5720ffdd5505faa04ab5afa9732ef0f6e]
>     mm-replace-20-page_shift-with-common-macros-for-pages-mb-conversion-fix

The compilation problem is a result of bad include file ordering. Since 
the only users of PAGES_TO_MB() macro are kernel/rcu/rcuscale.c and 
mm/swap.c and they both include <linux/mm.h>. So this can be fixed by 
just removing the <linux/mm.h> include from arcregs.h.

Cheers,
Longman


>> ## Source
>> * Kernel version: 6.17.0-rc3-next-20250825
>> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
>> * Git describe: next-20250825
>> * Git commit: 6c68f4c0a147c025ae0b25fab688c7c47964a02f
>> * Architectures: arc
>> * Toolchains: gcc-9
>> * Kconfigs: defconfig
>>
>> ## Build
>> * Build log: https://qa-reports.linaro.org/api/testruns/29652436/log_file/
>> * Build details:
>> https://regressions.linaro.org/lkft/linux-next-master/next-20250825/build/gcc-9-defconfig/
>> * Build error details:
>> https://regressions.linaro.org/lkft/linux-next-master/next-20250825/log-parser-build-gcc/gcc-compiler-include_asm-generic_getorder_h-error-implicit-declaration-of-function-ilog/
>> * Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq
>> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq/
>> * Kernel config:
>> https://storage.tuxsuite.com/public/linaro/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq/config
>>
>> --
>> Linaro LKFT
>> https://lkft.linaro.org


