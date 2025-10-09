Return-Path: <linux-kernel+bounces-846118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CD8BC7170
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F6D24F2C73
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC7916EB42;
	Thu,  9 Oct 2025 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RmoNemMU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EFF1684A4
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 01:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972066; cv=none; b=X7CEyXmnvs5ddS0fL9OPcFertR9veWH9TM6Ivzf/ceTSEyDQkR8sCGPcGgrTv0trM/n9biMqxHzlMN/3NxY08hGhnha+N/yro2iHpMW7mIppSOnUuXgU2dJ/q1iw64aAuXLJKSUSBXZErJJHLUkQ4AEV7v18CP4aOYM5owcNUPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972066; c=relaxed/simple;
	bh=wUrk6XKY/1u2QS7MA+SbXv3W7CyWgdmZhrUV2O13MM4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iy9bQsphIqwBIG5kktfBEq9uirmkvRx0WVolfNzewEUhyswch3wcQUhr4yMVq4AhKcccOpYVNAIAQ4Z7OirnTpREnCnJTIDkc727wM2/szhlrsHB14e1TwECDwA0q1TrtTkwn9+1m3ed9zoSsq9V0UjzZwp3MEupBThEEsJ4n4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RmoNemMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AC7C4CEE7;
	Thu,  9 Oct 2025 01:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759972065;
	bh=wUrk6XKY/1u2QS7MA+SbXv3W7CyWgdmZhrUV2O13MM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RmoNemMUl1sw1JOPWhVSmESnBtwY1VrPO/I9sWWI9ZARdWfoHuKCcSDnVrOkHjazk
	 z2i+CNKwtjiY+GMjqll+fCd7a2Iimzob44CQSFXocON4Qe2xHIP8L3AO0n7ZN+BP1x
	 eIQnQNCUW88YNkR19rYBD6YtlIfmvSYo0Q+FOf1M=
Date: Wed, 8 Oct 2025 18:07:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 ioworker0@gmail.com, richard.weiyang@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mm-new v3 3/3] mm/khugepaged: merge PTE scanning logic
 into a new helper
Message-Id: <20251008180744.008424134fbc29e9616899ad@linux-foundation.org>
In-Reply-To: <20251008043748.45554-4-lance.yang@linux.dev>
References: <20251008043748.45554-1-lance.yang@linux.dev>
	<20251008043748.45554-4-lance.yang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Oct 2025 12:37:48 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> +		if (!cc->is_khugepaged ||
> +		    *unmapped <= khugepaged_max_ptes_swap) {
> +			/*
> +			 * Always be strict with uffd-wp enabled swap
> +			 * entries. Please see comment below for
> +			 * pte_uffd_wp().
> +			 */
> +			if (pte_swp_uffd_wp(pte)) {
> +				*scan_result = SCAN_PTE_UFFD_WP;
> +				return PTE_CHECK_FAIL;
> +			}
> +			return PTE_CHECK_CONTINUE;
> +		} else {
> +			*scan_result = SCAN_EXCEED_SWAP_PTE;
> +			count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
> +			return PTE_CHECK_FAIL;
> +		}

I'm inclined to agree with checkpatch here.

WARNING: else is not generally useful after a break or return
#81: FILE: mm/khugepaged.c:574:
+			return PTE_CHECK_CONTINUE;
+		} else {

did you see this and disagree or did you forget to run checkpatch?

--- a/mm/khugepaged.c~mm-khugepaged-merge-pte-scanning-logic-into-a-new-helper-checkpatch-fixes
+++ a/mm/khugepaged.c
@@ -571,11 +571,10 @@ static inline int thp_collapse_check_pte
 		    (!cc->is_khugepaged ||
 		     *none_or_zero <= khugepaged_max_ptes_none)) {
 			return PTE_CHECK_CONTINUE;
-		} else {
-			*scan_result = SCAN_EXCEED_NONE_PTE;
-			count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
-			return PTE_CHECK_FAIL;
 		}
+		*scan_result = SCAN_EXCEED_NONE_PTE;
+		count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
+		return PTE_CHECK_FAIL;
 	} else if (!pte_present(pte)) {
 		if (!unmapped) {
 			*scan_result = SCAN_PTE_NON_PRESENT;
@@ -600,11 +599,10 @@ static inline int thp_collapse_check_pte
 				return PTE_CHECK_FAIL;
 			}
 			return PTE_CHECK_CONTINUE;
-		} else {
-			*scan_result = SCAN_EXCEED_SWAP_PTE;
-			count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
-			return PTE_CHECK_FAIL;
 		}
+		*scan_result = SCAN_EXCEED_SWAP_PTE;
+		count_vm_event(THP_SCAN_EXCEED_SWAP_PTE);
+		return PTE_CHECK_FAIL;
 	} else if (pte_uffd_wp(pte)) {
 		/*
 		 * Don't collapse the page if any of the small PTEs are
_


