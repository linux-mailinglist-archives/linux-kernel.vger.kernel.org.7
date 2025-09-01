Return-Path: <linux-kernel+bounces-795187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FA2B3EDFC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0241A8347C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B107324B2A;
	Mon,  1 Sep 2025 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVzQ88cg"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C9D202997;
	Mon,  1 Sep 2025 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752037; cv=none; b=koVuuas0kqBOJeU4sd1ELS3SgZKPT8K/oFta7DWfT8geSN4xmMNqA5iA5ntO9LoHGMRMxIObegK12lVDjaSgicL+FzAzSiLkn/Oh9EnvmSFj809Ipwc9j8VZ8UTqIVY5DPqCaHzKTAxvmRdzZUlznEpEFgXssNuGMZjGcge9QNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752037; c=relaxed/simple;
	bh=Q2KNqqX4HvvrdV+7pX8yVeWwRZhNJcUc2pVnU5UUo4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8igCw3Z9KAoIp3XKmoQ1rrKkonW5teoidtzMqIofo2eaVaTa1+tDwcBfd6d2HQ2S6dfnjUH+Fpm2hBIEhUcgbc6C58teTzxx9LL2z5vNxExBhWY05dC6n1UEV/X64ncfBeIRyir6yYD1XpyybJCAncQwj56W0u35nkt28HpDZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVzQ88cg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so1588600b3a.3;
        Mon, 01 Sep 2025 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756752035; x=1757356835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NIrx3vsJGKnIC1mV3ZO9Gva97ORXiax8+B9LAsCFpWY=;
        b=EVzQ88cgwHO6cPVMZgjtyywo7TtWAfZ6rfPXKGrX2hBczA18yvCJIl4YhgxMW4OxgO
         BtgD1FadQBPrObgXfP1/w7jub/J9l6RS6/McUpklzrm1k3IZVTcTnj+vUKZ51bHKz8mG
         7hwu39KhWGONgPbvewCZWfUmHOepL6HxkM8WlU4VtYGMmF4aE+IrljSXvsowRvUyt9C6
         U3As41BgG3t3+uq+44PDRNrAgjNKcZ+4x28xyGSWMsBrUPUAeFfLj9oGSR6s1kP4eqUh
         /h+Ow4eSI1kQoPKhPDagzmha1nKxxHa2V7yxMt85osQ8DXuMTKwQOy1/ribDfnhUmrLk
         uaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756752035; x=1757356835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIrx3vsJGKnIC1mV3ZO9Gva97ORXiax8+B9LAsCFpWY=;
        b=noY+7nJiD2g6sQrOXVTn4fs/+2HvcSNtrewnYmCI2pI/OJ+a52vbq2xlGP80rxShAr
         KsCOu3IWyFB5Vok4u/RB/BW+/wkxaVxKJsnQOl33HLQKLgfahJgUg7tOHu4r09kueua+
         yk/CCLKcuTfffh3ouJuv6HcbURbfNKwBshGwvjpglp84JH5v5Tr5SYlRqHK4yO5D+DWv
         WFa8j7QM5MgKA7xTpQKvn6rONG+8m/5DUCZpygj2x/2jLrQGdspJ03tkUnRkCYbKaxoc
         YP9TaW5S+/4UHBudREY/yO7USmyT1h0G2xeXHsk+Usi8jAdyuCGKjWEMvrSIMGz7Lhif
         e50g==
X-Forwarded-Encrypted: i=1; AJvYcCVNlc7z0ceKYU3zkDkZqF8X/Qbhm6j+VwK6OyNoMrdXfASLTywc66EAf1PtrdwblRHPi7B0QW6SS/d/FGk=@vger.kernel.org, AJvYcCVNo59MR1Xxi8/R3JZqJim9TeQQDKDVc21pYwhRa8VjgX91aGhSIrCrLmLpik0isRaCOFsQ6LjikRdFm4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ynlEUq5obpugRhv+v3Y17XU6D6wMjzbQZijNQGCtQ/zcLdAo
	U6qEYXhDMFqB+buBgXxeWbqjjr0W3Qm1EjQGCWJ8aXe/8PQOwf7kU17p
X-Gm-Gg: ASbGnct/fmpNw4QHEQetAvcJTY+YSOPiiLckzRDgsaegca9KFbvHgjJKUm8RauwAuAX
	6X+LobTPmawaOfc1Fz6//lN0icUdjOOl7NcE5kCNqprxcIUJRRYa+pS6CNbJNs0/uBFPJVBZ/6i
	kn24UCQGPKuhjsHVoKuDn9lQi3YBEmPN6Ok2SQILwpVqDtXrLc/7TsrDpHqrMwgyxnqdMLYR0UG
	VNCec0IvAT7Wrd39B5XkQtU90GJ5gAkq3Gd0c6HGEXVoO227KXq4CLOMIKBOWEOlNJZ80AaiyIN
	WOnZttXL4sAIAd+jopSGLFUSCW/WaBoXYRW5zceCRvl1q/fvNeEiSOERwBWnvQrbtLJHwZXcApD
	vpr6Aj2IpxPspViCGYOx9sexFci4X1DPR4iYxp2LcKXidjqnl2koW
X-Google-Smtp-Source: AGHT+IE/jtLqtpNoHzHQm8+GWilNaW0KaW/thghaOxb46kqVDVblP5DDWRKxuVHZ+7ag3CTMto3DbA==
X-Received: by 2002:a05:6a21:6d9a:b0:243:af85:44b2 with SMTP id adf61e73a8af0-243d6bc9cf9mr11653749637.0.1756752035340;
        Mon, 01 Sep 2025 11:40:35 -0700 (PDT)
Received: from fedora ([172.59.162.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77236d7eb7fsm9436621b3a.54.2025.09.01.11.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 11:40:35 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v3 2/3] ASoC: codecs: tlv320dac33: Add default value for burst_bclkdiv
Date: Mon,  1 Sep 2025 11:40:06 -0700
Message-ID: <20250901184008.1249535-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add default value for field burst_bclkdiv as initializing it to 0
is incorrect, potentially leading to a divide by 0 issue.
Valid range is 2-17 per TI datasheet. 8 was chosen as a
dummy value.

Reference <https://www.ti.com/lit/ds/symlink/tlv320dac32.pdf>.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
Changes in v2:
- Included removal of struct 'tlv320dac33_platform_data'
  and header file 'tlv320dac33-plat.h'
Changes in v3:
- Split into separate patches as per request
- Moved inter-version changelogs after '---' line

 sound/soc/codecs/tlv320dac33.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index 36b3de75a..feefc777c 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -1480,6 +1480,8 @@ static int dac33_i2c_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, dac33);
 
+	if (!dac33->burst_bclkdiv)
+		dac33->burst_bclkdiv = 8;
 	if (!dac33->mode1_latency)
 		dac33->mode1_latency = 10000; /* 10ms */
 	dac33->irq = client->irq;
-- 
2.51.0


