Return-Path: <linux-kernel+bounces-884570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C21BC307A5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBA284ECB25
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08337314D1A;
	Tue,  4 Nov 2025 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aTz7eAqE"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E15314A90
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762251796; cv=none; b=KgQXdhA3QWAtjGkW2kHZNRGjtbBE6/xRTO0Z5AsAuEOvrhdsBijvuE3AWMJkiQ/boT4tGyPEa40+poDvPqVEciqLR1krJndC+BcQr8M54oI5o3GnGVPVg9SaO5LmqaDkDNYsdlhfFwhL2CfeLms5/9sF5LpR2ERUjJaa0uajAPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762251796; c=relaxed/simple;
	bh=JiN5zRSgS7hbKTfA+TE3fwE94DEPB8B1lvln54KOk/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4dMu7LqkD9WKGeLqNDUrrhUzJ0YmoOzwzSoK5sj4OYeMZnaHoggmCPcbor/f51YccRuHote5VZdZteeoGgRQ4kQSA0acXAZUmv/FuW1lubIhC0HSKU6y7zULdz/QmkdScbpj9vqghPgs1UMnaJIqcsD6JsZ01gijcdtTmJr88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aTz7eAqE; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso980310566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 02:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762251790; x=1762856590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F5ReZ2sO1ifGE2LFSUDiqxuLt2EAfiZIaMd88MSsMsc=;
        b=aTz7eAqEWfzl9AKSpDDtvTg1znmgo2fvrtH2yogM/NdyMQz578VFLAP6Dx+VlUUyq7
         bEsiCBGE7WPbpwu7AJWNbTk4CtrZEd97lnt5R2lVYDGnwX/4cbrTDZ5Ft+N1v8n7UGYD
         p2zc6cmw2W/+RPGRyeZEpfRgOrEW/TW2HZfWoV36wXCehJU3Ffog0ytV0c+0K/LX53LA
         h8amw2apds5oUmDkLnO9QHBgnnUx22OwSIiRmCeQ1PP0xNQ3gkmbn16ag+fEhvHUn+O0
         fyn99o30QVH6Wu7sr1AZw+56yDTOTfOad1XNspAT265zb81/M56mVu3pBaNp+1vK/yeL
         MdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762251790; x=1762856590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5ReZ2sO1ifGE2LFSUDiqxuLt2EAfiZIaMd88MSsMsc=;
        b=H0iuxFxNlSZ7WHbXwZpaMi+8KW8q52oxJORQAl8JVjGxzoHbwvRDHNkA8koQC0XRHF
         t0vM1IjNvXe1lcjmr5heV0DCCNLzg8iRsPxqfOJKwMJ55iC77qqZd6wfxXNnQokfzPRm
         SW3BfD3vtQ0Czv5JIi3TJSLHfdeCaxD1sfwd8GXGk2Ul8IM+bo1sxP8jLi0c/Rv9Vnhb
         4YT4Xm+L+VyMv1Ulvl6SSKd3AL3sBQlv5RVKPIHI25pJgeU96WUMlGAps/XEsF8IoNIc
         U0lCZhpLIVS4Flo7piPQ66J12OJzh+fVSN7VhxpcU77X1tbpBijkovfisWfScb3LZBJu
         t9Ow==
X-Gm-Message-State: AOJu0YyuvUJ8Ou+xZQjy7HO5N+DiL0D9u897riKPPR8PQMnoBbji0Gnl
	fVkvvRsbWBMnsw4y+HVDmcnH8g5biL6QEIT4lRxpDfSF+BQHUgyOC97jEjc7oZpAxXmqr6tWMeb
	vU2wx
X-Gm-Gg: ASbGnct+RWQ8xUA2Ma3+ajHKvCFNE7qiBuRsrWeCQQtzCGOR6wwRsZ8lQ//X7XCxXKE
	DmiYm/KYthqeCPratdHCbQv2+xr+VIwelooxg75dbCN0elv24lEgaLVNTqkc6ehgZzWMM3QVTxX
	iNqR1vqSlXzG7R1RDMaAxVMFuXIxhSbE5XHR4eE91uZ6ilVrmH74zGxBmlK8DGgm7EyQRT1U8l9
	l8A+gTHCL5lgsBgknyoaVZI80mvMhQG4X5/rF4G+Y52DsZkMGqBYq04ok/ehRU025I/xj6TfMbX
	e0mrFHca8DnbAaBWbvaaTbYCd4fD2f2mSSuRc9SgsrwoaSaUj5vEUfCVkEzCKRK3ZWsK4VHCmxt
	6A2W+6r+nm25ZWERskJDePt7qiviqhjZe2khCsLN6whPUOHAGJzsG7F81H+JgztUj4ixSJj38sW
	VUkQI=
X-Google-Smtp-Source: AGHT+IGWDLrkGQTycS37vVNtt8N0T7C7MlaRLG8MWxJRzk8Dyu5UYLqwpV2UGQDLweeSm5p96/Ae9Q==
X-Received: by 2002:a17:907:94d5:b0:b70:cfe3:aae2 with SMTP id a640c23a62f3a-b70cfe3ac57mr612722666b.8.1762251790139;
        Tue, 04 Nov 2025 02:23:10 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6805da3sm1753752a12.15.2025.11.04.02.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:23:09 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	kernel@collabora.com
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Shreeya Patel <shreeya.patel@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH] media: synopsys: hdmirx: replace use of system_unbound_wq with system_dfl_wq
Date: Tue,  4 Nov 2025 11:20:48 +0100
Message-ID: <20251104102048.79374-1-marco.crivellari@suse.com>
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

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

system_dfl_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
index b7d278b3889f..da6a725e4fbe 100644
--- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
+++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
@@ -1735,7 +1735,7 @@ static void process_signal_change(struct snps_hdmirx_dev *hdmirx_dev)
 			   FIFO_UNDERFLOW_INT_EN |
 			   HDMIRX_AXI_ERROR_INT_EN, 0);
 	hdmirx_reset_dma(hdmirx_dev);
-	queue_delayed_work(system_unbound_wq,
+	queue_delayed_work(system_dfl_wq,
 			   &hdmirx_dev->delayed_work_res_change,
 			   msecs_to_jiffies(50));
 }
@@ -2190,7 +2190,7 @@ static void hdmirx_delayed_work_res_change(struct work_struct *work)
 
 		if (hdmirx_wait_signal_lock(hdmirx_dev)) {
 			hdmirx_plugout(hdmirx_dev);
-			queue_delayed_work(system_unbound_wq,
+			queue_delayed_work(system_dfl_wq,
 					   &hdmirx_dev->delayed_work_hotplug,
 					   msecs_to_jiffies(200));
 		} else {
@@ -2209,7 +2209,7 @@ static irqreturn_t hdmirx_5v_det_irq_handler(int irq, void *dev_id)
 	val = gpiod_get_value(hdmirx_dev->detect_5v_gpio);
 	v4l2_dbg(3, debug, &hdmirx_dev->v4l2_dev, "%s: 5v:%d\n", __func__, val);
 
-	queue_delayed_work(system_unbound_wq,
+	queue_delayed_work(system_dfl_wq,
 			   &hdmirx_dev->delayed_work_hotplug,
 			   msecs_to_jiffies(10));
 
@@ -2441,7 +2441,7 @@ static void hdmirx_enable_irq(struct device *dev)
 	enable_irq(hdmirx_dev->dma_irq);
 	enable_irq(hdmirx_dev->det_irq);
 
-	queue_delayed_work(system_unbound_wq,
+	queue_delayed_work(system_dfl_wq,
 			   &hdmirx_dev->delayed_work_hotplug,
 			   msecs_to_jiffies(110));
 }
-- 
2.51.1


