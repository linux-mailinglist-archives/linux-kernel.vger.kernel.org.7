Return-Path: <linux-kernel+bounces-801960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43676B44C15
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F292E3A3F85
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4721F4177;
	Fri,  5 Sep 2025 03:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="R29iIDVE"
Received: from smtp153-168.sina.com.cn (smtp153-168.sina.com.cn [61.135.153.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277532628D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041498; cv=none; b=LZ8toFVBG6IZdpyPHPJ66TndjGw4QZ4cuMo1DXCGoXCpmBWul7+9zLWeRZ55IDC1LTfCQBu0laBpGT3YdHPaV1iiO/zTUwXd763I+SGIS+r6iHV2RW2bJ9d3ln8XR4ZgPqd24P/MkYkH3y8g1Dx4G0SSpJASpFx800yctXBFooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041498; c=relaxed/simple;
	bh=Fa9QEYvq8U1239ffQ9FXV8vf18xnM6NBpeumwYql1Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ3wmy8g5+bWwvLcvJ+7roDFdHvfs9HFGmMkt3G/N+WR5RnL9zujuvyDmMq70c8uqbs2OuWd3czBbvHrBxHRgFdH7TA0KfPqZHLuVsL5MPfV3bXn3gqsY4zywPKDftcEA9pNFd9G9eUq77bkLmoYKqZxUFdmOYA09jaeojSSdRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=R29iIDVE; arc=none smtp.client-ip=61.135.153.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757041489;
	bh=UM+dj6qPa3stsp1QOw+zpoObjbjaHbOlW3JqlYRyYMg=;
	h=From:Subject:Date:Message-ID;
	b=R29iIDVEfvrOBJ0raYd/0I/cQfRlK0cfvgBzHmbZ5n98WpgHaqbSXFYI/cjucBh3T
	 Is6eA680seK90cu9AZffIDhuKTMH2mJotEhEq5cVxmiOJcFYebK5F2WxRNaeYW2Whm
	 jVp961ggCc7INWKvf90o7M6u41VIGPh9IifIBPsw=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68BA534600005335; Fri, 5 Sep 2025 11:04:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4972666685191
X-SMAIL-UIID: 2ABD3BF3762D4C96B8179C7EFFA9A17E-20250905-110439-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in __snd_pcm_lib_xfer (2)
Date: Fri,  5 Sep 2025 11:04:29 +0800
Message-ID: <20250905030430.6482-1-hdanton@sina.com>
In-Reply-To: <20250904061245.pqGf3VwT@linutronix.de>
References: <68b269e9.a00a0220.1337b0.001f.GAE@google.com> <20250830065638.6116-1-hdanton@sina.com> <20250904010529.6410-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 4 Sep 2025 08:12:45 +0200 Sebastian Andrzej Siewior wrote:
> On 2025-09-04 09:05:28 [+0800], Hillf Danton wrote:
> > On Wed, 3 Sep 2025 16:59:05 +0200 Sebastian Andrzej Siewior wrote:
> > > On 2025-08-30 14:56:37 [+0800], Hillf Danton wrote:
> > > > > syz.0.46/6843 is trying to acquire lock:
> > > > > ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
> > > > > ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168
> > > > > 
> > > > Given softirq_ctrl is percpu, this report is false positive.
> > > 
> > > No. This can happen on a single CPU.
> > > 
> > But the single CPU theory fails to explain the deadlock reported.
> > 
> > > > >  Possible unsafe locking scenario:
> > > > > 
> > > > >        CPU0                    CPU1
> > > > >        ----                    ----
>                Thead0                  Thread1
> 	       ------                  -------c
> > > > >   lock(&group->lock#2);
>            preempt to ->
> > > > >                                lock((softirq_ctrl.lock));
> > > > >                                lock(&group->lock#2);
>                                        <- preempt to
> > > > >   lock((softirq_ctrl.lock));
> > > > > 
> > > > >  *** DEADLOCK ***
>                now nobody makes progress
> 
Because of the absense of the deadlock detecting mechanism in timer, see
lock_map_acquire() in call_timer_fn() for detail, hrtimer is unable to
detect deadlock like the reported one.

	CPU0			CPU1
	----			----
	lock A			hrtimer B callback
	cancel hrtimer B	lock A

On the other hand softirq_ctrl plays such a detecting role in accident, but
they are two entirely different things. 

