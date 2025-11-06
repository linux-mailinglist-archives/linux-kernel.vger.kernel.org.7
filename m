Return-Path: <linux-kernel+bounces-888780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FE8C3BE53
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B74F4C93
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C011B3446C2;
	Thu,  6 Nov 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZRQ2CdTr"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D22314A62
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440616; cv=none; b=BSziffVq2iiBAJmbeaj9lSt801+ZtmpVg4+hz1hVUik3sKQfvgtgDJtTwPF/gOm4v21rzwHZKyJoLt/IVGXm8v8i4+aqgz0Zv105JzRkdtyCrmRJku1Y6/4IG4E1xPv18Niii1bN3FXS7cBkaMekq2G0vPL1k0qkWTfPgGKiD2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440616; c=relaxed/simple;
	bh=lH+dRzPdzs9ilCqrnljXat6niwfb9l9dK6HM/aEWRz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBcNCizBV/QZvkOxmOcRQ8VXBE3IxHKPHb8O6PMpoZcYqAeia9QO20OsyaMMnPN1rscNrG+cDX4ugoPEkGrMb/9/o6XQB4sGRTfMbsF+OjefknM4qjPQlEVlAucL+6eyZo67fzpGKAFH8z5fs/lRpg6J7F9g1/bkAoUbW4eWPe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZRQ2CdTr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47728f914a4so6400135e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762440611; x=1763045411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xPyWtxNj4oyHd2usnrxZrS333s1+6Us8v25kUZGu0Ms=;
        b=ZRQ2CdTrYY6yTmOgNbHBONWJwXzYYHFZOEFJIf7TjFm/okK71BMM2u3qxGjTC/ni6M
         0btSfHxIQWxDp2L7VKhL8JXpkdRukzozgnb7iEI4q5KqzSr87o7NS/wmXTlGDlbR6/n/
         MMSPyUJrprAewqOziW1t4uxaRF2pEXn9Cr6xTorJJyA+RJMcC2+/jtby9EyVD7ULLTYt
         hS5ZFjZqkVE3s6g0/3VNPY7CoweZ/w3Ia4kPIhoNPFVOQkgJDb/WRVzcxKR5EzNKLFht
         zHdTpzzyO7c4W2myxvv+YDC9CtBgFjB1NDWAPEzE4ECLGaRUPbT/v2qzhJNJtkGkZovm
         Yd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440611; x=1763045411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPyWtxNj4oyHd2usnrxZrS333s1+6Us8v25kUZGu0Ms=;
        b=mV7cW+DJahsphpzLpMiRqRauHoI2CinKZeEFELZr3t6H59kpunR5bEEHKLJmvM6dv6
         68mAzARiTXeP2a50AwIGOzweaz0wizEvT3KhNCWt9LLa4K/h5yLPrksmtb6zETHkYsoS
         fiCPWV0/1T7wOQVlA+8qrOdqbdeXficXcIe2VTfxcNzKaW9V4Za3h3TpoFXwzzrTGxxU
         C2cgN3e3br6S1apehbyPnx6BO/tATl0F8alsO8oOhkmYGJ+JP+42UY8cnADnPZchd3my
         O24buiVEKydZy+6xZvxpcrp7GWJmtWu/6guPdfCPCnU+y3wtIXsKFivE562FXO/KtR1z
         OalQ==
X-Gm-Message-State: AOJu0Yy2wyXUsT4HP5zOAyvyhm63vw4vXu1fQGC7NSJjIZaEUqUSxhOd
	fSujixCr4OxV6Q/3/jMM0AWdi9so4hkaZpsfgHZ7Fa+zOF2M5EF1G82p+zfLyme6FDp84N/MJKU
	WuS9K
X-Gm-Gg: ASbGncuS9uuL6b1a+UwWlxzzYisdrfG7pi56CnddHnb+DifSYdJc4kQwU0Og6hgaGN5
	QrHANwi5TWELO08WR+jlrxMncO3Xc+CXFTTugB4exzn8OE439gK4G2XpQT6rNNbEUDf8RrgcAJG
	VvNTvEMXm58IpUGs2GqAFbGRBTzP5QPOTfe+suAW+Iyca/ix5+Itwz56SZLqrZQn1/VXNn629rT
	JlAUvDxOifZvEcvy9lkTk0BEUix7qXk3R33Atj6gqSu2z8IQh6WrH90iMV7p5IioqFJrqV4T/b/
	Zmz9+jv4mteUA5IOBusKqD4hkuVG4Z1kEksphknejgqER7H9kRfGFfAFUvowxeTcP75p/fEm10G
	nDErtVO26K5PCkJHABfnDb9x/tN/ojm8StTEPLVKvjDuhgPKILturJsI6UxoH/NezdgQKAOepl0
	hFAYrjJru0Nn+SsCd36Jn+2p4=
X-Google-Smtp-Source: AGHT+IGBw8hgZO9ZeCLtRVjHd+533/r7fPmdgOo1/ZUErUhukgNXHrkqbH81/fl3KkzHzQWA2xHp+A==
X-Received: by 2002:a05:600c:4703:b0:477:639d:c85b with SMTP id 5b1f17b1804b1-477639dc896mr28671985e9.2.1762440610861;
        Thu, 06 Nov 2025 06:50:10 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdce8d2sm111566275e9.8.2025.11.06.06.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:50:10 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] regulator: qcomm-labibb: replace use of system_wq with system_dfl_wq
Date: Thu,  6 Nov 2025 15:50:03 +0100
Message-ID: <20251106145003.245866-1-marco.crivellari@suse.com>
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

This specific workload do not benefit from a per-cpu workqueue, so use
the default unbound workqueue (system_dfl_wq) instead.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/regulator/qcom-labibb-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/qcom-labibb-regulator.c b/drivers/regulator/qcom-labibb-regulator.c
index ba3f9391565f..1b14015caca6 100644
--- a/drivers/regulator/qcom-labibb-regulator.c
+++ b/drivers/regulator/qcom-labibb-regulator.c
@@ -230,7 +230,7 @@ static void qcom_labibb_ocp_recovery_worker(struct work_struct *work)
 	return;
 
 reschedule:
-	mod_delayed_work(system_wq, &vreg->ocp_recovery_work,
+	mod_delayed_work(system_dfl_wq, &vreg->ocp_recovery_work,
 			 msecs_to_jiffies(OCP_RECOVERY_INTERVAL_MS));
 }
 
@@ -510,7 +510,7 @@ static void qcom_labibb_sc_recovery_worker(struct work_struct *work)
 	 * taking action is not truly urgent anymore.
 	 */
 	vreg->sc_count++;
-	mod_delayed_work(system_wq, &vreg->sc_recovery_work,
+	mod_delayed_work(system_dfl_wq, &vreg->sc_recovery_work,
 			 msecs_to_jiffies(SC_RECOVERY_INTERVAL_MS));
 }
 
-- 
2.51.1


