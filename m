Return-Path: <linux-kernel+bounces-727812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B157DB0200E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F7316E4FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4B22EA14A;
	Fri, 11 Jul 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R0SIim2t"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61917A2EB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246278; cv=none; b=f91SVqPa4EJ9lzY98eGXhEBoBI9Rgn4sl4a92BMYrtK+lbG3rikRm9TZjZ62j3vGhHnAneiJDxa8BUaaKvuAVwWneqswRa5FitgdGDnvGoiF+doGQ7iwV5XU0wN0m3LfnFhSGq79RrI+rlmokkue+CVbqu63YqS4i2UOrpLMMrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246278; c=relaxed/simple;
	bh=sptVGB6DgQD3qnPME2DWVdOTQi7/cZp5rHNhgTnn9m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owH4+jYIXsocX5+P2wJXsX7GBomNVCsv4z9hmA5082zVGPBKLxK7sxtQbESGPxUgKHYyKluFmlCnpo7vbHbKtlznLUhRRuEHcUWjlLpTrKzyeotcXfmSBDAVx6xK5NSgEK8M6GwfrInRWFuX+qYTr+0UB9UolB+3+2U9poiLJfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R0SIim2t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yu71VHZtCvYmyIc5rSzQql2XR6++fb6s65EY+IsIk0g=; b=R0SIim2tTQNZwiBVSFwO5tHiHN
	NkmEDH0W0pjOHmZrY7KB5lqmt9I9vTD+YJ9OmjCldUC1hbIyUmHlgFf/BqQxuOMQ+DH3AJ91+g2kB
	gdk/IJ3Q+Eq5DdbS3dOt6M6S48rDWvDI0ubGfE5BI7ampi3j3x23BHpqj8lWYVQ8iGTiqI6sYV2vS
	G8HHmA0X8spOfHMU0T+Ju8U1m/vz85XKlDG+EBV0nxaoou+ANNtQMAYVcZWOE6UtXnQhyy2QAy5r0
	fXmvw0QWLJlAv5UZaODYi9o8mjy7ejnnFgyDDKUQVBHOehESMMzRLX0OaQWyCxzVwqevHYjg8Rhip
	AKzpnuag==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaFIc-0000000DOlN-2ODH;
	Fri, 11 Jul 2025 15:04:30 +0000
Date: Fri, 11 Jul 2025 16:04:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, muchun.song@linux.dev, osalvador@suse.de,
	ziy@nvidia.com, vbabka@suse.cz
Subject: Re: [PATCH] mm/page_owner: convert set_page_owner_migrate_reason()
 to folios
Message-ID: <aHEn_rVeoJNYGz9F@casper.infradead.org>
References: <20250711145910.90135-1-sidhartha.kumar@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711145910.90135-1-sidhartha.kumar@oracle.com>

On Fri, Jul 11, 2025 at 10:59:10AM -0400, Sidhartha Kumar wrote:
> Both callers of set_page_owner_migrate_reason() use folios. Convert the
> function to take a folio directly and move the &folio->page conversion
> inside __set_page_owner_migrate_reason().
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

