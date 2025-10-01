Return-Path: <linux-kernel+bounces-838311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5198BAEF03
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 03:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A927A6586
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 01:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C671865FA;
	Wed,  1 Oct 2025 01:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="tNl78dNy"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540D611CAF
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759281345; cv=none; b=Oona7bnfcZ7uU67xKSlqAfnDAN10436irzWk8jdlX1lAhxPMDchHyfdOnjuwZVeLXfx8RcpNma2SdTgXXnycIS4h3WkRFboveI/TyZ9wqCAp7OrTCAEcPnPbESyXNZKX1GeMVOWC4PUrpXTWbmuieSFOowNa/Jql5l86ZtKygP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759281345; c=relaxed/simple;
	bh=ob4T4yxLplSUvqQjGm1as1DY69R9UpksJ+Uy+p4I9EQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=PrV01xugLGBOD82+yCDGjTCAE2Gqj7Ydsd5FynA7/XbWUh+ICDxgdjHjMApD71c0NPoD1EjmjnWwpNXrv5vAbYDCOHP5jxRLfypvsZlthQ2xnGg03HU8AMl2j4zlFL5zlybCyIkxzw0tl3tJUINp+ywBzwA4VLuYfQLZCoVJILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=tNl78dNy; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759281340;
	bh=n4sm4uwqUsevMHIl11FkhxNg7pZdMeEC6XDT6aP0E8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tNl78dNy8xtHTUaChaP2zwSaclT5YxcvAeljf+BaRFs32QdTBu7bX68St3Rf91gSY
	 DC+Z/88+2+mkRa/2jzVxaPPDEtZ0M+80mnOPuMiYLbf7ZeNBAsRuoOivdCyrjfS8oo
	 nT26WUGxK5js8AzsmVb9mvDG03V3pEG4VBSdKf98=
Received: from SSOC3-SH.company.local ([58.33.109.195])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id 3DB2F663; Wed, 01 Oct 2025 09:15:27 +0800
X-QQ-mid: xmsmtpt1759281327tn5zipend
Message-ID: <tencent_46288A6EC6007C3C980C22DB856268526209@qq.com>
X-QQ-XMAILINFO: MVrhzCz4YLrfRB3C4lOmA9wEvdQR+OkVXpZQEk/Fm04bE1TloLLNpg9oYVYAm7
	 RE12IL3QWd1OrGFZlfnLyJQxIZOWUWb9ISLxj3jyhYV/xeyzvw+u1hO/c7oZu1lUi3ZikrixyvEG
	 as4FXdtZLB5BrWHREbEjJD2GReLB4uodJYaUvpJDDuycYduXGrDx4ApIN1MmSBxgNSfbB/5AnFej
	 LYnu+r32wMtECj6jhYjL0GqeHehcJmPdifRbqBOgtE5WhiQRnXzcMyPoKT+Lz2T5BIAfY1KHSzKU
	 jjzsrTdjVABwSww4X0YflF6nl/vp0luqlmxR5r6rHUIulHh6vKfOfipT3Bp1xnzAkeGYo+NUc7s2
	 DMzAHYN1mDPlE7bJn273D5GZQojIVq/RQ/D7BuIIwdpZmOuL9trMS3yACTRvQk8PRLqv+GiFvmp1
	 DF4iydlUYiDOxSBMkRqGnfAB0GHiiYyA5UHFHyahLHk6Pqf9HtTuG/mlSclgStLyUHoLqPDCKWHr
	 7r9uD1ATnY/tNR3LQcOCxVGXTNXswn/znaQl+q20yvB64jpyyIHpil/e2jq/hDBCW0s3mt7wLRpz
	 v5FwT7sZBI371kZr3ybpk1jynXYgj6sPsOdWZbm4MIxdKlkcrz2PFbkViN1GeAWc08++TQek1xa0
	 AYxHbs+MDAonIfubCxw0wE3d/4cGn8gomkS/1v4XQYS/2vzXgNc4MB/RjXFj4l+WTRO882qX9iwC
	 pKCraenWZsO5gym1QYpRuKG2j+rLozBIg2/VNqLJ2B2BXh3h6smzwbxBbRfLHD69upgTa+xdLoJz
	 2HsJ7b+lL0Zpnp6Xz7rfJEh3fuWOwBm6j4LZLx+aRdqCUpkjU9odtrQm5wKxFi9Y2so4UcdyJNl/
	 OnMX2JYFRcapNQ6BWDniP6jHk0d1LyYumypZCHF2R2Ld53AryEniswyjkZXmlQZ9h01uiJ5s6mTC
	 d+22Kv+ZY8uiLyfM2uQ0P5ZdCimr1+hwNlhBw+bhCGEQrYQq030RhqJYCj7v3e+LbT8wf0icaSWG
	 kW3Qq/Fq3XE3fMF4lZ92SaH6auPPhJgcF60vw39b+cTr8suE8sI6lhtU26za2on0IOthpirfSJVJ
	 eQhgrP
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Han Guangjiang <gj.han@foxmail.com>
To: peterz@infradead.org
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	fanggeng@lixiang.com,
	gj.han@foxmail.com,
	hanguangjiang@lixiang.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	yangchen11@lixiang.com
Subject: Re: [PATCH] sched/fair: Fix DELAY_DEQUEUE issue related to cgroup throttling
Date: Wed,  1 Oct 2025 09:15:27 +0800
X-OQ-MSGID: <20251001011527.3797919-1-gj.han@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250930125621.GO3419281@noisy.programming.kicks-ass.net>
References: <20250930125621.GO3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: Han Guangjiang <hanguangjiang@lixiang.com>
>>
>> When both CPU cgroup and memory cgroup are enabled with parent cgroup
>> resource limits much smaller than child cgroup's, the system frequently
>> hangs with NULL pointer dereference:
>>
> Is this the same issue as here:
>
>   https://lore.kernel.org/all/105ae6f1-f629-4fe7-9644-4242c3bed035@amd.com/T/#u
>
>   ?

Yes, based on the patch modifications, I believe this is the same issue.
When dequeue_entities() is executed on a delay_dequeued task while the
cgroup is being throttled, it returns early and misses the
__block_task() operation on the task. This leads to inconsistency
between p->on_rq and se->on_rq.

When PI or scheduler switching occurs, the second dequeue_entities()
call assumes the task is still in the CFS scheduler, but in reality
it is no longer there.

By the way, I have a question about the hrtick_update() in
dequeue_entities(). Should it be changed to:

dequeue_entities()
{
    ...
    if (p) {
        hrtick_update(rq);
    }
    ...
}

And remove hrtick_update() from dequeue_task_fair()?
Because for dequeue_delayed tasks, hrtick_update() will be executed
twice in this proces.

Also, should the return type of dequeue_entities() be changed to
match dequeue_task_fair(), where true means the task was actually
removed from the queue, and false means it was delay dequeued?

Thanks,
Han Guangjiang


