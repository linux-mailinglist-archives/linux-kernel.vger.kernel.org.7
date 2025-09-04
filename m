Return-Path: <linux-kernel+bounces-799654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBE7B42EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3483ACF1E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2598019006B;
	Thu,  4 Sep 2025 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="yMOZg30Y"
Received: from mail3-167.sinamail.sina.com.cn (mail3-167.sinamail.sina.com.cn [202.108.3.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E05F29D0E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947987; cv=none; b=V1jbyg0y7C8rraIJxm5/8Xf8EEePbV790UbKWEnQGb9/f0Z+Gj6cORNawjXL3EGHkHr0dgrXS2N2J4cwXwV14YkKhsYx15XI+GUpXse58KxAFhEIcRNMNqcRGiDJMFqqvpKgQTmse1WcP+KfH/lZHLN6tZWJb8a+vjmuYasumgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947987; c=relaxed/simple;
	bh=Y5FkXg1q+l+bANYuU78sTSjCfRhtQEMrq4gwoYi2ZcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BP4PqZvH0qxLtJhKjzJrjU8tFA96KEdsr2lWNcR9+bUnr+l5quxHOTHlFP4VdgkasGdUWecke52lJSUfEO4mUPj30fIywwJkMrBfdKfLwt8aYCm5d7ksU+g5b1XijO/CAjzNPGoA4FMyN5RVDl9u2IPtQqTiODIPShD5YoI6XEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=yMOZg30Y; arc=none smtp.client-ip=202.108.3.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756947982;
	bh=1PRX40VDXKt5fdkyOugUQheA0/3kNkmIu8jTLpAcbrQ=;
	h=From:Subject:Date:Message-ID;
	b=yMOZg30Y3zWFiW7jenptpOQ7zFYYw4dS0DWBUV5mKSCf62Dg52FYkvKxit9DrMrh2
	 uxst5HfxM5mJDYSZJQgMITcfHME49cFspLDEhyI17VslRV9IAAm4JI7BJv1w4uDUfx
	 yHl/4EZ0hDsWqZqI5t7AZV1e/PdqApBpnYA14ObA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68B8E5E000002BF5; Thu, 4 Sep 2025 09:05:38 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2775386685278
X-SMAIL-UIID: 7201085AE2EC48469630045E6EB342DF-20250904-090538-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+10b4363fb0f46527f3f3@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] possible deadlock in __snd_pcm_lib_xfer (2)
Date: Thu,  4 Sep 2025 09:05:28 +0800
Message-ID: <20250904010529.6410-1-hdanton@sina.com>
In-Reply-To: <20250903145905.r7Ak4Wya@linutronix.de>
References: <68b269e9.a00a0220.1337b0.001f.GAE@google.com> <20250830065638.6116-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 3 Sep 2025 16:59:05 +0200 Sebastian Andrzej Siewior wrote:
> On 2025-08-30 14:56:37 [+0800], Hillf Danton wrote:
> > > syz.0.46/6843 is trying to acquire lock:
> > > ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:44 [inline]
> > > ffff8880b8823d90 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x264/0x400 kernel/softirq.c:168
> > > 
> > Given softirq_ctrl is percpu, this report is false positive.
> 
> No. This can happen on a single CPU.
> 
But the single CPU theory fails to explain the deadlock reported.

> > >  Possible unsafe locking scenario:
> > > 
> > >        CPU0                    CPU1
> > >        ----                    ----
> > >   lock(&group->lock#2);
> > >                                lock((softirq_ctrl.lock));
> > >                                lock(&group->lock#2);
> > >   lock((softirq_ctrl.lock));
> > > 
> > >  *** DEADLOCK ***

