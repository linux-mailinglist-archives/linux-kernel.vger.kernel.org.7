Return-Path: <linux-kernel+bounces-870775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88256C0BA90
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 03:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E708818A308A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 02:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EBB2D540D;
	Mon, 27 Oct 2025 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nhKPw3BB"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030352D29CE
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761530598; cv=none; b=Aea695q26kNKgc9rPwl0LMrUX5tcpcNmakHcvjlGwRBDuUAUtZ7Ey/fOhNts/x80l7RcyLm8KRnDIeJaLPVFwf1Qtx269SMA5V/popFDiZjEA2KXqX42oYc7uyu0LOOlooofq1htCqli12PpJYdSwp3KwesP5igucy0cNZgL0mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761530598; c=relaxed/simple;
	bh=YnlLfSeWaLmzhIjuiLSDNwjYJ9vS/n7XL/YYh6heIuM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SmyG+SkcEoVSAThuh+n9HBWWRCIX7/3Ei4y5hOfzcVs50tlvLbYZkJB2LHpwBpx8vt/tasRLmQ87THuGTKZIRE5XhzIbe6GHTvATeFcxTbyssOeVLB7xjZ2KreQulKPsjsLu/MpRS1XmLycgeB13EMqUHOGlE9mjBl5HZvmZXFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nhKPw3BB; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761530586; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=mx+VoEY0CT/CKfx1nDM5Jt1hgguzcel3vSopk965SuI=;
	b=nhKPw3BBHwGISurGxwZiowwYw0ZzMIplqhfKtTecUWxRZcof6V3ukmaHnoyVa4qePMjTqQklydHgVI1QjQTTOAtD0k116dUoBAA/4/66DSJjfL1dx2RTeUMafZ+x0oMw/KWLYtKZwGS0k4P+e71P4TUtEbBzylISUt5geajHw+w=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wr-dZdy_1761530575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Oct 2025 10:03:04 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,  Catalin Marinas
 <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>,  David Hildenbrand <david@redhat.com>,
  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,  Vlastimil Babka
 <vbabka@suse.cz>,  Zi Yan <ziy@nvidia.com>,  Baolin Wang
 <baolin.wang@linux.alibaba.com>,  Ryan Roberts <ryan.roberts@arm.com>,
  Yang Shi <yang@os.amperecomputing.com>,  "Christoph Lameter (Ampere)"
 <cl@gentwo.org>,  Dev Jain <dev.jain@arm.com>,  Barry Song
 <baohua@kernel.org>,  Anshuman Khandual <anshuman.khandual@arm.com>,
  Kefeng Wang <wangkefeng.wang@huawei.com>,  Kevin Brodsky
 <kevin.brodsky@arm.com>,  Yin Fengwei <fengwei_yin@linux.alibaba.com>,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH -v3 0/2] arm, tlbflush: avoid TLBI broadcast if page
 reused in write fault
In-Reply-To: <20251023013524.100517-1-ying.huang@linux.alibaba.com> (Huang
	Ying's message of "Thu, 23 Oct 2025 09:35:22 +0800")
References: <20251023013524.100517-1-ying.huang@linux.alibaba.com>
Date: Mon, 27 Oct 2025 10:02:54 +0800
Message-ID: <87cy69hzjl.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Huang Ying <ying.huang@linux.alibaba.com> writes:

> This series is to optimize the system performance via avoiding TLBI
> broadcast if page is reused in the write protect fault handler.  More
> details of the background and the test results can be found in [2/2].
>
> Changelog:
>
> v3:
>
> - Various code cleanup and improved design and document in [1/2],
>   Thanks Lorenzo and David's comments!
> - Fixed a typo and improved function interface in [2/2], Thanks Ryan's
>   comments!
>
> v2:
>
> - Various code cleanup in [1/2], Thanks David's comments!
> - Remove unnecessary __local_flush_tlb_page_nosync() in [2/2], Thanks Ryan's comments!
> - Add missing contpte processing, Thanks Rayn and Catalin's comments!
>
> Huang Ying (2):
>   mm: add spurious fault fixing support for huge pmd
>   arm64, tlbflush: don't TLBI broadcast if page reused in write fault
>
>  arch/arm64/include/asm/pgtable.h  | 14 ++++---
>  arch/arm64/include/asm/tlbflush.h | 56 ++++++++++++++++++++++++++++
>  arch/arm64/mm/contpte.c           |  3 +-
>  arch/arm64/mm/fault.c             |  2 +-
>  include/linux/huge_mm.h           |  2 +-
>  include/linux/pgtable.h           |  4 ++
>  mm/huge_memory.c                  | 33 ++++++++++------
>  mm/internal.h                     |  2 +-
>  mm/memory.c                       | 62 +++++++++++++++++++++++--------
>  9 files changed, 140 insertions(+), 38 deletions(-)

Hi, Andrew and Catalin,

This patchset needs to be merged across trees.  [1/2] is a mm change,
[2/2] is an arm64 change, and [2/2] depends on [1/2].  Because the
user-visible change is in arm64, I think it may be slightly better to
merge the patchset through the arm64 tree.  The opposite way works for
me too.  If you were OK with the patchset itself, which way do you
prefer?

---
Best Regards,
Huang, Ying

