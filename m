Return-Path: <linux-kernel+bounces-888728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A23C3BC34
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF281B208F3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4350D33E36E;
	Thu,  6 Nov 2025 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aQCdVriY"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AC32B997
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439366; cv=none; b=jw4LNvo7YHExL+mLPti1PbfBpw/G0yqBAXhqxGxLUGiAz/F0b8TI0DEORXaJlIck1oADaZIfkjQob+2L24mFPGE+MwjwYi4v156+c/qsQxzp+z8KsA8Yp885oP3O8NnqjQeEbYNtIs0qXosuKicfa12+Nbs2CIoKCy8AGfmHLa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439366; c=relaxed/simple;
	bh=d4fHAUv1EuUUWp1Aapmae9ls6LCSo7WvtBtFk+cOU3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ovg7ggyKI+zaXuvFW64O9Tv6PI8q6JkTPT/WvKdxJf9dxnD6dc7JkXjjoPBaABFHITWZWeDTc/WK8ZHG5TQq8D9dL9RCyTWBeS8rMS16Nl4W+WgeuSGXVfzSAerjzYsZZ0uzB6s+Ynvujf/hOg6Sx0eP/cZ6MzDF+/owMFlQcbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aQCdVriY; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4711b95226dso12246535e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762439362; x=1763044162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h5YxLYnLmr4nTLx/JN1RCszCEO3k6sNkh+Sh26FPVKc=;
        b=aQCdVriYX5D2RULFQa1Qo+qO7gIKxoDBl9vG51GTMQNLSGnpClaTjsivjJPk0LMtLb
         6Wzafd7q4+eMeRmIyjf8JbkmUgZa/XVwCdc6GwllxDAflNsm+fMjCW1Gihuj9WjFcTOn
         Gs0Txu+DTQiV7VuYKrdBSybooI8x4o8R1ZLmx1FqgZWAsWqD/PVZNlxqShtcBhKSG20k
         DgcY3abbcRY4+F3mIWTFIoOrLbSsQ6Y0isZgjKNEdjSMOtqTcNCgDfkhmc7TGXexy5lt
         UHpIcIGKzgRwav/pvj38vgHV4PLrX3ED70kqoxz4soels1xvOawksLsIileC/PAsBmDU
         2o8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439362; x=1763044162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h5YxLYnLmr4nTLx/JN1RCszCEO3k6sNkh+Sh26FPVKc=;
        b=pZPHwlWsVMAdOm37UwGprzIGZj/+VQYRe4aZ/Itzxgb2VJLuM/M61y7dO3xzySjUDF
         HsPt90kMmyr6GBhIr/kE3l8jyRg5GjcwHoybkGSAIh1dA1NXXgV9wdBol5zRbSpQpPSq
         G9SnuyU8D/5nKmnvH7/c53nu0EgQ/cQFOoY/ngE/vGvbf6AfpWjTJHCCnYAURADT89xC
         lX63EEOlUCrYAIZJqc7bttHlqhhwJxohuqpK99sMhjnFMuL/B9Cfv2+tg+XYpjdFYhiI
         jOuTJViRN/16Ku6gX/MozDlKHn2/Bp6r6OjsR+rZyCVGGx+lSwb6XX5B+yntIBv7d/nY
         /Y9w==
X-Gm-Message-State: AOJu0Yxxb/Hb3vGBxQfBoiHzQnCugca79T6nh8BQPupQocJIDsI76om+
	Lx4EUUIiIAVcPWmDWnhytvR5/oDwvww0JcVGYNF5jam3Wz3fYhpp6VRZVHUdaYjanXD46zdX5DO
	KjhJq
X-Gm-Gg: ASbGncu0Oxgn9TuNylmxPGDMkTkELUMB/Rv7vISyf4XdJ7ZdS6ZbnwPRy+vs383C/OZ
	tUkx3Z6A2EWfP6kgTSawBkSDDmXiuAIfjqIeJtKbzxU0wR8yJ4J2bkfgRWxFPrpD9/0Y3f3nXuG
	4174B+XC81jPFWK8oLhrG6ir9r6bcIEDG3F9ynL1odFp9H3Rqdx1CbufaF3CUq+vGdPWLWdI4Y+
	3Fv9z3VHW81So/p7pSVNigtJnX3IcKl03t6l1fZhzNOiYtSaRC6N4nxIrGxB3SciitcKIXdldLU
	eRkgmsfnHFFyX100Uqk6Dlyoa+hkdACBxNP6tbkyiwaKXiuhjVCch229AoG2Lw7tsrtMSadmQci
	MxPukdoqPaBveOWMH6nJ5uslHpOp0ymEEfpU8oFMYgGID3Ve/9ZlC7pDHdAfS04vtTmfIseFo/l
	cUKpLlfuUuRx6Dp3K92rXgbF4=
X-Google-Smtp-Source: AGHT+IEMdtJHre6mRIbgK0R5dgFdW0iBUI74M4kEgpZn842elu23QCa0tNFdWBlVBuG81fddtz4Yrg==
X-Received: by 2002:a05:600c:5251:b0:46e:4704:b01e with SMTP id 5b1f17b1804b1-4775cdbe125mr57505445e9.8.1762439362278;
        Thu, 06 Nov 2025 06:29:22 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49c394sm5613736f8f.41.2025.11.06.06.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:29:21 -0800 (PST)
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
Subject: [PATCH v2] regulator: irq_helper: replace use of system_wq with system_dfl_wq
Date: Thu,  6 Nov 2025 15:29:14 +0100
Message-ID: <20251106142914.227875-1-marco.crivellari@suse.com>
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

This continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This specific workload do not benefit from a per-cpu workqueue, so use
the default unbound workqueue (system_dfl_wq) instead.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/regulator/irq_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index 5742faee8071..5b3cfac28667 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -146,7 +146,7 @@ static void regulator_notifier_isr_work(struct work_struct *work)
 
 reschedule:
 	if (!d->high_prio)
-		mod_delayed_work(system_wq, &h->isr_work,
+		mod_delayed_work(system_dfl_wq, &h->isr_work,
 				 msecs_to_jiffies(tmo));
 	else
 		mod_delayed_work(system_highpri_wq, &h->isr_work,
-- 
2.51.1


