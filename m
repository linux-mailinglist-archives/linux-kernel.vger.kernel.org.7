Return-Path: <linux-kernel+bounces-780728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2697CB3086A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFEEAA02E4C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB62C0261;
	Thu, 21 Aug 2025 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cKVa/0E1"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1032C026D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812113; cv=none; b=IZgvo5BuMWxHSMMJYeckvRvyuixrFd+Xn+1Im6wCo5KxR1uPjRPcodg/j90PzsGKsH3WSKpjh4cfgEKFyrV8MaTiQ5+h06U1F8mwkQiYzBOoDxzeTISZ01BMHmq3oVfGGNbWvLWbyMLQkRCT34eflfL9hScG7OI2X+0vTh3eDos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812113; c=relaxed/simple;
	bh=bAmN/AfX5lwIEYmHilniwpETgpxib6iulemfl4KOa1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwFJBU4Yld2VhgghloFhZdOxtKLkDZ+1OI2JF5ioponqbYAZOwfVgew3f4SCpwOLAuZ2uvtWnOTZayxQ47kc+7T0fHSJfuaLMm+seUuiHWOKJGuXTjnsJRwz2HKvNGUn1X9BmQer5zvv6qP5Gu63C2lfylZVR+RpxztgXOB+cJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cKVa/0E1; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 21 Aug 2025 17:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755812099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6l9aSgAb2E3cUwpa0ZqVYq3A36zEuUkKRZnMLOQjDf8=;
	b=cKVa/0E117buhr5K37hgJtj77Pc13bOzosQtOW8ViKUo5puIjXVou9iw13GGpUM01YbA2g
	9WYuRCTqBCClWY7v9v/iJHFJYU9SgNCws9F3lyh4TB3azy0TfEjV5kwHqRzpgmhHj/9b8B
	BLVZRZ8axbAUdLovgVvsMfxZ3JRdkak=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Sahil Chandna <chandna.linuxkernel@gmail.com>, corbet@lwn.net, 
	linux-doc@vger.kernel.org, tj@kernel.org, cem@kernel.org, linux-bcachefs@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org
Subject: Re: [PATCH] Documentation: Fix documentation typos
Message-ID: <23de3jgp44vih5g6hjgc2ji6momi5t3w7rfkm5mgtajicbbg7a@7r5hgt5e7eir>
References: <20250821185145.18944-1-chandna.linuxkernel@gmail.com>
 <4cae933a-d171-48aa-a854-b4323d10b347@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cae933a-d171-48aa-a854-b4323d10b347@infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Aug 21, 2025 at 12:09:57PM -0700, Randy Dunlap wrote:
> 
> 
> On 8/21/25 11:51 AM, Sahil Chandna wrote:
> > Fix several spelling mistakes in documentation:
> > 
> > - Availablity -> Availability
> > - heirarchy  -> hierarchy
> > - maping     -> mapping
> > Findings are based on v6.17-rc2.
> > 
> > Signed-off-by: Sahil Chandna <chandna.linuxkernel@gmail.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst                  | 2 +-
> >  Documentation/filesystems/bcachefs/future/idle_work.rst  | 6 +++---
> >  Documentation/filesystems/xfs/xfs-online-fsck-design.rst | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> > 
> 
> Looks good, although there was just another patch that also fixed the maping/mapping
> spelling for XFS.
> 
> And various maintainers might request that you split the patch up by
> subsystem/filesystem (i.e., 3 patches here) unless Jon merges it as is.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

I'll take the bcachefs patch if it's split up.

