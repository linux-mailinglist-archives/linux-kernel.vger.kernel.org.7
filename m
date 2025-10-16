Return-Path: <linux-kernel+bounces-856777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 760B4BE50AF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 613084EACFA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A42E2264CA;
	Thu, 16 Oct 2025 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rzgp548D"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1B7464
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638978; cv=none; b=MJEbDPcmzgz0jnYRHRV2dILGIpPogmn/A/Y0Z3kT+2BC6v90MLnOV1s1s6zHJo8xz1gl3ii86U2Dv2F5cBoQ6YPam+auMhgofjkW59IMBQcnFAnqHZ6yoh3s1U1WI0VfCNUNApdREW9f8Ko4RSZWjMmLrnHHhJYmAX8UL8rmk2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638978; c=relaxed/simple;
	bh=DYXWivWc8Cqk612vPBr1sSLB56g+GU6w0EQJpiN7GSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fM2lKCrxqVlbeoqQ2bx00Mtgidp4Ghhzi8HV2Wytxqxu76y9B1Ujx/zgNapH6P0YF6hqCW9F17CQykaez6uQpNqPXrOfu4mj1NrNo0nA4utXx2ZikYjCs54Wh9IZQXoWnz8VB6T3+CEM8SbqB29CKQWJiLtUgHtnpF0NpSmdmBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rzgp548D; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0hYYv/LwA1GURrWhGh2MDAllNLGQ7zQ8O8L85h5N1Cg=; b=Rzgp548D+FBSB43kwyHxqonghH
	42O4W2Z8TY77zuQ9poKmtvJObgCWVNT3JfIjesTFpvm/ShNqIvGnHC77bY09mhQ87U2VKDQSIdHyZ
	78ZXZYduDtDxyQGi3hQOWhD/q8yqr4SnTUzqMJ07rdZLesOVAz2L6EU7tBO1cBuFHPa2qIP3MLqcu
	XJCMmNGPDaKSSYP8Rw0tfLh7qXFKQ82fuVLdJnSggVOhDZd0jGX+5/1BSjSHBI1TNe+gDY3cYhsNX
	O2G6GCXwBDfX7s/3sXay9XEas3Y4+p9GGp0hxcVEXUwmYI0sX/tHSk7nBMmD3rD+Vl/Su7AUjYLDq
	waLsZxnw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9ScS-00000009YoF-2lgw;
	Thu, 16 Oct 2025 18:22:32 +0000
Date: Thu, 16 Oct 2025 19:22:32 +0100
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
Subject: Re: [PATCH RFC 1/2] pgtable: add pte_clrhuge() implementation for
 arm64 and riscv
Message-ID: <aPE36PlriswJWSKD@casper.infradead.org>
References: <20251016112704.179280-1-yintirui@huawei.com>
 <20251016112704.179280-2-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016112704.179280-2-yintirui@huawei.com>

On Thu, Oct 16, 2025 at 07:27:03PM +0800, Yin Tirui wrote:
> Add pte_clrhuge() helper function for architectures that enable
> ARCH_SUPPORTS_HUGE_PFNMAP to clear huge page attributes from PTE
> entries.

I really would prefer to see pte_clrhuge() removed first.  Otherwise
this just goes onto the long list of "somebody should clean this up some
day" and nobody ever will.

