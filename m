Return-Path: <linux-kernel+bounces-840119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F58BB3962
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7B3189BA07
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A6930AAC7;
	Thu,  2 Oct 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="fSGo9GlA"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB60D308F0A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759400149; cv=none; b=H78OekVKv9Q3WGSqkmhPY1RKRU62kOOE3f0taKXTRBYoLTr9YAVgWPQBPal3YOhSZl2l3ctJ27FHbG0+8Y5ZEQQT4S+sA2W/NROdPDo4V61D3oF6nfTxuPPGG6+JC/W4XF7GofSMJ+7ujjsryR4fETpP9jKFr0Wrft3UUJv7EGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759400149; c=relaxed/simple;
	bh=4S0fonwtNaMiRsMJskKUXGgiupKPbZ1yq9y5vaUwWQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q4hnQV/aoA9pgjKofC3Wl6oYdTq/sC8B9eUSP0hluXwpk7kcL3M3zWrUb6ylFe0NZoEt6UmNaE2Z8kdcYRY5PY0+381fZ19rBGIeE9j/3hVubn7AGXVS23GxOd1I2nff2dWnGr47XyBTjhznirRdAmsEhPtkUHpu9PEgoqDvlCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=fSGo9GlA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so1408906a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1759400146; x=1760004946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1OIQtBRu/WprhbP6faVFfcIfdDA6GpU6KASBlBkiMI=;
        b=fSGo9GlAkLMEQwx9ff1nnqJ/1E8cWgQP/BchZ2aGCoo4UACTCFMzdEzwKI+JCk4Pye
         AltjS1fNQaKI/8/S7ZQuP0OO5H9aoIP/eO8HnQXnUYXnknQbB6HI3IcAwdDeUhymzwXl
         z3hWTEvVvS51I1BQ/mDdA7Yq0bCr/qqrNQYIBahF0TU4ohyycDlf+ZwrKoZm0wmb3RED
         WQx7Kh2L2LRWNAna5ExGbF7fW60uxzG6ZEHE4kaWOKEDurkom5vx/V8lDb+zw3ZRnnwL
         VYCFNZ6alYO5hOCNK78Pmm+AnEBd1q07k+JSMbHYwVsgyCa3J00/6uXQumFJW5sycN3C
         5XlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759400146; x=1760004946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1OIQtBRu/WprhbP6faVFfcIfdDA6GpU6KASBlBkiMI=;
        b=lul+8+6ihR18RUT1t/1MvZ7OenvpfoZvDy/CmljT0Qk3FDfq7t2jhiG/Bk71Sf4mD4
         6qSbpKoAO1SwAkIww9K1wB2DL5y4h4/rPm4trOyuKmDEAn1GagemxQ9Tl+to+YEqE/bx
         byNOjTZHCQIIl8lL4Eig4HMdlW+xM5EneBZf0h+yrpYgCd2k0Jt+sh1Ow5ie8Dl7b7mv
         Ufy5j8WTVgo1Dky18Urkt1FJeUaKrGCLvHqrqKi9bYZZzry65Xdu4QmqLhyrxdvbFQvm
         PmVdEypoiEYWrrq2K1hTF3uq+NNr1m6i989ialId58FkTjrDL5wIDKRkrS3/FeDKvNAa
         DC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6iuup0w2Ckz6+bJy2t9kQum5P66sTILl92Fj6+jCBjIrJ2GyRSCTBjaCO3FEGEQt+TRGHpuTEl3iKRxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSb8qFJCp7CZkgvYxCWfyFqaLky2yyi6UJCJCTLQY20KIHszDh
	wTRSeFalpLviQlkShMHDN9kMCiLt6/gt7VAQrXFG7vP8VvF0X2rPo2bvvU43xu0BNSk=
X-Gm-Gg: ASbGncunQFbCUzZe05hB7xSmmEEhx6e+zZoBifMp9AOUcFlaHk0ps3xf13rRwkwegyK
	xbYk1sxD3CSgjEAsa1ONnMgVgnqDJ5ABgYlxlmPefo5e2/o6ZmGdmNzpUjpa3R+0MQMcyauv+aU
	SgIvgTyr9Ha3Os8oECZfROsFy9mv0umZql4YfvC66xiJdPosihfGk9E+unv1uVBS0xF5OCvSB5x
	Mvw1LhMo0yfce69VA385f/h3V3gF8WSmLL5pVG6IsOiHNfd3qC+Zq7wT8/hicM9J5Adm9bf6MPE
	wMyOuZFYv9YlPg9OzqEbCHmWNbZkqiRxww6P7PjlC0nHLsPGxnZo2yTlWKLUVErlQgzXZGTpt8p
	MIbCSRnae+v5d53rhuuQ1+AmklY47y9Uwz5WHzx5mJJxUg3U+0lbRGXbBBcUScCRiHYEzwyDHs3
	34YmqrStcVSF7aFynQXJBm01VWOy0n
X-Google-Smtp-Source: AGHT+IF7ZbtnLWsvPJhQN1RSKQw+RDAp4xELO1JKJ0B5XI3fYprHLA3ovfGjHaxD/7jWkw7clR39uw==
X-Received: by 2002:a17:906:c103:b0:b42:f7df:a2f4 with SMTP id a640c23a62f3a-b46e94644f8mr865762466b.52.1759400146005;
        Thu, 02 Oct 2025 03:15:46 -0700 (PDT)
Received: from [172.16.220.227] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e77427sm174862366b.36.2025.10.02.03.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:15:45 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Thu, 02 Oct 2025 12:15:34 +0200
Subject: [PATCH 2/4] media: i2c: dw9719: Add DW9800K support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251002-dw9800-driver-v1-2-c305328e44f0@fairphone.com>
References: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
In-Reply-To: <20251002-dw9800-driver-v1-0-c305328e44f0@fairphone.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Daniel Scally <djrscally@gmail.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759400143; l=2384;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=4S0fonwtNaMiRsMJskKUXGgiupKPbZ1yq9y5vaUwWQ4=;
 b=OQkAvbTC0VB69piBjtPx6WV4d4BVHjc5nyvTAGrM7x9uvXVMxqQHHqI1k1gup8JsV4W4oIdYY
 jBiQtg/xFsABvz/OxeMwP76goePHsyKnz4O4MJO8F+38BboI/fQ4W+V
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

The DW9800K is a similar part to the DW9719. The method for operation is
the same as the DW9719, but the register set is different. Add support
for this part to the existing dw9719 driver.

Tested on the Fairphone 5 smartphone.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 drivers/media/i2c/dw9719.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/media/i2c/dw9719.c b/drivers/media/i2c/dw9719.c
index 3627e78b8b6668933c4ecd92231465ce4105ff0c..172479f2c9f63f6b2a1f6eccf8184142edb383b9 100644
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
@@ -137,6 +141,12 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 			goto props;
 		}
 
+		if (dw9719->model == DW9800K) {
+			dw9719->sac_mode = DW9800K_DEFAULT_SAC;
+			dw9719->vcm_freq = DW9800K_DEFAULT_VCM_FREQ;
+			goto props;
+		}
+
 		ret = cci_read(dw9719->regmap, DW9719_INFO, &val, NULL);
 		if (ret < 0)
 			return ret;
@@ -177,6 +187,12 @@ static int dw9719_power_up(struct dw9719_device *dw9719, bool detect)
 	}
 
 	switch (dw9719->model) {
+	case DW9800K:
+		cci_write(dw9719->regmap, DW9719_CONTROL, DW9719_ENABLE_RINGING, &ret);
+		cci_write(dw9719->regmap, DW9719_MODE,
+				  dw9719->sac_mode << DW9800K_MODE_SAC_SHIFT, &ret);
+		cci_write(dw9719->regmap, DW9719_VCM_FREQ, dw9719->vcm_freq, &ret);
+		break;
 	case DW9718S:
 		/* Datasheet says [OCP/UVLO] should be disabled below 2.5V */
 		dw9719->sac_mode &= DW9718S_CONTROL_SAC_MASK;
@@ -426,6 +442,7 @@ static const struct of_device_id dw9719_of_table[] = {
 	{ .compatible = "dongwoon,dw9718s", .data = (const void *)DW9718S },
 	{ .compatible = "dongwoon,dw9719", .data = (const void *)DW9719 },
 	{ .compatible = "dongwoon,dw9761", .data = (const void *)DW9761 },
+	{ .compatible = "dongwoon,dw9800k", .data = (const void *)DW9800K },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, dw9719_of_table);

-- 
2.43.0


