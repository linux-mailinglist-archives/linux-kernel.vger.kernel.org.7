Return-Path: <linux-kernel+bounces-768686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE5FB26437
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD80B1BC7C61
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760F62F1FDF;
	Thu, 14 Aug 2025 11:25:17 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB965222566
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170717; cv=none; b=W66E26MesKhZVHB7sc5VySYyMMHdNPNDoYW9ZhahyqXPh9zlS1e8GfkuslRf3iRDzkwRuzPilShfLPdbbiWleNkaWFAc7GdbO7eFhfe1pazm61U93qOtfVK5lcjvshsqvEexnJKyi2ggzaJoKzPkJfSz1wEApRDTZCg8mt891f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170717; c=relaxed/simple;
	bh=wp3rwYwUgjRyjVgaK+Ct89o2TRJ1NLg5QDHGpD5DFg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfDiRbSnUeLXMdKgp/ntB/UyDY8QesFbmwkM0Mo7xJtdm8NEDY6FdCoJfcSbuDRyrSC/7PsKuKR5VZoy5BSqdKSmfbK/c639MAeutzCcGpQS9IV80I8pxBeuzaAql2tGEoajxwhe51j9NTR0jaXG+HvGWHbfpnam50BusTbgHKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c2jYm0b7yztTFw;
	Thu, 14 Aug 2025 19:24:12 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 17AD8180B51;
	Thu, 14 Aug 2025 19:25:12 +0800 (CST)
Received: from kwepemq200012.china.huawei.com (7.202.194.183) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 19:25:11 +0800
Received: from huawei.com (10.175.112.208) by kwepemq200012.china.huawei.com
 (7.202.194.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 19:25:11 +0800
From: Wang Wensheng <wangwensheng4@huawei.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
	<tglx@linutronix.de>, <saravanak@google.com>, <robh@kernel.org>,
	<broonie@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <chenjun102@huawei.com>, <wangwensheng4@huawei.com>
Subject: [PATCH 1/3] driver core: Fix concurrent problem of deferred_probe_extend_timeout()
Date: Thu, 14 Aug 2025 19:10:21 +0800
Message-ID: <20250814111023.2693-2-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250814111023.2693-1-wangwensheng4@huawei.com>
References: <20250814111023.2693-1-wangwensheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq200012.china.huawei.com (7.202.194.183)

The deferred_probe_timeout_work may be canceled forever unexpected when
deferred_probe_extend_timeout() executes concurrently. Start with
deferred_probe_timeout_work pending, and the problem would
occur after the following sequence.

         CPU0                                 CPU1
deferred_probe_extend_timeout
  -> cancel_delayed_work => true
                                     deferred_probe_extend_timeout
                                       -> cancel_delayed_wrok
                                         -> __cancel_work
                                           -> try_grab_pending
  -> schedule_delayed_work
   -> queue_delayed_work_on
since pending bit is grabbed,
just return without doing anything
                                        -> set_work_pool_and_clear_pending
                                     this __cancel_work return false and
                                     the work would never be queued again

The root cause is that the PENDING_BIT of the work_struct would be set
temporaily in __cancel_work and this bit could prevent the work_struct
to be queued in another CPU.

Use deferred_probe_mutex to protect the cancel and queue operations for
the deferred_probe_timeout_work to fix this problem.

Fixes: 2b28a1a84a0e ("driver core: Extend deferred probe timeout on driver registration")
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/base/dd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 13ab98e033ea..1983919917e0 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -323,6 +323,7 @@ static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_
 
 void deferred_probe_extend_timeout(void)
 {
+	mutex_lock(&deferred_probe_mutex);
 	/*
 	 * If the work hasn't been queued yet or if the work expired, don't
 	 * start a new one.
@@ -333,6 +334,7 @@ void deferred_probe_extend_timeout(void)
 		pr_debug("Extended deferred probe timeout by %d secs\n",
 					driver_deferred_probe_timeout);
 	}
+	mutex_unlock(&deferred_probe_mutex);
 }
 
 /**
-- 
2.22.0


