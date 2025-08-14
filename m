Return-Path: <linux-kernel+bounces-769736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1FCB272EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 01:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47D214E5FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 23:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F2F2877C0;
	Thu, 14 Aug 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pONeTZiZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC23B248F4E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755213227; cv=none; b=MzG10Gk2+h6P/GDONdKYCitMICycrCG0sMFA20tOh0v4TkETVVgz+cEOjCi69B8y6K4qCvNq2Ydyc1Ab1xOq2ATiE6YKbW3Tzp3zQlLhtx1/Fw12j35juwLOIoKSazPU1lVJJPUpZGzRugRc07h6DkbdhFFf9yFsmnZUIeTov2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755213227; c=relaxed/simple;
	bh=QDuybNx730xQBT3wod57laf9u9iTM7rHjUvW1T2v/A8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DyjRVJ6cC7xG2F9bqe48EmROSGyCwQUh+5TzSJWIqVctJUyvVnNLoiPfIRBfyyleAwRAcfcuS2s/bqHs20618NFYxbrotEPDi8kJrhvIYouuSCrJwYGl2O3daQvIMrHRlhcnPoe/4iXXoJlDAZyX4SygEU8moOl73pk6ss+v5kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pONeTZiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602FEC4CEED;
	Thu, 14 Aug 2025 23:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755213227;
	bh=QDuybNx730xQBT3wod57laf9u9iTM7rHjUvW1T2v/A8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pONeTZiZjNbzBFiiZPEIM2iR6kPyC71xQPFcDNY7Xl5VTFDYMMwzfV6aeXw6EYmIg
	 QN8UhlLAm6z2zfYK+Y8bSzg1m19jWmKEVpgCJlyQdJvsXzxoziN2aShH1YGhk+Az5v
	 YwJI3SQFXeUZEUmPp3C4zuamATd1QhSAuH7/1bvc=
Date: Thu, 14 Aug 2025 16:13:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: <zhongjinji@honor.com>
Cc: <linux-mm@kvack.org>, <mhocko@suse.com>, <rientjes@google.com>,
 <shakeel.butt@linux.dev>, <npache@redhat.com>,
 <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
 <peterz@infradead.org>, <dvhart@infradead.org>, <dave@stgolabs.net>,
 <andrealmeid@igalia.com>, <liam.howlett@oracle.com>, <liulu.liu@honor.com>,
 <feng.han@honor.com>, Joel Savitz <jsavitz@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH v4 0/3] mm/oom_kill: Only delay OOM reaper for processes
 using robust futexes
Message-Id: <20250814161345.b2ddf7120dfcc420c3199e67@linux-foundation.org>
In-Reply-To: <20250814135555.17493-1-zhongjinji@honor.com>
References: <20250814135555.17493-1-zhongjinji@honor.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Aug 2025 21:55:52 +0800 <zhongjinji@honor.com> wrote:

> The OOM reaper quickly reclaims a process's memory when the system hits OOM,
> helping the system recover. Without the OOM reaper, if a process frozen by
> cgroup v1 is OOM killed, the victim's memory cannot be freed, leaving the
> system in a poor state. Even if the process is not frozen by cgroup v1,
> reclaiming victims' memory remains important, as having one more process
> working speeds up memory release.
> 
> When processes holding robust futexes are OOM killed but waiters on those
> futexes remain alive, the robust futexes might be reaped before
> futex_cleanup() runs. This can cause the waiters to block indefinitely [1].
> 
> To prevent this issue, the OOM reaper's work is delayed by 2 seconds [1]. Since
> many killed processes exit within 2 seconds, the OOM reaper rarely runs after
> this delay. However, robust futex users are few, so delaying OOM reap for all
> victims is unnecessary.
> 
> If each thread's robust_list in a process is NULL, the process holds no robust
> futexes. For such processes, the OOM reaper should not be delayed. For
> processes holding robust futexes, to avoid issue [1], the OOM reaper must
> still be delayed.
> 
> Patch 1 introduces process_has_robust_futex() to detect whether a process uses
> robust futexes. Patch 2 delays the OOM reaper only for processes holding robust
> futexes, improving OOM reaper performance. Patch 3 makes the OOM reaper and
> exit_mmap() traverse the maple tree in opposite orders to reduce PTE lock
> contention caused by unmapping the same vma.

This all sounds sensible, given that we appear to be stuck with the
2-second hack.

What prevents one of the process's threads from creating a robust mutex
after we've inspected it with process_has_robust_futex()?

