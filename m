Return-Path: <linux-kernel+bounces-886263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86260C351D2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183EF1921D17
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE13043C5;
	Wed,  5 Nov 2025 10:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V48ADvGP"
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B72FB630
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338935; cv=none; b=hdfYIRIKdC9kjqpGLQt7uuRRqeRoxRtCnVL1KhJF+4Ib2+h5AA7gDrV1CZGzPUS7NQk00U4EKSZDwvNzvy2Lqxqm5g6me2auEnaYnKvEqFwy7Sg0pJc5+iAIrYtiYJglVTjMe1Ltfzba+P8Q7cWHgHh6PNNOOJbuaDG5ADtr8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338935; c=relaxed/simple;
	bh=7GtDYEcpQHm/k2cpAEkhyEX6WOZzt9cyF6ww07aUpA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vvc6suH1wWUGoBVCWKLDaKMLuPcYa7VNbAgehWsvPYzKq/vE3tPpiiRTzvcLdPcGGFkTpcz3crT7hufY2yMCeTXYHdFQuspZRxnCgtRuEIfTBnImwLniys7ORLnNVF/yrODNEZ74vG4ADER1nyVTWFDiG/juQ0J9/M0nzMIecjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=V48ADvGP; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-47114a40161so16607585e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762338932; x=1762943732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnTcj+uqHxj9zlocBkSTKNzsaDjt8qwc3bgNROERDqs=;
        b=V48ADvGPQpb+MlvYQw0lK/wxvrNh/+uS7tWvbIO2Y7WIcqB2vT67og2pSTaMiy9FJv
         B5pfvBs3oouoGmaZKWXLWiLR4RhHwAdxVQQTyNAESujr7VbBUc6hKUuS95l3JW3RZTH9
         Niu47bHi/9WGeyTOJrSYnyNr7PL7wkAjkQzAfdrMKs5jOtgZ7HMBdlw0WnbP/vFpKAol
         Oe6OGqwgLmLPS8pTU+KX3R1PXxtSic0iHb5RgAYbdij+4ShwCKUR2cFGig9ME+mlEAKo
         yQKB3AxTH5ZmDE2BDH3z/4+maVy4p9tfTdaNWV0mMI0sAjl18ppi39ZVWDNMDIBOEY5M
         mUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338932; x=1762943732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnTcj+uqHxj9zlocBkSTKNzsaDjt8qwc3bgNROERDqs=;
        b=vBPTWCrf6fQvCvjg2vf780lWYZq2tInPSWLXDMsU6EH3x43YqFZkrnkGLYBHrqXEtY
         Pfg+62YX7vw7cMo2qLY+kwqjN3CnGhu0hqG/2Df69/9vw6wagsoBLsP6PjyTUjGqgwXG
         uKn+SvTbgTDIIGCqy5gyx4QZRR3ENPn/3WF16ZTEZAUQeJXcRxYFqHaTdjZ6mVlfDE+9
         0revd0PYId0B8EPKZjXI9CqzaHWPQZAJfEjqkhfoKuvS9unKsKl7/E9IyLrOQ9FND5EV
         TvUpjL64k+bC1wp5dqy7ZQiSgB5enu2Qv+ovhnJiBbSLlvzTjIB0UrZ/MP+gKfT3JfGd
         uUHA==
X-Gm-Message-State: AOJu0YzMdYTBi+/N57HGKlFWzDs7sO/1hvbyXmi+RDC4rI+wkDXxwiu/
	2ZjamF1Wqpx+/J8MZtAbZX9dMiEVbr7FWihaODvpnrQo8ZQuCVA+BATsLNgEgMXQ2z4OKpL2v4r
	Tax8u3to=
X-Gm-Gg: ASbGncu0fZ5GJshppOEpXNHU2q9oSxJWf1QE2wJwP9rscUjwMzwUk7NEyLxNL3zEqMC
	a7z4klJYHD96QPRJQgPQkAGZqnvLEYR0tMjLsPm7pfLwyJgSBb/kXCe0uQV7ADRG+QCJzHC7oyf
	pKMi4fmhx9T8CFR67qcO9LgCDpZAXSOITPL7CW2JTcsV3b6HpSrHmugx3iy2OtufXfoJS3RiNKS
	SEwPehloYFcyDG3VUANdVnw+pBPuMY8lQv65eGmcya4JtkLphUvp0ZLEIAz8PQ4bU0EFU/ysGHi
	YvU8Tuj/EQScuh9oLro9nKUnjlQD2iuOmxc5PSv7N/uVVJ0djADZt1Ksy4d3Hu8XtKRiiSAB7fn
	V2C904bvfK+baRgWbDwTkdSvFaZDrC2L4e1DKFCnjpWfJeU9jyLhd3DUeqCGpcc3fEzRVku2uOw
	7maqqm3ubQ46VoGDWISYy0hjpP
X-Google-Smtp-Source: AGHT+IF/Kjv6keF0dVFlq2e7G/uaOM8tjH7gF1BnkhBuMd+aZwUz2zSj9lYOHeyhfgewGMiByThlVg==
X-Received: by 2002:a05:600c:4e53:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-4775ce14d69mr18173955e9.31.1762338931773;
        Wed, 05 Nov 2025 02:35:31 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm9924053f8f.34.2025.11.05.02.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:35:31 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/4] Input: palmas-pwrbutton - replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 11:35:21 +0100
Message-ID: <20251105103523.103622-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105103523.103622-1-marco.crivellari@suse.com>
References: <20251105103523.103622-1-marco.crivellari@suse.com>
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

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/input/misc/palmas-pwrbutton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
index 39fc451c56e9..2d471165334a 100644
--- a/drivers/input/misc/palmas-pwrbutton.c
+++ b/drivers/input/misc/palmas-pwrbutton.c
@@ -91,7 +91,7 @@ static irqreturn_t pwron_irq(int irq, void *palmas_pwron)
 	pm_wakeup_event(input_dev->dev.parent, 0);
 	input_sync(input_dev);
 
-	mod_delayed_work(system_wq, &pwron->input_work,
+	mod_delayed_work(system_percpu_wq, &pwron->input_work,
 			 msecs_to_jiffies(PALMAS_PWR_KEY_Q_TIME_MS));
 
 	return IRQ_HANDLED;
-- 
2.51.1


