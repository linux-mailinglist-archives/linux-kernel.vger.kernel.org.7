Return-Path: <linux-kernel+bounces-849019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A96CBCF068
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37E744E3E6F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD34212578;
	Sat, 11 Oct 2025 06:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VatXPrGG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DD4C8F0
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760164111; cv=none; b=INIFIB/67NT+uMu8Q/BkUA2XF+w6OVaiJUix05hDXhdnvEUKJDG1LfjzvPuyN5W9AiEhjWy/AzklEByBn5mFwMLGv9m71zYIiEJIKRXXWv5U4/QAI1NULLF9MffUv9xozagse+u9PTNibvPOPPjMfxMrxXrDRW7h2UsRpI41zV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760164111; c=relaxed/simple;
	bh=JmDOfQUbMEHiVtzCQOOrc24XvL9I3YKy6Q+bCgh3a1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XC2us/iHPyTmQ1tudaxjpSdmrxJqENhZUiuIymWpbHiqSN0cclK1oD7VxSY34C2AtsaH7XO6QMKTuD3jgqXJcim9QaaXfmBkNPncybDTcNMKmFCN90o7ObkNigIg8X7x0uaTzp+g8+4kOJmQfXT4Qh8XQJtLMAP6Wh23FjtFkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VatXPrGG; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760164101; x=1791700101;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JmDOfQUbMEHiVtzCQOOrc24XvL9I3YKy6Q+bCgh3a1o=;
  b=VatXPrGGd6inhjlcQX3/6woHzxD2gvPzRFOeeKu2wGyNJYnB2Mf4TvvS
   AA/RBzh0aCcsVmka0BC3eGuvnLJkvVrBI2o3JIJmIeHkLyyOHN1Sk2+5u
   +30U52UG6J2lab3dR7MND+VFS0H/kEaA3s5jCoZNATvDEFK6hbJUj3qGW
   R5SMc2HGaQah9oQrG0VR+XGcLLDz/9iCapHCWi89zzjDx5hYqbjOqv2Pp
   5RoUihTSLs+Lh2wP3eGMVbcH1fP7KWzTxADuMt+cIr1udxC76QLFYhxbV
   3X0qG191VP3mknLWFS5bb1Wo0dLQJPG57VLMlAcqKei3HH93K6ST66QaZ
   w==;
X-CSE-ConnectionGUID: JFCRAkfLS8iSQ3CI7RQ9MA==
X-CSE-MsgGUID: 22Zhr7zDRcO6Mq4J1LkcRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62258573"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="62258573"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 23:28:20 -0700
X-CSE-ConnectionGUID: ak6XigH/QdeMlk+cNQCyDA==
X-CSE-MsgGUID: +31j5JXqT2muzztIzmPLXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="180257706"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 23:28:14 -0700
Message-ID: <3971a3fd-c733-4864-851a-87dc9d3f686a@linux.intel.com>
Date: Sat, 11 Oct 2025 14:24:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] mm: Add a ptdesc flag to mark kernel page tables
To: Matthew Wilcox <willy@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Dave Hansen <dave.hansen@linux.intel.com>
References: <20250919054007.472493-1-baolu.lu@linux.intel.com>
 <20250919054007.472493-2-baolu.lu@linux.intel.com>
 <aObCAwbf1-Sxepni@casper.infradead.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <aObCAwbf1-Sxepni@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/25 03:56, Matthew Wilcox wrote:
> On Fri, Sep 19, 2025 at 01:39:59PM +0800, Lu Baolu wrote:
>> +static inline void ptdesc_set_kernel(struct ptdesc *ptdesc)
>> +{
>> +	struct folio *folio = ptdesc_folio(ptdesc);
>> +
>> +	folio_set_referenced(folio);
>> +}
> So this was the right way to do this at the time.  However, if you look
> at commit 522abd92279a this should now be ...
> 
>   enum pt_flags {
>   	PT_reserved = PG_reserved,
> +	PT_kernel = PG_referenced,
>   	/* High bits are used for zone/node/section */
>   };
> [...]
> 
> +static inline void ptdesc_set_kernel(struct ptdesc *ptdesc)
> +{
> +	set_bit(PT_kernel, &pt->pt_flags.f);
> +}

Thank you for the review comment. I updated the patch like the
following:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a3f97c551ad8..5abd427b6202 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2940,6 +2940,7 @@ static inline pmd_t *pmd_alloc(struct mm_struct 
*mm, pud_t *pud, unsigned long a
  #endif /* CONFIG_MMU */

  enum pt_flags {
+       PT_kernel = PG_referenced,
         PT_reserved = PG_reserved,
         /* High bits are used for zone/node/section */
  };
@@ -2965,6 +2966,46 @@ static inline bool pagetable_is_reserved(struct 
ptdesc *pt)
         return test_bit(PT_reserved, &pt->pt_flags.f);
  }

+/**
+ * ptdesc_set_kernel - Mark a ptdesc used to map the kernel
+ * @ptdesc: The ptdesc to be marked
+ *
+ * Kernel page tables often need special handling. Set a flag so that
+ * the handling code knows this ptdesc will not be used for userspace.
+ */
+static inline void ptdesc_set_kernel(struct ptdesc *ptdesc)
+{
+       set_bit(PT_kernel, &ptdesc->pt_flags.f);
+}
+
+/**
+ * ptdesc_clear_kernel - Mark a ptdesc as no longer used to map the kernel
+ * @ptdesc: The ptdesc to be unmarked
+ *
+ * Use when the ptdesc is no longer used to map the kernel and no longer
+ * needs special handling.
+ */
+static inline void ptdesc_clear_kernel(struct ptdesc *ptdesc)
+{
+       /*
+        * Note: the 'PG_referenced' bit does not strictly need to be
+        * cleared before freeing the page. But this is nice for
+        * symmetry.
+        */
+       clear_bit(PT_kernel, &ptdesc->pt_flags.f);
+}
+
+/**
+ * ptdesc_test_kernel - Check if a ptdesc is used to map the kernel
+ * @ptdesc: The ptdesc being tested
+ *
+ * Call to tell if the ptdesc used to map the kernel.
+ */
+static inline bool ptdesc_test_kernel(struct ptdesc *ptdesc)
+{
+       return test_bit(PT_kernel, &ptdesc->pt_flags.f);
+}
+
  /**
   * pagetable_alloc - Allocate pagetables
   * @gfp:    GFP flags

Thanks,
baolu

