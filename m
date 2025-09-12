Return-Path: <linux-kernel+bounces-814597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B00B5563D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 20:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11932B631CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F50C32ED28;
	Fri, 12 Sep 2025 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MidjlJte"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD5266B40
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757701997; cv=none; b=Y4qmb0j7fkPIdwTSHtxzw4jXaSdmifbXuB7b24EGI0W2BTryOFWSZHEt9VQHqtCxAWIaR5L9yCh/zgqS3sIIdlQ9O0TPnBWH4VQNL8oFCnvvJQxYPVturrI2avbfMaPs8nC9x8O0bAPopDo95K4oxE4R4jdwUnfdo0X0a/iZhjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757701997; c=relaxed/simple;
	bh=KFlEUjBcWRsH4OTEaeOYJL8eDKrrcCJBALa8neJYRtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMONxCzv3OlphrzGjlwwc2RnaX1GJCgZEtb7aOyqmQPLOcohhbPPGsxpB6FJPZNs5GkgUeFXT0flfxS78kjt8bD+T3HDQoCgxMwAtg2X3Cm5AtR8E45Z9ByGwHc0XozHIB30BhQA36o0XDyrMdBSZTY9MW2dOVtXeybx2mLrnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MidjlJte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C56C4CEF1;
	Fri, 12 Sep 2025 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757701997;
	bh=KFlEUjBcWRsH4OTEaeOYJL8eDKrrcCJBALa8neJYRtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MidjlJtel7Cp/T9/t/kG+eRWK8OX8Bktd9X2t5+mf5Nxm8WSjzBE3ajxlLKHEH5HO
	 gA89BQNsNJYzWRV8ui0JzIU0bptIMIqv8PJK/fs/tgFttaRWXBox8emJ7hkZB1VzcO
	 6N5IlYHGCobFVhQUTEpe+8lQpPckEtozqsDX0M1FS6AARjyzw62J4WX/ulUWIkFqoh
	 T/9nEizFyDP79mlC1EDi8W74avUydLBmjNhv+Qg7ShJewUTFZVOSopzgOnYqTL8EJI
	 MCw8nfedCpbCT2ndHVTM48T13luMlojGZ6z3FjteNdacd4d9aSYTFCRsElqRpc4SvJ
	 l1QI4kNahO12g==
Date: Fri, 12 Sep 2025 15:33:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
	akpm@linux-foundation.org, david@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
	namhyung@kernel.org, tglx@linutronix.de, willy@infradead.org,
	raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v6 00/15] mm: folio_zero_user: clear contiguous pages
Message-ID: <aMRnarU3w_XykRHG@x1>
References: <20250902080816.3715913-1-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902080816.3715913-1-ankur.a.arora@oracle.com>

On Tue, Sep 02, 2025 at 01:08:01AM -0700, Ankur Arora wrote:
> This series adds clearing of contiguous page ranges for hugepages,
> improving on the current page-at-a-time approach in two ways:
> 
>  - amortizes the per-page setup cost over a larger extent
> 
>  - when using string instructions, exposes the real region size
>    to the processor.
> 
> A processor could use a knowledge of the extent to optimize the
> clearing.  AMD Zen uarchs, as an example, elide allocation of
> cachelines for regions larger than L3-size.
> 
> Demand faulting a 64GB region shows performance improvements:
> 
>  $ perf bench mem map -p $pg-sz -f demand -s 64GB -l 5

So, can I go ahead and pull the tools/perf/ bits into perf-tools-next,
Namhyung already reviewed it, the rest can go thru the relevant
channels, ok?

- Arnaldo

