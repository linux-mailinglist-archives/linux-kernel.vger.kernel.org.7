Return-Path: <linux-kernel+bounces-767259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E8EB251FC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E491B62537
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731971F5413;
	Wed, 13 Aug 2025 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ii8UnpkR"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A804B303CA6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755105562; cv=none; b=dBd/+1vYTNVX9PExnuCwH64qMshb4Lb3Otp26t7jmZfS9oxrBANAVm9EZuzyNAFJvG+e5iLJ5BGBYD8cyHedPF3QCGK+uS6I4WN3vYP2qrZtDncE/JYhHPajWKyOkrt8mXduAN4zpyvjm62eCjYYm03RqffUxLBRneRU6PZyIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755105562; c=relaxed/simple;
	bh=tlmB5ALZT6K1dJVjXBcEODJRpdYWGeYicDb71U/5IAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/LD6mKWdKrFaVpILUM5wjuXASRluYcZFGRPz5NN4HfDvbPVm/uIqMdVLiueaMm4IMmYDleSYoQ9L3MOa+WCnVigeVJ/W4n+b/SUfYU7Bs5vADfEmkwkcRRTmjd98W6McYtyWv8NlA2xXJsO2R6EMDw82afYJ8UNW5R85gSh/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ii8UnpkR; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 13 Aug 2025 10:19:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755105548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1FMi5Yjh1vUlhiqB6XzBhiLfGu5kDDG1EY0MWpuA5g=;
	b=Ii8UnpkRn8GihHXCP3Zq/SnAvVnE3OovoucrWBxYKSrTGYHiRfkf7u46SHtP2x/y6SCoro
	BozREqc2qerr7Q53CpI5AuORNpsev64h/KoMeh2oV7YBavBw/Kz5ZKYVLvJgrWZ0RXtEuK
	7F9Xcs4/yQq3uyzkP/U8Sms1fCzUvgU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] memcg: Optimize exit to user space
Message-ID: <hzvjjgzf4cdvj56zeysosb7otkvplbbozzcpij2yeka4a4kakl@4l26obz3karf>
References: <87tt2b6zgs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt2b6zgs.ffs@tglx>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 13, 2025 at 04:57:55PM +0200, Thomas Gleixner wrote:
> memcg uses TIF_NOTIFY_RESUME to handle reclaiming on exit to user
> space. TIF_NOTIFY_RESUME is a multiplexing TIF bit, which is utilized by
> other entities as well.
> 
> This results in a unconditional mem_cgroup_handle_over_high() call for
> every invocation of resume_user_mode_work(), which is a pointless
> exercise as most of the time there is no reclaim work to do.
> 
> Especially since RSEQ is used by glibc, TIF_NOTIFY_RESUME is raised
> quite frequently and the empty calls show up in exit path profiling.
> 
> Optimize this by doing a quick check of the reclaim condition before
> invoking it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Muchun Song <muchun.song@linux.dev>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Since this is seen in profiling data and it is simple enough, I think it
is worth backporting to stable trees as well.

In the followup cleanup, we can remove the (!nr_pages) check inside
__mem_cgroup_handle_over_high() as well.


