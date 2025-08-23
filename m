Return-Path: <linux-kernel+bounces-783182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DCCB32A7B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2BC586EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E9120297E;
	Sat, 23 Aug 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KMXPpxTQ"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41944481DD;
	Sat, 23 Aug 2025 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755965301; cv=none; b=oEGKC7IWuve3+mXNmd29i7hwKbrGXF1lSsvBAdBZwLnYgqssJjVsQxIT8JE10UT4mRamsCGM1z6MjKs5tf8k57kL1vHmfY5O1GpLccfizuofa1rX9V7A7oDRv/NyGgFge1J5uk38urDcB44jEc+pMKeNGWa2oHBGwAQfKbEg4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755965301; c=relaxed/simple;
	bh=71ZM71aMCaP3obzFQaXtGyIe0i13c/qjaCLtECLyycg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaAM6vaDSJ+kf/alCHYsvQ9f9xYzFV4J+2cHbXEw/b+FDLzsl19CiDEuhLe5vFZlun8NuquTgufAXHSjpUq62g6fn+ZB7ngy/Y7SW6X7tTLd2Kjf/jMLlpcA3M2iPV+YcZF0Igb4H9bE8Ol7qrFCZsRuEUy6H0hlmNHz2diPPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KMXPpxTQ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 Aug 2025 12:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755965285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5EP4VlWoyAxZL5RZGxy1hvzJtGDefYV66QZqu9u66iE=;
	b=KMXPpxTQII9TbKU0mFprM6ZaF5s9BmRvzoYJBtBZbPhnOmFbeiSbIA+iiCXiVWAwKZcaHs
	4RZJUWKXrUX/NSmWlaPmpHy+CrJ4PF5wPZgvcFyQv+2Adjd9Ny2mV1sytoLtZj6FaUVI8c
	VU668Pte4WC+GQgVVDweGBAUmymmDkc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sahil <chandna.linuxkernel@gmail.com>
Cc: corbet@lwn.net, rdunlap@infradead.org, linux-bcachefs@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: bcachefs: fix typo in idle_work documentation
Message-ID: <t4k2mqzg5mxhx2ccci7x4w3jjuwwivuv4canl3yr6g5dcayaxt@5lfesxl6uqpi>
References: <20250822223416.23345-1-chandna.linuxkernel@gmail.com>
 <c9cbd06a-9564-452b-bf05-8bfa83b81aa2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9cbd06a-9564-452b-bf05-8bfa83b81aa2@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 23, 2025 at 05:05:33PM +0530, Sahil wrote:
> Fix minor spelling mistake in idle_work:
> 
> - heirarchy -> hierarchy
> 
> Changes in v2:
> - Dropped cgroup, idle changes (already being fixed)
> - Dropped xfs changes (already fixed)
> - Only keep bcachefs doc fix
> 
> Link: https://lore.kernel.org/linux-doc/23de3jgp44vih5g6hjgc2ji6momi5t3w7rfkm5mgtajicbbg7a@7r5hgt5e7eir/
> Based on v6.17-rc2.

please rebase here:
https://evilpiepirate.org/git/bcachefs.git

> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
> ---
> Documentation/filesystems/bcachefs/future/idle_work.rst | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/bcachefs/future/idle_work.rst
> b/Documentation/filesystems/bcachefs/future/idle_work.rst
> index 59a332509dcd..f1202113dde0 100644
> --- a/Documentation/filesystems/bcachefs/future/idle_work.rst
> +++ b/Documentation/filesystems/bcachefs/future/idle_work.rst
> @@ -11,10 +11,10 @@ idle" so the system can go to sleep. We don't want to be
> dribbling out
> background work while the system should be idle.
> The complicating factor is that there are a number of background tasks,
> which
> -form a heirarchy (or a digraph, depending on how you divide it up) - one
> +form a hierarchy (or a digraph, depending on how you divide it up) - one
> background task may generate work for another.
> -Thus proper idle detection needs to model this heirarchy.
> +Thus proper idle detection needs to model this hierarchy.
> - Foreground writes
> - Page cache writeback
> @@ -51,7 +51,7 @@ IDLE REGIME
> When the system becomes idle, we should start flushing our pending work
> quicker so the system can go to sleep.
> -Note that the definition of "idle" depends on where in the heirarchy a task
> +Note that the definition of "idle" depends on where in the hierarchy a task
> is - a task should start flushing work more quickly when the task above it
> has
> stopped generating new work.
> 
> -- 
> 2.34.1
> 

