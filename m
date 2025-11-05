Return-Path: <linux-kernel+bounces-886764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C5AC367D1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A171A27405
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E0432ED56;
	Wed,  5 Nov 2025 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V9TzDbwg"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4896430F950
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357052; cv=none; b=C0uvupbB/4z9jyJTLG6LZecisd5xWzBEU8KWbcJKiak2FRK1QAkoj73gtDh8eqKWDKXx69cNXK7YC9CvlxYu2mMimx5Sp/W1wDvfi/lOK3I8LfyoyzyTavbiMNdS/aWwEvMLiUt4gsa4Y/87wQwP39qAr8UDVXj7sss+KH51URM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357052; c=relaxed/simple;
	bh=Na3RrkoHwlZXB+6G0sX/Bj13vmuXaUzHP/feTxZ9p4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W2uq1z0O21gEZPNm0fKCymwZyPYZDbXV5yVcGN2/gs03xuitRzgfKANiL8qzjgtsyDWD4vgEZ/AgnAsMdRkw7KIW8J8qkk6Sz70MKJCFIq8oVUI0NMY35u/zAoUEU5pLtgTNvmWRx/iAhiPL0OEPVeMwU8noPi1xu+i4AuuHBog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V9TzDbwg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4774f41628bso5404115e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762357048; x=1762961848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W0gR74tfBv6fnJNcasqKiO9TcPjGtdefRdRG0G1TqsQ=;
        b=V9TzDbwgk4oruEDAAX323Aab6TfcAJaMtubwXdHGxXOWsvN7tmlmfqe8nG0OiH3txh
         J9X9msNsLOaFUTxElxwIg94ZNEwatcTSP9qp8pC/WWvmBnQOicKRuRynK0Tyr07hUmY+
         QgMW16tzpbw9mKzP0xoZhqTE3GwOlaCf24iUo1F/HjEPeEo9EGWAHVPt4D+Km1WhS8v4
         Lc+C0ABflHZ4LMHX9yIO5Es+qOrCsoh42ffFFv7PK9+ItMdkMmGxyTPVnrsRBr6JiS1D
         fsVTkgXjj+xQBNPWaxRhNTCMFlbWnIrBXL5SpnTRx/Mzf/vxI0dpmhtvgm1LwGJ/u+ln
         Rm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357048; x=1762961848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0gR74tfBv6fnJNcasqKiO9TcPjGtdefRdRG0G1TqsQ=;
        b=b+xVaxmjWklDgjE0A5rwQ7vqZhCjBqEBwbW6LEYFLmo3lGPvuu1QZ8QNDrcstCqEsb
         Bo6WwLySfmya773lNvZY8GEukKpiEJfD9sdUlfG0/mgVIfrtAOxiL4MHaIynvWGmS0uU
         bjVaFHRL2iZDvhFAvW8ai+ouIsIUIrBgfMeRAcWZtc/rOtpcdf0vcEZkTWxBedNxPs6b
         UfY8YGHv4rNda7crT1d0JH5Y3rTUmvs6+IiyNYhzvQXqWma0xP1YskqM8rMXfmL7OkRL
         dwZAAa54V7b9UBzvBK/+NT2rwpfkUMB1U08q4pQKuZALgOp4+u3KiM8AnUx4vnGPPb8G
         J85A==
X-Gm-Message-State: AOJu0YwlawP1tkSATji4o/YKihi9Gv2WKxuZsm6N+XNdg8RZtgnJcBSa
	yGr7wC9WdEArjcShQ8sqwGpq1pycNwdRBsuv7p5A0mSj0W08OofaTOgt2oORmcmjw8eDCSCfKn1
	U0Fye
X-Gm-Gg: ASbGnctohVXdtCl/wDau0M7GrzhauDggY8dEDrL7+Mtxj8JQPMbqfiRwH0O4WlwqSmk
	IMWbnqS6vuiFxMbPKX2jZMWVTzDTqxoxcxfuKVz1vEF8YvJbr6/mIKHcn+j9RieZid3wBVuucma
	P49eTMq1a8GqBxHI3YJK0DWmGIH2Zftto+t7I0EkP5yhtZ547zxPlLr7oiU/pzKjFvddF9W++cp
	J/FeWHt5Q8UyStgfffPDQsGW+aKN/ThaLFd0I/hl77Cmjzf9Fv91dZM59o977xKAuTT0Wetu0Af
	4D0pp5HLCAlFrqVFo0E7ZPHfd0lRzdXeitS+5T8Pi4UTJYmIrqmCWv8+mzEetamXfg4CapAQSbk
	cZ9F58p+P+JEyrUDN5BSfyKjWi/B3cIBwKHaAqqFSue09EtKjB6XPiQBnDJQlZ6uaE6yFgiXTX5
	PLu9tB2oieo+IvvNnPT+pzqew=
X-Google-Smtp-Source: AGHT+IGtmkFD9fDxmx2aRKORnBOzXJsHPATBzLIfnvJ6CDel21ZB2lIYgp+lbWPdHjcgbovHwakRhQ==
X-Received: by 2002:a05:6000:430d:b0:429:8fbc:9824 with SMTP id ffacd0b85a97d-429dbcc5c8amr7181329f8f.3.1762357048162;
        Wed, 05 Nov 2025 07:37:28 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fdef7sm11634497f8f.43.2025.11.05.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:37:27 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Marek Behun <kabel@kernel.org>
Subject: [PATCH] platform: cznic: turris-omnia-mcu: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 16:37:18 +0100
Message-ID: <20251105153718.274765-1-marco.crivellari@suse.com>
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

Replace system_wq with system_percpu_wq, keeping the same behavior.
The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/platform/cznic/turris-omnia-mcu-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/cznic/turris-omnia-mcu-gpio.c b/drivers/platform/cznic/turris-omnia-mcu-gpio.c
index 7f0ada4fa606..4e430d6c3fc4 100644
--- a/drivers/platform/cznic/turris-omnia-mcu-gpio.c
+++ b/drivers/platform/cznic/turris-omnia-mcu-gpio.c
@@ -893,7 +893,7 @@ static bool omnia_irq_read_pending_old(struct omnia_mcu *mcu,
 
 	if (status & OMNIA_STS_BUTTON_PRESSED) {
 		mcu->button_pressed_emul = true;
-		mod_delayed_work(system_wq, &mcu->button_release_emul_work,
+		mod_delayed_work(system_percpu_wq, &mcu->button_release_emul_work,
 				 msecs_to_jiffies(FRONT_BUTTON_RELEASE_DELAY_MS));
 	} else if (mcu->button_pressed_emul) {
 		status |= OMNIA_STS_BUTTON_PRESSED;
-- 
2.51.1


