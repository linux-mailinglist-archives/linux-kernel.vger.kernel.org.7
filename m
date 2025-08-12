Return-Path: <linux-kernel+bounces-764881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5E3B2283D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6327AAF05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8718727A455;
	Tue, 12 Aug 2025 13:21:19 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87C276022
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755004879; cv=none; b=DhkovVQMKbUBrONrxfmmyeO26KCa5MIsfZCMVCi2oEKctVSs5hBXTcOnzc6aNejxnmd/2Aoh1HRIqzm3ZaGZTLcFAeubyTuPmwObGN9foi2h9NubVDHpOLIBgIkoqwQWZusLaN5uE5pqOkrYqOV0/BaYU/eNgM0yK2j4kDtaNtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755004879; c=relaxed/simple;
	bh=4qJyuXcJg81aDQXhfDxMPElcejduzJ0mAO9OKRd6Niw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PsvfiT7ClkhUb5s+LK41Q0lkltouGCuvqD/bnnnbLWa8ui+i/AwL0lpofUiSUKL1OCl7nPAfwoKe/TNyrt49Y8ieVbOqwThJU3zHWbKePP7ss66BR6qmPA0KmQRBFLbtr4s6l5RwkFJmh4Fvw6x3kfKeq1mp49ed03uajYjbNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w003.hihonor.com (unknown [10.68.17.88])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4c1XFT51GXzYkxsh;
	Tue, 12 Aug 2025 21:21:01 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Aug
 2025 21:21:08 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Aug
 2025 21:21:07 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <tglx@linutronix.de>
CC: <akpm@linux-foundation.org>, <andrealmeid@igalia.com>,
	<dave@stgolabs.net>, <dvhart@infradead.org>, <feng.han@honor.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<mhocko@suse.com>, <mingo@redhat.com>, <npache@redhat.com>,
	<peterz@infradead.org>, <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<zhongjinji@honor.com>
Subject: Re: [[PATCH v2] 1/2] futex: Add check_robust_futex to verify process usage of robust_futex
Date: Tue, 12 Aug 2025 21:21:03 +0800
Message-ID: <20250812132103.9910-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87cy99g3k6.ffs@tglx>
References: <87cy99g3k6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a018.hihonor.com
 (10.68.17.250)

> Please use foo() notation for functions in subject and change log.
> 
> > The check_robust_futex function is added to detect whether a process uses
> > robust_futex.
> 
> Explain the problem first and do not start with what the patch is doing.
> 
> > According to the patch discussion
> > (https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com/T/#u),
> 
> Can you properly describe what you are trying to solve as part of the
> change log? A link can be provided for further information, but not
> instead of a proper explanation.
> 
> > executing the OOM reaper too early on processes using robust_futex may cause
> > the lock holder to wait indefinitely.
> >
> > Therefore, this patch introduces check_robust_futex to identify such
> 
> # git grep 'This patch' Documentation/process/
> 
> See also:
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
> 
> > +bool __check_robust_futex(struct task_struct *p)
> > +{
> > +	struct task_struct *t;
> > +
> > +	for_each_thread(p, t) {
> > +		if (unlikely(t->robust_list))
> 
> This is a racy access as the thread might concurrently write to it. So
> it has to be annotated with data_race().
> 
> > +			return true;
> > +#ifdef CONFIG_COMPAT
> > +		if (unlikely(t->compat_robust_list))
> > +			return true;
> > +#endif
> > +	}
> > +	return false;
> > +}
> > +
> > +bool check_robust_futex(struct task_struct *p)
> 
> The name sucks. Public futex functions are prefixed with
> futex.
> 
> But this is about checking a process, no? So something like
> process_has_robust_futex() makes it clear what this is about.
> 
> > +{
> > +	bool has_robust;
> > +
> > +	rcu_read_lock();
> > +	has_robust = __check_robust_futex(p);
> > +	rcu_read_unlock();
> > +	return has_robust;
> > +}
> 
> Why do you need two functions here?
> 
> If the OOM killer is invoked, then saving a rcu_read_lock()/unlock() is
> just a pointless optimization with zero value. rcu_read_lock() nests
> nicely.
> 
> But I'm not convinced yet, that this is actually a sane approach.
> 
> Thanks,
> 
>         tglx

Thank you very much for your review. I will fix them in the next version.


