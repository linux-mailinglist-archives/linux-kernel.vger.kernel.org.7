Return-Path: <linux-kernel+bounces-849661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77549BD09A5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295203AA36C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8339D2EFDA2;
	Sun, 12 Oct 2025 18:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmx6s7LS"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FE72EF664
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760292790; cv=none; b=alR8/14plorMDEv775jokHeO4nrsiNp6rt5t1AYwnkifUh8ivs8YcIqnT9H7RNsCEslqs/h3tDdnl+Ja/vyFrzbVuWdAlp5FgH47OtICoK4Lu6Dy6PFhGUzFo4T7UOgzGfS5IL89mDwdb60z6C/Xi/j+lb1cDWtzpHtclsByYiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760292790; c=relaxed/simple;
	bh=qmgeVD2VVl4QslPbtYsfzqW9k+kHx43RIn2OTo4Jl5w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RAFz08lMY/6KUCoNNwhM5ictXRaft9oq6G4GjW8f2JJEaHsl7M4DbL8i8R0WphBd9accKEXdwMLp3sc1LjQgd7Sp8PKz7Ko39ZuTqROtXDfsc2w1fTbyaYBnvT8gUidiCAxJdcnTqEUgHHAoq9FzEUqYIjhQMHd25eNvah0BBuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmx6s7LS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f44000626bso2459840f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760292786; x=1760897586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qm49PMkGSlJZFDb/IimhHX7d0uXnXKa4R969SumUkuw=;
        b=mmx6s7LS19jylkIS6hn4qX2FfTZxuC4BW9foq6od94b6sWATQ/1g5W1Qnv0QKwc2dH
         TiQ70eh1Zqcj4S792FFiBtu7yKx1MuBgNTiZpq2HlBQMrZN8kwE5z+7RK8ks5Q2TF5D/
         910vVParU+ptPUSqcORmpXi861sDfaNgnkP+zVkxRl7IC3fEx5ZhXEUwS79hW5L2gpzO
         1kDX9ZaWJ3zKaBdyWWhfM3oOWedR/W9i88O12+53hNzyjSa2+HW8jVNzA2gyB4dSesfG
         hJQJD4GOHZbGjbtUawomfyaH9rRwHLRRQ2o6HgGvPjMqSM68SDTw6HcR8IsjrhJtGybq
         D1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760292786; x=1760897586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qm49PMkGSlJZFDb/IimhHX7d0uXnXKa4R969SumUkuw=;
        b=bPaZ8jxbtvwxkhlUPFnuqCRoSlfrAxHfPYsTH6OQSvZ7LED4eIOScv7+iiZUGMdbpF
         QTvINijODmplnFSw6vpoDoKUBVgP3mQiSAktItM5hBK+Xm4Z7SI6fO6v0dgbp273N0RM
         /dOwOC+1PKJqI/Ic9GKB4XmEgY2y5R6gj1J2i45K38EwFyV7J3/yrdHwl8hKP9HhQIlU
         eppYVhFBK5yZx/+QCWdsg9UzRBDH1XN4HDcyvezvIzM6zVsyrAoW1Ggi31ZuNZ3FwR/H
         c35B5kK2Blppvxi8A3FK5agktRVp1HyasGeEtaoX7zvNFGQg7PonkliCU2zRXNKQuZyx
         7vVw==
X-Forwarded-Encrypted: i=1; AJvYcCWxQVSWL+ot6Mah6yMg9fTX7LKMfFdPzvod2U+iBBbLsXINS011hJgq1feUYMREQfYJ4iydTAUsgS+hNbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWZAc5s9/ZISJgtw79PDWjITcl3NOHf8gxM9J3FVnd90lyf4bo
	JS3LtxKttjsZOLNdujA7LlWVX1wIlmUUWB8R5EEqvPtnkNXwJ9Lkuaby
X-Gm-Gg: ASbGnctaJgPAPYdcTXZM/O4DslIIlcbAEWpfXX5rZOSmB31dsm75v7FcQIgrn1lSkv0
	IgHwGD6YsemgkpgF2SDYW4jgFhTR6IYuIKixgWjR/si1pTid6X+HAJwS7bP2mM/DcTYvasy/vbc
	uQMs7cfIbA1YmmovlvhEVqF6556ueGLoRGVvW95PJbTTAU9iUugD6bEWX7L+Xm5PX7kn6qpQePD
	AFHyUDVcDYkR9RncK4JTvktkmj+CG200pja8En3HMdqPx7dQWjXOEyJEwE+ear7JXj2J6E/v4ud
	spk06ia9NBgyhOq1yRZhFXHg4hzIMuj6JcR/8yONeC1oWLrEwTMSw8mvTVXzWRnx+BJ24SI3aPZ
	IJtmLt8vg3tZrdH/aP7A9NjpfybIHmv0qrw==
X-Google-Smtp-Source: AGHT+IE1sITyqeK252spybpiCvyKv3IBHpRkeCYLSxM0igwtTT/L5xFKNU+rdVGC1vsPFlR1JqbCHg==
X-Received: by 2002:a05:6000:25fc:b0:426:d301:a501 with SMTP id ffacd0b85a97d-426d301a83bmr5173581f8f.62.1760292786392;
        Sun, 12 Oct 2025 11:13:06 -0700 (PDT)
Received: from pc.. ([105.163.1.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0efasm14478684f8f.41.2025.10.12.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:13:04 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: linux@roeck-us.net
Cc: grantpeltier93@gmail.com,
	chiang.brian@inventec.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] hwmon: (pmbus) Fix child node reference leak on early return
Date: Sun, 12 Oct 2025 21:12:49 +0300
Message-ID: <20251012181249.359401-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the case of an  early return, the reference to the
child node needs to be release.

Use for_each_child_of_node_scoped to fix the issue.

Fixes: 3996187f80a0e ("hwmon: (pmbus/isl68137) add support for voltage divider on Vout")
Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/hwmon/pmbus/isl68137.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index 52cf62e45a86..6bba9b50c51b 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -336,10 +336,9 @@ static int isl68137_probe_from_dt(struct device *dev,
 				  struct isl68137_data *data)
 {
 	const struct device_node *np = dev->of_node;
-	struct device_node *child;
 	int err;
 
-	for_each_child_of_node(np, child) {
+	for_each_child_of_node_scoped(np, child) {
 		if (strcmp(child->name, "channel"))
 			continue;
 
-- 
2.43.0


