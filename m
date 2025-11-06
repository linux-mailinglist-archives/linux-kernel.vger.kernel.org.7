Return-Path: <linux-kernel+bounces-887743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6047BC38FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2653A3AA7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E5219CCFC;
	Thu,  6 Nov 2025 03:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lE15MsFJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GC4lwx8Z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F72D9499
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399868; cv=none; b=MQe0livvc39fIMxlFmF4mUtNYg+oapKcwk0WWNRK0FY96YxILRumrtB1GrtEKgdCA5CS1eR8mT/pb+hruGRyfMZ6r9gFrOGdblHLUvB+J2aQ2v2jrD7ZNIEd3JWLtzjKfeS5N8cXjfXSqnINKzbQFK8fqhlLZyGpj2f1dopEP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399868; c=relaxed/simple;
	bh=JQ5iyKLsbTvW1G+rebQp49wNfxcQrPn+UClBYzR7ixg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLfY61ntf0OLbUdKWuDeN/KuCHah5+4zvJnifJXCBFmfy6135XB0MBZDPWFJTHVqd91MO0skdKKmbcEk4yBgip6nqvEVshOrq3pvBc4p380O2oZCaAw52DzD8C6GaJ3ZapooxACugW1Syi9Zf1px7mIIfsB2BgkADSSd5d7Nrl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lE15MsFJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GC4lwx8Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5N5RmH2148087
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 03:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ugBW9Cv+1k8WLRXW2Hz0UY8b2KE1oQhBmaVaCghLSSQ=; b=lE15MsFJH0de2+tr
	dozC6uE9hzSyTIw17JCuh67gDjrzYK0JTxdYak7Haa56x5QDJ8a+q5Gyf09GEjvm
	LH7PrG26vUyJbp1jwrDGszkMlXSbg8G84a4EZ18lhf2t/V8HheJ43gV2N6JJuRB/
	RWg7W6Ugvnr24uxQ7HOmYG0MUQ8WCp4d4bc1TU61InaX3MSitt1p1tI3vxGQHBV+
	+UfM+RiQZTGavn/xjhK3Dsd8K2klWLFAzglVcOL92ytjR3O0WLOVdAuc8tFlMsjy
	hXSqhMUhlXU4oTh1jy5ADQC5BbCl7AFWYwl84tFcaWlZaRa3UdZVCuVhBMlfci9L
	bOoXBA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8fxvrmaf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:31:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b522037281bso331038a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 19:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762399863; x=1763004663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugBW9Cv+1k8WLRXW2Hz0UY8b2KE1oQhBmaVaCghLSSQ=;
        b=GC4lwx8ZcDTCYNk4INMLfJYHlzXel37W/sNH82QxGalHnoCCrOpmTKhenllEwrXd1g
         rmUr2OSVjmmOZMFs65GtsTroyNTR7lAT01dDxdfI6pTcp/BjnQzHlHM5oMpkVkMJyoR9
         +vXva9N5UAaIpNhlstbLFMwtYohMFXXxnnna/dIFhANXDrTRCWis2ddRYi625RVjcocJ
         33ya2D3iSQS6AEBd+SCbF+3PvG7yITB0QQu4bxjCmLnOKPO96SYrla4UE/CSGQkioWRX
         rKHVFBQ30VT8z3NFg1RzGfYpVcYPi6ZCOgk/MyOfmoG0wxP8LCRzmkpVwMDQh/HHJllq
         +m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762399863; x=1763004663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugBW9Cv+1k8WLRXW2Hz0UY8b2KE1oQhBmaVaCghLSSQ=;
        b=mK+jIzxbUGh7Bc6VR7yJm6V7Sdam+9Klbev/opYGbWitGZ5+WYHcAAq5Cju4deYLaB
         q23bpYHGBMvNdWtY+3jI5+kS3YCR5wOC7P/2RZf0q0Nne21AYQzeg435GlilcdpU3dBT
         yi5mZMq7NkbmpRKt8JgV2dQQ2XHp0gioUQZ62kjULWweUL9y8DyI1byg6cCBYfn+gZqK
         YJwy8vbIcWy1ESVJrg5koCV1N4IJr2fe97vGDoogOa4v/r2M3e5BrkeIr9jEf42BnJYM
         h4i40WTPh2PuvwyHFNj9KTJfbHKe256DE5w0wSCYBekdVfM17q5PBmGdgDvIi7LLY9Gr
         yUhw==
X-Forwarded-Encrypted: i=1; AJvYcCW36MC/Ceax25/RmYJMK0BQUeGKYS3p3n5pU/x3q744fBF8isPwxAucq+k1KW3ctzrUsqE0Zhdv1GyteAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHUrsyaAnOIIFlX/zOHDlTvi1DdoBFTvcFMrPY1asxkkvAc3Qy
	zgO3W2rWowmjCBDsoiWuFxHaKIsnYSjchtTzSVlLVfbFKwVNjHnelHTa/khxvp+F5/aerOToFdH
	+mh2/NPmXRKE1RkBqRR/GEcQFLmePvB+mo6SmZq9LvHd4gjw/+NKU9UBsDUwCzb1NtWk=
X-Gm-Gg: ASbGncs3xWWczYUaZXucqu2CdHuqihQQMMcXxUTBTevow6nxwYWLMLfL0mQZTYmUD86
	jDlEKf8+1gJh1Mf46e950ek0p88HBja9px14KOVFl49LW9ewDI5p+c8NE0hj3hvXKMvNR+dn4d6
	JUmhWSvvtEixARjYFQAANOXaxeNEfJb7DhapXANLyi3V4MlDW9IrptLvVfzWg30leoqZBcvaVDS
	KzqeP4U2Up61U7/plz7t3mDaL5wC93RnfEhOMPeRVo/o+S4kkpx29cHDH7QnJjU12HN8StTux7o
	priUAvHBDTKr1bfmjxKs+ByZfnBs3lzgFjMxznyjSuOKOcBQZ4JRhJhKFNG4D20dCLyR72Vfsih
	lsDsUYlNf7q08UupJfsqZGWcJ7jd/g8ttZw2QS8tHGFw3DwYvi3w3HzNyjHsg6ZCCU9VzXNvTUA
	==
X-Received: by 2002:a17:903:2286:b0:295:54cb:16ac with SMTP id d9443c01a7336-2962ad1bc4dmr75095485ad.18.1762399863482;
        Wed, 05 Nov 2025 19:31:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0ANBdoE+euT8S2x1s+JWx4g+Ehlkq6HJ9gp+SG6qkEmCDxZ8JU5K3mDejLGnk1hCVFvAxhQ==
X-Received: by 2002:a17:903:2286:b0:295:54cb:16ac with SMTP id d9443c01a7336-2962ad1bc4dmr75094935ad.18.1762399862951;
        Wed, 05 Nov 2025 19:31:02 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0060sm10361925ad.108.2025.11.05.19.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 19:31:02 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Thu, 06 Nov 2025 11:30:38 +0800
Subject: [PATCH v4 6/6] media: qcom: iris: Add intra refresh support for
 encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-iris_encoder_enhancements-v4-6-5d6cff963f1b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762399836; l=6329;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=JQ5iyKLsbTvW1G+rebQp49wNfxcQrPn+UClBYzR7ixg=;
 b=7vwksZhemnsCeknghGDmXoxZn/Ky4K1aWqGHAsIPT1HV2CAm7LDG6lS2b7v3UpdGpQBWO/JyH
 WDCodetoDFkBALBJUkXIsJInQsN/gbqb5VLD52X0i3iWr8lmSwzG21h
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAyNiBTYWx0ZWRfX2dfFzdDeHOed
 mXsNLaAQuhg5F3WNO3bchPtiEe6uSFmEEDs4PSwikhpbbcALpkYtFYCOh/ykcjvJpnuOvcWaIoD
 tO6U1vd8RM7AyUCSQp2XJL2dgChxfHYrDUZXEaTS2dDcnzKKh3APBzjerkVWMNBkwm6ct/sZAVs
 3BsMtVlZgKdwY6ZSEforXawZvX0qW2LbLS7rRKdM4/fMzWb1DHWRPnNzt0qyhT9fRY6i0zY+LkN
 hC7h1lm7NuNFxQLbAFXLqyUB1FgrZMkCAKUJrpLEkaOBtJ2T9KiNHkSoVNlL+90PQic4TNtg2NZ
 wEY+OCpg6vaDpWuinIXBK9miwHWVuCzWEvBX1Z7EN2Cv1f1T0PpnoIgwofoB2A7fIwzgQkRt7y3
 S3seO8osDU6kHp5M7utMOghRNxeoyg==
X-Proofpoint-ORIG-GUID: iLoDrxwRIt9BkHC8ovWURNDJaEMzYDES
X-Authority-Analysis: v=2.4 cv=OZSVzxTY c=1 sm=1 tr=0 ts=690c1679 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=-vM60OG-bLC5KXgFrusA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: iLoDrxwRIt9BkHC8ovWURNDJaEMzYDES
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060026

Add support for V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD and
V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE controls.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_ctrls.c      | 33 ++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_ctrls.h      |  1 +
 .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  2 ++
 .../platform/qcom/iris/iris_platform_common.h      |  2 ++
 .../media/platform/qcom/iris/iris_platform_gen2.c  | 19 +++++++++++++
 5 files changed, 57 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
index 8f74c12f2f41f23d75424819c707aff61ea61b33..14891569247318aaa7b2009b737f077d1cb45095 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.c
@@ -104,6 +104,10 @@ static enum platform_inst_fw_cap_type iris_get_cap_id(u32 id)
 		return HFLIP;
 	case V4L2_CID_VFLIP:
 		return VFLIP;
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE:
+		return IR_TYPE;
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:
+		return IR_PERIOD;
 	default:
 		return INST_FW_CAP_MAX;
 	}
@@ -197,6 +201,10 @@ static u32 iris_get_v4l2_id(enum platform_inst_fw_cap_type cap_id)
 		return V4L2_CID_HFLIP;
 	case VFLIP:
 		return V4L2_CID_VFLIP;
+	case IR_TYPE:
+		return V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE;
+	case IR_PERIOD:
+		return V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD;
 	default:
 		return 0;
 	}
@@ -944,6 +952,31 @@ int iris_set_flip(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id)
 					     &hfi_val, sizeof(u32));
 }
 
+int iris_set_ir_period(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id)
+{
+	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
+	struct vb2_queue *q = v4l2_m2m_get_dst_vq(inst->m2m_ctx);
+	u32 ir_period = inst->fw_caps[cap_id].value;
+	u32 ir_type = 0;
+
+	if (inst->fw_caps[IR_TYPE].value ==
+			V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM) {
+		if (vb2_is_streaming(q))
+			return 0;
+		ir_type = HFI_PROP_IR_RANDOM_PERIOD;
+	} else if (inst->fw_caps[IR_TYPE].value ==
+			V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC) {
+		ir_type = HFI_PROP_IR_CYCLIC_PERIOD;
+	} else
+		return -EINVAL;
+
+	return hfi_ops->session_set_property(inst, ir_type,
+					     HFI_HOST_FLAGS_NONE,
+					     iris_get_port_info(inst, cap_id),
+					     HFI_PAYLOAD_U32,
+					     &ir_period, sizeof(u32));
+}
+
 int iris_set_properties(struct iris_inst *inst, u32 plane)
 {
 	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.h b/drivers/media/platform/qcom/iris/iris_ctrls.h
index 355a592049f3fcc715a1b9df44b4d1398b052653..9518803577bc39f5c1339a49878dd0c3e8f510ad 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.h
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.h
@@ -34,6 +34,7 @@ int iris_set_frame_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap
 int iris_set_qp_range(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
 int iris_set_rotation(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
 int iris_set_flip(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
+int iris_set_ir_period(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
 int iris_set_properties(struct iris_inst *inst, u32 plane);
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
index 0f92468dca91cbb2ca9b451ebce255180066b3a4..9e8fdddf2aef439e7f133c9bb2fafa6d95062b02 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
@@ -70,6 +70,7 @@ enum hfi_rate_control {
 #define HFI_PROP_QP_PACKED			0x0300012e
 #define HFI_PROP_MIN_QP_PACKED			0x0300012f
 #define HFI_PROP_MAX_QP_PACKED			0x03000130
+#define HFI_PROP_IR_RANDOM_PERIOD		0x03000131
 #define HFI_PROP_TOTAL_BITRATE			0x0300013b
 #define HFI_PROP_MAX_GOP_FRAMES			0x03000146
 #define HFI_PROP_MAX_B_FRAMES			0x03000147
@@ -108,6 +109,7 @@ enum hfi_flip {
 #define HFI_PROP_BUFFER_MARK			0x0300016c
 #define HFI_PROP_RAW_RESOLUTION		0x03000178
 #define HFI_PROP_TOTAL_PEAK_BITRATE		0x0300017C
+#define HFI_PROP_IR_CYCLIC_PERIOD		0x0300017E
 #define HFI_PROP_COMV_BUFFER_COUNT		0x03000193
 #define HFI_PROP_END				0x03FFFFFF
 
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 284d6bde6d6bcdf70016646d1c92e6ae7f067efc..30b98e769ad34c2b63dd63e7714bfeaa5b4f162c 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -143,6 +143,8 @@ enum platform_inst_fw_cap_type {
 	ROTATION,
 	HFLIP,
 	VFLIP,
+	IR_TYPE,
+	IR_PERIOD,
 	INST_FW_CAP_MAX,
 };
 
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index e74bdd00a4bb2f457ec9352e0acaebc820dae235..ce54aac766e2bf76fa2de64c884724ca63f05dcb 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -620,6 +620,25 @@ static struct platform_inst_fw_cap inst_fw_cap_sm8550_enc[] = {
 			CAP_FLAG_DYNAMIC_ALLOWED,
 		.set = iris_set_flip,
 	},
+	{
+		.cap_id = IR_TYPE,
+		.min = V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM,
+		.max = V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC,
+		.step_or_mask = BIT(V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM) |
+			BIT(V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC),
+		.value = V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM,
+		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
+	},
+	{
+		.cap_id = IR_PERIOD,
+		.min = 0,
+		.max = INT_MAX,
+		.step_or_mask = 1,
+		.value = 0,
+		.flags = CAP_FLAG_OUTPUT_PORT |
+			CAP_FLAG_DYNAMIC_ALLOWED,
+		.set = iris_set_ir_period,
+	},
 };
 
 static struct platform_inst_caps platform_inst_cap_sm8550 = {

-- 
2.43.0


