Return-Path: <linux-kernel+bounces-815085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABC5B55F2F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 10:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31AFF7A7FF7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66335246788;
	Sat, 13 Sep 2025 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="HfJH0ly9"
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5984F192D8A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757750474; cv=none; b=ggEI0G6FGWgJUX5YWuA1RKORB84qkhmkqR8vDwy+r7ilEnd7HI5qffI0YWfn+Q3A/FwvShOWXUsaIIXineANbonFKNhDoOrz2yG0nIPnEbCjmPO96/EYkaF6vtHPkHS7g4grAcwH/4aKjUTdXF0951lmGztXsyqB8LMP+X5ADQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757750474; c=relaxed/simple;
	bh=PKCHyblJmO1ZYvEI4PZvuL0TQRA/6X//A/5venXGVf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LwPqp3KIMDKqCowr4qT5v4uU6urPSH5g19B9IL2cTKxPXL23dFQu9EcGRs/tw+hUfN83OGwyJsEHLWiy52NrfAhFZ+9CMGbqBUnLPqpnXJj29OQyPZyflKOQEI/XhqwTGl+jjynptIJsNM8Iz6c9qV88gTF1nVMXJk08qq5VzKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=HfJH0ly9; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1757750468;
	bh=f0Py+bHOqvm1/UQHUuyMaGMlBz042T1KFybBHcD/XTw=;
	h=From:Subject:Date:Message-ID;
	b=HfJH0ly97R2ePFJy4rdnUqFuuyA93Rzl+fKLEVa17iqHkV6+476Y4196BRpcvzBb+
	 M34QCYBMERTYdk/VnKonCE2ZD21Ruy92F3TmC1n84sp5rTgYdQSrgWBZehCO4v1MP3
	 DB5e5ZwW38xg2u7Fe0zsiUpKzQaeKKOI1Xv+booc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68C5249A00001FD0; Sat, 13 Sep 2025 16:00:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 9218504456674
X-SMAIL-UIID: 65F741423F68481D9CC185241A1D82F8-20250913-160028-1
From: Hillf Danton <hdanton@sina.com>
To: Waiman Long <llong@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	pengdonglin <dolinux.peng@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock critical sections
Date: Sat, 13 Sep 2025 16:00:15 +0800
Message-ID: <20250913080018.7032-1-hdanton@sina.com>
In-Reply-To: <9d06c0d5-e20c-4069-adca-68a2c4cf6f4f@redhat.com>
References: <20250912065050.460718-1-dolinux.peng@gmail.com> <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com> <20250912213531.7-YeRBeD@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 12 Sep 2025 20:33:31 -0400 Waiman Long wrote:
>On 9/12/25 5:35 PM, Sebastian Andrzej Siewior wrote:
>> On 2025-09-12 17:13:09 [-0400], Waiman Long wrote:
>>> On 9/12/25 2:50 AM, pengdonglin wrote:
>>>> From: pengdonglin <pengdonglin@xiaomi.com>
>>>>
>>>> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
>>>> disable preemption, which provides RCU read-side protection. When
>>>> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
>>>> manage RCU read-side critical sections.
>>> I have some doubt about your claim that disabling preemption provides RCU
>>> read-side protection. It is true for some flavors but probably not all. I do
>>> know that disabling interrupt will provide RCU read-side protection. So for
>>> spin_lock_irq*() calls, that is valid. I am not sure about spin_lock_bh(),
>>> maybe it applies there too. we need some RCU people to confirm.
>> The claim is valid since Paul merged the three flavours we had. Before
>> that preempt_disable() (and disabling irqs) would match
>> rcu_read_lock_sched(). rcu_read_lock() and rcu_read_lock_bh() were
>> different in terms of grace period and clean up.
>> So _now_ we could remove it if it makes things easier.
>
> Thanks for the clarification.
> 
> In this case, I think the patch description should mention the commit 
> that unify the 3 RCU flavors to make sure that this patch won't be 
> accidentally backport'ed to an older kernel without the necessary 
> prerequisite commit(s).

This change also affects the dereference helpers.

#define rcu_dereference_check(p, c) \
	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
				(c) || rcu_read_lock_held(), __rcu)

