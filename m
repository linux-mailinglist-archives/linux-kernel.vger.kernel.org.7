Return-Path: <linux-kernel+bounces-795498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70550B3F2F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 05:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2B71A82B06
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 03:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E262E040C;
	Tue,  2 Sep 2025 03:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOlMgX3f"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB85257851
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756785143; cv=none; b=RQctjN1Wm/K/7c7H4TRsoqrwXulTvm5z2KnPaLFBma0TnTd7XAuNnq8bUszljE+7OzQp3i8oKlA++X+DlrD/OGcCij4Op3iWhigj66YDAVCeENefKoNtR/hw1dD6OIRmSjKk9Ts20TbGJwISktG8RO9muka9mjF200cEiO1+Bas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756785143; c=relaxed/simple;
	bh=4Xwq4X9ulBcvnHaSUDgu4C/KnWnnihDDFkiQT47K9ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1C/jIycQ5P3xo7gjSQO6phYMnF6rUqyqHYH0EV1V8qPSwPb402JRKmqVNWAmbEBL0mqecjU+/yU2yKzMhIHuD7oMoM2PnnPlCmTyhcE5NBevWMrjjeM7Fg37XdCavjOQxgu8aNjnkd6CbMoFs47H04TW0iGT1IgD5M/eiwKEx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOlMgX3f; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-77251d7cca6so1470267b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 20:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756785140; x=1757389940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oT/ykTkaSyUHTJBIc69nRGocpP4BAL4LdV9JCrnAuJE=;
        b=AOlMgX3f+sALvXxPBMr2uKVq5i6xTq4PnN/GurXezYusDnxSX8aaeCg2aHL80JAVEq
         U6dn5vj7i0WxKrUDMjUUB2wgNXYe2OXEl3Gy5wto9WTeJmuXqo5IWhDdllraXOQKXg4z
         0tuNmehvRq6tRT4MUzMqImR5/PQLe1/zZ3DDfNTx7pRHd6jNKBxrBzstZ4ZwO0aaGAM2
         eWv6JdasZEqhH3xVbaVcg4aLz+mOVzm+2Xr4lKITzH5BrcJGSgdc1UxY6C6s9RsCGQLl
         c0xje3h274PrYwA28IPcuUX+J6Z4DgCmu6MYR2g55bYJ2L/3dbJfev4u5oxSEUmnUFID
         cyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756785140; x=1757389940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oT/ykTkaSyUHTJBIc69nRGocpP4BAL4LdV9JCrnAuJE=;
        b=IHonpkx5uJMIF/IVU+oSVY8Z7zjzpa8FAHGnxm+Vh2Szx7QBiVcDr8lqTgv7TuuhNm
         iu0u5r77pHFFIwvn0l6iy6HTRjKa4wkAperpr0OS8CIn1xi005oZChm9IvoOkd6525t6
         JK+uUdSv31crsvLkQDv2LTdRPoX//FaQQm/pF6GgFH0kDWwBwg3MtK2DBGyOyHJ5plDI
         4PbquHjOxsms4BRP4/c6wMrdor8CBf/OfA7wwCKlBa/jSfYroOTQKTeszzeQ33YBeLQj
         Uvhs7RibvG+Jxm7R1QI1KKNRwyA4SCToWe2uXGT2CVmx8axej5hoGO+Jkkh0I35UiJsP
         R2BA==
X-Gm-Message-State: AOJu0Yw1hIrmD0j3oOlaXxfKkPZz+ncJqmU5mqgklA5NZ4AIH/OkMm/U
	Lv1Da3gqhlHlmXnTXzn/5QMkwB0vBLSwPz/wEAr73+GEeK45vwHJWyJsjoi2nqfM
X-Gm-Gg: ASbGncsY3PKwaqLddis/7ivXbIa0OsY1lXLd2JPdoumbpwyQMckbU3ZGoECLtuzLz1T
	xppsduXLhynMGFLDMnG11FSJle2+7ueyOqHwkl71uXJhazOCIr+Voj2098DtfQY4CY3s7jPJPIT
	gVnLR1ypRGrM/q/36l9ill5+SyoCcepVFdJ1dLidP4uz5LLHPtJ6/H24SfOrvWNPLl7QX/bymqK
	5Iiy0k6tNF72YZAmv+73+Sc4pmr/gS02VdoawwaSuBZKCxlwPD6IusO2ozcqfJzbiRwOHk0mrjL
	eBUS7JwP/qU81Bt9yHrd+v91HUTMtTAOxekAMdBAAqsm/++8a8e43a+CAOSgQRiKWfmsmVWxlOR
	K39ZPenwFDk7sbv5tEQDTkNV1OxxD3sxDpAwERGlQkX/4+8vVKMLyXazNB6qEmS66Tgm6XSVOfR
	D/7r9h3LF5OeOpB+dqiShN2MFqaLTa0DPopX9b
X-Google-Smtp-Source: AGHT+IF4nNKMOTogfQaVhATVDQ1kYDItGzEhI6Zcly5AfBTAmyqokUDnZCi0a9STC10UQbgcIDQS3w==
X-Received: by 2002:a05:6a00:4612:b0:772:5487:c37c with SMTP id d2e1a72fcca58-7725487c5cdmr7681292b3a.22.1756785140306;
        Mon, 01 Sep 2025 20:52:20 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4bf378sm12085276b3a.60.2025.09.01.20.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 20:52:19 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH] nvme: Use non zero KATO for persistent discovery connections
Date: Tue,  2 Sep 2025 13:52:11 +1000
Message-ID: <20250902035211.2953174-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

The NVMe Base Specification 2.1 states that:

"""
A host requests an explicit persistent connection ... by specifying a
non-zero Keep Alive Timer value in the Connect command.
"""

As such if we are starting a persistent connection to a discovery
controller and the KATO is currently 0 we need to update KATO to a non
zero value to avoid continuous timeouts on the target.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 drivers/nvme/host/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 812c1565114f..bb9685b67338 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4986,8 +4986,14 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 	 * checking that they started once before, hence are reconnecting back.
 	 */
 	if (test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
-	    nvme_discovery_ctrl(ctrl))
+	    nvme_discovery_ctrl(ctrl)) {
+		if (!ctrl->kato) {
+			nvme_stop_keep_alive(ctrl);
+			ctrl->kato = NVME_DEFAULT_KATO;
+			nvme_start_keep_alive(ctrl);
+		}
 		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
+	}
 
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
-- 
2.50.1


