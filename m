Return-Path: <linux-kernel+bounces-857679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E532BE7A3F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEE5956642F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3345F313E22;
	Fri, 17 Oct 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ME9RsZC1"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2382D5C6C
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692256; cv=none; b=AZg4GqqdFXMzJV9X+tCmYVKfbYcLAxzQNcKbKoasTD0Ev27IiqMhk1PcoJUiuug10q5mIVDr0f0nWOsf67KVcnr4d7JfIw1gNKS2hNfXMgbFZZ2AOmTehRuNAs0Z2OdHnLEQhjk8mC2Wsc53voMwQqWO1s9evTigecTzuPD5xGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692256; c=relaxed/simple;
	bh=bdrLtB6xk+MGpM2d9fMPQJJLoWlfKm290p8L/KWLkIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E12Kh54cW3Rhk6lwRDepUkGWua4w3E1xrjJlxHSjkdg3f4wZ+FBFUcUGXyg4lF2aQhOluycV1cwWjpwaQgyQ4Cz6gVR9Fjwg74WObiczsI8ncstlFuGnq/i62CaUhI6sJA1pdhERCDqoUEzIdV9NWpeMuR1pKLsmpa12A5LGbnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ME9RsZC1; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rm
	NrZtMiHz3LjDeyDhuaXOJWQ3vAUBHaxOPOvnDcSc4=; b=ME9RsZC1OF+rXHhlZY
	SjzgjpIUQ3O6NGKMmO04oVLeEmqXEksvHQR3aRapOTu32lW2mteZu+fUU0knJcHC
	K14G/kkD6iqwZsokzGjnTASfNjRbGJT6hviPYjZ6m5VHh403fB1dSid5Faz7yrTj
	8AwEyZxEDl6HpaGDcwls90K5M=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wB3_PMRCPJojpl6Aw--.8554S2;
	Fri, 17 Oct 2025 17:10:41 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: tj@kernel.org
Cc: jackzxcui1989@163.com,
	jiangshanlai@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Support RT workqueue
Date: Fri, 17 Oct 2025 17:10:41 +0800
Message-Id: <20251017091041.3026848-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aPEQAqGOWOzzZl4Y@slm.duckdns.org>
References: <aPEQAqGOWOzzZl4Y@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3_PMRCPJojpl6Aw--.8554S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAw18JF17ZF45Gw1UXFW5ZFb_yoW5CFyDpF
	WrKay5Ca1kGr1jya97Za17Wry2k3ykXF47Jr95GwnrAw45K34avFyxKa4F9F1DCrs3Cw12
	vrWjv34DCFn8ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUljg7UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvxHc5mjyCBHhiAAA3+

On Thu, 16 Oct 2025 05:32:18 -1000 Tejun Heo <tj@kernel.org> wrote:
> Hello,
> 
> On Thu, Oct 16, 2025 at 06:23:45PM +0800, Xin Zhao wrote:
> > In a system with high real-time requirements, we have noticed that many
> > high-priority tasks, such as kernel threads responsible for dispatching
> > GPU tasks and receiving data sources, often experience latency spikes
> > due to insufficient real-time execution of work.
> > The kworker threads are shared globally based on the attributes of the
> > workqueue (wq) and the parameters of queue_work_on. This means that
> > regardless of whether you create a new wq or use an existing one, the
> > kworker thread that processes the work does not exclusively run any
> > specific work or work from a specific wq. While this design saves
> > resources, it makes it difficult to ensure the real-time execution of
> > work by modifying the priority of the kworker thread associated with a
> > specific work in hard real-time scenarios. Additionally, if I manually
> > set the real-time priority of the kworker while executing the work task
> > and then adjust it back upon completion, the next time queue_work_on is
> > called, the priority of the kworker thread will have reverted, making it
> > impossible to ensure timely execution of these lower-priority threads.
> > Moreover, frequent priority adjustments can incur additional overhead.
> > Perhaps we could implement all logic related to hard real-time tasks
> > using kernel threads, but I believe this workload is unnecessary. The
> > existing workqueue mechanism in the system is well-structured and can
> > guarantee that work executes in an orderly manner in concurrent scenarios
> > by adjusting the max_active and WQ_ORDERED attributes. We only need to
> > introduce a WQ_RT flag and add a small amount of code to meet the
> > requirements of hard real-time workqueues.
> 
> For things that may need RT, please use kthread_work.
> 
> Thanks.

Thank you for your suggestion. We can indeed replace some simple work usage
scenarios with kthread_work. However, it is not a panacea, especially in
cases where work processing requires concurrency.
If we cannot use the RT workqueue implementation, we need to create another
kthread to improve concurrency performance? In addition, we may need to
incorporate logic to split works that are originally of the same type?
This splitting modification can be quite time-consuming and is likely to
encounter various strange errors during the split.
Given that the workqueue mechanism is so excellent and effectively matches
the needs for concurrent and ordered work while also managing work thread
resources efficiently, perhaps we should consider adding the RT workqueue
feature to the kernel. After all, the changes are too simple to carry any
minimal risk, yet the benefits could be substantial in handling concurrent
demands and preventing thread resource wastage.
If we do not pursue this, continue relying on kthread_work to handle RT-prio
work concurrency, it would be equivalent to re-implementing the logic of
pwq and worker_pool.

--
Xin Zhao


