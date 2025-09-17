Return-Path: <linux-kernel+bounces-820429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F88B7DC93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DA0189B793
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F8D34AAE3;
	Wed, 17 Sep 2025 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ5DJzue"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C96285073
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103661; cv=none; b=rzEyo5Ez7ULQor0EHb/Sfx/Xj24xdI+kX36A3kI3i/G8aFvEDqOwxjm8gxzPLNq8/rreY0h/V+E3VeSfKrk2nvOO6G1khbybxurB7RgSx/TNd3772KdZIlIM/X2GmsPLYcXRf3KYoQVhChHaMSx+yIgmYiElccmO2MuHOUa5qBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103661; c=relaxed/simple;
	bh=79XxpwCu3fVL4v7JYlGHjCi3NPeqcX6mf5J7x6f3YwU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MquOKAgBJs+y9fwA/3K9DT4yqgjjzQAh4MaToMEAAX2o6L7mkb/rdjygVC6zCZ4U0ahbk3o+Alk1wlpgo/Z5FvfsjVYphIp/spNugGAHIbIOCxSzUsbxuT4Ysl7Okm1tpEpxGAmPNPVWu1cOylXXwJfuPK2V/PFX8Nuxz4YkQZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJ5DJzue; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7761bca481dso3699291b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758103659; x=1758708459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PWKk+L+NgCa/CznAlFierH4EX24Xz9GhhvirFRfuiOk=;
        b=gJ5DJzue+GpiW6zYJkTRyOIFd8VFq4TL1fJDtQVv+D8L1pTBk8J0WAbZW8PfHwuMsY
         TMQ6ExinwYOzNjw13XKeM81GCNxSHGe1JTMz3ObPjJIg6H+qH43FjBCT7O3gdYF/HKUS
         6qciQAWqKMKp9kEu0Gqi5N4Z6WFn91u0VlD9wBB+vRgtlzgGuc60cK1Ce97LLO0Vhdqy
         vNJUhRe5XczyMEFj7JBNtA3ovTd1BIjGRhabZjY9O0i2h4yG7DS6V0mSSJSAwtodBrla
         jhnoqgVc6BBduahNVctkgJkmri/5+lHO+ZWM9EUynjuZapdrfac2W0OIUYsEZ415v/HH
         GtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103659; x=1758708459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWKk+L+NgCa/CznAlFierH4EX24Xz9GhhvirFRfuiOk=;
        b=rlJZfwiia1r4jgPc+GS4IZX86EagMvX/ASzoSOpi2VFejYSm99u/1r6wlmNsiO4moD
         GYus0SbmRkg8eOOsrHhi1jjPF58JX+07tPvlcPAOKmiEG8wl1Y0fpz0VhcKEr086fgUA
         0b1sthtIWV3a1EHteSVEwB1Ycl+G7+rdiHCEXpfuJ9Nn0La7yjb8vDwTqK2YH+M3QPJK
         4FFiFgI9z9rlpBBDEtaGtjV7lANd9Ou0JV0VQiCEzwD1ojOFFM/pS31nZMkq+aIxyD0O
         EGmMaj6Aun/D4zyNgnbZku6+oeBdPUc9nXWcddeM1l8cteouki2H4IxP4E6bmZN3ZwX1
         xT0A==
X-Forwarded-Encrypted: i=1; AJvYcCWTQ/Tp+643aP9+CHZthn1JX9g+G+thsr7SBIIac57eB6bRJyRq8ZJhaTSMhRhb27Hr2MXfzHUrDX65OS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9vwWrSwza8hM2yOfmmFUXomdx7m1USab+4mLw2pOo1VQBkFXg
	u1QRy3BK0DtxG1gpHPajoqukrpuhoq3bofV981Ldmw9b+4Y/zTfbDXPm
X-Gm-Gg: ASbGncuQmHf6NE6oLXZhiFgbAdrqsOXNsTxE8xYLtq6QdMvNNS3eO04YnrSWZAOB5Qj
	EVQGPiJL8QR6h8s7laYk57/nyVqKAeMJ1yoPKAvvB7umipYBCHgQTlNyIYYBVEwER7N9n7Bwe1+
	p5VjurTURwku0gEf6teCAvLF5fI4SxafdWf3O6DR+63j3Icf0yyUqIISFjxRy8uOH9sXMTsibmJ
	NCiWrNxh8JwB/mFIeCNos2bnzeFjdmCuwfkWWWCW1XP41OH1+S8u9ALWpMygSHafTrsliRO0ma8
	EaiIzWOBChbsJtXzmGpo3TsjLhaH+a9Q3OXTIdR/JDVoDmXTdVMP/1PLtTgZFEO+tGp3GbyE9Or
	lgMDjjs/h8xqEq7JYilWFHa8cXEt7Bv4KJd1YqXSok8VRpA==
X-Google-Smtp-Source: AGHT+IF9K3dVlb8ccRBiSP5pGnBRvctukZ7RbjT4DoZUseVEPPY5yGUGZzfk2a28zPdCsJkcLZP4uQ==
X-Received: by 2002:a05:6a20:431c:b0:250:9175:96e8 with SMTP id adf61e73a8af0-27ab36d0dc4mr2205624637.45.1758103659082;
        Wed, 17 Sep 2025 03:07:39 -0700 (PDT)
Received: from localhost.localdomain ([115.42.62.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a398d26asm16652750a12.45.2025.09.17.03.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:07:38 -0700 (PDT)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/rxe: Fix race in do_task() when draining
Date: Wed, 17 Sep 2025 10:06:57 +0000
Message-Id: <20250917100657.1535424-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When do_task() exhausts its RXE_MAX_ITERATIONS budget, it unconditionally
sets the task state to TASK_STATE_IDLE to reschedule. This overwrites
the TASK_STATE_DRAINING state that may have been concurrently set by
rxe_cleanup_task() or rxe_disable_task().

This race condition breaks the cleanup and disable logic, which expects
the task to stop processing new work. The cleanup code may proceed while
do_task() reschedules itself, leading to a potential use-after-free.

This bug was introduced during the migration from tasklets to workqueues,
where the special handling for the draining case was lost.

Fix this by restoring the original behavior. If the state is
TASK_STATE_DRAINING when iterations are exhausted, continue the loop by
setting cont to 1. This allows new iterations to finish the remaining
work and reach the switch statement, which properly transitions the
state to TASK_STATE_DRAINED and stops the task as intended.

Fixes: 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 6f8f353e9583..f522820b950c 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -132,8 +132,12 @@ static void do_task(struct rxe_task *task)
 		 * yield the cpu and reschedule the task
 		 */
 		if (!ret) {
-			task->state = TASK_STATE_IDLE;
-			resched = 1;
+			if (task->state != TASK_STATE_DRAINING) {
+				task->state = TASK_STATE_IDLE;
+				resched = 1;
+			} else {
+				cont = 1;
+			}
 			goto exit;
 		}
 
-- 
2.25.1


