Return-Path: <linux-kernel+bounces-834452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07943BA4B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3587740028
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5733081A6;
	Fri, 26 Sep 2025 16:56:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3F31C32FF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905786; cv=none; b=lxV/ueozzlDFnn9WRb+OSE0kWIG8eP8qh1ZwusqQfUcwgfZu4V3mlRo10JpdZM0upOk6Ji5OmHJ4lY2G6VGTgia7czv3tg3rYCi1ctxN/gTxXjU1e+Sjm2yRLQC7UwomFjM2IWNcee8kxn1GL3mJ7JT7z1FY4maXTndaCOfQyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905786; c=relaxed/simple;
	bh=E3+lOENMQf8cdkmZll4NY0yIBx9zFzHOB3c4+aNdYV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAMMy37wSngNw7Rq3rL7/ybgmken3RZY8qeWCXXwHIeO8VT4ArtavsWVjh6S1V8P/WXX53ZsAR0Qc0iyKUQ1jeD2vp/wzoY0HqTvcY4MNhKFD22DEQM2VAJ3iyfXsXYhuJ7oRtVdxLnfSBtTTnGhXGL7d2K8PPRVhxdgeYfKR4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E69C4CEF4;
	Fri, 26 Sep 2025 16:56:23 +0000 (UTC)
Date: Fri, 26 Sep 2025 17:56:21 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Yang Shi <yang@os.amperecomputing.com>, muchun.song@linux.dev,
	osalvador@suse.de, david@redhat.com, akpm@linux-foundation.org,
	will@kernel.org, carl@os.amperecomputing.com, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: hugetlb: avoid soft lockup when mprotect with
 PROT_MTE
Message-ID: <aNbFtaVr8f2klqdD@arm.com>
References: <20250926162034.1785899-1-yang@os.amperecomputing.com>
 <1038c7c7-81d6-f273-6fa1-93eb7206d5ed@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1038c7c7-81d6-f273-6fa1-93eb7206d5ed@gentwo.org>

On Fri, Sep 26, 2025 at 09:29:54AM -0700, Christoph Lameter (Ampere) wrote:
> On Fri, 26 Sep 2025, Yang Shi wrote:
> > When calling mprotect() with PROT_MTE, kernel will initialize MTE tags
> > for every single page in the affected area. Soft lockup was observed
> > when doing this for large HugeTLB memory area in our customer's workload
> > (~300GB memory):
> 
> AFAICT this is a bug fix. The hugetlb path should be doing a
> cond_resched() like the base page code does.
> 
> It is not MTE specific. If other processing takes a long time in the loop
> (setting up terabyte size mappings for hugetlb for example) then the
> softlockup could also be triggered on non MTE workloads.

Yeah, with MTE set_huge_pte_at() isn't just setting a pte but also
clearing the tags. So it can take considerable time.

The fix is indeed not related to MTE, so I don't think the Fixes tag
should mention MTE (but I'm fine with a cc stable). Let's say we change
a hugetlb from RW to RX and have to do cache maintenance, we'd trigger a
similar soft lockup, depending on how fast the system is.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

