Return-Path: <linux-kernel+bounces-881800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD40C28F27
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 13:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 953A53AC28C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 12:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B46026E158;
	Sun,  2 Nov 2025 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk0Sp/EN"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9022156B
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762086327; cv=none; b=RL4Xnrx/t43WZyP3wY8LKBJDm9uXCxaMGWnVyJRBz7k3sCB9RplxPpM0TuWrujowqdlD1n7H+NC1am6vjIzljVJV3LXDaAhBXmbW9Fr/N1rKMeVhWNrKDzZd/0Y3Q+IbMgkR2rJF8XqqLOFQaMMUjvxbpjk4645E0J2XGzC3gYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762086327; c=relaxed/simple;
	bh=yZF+WLgpFJwG6Ifdb4BMMXdhCX9I6hZsJpmlieiQnIY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PlOT33dSeYCGZCcgf6Er9xIFPCaDppIafODS1qbXSbnt+7IvsGa2WRAwiftVU7/EtB/kc7TK0sNBkJmR60zzOYL/xMPOwv3U+1PpUw7myVLnueuOBy5Lin0HqRlW3ZTs/qke29nc/CS/WnwiWBhCqinIx+NdMSokFSuGphiGTIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk0Sp/EN; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33be037cf73so3756790a91.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 04:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762086325; x=1762691125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPAITQnPT8f3NoA/GWdr7roKgAtVZtrGCy1Wj82OPuM=;
        b=Kk0Sp/EN7GJn3uzS71DJbsPWve5EiSF/YqWmZhjNuVatDK9ZK9TiKyCsNipbTw7fB9
         OjDJVzyoj34zWU9Y6trqGXVPSN/zPm93Ox7mLd29OryfvEOqwrqE2FhjhS7sfG/e/QaF
         T7JRXVz3BhtHb/fAEtAfC1D6UAWliaU4qm3mSRalKdgrv8nRU9GBhjUMOnjd9eCrH7FS
         jaa9p1ZiOL+QKDG077essFOibtT/5BiwmwxwK/Y3lQTZcxnEwMrqJGeROndw7YRBk3ld
         QGcmzskE4SMupTrmc56fck6sJuIiM6vfjfgm7TpeXpU6lEI1ruuQwkZ0eKUzePNYI/Hc
         9oJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762086325; x=1762691125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPAITQnPT8f3NoA/GWdr7roKgAtVZtrGCy1Wj82OPuM=;
        b=G3i9VEKvblrKWFHzgti0vs1TehSwTd/5GT2928IN+fwEJ8BRkaRlSSi8oB7JH6OdjU
         sjhciUCnhG7ZhNNOOU6ZgRpXIW94IDxbsT+qGkmqs2JbAuVwbGwtKL2ypJWZE3hKgphB
         SWgghzH1+KbAOBehymcHwqptLOzDD8k39QC4gmv7JnSlZoBadTPlfj+lrk38CW/br4rw
         8F6NF2ngzCXWxSLtyUuPsZ1ekFthQxF/RaF6th2tDLBHn5NfuVEnHzNk0NOTzoRKi1j6
         TYJG+WLZwoRbWiepHAe1kbHQVTaDA0D7thsG59DoFMjgeC5uKHWEWwse0ozzp+pr3Byo
         jeoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkEXxroYAt55c51+hhlI3qJ9RblZ5Mbm2rxZonBQvCzIQo5Eu5klNVy2l4ALGdZKrNd+Dp0rCDVsiYh78=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC++4OY0Q/DSBxYZCyIirWgpTikr04pEqLXDo0YKI7CnpwrWGc
	0wUgm7j1rRbzGmKZYRO+U/Lse9tHIXESWhTJhWcgqUf8ucDluKQ4N/wBvYAqvQ==
X-Gm-Gg: ASbGnctoE65jjJjiXkrrrb2uJUn/5fQFTI828P8oBrn4NWfFzHiS7CS+aoP0ptjkDeK
	iJJiOJO1wrp6R7iuLXFt117ZMUWQ+9t209cQd/Qb2mw+Jkb8LKU3Y/PSopdu2qZ1XGENa4TK7u2
	9JZxbh5Y4XGjfIAZJa9EFz94JENm+TGXVlEnhrUdP/TUgw3wbOi0SvcpKrrQghL8AEyfDByo7Do
	CY488hr1tkSCvWihWNCTuEAztEzUhrV5oxAnGVPQv7IUvw+o0LZuYfLfolN6Gpt8GFphFfkgOLc
	2ykd09VUkOFjkCNABMXMOsQ2Dj19G2kyS2ilnZsSZPem99TKo1AbyFuDpDMkHnrXKasgcXpTGC3
	UHa6IOtTmtwRXpLNSzmAw35pB/SAVkaGf0YCcRq6RBpNWp0/HUUxBfAzBSYVkKl14RgDj8eXGVI
	0CIS5pCaKEE8Bt
X-Google-Smtp-Source: AGHT+IFUI2gNHERa8lGBYVJ/VPD+f7hRdUsFXFRALpACNDsX30CRFcgPNcaVtF1ojHFvmr9u62IrKQ==
X-Received: by 2002:a17:903:41d0:b0:295:5116:6a7d with SMTP id d9443c01a7336-29551166bf6mr61961075ad.4.1762086325495;
        Sun, 02 Nov 2025 04:25:25 -0800 (PST)
Received: from fedora ([2401:4900:1c6a:b269:720c:17be:423d:a240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2959e4e598csm14094225ad.36.2025.11.02.04.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 04:25:25 -0800 (PST)
From: Shi Hao <i.shihao.999@gmail.com>
To: koby.elbaz@intel.com
Cc: konstantin.sinyuk@intel.com,
	ogabbay@kernel.org,
	gregkh@linuxfoundation.org,
	linux@weissschuh.net,
	akpm@linux-foundation.org,
	tomer.tayar@intel.com,
	easwar.hariharan@linux.microsoft.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	i.shihao.999@gmail.com
Subject: [PATCH] accel: habanalabs: use alloc_ordered_workqueue()
Date: Sun,  2 Nov 2025 17:55:11 +0530
Message-ID: <20251102122511.21141-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated create_singlethread_workqueue() functions with
alloc_ordered_workqueue() since it aligns with current workqueue API
modernization efforts. The conversion is safe since destroy_workqueue()
is used for cleanup in both cases.

No functional changes intended.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/accel/habanalabs/common/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 999c92d7036e..d100a59c31fb 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -903,7 +903,7 @@ static int device_early_init(struct hl_device *hdev)

 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
 		snprintf(workq_name, 32, "hl%u-free-jobs-%u", hdev->cdev_idx, (u32) i);
-		hdev->cq_wq[i] = create_singlethread_workqueue(workq_name);
+		hdev->cq_wq[i] = alloc_ordered_workqueue(workq_name, 0);
 		if (hdev->cq_wq[i] == NULL) {
 			dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
 			rc = -ENOMEM;
@@ -912,7 +912,7 @@ static int device_early_init(struct hl_device *hdev)
 	}

 	snprintf(workq_name, 32, "hl%u-events", hdev->cdev_idx);
-	hdev->eq_wq = create_singlethread_workqueue(workq_name);
+	hdev->eq_wq = alloc_ordered_workqueue(workq_name, 0);
 	if (hdev->eq_wq == NULL) {
 		dev_err(hdev->dev, "Failed to allocate EQ workqueue\n");
 		rc = -ENOMEM;
@@ -958,7 +958,7 @@ static int device_early_init(struct hl_device *hdev)
 	hl_mem_mgr_init(hdev->dev, &hdev->kernel_mem_mgr);

 	snprintf(workq_name, 32, "hl%u_device_reset", hdev->cdev_idx);
-	hdev->reset_wq = create_singlethread_workqueue(workq_name);
+	hdev->reset_wq = alloc_ordered_workqueue(workq_name, 0);
 	if (!hdev->reset_wq) {
 		rc = -ENOMEM;
 		dev_err(hdev->dev, "Failed to create device reset WQ\n");
--
2.51.0


