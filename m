Return-Path: <linux-kernel+bounces-768808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AABB265B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FA10A01DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C32FE05E;
	Thu, 14 Aug 2025 12:44:45 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87B3002A9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755175484; cv=none; b=loMeM2rpdXai0SvSxnwVUxASAjzjMpiw6L3KfS2h798pHSW/TKeciROHqkseByTHeRbEWku+fizehMDh/cDMJNvimbmb6MLA1swV+N/VSm3gmXhvfChLVZJGgirH2+rFcVa4VF/UzdSZSTGS/doeqXZKTq2oYc9tFL6l0Fq3b2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755175484; c=relaxed/simple;
	bh=RdpcGOIi6bpU/Nl6xwvkR2ft1dwWKN7ueFROD1zkJbw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bBp7k1cRu48kbXqV2IV0+1TPAftLKKjueek3z3Xkow8QNMTLObReKCoHPhNYdZPqYf47vuY+CSPnv/w9voS6hHShKmljKk1s8JF5dfbKsoHcSUc40U87PJHD+SC4KhEAcGseQoRH5QXzCUsJns4vO0Or73oel71CbwxCfYruPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c2lHH2wVGz2gL3L;
	Thu, 14 Aug 2025 20:41:47 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D90A31A0188;
	Thu, 14 Aug 2025 20:44:37 +0800 (CST)
Received: from kwepemq200012.china.huawei.com (7.202.194.183) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 14 Aug 2025 20:44:37 +0800
Received: from huawei.com (10.175.112.208) by kwepemq200012.china.huawei.com
 (7.202.194.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 14 Aug
 2025 20:44:36 +0800
From: Wang Wensheng <wangwensheng4@huawei.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <dakr@kernel.org>,
	<robh@kernel.org>, <broonie@kernel.org>, <saravanak@google.com>,
	<linux-kernel@vger.kernel.org>
CC: <chenjun102@huawei.com>, <wangwensheng4@huawei.com>
Subject: [PATCH v2] driver core: Fix concurrent problem of deferred_probe_extend_timeout()
Date: Thu, 14 Aug 2025 20:29:49 +0800
Message-ID: <20250814122949.9024-1-wangwensheng4@huawei.com>
X-Mailer: git-send-email 2.22.0
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
---
 drivers/base/dd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 13ab98e033ea..00419d2ee910 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -323,6 +323,7 @@ static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_
 
 void deferred_probe_extend_timeout(void)
 {
+	guard(mutex)(&deferred_probe_mutex);
 	/*
 	 * If the work hasn't been queued yet or if the work expired, don't
 	 * start a new one.
-- 
2.22.0


