Return-Path: <linux-kernel+bounces-829756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E434EB97BED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 00:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D45119C78DC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3003730FC31;
	Tue, 23 Sep 2025 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SojriKu2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C930F95E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758667171; cv=none; b=AUW2kUOAQIPsjtX6KMmiYKa2p9uPd4FOajSxRVofbAYJkZaRh0VpbvvlDrY+zW6XI0Cjvckt15nFq/xGYRXykn+1/cQ6ZnWQ3ZTBZPYAR9mWyVJGhjTmHpXczTm/Tvw65q8lXlllpGRS7R8l9rpBMeY25mClK7uEaEpOgicZUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758667171; c=relaxed/simple;
	bh=RfseB0dvf+4GiTABfqemCMetSCq0ew38AG2dgt/dwmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8wprNxg6bJdOY2SS6zmtaL+sLiTlTagYCNSPYe0pXqj6e2TMDCdecYkh0xuiRc6ndNgrV5tPKZulJH/gSYNXenHLf55X10who0hzV+3LMGGdhU3qrbjYKGk/5RcJHwSFWP/RDDd60//0KPFrz1/jCH1pQRkxwKTdL0GkRM0y1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SojriKu2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kMNRIy7juPEY6DIXxF9DZzfJvByV0E5yz461o/FuEmU=; b=SojriKu2ZEAiqDCZFCDQRhRKhn
	nKspnPTfBVKaUKc77OtjSxdvixl+GHzCJK/5nnDH122mvTIjGuaDBtfO2/vhms/1t4MnJvEPwrhjB
	SL/CfblZqb+J/Mg1qpXUiH8CIEeTs7RnM5SEdFEjpxScnHE1UEuvNZ37MUF2Idfeulhmd9iuFHN+X
	YneEJmmbwYFcgPkAR878Rq4Hy6K/em+73ZwEXsSrT8HKSJSfk8+IhYUuoVieViWI58YHUR7Ufjd3M
	/5l7MwBlIgT3Gk4OECBaBAUXXAeZup1SPEBlZdCDvKR6uwJtaxODOFfE3ZGINd6WxrnAwhB2zzg6Y
	5izeBW/g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Bf7-00000002lyS-1MIl;
	Tue, 23 Sep 2025 22:39:05 +0000
Date: Tue, 23 Sep 2025 23:39:05 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yin Tirui <yintirui@huawei.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	anshuman.khandual@arm.com, yangyicong@hisilicon.com,
	ardb@kernel.org, apopple@nvidia.com, samuel.holland@sifive.com,
	luxu.kernel@bytedance.com, abrestic@rivosinc.com,
	yongxuan.wang@sifive.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, wangkefeng.wang@huawei.com,
	chenjun102@huawei.com
Subject: Re: [PATCH RFC 2/2] mm: add PMD-level huge page support for
 remap_pfn_range()
Message-ID: <aNMhiZ4FiEE1Rk_T@casper.infradead.org>
References: <20250923133104.926672-1-yintirui@huawei.com>
 <20250923133104.926672-3-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923133104.926672-3-yintirui@huawei.com>

On Tue, Sep 23, 2025 at 09:31:04PM +0800, Yin Tirui wrote:
> +			entry = pte_clrhuge(pfn_pte(pmd_pfn(old_pmd), pmd_pgprot(old_pmd)));

This doesn't make sense.  And I'm not saying you got this wrong; I
suspect in terms of how things work today it's actually necessary.
But the way we handle this stuff is so insane.

pte_clrhuge() should not exist.  If we have a PTE, it can't have the
huge bit set, by definition (don't anybody mention hugetlbfs because
that is an entirely separate pile of broken horrors).  I understand what
you're trying to do here.  You want to construct a PTE that points to
the same address as the first page of the PMD and has the same
permissions.  But that *should* be written as:

	entry = pfn_pte(pmd_pfn(old_pmd), pmd_pgprot(old_pmd)));

right?  Now, pmd_pgprot() might or might not want to return the huge bit
set.  I'm not sure.  Perhaps you could have a look through and figure it
out.  But pfn_pte() should never return a PTE with the huge bit set.
So if it is set in the pgorot on entry, it should filter it out.

There are going to be consequences to this.  Maybe there's code
somewhere that relies on pfn_pte() returning a PTE with the huge bit
set.  Perhaps it's hugetlbfs.

But we have to start cleaning this garbage up.  I did some work with
e3981db444a0 and the commits leading up to that.  See
https://lkml.kernel.org/r/20250402181709.2386022-12-willy@infradead.org

I'd like pte_clrhuge() to be deleted from x86, not added to arm and
riscv.

