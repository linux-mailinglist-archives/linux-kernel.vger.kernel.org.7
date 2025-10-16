Return-Path: <linux-kernel+bounces-856110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C276BE31CA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0718B587194
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8B132C30F;
	Thu, 16 Oct 2025 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="aNYUIh8z"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1FA31A7E2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614544; cv=none; b=aFTiw92RxN+u/6vVIEWEi97r4Q1CaL/1SnnlZ/SRDZMXKvhdyBhoRuB/UM+G8wk8srrNYRmvZ7FzS/4H+RfE9QmA6oMtZ1c3Mo0KtX7KsRBwnMOmsFyRB5Y14i28/96pCkkMDX+mjMA7bX/6VAOiwxF5AgouJ0wqcetgj4Riys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614544; c=relaxed/simple;
	bh=O4rKc5sy4aBgNGWvywdtU9qBCzmUASThUm+1bKVdk1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lE1C3Zn4INiGs9sBkov/X7C/uuvUT2Ek3MT321JJP7kqnnTXXW5VPiFA6lYCH5fOqUB1ixFZ5Z7MvW/aNBclDDenIv3DOAzjYi8Vn/HoywiUGKeCHPhjF5Ob+2vapqEm00nq7SZAXV/QPFxWCQMd5SMa5SI0AlpxhO0sbI0lLh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=aNYUIh8z; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso1143532a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760614539; x=1761219339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0FpJ3krtfpqdj7q9wHL/cml6yEqlBhsQEIvVzkEwck=;
        b=aNYUIh8z3Q/QOqW6tjPAaXuI6u56lhNqP8CF/HE8zwgOxD5TKpjIw9NPOyyifbKMWj
         6jKUa+nxs+FlUE0S0nd9kmmRNGCyY+9FMX2+E8JpQ2Btco1mgywPF7CoM/zlAc1xwFsU
         +205bTa0cR0p4NSUu5pYamqslvmwGEtrJoVMzzKd++kQmcbtNhbi8qZjFY49bxCV+Q+T
         yenjh8Y9+JDYwVXaPRXQWWy8xoPaa4LkWprTQIgOq/K2t42gDmW65iilbzKNV93al8ug
         dSOc1RbGx/VYjjksCgXvdQ5z2qonFY+a1a/k/0N45C7zdssqfSJI2BiVmTCZrj+4qLQP
         pORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760614539; x=1761219339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0FpJ3krtfpqdj7q9wHL/cml6yEqlBhsQEIvVzkEwck=;
        b=k8dQNmDK6IzLATJ4rxAODoairwk0qCMUdwaynZyxJewYfPPkg3O4yN7BBYhJFtZIU9
         CBQwKJ5CPEBx2LgPkepmL+bnBtL33dW0LaNzhwZhdRUVu0tg4XDfCjqAs3FeX9IC48tZ
         pyTbaf1OGcaX3vOxYq8a7ww6vt65ukwlUMCslL9AHRT4Yad4bB5CLGEJAoMCKzqQnJ/1
         BMTusPnhRpd1GTJfEF7KEslenzta+rChC9PaUlOnIlGtV/FjCAv+Yx3yTfoHhjaan5GY
         UZG89wnsjDuAJx9Qbo5oKpObafpf1VCe0uM1tMovB/DHHpJ6IWI9E7BzUCx2psC1Rzmc
         eLNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY+n+ie81bvBQgn364O5OSXuhLnFXXAcseiaigM/wMSnekwdTyk2asYnLTNHWVd7PScJO0Hx/LXC4j4wE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx356AowJjRHk/pzD7hbK6LBuHyNNFZ/NjpVoqQGu9VMTmTwYU5
	aualke6XIl396cERs8CBmwR/zzvh5spFi8V0WRvUVFafckBmF2//swSYHjoIFvm0iXM=
X-Gm-Gg: ASbGncteUrRz/+//F64hIjdEOq9vTeA8Ppg9Gp7QGzedmVu7VW8bz8T7YgkTZ8YR3JO
	hsPmUwvRdV6CvW3QgPF+yT+vYAlz8xBK5fmeQZkpEIPs87SMXj4nBRUrizxe/OBrrE8Q23sdYfL
	fx1dilO27Tvq8eQZnaRNZkk93sTQVXeEk0KgFaWh+6JR1MEtd1/U7SEHTK2UimMobqC6n4Sr8h2
	np4VFIG/KdeB7l16ztKSfCu58bZI1dwn8j33gfnlx/fIxhXj7+Uudr5RcIztXX65bjaaYqRPNuE
	1OgMw/8X5ou0eYxflsjgAiTPR9DmYcmmhG0g2kHDq/+o1TkAysoAL9BOkq5kYJM3S6E7E3FseI/
	jHM+YEBQ9+0nyxodLaGb9cW2x3x4JaC1A9E2yGUVIyIifBa0mK8SwQkrzwsox1jSJGoa5yjiP5a
	WJTTqtjlWMnxcnY/rKv0N2J4dneD4ghZsTln2dcweU9LYr2joXvw7TI1G51Q==
X-Google-Smtp-Source: AGHT+IEG3dCpKcVJYID+c0OWz372qjRoKiSXU0T4AZRS/rp11xQVeouzN18fTWfpzl+bcSHxHxRnzg==
X-Received: by 2002:a05:6402:40d5:b0:63b:ed9c:dd16 with SMTP id 4fb4d7f45d1cf-63bed9cdf34mr6705502a12.3.1760614539082;
        Thu, 16 Oct 2025 04:35:39 -0700 (PDT)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b1e89csm15849397a12.19.2025.10.16.04.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 04:35:38 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 16 Oct 2025 13:35:23 +0200
Subject: [PATCH v3 2/4] media: i2c: dw9719: Add DW9800K support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-dw9800-driver-v3-2-d7058f72ead4@fairphone.com>
References: <20251016-dw9800-driver-v3-0-d7058f72ead4@fairphone.com>
In-Reply-To: <20251016-dw9800-driver-v3-0-d7058f72ead4@fairphone.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Daniel Scally <djrscally@gmail.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760614534; l=2782;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=O4rKc5sy4aBgNGWvywdtU9qBCzmUASThUm+1bKVdk1Q=;
 b=Jrp8bJ8iQSh0riK68tm9jxFjE9G7FmGLLB9PaFBqVDrh7pHupDGsgfvgJ+E66QztssfS5zewt
 KdgSq2Et5JFBbu2aQu5a+v8+gCKDD7v3GgPvs02HHtoBZ017S3kX4G/
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

The DW9800K is a similar part to the DW9719. The method for operation is
the same as the DW9719, but the register set is different. Add support
for this part to the existing dw9719 driver.

Tested on the Fairphone 5 smartphone.

Tested-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 drivers/media/i2c/dw9719.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/dw9719.c b/drivers/media/i2c/dw9719.c
index 3627e78b8b6668933c4ecd92231465ce4105ff0c..59558335989ed2825ef7a0d356ddfe10f001716a 100644
--- a/drivers/media/i2c/dw9719.c
+++ b/drivers/media/i2c/dw9719.c
@@ -68,6 +68,9 @@
 #define DW9761_VCM_PRELOAD		CCI_REG8(8)
 #define DW9761_DEFAULT_VCM_PRELOAD	0x73
 
+#define DW9800K_DEFAULT_SAC		1
+#define DW9800K_MODE_SAC_SHIFT		6
+#define DW9800K_DEFAULT_VCM_FREQ		0x10
 
 #define to_dw9719_device(x) container_of(x, struct dw9719_device, sd)
 
@@ -75,6 +78,7 @@ enum dw9719_model {
 	DW9718S,
 	DW9719,
 	DW9761,
+	DW9800K,
 };
 
 struct dw9719_device {
@@ -130,11 +134,18 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 	cci_write(dw9719->regmap, reg_pwr, DW9719_STANDBY, &ret);
 
 	if (detect) {
-		/* This model does not have an INFO register */
-		if (dw9719->model == DW9718S) {
+		/* These models do not have an INFO register */
+		switch (dw9719->model) {
+		case DW9718S:
 			dw9719->sac_mode = DW9718S_DEFAULT_SAC;
 			dw9719->vcm_freq = DW9718S_DEFAULT_VCM_FREQ;
 			goto props;
+		case DW9800K:
+			dw9719->sac_mode = DW9800K_DEFAULT_SAC;
+			dw9719->vcm_freq = DW9800K_DEFAULT_VCM_FREQ;
+			goto props;
+		default:
+			break;
 		}
 
 		ret = cci_read(dw9719->regmap, DW9719_INFO, &val, NULL);
@@ -177,6 +188,12 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 	}
 
 	switch (dw9719->model) {
+	case DW9800K:
+		cci_write(dw9719->regmap, DW9719_CONTROL, DW9719_ENABLE_RINGING, &ret);
+		cci_write(dw9719->regmap, DW9719_MODE,
+			  dw9719->sac_mode << DW9800K_MODE_SAC_SHIFT, &ret);
+		cci_write(dw9719->regmap, DW9719_VCM_FREQ, dw9719->vcm_freq, &ret);
+		break;
 	case DW9718S:
 		/* Datasheet says [OCP/UVLO] should be disabled below 2.5V */
 		dw9719->sac_mode &= DW9718S_CONTROL_SAC_MASK;
@@ -426,6 +443,7 @@ static const struct of_device_id dw9719_of_table[] = {
 	{ .compatible = "dongwoon,dw9718s", .data = (const void *)DW9718S },
 	{ .compatible = "dongwoon,dw9719", .data = (const void *)DW9719 },
 	{ .compatible = "dongwoon,dw9761", .data = (const void *)DW9761 },
+	{ .compatible = "dongwoon,dw9800k", .data = (const void *)DW9800K },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, dw9719_of_table);

-- 
2.43.0


