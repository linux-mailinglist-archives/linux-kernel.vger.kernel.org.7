Return-Path: <linux-kernel+bounces-793095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71648B3CE4A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312C8206811
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 17:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41942D660A;
	Sat, 30 Aug 2025 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4OyDI8z"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC92D5C67
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756575564; cv=none; b=aDFJx4AuE/WnFjGfjbEwc26fNF7tDgsiEzM3ziRpyTuLA7PFaziMzyzDsg168OhZGJcJKmXfw3eJpX9lZUSYqM/pjmgAE56h0strMyQNaQQ4tYNxfLjy23M9Jv9W8AWW1B/RLvogUbYJz+iTIw+6VQe5V0DfxjnCM1NuFKyIzBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756575564; c=relaxed/simple;
	bh=bRv34QZeUsGRMmbO/KM3BzFgbgNXwP5WC/xesqcskJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M761ig2Tv1YImNTQvseauxN/+619GpxLuYzQg+zkuHkYvRFEf7QYtbTGQxyWixpDIeWmdLNy6MiGex2tH9yUIvwUtJ8Qw384TelJmqIhMVvAGs/9HtxTcdOXQQOd23AFrLmHJnWgBEK8f9jk5QcFysMpQpaMSZQoDpJcfNa8TKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4OyDI8z; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-248cd112855so6098285ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756575562; x=1757180362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETXuVNXIq9MNAcEeVRd5xBs+jfDzG9umQE4H0ixj1/4=;
        b=g4OyDI8zw3k+xAmdjWV0w4EtsCarlIWdngpUTBddWM9MKY++pJpXvdYvMT1dINbJm1
         ju/kTkqFZ4XqJ+BEK36K6SeBp5+vToAXY4PEbtrhCL0oGYadhogWgs4xgqWsREjbxEHh
         TAYILMV4PEAv47VpScc/3f8QciCOn5Uoo7D69dJslCR0zeH64aLKAe2hbZgqF1c6IUN1
         nCBArcTw2Fx8d7VLbOzbQBeDikoWXDsgxU44zbXcj6Uw404GxSGmnWgAGZTNB2Va+1Dv
         lD8MtpY424bMRcy/wM/kEDmTazjkqkReH/wx9tt5BLrB0U6nJWCUVOxt9JJQ0VQSQNl6
         s7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756575562; x=1757180362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ETXuVNXIq9MNAcEeVRd5xBs+jfDzG9umQE4H0ixj1/4=;
        b=r4mgLgPuC4/lgMqroODS83PEZuSHRkrVeYAuvFKSLrXQazRVUK1vN3MLauFDQ1oA0D
         JkYhr4L8gugDql8j88s2X5NbJ/MNp0LHyhjEuHOAISpedR5WGw7/lFtgP5+AChwyRVXZ
         ObkCOnCHvWhlt5a7ZnsY2u+NFv8ins/lPcL6BgsWtfBdeNNQ1O7lNl3DF+ZPy0sx4/l8
         5OzYxx51Vl+6jRpvpHGUH+f0vGTqG2/p44Q9IT4isgDPQbkil+48HqRZ65c1cMIwitOc
         jWryDyjb2G8G0sLVpCKnXgCzJeqZC0IkN5ivDwKeli1FZTLZMoaRBstx/TZkoGM+foHM
         ohsA==
X-Forwarded-Encrypted: i=1; AJvYcCURtiqEv+uI8zXRkcnrQX1ZZCxbB02+bXicGHcx1Es4scxyUGqJed7cJ9og7szRB0Isi47WsjEB31KJjFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMRjKBvSsXr0SBEREVOKjvgIGop7sp60s4kszfb5XAvMrIA/kV
	Z2RQdaJyjD/req2PKVjozM42xItKFeyqOra6zWVSFXQbwkiOSrTqw4m/
X-Gm-Gg: ASbGncuuZj5d4/rOF6bJdvQIRl3JUxO+zSHFYdd/X0MMUi8Dn9TxPULZ6SpD0jTZKaz
	uqcQu4E/S2+UHLKFT9wzVAiboUn1WEWFBRJFnLhjKf0x4aDR8WiPz7Tskri2y6GY8BG2vY1Atiq
	P7+EKpYvYiOhSqRS1xJcK/50AHk8atmiRM5vqnTC6JcweSyu7IjiAsta5eUYiJ4k0eQjTJjHAfl
	S1Wda9IjG27f8dN+GyG+S9XbILT+QIB1u1I7p2nBnQU2ZXDPDvlURpykKkRku9n+aa/DPgJg2It
	Q1WXAzCetOaqDR2iyNXwej9Yg4g7Mt0BX/x9cFzOrgZ4cPd5V/55NOMT3uvs8/PMKPwoYEy62YE
	0t7MifJm9AVkZgsOg0Az80Ma1okApLjZX0dl0raMuVg==
X-Google-Smtp-Source: AGHT+IEQMlEuh9ApetxKqLHAyWAj6WwoICnokFpZDwrZ4Vzc5kyx9IzKhufzz6cMaGBpmsh6eXQcbw==
X-Received: by 2002:a05:6a20:12c6:b0:240:6243:b9ac with SMTP id adf61e73a8af0-243c8160dcfmr4346700637.0.1756575562072;
        Sat, 30 Aug 2025 10:39:22 -0700 (PDT)
Received: from raspberrypi.flets-east.jp ([2400:4050:d860:9700:eabe:57a8:cf74:875e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ad39csm5154525a12.27.2025.08.30.10.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 10:39:21 -0700 (PDT)
From: Masaharu Noguchi <nogunix@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev
Cc: vaibhav.sr@gmail.com,
	mgreer@animalcreek.com,
	johan@kernel.org,
	elder@kernel.org,
	greybus-dev@lists.linaro.org,
	florian.fainelli@broadcom.com,
	rjui@broadcom.com,
	sbranden@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	dave.stevenson@raspberrypi.com,
	laurent.pinchart@ideasonboard.com,
	hverkuil@kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH 2/2] staging: vc04_services: bcm2835-camera: avoid -Wformat-truncation
Date: Sun, 31 Aug 2025 02:38:50 +0900
Message-Id: <20250830173850.323897-3-nogunix@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250830173850.323897-1-nogunix@gmail.com>
References: <20250830173850.323897-1-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    - Fix -Wformat-truncation in vidioc_querycap() when composing bus_info.
    - Use scnprintf() for the prefix and strscpy() for the remainder.

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 .../staging/vc04_services/bcm2835-camera/bcm2835-camera.c    | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index fa7ea4ca4c36..c2788659af12 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -874,13 +874,14 @@ static int vidioc_querycap(struct file *file, void *priv,
 	struct bcm2835_mmal_dev *dev = video_drvdata(file);
 	u32 major;
 	u32 minor;
+	int n;
 
 	vchiq_mmal_version(dev->instance, &major, &minor);
 
 	strscpy(cap->driver, "bcm2835 mmal", sizeof(cap->driver));
 	snprintf((char *)cap->card, sizeof(cap->card), "mmal service %d.%d", major, minor);
-
-	snprintf((char *)cap->bus_info, sizeof(cap->bus_info), "platform:%s", dev->v4l2_dev.name);
+	n = scnprintf((char *)cap->bus_info, sizeof(cap->bus_info), "platform:");
+	strscpy((char *)cap->bus_info + n, dev->v4l2_dev.name, sizeof(cap->bus_info) - n);
 	return 0;
 }
 
-- 
2.39.5


