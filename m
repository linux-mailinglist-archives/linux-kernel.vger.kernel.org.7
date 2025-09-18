Return-Path: <linux-kernel+bounces-822887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC59B84E77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8024A5ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F2E21C9E5;
	Thu, 18 Sep 2025 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="pue4nemh"
Received: from mail3-164.sinamail.sina.com.cn (mail3-164.sinamail.sina.com.cn [202.108.3.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3CE1DFD8B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758203299; cv=none; b=Yjg3YPKvTirAoy0pEXUXLxMUN/1NAs4mi+AC7ReO9V9AxcI2D9Cf11nR1Ub2OOibWSf/xAqcrr8WSLuhsO3XD05rhRXlDo7lfQ9LgSfXbLbA6WNuTRZh3Y9XyLuojUrlp7fMBrM/dOF0yDoXmEzE02KSfuN4xqrvuW8eZi4gvuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758203299; c=relaxed/simple;
	bh=lDadJAvyZmcx7PatuYxQJaBFZ0vOYRBOxKD7sc4NrxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=td1gYUNsb+KOpFcT2gW3dos9/GmDlF6myKFFPFTbJ5VcbctTGf2C8bW9r6XK/Up2UsdxWGC296yel+XuaYkqfEr3aMikbH2/ys0Og3LUyBMn2I1sucMTlnI/FP0Bj/s1jgdjDbhFS/QbXuybkc0p7vy7oqgr0WUCkGADMHi+mnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=pue4nemh; arc=none smtp.client-ip=202.108.3.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758203293;
	bh=gjZ4m8+fnvvBoHeOxGVUc9aElTf4Aye6ynvpcFh61TI=;
	h=From:Subject:Date:Message-ID;
	b=pue4nemhc5qhJ85DbrIMDcHWJSjERaV23sdBjNu4vnRyq795ijLTb4apdHSvzegS9
	 A9cHUaaST6Ndt/p7lmuM9zRazLZErKm7L4Znton7AV/Lwd/GzhKviO3AVQKuna1zuT
	 P2OSiua/+EG5JxrVOk4/PK3MwA38Js4o/BPhc4/4=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68CC0D910000565D; Thu, 18 Sep 2025 21:48:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8010254456942
X-SMAIL-UIID: 9B565D5A1764478DAB38227F3EE49FFB-20250918-214802-1
From: Hillf Danton <hdanton@sina.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 2/3] softirq: Provide a handshake for canceling tasklets via polling
Date: Thu, 18 Sep 2025 21:47:52 +0800
Message-ID: <20250918134753.7122-1-hdanton@sina.com>
In-Reply-To: <20250915073933.L7UOtfkj@linutronix.de>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Sep 2025 09:39:33 +0200 Sebastian Andrzej Siewior wrote:
>On 2025-09-05 18:15:01 [+0800], Hillf Danton wrote:
>> 	CPU0			CPU1
>> 	----			----
>> 	lock A
>> 				tasklet C callback
>> 				lock A
>> 	cancel tasklet B
>> 	DEADLOCK-01
>> 
>> After this work could DEADLOCK-01 be triggered, given no chance for DEADLOCK-02 ?
>> 
>> 	CPU2			CPU3
>> 	----			----
>> 	lock A
>> 				timer C callback
>> 				lock A
>> 	timer_delete_sync(timer B)
>> 	DEADLOCK-02
>
> You are not supposed to acquire the lock, that is also acquired in the
> callback, while canceling the timer/ tasklet.
> Tell me please, how is this relevant?
> 
> If lock A is acquired on CPU0/ 2 then tasklet/ timer on CPU1/ 3 can't
> make progress. Now CPU0/ 2 waits for the callback to complete. This
> deadlocks as of today regardless of PREEMPT_RT and this change.
> 
In case of !RT, the chance for DEADLOCK-02 is zero because deadlock is
detected based on per-timer instead of per-cpu.

> The difference is that !RT requires two CPU for this to happen while RT
> is efficient and can trigger this with just one CPU.

In case of RT OTOH, false positive deadlock could be triggered because
canceling taskletB has nothing to do with the callback of taskletC.

In short I am highlighting the gap between per-timer/tasklet and per-cpu.

