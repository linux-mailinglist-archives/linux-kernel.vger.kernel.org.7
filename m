Return-Path: <linux-kernel+bounces-888713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FE5C3BC01
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BEE562AB0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD6F3446B4;
	Thu,  6 Nov 2025 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RwE0yhD/"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85132E6B0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438812; cv=none; b=Y01IZaEm6ctG/p5Pzz9MUtTkE+Ca5aHYuM64k3juiMp5Srq7SrlVDAFMkW/Pr0eO1D1xNZykVSZqlDc87mk+R7rAACm2NfuKd/b7DB5lNvBrVo62J5848/F26J6HMXyUiN3E2e9KOxBdoU2/HvPA7CDnqEG3aCp4V7J2KDzBO/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438812; c=relaxed/simple;
	bh=ne64ZMpOHv5JrJYTl+IV6blK6HhNvZS3fCmagvcA/EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dz/mA0buls7GZwDZ1pDwft5ofCP8htGU+AAIji1cqrMBvuO/FdeNnhsuvfWb3JC4SCCothRVcDglK4xSLiB7DSpsfhLB0UdHgA5nrzz6f45HJ4Jp3+HD5MQZeqJOx+cGI06zD/Enejo25gMC/Y5UEZi5bAj02o5Hg2KAkkHGD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RwE0yhD/; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-429c82bf86bso735266f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762438809; x=1763043609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tvl0FaCGGvCd+ecMva35yR/ysW/rAFJwtlTSjqQndyw=;
        b=RwE0yhD/6m37I30+PO+KKv4HTSyQIHtfQT8Y1HoEga66NtvKriWwGH6P3lCFi0rgWW
         9DkA3CVQQ8YWnmcWTeXeWhQtTQQUnncBxLJej9BnQKJ6NUg/aI+WONJqAOsGSXdBKXIw
         ykvMU6Fav6zOhksN8Ce5/P56jigXyP+U/kx7zuUCdh53UjcSZ26i9vxppU9RmbM1J1Zw
         Fj9iQGRhAT8t6bwR9EU2HktQgqzxyMgq7ZaDkndGcF7RxqdS+gZtsNifwOpvtEAmNEoj
         DkocOjbN97atvVuNSjMj9aod19QGk5e/W9yM1bh5A9yhKlvdeVQ08tGBcDgzmzilR2Ps
         56/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762438809; x=1763043609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tvl0FaCGGvCd+ecMva35yR/ysW/rAFJwtlTSjqQndyw=;
        b=HaWCV6VhSzGYbmqgaH21ntfiYwiuBBEEk4Ej6WoMIVvoJx7DHg8gCuvU71Cnp5C5n5
         zrAaoN8MS6zguXvhrTJgEEy7x9i1nbXNgsYwtHvudDjMWJUbFs8AOwNbK2XrFNNb6d3o
         42uHmJmrARfbFxjEkDH/Ve717BRsyr1m2yAnRZzIaY0oMJvnLCDLmsETSk9Yl52VHm/f
         lHt5ss4ClBfyuyJKOHlbtwwvqrMYax6G951tegdwPhxX18t9J2PKFyCMI/4mGwEGcYIe
         6YI+7BycAn3wxRrfaCs0MVaWXEoWgNbacyijL5d/6kP3lWpnRsfgxO/Ufe7jel2fGN/7
         3w6g==
X-Gm-Message-State: AOJu0YxXBpbLwXGV4HxI/e+3Mykj4roRwXONrXC5rJ8VqnsHTo8APUUh
	HB8F7MAOPI0G/moK1dXVT9lVnG4yWSSyJI5lOvXvA7sVHaaHwiUlYL3W3UL9WZeJT2+BRFmUNaC
	OhI0tELs=
X-Gm-Gg: ASbGncuGl2DAAjd39EJ/eCfLQ7Xx2DiiKbKYOrkPKgVxnQ5o+SVQB5nSBTkYMhKgj2P
	RfsgVPsq25sdFcMNsfBg/Lqp0twuXgMhS0dsqiAwEv3dxqwU+Fh24qN5tH/Zzm5vQP4si+spPz+
	t7WL3U4qS9b4CiMxTKMMPorr4QQoqa9Gxil6IgcgpRGSP8Zx8i+nEy4MGUDUNn7LQoQUcoorfgP
	xLlsgjCd94T9m0ZPcsz15jbJWEdpWyANeN0qxdX24hyv89+36VDdqXiD2D8mUG2n4hsfaAnjhYC
	Fr5oanQ6bUtX3hm1nRio4vxTwDE9PYAlna2SR584bYKaA8HjJhEjMIC7YHhOaeTAsxO0eU8ztNS
	czSKY6vdwdsnfhaSr3K8jdYDafmNz9dYKx/GZZt56gstVuDuyFgBFysVMyKeO1bO0KXppovOE5N
	2VPZd28U7ZFdZ8etFy1pxn0IFCpLIvXI1DzA==
X-Google-Smtp-Source: AGHT+IFl68/B9oFeZwFiwqtsa9uyiZlKZflUFx6d2HXKSbpyFcG05DLesWxzZYfX2T5uhbdPMVBT3g==
X-Received: by 2002:a05:6000:22c3:b0:427:900:68ac with SMTP id ffacd0b85a97d-429e3305d0amr6567727f8f.39.1762438808852;
        Thu, 06 Nov 2025 06:20:08 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49be96sm5255531f8f.35.2025.11.06.06.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:20:08 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 2/4] Input: palmas-pwrbutton - replace use of system_wq with system_dfl_wq
Date: Thu,  6 Nov 2025 15:19:53 +0100
Message-ID: <20251106141955.218911-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251106141955.218911-1-marco.crivellari@suse.com>
References: <20251106141955.218911-1-marco.crivellari@suse.com>
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

This specific workload do not benefit from a per-cpu workqueue, so use
the default unbound workqueue (system_dfl_wq) instead.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/input/misc/palmas-pwrbutton.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
index 39fc451c56e9..d9c5aae143dc 100644
--- a/drivers/input/misc/palmas-pwrbutton.c
+++ b/drivers/input/misc/palmas-pwrbutton.c
@@ -91,7 +91,7 @@ static irqreturn_t pwron_irq(int irq, void *palmas_pwron)
 	pm_wakeup_event(input_dev->dev.parent, 0);
 	input_sync(input_dev);
 
-	mod_delayed_work(system_wq, &pwron->input_work,
+	mod_delayed_work(system_dfl_wq, &pwron->input_work,
 			 msecs_to_jiffies(PALMAS_PWR_KEY_Q_TIME_MS));
 
 	return IRQ_HANDLED;
-- 
2.51.1


