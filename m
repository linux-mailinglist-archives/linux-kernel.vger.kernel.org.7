Return-Path: <linux-kernel+bounces-899758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30503C58CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD0D1364C49
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04883587D2;
	Thu, 13 Nov 2025 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D8gB9AME"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F927358D0A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050116; cv=none; b=NAnUCcWCT+gyXsgEgzBGWuoae3+hHj7e/znYWHNFuDj1I0PcjfUfs6phqiCQNkQOwvGpz/vm8hEekt9neyGQI6X1+QQlKTjryWkR4GgicaEpONsqlW09YmiRu5x6Ytgw2lRYz7O+nwWq1Jl+DwNiZxDdIu/b0HIF+laU6WCYWlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050116; c=relaxed/simple;
	bh=GaysYy91tbo7Rzk5Oo+T5WhlW7RvlxlYoCLAx+Mxnys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KDwKVZGBEsSSghfVMrUePdb+3sFDhYvcwMWBsGWa11o6Zojlv78S1ZfxTM8fHNmkOEXlXnTMl1ocAD4l6xGgmh1rdChq69L846fK5fb6+LgEvyheYYxXC2doyii4ofoTuJIAh95kICAnRorhRJoxECtWDePXCmrdWujGFN5ykPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D8gB9AME; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so5177045e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763050112; x=1763654912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7APxJ+6Kt5ZjlFq80IvFZLaGiW4Zr97mkhbYhGA1FE=;
        b=D8gB9AME9ACIqNl0FZXQuAhwXcJMQ+ZkCIbbtsbu0CI5lXudL8TLg2UwH7ckDmOIdb
         pGsTlG4gxnb2t7mVZ4o627DBO7jLIVWEGPREvbCOSCEjG7ztagP3WalyXtvgYXE+5TAL
         AkoJW17CHNIr174OavM+4aTfAgH8SwwMC9oey94YkquP1+XuTYAFz3pbnCLUJVms+uTs
         96+FKj/W5SpnvIikXDMPO9T0MnnNvupiijZvZcOTSZG+xshJcA/ViuL37mCQUQjoxyQn
         PBLnPtSRL3D1svcgsgAbnB2iS0x5GTpJeeM5+HPIvneAbiExAtymu8wOjUrI3ycCBUYE
         y/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050112; x=1763654912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7APxJ+6Kt5ZjlFq80IvFZLaGiW4Zr97mkhbYhGA1FE=;
        b=WtLGsHvaCEkXWGFYA09X/4M+pZawxFUxGrcAfwiJ+4adVdCSWKyD2CF1tuLJMnRWlM
         KQJrM6hdvMK05FDgzMG49IvG6VZeiy8779sPt6XtHAk5Oxq8M8vRKBU7higS8Vtc3Ls0
         B2wa4yx37k1CqTSDjPYIUTfY0KzR8l1AkmvVWOsztTnl8+WJHPLtVSTJaHYL4u6iujB6
         18vPGlvTIY+tEbA9dII1To1oDwa30QHQqzp/S6y71gX3ueSd0wT8dZFiFoLJSluJnfWI
         nU2KV1ESGyzlr32GDYWq2Cfrgr3laKLoewjx6QTPQ+R6jYyRSXKxe5IFTgRnWcM97krF
         +xNA==
X-Gm-Message-State: AOJu0YzCRQH7F/YaOXnfnbMu4zDQbexs966pEPbE9GCpleWyXKXj3mdD
	m7rNi7l0THhsfwg+VvCiMBLZh5GuraQzA4zFyvPX17bwf8K/Suv7ZJ70YFwNtCW9iR8JY3Z07m6
	HByg3
X-Gm-Gg: ASbGncsZuswTmLzFK/th+xP3PLZxG4G8NQ4qxjDhLExqRES+xvty4aoOmlzQGUa/MOm
	Gp2mDyLRBCw3gCWFO6CNDWCv6VSSkx6YYNmXFQRymrIOAaltsrHB5iOIvDH+KG5ZaKMrekuj50O
	TJ5SwLYNec5kVZj/nnVourHVnK20RWkP17LOZnij4XP0fGsLT2BdZUegUg6+58GB2FT8WOdjpWJ
	nICegDaMVUqKiT3CRLkH3YmtON/p33OibStSmCcyvc//kp3b2hATwOKnW3BBeMhIKuAmxUsmTkZ
	aTcGh2FzVYHQIec6hxByOYszTe+x4kqoTZuTTiIKmhls60gYD7RXMDNKEXR9zyvH2hprJz7G5Wp
	Sv4Hh/ExjpM+ORP2mG97e9KLVog4D9+imhYILxQkE0l10KKnqImpajB49SBKiECuStUoRLZmysp
	QqCbuYdgrD/5nLGebmvG+fSQJL
X-Google-Smtp-Source: AGHT+IG7IB1X5/m5Q5SADMGB90OCLYqu+sTZAOn8CJ1vZLQh6fP3A4bdbgQvQYNfniqXzk7gnOjiTQ==
X-Received: by 2002:a05:600c:4f06:b0:477:5c70:e15d with SMTP id 5b1f17b1804b1-4778fe01a08mr591385e9.0.1763050112533;
        Thu, 13 Nov 2025 08:08:32 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e36ca3sm108865325e9.5.2025.11.13.08.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:08:32 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jerome Pouiller <jerome.pouiller@silabs.com>
Subject: [PATCH] wifi: wfx: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:08:25 +0100
Message-ID: <20251113160825.383883-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.
For more details see the Link tag below.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
---
 drivers/net/wireless/silabs/wfx/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/silabs/wfx/main.c b/drivers/net/wireless/silabs/wfx/main.c
index a61128debbad..dda36e41eed1 100644
--- a/drivers/net/wireless/silabs/wfx/main.c
+++ b/drivers/net/wireless/silabs/wfx/main.c
@@ -364,7 +364,7 @@ int wfx_probe(struct wfx_dev *wdev)
 	wdev->pdata.gpio_wakeup = NULL;
 	wdev->poll_irq = true;
 
-	wdev->bh_wq = alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI, 0);
+	wdev->bh_wq = alloc_workqueue("wfx_bh_wq", WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!wdev->bh_wq)
 		return -ENOMEM;
 
-- 
2.51.1


