Return-Path: <linux-kernel+bounces-794633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89104B3E479
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA753AF277
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696E41E3DE5;
	Mon,  1 Sep 2025 13:18:02 +0000 (UTC)
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6AE1DF270
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732682; cv=none; b=DSxa+Vfj6ZrukCO27reYuE/3Fm3EbELdVAS/DhknhNFxhIvo9RXXe9HxaM7NZbzldgIn6QlkxczFupM944qoYVrRggXS89UCu59gnXv619dEdT05L3WLVcHEwbLi+az2zgeWg6XBLqpdRqJeXJnLsZ5q5ZCyHe1nq4tnZ91Ajrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732682; c=relaxed/simple;
	bh=n0prFO744TsH2cGxBDp2IVzGGzC730aQKfMKFW0Slw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7Qw/y3MjzW24cqmAmR4JKtsY+R+djCsX22qakkLyxLJnHg/PWDikEWIF0gA1NpAzatAZ109BIavX/6jeTF4sWOA6IfHh+CqBqs4GxKpwWhYwckUBz673NKDbtdWLPp4W3a0S9waXWfciCzt7OP7qi8D8/IGoeLE8YhIOh7ftgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cFqDJ3wqFzYl9lf;
	Mon,  1 Sep 2025 21:17:36 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Sep
 2025 21:17:57 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Sep
 2025 21:17:56 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <shakeel.butt@linux.dev>
CC: <akpm@linux-foundation.org>, <feng.han@honor.com>,
	<fengbaopeng@honor.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liulu.liu@honor.com>,
	<lorenzo.stoakes@oracle.com>, <mhocko@suse.com>, <rientjes@google.com>,
	<surenb@google.com>, <tglx@linutronix.de>, <tianxiaobin@honor.com>,
	<zhongjinji@honor.com>
Subject: Re: [PATCH v6 1/2] mm/oom_kill: Do not delay oom reaper when the victim is frozen
Date: Mon, 1 Sep 2025 21:17:52 +0800
Message-ID: <20250901131752.29098-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <krmliemwgxygxkc3rkix5ah6ubzzulpktejdbu5uhpldwtjts2@3sqqkl5i36tv>
References: <krmliemwgxygxkc3rkix5ah6ubzzulpktejdbu5uhpldwtjts2@3sqqkl5i36tv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a018.hihonor.com
 (10.68.17.250)

> >  	get_task_struct(tsk);
> >  	timer_setup(&tsk->oom_reaper_timer, wake_oom_reaper, 0);
> > -	tsk->oom_reaper_timer.expires = jiffies + OOM_REAPER_DELAY;
> > +	tsk->oom_reaper_timer.expires = jiffies;
> > +
> > +	/*
> > +	 * If the task is frozen by the cgroup freezer, the delay is unnecessary
> > +	 * because it cannot exit until thawed. Skip the delay for frozen victims.
> > +	 */
> > +	if (!frozen(tsk))
> 
> Can you please change the above condition with the following to handle
> v2 as well?

Thank you, but I think the cgroupv2 check isn't needed, since a process frozen
by the cgroup v2 freezer won't block exit after being killed. Would it be
better to note in the comment or changelog that this change is for cgroup v1?

> 	if (!frozen(tsk) && !(READ_ONCE(tsk->frozen)))
> 
> > +		tsk->oom_reaper_timer.expires += OOM_REAPER_DELAY;
> >  	add_timer(&tsk->oom_reaper_timer);
> >  }
> >  
> > -- 
> > 2.17.1
> >


