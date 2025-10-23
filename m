Return-Path: <linux-kernel+bounces-866068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AFDBFED2A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 03:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C0A19A1E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 01:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03062B2D7;
	Thu, 23 Oct 2025 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HOTMyy8e"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A04502A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182234; cv=none; b=H7kYKFdXHjEKYIoIT5UVLoCvGa2rYQ4RkdgFVBnk36wFETEuU2v5yucxMLk1AGIUbQfFpo1TTAtDUIcpyXTSL9p8Sx5bPzwORx/2hJAOk+P2L082VPcpcTadOeR/ZQE744LyJAjunQ1AVyQ6JXF1ZmXHeGfgasnfHJ46eIn7mik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182234; c=relaxed/simple;
	bh=C1bYycyuPZ80fxpx6jrWiP+crKGpKFVr5PXP71WtIGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dbIkLhpjbrSbElBQwSY5UNuoAWvzFaxVfUEvcj82kpUYxBAr063EddNMXA6GjtQ6ncMV/Bmga2Ms51wBSjKVk8El2yMA33yC61oDu44og3/M+v13Gd7b+i9XqFWpoYmgvCf8usAMwdkDWzx3ClZQZhMFJGHYSY+/1x7PyThRzWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HOTMyy8e; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761182228; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=tLGJy/2AZYKq6vVC4qpKJvBSxQ5OrU9VmKnnjRkvqm8=;
	b=HOTMyy8eLC58QU1RiFa+oca4lhrG3OW5tpG2lJbX60frsX+rd1sld3jR1VwMuuI2CQ7OMpEBI22QAdUqQuCOSSOBrGbbrOzJRapA2KZ7s6RuYtwLVaEDC2jtqzh41wGBCU4/cDjHdBFI5+gK5LuMzM35KWifO+/lxsdcZ98YD5Q=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wqoktlp_1761182227 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Oct 2025 09:17:08 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  David
 Hildenbrand <david@redhat.com>,  linux-kernel@vger.kernel.org,  Catalin
 Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH V2] mm/debug_vm_pgtable: Add [pte|pmd]_mkwrite_novma()
 tests
In-Reply-To: <20251022032951.3498553-1-anshuman.khandual@arm.com> (Anshuman
	Khandual's message of "Wed, 22 Oct 2025 04:29:51 +0100")
References: <20251022032951.3498553-1-anshuman.khandual@arm.com>
Date: Thu, 23 Oct 2025 09:17:06 +0800
Message-ID: <87ms5i2z8t.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Anshuman Khandual <anshuman.khandual@arm.com> writes:

> Add some [pte|pmd]_mkwrite_novma() relevant tests.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Huang Ying <ying.huang@linux.alibaba.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> These tests clear on arm64 platform after the following recent patch.
>
> https://lore.kernel.org/all/20251015023712.46598-1-ying.huang@linux.alibaba.com/
>
> Changes in V2:
>
> - Added a new test combination per Huang
>
> Changes in V1:
>
> https://lore.kernel.org/all/20251021024424.2390325-1-anshuman.khandual@arm.com/
>
>  mm/debug_vm_pgtable.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 830107b6dd08..def344bb4a32 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -102,6 +102,12 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>  	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
>  	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
>  	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
> +
> +	WARN_ON(!pte_dirty(pte_mkwrite_novma(pte_mkdirty(pte))));
> +	WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));
> +	WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));
> +	WARN_ON(!pte_write(pte_mkwrite_novma(pte_wrprotect(pte))));
> +	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite_novma(pte))));
>  }
>  
>  static void __init pte_advanced_tests(struct pgtable_debug_args *args)
> @@ -195,6 +201,12 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
>  	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd, args->vma))));
>  	WARN_ON(pmd_dirty(pmd_wrprotect(pmd_mkclean(pmd))));
>  	WARN_ON(!pmd_dirty(pmd_wrprotect(pmd_mkdirty(pmd))));
> +
> +	WARN_ON(pmd_dirty(pmd_mkwrite_novma(pmd_mkclean(pmd))));
> +	WARN_ON(!pmd_write(pmd_mkdirty(pmd_mkwrite_novma(pmd))));
> +	WARN_ON(!pmd_write(pmd_mkwrite_novma(pmd_wrprotect(pmd))));
> +	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite_novma(pmd))));

Why not add

        WARN_ON(!pmd_dirty(pmd_mkwrite_novma(pmd_mkdirty(pte))));

too?

---
Best Regards,
Huang, Ying

> +
>  	/*
>  	 * A huge page does not point to next level page table
>  	 * entry. Hence this must qualify as pmd_bad().

