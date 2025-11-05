Return-Path: <linux-kernel+bounces-886664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E59C3634A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E29674FAA20
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E537132D0C5;
	Wed,  5 Nov 2025 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e5DWWvBk"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469ED32D0C8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762354719; cv=none; b=Ai1/K7AwW8T7TuM6WuS0PtAIL051vZJyNb4VlqT62MYEHIJJQ19tu50tn6XVoAY+rtsP1UmzYICSRQbh9DY6Opy3sxTJ0bMLjV0rRhiCCwR4JYEtIWLOyycYwjNiojtJFzHp1JMSYOTZ7lRjWuK+/2eFZDVKHUK7kFPlzmU24as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762354719; c=relaxed/simple;
	bh=8jLznCNTXuN7D4wK3yEz3dcKAYCy1+tOtUXbC69C9to=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ST2zRu+3tDhdJ2sr/BSLNVhgnr6zpgt8DrNprOPRfh6+v9fw1xtQ0KpWeXOmn9YDFgBLmOWci/X6PCLsncDiRJfMHFpWpBNOiy0+q1gDYnld2UkJH4caNtLF/M+nsJbzLOl8SDFsUrlss/5UQVWG2c+11OMoEINUwYAp/uD1U74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e5DWWvBk; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c7e0282dso3864385f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 06:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762354715; x=1762959515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JIqAEW2A47SwKdIX3rkBdS84blRL0FTS3b9HYaYDUAg=;
        b=e5DWWvBke1BNZnQm9D3rAkx6yQReNpOkyDCgyhH0SwE6CT14zx+pS5DxQm+By+zLFW
         Y5eKJL0hknEW652uRfBrL6LEtzh69Pir+JU2XYTBRIIjyUUdIsXUMa/vey0tQLLFSkK0
         HrslqQxB4X9pveT68F9SfYo6fC/VhK23NsGlBATe1xlU5QS8mu0oFy7BS5H2vmCzJf/q
         vAfrSGv1M9nRQglC48Md2kmjq8LilZMS01EZwWRCbC4fdKy+n9I3eXNdkgvjmDP4ULMA
         aAcSw1swYUQ5pDEAwAivczHFvyOa6iDwknx3s3kil6RfxUSSlHkCYlvQ+mj0DmKTgZNC
         UuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762354715; x=1762959515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JIqAEW2A47SwKdIX3rkBdS84blRL0FTS3b9HYaYDUAg=;
        b=lIlobdibUQ4T5h9uC64ibHlVfbgsTTwe75jHPwUDbNHQ4f5WKoa1dgqK1vpqzgKmre
         QaCl14yO3+/VP/UokMf2R64y9gsJLNAw03Qmdixq4CaahQSIWIoVrLocCXT/gY5zVtTx
         Uj8m/ZLNjKrjJKfgT3R+DupGbmg/GUfaIMlwWT3AP1jQhs8GP1fiBa5AxcusJhQDSvj/
         6CE+Mb7fQC3FXYpVeW+ItR/Ve0MPhBUWCBZ33dPRgdo9qbxyjpQJFDea+A8lkn1UFA9v
         i///LmWHQ4UeYioOK0hfgUT3h3nSZX07RYSI+BFQ5HA063v6lEimC1fB8FD5lyA1Fxj+
         IsIg==
X-Gm-Message-State: AOJu0Yz3n/nvA42uVcnkUH3XVjLB+ZxQdFBv2BEu4MQw2iqoyFBxaR1F
	0SlWWNA3OsqBWUMW5NYDA1HTlwbCLIm+RswK4mMePxwN9ONnQhWEyR5rSUze3rxfXblF6+ZdM1r
	YN2y/
X-Gm-Gg: ASbGncsf+KA6znp96KeHAqrR8dxe2D+wnyknToChdAIOkKdfxgPEN5jTBuiL+LRU2xS
	Bq4TXHeCxC0FvwVlynw4d3qeONaLHTYvN9xbm4VA/JhN2Rk8pDZciZ01VNjaXHqD9h5I3BnVM5M
	C+EEy1kkvjTtsAKJH+gsnU0Cq1fNJAidwtMfdl+M12jg4YLfoyYBi6QaDHxxR5vbeUVOz1fttLU
	C+6GBrDaE7xEPaJZ1ojINgmQ2TBk1ROeFTggc7Jh5W1KjqYq8GuQk0bM3bhjVGZT/qFt4dvwJrn
	pmmIYbIDXwd9Q/uH9xvdNtQkrs748s31em8CvuvvxUH9eXTkAaxt/gdu6B0VvjxEwxs8VJj/26f
	ZY3zMfvYK+6zWF3Grro/lU5DDjjuGoDw7R++aKZohlV21y4u8UX6iHOTBPn7iEIQKxtYDxZL9Nv
	4CE+3pl8dpkBHZl6ZeJWk+Jlk=
X-Google-Smtp-Source: AGHT+IEBPAS+hCxeJqPMaUujS70zIJqZeU6J82mDcJTJLDzYyDph9uIKgB3uob05iMc3orkpINlzew==
X-Received: by 2002:a05:6000:220d:b0:426:ff2f:9c15 with SMTP id ffacd0b85a97d-429e32c8784mr3606026f8f.5.1762354715311;
        Wed, 05 Nov 2025 06:58:35 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc200878sm10921977f8f.45.2025.11.05.06.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 06:58:34 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] mmc: mtk-sd: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 15:58:24 +0100
Message-ID: <20251105145824.239054-1-marco.crivellari@suse.com>
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

Replace system_wq with system_percpu_wq, keeping the same old behavior.
The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/mmc/host/mtk-sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 79074291e9d2..daed659f63f6 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1214,7 +1214,7 @@ static void msdc_start_data(struct msdc_host *host, struct mmc_command *cmd,
 	host->data = data;
 	read = data->flags & MMC_DATA_READ;
 
-	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
+	mod_delayed_work(system_percpu_wq, &host->req_timeout, DAT_TIMEOUT);
 	msdc_dma_setup(host, &host->dma, data);
 	sdr_set_bits(host->base + MSDC_INTEN, data_ints_mask);
 	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_START, 1);
@@ -1444,7 +1444,7 @@ static void msdc_start_command(struct msdc_host *host,
 	WARN_ON(host->cmd);
 	host->cmd = cmd;
 
-	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
+	mod_delayed_work(system_percpu_wq, &host->req_timeout, DAT_TIMEOUT);
 	if (!msdc_cmd_is_ready(host, mrq, cmd))
 		return;
 
-- 
2.51.1


