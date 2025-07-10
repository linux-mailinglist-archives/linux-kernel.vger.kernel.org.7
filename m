Return-Path: <linux-kernel+bounces-726352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC64B00C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1788E3AFB19
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12AE2FD59E;
	Thu, 10 Jul 2025 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DyVdBLuS"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB31DFE1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176610; cv=none; b=DpuGS4iHcgj7oswL0ROqaA5b5M+QsleVZGj8t4FNmlr9WnkkHmbV/wZ5/fPQOaz/ZjhXeifhi7FGuVBRHzKelUbReMgqfn/uB7GuGcLCvD/0mKvZdCUrtZMEvpaYs202M18Lx+XBWK0DW8ccwFco/h/bn45E//DCj1d1irZl7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176610; c=relaxed/simple;
	bh=Qa/KdK8rXB0uARObJKtgyfABrvIYkDUUDlVIevyWCOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFDg+c/BQORC4x8M8PAFQsvSz0dAtQZn7M7eornCkPBVVfG9Fgx4FyyQn2JEeQdo5LKRhl8//xWXbmgZkL1fpL60wck86+EpuahDVxPhnCyxar/c8fcVGx8cIwqWBWqc5won3TNfDPYtgZHKQIj3tWLjPRFsEKb7q2MyKqXXHvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DyVdBLuS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AUh6rPaAYLbvye1HdwjcG/2teeW57yG0VBgHYsKR4cs=; b=DyVdBLuSr1b0TpTqTkKfMEicAb
	gnJg0NdJTsgZGbDmv40/n2Tm+JppfrEFHeByErh3bN2/jZc3+n5wv3pnivFi4RBoiqLEJj59Jmtex
	v0dakO7Ou8wu0fM+v8M363t311KtoXcUQSH+MltFg/bw+4dvsV24/wxAz48n1kZfcNKligm+0b4T5
	BkVL02iBwlbIaM4G7V+62CU1Xm52rZ9FKTQzHqcdTfJOXZbyCiye8bb+Jk0c+LmJ0b8x7O+IZlvkW
	q/NjS1vufnI9QHV73XvRro+yn5Pzps7Fp7bDxGlTbd+PD/2UpIwtQw99ak4htTkwflYYLWqNdosJe
	VewM7sAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZxAx-0000000A94d-35wv;
	Thu, 10 Jul 2025 19:43:23 +0000
Date: Thu, 10 Jul 2025 20:43:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: Re: [PATCH v2] mm: zswap: add myself back to MAINTAINERS
Message-ID: <aHAX25rbbwhziWc0@casper.infradead.org>
References: <20250710191818.1429309-1-vitaly.wool@konsulko.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710191818.1429309-1-vitaly.wool@konsulko.se>

On Thu, Jul 10, 2025 at 09:18:18PM +0200, Vitaly Wool wrote:
> It's been a while since I was one of zswap mainainers but nevertheless
> I'd like to get back on board. There are some things in the pipeline
> related to zswap/zpool and Rust integration that I'd like to submit in
> close future and maintain thereafter.

We don't really need four maintainers for zswap.  You can contribute
without being listed in MAINTAINERS!

