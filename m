Return-Path: <linux-kernel+bounces-743150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D68B0FB35
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A9D4E1A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA1230BFB;
	Wed, 23 Jul 2025 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DEG8ct1W"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E07F9
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300668; cv=none; b=CD4BJA2VVpW1TB6V+tsIwKgdbXQem+W3z06mYKv8T6q1oxAZG77trPfpn/DV9ptVsAVjswtHfRcbOw6YAQ/LmXvGETVk1UQcSLisuwSwbAjN7ZJXu1oCKtDXq+L2dML18B3xXb40rRANVeqE7iAZyiExhu5gVT41Zp2rO3MIp6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300668; c=relaxed/simple;
	bh=FVSyqqgqEq4MnbN1AK5ppWWETHgof3UqLFecD42QwMI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YIj+e+tlCP3IDRIce11SoTY+nzPZFZEOPdIsQOWOvuUDJw9Nc5DQB7g5leIs8Qf96DdVgaYJ8ewJgSN7un3PrH3BQwN3Bp/hob+DZKEo1An8W9BRKyRD/e6LPUbrkEBgwIyqTCweLq+GsmqEhGqrvWnhLBQqrHiEsHVU780IYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DEG8ct1W; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3bad2f99f5so304108a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753300666; x=1753905466; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/DG2m9HOzWXxFr0mPV6O/7kOINoRfxN8n3jHURo/ORo=;
        b=DEG8ct1WATN5BwkWQIXgcWqP6ciIk034NbYWzPusn72yEkYoms4aCtNMDMF3B4AOm6
         2DZP5IlmWNnNX0Zn+QNPC+F1O1ObGov/9wbs9lGLJAp673em5+w3xfik9w6wK8TU49qq
         GAoQAYo4OhYrTzag8rTymSeLXkSNehTPjnWTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753300666; x=1753905466;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DG2m9HOzWXxFr0mPV6O/7kOINoRfxN8n3jHURo/ORo=;
        b=tiQhDqayVN8iMfq4nJ5qzFd/ZycpBmQE+QbN5zMbhjCY3uQyxAGrchViOJBZWM4M2L
         v5jkw+9kj5q7uWrObrAhxOMgYMddMTgGUypMevyIomF5Z+kPBD1pMiDRAAWwa0bWChq+
         TxAef8lM9UBKWD4I7GnLGDyJZjSw48IW7B/3nArvQZLdb2yvUXo++SlcHy2GYkTv+MbE
         1b+RV8naWBG6z7Kwgj7Mhr3Wt2SaiugwostobZtACsOeu/MusBDovNz24wDpKLu9Mris
         D3q3JoPfMGuCvZKqx/s60Dqxr8OVRjdLjwUIcHBFHi3fr9iMbuw+g2JmLy3ThIBKG0ob
         8ezQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtxH2Z0jZfAirqKWDKOFIlbd8GnebUwbdW6jufS7IdsE3LpREqN7Gnuv+LY4xJufJMtetfAFdoWj3Mk5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrnrSgO2Y3LpEGAO3h1lPZ31aEuzh4GkzM8ddIkS7lpsBdlCKM
	iJnKybD04YX/RXJ3OOLTGhhUL9PzCYLbDMCwlrPw6LUr1SMEH3cXuS+oM6a3GKJiHQ==
X-Gm-Gg: ASbGncsd7iIz6GABgoi6h0YtKGDQ/+Sy/ICHVcWi9gpaScq8HDijMju39E2VhckzBKP
	gFfAB+dkvbI6/mpmzKEUyS1TNPCSgcF+TToTmbEOdZAUGftqbSMKEIpzRYNFVvp0DdWZeDuRLMX
	/8HCVvl9QZErjgjlqfkX5RTepuetxOCevySLG8HmFXdUoUFIbSDLvv5mcBr/wTnuqdNdJwMKFRo
	wloEtnx9S8+FNXM8I3TBIkfuKG5OUXbVSEe8h9tA6sl0aASsfFedVEJ9ky8iu9lk+oaxz7xGgcD
	P7q2MqTnsIctSJMrFB+HX/kWCt4CTFjJDyAjHvrukww1XhxDkrmI43Initsjh0rULNrTNMBEmkT
	UrU1PTNu3cjk+TVcDqSVCUiNme5T3qo4PdmbLd2E8SU/QxoM=
X-Google-Smtp-Source: AGHT+IFkLaseT4J9N1a2WehClVWhl7WlueTj40zlFze3K+qatH6eNoY69q9GmgP0Dhp8ElHdTx56HQ==
X-Received: by 2002:a17:90b:2709:b0:311:a5ab:3d47 with SMTP id 98e67ed59e1d1-31e5130f700mr4952881a91.1.1753300666086;
        Wed, 23 Jul 2025 12:57:46 -0700 (PDT)
Received: from ballway23.roam.corp.google.com ([136.27.48.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e519b1494sm2297587a91.4.2025.07.23.12.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:57:44 -0700 (PDT)
From: Allen Ballway <ballway@chromium.org>
Date: Wed, 23 Jul 2025 12:57:35 -0700
Subject: [PATCH v2] media: ov8865: move mode_configure out of
 state_configure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-mode_configure-v2-1-7fb0f6ba1194@chromium.org>
X-B4-Tracking: v=1; b=H4sIAK8+gWgC/3XMQQrCMBCF4auUWRtJUoLFlfeQIjWZtLNoRyZtU
 Erubuze5f/gfTskFMIE12YHwUyJeKlhTw34aVhGVBRqg9XW6Yu1auaAD89LpHETVJ022sVn6Fo
 XoJ5egpHeB3jva0+UVpbP4WfzW/9S2SijHA6t084O2sSbn4Rn2uYzywh9KeULhblnxa8AAAA=
X-Change-ID: 20250722-mode_configure-80105fbd835d
To: Hans de Goede <hansg@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Allen Ballway <ballway@chromium.org>
X-Mailer: b4 0.14.2

ov8865_mode_configure() only needs to be called on sensor init, but it can
be called multiple times from ov8865_state_configure(). Move
ov8865_mode_configure() to ov8865_sensor_init().

Signed-off-by: Allen Ballway <ballway@chromium.org>
---
Changes in v2:
Cleaned up coding style
Removed call to ov8865_state_configure() from ov8865_sensor_init()
---
 drivers/media/i2c/ov8865.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
index 95ffe7536aa6aba814f4e5c3d12e7279470b2f07..eaa84fe68bdef45961885f435df99d98eb0ac0ca 100644
--- a/drivers/media/i2c/ov8865.c
+++ b/drivers/media/i2c/ov8865.c
@@ -2304,14 +2304,6 @@ static int ov8865_state_configure(struct ov8865_sensor *sensor,
 	if (sensor->state.streaming)
 		return -EBUSY;
 
-	/* State will be configured at first power on otherwise. */
-	if (pm_runtime_enabled(sensor->dev) &&
-	    !pm_runtime_suspended(sensor->dev)) {
-		ret = ov8865_mode_configure(sensor, mode, mbus_code);
-		if (ret)
-			return ret;
-	}
-
 	ret = ov8865_state_mipi_configure(sensor, mode, mbus_code);
 	if (ret)
 		return ret;
@@ -2384,10 +2376,10 @@ static int ov8865_sensor_init(struct ov8865_sensor *sensor)
 	}
 
 	/* Configure current mode. */
-	ret = ov8865_state_configure(sensor, sensor->state.mode,
-				     sensor->state.mbus_code);
+	ret = ov8865_mode_configure(sensor, sensor->state.mode,
+				    sensor->state.mbus_code);
 	if (ret) {
-		dev_err(sensor->dev, "failed to configure state\n");
+		dev_err(sensor->dev, "failed to configure mode\n");
 		return ret;
 	}
 

---
base-commit: 6832a9317eee280117cd695fa885b2b7a7a38daf
change-id: 20250722-mode_configure-80105fbd835d

Best regards,
-- 
Allen Ballway <ballway@chromium.org>


