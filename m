Return-Path: <linux-kernel+bounces-731550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DDCB05618
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE5D188D5D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD84D2D4B7E;
	Tue, 15 Jul 2025 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnOq2vY6"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7744A2D46D1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571121; cv=none; b=bvCP6pXMlWRuNyRTpJkFBAw4Eo3DlOOB8DwLcd9YOI+oW8yBz8DkRLiuzKOYB//romMBZRgTGbLLOpKgm8S2hvBUq7A0cA6WQoXayG9g8XI6JeSnjIrYJ4/0uuvKULuUKd2OwyddCJJReuGStfn97QDXzqK30z/EucNQCSgwBh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571121; c=relaxed/simple;
	bh=rpWyeoOVrCxoR6/Ur0nB8earE4j/b1kvwmIic1K2BGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q6QvI9Gji+wIgXFDWsn2WZSArCXbN0KA19elbD7brtysUJxQIXEKk2dZUdKaBMeHpJ48CwmWLp9UbcermQR980pAwwNmfZivSVZR2kWo9MWg9SwZlV4RKKQaKIQazF3nAWvDj19blq95ETf6+B0GuF/H80ClqFr3pcZlPllBXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnOq2vY6; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae223591067so907638266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752571118; x=1753175918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+9C4SqxPPpyskVd6ert0bcYvhtym6+38fcjIR9tWwdk=;
        b=WnOq2vY65mw+Eqn7XdeES6UpncbB+zmhrIswaAqFABOtlOio6YuSjzpxTF8bDxqova
         GIWgTh4VUVWLHk0xugofzZY55kCjjiJYEZm+5JChYI85v5o+Lqp2NIvV79Zm1lYridbH
         T78qV2xihhPp2BNxp3moa1J4M9ptlQZXZzYcr7d69o5M8EmDakCFY7QX+HPYXYlfvWNl
         sSHGKswcvQCshG9KI2unEhdDBvD8shoX2EuQ+B9KueCBYhxM30sRAUveMsSFOBvqw77/
         n/5URlxAEqypOdhgOp7OzV9p/YavoJ1qG28SYtfgtkISQQ2ocGW3siPmbmfDmjh36Uzb
         xmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752571118; x=1753175918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+9C4SqxPPpyskVd6ert0bcYvhtym6+38fcjIR9tWwdk=;
        b=iyZSzUrzpKTaYnDABZ6wtM9vvolltt7IO6bjNpxKiocSeuLmXLKKqovzcAqnwJxnM+
         Xh/JLpJUHbVLga913wJZQQchHhFLEz3NqA6/W+0A1NmO0xEoWjnH4b2YCZC5+8I618vx
         vl6xG7UGY8TTnPmV9BgRj2uHNZ4K5A/mXbNWmFGv9VX7c7eYQzF/yd+yKa4/Z9B3C7hM
         Pi+oivkln7M23Cr9squjISEVWysAstgtsYsqn6AJrcaMqbyDBQntmNRqjJ1P+mau0l1A
         Ck/2FHWphlvwX0UO2k7u0gWQUUK+TmMdridEAGaQxXn40019OYmZSLPK9kmU41fJHQAY
         Y6vA==
X-Forwarded-Encrypted: i=1; AJvYcCUt9yJl6qTyLTQ4iS4rerJmq7Zt8/uftTsW9t3o4krmR5GtnliwCLhDt1gdBw/+xmKfwjs920+nBjJvhfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmCViqZBtGQRBIFbJXQm94RB/zzVdPuWy2x+EJskArzbsnoMOI
	C1NogdE3xDQuPtdXrYtRme4Sx8KaNO0hJBymw1R/bjgrhhl/Ts6u3L8Y
X-Gm-Gg: ASbGncvpBYluo293kJ50o1SBJkP04mZ/x1AZHg4J9DeSuygmsxp6Hzj3kaPsSNzV6Yt
	Uiz00ZE9G8R0+r6iLIYLvfuKeSFsP+Ku34JNfV7CkytQwLjj97/TbjR2LaMAOnKyO5QbbDbI2H4
	ZsAmcqONuOLpedjiUNSDZYKZxx3urdgp4lZhBFvksfV3Awkmw6LaS6XVha2iwt30tyGtoUSWZUC
	OMxSqutv/K8VpbtH8cURPH+TQEXRRhOYPGbgHWezjvTGXW+jvMPd5fvg5jHx1W3f57fzemqx1EB
	mWX2mwyCNIQKh92LAfVqt9+plngxTPkfSdA6xuCU3adlv/103J9Z+e1WDUCKDj3BBJ8/Qu/RqmG
	FSuO4+jPX5TaurWezIg+YKADhqusVLxXG4S+jT/Uu5b3g2Y06
X-Google-Smtp-Source: AGHT+IF6yENuvCdGMmQcnjxY1sTGWjszAKx0f9Kx1Yo4wEy5CvAUJeELbK5qpL9ki6y5Wq0WZQ8Q/Q==
X-Received: by 2002:a17:906:fe0c:b0:ae3:5212:c906 with SMTP id a640c23a62f3a-ae6fbe13960mr1793783966b.10.1752571117363;
        Tue, 15 Jul 2025 02:18:37 -0700 (PDT)
Received: from A13PC04R.einet.ad.eivd.ch ([185.144.39.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91bd0sm973213566b.33.2025.07.15.02.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:18:36 -0700 (PDT)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	dlemoal@kernel.org,
	alberto.dassatti@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvmet: pci-epf: Do not complete commands twice if nvmet_req_init() fails
Date: Tue, 15 Jul 2025 11:18:26 +0200
Message-Id: <20250715091826.3970789-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Have nvmet_req_init() and req->execute() complete failed commands.

Description of the problem:
nvmet_req_init() calls __nvmet_req_complete() internally upon failure,
e.g., unsupported opcode, which calls the "queue_response" callback,
this results in nvmet_pci_epf_queue_response() being called, which will
call nvmet_pci_epf_complete_iod() if data_len is 0 or if dma_dir is
different than DMA_TO_DEVICE. This results in a double completion as
nvmet_pci_epf_exec_iod_work() also calls nvmet_pci_epf_complete_iod()
when nvmet_req_init() fails.

Steps to reproduce:
On the host send a command with an unsupported opcode with nvme-cli,
For example the admin command "security receive"
$ sudo nvme security-recv /dev/nvme0n1 -n1 -x4096

This triggers a double completion as nvmet_req_init() fails and
nvmet_pci_epf_queue_response() is called, here iod->dma_dir is still
in the default state of "DMA_NONE" as set by default in
nvmet_pci_epf_alloc_iod(), so nvmet_pci_epf_complete_iod() is called.
Because nvmet_req_init() failed nvmet_pci_epf_complete_iod() is also
called in nvmet_pci_epf_exec_iod_work() leading to a doubple completion.

This patch lets nvmet_req_init() and req->execute() complete all failed
commands, and removes the double completion case in
nvmet_pci_epf_exec_iod_work() therefore fixing the edge cases where
double completions occurred.

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 drivers/nvme/target/pci-epf.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index a4295a5b8d28..aad828eb72d6 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1243,7 +1243,7 @@ static void nvmet_pci_epf_queue_response(struct nvmet_req *req)
 	iod->status = le16_to_cpu(req->cqe->status) >> 1;
 
 	/* If we have no data to transfer, directly complete the command. */
-	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
+	if (iod->status || !iod->data_len || iod->dma_dir != DMA_TO_DEVICE) {
 		nvmet_pci_epf_complete_iod(iod);
 		return;
 	}
@@ -1604,8 +1604,13 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 		goto complete;
 	}
 
+	/*
+	 * If nvmet_req_init() fails (e.g., unsupported opcode) it will call
+	 * __nvmet_req_complete() internally which will call
+	 * nvmet_pci_epf_queue_response() and will complete the command directly.
+	 */
 	if (!nvmet_req_init(req, &iod->sq->nvme_sq, &nvmet_pci_epf_fabrics_ops))
-		goto complete;
+		return;
 
 	iod->data_len = nvmet_req_transfer_len(req);
 	if (iod->data_len) {
@@ -1643,10 +1648,11 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 
 	wait_for_completion(&iod->done);
 
-	if (iod->status == NVME_SC_SUCCESS) {
-		WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
-		nvmet_pci_epf_transfer_iod_data(iod);
-	}
+	if (iod->status != NVME_SC_SUCCESS)
+		return;
+
+	WARN_ON_ONCE(!iod->data_len || iod->dma_dir != DMA_TO_DEVICE);
+	nvmet_pci_epf_transfer_iod_data(iod);
 
 complete:
 	nvmet_pci_epf_complete_iod(iod);
-- 
2.25.1


