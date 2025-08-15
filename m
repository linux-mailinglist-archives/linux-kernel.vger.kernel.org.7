Return-Path: <linux-kernel+bounces-771176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84328B283D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8125A283E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2F92D060A;
	Fri, 15 Aug 2025 16:32:18 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5701F5434
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275538; cv=none; b=KxHdgta474gfJk+mm33zDHmwx/bQu9ZbXz+zxStKV3NTaRgI8xOqHbA1EchH1OdNQZwTyVTBmU7YF3KvKn2Xz2YLjmkzw3WY6p2e6//pY4BqzEQF8KBzSXQxS3ypbRC8uSUr9TJv/V+nTXjOJ/t36YIPCthh0wS6rKMwuVhQIdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275538; c=relaxed/simple;
	bh=cOYNHEn2wdj8L4vGwDqFQQAIQTkIKKs7OivOsUT3Dvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OP79wyVu4EPvQM+wX+3oVNZSFSAIg52YkhAs3fWv+u8OLytL8f6xDbpgQeHLZNh1SBgehg/HWPt50+bCOEejxixxz1WaA7Oq4vRPj/9r5q3LsquyrW7lqG+z33fHScCV1CWgLJ0AkslLzbisTnKNp5EOSt8Gh2BpP6yEEKFLRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4c3SLW0yd1zYmPdg;
	Sat, 16 Aug 2025 00:32:03 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 16 Aug
 2025 00:32:11 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 16 Aug
 2025 00:32:11 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <akpm@linux-foundation.org>
CC: <andrealmeid@igalia.com>, <dave@stgolabs.net>, <dvhart@infradead.org>,
	<feng.han@honor.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<mhocko@suse.com>, <mingo@redhat.com>, <npache@redhat.com>,
	<peterz@infradead.org>, <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<tglx@linutronix.de>, <zhongjinji@honor.com>
Subject: Re: [PATCH v4 3/3] mm/oom_kill: Have the OOM reaper and exit_mmap() traverse the maple tree in opposite orders
Date: Sat, 16 Aug 2025 00:32:07 +0800
Message-ID: <20250815163207.7078-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250814160914.7a4622ae1370092dde11c5f2@linux-foundation.org>
References: <20250814160914.7a4622ae1370092dde11c5f2@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a018.hihonor.com
 (10.68.17.250)

On Thu, 14 Aug 2025 21:55:55 +0800 <zhongjinji@honor.com> wrote:

> > When a process is OOM killed, if the OOM reaper and the thread running
> > exit_mmap() execute at the same time, both will traverse the vma's maple
> > tree along the same path. They may easily unmap the same vma, causing them
> > to compete for the pte spinlock. This increases unnecessary load, causing
> > the execution time of the OOM reaper and the thread running exit_mmap() to
> > increase.
> 
> Please tell me what I'm missing here.
> 
> OOM kills are a rare event.  And this race sounds like it will rarely
> occur even if an oom-killing is happening.  And the delay will be
> relatively short.
> 
> If I'm correct then we're addressing rare*rare*small, so why bother?

When there are apps that consume a large amount of memory, encountering OOM on
low-memory Android devices is not uncommon. On Android devices, programs like lmkd
(a user-space daemon in the Android system) also call process_mrelease() to reap 
memory when an app is killed.

> > When a process exits, exit_mmap() traverses the vma's maple tree from low to high
> > address. To reduce the chance of unmapping the same vma simultaneously,
> > the OOM reaper should traverse vma's tree from high to low address. This reduces
> > lock contention when unmapping the same vma.
> 
> Sharing some before-and-after runtime measurements would be useful.  Or
> at least, detailed anecdotes.

Here is my test data on Android. The test process is as follows: start the same app,
then kill it, and finally capture the perfetto trace.
In the test, the way to trigger the OOM reaper is: intercept the kill signal and
actively add the process to the OOM reaper queue as what OOM does.

Note: #RxComputationT, vdp:vidtask:m, and tp-background are threads of the same process,
and they are the last threads to exit.

Thread             TID         State        Wall duration (ms)
# with oom reaper and traverse reverse
#RxComputationT    13708       Running      60.690572
oom_reaper         81          Running      46.492032

# with oom reaper but traverses
vdp:vidtask:m      14040       Running      81.848297
oom_reaper         81          Running      69.32

# without oom reaper
tp-background      12424       Running      106.021874


