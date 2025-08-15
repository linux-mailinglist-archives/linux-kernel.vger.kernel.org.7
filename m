Return-Path: <linux-kernel+bounces-771249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AD2B284A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B11AA1E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C534304BA8;
	Fri, 15 Aug 2025 17:07:09 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E1304BA1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755277628; cv=none; b=MouHjZ+JUhOQyGYDUDe8DrYksl46UUYCnob1CEVFwpyVmS1Qj/si4rHOs5e5ch8sfJNzPwKTXS5ClkEYXPIT0e7FLNI1cwhSsbBWpAbC6VvPYNfbEJhvY0iUlwldpjXteVsmywqIG8GmN8qFftzNNgNQeywPMcHgguDLV7+PHmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755277628; c=relaxed/simple;
	bh=EpYsGoqWN4QWv8S6Flrh8xW9jet3JK3XpRQ4rYr1ZJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/UVUCikD3wv4VA0uqhULO1YBNSvjWQitpbZJLd/VN1TbERXutCJf/+nJrZUXr86A3s6dEQeuYX5pWKoAFzSrvhza9sSo1QV3ENn+ZaBYBcLywRMGFhQQPMSWXROdldvnF7yhH4Jt/piKy0bbyly/P30ZWM2RB71z90BmrG1KAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c3T6b4gYzzYkxsP;
	Sat, 16 Aug 2025 01:06:47 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 16 Aug
 2025 01:06:56 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 16 Aug
 2025 01:06:55 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <akpm@linux-foundation.org>
CC: <andrealmeid@igalia.com>, <dave@stgolabs.net>, <dvhart@infradead.org>,
	<feng.han@honor.com>, <jsavitz@redhat.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<mhocko@suse.com>, <mingo@redhat.com>, <npache@redhat.com>,
	<peterz@infradead.org>, <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<tglx@linutronix.de>, <zhongjinji@honor.com>
Subject: Re: [PATCH v4 0/3] mm/oom_kill: Only delay OOM reaper for processes using robust futexes
Date: Sat, 16 Aug 2025 01:06:51 +0800
Message-ID: <20250815170651.11457-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250814161345.b2ddf7120dfcc420c3199e67@linux-foundation.org>
References: <20250814161345.b2ddf7120dfcc420c3199e67@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
 (10.68.17.250)

On Thu, 14 Aug 2025 21:55:52 +0800 <zhongjinji@honor.com> wrote:

> > The OOM reaper quickly reclaims a process's memory when the system hits OOM,
> > helping the system recover. Without the OOM reaper, if a process frozen by
> > cgroup v1 is OOM killed, the victim's memory cannot be freed, leaving the
> > system in a poor state. Even if the process is not frozen by cgroup v1,
> > reclaiming victims' memory remains important, as having one more process
> > working speeds up memory release.
> > 
> > When processes holding robust futexes are OOM killed but waiters on those
> > futexes remain alive, the robust futexes might be reaped before
> > futex_cleanup() runs. This can cause the waiters to block indefinitely [1].
> > 
> > To prevent this issue, the OOM reaper's work is delayed by 2 seconds [1]. Since
> > many killed processes exit within 2 seconds, the OOM reaper rarely runs after
> > this delay. However, robust futex users are few, so delaying OOM reap for all
> > victims is unnecessary.
> > 
> > If each thread's robust_list in a process is NULL, the process holds no robust
> > futexes. For such processes, the OOM reaper should not be delayed. For
> > processes holding robust futexes, to avoid issue [1], the OOM reaper must
> > still be delayed.
> > 
> > Patch 1 introduces process_has_robust_futex() to detect whether a process uses
> > robust futexes. Patch 2 delays the OOM reaper only for processes holding robust
> > futexes, improving OOM reaper performance. Patch 3 makes the OOM reaper and
> > exit_mmap() traverse the maple tree in opposite orders to reduce PTE lock
> > contention caused by unmapping the same vma.
> 
> This all sounds sensible, given that we appear to be stuck with the
> 2-second hack.
> 
> What prevents one of the process's threads from creating a robust mutex
> after we've inspected it with process_has_robust_futex()?

Thank you, I didn't consider this situation.
Since process_has_robust_futex() is called after the kill signal is sent,
this means the process will have the SIGNAL_GROUP_EXIT flag when calling
process_has_robust_futex().
We can check whether task->signal->flags contains the SIGNAL_GROUP_EXIT
flag in set_robust_list() to ensure that the process is not being killed
before creating the robust mutex.


