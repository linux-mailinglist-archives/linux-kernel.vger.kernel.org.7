Return-Path: <linux-kernel+bounces-841947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A7DBB899A
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 06:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8726B4EA0CB
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 04:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F32A221F06;
	Sat,  4 Oct 2025 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EaTmq6uv"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049722173A
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 04:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759552649; cv=none; b=FliOadODgybbSt4fM12OPFQmGkAs1ijKZvZ/NebkGtFrKKvXuEryfyXDFnXdogtuFQ3Bb6CSyd6cEjFFoBGBxxsaF3Ecw/W3sN8og9tDpgxKn6EiI9v1MQq16E5K+AkbGBoxokXV5s/XtgSpcwLHGDzBIaYUIXPkCQE/RjuqmTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759552649; c=relaxed/simple;
	bh=C/XSjPJuRy8ewVWu6FsAPA2+zT++6o31XO5SvNt/WCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNuEgqlbGpv0Z1n0UCqVneiN18pDdN50/ewCm4cqS6CFZVTeVyfH8L2mFQ8oT5M3PLG01d9SAlgoWlF2TeQ8rNeFLQ4zd1/Y25xNcxinIT/oPiR5LMIW3OpqaTsf9f5GtW91RhzGgkC/5TCo3MPJGi8x3em8xzKdIbP9kjLeBoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EaTmq6uv; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 4 Oct 2025 00:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759552645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LQXIa5my2S5WHl5zClCiPmcNATxb8aXw0V+RBcNeqYI=;
	b=EaTmq6uvAh7JcvM4yAX9rwI+Z/zstR5qHR9NFzjJL8Iiy/17JA9yb/jA8s87ZyJq7JYtAC
	XCiylvHwXEkJIa+KGkS05VPB9c+IA5+Y6V54ZYFuHgP11IjdTBZCo9GkRh/iB2zSGiXqut
	Mfa2qLlrEVDOfaOQe1FYf6I64Hc0QTE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6/7] lib: Give XOR_BLOCKS, RAID6_PQ config opts names
Message-ID: <ri6hb5q3i4t5jdfahmyp5wox3fqlyndnu3vfpsiqr7zbci7j6f@un5xm2rcokld>
References: <20251004020049.918665-1-kent.overstreet@linux.dev>
 <20251004020049.918665-7-kent.overstreet@linux.dev>
 <aOCfLTDYR83WS2CB@infradead.org>
 <73o2borvbdhb7j35zigv5ua7vgjjtt4pohbb77eolflgp5q4zu@bawkl5ykytce>
 <aOCjWdfGG3QiT1QX@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOCjWdfGG3QiT1QX@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 03, 2025 at 09:32:25PM -0700, Christoph Hellwig wrote:
> On Sat, Oct 04, 2025 at 12:29:15AM -0400, Kent Overstreet wrote:
> > That's been the primary purpose of the lib/ kconfig menu. The current
> > language is no longer quite as explicit as it used to be, but here's a
> > recent example:
> 
> It's not the current kernel where this got fixed.  If you find others
> instances, we can fix them as well.

The current language is only slightly less explicit, but the underlying
purpose remains the same.

