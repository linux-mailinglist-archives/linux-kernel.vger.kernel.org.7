Return-Path: <linux-kernel+bounces-791734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C444FB3BB27
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912591B21397
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA12314B86;
	Fri, 29 Aug 2025 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UJCkVPum"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6912C0F78
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470067; cv=none; b=ftYfF0JsGsqUn3sBOtnZO1xk7rZTYSw/54De9JA5lEm1c67zrlrXpxEHSe8CkTtaG3YIWJzQM2t8APSUayU7J4RERsaSUgNGCngzLV68EqXu0dNOEOteLGoIpbE4af5G5gnwtw7dsrQJiJCsN6yz6qroibkK5pYW9H+LzGDmPs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470067; c=relaxed/simple;
	bh=aWDmcKQxJLeLFc2zLkg59VZBRjE8kpjJMy4W/8wPRag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mWV/o5O/xAE8n0kx+o4cDhm21uYeSFo8vZpFQBR0H94SNwwN38tkj87gHc0Z3wcw05BwEHjWRHqcfDw93EhYB1gFL0oOeoVzohaa90KWR1IVcMfgUNbTGVAVvmI4nkHK5BRr5q7537SjdCfBmo67FZ884TcZ3t6CLVMjZ4yk/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UJCkVPum; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f53efe803so2445845e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756470062; x=1757074862; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zW4AqSEKv0kJ/6/OBgXVXAF4o8+R44pXfVrj6w3QMT8=;
        b=UJCkVPumwxbKg8DOUW9LEQ2cD49u+20hj1tYg5PsFQ8VZ55Yml8r8tTnnQvyXyZGVl
         PyWrZpqHv3q1g/6QL5dMI6q2mltxE2PEwLi8Ww5AXjog54ZyC+n2+2Yn82tEsajkXNJ2
         Ky/SumRPgiEYNQTjyry2zVe+10zWc10NPEbVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470062; x=1757074862;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zW4AqSEKv0kJ/6/OBgXVXAF4o8+R44pXfVrj6w3QMT8=;
        b=S4unJCZ+DXfVdPPRSbbmKE49Q7BHSTqxSokpWPb62hbps9JUUMLIa7fivyrYujeFz1
         SXrTjc/ChT7oILqpmGSh+oyt4Xqxqfmsy+yvYludnX0U5uKEYBm6C3UQESQ1Qg+A/xC+
         g6gKfF9/hjOvg9mIrtUyoT6QObXR3thQq0kbsIvFPeduaoraxgdrO33I7nVa7XaTbHse
         kVPpekymt9JKxb0ucRNSCO85Ih6AYGOwLiOiF1EzYzSJ8hTsdywd77vFELcfV1Xvlgol
         YXtTiHulPjMZGKi0V7RzQm6V0elBeqvzTZfBVQLLWsFs1cMjKC2Tic7+9gre721QW5b1
         +j8g==
X-Forwarded-Encrypted: i=1; AJvYcCVWYWQZg1c7SEWFKa+gjcPJBtgdMt7e6HLiLkLYHVpC9bLqdSqgn+PX2TPrXpiaTGYKgxLvgu0hYOihhTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXvPYoz/efZKFpR1Hwp9x6KfeRmZCmJdBmmeDZe5K+TFQqkex+
	djdjx1xJV9PEQ9X1+XJ7qmdv0/G+jcPGqvy8bgXoXz3vvuomQsfDZltOK6vCFKZasQ==
X-Gm-Gg: ASbGncuaoX+7EVq6p39u1VJBMEI/ounsh68ZIzmfNMv8QAGG6q4B2r4HHzoxWoq+vA/
	J5dZOkc0hfryQQX8m7SGM330LQZfgu/fFJtVsydPVF4Fz3mHbQaV8P24ifL7trekSeiMHoP60Ho
	0ZmA7+4uJCELlTBftzPivGCGR2XfKNMy+uNA97Dg1cPfDG5KZzYgTDfraj2eFvuaDLq7/Rukxet
	Cn+iXcGwl74oihuEZwFgXlPtbxGBPfbDP0F2/GxNsTptt+3opKbQQbMYCp4I2RwvBxIflBoX/4V
	VLw/6qT+rjV93cc+oABEZaiJwON342s/E99JgYIQmkaU1lWWS3sIs9bUsh4b9CFIRr2rYy6b4aL
	/3VkrkGqFUB+lAIC9RSUy2Fj+fy6aNDOiC1br0teQ/oQKv8MoES2YbWOBuJ2aSMyS5ig4yeDkJO
	I=
X-Google-Smtp-Source: AGHT+IF2QWCHbTAObS7nDBaTJMvC3i63bxSUzXfhy7g5nsIjei4FJvSWRcK9EvWQJ5ryoIHlYZkW/g==
X-Received: by 2002:a05:6512:2282:b0:55f:4f99:f3cb with SMTP id 2adb3069b0e04-55f4f99f618mr3561895e87.15.1756470061985;
        Fri, 29 Aug 2025 05:21:01 -0700 (PDT)
Received: from ribalda.c.googlers.com (237.65.88.34.bc.googleusercontent.com. [34.88.65.237])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676dbb6dsm600774e87.13.2025.08.29.05.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:21:01 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Aug 2025 12:21:00 +0000
Subject: [PATCH] media: i2c: imx214: Exit early on control init errors
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-imx214-smatch-v1-1-f3d1653b48e4@chromium.org>
X-B4-Tracking: v=1; b=H4sIACubsWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNL3czcCiNDE93i3MSS5AzdZJMUIDQ3MbJIMVUC6ikoSk3LrACbFx1
 bWwsAlYcLi18AAAA=
X-Change-ID: 20250829-imx214-smatch-c4d4d47428d5
To: Ricardo Ribalda <ribalda@kernel.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

Now we try to initialize all the controls and at the very end check
ctrl_hdlr->error to check if one of them has failed.

This confuses smatch, who do not know how to track the state of
imx214->link_freq.

drivers/media/i2c/imx214.c:1109 imx214_ctrls_init() error: we previously assumed 'imx214->link_freq' could be null (see line 1017)

Fix this by exiting early on control initi errors.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Right now we are handling this with a quirk in media-ci, if Dan cannot
fix smatch in a kernel cycle we should merge this patch.
---
 drivers/media/i2c/imx214.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx214.c b/drivers/media/i2c/imx214.c
index 94ebe625c9e6ee0fb67fe1d89b48b2f1bf58ffc6..7da9e8fa2b622adba53fa6b544bca9859da23e3e 100644
--- a/drivers/media/i2c/imx214.c
+++ b/drivers/media/i2c/imx214.c
@@ -1014,8 +1014,10 @@ static int imx214_ctrls_init(struct imx214 *imx214)
 						   V4L2_CID_LINK_FREQ,
 						   imx214->bus_cfg.nr_of_link_frequencies - 1,
 						   0, imx214->bus_cfg.link_frequencies);
-	if (imx214->link_freq)
-		imx214->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
+	if (!imx214->link_freq)
+		goto err_init_ctrl;
+
+	imx214->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
 
 	/*
 	 * WARNING!
@@ -1101,6 +1103,7 @@ static int imx214_ctrls_init(struct imx214 *imx214)
 
 	ret = ctrl_hdlr->error;
 	if (ret) {
+err_init_ctrl:
 		v4l2_ctrl_handler_free(ctrl_hdlr);
 		dev_err(imx214->dev, "failed to add controls: %d\n", ret);
 		return ret;

---
base-commit: 16428e2449ab96cce27be6ab17b750b404c76c7c
change-id: 20250829-imx214-smatch-c4d4d47428d5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


