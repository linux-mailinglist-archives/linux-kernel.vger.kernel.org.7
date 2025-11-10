Return-Path: <linux-kernel+bounces-894297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE3FC49B4B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 970684EB511
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB801B0413;
	Mon, 10 Nov 2025 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="LWvVrsUR"
Received: from r3-23.sinamail.sina.com.cn (r3-23.sinamail.sina.com.cn [202.108.3.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784242F0C7C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816082; cv=none; b=L1nomqjIERhHkg/xxz/zqJGHRAsxCkiC6x61ybttPssEXxnJsqoGsvUZaRr9fL+vyh/RjiWq0TvqmBEJTFYLj/NVW8hPUX3SYvenrp2SctIS0dAFcssGu+ZvySAKS6wpk1T5tfB2YEyrMiQvD3H8y5nBI7/Nwg4JRzkj0DoxTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816082; c=relaxed/simple;
	bh=laL2LgAPLr8CQswa6AsMYbjaff6SHRYL6gSFKkkejME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuLaasHLjlXc8wp2w2y5qx+6FN8wUfGYctHO3mK1/o4Vn+cGXoDGY1GCjO06zwKAvWFZL4ItHirx6UdK8Iaqv5oTDId54pADeYlguWddaRBNZkTrGik9AFt9JOadfM4fvdNT/DojaMwGvvE2rQU4Wtf6QHAx8fIbDA21/o3D5BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=LWvVrsUR; arc=none smtp.client-ip=202.108.3.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1762816077;
	bh=6J2qsI+c35WtaOkxN/9+MAOp0J/opKX9W2NtQHW3OuY=;
	h=From:Subject:Date:Message-ID;
	b=LWvVrsURRja10KVOh1Gu9vJd1prkOPBrYw2k2GyA9ZX/5MwWOJYMR3dpAY6f/D55f
	 r1mhI4xNovemi2kPP6yJ6aJESQEkF/w5fxyN82okapApHdVhsFu6eReFkjqpsr+k/+
	 uniisMQpJTNbBvTUkkR3E5NnPHLQpj9wcibdINYM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.31) with ESMTP
	id 69127048000031B3; Mon, 11 Nov 2025 07:07:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7443926816316
X-SMAIL-UIID: 4FF7BC97C0A44A949683DE4B3C1BD111-20251111-070754-1
From: Hillf Danton <hdanton@sina.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/1] mm/hugetlb: fix possible deadlocks in hugetlb VMA unmap paths
Date: Tue, 11 Nov 2025 07:07:43 +0800
Message-ID: <20251110230745.9105-1-hdanton@sina.com>
In-Reply-To: <bfe5a925-69ce-46af-a720-14e1d2fd30b5@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 11 Nov 2025 00:39:29 +0800 Lance Yang wrote:
> On 2025/11/10 20:17, Harry Yoo wrote:
> > On Mon, Nov 10, 2025 at 07:15:53PM +0800, Lance Yang wrote:
> >> From: Lance Yang <lance.yang@linux.dev>
> >>
> >> The hugetlb VMA unmap path contains several potential deadlocks, as
> >> reported by syzbot. These deadlocks occur in __hugetlb_zap_begin(),
> >> move_hugetlb_page_tables(), and the retry path of
> >> hugetlb_unmap_file_folio() (affecting remove_inode_hugepages() and
> >> unmap_vmas()), where vma_lock is acquired before i_mmap_lock. This lock
> >> ordering conflicts with other paths like hugetlb_fault(), which establish
> >> the correct dependency as i_mmap_lock -> vma_lock.
> >>
> >> Possible unsafe locking scenario:
> >>
> >> CPU0                                 CPU1
> >> ----                                 ----
> >> lock(&vma_lock->rw_sema);
> >>                                       lock(&i_mmap_lock);
> >>                                       lock(&vma_lock->rw_sema);
> >> lock(&i_mmap_lock);
> >>
> >> Resolve the circular dependencies reported by syzbot across multiple call
> >> chains by reordering the locks in all conflicting paths to consistently
> >> follow the established i_mmap_lock -> vma_lock order.
> > 
> > But mm/rmap.c says:
> >> * hugetlbfs PageHuge() take locks in this order:
> >> *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
> >> *     vma_lock (hugetlb specific lock for pmd_sharing)
> >> *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
> >> *         folio_lock
> >> */
> 
> Thanks! You are right, I was mistaken ...
> 
> > 
> > I think the commit message should explain why the locking order described
> > above is incorrect (or when it became incorrect) and fix the comment?
> 
> I think the locking order documented in mm/rmap.c (vma_lock -> i_mmap_lock)
> is indeed the correct one to follow.
> 
> This fix has it backwards then. I'll rework it to fix the actual violations.
>
Break a leg, better after taking a look at ffa1e7ada456 ("block: Make
request_queue lockdep splats show up earlier")

