Return-Path: <linux-kernel+bounces-884273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F39B5C2FC94
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75AC84F4513
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5F5313295;
	Tue,  4 Nov 2025 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QkEPgSTC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C2UOVtVJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05083128D8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762243940; cv=none; b=Tkqk91NMmqVKp+zq5W3eQnCNMW+CIC2Yr/BGhqeSyUaZY484P08R6J/ZeZCqZeMLvKFMJ9g+dS1JlUf2396JnOJJ1NsDHO5NqD22dWoE6hGBzYcZJtJwmT5OeK8NFodfiXXujiFhwuv5wiPgRRydVVFsxyXnhJ+WnjI8IrvfSTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762243940; c=relaxed/simple;
	bh=fJoAPc83wR1LgHrDfr408IQ1A/7ZxGfeFvE/M2rCaic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uD5qLVrN1adELaO9/AcIkQfRSL7ee6H7fxsk3YSdOPCH3WBC3Ks7TPKLDpOGIAl2V/ABQYshZjaxomuHpE5rFNrh+G//i3pkyagp8W6nbPoFisLAVP/i7Elk8dKGiVKhJd3jeHaiFkstlVS7dFSFBHpVoGX6+OAlYntrGfzuG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QkEPgSTC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C2UOVtVJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A42fwSL3682791
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 08:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ovGBUB15DEWLk0DVrQSRCkCYrN6zQfyDDY5aUsiUaHo=; b=QkEPgSTCiDSwM2az
	Ujb/thaUTaAwKqohEi0r2hWpU24E/K+FCqcV5IjCZLybTQlizkFjQVU0xlU2ucnw
	9J6dpa5gUmlmPg8S04g1xI+AToT61YUfcgn2KyDe03Cjb+6o5Hn82DKyV/bAaeCG
	qrdxZEamZykavbxqpvaXVNPBe/Pduc5zb8Ry60FM3IxPwhA0/OBKZueGFEmCggaH
	xwn6kg83Sf/SG+9FNCs5K6Hi6RZSbeKJglejU20zzJO7ClTvYC7OnZlxoEApv8Pd
	TBF3iqVjZl6ZLeK0Lwg/W0c4mziVi60DUoND474SFvGz83W0+H2t84Qirzdvdc9q
	GlPnAw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6xjqtn0d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 08:12:17 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340fb6acc39so3184646a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 00:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762243936; x=1762848736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovGBUB15DEWLk0DVrQSRCkCYrN6zQfyDDY5aUsiUaHo=;
        b=C2UOVtVJByiYuhtGesiJQPYyrW2waYodzxBgmQAAW+SisUJMsQWmz+qho33CN1Cep/
         +7iNhmnI35XbBUCTOIyHGWbfm4Fmmwbdxwoe1ShRpD8b4h4fGD9X0RkWuDNmyvpC6XvZ
         /vu75EDFSHsR9F13xYHZ2h0TVRU7vrxWSFkkWPEkEAwv9rAZ/jRMZx9bXUe++bAvW/vq
         bXETcu7H6g/hxd84IIeKxJqKyfXF/f7g02hSj3nCFlNYq5DD0lZAQll7kgoFkyy5F22u
         JCvTfo9QAI3KPoHpGsoZeeCvuW9NbaXnAHj3zC3eRDz5JxvFoj4O8BM20kPTAul5cSsf
         HpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762243936; x=1762848736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovGBUB15DEWLk0DVrQSRCkCYrN6zQfyDDY5aUsiUaHo=;
        b=gY1M0KVVQjq785tydeWQ++DdtExh4N7PB1HPztEJksGKfHFqqqL9hD48R4xwMxqOQh
         JqeFN2+mfyPFTNdRTjOaGY2OTBcjA4qNDEB9BWBnLLHHMlYEFj/m7hSP08Rvl8aFaC+r
         O+A4rJ2iiVF1mvtkrY5xTVkf2JtCnp1m5FxIL9SoSJBGE0+Q7zfCpPCZ499DHXWNmdcT
         BXJKkPfyO2HLvekL8bILrCTfCWnlxD66lEyS49vMZekSfd7SFfFT8LhNQ96HGuj1+3zJ
         QqBeBNOH9xH/jm75KxpG443R5g6TEahX08Y+z5mgyyENyCeqj9Z35V22Ct0unLGVJH9A
         vJzg==
X-Forwarded-Encrypted: i=1; AJvYcCU3bc+IMmQxKt7Nz3Lbz3L5gPlWQDo8Pkzib1pSHYKYc/Dpu5uRIwk0DAWMlxKC6C5r0L8JjZqhyAIun6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8fhqbSWqpri+sbogUAiA6UocvXO+IG6GOARRFjYOqDYCM4bv
	4KfFlZ/rl3SkHTP37R96bSjb4HGMh6hyqUPhK09Wat1JjOkhSmHyZs9oAwlXjLVvx8slTF/KCsa
	MKp3IiHXXO/t3QB1nDtjBnMsZ3S9oiBjocLW8e3Hz9oPFrbgKm/zswvHSAceYasHZ8uA=
X-Gm-Gg: ASbGnctMdMOM8pBzZU461SxLMzx7vPDuoR2tvNGVHavrS0LffomunW8DiKEiPE/b/TR
	EzXlcj4+VZws8/IYKLqQm6qGWshowVAxpcShNQ5uG/CNCnN+d5qy0S+J/hGdFR9eGzNW/OYYYUV
	mVQbVdh7awaqUeks7/ArCu3A3E2gBPz13IDXHXXpm3Fi835I6ngMC5NuZyZOnAKDGnuXzxTE3/q
	i1sNYL89Jl3HLsfwH7Wge0Bk/Mw3yNgdbJQGkypJRlP3DxF5udFOdEdaWUGMJvsOA9T4K4sikLX
	DP0G9BSdOFY4KNRGOL3k33e6vjJiUjUqGKpf4Qoj5a7cJInPbuI6BkJdDzygvnKJDZLym7cpLIM
	LkY5VXNSRPkGRy/WdtjBUTels/Bkpc5pUlmkQUOr+5AUEGrZU1np2yNIztVP5O9UYFQYM42Vctw
	==
X-Received: by 2002:a17:90b:2b4d:b0:340:ec8f:82d8 with SMTP id 98e67ed59e1d1-340ec8f87fcmr10541869a91.12.1762243936479;
        Tue, 04 Nov 2025 00:12:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/AabkJTPh5krRwgPsv6Ln4KTaXbwzylXrpyEKBYfRobrKqMA5DOKC9cLklniqODSS0ep+Tg==
X-Received: by 2002:a17:90b:2b4d:b0:340:ec8f:82d8 with SMTP id 98e67ed59e1d1-340ec8f87fcmr10541832a91.12.1762243935969;
        Tue, 04 Nov 2025 00:12:15 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415a1c2f12sm3601755a91.5.2025.11.04.00.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:12:15 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Tue, 04 Nov 2025 16:11:48 +0800
Subject: [PATCH v3 4/5] media: qcom: iris: Add flip support for encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-iris_encoder_enhancements-v3-4-63b0c431b4d0@oss.qualcomm.com>
References: <20251104-iris_encoder_enhancements-v3-0-63b0c431b4d0@oss.qualcomm.com>
In-Reply-To: <20251104-iris_encoder_enhancements-v3-0-63b0c431b4d0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762243916; l=5542;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=fJoAPc83wR1LgHrDfr408IQ1A/7ZxGfeFvE/M2rCaic=;
 b=XcD4aIGY4/vv3mqzLanPyBWhYQruDFibo9YL1B+7hEEMht/D1FljFmQNW7rVE8UYjrfKUHcHk
 kzAv1Jc88JBAQ6sv8XVJIzelQQoSdBoRBX+5Pde5rDYk3STwbvCC3Lv
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-GUID: 3sMEzlG0enVkcvhxkXxOgyNkRGH1qwAZ
X-Proofpoint-ORIG-GUID: 3sMEzlG0enVkcvhxkXxOgyNkRGH1qwAZ
X-Authority-Analysis: v=2.4 cv=criWUl4i c=1 sm=1 tr=0 ts=6909b561 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=uxdc-9wEpbf47THqrzgA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA2NiBTYWx0ZWRfX0uhZRhF/Khsw
 F8zxMlUrWhW5BVEFcvFpFfFy29WG7EjaUtenlMw1pKadsixv+QtIV44L07BGcu8m30/FUgGbcwf
 To5khkad7Pu//+1p15UbS2XhVON4rUUdxpstgd7oyBf8b9l+uDafh7WZlImPiFNw9JL8nx90MgY
 rw8m3p9gbijU/zz+3Xwue+ed1Cuw1X4bslzsnzt+AFo8hOYVhUvioOUoDMLVipdrQgH9Mjme7FB
 cn5tVgvnXbhFQ29u0p04n/V9RXGjXnM5vO+zCpD73K2Vp6sfCf3bV+dFhTE9szlnJ6p45cMbLxk
 EV+0SVJnKjF3ppFD2IvPRTt9bKzTIDwIVwJbkEHgmaqK5D1IJZt0GsIjQdXgN1whzJMQZ8JBJk1
 LFzY3dKiQPkd4YdsySOeI1ogOSiwyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040066

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


