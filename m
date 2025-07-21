Return-Path: <linux-kernel+bounces-739593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D15B0C84B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CA75455D2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 15:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA06B2E03E6;
	Mon, 21 Jul 2025 15:57:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125342DFA21
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753113465; cv=none; b=nz1M9hG1+sqSlkXDM/o6wb+fNdHRovzWYmjYRI5vk2rPBYdAryhf47As719dfoj7fmvyZ06DlM6J1RZYuynUS/AIVTmh8Q6Kb/3wx2+UEqssFd/ILB+wdt3/K1u5DMDFs0VOCkKfhhNp8Q8qXYPbn9BDbzlrGt5MN0v5AUtDSRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753113465; c=relaxed/simple;
	bh=XEKYZrig8jdMomffz3kLwR4AlHFSQv9cUMUqlNS8fa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4nmsc9gYj1+c6cQPp1a2qLW4T4zOBQziKdNfSeCih2ndy+7qcgZqAslgEd+Yd9MG3eHyXd/RQy4shRIrkWjGmt6j/k/y43soYlaEnuqi/rZ4pheYGSb+/a1qs5OTU0HiNUuq/C25d1Qjkv5pjeufaRVU56Gn1fKphZdXwuJR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34CDD153B;
	Mon, 21 Jul 2025 08:57:36 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D597F3F66E;
	Mon, 21 Jul 2025 08:57:35 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:57:32 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
	willy@infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, will@kernel.org,
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
	jannh@google.com, anshuman.khandual@arm.com, peterx@redhat.com,
	joey.gouly@arm.com, ioworker0@gmail.com, baohua@kernel.org,
	kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
	christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org, hughd@google.com,
	yang@os.amperecomputing.com, ziy@nvidia.com
Subject: Re: [PATCH v5 7/7] arm64: Add batched versions of
 ptep_modify_prot_start/commit
Message-ID: <aH5jbAYKoACvspj4@arm.com>
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-8-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718090244.21092-8-dev.jain@arm.com>

On Fri, Jul 18, 2025 at 02:32:44PM +0530, Dev Jain wrote:
> Override the generic definition of modify_prot_start_ptes() to use
> get_and_clear_full_ptes(). This helper does a TLBI only for the starting
> and ending contpte block of the range, whereas the current implementation
> will call ptep_get_and_clear() for every contpte block, thus doing a
> TLBI on every contpte block. Therefore, we have a performance win.
> 
> The arm64 definition of pte_accessible() allows us to batch in the
> errata specific case:
> 
> #define pte_accessible(mm, pte)	\
> 	(mm_tlb_flush_pending(mm) ? pte_present(pte) : pte_valid(pte))
> 
> All ptes are obviously present in the folio batch, and they are also valid.
> 
> Override the generic definition of modify_prot_commit_ptes() to simply
> use set_ptes() to map the new ptes into the pagetable.
> 
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>

The arm64 changes look fine to me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

