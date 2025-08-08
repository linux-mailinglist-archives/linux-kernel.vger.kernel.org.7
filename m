Return-Path: <linux-kernel+bounces-760529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE18FB1EC7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 17:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42766581BB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 15:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3840285CBD;
	Fri,  8 Aug 2025 15:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="b3WhRZIz"
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22411286419
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668352; cv=none; b=Wue59IeUq7bOtvkioOARyspZDEj79n+1KzPHId/lANhG53MFngUZ5WmH7bLCqks3PMlwQbNtpGPUIWXdy2NawDghGhNSW29MB8LSr83xxj2TOBJVCWshFlqTuaoApyxGkMpmcPD0X4NgSRDFMcah25O2xtEPQAXNaFXpxIZaToo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668352; c=relaxed/simple;
	bh=rwY+6H6u80joBsrhEhKEXk0cucLQiP1e1Ud9NkfJ2mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q5hRCOrfULj66x/9ktDyE/+lOFjHPfgVW97YPmlvZkeXMOLg6QxwqAibo32QYw8ODB7AVX4G4Av3HKGgVDnyWzXvKR2zbUTSFTxMtyJ91nZhuj6kZh0He9kugekpCujyN9CJsFc4aGZSku6lBnnmo70IAIId1GI1cJ0v7A8jMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=b3WhRZIz; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-881884dab5cso3727539f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1754668349; x=1755273149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WDnFLQYE/9gqtmsTbT/ho+kOSDoyfUwk9gt7yBIm8Gk=;
        b=b3WhRZIzCxE78fbKuhGfCrSHOuXdj+SjQwlmmPcQxBs0FZw1LVjkkgcQsRb/j6AMhp
         HG5bqW/pDPS1JgvcPx1hrJcs4loVobRl/76uANt+IoUc4f39N9dMBQj3TqnqrF11UGuH
         puoMm9o/SMUP2yxWx9d87D6lmmK2erZM95nCDNAjyTWOgMHff+fkSZcAz1FKpRtd68uZ
         EwiraqzXBFW1MwynNzJ5NBGNcrnZ/pKcUNZYZB8cjIAU0ETEesf2PdXuf/Z7dtmfAndd
         GcPfwCgsDhpZWP0v7GTVVoTLJ3Zr+dxTtMlO1WjCjjKQxBNT5CKJ+bCssBsuOsW/0ACK
         3kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754668349; x=1755273149;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDnFLQYE/9gqtmsTbT/ho+kOSDoyfUwk9gt7yBIm8Gk=;
        b=gJhTjHOtNuLq17prchWy64xZQ08OXbxAutCMEl4cLGqQQfI6SJyfY3o1Ick0afw+Ro
         bm6MD+9xsqMRTLwvhrZy01DknlYZyUigzvBPTesQEVBpuFw8f8jO1SO8Hcng6dyICL3i
         tlY+nM1aVxJNIv9949lAPqVfhbHYy2uyGhjgZIQ2ObgtkL9kbNSmoMuAHM4/OA2S8Pq+
         B0yLT4ttYKJTP6dSi8lrLnuILW+GMIH+ipes9XRzal1X4xYED8F/3t3QDj6sU8jqqUu0
         6FhieKq5orarrM611uHhE3S+Lq38mMQQVpUrV3WkaruEEkId4zO8uXSBU2Y0ExFMdS9s
         3pcg==
X-Forwarded-Encrypted: i=1; AJvYcCWNstn+N9Fi6m3wOAXmZUA99T77EhXYBFrDaqZopJQUCMyzu2LM1GByk51G1UAZHAnA8yOBpAehSKzAfOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjVjHA16WbbEE75n4CNWeRKDZ8XcY90W1S+WmplKBTYSFuHHc
	WEdhGlv4SLz5I0nIPmICmkmGoKGHso3vaGWHanVuoqHRxogm0ZCv2GkIDET+JaUBodkoGoSgHKX
	z2VVdypVcHuyrctk8kWNekxGGRguxDShkJ9nl
X-Gm-Gg: ASbGnctSLq7hyb9ZpM/Yx7nJL/5sThADAL6sHBAycp6MZWJM1cGkP8cEbNya6lRRLv1
	0kBnZdWCUabvHXAp1954pcDkTI2+ICJF91SEOMDtmos59DuRCfth0w0Nh2GTD8/1SSevyeBuT2f
	P/maYqwzamP/5v6defeGCbOU714hxYCNqgKOY8pEoir+FYoMZKdEyAKs2/4RPeTivGyF2AwDaht
	D1vg9v7EEQ2UYfOH0WDUTZrbS6niny73Z6OvXhJv4pEApy8OtCFqmk0nSVT7eLZgWXpf/9OlwHL
	Z1B6qIP0OmxuX5MqllAGazMbqyAeLnU0vT3xbpZER4t7gl/uO+sTro5Y4nbx4S4HyoDbLUBL
X-Google-Smtp-Source: AGHT+IHsEIHvzKEqwfGGH06NchR3RnM7OZwvoi0OVdp5Y0s9Go/QPEu1k6+RlpB3kq/7NyAS23S5mk4VQRpa
X-Received: by 2002:a05:6602:3fc4:b0:87c:46f2:7075 with SMTP id ca18e2360f4ac-883f12ac4f6mr160145439f.5.1754668349110;
        Fri, 08 Aug 2025 08:52:29 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-50ae9bb6bbfsm160766173.32.2025.08.08.08.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 08:52:29 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 821D4340237;
	Fri,  8 Aug 2025 09:52:28 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7C621E489B5; Fri,  8 Aug 2025 09:52:28 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: check for unprivileged daemon on each I/O fetch
Date: Fri,  8 Aug 2025 09:52:15 -0600
Message-ID: <20250808155216.296170-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue
daemon") allowed each ublk I/O to have an independent daemon task.
However, nr_privileged_daemon is only computed based on whether the last
I/O fetched in each ublk queue has an unprivileged daemon task.
Fix this by checking whether every fetched I/O's daemon is privileged.
Change nr_privileged_daemon from a count of queues to a boolean
indicating whether any I/Os have an unprivileged daemon.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue daemon")
---
 drivers/block/ublk_drv.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 6561d2a561fa..a035070dd690 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -233,11 +233,11 @@ struct ublk_device {
 
 	struct ublk_params	params;
 
 	struct completion	completion;
 	unsigned int		nr_queues_ready;
-	unsigned int		nr_privileged_daemon;
+	bool 			unprivileged_daemons;
 	struct mutex cancel_mutex;
 	bool canceling;
 	pid_t 	ublksrv_tgid;
 };
 
@@ -1548,11 +1548,11 @@ static void ublk_reset_ch_dev(struct ublk_device *ub)
 		ublk_queue_reinit(ub, ublk_get_queue(ub, i));
 
 	/* set to NULL, otherwise new tasks cannot mmap io_cmd_buf */
 	ub->mm = NULL;
 	ub->nr_queues_ready = 0;
-	ub->nr_privileged_daemon = 0;
+	ub->unprivileged_daemons = false;
 	ub->ublksrv_tgid = -1;
 }
 
 static struct gendisk *ublk_get_disk(struct ublk_device *ub)
 {
@@ -1978,16 +1978,14 @@ static void ublk_reset_io_flags(struct ublk_device *ub)
 /* device can only be started after all IOs are ready */
 static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
 	__must_hold(&ub->mutex)
 {
 	ubq->nr_io_ready++;
-	if (ublk_queue_ready(ubq)) {
+	if (ublk_queue_ready(ubq))
 		ub->nr_queues_ready++;
-
-		if (capable(CAP_SYS_ADMIN))
-			ub->nr_privileged_daemon++;
-	}
+	if (!ub->unprivileged_daemons && !capable(CAP_SYS_ADMIN))
+		ub->unprivileged_daemons = true;
 
 	if (ub->nr_queues_ready == ub->dev_info.nr_hw_queues) {
 		/* now we are ready for handling ublk io request */
 		ublk_reset_io_flags(ub);
 		complete_all(&ub->completion);
@@ -2878,12 +2876,12 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub,
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
 	ub->ub_disk = disk;
 
 	ublk_apply_params(ub);
 
-	/* don't probe partitions if any one ubq daemon is un-trusted */
-	if (ub->nr_privileged_daemon != ub->nr_queues_ready)
+	/* don't probe partitions if any daemon task is un-trusted */
+	if (ub->unprivileged_daemons)
 		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
 
 	ublk_get_device(ub);
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
 
-- 
2.45.2


