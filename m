Return-Path: <linux-kernel+bounces-579040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00EAA73F13
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 20:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB7D3B6DCF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Mar 2025 19:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A1A18FC84;
	Thu, 27 Mar 2025 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NQiSwXD4"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3161A76035
	for <linux-kernel@vger.kernel.org>; Thu, 27 Mar 2025 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104844; cv=none; b=LB5ZInC8LJLQNcJCqo62W+GiXBfKPKT7RSj1WhgazLVkWsl6f4Xewb6bHNLOIyAvQ3bBgCNzFqPINyOejLXBmWyIzpm4d8GN9DVnBk2JDier5l6XIbjYqXusX5pDXQ1KtZ/fz6z/gOowLesMV18M87i67PiydWy6bjgDMnBOFRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104844; c=relaxed/simple;
	bh=JlC2gHCw+8MGXjZ6W/LP52zt1zrM6G+eZzEKbugCaQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izpDCNRP9F/uGoVETVlpaGZoFnbTIw14nOgkhZZkRPvxo+WgkG/VVtvPmoKpN6AzXHloXrTth+csyNQ8k1h1ZUfFxzY2On9yS2tu213tWsj1BEsstFlmsD8YUtAXKETMxNgSvWeDdJnUTv0oG2YceXjWSIThKYJYIXBAmiaR2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NQiSwXD4; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Mar 2025 15:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743104837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ua+2XTJbjfYYpVjP8YCjxEQGmfQkkTUtH1bVwBILcqc=;
	b=NQiSwXD4oBJRP4j3k/vtElhzkc563VRKlN3NDdQ8LigLF0LUWE10O1puA0gJx1DU8QKdlZ
	s/4hxo4bB7X5/xj9DrGWYeE9WA+WMooBpS366uxavpuX475g8UJdndcYrVXW03G1ajzPD+
	bVEXACN87O09EuC2oa2cEPFIf0MnEGA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: Re: [PATCH] lib/sort.c: Add _nonatomic() variants with cond_resched()
Message-ID: <novak4bihej44g63emwr6aohnnv3737ssbbbeldq2tqwmbf65n@j3fh7vsg77z5>
References: <20250326152606.2594920-1-kent.overstreet@linux.dev>
 <20250327110923.41e281e75fcf5b1152a55a64@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327110923.41e281e75fcf5b1152a55a64@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 27, 2025 at 11:09:23AM -0700, Andrew Morton wrote:
> On Wed, 26 Mar 2025 11:26:06 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:
> 
> > bcachefs calls sort() during recovery to sort all keys it found in the
> > journal, and this may be very large - gigabytes on large machines.
> > 
> > This has been causing "task blocked" warnings, so needs a
> > cond_resched().
> 
> I assume this has been happening for a while, so a cc:stable is appropriate?

Well, right now I'm only doing backports for the most critical stuff,
and this doesn't meet that bar. I'm planning on doing normal backports
after I take the experimental label off, in at most another year.

And I've told the stable team I don't want them touching fs/bcachefs/, I
want to be doing those backports and running them through my normal QA
process. We could for this, but perhaps better not to let the process
get confused :)

