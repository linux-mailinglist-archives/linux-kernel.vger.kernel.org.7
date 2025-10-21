Return-Path: <linux-kernel+bounces-862156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C08BF48D5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720AB425EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AD521255A;
	Tue, 21 Oct 2025 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zb4tyoiG"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597B7D515
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761018857; cv=none; b=vFbrr71HsVDamhRZxJBS/FHezaZ4fC1Ay3l+S9co7geX9HXPMwZ0CAmvRNjVzCk/LgE29KQO258ET1R+ywW9eSAns4rKR3x7eR8Wnui4BaWlSBugBhLe9THHY7VcV10zJMsiBlMehAmxYZy9Q9TrfbaEo+vXvvkW4+F2Eq5PBJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761018857; c=relaxed/simple;
	bh=ld1mk8mFPuUiH3BODYxL699bG8tU1Ec3figtxcSMx9g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GrjhssW7O+I/iBES0W83aOou/0gHqzMR8exJNpPZx1PiB1Xzd0+MY7oHLLci9yjtseHU1lRurrhZXSIaqV3n8zg4THg/S8vrnadyIJKaE4FzBJtnKgWvI08KLP2/Deaw/MEKEmGqXE0iuCUtG5vMEW+3w8puqR+bJT8ocORnDQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zb4tyoiG; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761018844; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=8DqkQFzbLJRAr2/bah4u5arNYsIBZs+B2Fh0nUeM2Ec=;
	b=Zb4tyoiGX3Y6fdCV8UDF2avF5vEmm1Mf4UaTdYF7s4ujh0B2zaIPp4lGPOG1HvWJjUm3zM1rCMf2q8TWLLdFzt7hmRiSarN7XmqhGd/dV9JINJ4Eq6lKsb8qF5tF46XeKFUpKhCLSi0JCKufTvzkBl4xlWjUuRNV4naTiSJP+Z0=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WqhQHqT_1761018843 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Oct 2025 11:54:04 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  David
 Hildenbrand <david@redhat.com>,  linux-kernel@vger.kernel.org,  Catalin
 Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] mm/debug_vm_pgtable: Add [pte|pmd]_mkwrite_novma() tests
In-Reply-To: <20251021024424.2390325-1-anshuman.khandual@arm.com> (Anshuman
	Khandual's message of "Tue, 21 Oct 2025 03:44:24 +0100")
References: <20251021024424.2390325-1-anshuman.khandual@arm.com>
Date: Tue, 21 Oct 2025 11:54:03 +0800
Message-ID: <875xc8ap0k.fsf@DESKTOP-5N7EMDA>
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
>  mm/debug_vm_pgtable.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index 830107b6dd08..b9cae1580782 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -102,6 +102,11 @@ static void __init pte_basic_tests(struct pgtable_debug_args *args, int idx)
>  	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte, args->vma))));
>  	WARN_ON(pte_dirty(pte_wrprotect(pte_mkclean(pte))));
>  	WARN_ON(!pte_dirty(pte_wrprotect(pte_mkdirty(pte))));
> +
> +	WARN_ON(pte_dirty(pte_mkwrite_novma(pte_mkclean(pte))));

Why not use: pte_mkwrite(pte, args->vma)?

Maybe add

        WARN_ON(!pte_dirty(pte_mkwrite_novma(pte_mkdirty(pte))));

> +	WARN_ON(!pte_write(pte_mkdirty(pte_mkwrite_novma(pte))));
> +	WARN_ON(!pte_write(pte_mkwrite_novma(pte_wrprotect(pte))));
> +	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite_novma(pte))));
>  }
>  
>  static void __init pte_advanced_tests(struct pgtable_debug_args *args)
> @@ -195,6 +200,11 @@ static void __init pmd_basic_tests(struct pgtable_debug_args *args, int idx)
>  	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd, args->vma))));
>  	WARN_ON(pmd_dirty(pmd_wrprotect(pmd_mkclean(pmd))));
>  	WARN_ON(!pmd_dirty(pmd_wrprotect(pmd_mkdirty(pmd))));
> +
> +	WARN_ON(pmd_dirty(pmd_mkwrite_novma(pmd_mkclean(pmd))));
> +	WARN_ON(!pmd_write(pmd_mkdirty(pmd_mkwrite_novma(pmd))));
> +	WARN_ON(!pmd_write(pmd_mkwrite_novma(pmd_wrprotect(pmd))));
> +	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite_novma(pmd))));
>  	/*
>  	 * A huge page does not point to next level page table
>  	 * entry. Hence this must qualify as pmd_bad().

---
Best Regards,
Huang, Ying

