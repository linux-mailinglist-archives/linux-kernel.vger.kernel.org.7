Return-Path: <linux-kernel+bounces-722427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B519AFDA54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17041C27B0C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82038219A97;
	Tue,  8 Jul 2025 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="kI7LnTRM"
Received: from smtp153-163.sina.com.cn (smtp153-163.sina.com.cn [61.135.153.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B691E9B2D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012061; cv=none; b=e5ZoTcSj6CiTVcuPpsadvxyYe98rr+ui7M6gYZC2Bou0x5At/c2nmgk3VnyUMFpzMFaXBpneyQilSTheVH6u0Gznms1hn5VmOIYAjHLlTBE5AeqMSmPxCI8z6vhJ1/qgn+NaFG2zE90fgzB3d9Duoma4pLJVrGOd0hnWH1OIB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012061; c=relaxed/simple;
	bh=v2gnjJvcScxjmdjpx6QWkmzaEkJOOPMEfIx0f+5JGC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/z+KyYrlkIUvv9cqsN1+xfAExB1/1LRFUL7460abaq1Yo1bEWHoLgiSk3pFbaL+FK3K6VGp04eHah+RBEeWRV7sj3yeIlyh2J2b0r2VZLYZlXBkVuTQkTx0EKfxmGmuXKZ+RyBx13TCFGJq6ygesVjkEl8Xyek1dw3ODD+3wTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=kI7LnTRM; arc=none smtp.client-ip=61.135.153.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1752012053;
	bh=L//NFJyjI+CU5wgh0Zq9743Re3Kfj6QcX8yEC/rcM9o=;
	h=From:Subject:Date:Message-ID;
	b=kI7LnTRMGvCQ56lw9H1uFrpwKJI+G8QiB5mzHoknkvM0sKFs9aYdse+4Aq5A1+FTE
	 vWhoetFP9eVzdERybXyWgSRFgVL2MWJqAYweEy+0+wXQzk/7MGoqg7sZhNVVyz+IWP
	 Xw6z+S/j/qfICT9UzWmxuMHAok6TZ4upjI6nlSq4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 686D950B00000B9F; Tue, 9 Jul 2025 06:00:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3684894456961
X-SMAIL-UIID: 68FD27539D6D4DE187F3954312ACCF18-20250709-060045-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/3] futex: Use RCU-based per-CPU reference counting instead of rcuref_t
Date: Wed,  9 Jul 2025 06:00:32 +0800
Message-ID: <20250708220033.2999-1-hdanton@sina.com>
In-Reply-To: <20250708131558.K7QEhtjc@linutronix.de>
References: <20250707143623.70325-1-bigeasy@linutronix.de> <20250708085640.2918-1-hdanton@sina.com> <20250708120156.2938-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 8 Jul 2025 15:15:58 +0200 Sebastian Andrzej Siewior wrote:
> On 2025-07-08 20:01:56 [+0800], Hillf Danton wrote:
> > On Tue, 8 Jul 2025 11:16:26 +0200 Sebastian Andrzej Siewior wrote:
> > > On 2025-07-08 16:56:39 [+0800], Hillf Danton wrote:
> > > > On Mon,  7 Jul 2025 16:36:22 +0200 Sebastian Andrzej Siewior wrote:
> > > > > +static bool futex_ref_get(struct futex_private_hash *fph)
> > > > > +{
> > > > > +	struct mm_struct *mm = fph->mm;
> > > > > +
> > > > > +	guard(rcu)();
> > > > > +
> > > > Like regular refcount_t, it is buggy to touch fph if futex_atomic drops
> > > > to 0. And more important guard(rcu) does not prevent it from dropping to 0.
> > > 
> > > What is your intention with this? There is an inc-if-not-zero to ensure
> > 
> > I am just simply wondering why get and put do not work without the rcu guard?
> 
> To ensure every get/ put user within this section observed the switch to
> atomics. There is this call-rcu callback which performs the switch. This
> one will be invoked after every user, that was user the per-CPU counter,
> is gone and using the atomic one.
> 
Then percpu refcount sounds like a better option because it is free at least.

