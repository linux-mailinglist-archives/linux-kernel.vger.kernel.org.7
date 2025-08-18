Return-Path: <linux-kernel+bounces-773334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3837B29E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4892518A1865
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F1030FF08;
	Mon, 18 Aug 2025 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHDrVGCp"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD6930F7F4
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510688; cv=none; b=SPO0f6WQnYeH/5Q6oIZYTSazPDwqKHoewOFI55/Wf9zFHaGrJSm3OCSrfbB4cNDkG0LUkRsaWcyivpCj3kiX2+V9PgK1CwY6nHtSIz7kxs8VxHjjmHD7tYbbrEJwgOApCQP2BXBSLyAjE9ZrTCqqR8TxOnsQyXxrTrKWnQQrsh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510688; c=relaxed/simple;
	bh=QBBhmYV+UQ2hXTTLPXbJol0ycEg/rF+5oel04wpKfk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ifE/BlkL+Sw2eLOZHttc6cLDuVN+bdSVVo+bDKqkGA/Wdlj+5pt19MjAxqHCP4zdj7hOdYObOJhnuqOOn3OiQLgiJipLWcbZZjGfIY8/poEhjJxlF1uzEXH6NnhH+pNvfcDvAh2MLD73IQ0K3LXY2x1OQx9eHOuctR2Pzl4OCSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IHDrVGCp; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3bb2fb3a436so2100665f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755510685; x=1756115485; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=irOcbMOZce8tdkmOmvyjdJd5jG31cnXbJF+FtwR0pdw=;
        b=IHDrVGCp/FquoRUHRTf0XOvSxr4KJQROWnVCmET1qDWwS1PJJKmDnSB2leaCXJov1W
         dLb5He/TfbWLypOf1zVHX4xFMDVAZ3cHxZhPkrbPAjvJN465isZY6Dr6sbJojmvmsopo
         JYKCTSvAWzSsD6vs4/d1oaLkX2NnKHODGD1NT3Lr3HDNMO64EIir2lqdeEUF8PNvegsN
         sqFns7x3fpzCBKK8CbnjfHdxL0XaCUgqp9K8haj9r1Y1mzwZPha3OjVazD8s5DnIq0UC
         fCkEmhG+r4H0PxqY5TVila62dKnbfQuXC3LY2mFVQzBZI0kSLLIenWzpafsYZDtMwAEJ
         Q1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510685; x=1756115485;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irOcbMOZce8tdkmOmvyjdJd5jG31cnXbJF+FtwR0pdw=;
        b=t1XLrIj8XQvg713/pMqZ/m2nNQ6li+I7YdxnkEuVKkTtdIqdE/rLDKSG7vNoMc5Fl9
         5MxGhdTy+V3yNPjQq+MjdjNKCdFvc+RiYRL+fjx+KAdYkHM3ZnxT/tiEd7BJiTa2poei
         PC7tKOnXJhc8VyegQSpajJw5RwK2Rbbjt4szky5he0565yYy7WuLKyhKrpQAK2eVc94W
         5zUL8j9AgU/NyvdfJgjPTP4JSHHflIKTwYjTSlOtEL1EQZG+iEe+7h5b3DVzw6cEroE7
         71Wead/3vHpsRDWEy50Q9YR7f2xqWKvHv+qnPCYP4Jy/yAAa82V0Hk3NqiQdYMk1FqHp
         /jCA==
X-Forwarded-Encrypted: i=1; AJvYcCW1T/g066P3fMwZ0OUgz3GJgzqXPgfo1FqiGoiYZpy+umGa1IuJQbFNTj6CErrXdda4roMyy5ZxU8z1I9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxhiEd2B8Z7wz5xM7vJ3BjH65o4bERq8gz3Vxz8RoS+R3uPFV6
	qfHGLfqR5rDgNWiJT61QMzjgNlD4TWEXypW3Y0xJVIfGf42wY6r5/eOwNG0cn7rrOPE=
X-Gm-Gg: ASbGnct8PjrEzlf0PbAa1wwqktv3m9lk5odilwtdBO80isyBSAx1twN65tHCFGIopoz
	43YfNh5lp1HTQJEQJ6krcZLvDQBm3Ev0l43A+7hc2QCubYKb1zqYFefNDW4mIQLHIw77HtjIqYW
	K/bjh7UjN4w5BEMx6ZuJ7tg02HDUMDKFQx1Z2EP4QzBTbD05eqIble/HrUZm9JPwEwBOszu3j90
	wpriQGxm5uxuLZhm24s0R4Y0xROm2Cq3nU2XN2maL59vGbRUxd0/lbYb4/+XL51fJdf4hsaUp4B
	YfDohpOIFVxzG55GIAMnbSTU1Tn8wi6hO0pzGHWlL4n3juN5BR7a7EmBZSwZfoS72De48yXbZqT
	47zz3ViMXSXj6y9px0JGOSphDlT86aguPgrZvLw==
X-Google-Smtp-Source: AGHT+IHU8L5zc37ViCmI7CAJbkfEFWeKIJ6N/OF/IPmJs52MJ5SlIlIojdXPEOIrX5ObGymSXBjkOQ==
X-Received: by 2002:a05:6000:188c:b0:3b8:ffd1:80d2 with SMTP id ffacd0b85a97d-3bc684d7c2fmr6672591f8f.24.1755510685037;
        Mon, 18 Aug 2025 02:51:25 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:7049:5418:d1a7:cc44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bc4afe7a63sm10157016f8f.15.2025.08.18.02.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 02:51:24 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 18 Aug 2025 11:50:41 +0200
Subject: [PATCH] media: iris: Fix firmware reference leak and unmap memory
 after load
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-iris-firmware-leak-v1-1-1e3f9b8d31ce@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHD3omgC/x3M3QpAQBCG4VvRHJuyWMmtyMHiw+S32ULJvdscP
 gfv+5CHCjxV0UOKU7zsW4CJI+omt41g6YMpTVKblMayqHgeRNfLKXiBm7ktujxrewOUlkJ4KAa
 5/2ndvO8HphHEP2QAAAA=
X-Change-ID: 20250815-iris-firmware-leak-b6c43bd1ee85
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Stefan Schmidt <stefan.schmidt@linaro.org>, 
 Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2

When we succeed loading the firmware, we don't want to hold on to the
firmware pointer anymore, since it won't be freed anywhere else. The same
applies for the mapped memory. Unmapping the memory is particularly
important since the memory will be protected after the Iris firmware is
started, so we need to make sure there will be no accidental access to this
region (even if just a speculative one from the CPU).

Almost the same firmware loading code also exists in venus/firmware.c,
there it is implemented correctly.

Fix this by dropping the early "return ret" and move the call of
qcom_scm_pas_auth_and_reset() out of iris_load_fw_to_memory(). We should
unmap the memory before bringing the firmware out of reset.

Cc: stable@vger.kernel.org
Fixes: d19b163356b8 ("media: iris: implement video firmware load/unload")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/media/platform/qcom/iris/iris_firmware.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_firmware.c b/drivers/media/platform/qcom/iris/iris_firmware.c
index f1b5cd56db3225d0a97e07d3a63c24814deeba78..9ab499fad946446a87036720f49c9c8d311f3060 100644
--- a/drivers/media/platform/qcom/iris/iris_firmware.c
+++ b/drivers/media/platform/qcom/iris/iris_firmware.c
@@ -60,16 +60,7 @@ static int iris_load_fw_to_memory(struct iris_core *core, const char *fw_name)
 
 	ret = qcom_mdt_load(dev, firmware, fw_name,
 			    pas_id, mem_virt, mem_phys, res_size, NULL);
-	if (ret)
-		goto err_mem_unmap;
-
-	ret = qcom_scm_pas_auth_and_reset(pas_id);
-	if (ret)
-		goto err_mem_unmap;
-
-	return ret;
 
-err_mem_unmap:
 	memunmap(mem_virt);
 err_release_fw:
 	release_firmware(firmware);
@@ -94,6 +85,12 @@ int iris_fw_load(struct iris_core *core)
 		return -ENOMEM;
 	}
 
+	ret = qcom_scm_pas_auth_and_reset(core->iris_platform_data->pas_id);
+	if (ret)  {
+		dev_err(core->dev, "auth and reset failed: %d\n", ret);
+		return ret;
+	}
+
 	ret = qcom_scm_mem_protect_video_var(cp_config->cp_start,
 					     cp_config->cp_size,
 					     cp_config->cp_nonpixel_start,

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250815-iris-firmware-leak-b6c43bd1ee85

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


