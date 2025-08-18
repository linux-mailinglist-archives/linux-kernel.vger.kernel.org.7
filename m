Return-Path: <linux-kernel+bounces-773518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D87B2A12A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266093BFD9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EB130DD10;
	Mon, 18 Aug 2025 12:08:30 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87A01EF36C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518909; cv=none; b=bc4LSg9L8mzbUU00JjXni2LLUyfejIigZsWkmHo7jixMloA8jh65RXH7vx8wwY6vzMVdNFr30ih79qJAk/tOxHBUQ19kw6vhjXdlehOEOAOqgCjPxQUe0KgHkuKh2WSY7gk5jysSlChZ+BFDLP3PwaUIEMLz9Yn9C28Ymy3prDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518909; c=relaxed/simple;
	bh=GVPHf1kGP4Q5WQrYADTsKIrm99q71Z83ItiVvd9p9zk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXWriMG0Hi1lBWbFIEwdk/i/Zf5g+dDxuWykgHbgPQr8o53IQctFTGXXgRyVkCWs8nnlhyE7yItR/Kny+sQfSJ+BduFAkEFEfCDO1lmranqIhsB7ntRBtdZv9SwV3IhCN7FB8s5p4RUEz6+TYhNcjqQ41udYl8hpEyErYyVNj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c5BLj5FtxzYl6Cw;
	Mon, 18 Aug 2025 20:08:13 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 20:08:24 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Aug
 2025 20:08:23 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <andrealmeid@igalia.com>,
	<dave@stgolabs.net>, <dvhart@infradead.org>, <feng.han@honor.com>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <liulu.liu@honor.com>, <mingo@redhat.com>,
	<npache@redhat.com>, <peterz@infradead.org>, <rientjes@google.com>,
	<shakeel.butt@linux.dev>, <tglx@linutronix.de>, <zhongjinji@honor.com>
Subject: Re: [PATCH v4 2/3] mm/oom_kill: Only delay OOM reaper for processes using robust futexes
Date: Mon, 18 Aug 2025 20:08:19 +0800
Message-ID: <20250818120819.26709-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aKIvd4ZCdWUEpBT_@tiehlicka>
References: <aKIvd4ZCdWUEpBT_@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
 (10.68.17.250)

> On Thu 14-08-25 21:55:54, zhongjinji@honor.com wrote:
> > From: zhongjinji <zhongjinji@honor.com>
> > 
> > The OOM reaper can quickly reap a process's memory when the system encounters
> > OOM, helping the system recover. Without the OOM reaper, if a process frozen
> > by cgroup v1 is OOM killed, the victims' memory cannot be freed, and the
> > system stays in a poor state. Even if the process is not frozen by cgroup v1,
> > reaping victims' memory is still meaningful, because having one more process
> > working speeds up memory release.
> > 
> > When processes holding robust futexes are OOM killed but waiters on those
> > futexes remain alive, the robust futexes might be reaped before
> > futex_cleanup() runs. It would cause the waiters to block indefinitely.
> > To prevent this issue, the OOM reaper's work is delayed by 2 seconds [1].
> > The OOM reaper now rarely runs since many killed processes exit within 2
> > seconds.
> > 
> > Because robust futex users are few, it is unreasonable to delay OOM reap for
> > all victims. For processes that do not hold robust futexes, the OOM reaper
> > should not be delayed and for processes holding robust futexes, the OOM
> > reaper must still be delayed to prevent the waiters to block indefinitely [1].
> > 
> > Link: https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u [1]
> 
> What has happened to
> https://lore.kernel.org/all/aJGiHyTXS_BqxoK2@tiehlicka/T/#u ?

If a process holding robust futexes gets frozen, robust futexes might be reaped before
futex_cleanup() runs when an OOM occurs. I am not sure if this will actually happen.

> 
> Generally speaking it would be great to provide a link to previous
> versions of the patchset. I do not see v3 in my inbox (which is quite
> messy ATM so I might have easily missed it).

This is version v3, where I mainly fixed the error in the Subject prefix,
changing it from futex to mm/oom_kill.

https://lore.kernel.org/all/20250804030341.18619-1-zhongjinji@honor.com/
https://lore.kernel.org/all/20250804030341.18619-2-zhongjinji@honor.com/

> -- 
> Michal Hocko
> SUSE Labs


