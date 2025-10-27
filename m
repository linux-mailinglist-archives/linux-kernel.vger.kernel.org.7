Return-Path: <linux-kernel+bounces-871066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5620FC0C622
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49765188ED19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2F82E8E1F;
	Mon, 27 Oct 2025 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYwM17SY"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356162E88BB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554564; cv=none; b=Mp8bQIMfIobgADG/OWm6jKOslhWAZxabwVxy164Wn2tz6FkSR1Tc1xAi3d6BN+QpJzhU3rEEr1VzJu2u+RXIx6rlM+DfuMIHJYwqKeF0ZHaVg9cUPbECCYDZTWea4fFcnOZHQWRKMHvijeMOA5BX0+U9ykK/QptzWZaphFs/CQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554564; c=relaxed/simple;
	bh=hqG+5l/LrvFbIM2Tk/d5FE11cjQxVeAHFu9KCJp7GSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2msS+h2RaOmq4lgSAQ5vmmOSXgm6hLhKrbEuc3DoZ8MJ1XKdJgMv/WQyD2I+H9zGQPVHDICkqMe/N47I7fk27ZIYgcmbRIW+KM0oAGZDbm7iRsgvSb8yrxIlJMFnIEVGu1vH4xuc3dm3WF4+B3vaKsLISAmuYTuLSc4PeL830c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYwM17SY; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-85a4ceb4c3dso421834785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554561; x=1762159361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8OiplbvxRK3PGzaWxhrNct+/g/8F7ug0XbeVAkGeME=;
        b=KYwM17SY+Ul9nobSvVebLG2hB5yAPMGiRbBAtpPEJ0VI9s/XJEapK5Oda5RmgDhPSS
         iYr0wcKBqqlxWGE36+LrHAKb6+NccjSTZqUh+UTfDc/hO5cxvmwf94AkVv4rusdFyidh
         M1uXxuyokgYY1jwxUQryKbaQAbnuTUez6CIYsqCck32V2X/llFYuAyTdZ/QMdlW4aoN3
         rmomdjRJJw85yJ0dbL+mqKyD7wxJ/S4yxJlDwzjT++wADFcd46r9gljfc/E0D0iEHxRM
         UpM6KJuxmiQMX0180ftxGwbCyWu+XQ1PdHCCIrngFrgMivfVaQk4MTqWpstV2hRvCl43
         D39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554561; x=1762159361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S8OiplbvxRK3PGzaWxhrNct+/g/8F7ug0XbeVAkGeME=;
        b=w6RGh+4+wwzFfNoo0yq5T0CRwE4wJ0BumT2cDNQ//1A2N//A5+xqtM4hNG9sMg4qCd
         vu/lM9XYzmou1jdmfwiqbrH1eP3o1PfU2Zm82Uap3+RkQM7x5rGYGa9hph5hrNoSXXn5
         doq2s8ReSoowwZz8y33sZm7Ihrsdih+B8rp6Z+DNRiQewtfWvCK1Q6ojg3vzZhT4J6f8
         Lca3AXDOyFlkv9pmdQaL6xvJHtTwg+ypVJj/mmCdppeU9sR9lKWnP8xLzz/ebIcHoy3O
         MNSd1PGQFpL6flzGk9tYOTvjFNOc/XK4ocTSuko+LavIbSEC3cL3Y7PO9rJ6WFmpKOi5
         xKAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCiOEttePMb8ld3KrSuzQYppDIoby/fgiy1WyksETnqd0YxqBS8AlZ0W+edJXjUoTGmDddz9zumUvO1ps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zH2/H+DAnoCHkfDOaKwGTyulzLq3zuuOneFqoG7QQ14MSZEn
	0gUsQtSZUaGMjb3pzPZSBF5ZCA3VYWWCFyy7tpIDP44GRQzXYQWdHCEocoaBJdRsQVfnnLNISbJ
	WudkIRTT4jrNF7bIxOtS3ALX5e8T9vtU=
X-Gm-Gg: ASbGnctMlhj0wPdbm0R7R6txYB3iHVh5yabdTC5NPKeMmoH8Tc69H0jMBBnuc5T7j9r
	vpNxe6BUAkBASzPr14fJ/Ympt8CnGJTHE+wPdST9tBM+G4vZ/+MY7Xq8tRHIJUGKVioxq3uCu8o
	a8O3M6GyaL+EdViC1QgPrDODvuS6NFJZSqoxzI2BNZmw8gTU8GZ4pOlLmQ0Dy/y8jqPkgowP8N6
	a8qJ9jLhNWwjyaTP64Q6sWBHjzrEguANq17CLr5wtMMuQypDNEJPdGZ0K8JrsN1rjWiUM04Itql
	FQii6b0KrpO/HWbSbi16qOnES3g=
X-Google-Smtp-Source: AGHT+IFX+mR137xrvZDcqT/67/gVBqUrAWDajbuXrFM2dAwerxuXEYH48nepHi6uQYXhfp0Am9+yzl1UMhOb2c+aXlg=
X-Received: by 2002:a05:620a:294f:b0:8a4:6ac1:ae9 with SMTP id
 af79cd13be357-8a46ac112f4mr279316485a.3.1761554560864; Mon, 27 Oct 2025
 01:42:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023013524.100517-1-ying.huang@linux.alibaba.com> <20251023013524.100517-3-ying.huang@linux.alibaba.com>
In-Reply-To: <20251023013524.100517-3-ying.huang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 27 Oct 2025 16:42:29 +0800
X-Gm-Features: AWmQ_bk9pI0TtC_0goeD9hHvk9ke19jrv2VrqxdCfcyf-qPwd6ST0IlyubPCsHY
Message-ID: <CAGsJ_4y46gUWNR_Gc8A12UkTPybR=dc-1vmH_f6WHEFih-CqnQ@mail.gmail.com>
Subject: Re: [PATCH -v3 2/2] arm64, tlbflush: don't TLBI broadcast if page
 reused in write fault
To: Huang Ying <ying.huang@linux.alibaba.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Yang Shi <yang@os.amperecomputing.com>, "Christoph Lameter (Ampere)" <cl@gentwo.org>, Dev Jain <dev.jain@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Yin Fengwei <fengwei_yin@linux.alibaba.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:23=E2=80=AFPM Huang Ying <ying.huang@linux.alibab=
a.com> wrote:
>
> A multi-thread customer workload with large memory footprint uses
> fork()/exec() to run some external programs every tens seconds.  When
> running the workload on an arm64 server machine, it's observed that
> quite some CPU cycles are spent in the TLB flushing functions.  While
> running the workload on the x86_64 server machine, it's not.  This
> causes the performance on arm64 to be much worse than that on x86_64.
>
> During the workload running, after fork()/exec() write-protects all
> pages in the parent process, memory writing in the parent process
> will cause a write protection fault.  Then the page fault handler
> will make the PTE/PDE writable if the page can be reused, which is
> almost always true in the workload.  On arm64, to avoid the write
> protection fault on other CPUs, the page fault handler flushes the TLB
> globally with TLBI broadcast after changing the PTE/PDE.  However, this
> isn't always necessary.  Firstly, it's safe to leave some stale
> read-only TLB entries as long as they will be flushed finally.
> Secondly, it's quite possible that the original read-only PTE/PDEs
> aren't cached in remote TLB at all if the memory footprint is large.
> In fact, on x86_64, the page fault handler doesn't flush the remote
> TLB in this situation, which benefits the performance a lot.
>
> To improve the performance on arm64, make the write protection fault
> handler flush the TLB locally instead of globally via TLBI broadcast
> after making the PTE/PDE writable.  If there are stale read-only TLB
> entries in the remote CPUs, the page fault handler on these CPUs will
> regard the page fault as spurious and flush the stale TLB entries.
>
> To test the patchset, make the usemem.c from
> vm-scalability (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-sc=
alability.git).
> support calling fork()/exec() periodically.  To mimic the behavior of
> the customer workload, run usemem with 4 threads, access 100GB memory,
> and call fork()/exec() every 40 seconds.  Test results show that with
> the patchset the score of usemem improves ~40.6%.  The cycles% of TLB
> flush functions reduces from ~50.5% to ~0.3% in perf profile.
>
> Signed-off-by: Huang Ying <ying.huang@linux.alibaba.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Yang Shi <yang@os.amperecomputing.com>
> Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: Yin Fengwei <fengwei_yin@linux.alibaba.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  arch/arm64/include/asm/pgtable.h  | 14 +++++---
>  arch/arm64/include/asm/tlbflush.h | 56 +++++++++++++++++++++++++++++++
>  arch/arm64/mm/contpte.c           |  3 +-
>  arch/arm64/mm/fault.c             |  2 +-
>  4 files changed, 67 insertions(+), 8 deletions(-)
>

Many thanks to Ryan and Ying for providing such a clear explanation to me i=
n v2.
The patch looks very reasonable to me now.

Reviewed-by: Barry Song <baohua@kernel.org>

Thanks
Barry

