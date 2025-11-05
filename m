Return-Path: <linux-kernel+bounces-886832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA8EC3684F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0075E34EBF9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10129333727;
	Wed,  5 Nov 2025 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VTLsx2t6"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB6329386
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358282; cv=none; b=Fwt9z8qQiUWXF6VbHkJCQUHAGv214jBXgCnRbPaE3+o7bmoAxWgiz9wxLaHiQ+SvjETOeC0flT8vGNXCJH+ZG8GKo0gl7Ym9cRp2ychlKxdW0WLuTzgI7qMdSe+KqPOLllQmnDDZmIF48Za+WXeQuBAfBQtnCf7OGI9r1MgZPZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358282; c=relaxed/simple;
	bh=0juMyDMRUXKUaPALyDvOumxXmXJXFGZjKJfB24N29Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoGZdGRlRHkwyQbWP/siZMrNBiE4mdijNA+N1c4A/XxUsLnu4XIWDOxizIJ3CWJzrye61HRzaDYCA6zgJ1sP4FYkm1XyDBiXtMYtdIeIFyMD4iyVqmTc5q7x8xPCkZq4zyw/bMYzpKEI4wW1EY2f+2w8Uk2YpDh9miuNh3U+kBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VTLsx2t6; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710665e7deso32142355e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762358278; x=1762963078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjaDKV9LCQmWEfoKcz3mnBs+RpSagfYrbdY3gsz2Kew=;
        b=VTLsx2t6s+zH9HONiaR0NYX9F7mI34dz9yxpqaGF76pCpi4b8Qg6NBL8W/lVmDQaVn
         692zhEusRy360woolElvu5Zi36NGpm1yJkPBp0pEv7C/Vp3Iqm+c/CJUp4f5EtbK/Ha9
         ZRTZpMo0+O0KJaYye2WpRgqDmy5bP9VwsCdgn7I6zboMQ4WHqFsOg1XDAdjX4e0/5god
         1GZxWrMOMzz+xr5yetn9O25DAXROzZbRkazFvrVqVf4psxyX/rNPq4l9k3uj6PrgKuBa
         r3mo/02Q5KTDbbOwPuXrjYGNCHZczAHhS37bZH1ax0wIbPro32Ws7YhHAmmHSGS/nGkI
         /4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358278; x=1762963078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjaDKV9LCQmWEfoKcz3mnBs+RpSagfYrbdY3gsz2Kew=;
        b=D9CDYng6T/KZnuJ+HJCZ4O+KjiVxbI2oKEmFQ++fFgN2tyQ5tkG1Ire4zbah9O/cV5
         0/SQvCz8KwAoVBOAWuK/qX0IybQmtytCcFtV1VVoK6b+65zKj4fpzCyQ0uUm0a56LloM
         klU8fADMCBwFllA15RSlXBwUsgHpL4GiYvN/uc/5lTZe7ECLFMr0SE9A9/k/JheHWklt
         ScqXSmQqHukgpGF4GfPJRVFdd0+t7NKcF2nxY5qq8fWTrYErPYs2xRSed7bL5PC/7zIt
         YmpxP5+D09rOo3bgC9YZ/inKD1CxMMg97nG5Bv6Vt5uNg+SGOzlKX5PLuoGTXEYhpb7L
         25ug==
X-Gm-Message-State: AOJu0YzsvNpMChXFxQhy+jnHye2V2XUJuyt+u447rkuJjXEmYRHpKITE
	stNuRYKy6QezXmJFgFlEEGZze0ZhYdW0Vt1C1IyG6SLV+GZ3UGHP8USYx64gPXZD8/3obrW3Nln
	EQipo
X-Gm-Gg: ASbGnctqrRkQJ8we1+8ieVbPKb0KoGW+ynZx1Z41rb5ko4mLnpU5C8+h1ZoNfA7l43b
	ClNcY78J+h9tf8VgphPCKAI67c9gNfHOKiJ6WUt/BdAaf7IeYIHouEsrV+KHwS9OKrJLQTYvS2M
	Blf65GvMaXAEavjdpN6km0JH13tuy2nSkx7a0d3eBn+Amw/5CYiwhnfaWwR92A9C8xKelJD5K5y
	iXzihVOkAN1sAhDd1/PIcY7hSdsaIFoQS3caGnPmGVQewAScKzcyZXRx5X6Q8Ok9Dxw9ki2znBZ
	IBwBBfvbpLqg546R5Dp6T5UFE1RYRZQJ6RzwZszT8oPKgvarE0OHPNbgve2gG+3s5uJeES0bevY
	NUcs6I6qGX6YFtG/8OMIlqjTogjKZ72NajuqdbaDDMfU/cs4pWQCTXqyb/d7+Le31V6I2gS7sIH
	YUJUlloqaRgHv/nSngwDutbAp3yzfbo2PSNw==
X-Google-Smtp-Source: AGHT+IFmHmXfTRK5ZoJhOa+eElcl7UkfXFONMs9IfbNmfXHDnWFTChL/HrvqCSssLTLQgY2Gg0zfEQ==
X-Received: by 2002:a05:600c:821b:b0:471:b5d:2db9 with SMTP id 5b1f17b1804b1-4775cdf26edmr38095045e9.21.1762358278377;
        Wed, 05 Nov 2025 07:57:58 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdc2d14sm55567045e9.1.2025.11.05.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:57:57 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 1/2] platform: surface: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 16:57:35 +0100
Message-ID: <20251105155742.293326-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105155742.293326-1-marco.crivellari@suse.com>
References: <20251105155742.293326-1-marco.crivellari@suse.com>
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

CC: Maximilian Luz <luzmaximilian@gmail.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/platform/surface/aggregator/ssh_packet_layer.c  | 2 +-
 drivers/platform/surface/aggregator/ssh_request_layer.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/surface/aggregator/ssh_packet_layer.c b/drivers/platform/surface/aggregator/ssh_packet_layer.c
index 6081b0146d5f..3dd22856570f 100644
--- a/drivers/platform/surface/aggregator/ssh_packet_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_packet_layer.c
@@ -671,7 +671,7 @@ static void ssh_ptl_timeout_reaper_mod(struct ssh_ptl *ptl, ktime_t now,
 	/* Re-adjust / schedule reaper only if it is above resolution delta. */
 	if (ktime_before(aexp, ptl->rtx_timeout.expires)) {
 		ptl->rtx_timeout.expires = expires;
-		mod_delayed_work(system_wq, &ptl->rtx_timeout.reaper, delta);
+		mod_delayed_work(system_percpu_wq, &ptl->rtx_timeout.reaper, delta);
 	}
 
 	spin_unlock(&ptl->rtx_timeout.lock);
diff --git a/drivers/platform/surface/aggregator/ssh_request_layer.c b/drivers/platform/surface/aggregator/ssh_request_layer.c
index 879ca9ee7ff6..a356e4956562 100644
--- a/drivers/platform/surface/aggregator/ssh_request_layer.c
+++ b/drivers/platform/surface/aggregator/ssh_request_layer.c
@@ -434,7 +434,7 @@ static void ssh_rtl_timeout_reaper_mod(struct ssh_rtl *rtl, ktime_t now,
 	/* Re-adjust / schedule reaper only if it is above resolution delta. */
 	if (ktime_before(aexp, rtl->rtx_timeout.expires)) {
 		rtl->rtx_timeout.expires = expires;
-		mod_delayed_work(system_wq, &rtl->rtx_timeout.reaper, delta);
+		mod_delayed_work(system_percpu_wq, &rtl->rtx_timeout.reaper, delta);
 	}
 
 	spin_unlock(&rtl->rtx_timeout.lock);
-- 
2.51.1


