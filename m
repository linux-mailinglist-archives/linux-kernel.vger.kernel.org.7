Return-Path: <linux-kernel+bounces-886873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E737C36A73
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A93E1A254CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEA741C63;
	Wed,  5 Nov 2025 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VTpoULf4"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDCC334C0C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359278; cv=none; b=aN8DJbS767+x4PgVssfG0T4IVkKPUOyiwGCuN3BbY7k8NGEOIziq+EVD19rrB5Y8TGW6iK/65yW3epL1TMIy09OJ4CNzR4w0aBOA/CG6mSCc7TQ4JlimAUBoUocPjiylo6rFHQFRLLgYd9mHQ0aR1/hUvZsPUxlA/G3NZh60Ly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359278; c=relaxed/simple;
	bh=+RqzI7DmaHbnC2L4j+PhZU6q5miuhQzf6z7aKSIP4vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vqawd/bsvtXq7vIEFUsV2E+trvm2wN9tbi6xHmdN2eAhP98bV8OkHonvZMcpLQeRlamoEp7u63guZve/rplGC1ArJms34U5mSYZZ6RosJt5fLjXMrjiE6wqPyZZuSgE0lgGjnyw/IPlSJ6tdjykUQEakJvKYukoLP/5EtqW2VBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VTpoULf4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-429cf861327so20174f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762359274; x=1762964074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRA35tpQfzjsxooDaaqj7UJHSVhlCQN3eSDYhgPLw1A=;
        b=VTpoULf45QtKxF2b4bn3kAuE+Zvp7V7TN1neyeKR7k2WwP+ncRA2WhMC///MiZ+fPg
         4/vyEj/tfHSOnjyA7yCe7Vh/EUecbXqHBcCuWsvvQG9hzure5o1TgoiFI3reG5JvNUfX
         RqcOu8VZJbidRcUUmt/j58IeVjkr2My9sF/gHHYeq/q/K64EycMsyX5Itw+4CtSqePBB
         0sJ9mepzfdtbQ/83N+8giml8xenShqK6jwWjPw20f6uJ3adTSma8tN9q8mk+slVHEOFB
         ZUkLRzaJQlZUYEaNrQw3VoPJGCY6b7cPIL0q630GscWjVhz4ffaVDALpaLaSTSgh6/cy
         VxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359274; x=1762964074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRA35tpQfzjsxooDaaqj7UJHSVhlCQN3eSDYhgPLw1A=;
        b=wOZARXDiBA1h2Dub1Hl4XYVvggD2HSGpadUcVq3rM/xgHQvHvGTs7aDE91VTEYJa4B
         KATfzgcSRLm6w58AhxGXJYydcjJzkqH84KKNmwq/7J68cxI482kW6mksn4BGjBeqrpOO
         H8qnmxsJWBkSTJqt79ZkBX9CwCz2c/ZAO5h/qVQqk2CS3OxanjllxdndwM7AQtqh+xNP
         O0REo4vumF5GC72YFWoBQINis/NJgF+PJjktes0lGwVhk3DXe32fJStfTg61VrgkJc3f
         O/Tspa9knKqCbxM1mcYbsBWoSYZlafmSkNnnqOjvKYtximFZGzfW9d8lRcMmWYaKbgNp
         WERQ==
X-Gm-Message-State: AOJu0Yw0JJTyQA5rCC9S93BKCvPsav8CdIYCCbUIwNFboeEx+eORR+t2
	PzKqOsR/eeV9taJjVOlRL1bfFSyzD20gdYwBSyR6tWvmZE1WzxF+EqyXwQq080o+PCd0Q6gEGM0
	VZoP8
X-Gm-Gg: ASbGnctk5T4jdBp/fa5lzgxq07BxPFmDmI8AX3b5Qb3W6utdh63FhJm6DFqaTydDXGw
	Lr7hLH4XLuezCUwH9XSXTR1DNLhYoXiJj8FXffhXZ+i1q9M2fwF6DnqJCPTi8/YiEdZmTUczMhX
	k44QvBTHL6gUwytrkhUJ6KBP0wMlLIc3H5ILRhCCXHZcg4YUQpU4Py0uZ8voWNueKW0kHUrU6Nt
	qMLwqfMp5MjW22LRenmaJ4v6dz98/fMOP7pn4j8GPyHG3VPdt+TFb4z8hajiqHQl4wnRWOCxGd5
	ULZpPhc5fXhaw6Tc+8rkkPdoYnDycM0n5/dUetop3aO4ywon7cxPqT1X0I3T1lTvxKLQs0WXdiJ
	J5qVcg6C8VcChPchBiQlMEsaGPLmSijyqdt1MQ3Ds7DwNWbfJUb3CbKIHv0KMnzNfCmOQ7eLaaU
	L9jpEswBWuobmzknWR+QNWlE4=
X-Google-Smtp-Source: AGHT+IHNe9YjvUvCQil+uYmv2TjbMeloFxryl8gTcYWClByDg3GQY2jUp7fSBGOSrDWJRS2WxtFx7A==
X-Received: by 2002:a05:6000:186d:b0:429:b9bc:e825 with SMTP id ffacd0b85a97d-429e330bbecmr3757724f8f.46.1762359274478;
        Wed, 05 Nov 2025 08:14:34 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fdef7sm11808315f8f.43.2025.11.05.08.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:14:34 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] regulator: irq_helper: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 17:14:25 +0100
Message-ID: <20251105161425.308499-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Replace system_wq with system_percpu_wq, keeping the old behavior.
The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/regulator/irq_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index 5742faee8071..54dd19e1e94c 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -146,7 +146,7 @@ static void regulator_notifier_isr_work(struct work_struct *work)
 
 reschedule:
 	if (!d->high_prio)
-		mod_delayed_work(system_wq, &h->isr_work,
+		mod_delayed_work(system_percpu_wq, &h->isr_work,
 				 msecs_to_jiffies(tmo));
 	else
 		mod_delayed_work(system_highpri_wq, &h->isr_work,
-- 
2.51.1


