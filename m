Return-Path: <linux-kernel+bounces-890468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F77C401EA
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94219189C9DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9922E7166;
	Fri,  7 Nov 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bRQm648t"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975402E719B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522203; cv=none; b=RNflXMAyvNdRJkTCddLLQ485uBgH7nITPU3OdBbK/p4EglBEyMlA81bhq9mwWxh/J+Cd+oKJOgQejm0utBytAitmiGW0LZ2JN+ldUi/kwbrMzt6xpzZaoIG98fBsqTyXO5P8VRwqU6mISnO7kayn3jPRHMumYja/r2UcofE4PS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522203; c=relaxed/simple;
	bh=bne0rOQwnlY7OIldu8r9ihwIuRSNMqzWL8oa+y0+TmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HTYJ3wkH14xv7/DUcdCFFa65EgzAjEF1wPzYxfzXW80n9IZ+1KZyBtxC7lJ7h7gPSZ3cc/RI+4Be+QG8abY/Bs9ExXzDSnJY7fv4reIXCG0UuUPKBKxzbIszA09m4gtZCmWAUc7Du5/OK5ahrJC9X2VAsI4+FVNPQA1jn1NcDD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bRQm648t; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-429eb7fafc7so578728f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762522199; x=1763126999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9uKcl/f9ZChp5UYMtJdyOFq+FU1Dyf96Ve7s2R428o=;
        b=bRQm648tEWV1ncOOxTzo+woPngEbpvpSUKYjE7dXzkAo3bn7zdGL+i88Bcyjhu1d2l
         HK/7OWBlkqbBb9IzfOCGXf6YJKad5affVEqtCqIacm4IHnxCfPhBuIxNyjaTVIcMaoq1
         esJ3JXl7yjq6RQbyVavXaw0Bqla9+iNJif/KWvmdog4/MMQ71RE1nXR+zSwYsQ3z+0bg
         +Z0b4eI82pr5gyUKEb5n3QfodSn6x0GdHJR0g7OOFhUVptTUKtScJUQQ01JDxwPeabQ3
         DBLCYag/GXXaZW3fwMIyBZ3Fm2CrbcPg/vyVOQ/tTXhe0utH8kErG1PQSBVhTAyfsGsI
         57aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762522199; x=1763126999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9uKcl/f9ZChp5UYMtJdyOFq+FU1Dyf96Ve7s2R428o=;
        b=FhR1Ext6sUT/cGEPwhn2HfHg9ZylEw6vUdI1wILxdPql5yArNOZxmARB/iKOZ2cNjq
         vTbm1T7mdBOdO96wJ7HLjf+RP3dSaEJ/NLHK966LfA1fWPHB5BguAsXyExsEyzGJ1JwH
         0WMl4SDGfdJ/yBD/9q2vMWMb48zUXuqj/1Nca1S7awuwXpz+80a4amqccMFr5GYzllw8
         F6xDf2J9pM3QuQmNRfWssyqTW3469TRx9+eIW80v4NNtPOOTl8Dn+Ya9+r4JBZokHevH
         /wsFGzN8Yk70Wc/5wbb3OiSWEW4HXtOAeZDiJD4f5guVMhFhxnUlgPHfSjahIVwCuths
         FaPg==
X-Gm-Message-State: AOJu0YxJjruI/+29vTo/qT/t/2/YkQFN5JZSky3QmlfFYfe6HffCKLDu
	EwbBsDI+hGjB8R2UZ+AKmeeu6525Y+VQLnjhOAiqL5yvy+PGTWy6C1nrCdpupq2ZyGFmN1sX3LD
	MCxSh
X-Gm-Gg: ASbGncuqPCr55CWGJeN1LDTnVglJtbj2v/Zpb7MFpUO8S+XVObnJLv1+v2eblp0zDK9
	wZze5wspx9+6qXI0M2oWW3pXcAD3aIS37f7aGmOuQVyJZx8H7kmu7vtBxHV9sTPn+ITyIR2nOwq
	nErvogDeeTrYl6CNEbHJmTdaY2Be5uhvjtEQoxlh8YTwpsn+F6UwfKQshhon+rUEZBusqZWW4wg
	ER2L4wHqZV0dVMaNt9M3pgbw/ydAkpUvWs/PdqEElZjdL/NzLUjIXMkV8jp4SiSmed971zVlbix
	iWtONHQww7RCVdUFzZ/ARyu4/mfxUjWJHeDrYb8OyUtQzVR02nKGnpSxVdwil10wFEX3mG4D0LV
	HGpEKmLih9RtLVVdw+GZynal3z6LADeLifIwZNo1dsPuaYH4S/ULl5zE54AlNB3zRe/aGcsGcvS
	auLPUa42mmiJMK/2Pp/2czRA1M
X-Google-Smtp-Source: AGHT+IG1zulGwSQbhYh/38/sTDo6Jn/J1fjvMhHK5mO3mv4/FtwtJPlGpH+oi0kLDn5Jv03MwMReRw==
X-Received: by 2002:a05:6000:4010:b0:429:c8f6:5873 with SMTP id ffacd0b85a97d-42ae58d0151mr2665587f8f.22.1762522198627;
        Fri, 07 Nov 2025 05:29:58 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e07asm5310756f8f.17.2025.11.07.05.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:29:58 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-i3c@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH] i3c: master: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 14:29:49 +0100
Message-ID: <20251107132949.184944-1-marco.crivellari@suse.com>
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
---
 drivers/i3c/master.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index d946db75df70..519b98c37ac7 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2925,7 +2925,7 @@ int i3c_master_register(struct i3c_master_controller *master,
 	if (ret)
 		goto err_put_dev;
 
-	master->wq = alloc_workqueue("%s", 0, 0, dev_name(parent));
+	master->wq = alloc_workqueue("%s", WQ_PERCPU, 0, dev_name(parent));
 	if (!master->wq) {
 		ret = -ENOMEM;
 		goto err_put_dev;
-- 
2.51.1


