Return-Path: <linux-kernel+bounces-884638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4DDC30A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C74134E50E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238642E0400;
	Tue,  4 Nov 2025 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UZjHTIHx"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057821ABD0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254077; cv=none; b=Eg/zeL7LTJ17Vc7YbLdSzvpDUWkUzjF5kRCup+6+YZr3DYQfWD8Pr5ENF+Vqx3E5sFTGWSKHtIlv8qA6xb1JSoC19sCblBSH47xte3Qon4HLfPLyWzSMV8HB9/3RTVEELps6leLorNTmqINmIkCI28piINLJyskMeQpBwBpW5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254077; c=relaxed/simple;
	bh=mArBqFOeVrE5jYsRKEJxiyZJF+9dJtNX3PiOAjPBW+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/pfyIba9EB9Um+hSVC2bQicXDEpAgWFcy7hGvY0tCPfPpuTng3UsBRRHtJglLoAl7N5zOPShXoGb1Y24Isw9cnnQp/ezRdrflnJZiQiyyJaAPFBZF9vj1Xf0l72dui9fmSmZnnw67ZummhmJYVwNyjBkj31shXcnhllPmqiuZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UZjHTIHx; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b714b1290aeso273137066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762254072; x=1762858872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LiUSXZMeTb4lHGRsJf5DN52rKN9wpSJp+QMjxfGu3bs=;
        b=UZjHTIHxmJzHNM4H7zL2ad0ujdLDA6dNP/W5Dw2dzx+pY+Q+i9s1Bf6RBQZeoEDzMs
         EQDBZYCH8siQp/7rJLjqnpu0q1z8lkSssbeC2KT0cu/eFo2+eR/tr6JbIiLcTQfSPb+o
         5PxU4xUjsDiF4eDRG0j8igGGL8kzukDNw54y4x2OvvNN8En1tCiKaq7kZ0njzaM9yHFX
         C7pADHmoFKAlJmD94ChXWtAhEfIXtG7xI11W+kKZ60qiCmlW+YT1KCmn4+cvJPbIRqsD
         BZyviZMdxALEP8clO32XVan5LBebzGpjQ8B2afxyFZCchnIFAIitYao0eY+QRUCLLobx
         o3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762254072; x=1762858872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LiUSXZMeTb4lHGRsJf5DN52rKN9wpSJp+QMjxfGu3bs=;
        b=F7w/I2aAlwsSSsfn/M2rgSQkhMfySMNaNTzcDw7fFJX9VwFexz1w/gXaoKI22bq9v+
         ++Zl++utcTp1OZPMCsNfm8260deXZi8U5PO/kCNMJJgboAPbZc3StiRZ8+FV1ADJ5J7K
         umv8lHcIMmDNzzzgB13fG09ry82RAbgeSNVSDHNe/teHnp73pmNOe0PjHnw+QU1/Ik0e
         maWcogtzLenS7PrKdkcTOhVKTZal5x1QYpSFg4TCK7tgaRD4YuNH8qf+zWQv4hWkQxBC
         JIE9gWUU4FqUj0INkX2VZ54RVfkj6DH/k23ciE56ebWzZ0ujTwMKhFDR3Ke5hl4BwZy3
         LPhw==
X-Gm-Message-State: AOJu0YwccNgHZIAKSKr+0bd8KXRZ0crm8yUA9M9rKTG7xRaIlfZiYhyi
	IK889DCH547OXT3vywBly9GhwLNiIKMx01ztQWFhQQfaF9TXHKi82nW8iejEsIsap2AY8K95M5x
	LsnCD
X-Gm-Gg: ASbGncsDXdqdIDNuAvNOeDa8YbbhYc6QWCjU8Hlu/Fd7wU+KP8bHrM7fTgDiJ4njqmD
	91esBhwDb4NedGFIE88o/c+Ls5ScmbFITRPbxtCch9Ku5xOgG5hxKHYoFxho0Z+fdxCxxcHNebj
	w5K3nCAFflDuH3R+FmV6gUQCLGENrO/R9XnOc/X46vC9tc5DtYAEvXLnLNo55BdHsQskIdxdd3w
	jBMEa1rw1RexPnYRkPJjd6eqRdnxdRz250e9CVFaVudzwLc9lB34wtC312/RhLe0IngExMWaCde
	mBIWmtZkRGAuxBWYrGRqAiLRgvMwJlQ95sM26Nf7cbQyOxC7Ve+S7LAA3ABF2a3Rq66XaW5nx+s
	iisBUocQ8qW2r0Wgr5xD0av0bjhk5bkW4RFdZw+hhbPG2LFAebEGwkBO92jsvqW61jeBmGqK+Y6
	8gDzc=
X-Google-Smtp-Source: AGHT+IEvPsmRgbTeuYJa2QmD6wW1icZrBHYQA2iPQ97Sc2Yw2+Mg2Xj2gzej6ArzF4F5HHUxk0AYBQ==
X-Received: by 2002:a17:907:6eab:b0:b6d:73f8:3168 with SMTP id a640c23a62f3a-b70700bb6f8mr1889737166b.3.1762254072454;
        Tue, 04 Nov 2025 03:01:12 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fa023adsm173606266b.51.2025.11.04.03.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:01:12 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] extcon: int3496: replace use of system_wq with system_percpu_wq
Date: Tue,  4 Nov 2025 12:01:05 +0100
Message-ID: <20251104110105.116858-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/extcon/extcon-intel-int3496.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
index ded1a85a5549..7d16d5b7d58f 100644
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -106,7 +106,7 @@ static irqreturn_t int3496_thread_isr(int irq, void *priv)
 	struct int3496_data *data = priv;
 
 	/* Let the pin settle before processing it */
-	mod_delayed_work(system_wq, &data->work, DEBOUNCE_TIME);
+	mod_delayed_work(system_percpu_wq, &data->work, DEBOUNCE_TIME);
 
 	return IRQ_HANDLED;
 }
@@ -181,7 +181,7 @@ static int int3496_probe(struct platform_device *pdev)
 	}
 
 	/* process id-pin so that we start with the right status */
-	queue_delayed_work(system_wq, &data->work, 0);
+	queue_delayed_work(system_percpu_wq, &data->work, 0);
 	flush_delayed_work(&data->work);
 
 	platform_set_drvdata(pdev, data);
-- 
2.51.1


