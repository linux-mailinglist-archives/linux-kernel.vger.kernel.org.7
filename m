Return-Path: <linux-kernel+bounces-886264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C9BC351D5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA463B6017
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249A7304BB5;
	Wed,  5 Nov 2025 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jv1aTmcB"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A809302767
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338936; cv=none; b=ZgeMKtHTwL+l2/fdI9nrgoefljlIKtOHao3X9JTm0OYEAninrHdFZv0/Gh5Vr/uLr3yxVpiUgFhGpsWYMeE7yZcAEBmzPvleKXWCF0rzglxUJaO/PP5wRrtCH6E9vA5alz8flM02ubH4MDJegsGUmTHFD8wii+kepEax2NTITtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338936; c=relaxed/simple;
	bh=yQWNSaUUwgQgN2VFDTHYdi8PjODCWMlHlgluCXS759s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctxxo4N3JsJqrOiqgLWXKlnoQhY6hhY1eX786fkz/F49wChuXMJv8I5ZSlFSlzNesCttfb57P8Kt10OPf9d93d2AaQ5sGYj8T9VuAdLcF0Y6dTxbPd7oFL0G9GnTJdG+HeIFcRdSzpEQQVWQuV97xBGic+BsDWssVYl7IyPHQB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jv1aTmcB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429bccca1e8so3233212f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762338933; x=1762943733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PKpcSlksAOjg1bpKhuMTik8R4CLWI2iP3FPu/LOjrk=;
        b=Jv1aTmcBxQLh908WpTAJIsJ3P5qETR/GvstAPlnynR9NzjluP6YomtO96LX2swJOBu
         qE/VsXLVosleHmfIdXWuOSlwmi+dBDcW7m/Ic3uJSb3IYHb9Vv9hqjLkPu0cs5xmGYMy
         etDsaGuaCp8j4eT8VAd+tzNQEyaQLGL2r2AmM9XRNqt/N5bsOVhjSMAAv8OX+NXGdwjf
         1XXTkB5tns8Cq7FE1Grlvk3hbGjLvP1aNCpUP8uw7q6cwGNzNnJGkxu4zPwOeUkTDE6N
         wZpxiyXWHoYGXz2S2JbPiMpBVy0l/BKMZejpfo/zI7ugD5mVGM9sm6zdUImM25WVu9wr
         fRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338933; x=1762943733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PKpcSlksAOjg1bpKhuMTik8R4CLWI2iP3FPu/LOjrk=;
        b=B79pUvG3dbskp9ui5fUeAeHnFwt5oDePrBWQ8EhWGeCnZHyKsx2WbESQfFXD9hdqZU
         KvDd3NiwwKxeEIhLetjcLvYW450F5Mf4qzy0hwqt1ChGIxRj0grQSyT81cbb/UV6FSJz
         WfulbPxhe/Dj/Ys/cPgexT0I9asKaG+ucoBVhLCcBwpFBii3JRem89cpvxTuZkLZlHIp
         ybeZpOXK+DFocN65Q68bxFlImyj/gpbz45fj8kSxOUQ1vrlD5OTqHNSDLBegPSlul+DK
         y4W/HCCJWuR6qx8r8oIjfOR1Vl8505uRCSm1zuu5L2b7LNhIIpUXkmO3HZehB6gcgtV2
         FxsQ==
X-Gm-Message-State: AOJu0YzEn0GqgxP2+rNK9n01nvWNTmEdJ5qkKM0TPa6DMsFEciBf5KNa
	VfLdQCuRD8vU8lh1r5rE7/Sqmo66S9Lz2EiMZyKi5j5+FbZpc3OxoE6E+Z3T+2nwYMRtQ8eZG6F
	sUfnI
X-Gm-Gg: ASbGnctFZZfEg7A7E0oHTceLt45TutzIu230iwHTfTNR+NTllqIniEHy72l29dJCrIN
	LdHa48HumD6/6vHcG0ZFO9SGUrvcKSogFHpKsn2/vzaUcXALiVK0e5pz6lZRrDFeWfKeP4aaidw
	Hl8pDo7UfJqiQqabklxWxe9sFE+WI7l6mhJtJmv3KR7Yw/RnfVBlSeXGSYnxzHwlZQ/qcUcnP4s
	a/U5mb5juhce1SVaim3W6F4RPA5GUXJsqVPZQZqvTxBchNBn17mjezS4wmtU2P5HOfIqEOCLZm1
	ew+Ry+w6FAZOBlfQ3ejq1UPv7n7xCX9rQsGZHNSDaJ+fzxOOMm5XjShN7IozqCEmmZVzpu8WQ10
	qDKJ2U5Q442nxZCs/0hBsuuNsKcT3AWqq3POAV3NtlSOx/DgkJx0UuDybt1zv1ObEU4biNU2es0
	bJO3UlQgcwvfRqhM3BuNo9s3p2
X-Google-Smtp-Source: AGHT+IH0cV0/d/aLL8pmsW5H1quW5zXkuj+DouBFgJmi4MrqNq+xfInqJNpalGNlfdknwRlZZqyghg==
X-Received: by 2002:a05:6000:220e:b0:429:d742:87d8 with SMTP id ffacd0b85a97d-429e32e45dfmr1859167f8f.20.1762338932650;
        Wed, 05 Nov 2025 02:35:32 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm9924053f8f.34.2025.11.05.02.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:35:32 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/4] Input: mouse - replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 11:35:22 +0100
Message-ID: <20251105103523.103622-4-marco.crivellari@suse.com>
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
 drivers/input/mouse/synaptics_i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index a0d707e47d93..d42c562c05e3 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -372,7 +372,7 @@ static irqreturn_t synaptics_i2c_irq(int irq, void *dev_id)
 {
 	struct synaptics_i2c *touch = dev_id;
 
-	mod_delayed_work(system_wq, &touch->dwork, 0);
+	mod_delayed_work(system_percpu_wq, &touch->dwork, 0);
 
 	return IRQ_HANDLED;
 }
@@ -448,7 +448,7 @@ static void synaptics_i2c_work_handler(struct work_struct *work)
 	 * We poll the device once in THREAD_IRQ_SLEEP_SECS and
 	 * if error is detected, we try to reset and reconfigure the touchpad.
 	 */
-	mod_delayed_work(system_wq, &touch->dwork, delay);
+	mod_delayed_work(system_percpu_wq, &touch->dwork, delay);
 }
 
 static int synaptics_i2c_open(struct input_dev *input)
@@ -461,7 +461,7 @@ static int synaptics_i2c_open(struct input_dev *input)
 		return ret;
 
 	if (polling_req)
-		mod_delayed_work(system_wq, &touch->dwork,
+		mod_delayed_work(system_percpu_wq, &touch->dwork,
 				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
 	return 0;
@@ -620,7 +620,7 @@ static int synaptics_i2c_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	mod_delayed_work(system_wq, &touch->dwork,
+	mod_delayed_work(system_percpu_wq, &touch->dwork,
 				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
 
 	return 0;
-- 
2.51.1


