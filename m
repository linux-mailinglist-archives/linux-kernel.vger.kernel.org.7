Return-Path: <linux-kernel+bounces-887741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29421C38FD9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CE418C7362
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035A92D7DDC;
	Thu,  6 Nov 2025 03:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nzpdbmpw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZcOg7ICK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C722D46D9
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399863; cv=none; b=pWkHdU7q3eBKUwPY9WE8CDm9ARSq7UqUsEaLZ9RHsl7oZptN5tZt3FBFASFUyta8kS3ZIW9idO20zuiFf+8Y79VHCdH/9uyGf4yzeYfaVYC1J9V5cGgja9K/qO/B206gF5jrfek3cPjS0ihcapthfb5J8JVuZIrZm+WI17qU4c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399863; c=relaxed/simple;
	bh=fJoAPc83wR1LgHrDfr408IQ1A/7ZxGfeFvE/M2rCaic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D10REHjp8md515n4VQ1hrGFQl9f2zy8SVsQS6IOsdL/A3vsLGOThDCW0t3Hi2yOdQniHnFf/j9sCNEBLRvQyUPDY5tWKmPcn2MOsnTWqT/ii+zuD95DFu4TiUQYSUrNgGXOHsWjeAFcatq075PDt3t+orGjouE3cDGGXI/O3iC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nzpdbmpw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZcOg7ICK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KEjU81938379
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 03:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ovGBUB15DEWLk0DVrQSRCkCYrN6zQfyDDY5aUsiUaHo=; b=nzpdbmpwTf6c8P/z
	yy6nAF2sbpyZKDRQKw2Pj8+sebU3Mr1YaCcIh037GtKKR+imUPjWbHHVSjJm6Unm
	zicAzNp1TEyEpGMO3pwtdYSo6eQkfYOJ5IJXtfPu/DPVTHqaq/dYgkM5tmXeIejY
	onHuFHVFcwr/0ewss3EkK/+aw/AVTEizqYeff11UJ8jZB/CpMzfgLRx58xsTYWsK
	K7ptFWYcBhhm0VUlhqpw4d7p1QwtJuVXJ/XMxsmxD1OvOSO6LXr4jffYPXX7QJh4
	/T1wVcYMHn2aL3+evBD+8fcRARC+DeyJhXuXku3wSzo7DqRxKZyukhBf8w3kNdYz
	ttbMnw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8apgsk3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:31:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-28eb14e3cafso11474825ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 19:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762399860; x=1763004660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovGBUB15DEWLk0DVrQSRCkCYrN6zQfyDDY5aUsiUaHo=;
        b=ZcOg7ICKva9OftrK7YOTQn6+pU9hahgtmsbpGAm/wFs+cVFV3YkTrOth6vod9VXAfN
         FDngENfhtxoB/ny85tSszahPD0yCXWXXhW27tCViqjW7/I9BDYcECozQV1Kwb0fNFd4b
         W52OAjDFbgkYxNJOUpz7KN2VGQ63NwvAZdt+rSMfanhLZcFh81eVDMSotq5kuxDEBj1F
         Ox5dVYFW3ZwuhyQA6ShzZy5JUU+quxP28837bDdAH5ajmHB5pgxPgspU4YSrGOh0/sQg
         YQ6qQXekGk+WhSCtqht4wcib4mMBAS06klua78YrgONktl+GoGg8JxgkBn3/WIGJZiGr
         ZViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762399860; x=1763004660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovGBUB15DEWLk0DVrQSRCkCYrN6zQfyDDY5aUsiUaHo=;
        b=vgd0auv0FyC6hGJh2B+zwl+v2MkxV/x9SGZI37j6HxhtV8lE78QUMC1XsZbhmOWeSN
         bLoX/r8iY0L8TMlL+DbayqV5L5Q8CFbFNWr0l4bC15gauejAwd4trOZ/gzSQw0TMuMSP
         srrReqwcYs2Aky2qq5TYfeQ0VDkHrAAH/WhN+bbzkl5KmKm8CNpKXD6iM4P+J/wF1u28
         Fqf2/Y0q+SVgSpqgHdHbBVuSVO9m8JCarybcDMCnCLvgAOIeMN2kZSPaInhQos5aglm2
         PB6rH8oyrS9pZC755IbuS4VI8je4HhweK+oQ5QQ7/03VwU6k9jrr4viRMAtjg2Z0WY2J
         w3KA==
X-Forwarded-Encrypted: i=1; AJvYcCXjOpDA55cES72imahYN06EWU5Uv5Vjpw0PowFPbIhSAQGaRc727hTl9u+zxREp2J9IX29ak7vt28FyDv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDOy4AAh0dxXM/MAjqmp5nZwA2OM6bQzQDsXC4tVfu4oNb8Fwv
	lpOr5pDK2s9+918oPqaTflgVprSXAOsdorDPEB1H/72uM1FIm6AyvcecYM4h4f3EaQskOZ5BaTu
	O34+gxpvGXj2OwNeQmnOkUHUlkZcOCMatqueF780UUzd99PV7xulUvxj5Xypjih/75zg=
X-Gm-Gg: ASbGncsm/Mkl/HhqneL1sbcI1OnGSKA9SwNpHDzLswv+vu1FczLgAc5ycL7Idz4wMUv
	B+0EeM2qACciWVt5BRkcmI3wlGgmEYrkpZnttE9OwKSzYfyoHPHB2TwxJDNARm2rsLAL9Tq9R7P
	7NUFpUO51ZDPEBsu+BSgD88ARVbnU+IOl0lw6OyCCffx72u+W4D/3rDAk6hrd/GOEGOYvaDRwJ7
	Hh+rMXEeZyOZudheGPi4QrVbJJIT8D7fnwNtpOwHRBc2ulF99CYTSgQE4UXY6H8l+XgAcwtDS4G
	I2XlipIY0gtqirXAU+RMJ4ciUVrgm4ClBhwmKrUgwwGY1L3EFlT9w8GYd3pWV8n8TzxbtE8nCvX
	bqXF/zwOW+hyGvkHPPzmdWwkaQeNMwG8ONC/+VEijY7uIowhoPwRDx2UrmiPmk41I9fPBgrYUCw
	==
X-Received: by 2002:a17:902:e891:b0:295:4d50:aab6 with SMTP id d9443c01a7336-2962ad1ef3cmr74204145ad.18.1762399859488;
        Wed, 05 Nov 2025 19:30:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa9wqU0TEXAeU7IUAuOLwc/rJpAYfELsDgUBzHCnlItiBEGyzp64/a6VsoXvnuBLzhXYS++Q==
X-Received: by 2002:a17:902:e891:b0:295:4d50:aab6 with SMTP id d9443c01a7336-2962ad1ef3cmr74203685ad.18.1762399858916;
        Wed, 05 Nov 2025 19:30:58 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0060sm10361925ad.108.2025.11.05.19.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 19:30:58 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Thu, 06 Nov 2025 11:30:37 +0800
Subject: [PATCH v4 5/6] media: qcom: iris: Add flip support for encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-iris_encoder_enhancements-v4-5-5d6cff963f1b@oss.qualcomm.com>
References: <20251106-iris_encoder_enhancements-v4-0-5d6cff963f1b@oss.qualcomm.com>
In-Reply-To: <20251106-iris_encoder_enhancements-v4-0-5d6cff963f1b@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wangao Wang <wangao.wang@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762399836; l=5542;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=fJoAPc83wR1LgHrDfr408IQ1A/7ZxGfeFvE/M2rCaic=;
 b=T0GaOjzE+e+efKO46QAWj0k4JjnTIovXMlV2adDExK0q8K/lsFCkWy7s7fyB4syllQBISVwyd
 BNwjxE4UVpMD6tTD+4YDr/ONSzzQVlJFMevJjtod9siLmuCxvvpIH0B
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAyNiBTYWx0ZWRfX2/iTXcX6LtOU
 SYUK6op2NrH9WQkcyKRjyoDhmFZIsPiEqKrSUXqrVq6kd0CosSUazpQnLra52iemMyPa2rjyphh
 UWWXxRxRiHiDlynzleIs0luAW/IxCo/9yr4q4kut1IvQX5zsr3mWc+bkb15Fa5eDe0tMyvfdOk/
 lPujw12Cyx/tC+7ZBx/JlgGkIUWoWKuYxpt9T2hvqaJ/MjcpO0BO3uma1R3mll/eHICN0OMaOuY
 cTQBnv0x0G0p/pvpw8g759egAqeW4IOWG6mJvZ+U2Pd0VEtKBFR4sBmiYJh1iMD/jaJo0gOEDcT
 lta0JcjfDmv3mHSvELEiPLEPfNcY7UIxgfILFKS26o6+oOaHPBfRgMckPTj+JdQnzlfN/Cxz3br
 k7BjGyS/yLD0vA9O3AtjzWrZRZdroQ==
X-Authority-Analysis: v=2.4 cv=LoCfC3dc c=1 sm=1 tr=0 ts=690c1674 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=uxdc-9wEpbf47THqrzgA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2O0PVpz5GW3pbIyiml175QRPpgdtYIx4
X-Proofpoint-ORIG-GUID: 2O0PVpz5GW3pbIyiml175QRPpgdtYIx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060026

Add support for V4L2_CID_HFLIP and V4L2_CID_VFLIP controls in encoder.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_ctrls.c      | 27 ++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_ctrls.h      |  1 +
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  8 +++++++
 .../platform/qcom/iris/iris_platform_common.h      |  2 ++
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 22 ++++++++++++++++++
 5 files changed, 60 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
index 00949c207ddb0203e51df359214bf23c3d8265d0..8f74c12f2f41f23d75424819c707aff61ea61b33 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
@@ -100,6 +100,10 @@ static enum platform_inst_fw_cap_type iris_get_cap_id(u32 id)
 		return B_FRAME_QP_HEVC;
 	case V4L2_CID_ROTATE:
 		return ROTATION;
+	case V4L2_CID_HFLIP:
+		return HFLIP;
+	case V4L2_CID_VFLIP:
+		return VFLIP;
 	default:
 		return INST_FW_CAP_MAX;
 	}
@@ -189,6 +193,10 @@ static u32 iris_get_v4l2_id(enum platform_inst_fw_cap_type cap_id)
 		return V4L2_CID_MPEG_VIDEO_HEVC_B_FRAME_QP;
 	case ROTATION:
 		return V4L2_CID_ROTATE;
+	case HFLIP:
+		return V4L2_CID_HFLIP;
+	case VFLIP:
+		return V4L2_CID_VFLIP;
 	default:
 		return 0;
 	}
@@ -917,6 +925,25 @@ int iris_set_rotation(struct iris_inst *inst, enum platform_inst_fw_cap_type cap
 					     &hfi_val, sizeof(u32));
 }
 
+int iris_set_flip(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id)
+{
+	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
+	u32 hfi_id = inst->fw_caps[cap_id].hfi_id;
+	u32 hfi_val = HFI_DISABLE_FLIP;
+
+	if (inst->fw_caps[HFLIP].value)
+		hfi_val |= HFI_HORIZONTAL_FLIP;
+
+	if (inst->fw_caps[VFLIP].value)
+		hfi_val |= HFI_VERTICAL_FLIP;
+
+	return hfi_ops->session_set_property(inst, hfi_id,
+					     HFI_HOST_FLAGS_NONE,
+					     iris_get_port_info(inst, cap_id),
+					     HFI_PAYLOAD_U32_ENUM,
+					     &hfi_val, sizeof(u32));
+}
+
 int iris_set_properties(struct iris_inst *inst, u32 plane)
 {
 	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.h b/drivers/media/platform/qcom/iris/iris_ctrls.h
index 3ea0a00c7587a516f19bb7307a0eb9a60c856ab0..355a592049f3fcc715a1b9df44b4d1398b052653 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.h
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.h
@@ -33,6 +33,7 @@ int iris_set_max_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_i
 int iris_set_frame_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
 int iris_set_qp_range(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
 int iris_set_rotation(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
+int iris_set_flip(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
 int iris_set_properties(struct iris_inst *inst, u32 plane);
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
index 4edcce7faf5e2f74bfecfdbf574391d5b1c9cca5..0f92468dca91cbb2ca9b451ebce255180066b3a4 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
@@ -92,6 +92,14 @@ enum hfi_rotation {
 };
 
 #define HFI_PROP_ROTATION			0x0300014b
+
+enum hfi_flip {
+	HFI_DISABLE_FLIP    = 0x00000000,
+	HFI_HORIZONTAL_FLIP = 0x00000001,
+	HFI_VERTICAL_FLIP   = 0x00000002,
+};
+
+#define HFI_PROP_FLIP				0x0300014c
 #define HFI_PROP_SIGNAL_COLOR_INFO		0x03000155
 #define HFI_PROP_PICTURE_TYPE			0x03000162
 #define HFI_PROP_DEC_DEFAULT_HEADER		0x03000168
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 9a4232b1c64eea6ce909e1e311769dd958b84c6e..284d6bde6d6bcdf70016646d1c92e6ae7f067efc 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -141,6 +141,8 @@ enum platform_inst_fw_cap_type {
 	B_FRAME_QP_H264,
 	B_FRAME_QP_HEVC,
 	ROTATION,
+	HFLIP,
+	VFLIP,
 	INST_FW_CAP_MAX,
 };
 
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index c1f83e179d441c45df8d6487dc87e137e482fb63..e74bdd00a4bb2f457ec9352e0acaebc820dae235 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -598,6 +598,28 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
 		.flags = CAP_FLAG_OUTPUT_PORT,
 		.set = iris_set_rotation,
 	},
+	{
+		.cap_id = HFLIP,
+		.min = 0,
+		.max = 1,
+		.step_or_mask = 1,
+		.value = 0,
+		.hfi_id = HFI_PROP_FLIP,
+		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+			CAP_FLAG_DYNAMIC_ALLOWED,
+		.set = iris_set_flip,
+	},
+	{
+		.cap_id = VFLIP,
+		.min = 0,
+		.max = 1,
+		.step_or_mask = 1,
+		.value = 0,
+		.hfi_id = HFI_PROP_FLIP,
+		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_INPUT_PORT |
+			CAP_FLAG_DYNAMIC_ALLOWED,
+		.set = iris_set_flip,
+	},
 };
 
 static struct platform_inst_caps platform_inst_cap_sm8550 = {

-- 
2.43.0


