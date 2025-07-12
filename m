Return-Path: <linux-kernel+bounces-728620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43669B02AE3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 14:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD53A62DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 12:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17784275AF1;
	Sat, 12 Jul 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HU9nk8Pl"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59681E
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752325069; cv=none; b=L5ZYMiB7O228EfvLEdhO8BIC7O5bXac65fNRTvXuQn/Ki0QwXCaol37iGJPm2rZf81IpAaH60Njh0jf/lagGmBWeBen4FA+yRLxdcPYbQ8c/oLBvR4xSQ53mqQR57URZi0cHUL+xLgOXOSl17l0RQqpWjFMbb/VCGXSkGDEtigA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752325069; c=relaxed/simple;
	bh=8bS4UYr3l9WBkgw+x3LKq/gxxx5Z7hIDlxrvtzw6Z5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiH+t0ScqW/pT0+V5demk2+DAZIuLvwMXYIx33B+PxXQBmGSp7r0qdu6oLM9t0+cqhMalma5u1MXeZQuQ8G87vWx8bkWY4/M6fj/2p5UhUnAViXgJVYPsemvRg5l+rtgqX4R2EAt+Ma1P/AxirH9n1KevIBUa6ZIo073Odxu+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HU9nk8Pl; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 12 Jul 2025 08:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752325063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qTv9ah9t4h6oUdT9A789T2hnOTNgS9LvHpI6S8hxVbw=;
	b=HU9nk8PlIt0Ta7EANFGfn6lUjjbynF3tYrp9GiFZW3SHg/dTtlVn+Mz6dL04xApslFmXjm
	wZXCSjd3v73/DnykGKnccxnxFTFdQbzs2p3Lhv/fA/vaquXHVGe2G8eKsN7vdHfLx8R641
	NPe+W/gkXRhR5filgs+9qHcKGtt7SVw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc6
Message-ID: <myc76cllhaignqti4pheqyp7paxkwe3fkzfldesvb6xfl6cbxf@kdi3asjcafzi>
References: <hmihnrl4tzezjnhp56c7eipq5ntgyadvy6uyfxgytenqfbzzov@swfpjfb2qkw5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hmihnrl4tzezjnhp56c7eipq5ntgyadvy6uyfxgytenqfbzzov@swfpjfb2qkw5>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 11, 2025 at 09:01:48AM -0400, Kent Overstreet wrote:
> 
> The following changes since commit 94426e4201fbb1c5ea4a697eb62a8b7cd7dfccbf:
> 
>   bcachefs: opts.casefold_disabled (2025-07-01 19:33:46 -0400)
> 
> are available in the Git repository at:
> 
>   git://evilpiepirate.org/bcachefs.git tags/bcachefs-2025-07-11
> 
> for you to fetch changes up to fec5e6f97dae5fbd628c444148b77728eae3bb93:
> 
>   bcachefs: Don't set BCH_FS_error on transaction restart (2025-07-08 15:24:15 -0400)
> 
> ----------------------------------------------------------------
> bcachefs fixes for 6.16-rc6

These are fixes for some high severity 6.16 regressions.

