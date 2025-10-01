Return-Path: <linux-kernel+bounces-838305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FA5BAEE96
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 02:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F62C7ABE15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 00:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEC62264B7;
	Wed,  1 Oct 2025 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="up1vNAJR"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8F045948
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279810; cv=none; b=XoE3GNXbaqZ+qDleHC8T726JdJmm2aTpLJOzCPEq2T18n6Qjvrri/XVhWb3QbQZkqZbJVYzm1aO0BtVrz0P8uxTvHyN34vpVVPKqATRofVsi6pC+nM4WTceYgZOOVwaRADSLfBvY6fU3HQ7b4scod4yW5LmiQdDTjrIDYWip25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279810; c=relaxed/simple;
	bh=yBpII+5GseSqD5y2z853rNN0ObM9HM3BjeDb/OQydls=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=FeR0Yh2C4Yc9j/CGp0kwivvRXJgZHu74K63sC7Kg0NqrJAGuA46VXe24K9mXt6G7WTAMa5jL/qAggN2i4CnxO1x31ZByiSh5FyPdWy6v2oiUtZh4d1NTlVmPbKVDq4yGDXMVeCxIrtT63LO/rRGggdZezbCKe9Eer5mk2KcerT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=up1vNAJR; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1759279801;
	bh=OuUVwzUIF9DNsLbaGjNZSuvJdIeeO3tVobBOhJ1B3sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=up1vNAJR17boruQQzF0FCornbtb06wGFAlwHMGUPVRDQmyHRBUgW9flyfodUqTm8o
	 cnmU9Iaumkw+1YVD+3Db+kUV2KtWQR06zWB9V23N/f2HMmStaW74G10LQQ08KSH+ls
	 ajbl0XzXjV26Xk8avYP4rZLDkOslIDpuZjWWr9i8=
Received: from SSOC3-SH.company.local ([58.33.109.195])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id C58AD4D4; Wed, 01 Oct 2025 08:49:24 +0800
X-QQ-mid: xmsmtpt1759279764tigw28ds7
Message-ID: <tencent_DB76A6B5C83E21339A969893A285312A1F07@qq.com>
X-QQ-XMAILINFO: ORpsEWb2hdylbvFpNZviGjmzFQbRBYV8iE1+OSC3uPzvYvSBehKVj5e8DITxJp
	 cDyBiCvIZ/hlZ4262CflYfQur2WDyw8huAqUcWaQ94+IRVs4fz7qzikJpaNmvgjZcHUou0ucGpjQ
	 1LHnVza0vQOLKJj3SdRK0bhXVHGWbaHkWPF1qYD+PTr8fxmfOhxMmOVIVk4xqM63m13S4OEd1iPU
	 5mqnWOviIkkpHubGuJMo3vlU3cKslmNLIOyMAlQmv7DynuD5Y1ohtaIoGXpmTah0ALuDkcGwhTHw
	 1AONbtF4jIp/FHb1oaLqisHoZIr9/ksH8kX/2CJd1F2IhiHJ8P+Gu4ZAPnKWgLGnY/AmVvvwM4EJ
	 64vgMTzH+9vVIyKESJpk9WJlmPzHRhp2CfpLpYNmJsUs+tC7PtsrG7wyQqD3ojL1iad9JfAmK0/n
	 BQctwB6ZiBfpeSqWY9W5npUrCTgPfZV2L3k2wcuDFnT/l0SIo4h30EVvw6miE5aVlGMKecnI/1pq
	 0pK9r3a41VuRKrLDVz3LuXm8cUirV6R7r+N3QBCk23/Yn5gHhVonI0xBHp54zBmEg+owntruOlIW
	 M3qgiNQlFmSOcZNQEHc7Aj3r6VF/SX+8JgoYLUwS5LnWRgauxwUZ00YqPNMwKjDypd0wNb7pCMWU
	 yXUBXGVegQ42Ozp4rvT4NXVPV3fTd2+UaY+He9fG5WVJMEXY9p3gi/zXFAwLCbqQto3vz1kMY66u
	 oQOjbrUFfZA2GaJeoGtun0dH0RKoV248luwYlVdZRE/OAodjp2gcI+c4K4dmnF2rWSObuoYJmMzQ
	 0OPEvjvbGxQU6bdc9LXB1C0TnjGFJXuICFM1+FKasI+EYv2mrC41x27XioEyhjXL0IfU8yWwbUNn
	 47eFS0hm7NBzt9TeUW1ZG3QncQvkWvwsxznaCZ09iOkA7WOf24H+h09m/QD8bAcZtWw+v2lDejMg
	 EnST5t6cN80snaD7/SVhhj8er3xACRH6VsRAI3gugEAZ/9pyP55J65QYzBPFcCMASc3mrrv5bF1m
	 lXpDN2eOz3cM4fdgQoc3wc3vlbxbo=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Han Guangjiang <gj.han@foxmail.com>
To: pierre.gondois@arm.com
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	fanggeng@lixiang.com,
	gj.han@foxmail.com,
	hanguangjiang@lixiang.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	yangchen11@lixiang.com
Subject: Re: [PATCH] sched/fair: Fix DELAY_DEQUEUE issue related to cgroup throttling
Date: Wed,  1 Oct 2025 08:49:24 +0800
X-OQ-MSGID: <20251001004924.3763567-1-gj.han@foxmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <ec925126-2756-4b3a-b311-5f50ffee58c1@arm.com>
References: <ec925126-2756-4b3a-b311-5f50ffee58c1@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> When both CPU cgroup and memory cgroup are enabled with parent cgroup
>> resource limits much smaller than child cgroup's, the system frequently
>> hangs with NULL pointer dereference:
> Is it happening while running a specific workload ?
> Would it be possible to provide a reproducer ?

Hi,

Yes, this happens on our complex workload. We are using PREEMPT_RT option,
and from the error log, we can see that rt mutex PI operation is
being executed, and it needs to switch scheduler for a delay_dequeued task.
The parent group of this delay_dequeued task is being throttled by
cgroup at this time. And We currently do not have a minimal bug reproduction
program constructed.

similar issue: https://lore.kernel.org/all/87254ef1-fa58-4747-b2e1-5c85ecde15bf@windriver.com/
 
Thanks,
Han Guangjiang


