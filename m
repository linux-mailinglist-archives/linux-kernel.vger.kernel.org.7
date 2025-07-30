Return-Path: <linux-kernel+bounces-750403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662F6B15AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A51AE17DF61
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A028F290BD5;
	Wed, 30 Jul 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV/oYmBb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBCD481B6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865516; cv=none; b=XSciMn03LlmDy/XHeMczyPOJmy5sfhYs+My5Qd7xcsRkKcQHqfEEVIzPnW2MHavJQdVWuAtvlX0cedkzCVJ52mz0sFBUquaWI87EFmf/WQPO7gSdYw+hAOsvsqexdDW6HjkKcKUsJU7hWDI1cqf+mfHfQWvH3KDlRgmhS1gnDk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865516; c=relaxed/simple;
	bh=u6wP6F/bNIsV4If2nbN3it0BAPZcnnD04agsbzZuBkY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TTDNwVzkSBHXUzKH60sruzu1aEd9+e82FqbTywh87eco6+rfdi8E0Mnjcl8hNzLMN124f7kSbFVftrn6RjTs54Ls2xtMfwzKnALwCVTjVqTznOZKJviDVM5tIQjMM0zhI7KABhHUlsBpnj3pGRpti8uARUkF/I1u/XnjHYCdMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV/oYmBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8CBC4CEE7;
	Wed, 30 Jul 2025 08:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753865515;
	bh=u6wP6F/bNIsV4If2nbN3it0BAPZcnnD04agsbzZuBkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EV/oYmBbLUrXD5Ra61sin3RomLS60HfU53OTbSmoJtDQxbHDitkqr49o9f/D9hfe6
	 V3TiufHRPfRR7aofuC+2zzQ582hvT1OXotY71asDUx2f3MXw+bmLG5oPkC1dS2BF21
	 Pw1KdqiDapxGqEJ+Kxeun9eTiFubkaF84MC0WJ2I+EW+1wUOf3pjjcYhqG/d4Xm7VT
	 xiRZt5glFx7AhRtbrRK3RK9dyamgetRWO1DY7QS1854CqOzkFLs9UirpJYsa93qwPh
	 O9+MdTyxZO+ZspnVAI3iwULNpdTs3c1ibPs0/WOeIzk8i7NTI9SgxEqyq8NdNSBcyY
	 3O9ugDXWwFKyA==
Date: Wed, 30 Jul 2025 17:51:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, Joel
 Granados <joel.granados@kernel.org>, Anna Schumaker
 <anna.schumaker@oracle.com>, Lance Yang <ioworker0@gmail.com>, Kent
 Overstreet <kent.overstreet@linux.dev>, Yongliang Gao
 <leonylgao@tencent.com>, Steven Rostedt <rostedt@goodmis.org>, Tomasz Figa
 <tfiga@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] hung_task: Show the blocker task if the task is
 hung on mutex
Message-Id: <20250730175150.af61caf3be97ef4cfbcc4da3@kernel.org>
In-Reply-To: <tfzs3z7yjs6ppobm53hxwjzhhptgq2aqc2obylblz5rk7mdstg@bkas4xcq66xk>
References: <174046694331.2194069.15472952050240807469.stgit@mhiramat.tok.corp.google.com>
	<174046695384.2194069.16796289525958195643.stgit@mhiramat.tok.corp.google.com>
	<tfzs3z7yjs6ppobm53hxwjzhhptgq2aqc2obylblz5rk7mdstg@bkas4xcq66xk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 16:59:22 +0900
Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> One thing that gives me a bit of "inconvenience" is that in certain
> cases this significantly increases the amount of stack traces to go
> through.  A distilled real life example:
> - task T1 acquires lock L1, attempts to acquire L2
> - task T2 acquires lock L2, attempts to acquire L3
> - task T3 acquires lock L3, attempts to acquire L1
> 
> So we'd now see:
> - a backtrace of T1, followed by a backtrace of T2 (owner of L2)
> - a backtrace of T2, followed by a backtrace of T3 (owner of L3)
> - a backtrace of T3, followed by a backtrace of T1 (owner of L1)
> 
> Notice how each task is backtraced twice.  I wonder if it's worth it
> to de-dup the backtraces.  E.g. in
> 
> 	task cat:115 is blocked on a mutex likely owned by task cat:114
> 
> if we know that cat:114 is also blocked on a lock, then we probably
> can just say "is blocked on a mutex likely owned by task cat:114" and
> continue iterating through tasks.  That "cat:114" will be backtraced
> individually later, as it's also blocked on a lock, owned by another
> task.
> 
> Does this make any sense?

Hrm, OK. So what about dump the blocker task only if that task is
NOT blocked? (because if the task is blocked, it should be dumped
afterwards (or already))

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

