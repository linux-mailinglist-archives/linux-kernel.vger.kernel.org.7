Return-Path: <linux-kernel+bounces-605341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 197FDA89FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 15:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7388E3BD352
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 13:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C99F1B81C1;
	Tue, 15 Apr 2025 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EXxj2el/"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02609198E9B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724884; cv=none; b=gg0SlH87ovssrcL5Y4lD9ApF5+8G3Qr3bWEqPMDmnnWK+EtYcZgStWY8AGQO1LMwL5tvZm/6hlT9JGTKRjdkK9CVjI9EYsmy2zgYcF8zGIY37/Tur8Tp0Im4XdPW0p5cYOZcrD4TwYBjt4T+lf4SiVUAz1r2aB9nGTmXbDWffeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724884; c=relaxed/simple;
	bh=9hnSK/z/at7Q/XPaFDHxC32ZrhxYmQz5KS3r7i8xong=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFUmBFk1UqjdRo3NKBB7vRs0fIwdOJ5wFY94x0FbPTANrTdWSUuXAd/6LijJMoKq4eRrDl0vm+q1lXuQrMaUEB/IOYpxj+txi6mcpPyJ5D9CKvHbvInxHT7QVMyFWIvqSSwOdhI0rEilBR99EZk24Zzj2iuDTM9kUnc5yVvAL/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EXxj2el/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so56435065e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 06:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744724880; x=1745329680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUkiFVraV2V5GiQVRCmgiYRRVnT/EoG7D4jFzUZHq4g=;
        b=EXxj2el/4LLgeleVPqjyl02FYT+TaVOeT+NTSkJwFNNsKgku3DOLRvYk2hF2MqQLdR
         nyVrTVLnM/KvT2IaN4rnsRAxMhnOvoRXisCh9O08mVyOYXYGjr1A6A1zo+Il0noqRAS5
         jxMi0PzHgQSIPKSg3xnqVx3Bb3+hM2jNa+dQkWdZJMCtnyIjNHGNCjBCzH4qh1payN5i
         zGDaE+ViXXTiEMRTOjvvns/Iny5kB1WCjQW5Dl/45mA37+vLLeCGKXvQxzKDjxTAMjH4
         xwwnJA15dWcG5r2CztpI+zAfErFix11nDSa5p9j+fX+vMDSznyU+m0GX/cn2FzMwcPeU
         2XHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744724880; x=1745329680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUkiFVraV2V5GiQVRCmgiYRRVnT/EoG7D4jFzUZHq4g=;
        b=nhKD4FiZ3ZMPSAbg2477NuCNkjLZYW49zHvLnWfbkkcKqvO0fUxfElj5wtdpzJhHFT
         t3LMra6nKuGaXL0TJrLlFRm+99EnSdiRnnYCwbGDaRS/OPDXoKzmBqVRE8tA1Hddo9/T
         WbfPf5ATeu5VGIBAHrx8IeNCWz9zrux4G8f50DuiogTO9tnX8wMyv1j3jdSeVto/YjQQ
         ZRVoky4/FChlPca37dw+vC/5E6WAykhDq10KfznsomvsNFxU/v5lZzNyfjVR9SwtdY9l
         sdBHS9E9quqO/VLZAZv2gzvQV+rLllq6RSsbhSJVntMKsKRiA7NxupOPrPbx4h22+IEO
         ghhw==
X-Forwarded-Encrypted: i=1; AJvYcCVUe9TH6ukNPDow3cbmOJNeDb5pAlvXm2YkzTte1waKSAmLNshYsF7p2XqWvToAAe7PGUk7HmojFEDjxOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5aMPaixE7wdFUriZ7WjIIBVB2ULVwaNauYhqTgzUM6GP2cMV
	TB1Akpd1ICLwLC2UiEwX8Je+XAqCgLJUNidwYgxyPJ1JQPTH97ZAqoUHDetx9Hg=
X-Gm-Gg: ASbGncsAuigQCSg0YZOhLIRP+rJh12IaFJ4eNgCbK2fhFJVQl1ZxVUqL9TZ9ARvawPz
	lfzWR+ZyKWQRCg72qIeiAOIUbs7BYPxNbBmD4eWEal+pieVdNY5GQQZLFXtT62K+eGF35wLFYXG
	6hkvYbiW4/k1tdUgY5boPKPbSJd9zI4ODLeM6ijf0IFoweB3X3jBaOOpVC4Z6g538Ilwe+qcHNd
	EHqeH+FHad8SifcKTGEcCUvmPvuRpvAMhQeect4FCtPsN9ss5iuhSjFjgFT74IGwYjr1lC74LBE
	L9rTOlz8ZGKiCVaUdAFiYrrjZy1aAY/koBLSYs6Wv19BpD7u1Dnyjjo/qvds9g==
X-Google-Smtp-Source: AGHT+IFMdi+4kbGwypmXXsrc/gyrInDJYkNwgbBgHQvNkP5YCt/nHE4d0rMikSiQ7LIFEN7Ilo2PCg==
X-Received: by 2002:a05:600c:3c82:b0:43c:ebc4:36a5 with SMTP id 5b1f17b1804b1-43f3a933b99mr139103035e9.7.1744724880253;
        Tue, 15 Apr 2025 06:48:00 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d0fcsm210434195e9.19.2025.04.15.06.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:47:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 15 Apr 2025 15:47:54 +0200
Subject: [PATCH v6 2/7] media: platform: qcom/iris: add
 power_off_controller to vpu_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-topic-sm8x50-iris-v10-v6-2-8ad319094055@linaro.org>
References: <20250415-topic-sm8x50-iris-v10-v6-0-8ad319094055@linaro.org>
In-Reply-To: <20250415-topic-sm8x50-iris-v10-v6-0-8ad319094055@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3981;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=9hnSK/z/at7Q/XPaFDHxC32ZrhxYmQz5KS3r7i8xong=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn/mOLNDxHTG5Da2DVWG/qPqBcln7veirdTZGxAqyl
 XAox2beJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/5jiwAKCRB33NvayMhJ0brfEA
 CpZOMYhUJwejreolozGB5rv+f6tgRnjK5wHky9FzlKf1HKCiWsChf0dOSzwdV3VLkKb4zD5DN/+xSp
 99sZ1YvEjG7M7C3X7DUutnUqqUjv96Wd1IfJN8vo4uOasTqmjGuNEgIH6A7aExflLjnL7VHcvyNcat
 oWdkT+f+bRJXNKIQjzU7YHm4DXM83r+CfzFyyzvvVEV0AEcM2yduxiJ4o9QRcWMATFdDAj7YJqXxwO
 qB8PzSiX4Q47CAQKMsMIZrbVy433gXYu/R6XRZULTEnmO4LEELjQ1paO4Oe4m6TWobd4H0C44rwewy
 Eq5d9HjgdpbYNdenoyesbtazlwqgYi8Vdy85MRFxqxu++AJOuY86Tlm9OtxixdFkYTN2dCP7XK2LUj
 T57LMZ7H1/3SQfAlSKCadKK2bOn9DQ0uU6nOWsNkbdSaeAkz/k6DlhXF8hgU6+I6IVOyrnawZsKFIX
 Ju2OoxDLwtal8saFNeo0aFBD9QolTZZoI13lAGiHkuviYIUgAbQrHycSy+ApfUwmIvumvxh3dfLy1Z
 GCtjnPqb9t94GSaR3UheUC7GmXWNlckGcx7NHJvsnZolr+6iViPFl/PeLZFi14Fh+dW4TCBs+VKMjN
 UGPexJnNuv90eCLPAhyPu4H30uN75wsTuHKlFh2+tLc3ZiBkDL+jlU5MAW9A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

In order to support the SM8650 iris33 hardware, we need to provide a
specific constoller power off sequences via the vpu_ops callbacks.

Add the callback, and use the current helper for currently supported
platforms.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # x1e Dell
Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/media/platform/qcom/iris/iris_vpu2.c       | 1 +
 drivers/media/platform/qcom/iris/iris_vpu3.c       | 1 +
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 4 ++--
 drivers/media/platform/qcom/iris/iris_vpu_common.h | 2 ++
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu2.c b/drivers/media/platform/qcom/iris/iris_vpu2.c
index 8f502aed43ce2fa6a272a2ce14ff1ca54d3e63a2..7cf1bfc352d34b897451061b5c14fbe90276433d 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu2.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu2.c
@@ -34,5 +34,6 @@ static u64 iris_vpu2_calc_freq(struct iris_inst *inst, size_t data_size)
 
 const struct vpu_ops iris_vpu2_ops = {
 	.power_off_hw = iris_vpu_power_off_hw,
+	.power_off_controller = iris_vpu_power_off_controller,
 	.calc_freq = iris_vpu2_calc_freq,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu3.c b/drivers/media/platform/qcom/iris/iris_vpu3.c
index b484638e6105a69319232f667ee7ae95e3853698..13dab61427b8bd0491b69a9bc5f5144d27d17362 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3.c
@@ -118,5 +118,6 @@ static u64 iris_vpu3_calculate_frequency(struct iris_inst *inst, size_t data_siz
 
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
+	.power_off_controller = iris_vpu_power_off_controller,
 	.calc_freq = iris_vpu3_calculate_frequency,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index fe9896d66848cdcd8c67bd45bbf3b6ce4a01ab10..268e45acaa7c0e3fe237123c62f0133d9dface14 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -211,7 +211,7 @@ int iris_vpu_prepare_pc(struct iris_core *core)
 	return -EAGAIN;
 }
 
-static int iris_vpu_power_off_controller(struct iris_core *core)
+int iris_vpu_power_off_controller(struct iris_core *core)
 {
 	u32 val = 0;
 	int ret;
@@ -264,7 +264,7 @@ void iris_vpu_power_off(struct iris_core *core)
 {
 	dev_pm_opp_set_rate(core->dev, 0);
 	core->iris_platform_data->vpu_ops->power_off_hw(core);
-	iris_vpu_power_off_controller(core);
+	core->iris_platform_data->vpu_ops->power_off_controller(core);
 	iris_unset_icc_bw(core);
 
 	if (!iris_vpu_watchdog(core, core->intr_status))
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index 63fa1fa5a4989e48aebdb6c7619c140000c0b44c..f8965661c602f990d5a7057565f79df4112d097e 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -13,6 +13,7 @@ extern const struct vpu_ops iris_vpu3_ops;
 
 struct vpu_ops {
 	void (*power_off_hw)(struct iris_core *core);
+	int (*power_off_controller)(struct iris_core *core);
 	u64 (*calc_freq)(struct iris_inst *inst, size_t data_size);
 };
 
@@ -22,6 +23,7 @@ void iris_vpu_clear_interrupt(struct iris_core *core);
 int iris_vpu_watchdog(struct iris_core *core, u32 intr_status);
 int iris_vpu_prepare_pc(struct iris_core *core);
 int iris_vpu_power_on(struct iris_core *core);
+int iris_vpu_power_off_controller(struct iris_core *core);
 void iris_vpu_power_off_hw(struct iris_core *core);
 void iris_vpu_power_off(struct iris_core *core);
 

-- 
2.34.1


