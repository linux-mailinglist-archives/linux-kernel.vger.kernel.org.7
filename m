Return-Path: <linux-kernel+bounces-780275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED22FB2FFB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB6418842D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E826529BDB9;
	Thu, 21 Aug 2025 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pSvfK21o"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDB72E1EF0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755792574; cv=none; b=NtF6YkircMcnqQE9IY754QaMJKN+abuMoFeoU8J3wZkNNYiuBau8FRq+RW0TDO7ppiALSsa7kDvI5LHtZPuValh1pp0a3PRFe0oHc/1VRgblof4M7cjIV4FfwXYEw1PPjco+MPheTYuQJPJYv/m+uLByU+voPNlihPMJW72nE/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755792574; c=relaxed/simple;
	bh=6WjcSP6SOFTt6Yu67V6Wv3TS+KrfNiKNYqKA4b4phW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiifWCrm0XQnE+yNQuKEaTWrH9kShb02I/y6jeH/2ZDjPk4NVRJuz5gdvr3ZP013rj0UeIVlDOLFzNaxIbb+8iEzwZD6mVtdzR2SLX3pi9uK6bwiqr1kLibk385NlwG4Dmvcn2AaxtrEjTK1fvHcEGvvmop5RyeOl91fpO8IO4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pSvfK21o; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Aug 2025 12:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755792570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LWps1BVOFzJixHZTrp3fOYbUvOGqY5I9MFzq6N8LXt4=;
	b=pSvfK21oVCgvO4FQR3/LQzQWy8T7T4y0UKEIyteQnH3P9PdSrogY2/roxuua0QGPVzsUBc
	BexcYvgYEMa0kbgAwVq+9KJlohNThkJT68E8V3hhCx40n0mVIgRRouOjxEXmkswacvSijL
	UE9OHb6Ld9YcXlsObVx2YUmca09mtUc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux bcachefs <linux-bcachefs@vger.kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation: bcachefs: Add explicit title for idle
 work design doc
Message-ID: <hsvtot4ds63jktba7chymx4d5qs4cbmnwakf6elornrlj53lmk@lld5rgm7rcbp>
References: <20250821004620.10772-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821004620.10772-2-bagasdotme@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 21, 2025 at 07:46:21AM +0700, Bagas Sanjaya wrote:
> Commit 9e260e4590e044 ("docs: bcachefs: idle work scheduling design
> doc") adds design doc for idle work scheduling, but misses explicit
> title heading, causing its two section headings to be toctree entries
> instead.
> 
> Add the title.
> 
> Fixes: 9e260e4590e0 ("docs: bcachefs: idle work scheduling design doc")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Applied

> ---
> Changes since v1 [1]:
> 
>   * Keep original "design doc" title (Kent)
> 
> [1]: https://lore.kernel.org/linux-doc/20250820002218.11547-1-bagasdotme@gmail.com/
> 
>  Documentation/filesystems/bcachefs/future/idle_work.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/bcachefs/future/idle_work.rst b/Documentation/filesystems/bcachefs/future/idle_work.rst
> index 59a332509dcd97..8519fdcaa5ff49 100644
> --- a/Documentation/filesystems/bcachefs/future/idle_work.rst
> +++ b/Documentation/filesystems/bcachefs/future/idle_work.rst
> @@ -1,4 +1,5 @@
> -Idle/background work classes design doc:
> +Idle/background work classes design doc
> +=======================================
>  
>  Right now, our behaviour at idle isn't ideal, it was designed for servers that
>  would be under sustained load, to keep pending work at a "medium" level, to
> 
> base-commit: 37c52167b007d9d0bb8c5ed53dd6efc4969a1356
> -- 
> An old man doll... just what I always wanted! - Clara
> 

