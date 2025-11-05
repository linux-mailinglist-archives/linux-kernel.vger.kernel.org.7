Return-Path: <linux-kernel+bounces-886358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 319CAC35527
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 442744F472D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DD930F95C;
	Wed,  5 Nov 2025 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gxcZwYrT"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEF73081D5
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341576; cv=none; b=QoyP7J6eRFIjnl8vmUjyRZjTMY54rA+g1mjJE5NM4+yOMy6Ov/eOBOGQMNXpC1DIXbDUde0WymjLAU1IMpG2ar4nEYrKyirentp77OT7ZJeM16bqKPMLsmVbwgUoHnWae7kxkOeVE3SZOy4hCKyxH8GZB16imYGADoNmlGa4nOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341576; c=relaxed/simple;
	bh=aabsKPFWol3OJ7wY7wf6TtpPtGBpyhyhY9TUbSJJLII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLRI1CixXUOK17fXv0UH7OtPqBoOq4jWJrBbFCSjmJh48JGwyOSMj0VElHmy75ztOyE4RERl2ge7cAfGkIHtMSHHv+Pgeb8i6xj/CSHlEtlU5u6cQ1dBl9rEKJra9Zl+oX39r5tfpweqfZP8ikaStxuxq1CML69QJLedYQPk/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gxcZwYrT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4711810948aso46646565e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762341572; x=1762946372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M9ZoeKzZOBJ8O1X8YsczWn8JrsyIoqb3TF8bG5VlZ6s=;
        b=gxcZwYrThlYwvVzeZKCV6YCiFl68AYnDBcZ/ON+/fTmenZ7dGwzLy099V96we8AUq8
         0fMYfLrEOb0AIZRXI1IBSYoQo42fhB8uDl13F7N6C782Hi/KR5TQowGLwohaqiBBvr6y
         ybH02b8cSHt5hCuYf90GTUVaYlrfGlY1QQ7jOihb3LmjcqgRNdlBVVRXJGJt7Qxfcnx3
         4bw02aRP+HEfI9csdmjJ3aBzZRQV7Hk7y2rAbtAkOexbhXEV3t5xv0ni/ZrLwbdltd99
         eY9X/WerPHbL7XPr4I8RpC0P+gX3fnRbKmb0hncDEijsv3bgd9UUVK/LIQsZDRfTtC5p
         GL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341572; x=1762946372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9ZoeKzZOBJ8O1X8YsczWn8JrsyIoqb3TF8bG5VlZ6s=;
        b=fl2UVgkyH3LjA5XaEk79RAWhnneSD26M1yEwOCpVQRgOwOjZyK5QAf8E57Qp9oeVqH
         XmuAPbcGBOSMcjl1tOau8LMw21L5dMo9Wg15VBsifrvTCee84dFTyDukCSTGBR3sKudW
         N2MhrOLsPhjLOjdDcplK5OqSp/klrCH4QnvNH1xCbTktEVW04mfoSqaPFVHWS5lnC3uM
         C/CU00lQ6RH/sEcxfEVGKcKuAldU5xkH+HpfMSx8TpAgosE6bhYAX6R8GOW6kqZUencs
         caXoExRaiYIHMWC2VPq5thZkNnQGnfGFqcYmYckx3igmz7z0CimOJtYh0Z1xdgwCBZ9B
         SL8g==
X-Gm-Message-State: AOJu0YwdcR+GSEdd03lv5YnjvxJm8p0bATwMJZ0XduE1QOEzIrlP9waC
	7jCH9cuun9uFn2k3us7FhVcujquCJ076QbpLAiBMGIdwpKwbn47Pk1lix8/WP9jbMLutT5gg25O
	9d7in
X-Gm-Gg: ASbGncsjrCv/3F3M5LbDwrsDHw8y9jh8BxlAyDNfI1ucV273jUxMHpgPmImufx4biZn
	FYNdGVELcEd146uEENx1c21Vmtgv1bpoClGPOYXreCOginQ9UHd4yxwxFw+93G7wNTQ/Ega0mP5
	z+5UNafwtwHLU8iCtrtQsqcTmeGoAPwn6hWOaFmCtrVNQbXz7+DwzjAhNsR9lH5A26Ee2xZhKsV
	aIcdOlFxA98f9vO0B3uxmmq4XVOnh2S29F3NfGLs26n9v+YQFOb8aAMzAKRFYcxeXQk3Uta+U0o
	rW2IhNZj375vKh6dJLRiyg1Mxykhzy7JcZ+18h5iX+YGBv8f/tzbOK3zZW1OGKklDZj1JbzFEw4
	YiwuLTTKdV1VERyxN8yNEXgW3SG5kr6MdYlf+si3HFM5zsXQZnsNhlCXHrIMAVzjbioaK+WGInq
	Qxa8rWSWkfftH+2ilbtg9o+Fcjhrk38Irpl+s=
X-Google-Smtp-Source: AGHT+IFvzesjCO25PoLrWQtVvB99hETRDXusyKHlx8TTYHHN77FB5rlYFu4DB6U/Ofm98Y0XnPco6g==
X-Received: by 2002:a05:600c:5304:b0:46e:4883:27d with SMTP id 5b1f17b1804b1-4775ce15c6cmr26611165e9.30.1762341571929;
        Wed, 05 Nov 2025 03:19:31 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755930592sm39499405e9.12.2025.11.05.03.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:19:31 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Pavel Machek <pavel@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH] leds: trigger: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 12:19:24 +0100
Message-ID: <20251105111924.141555-1-marco.crivellari@suse.com>
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

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/leds/trigger/ledtrig-input-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-input-events.c b/drivers/leds/trigger/ledtrig-input-events.c
index 1c79731562c2..3c6414259c27 100644
--- a/drivers/leds/trigger/ledtrig-input-events.c
+++ b/drivers/leds/trigger/ledtrig-input-events.c
@@ -66,7 +66,7 @@ static void input_events_event(struct input_handle *handle, unsigned int type,
 
 	spin_unlock_irqrestore(&data->lock, flags);
 
-	mod_delayed_work(system_wq, &data->work, led_off_delay);
+	mod_delayed_work(system_percpu_wq, &data->work, led_off_delay);
 }
 
 static int input_events_connect(struct input_handler *handler, struct input_dev *dev,
-- 
2.51.1


