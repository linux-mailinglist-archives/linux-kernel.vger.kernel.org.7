Return-Path: <linux-kernel+bounces-854191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62373BDDCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EF858046E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D5931B836;
	Wed, 15 Oct 2025 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nt0mjUtn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D302A31B131
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760520655; cv=none; b=HhMp++O2diW1JRxCKe/Tet0ySNpGdWnbfum3LY6/btQZtDKvcogRrd2Z7sUrO/yFXZA+Ir4MG4Q9HFC6FeZZw2qKp/pCjSP0a7yVCTxlRbBN5D1G+0rkoigfuU69IXQVOEP/lXteNtjBRMr/NU6ozBkVHWMP9Ykvof2ASXVr0Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760520655; c=relaxed/simple;
	bh=h+h0uhFYdYPSZC3lBI/p+2+7lEWXQZp6UALMpWO02/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PGi2Lc6rsRFDvgGhNAvR7Ru9vFn7eu1cpaZZNpBrTTAZDj34iU1lZypc62sCwNZ78DekbL5QD7KAu8VWG43yPfv6fhfNSMlF3BlezDR3zIahwm/Mfaoy6lmQWK1fZMuNQ/V1WAtbH+O/daCpEZoZ/7i8lDoWnBflaaJgPBMdrZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nt0mjUtn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sSiA016037
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bibjzZl8x7/
	oWBl+3wnQ7RPKahQftRencAh0lWK1z9E=; b=nt0mjUtn5ULooqWj7nYNFEXeqqP
	ZPN2GkiwFCG65uW88NzUdqS0nQg7zU8++EHzc6p3jO0S8gn9wvVNInPWEUTGsPq5
	rXvwLFve9lU59XBecfBDgtulQ455zm+P5f7BJhqJOZ5ZFuBKjh7tLYS19hR+Yun5
	EieIpG8pkHixc4Hg4DIrf8Gr/99dgDWq2i/daqyXsAkQwAmoYdjuBVXnl8GRLwnr
	KnYBjQDjk8JIs0mkkQaa586eOSxglUP0WMzaSJstvXoLjKOUyLQJb7HwCzE1dakP
	7X7y4/B8dRM14SmdmvNz7thEpMwwATfPWoP++NrjO/4D74GpK8OA08VWlbA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5m01y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:30:52 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b62f9247dd1so9913687a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760520651; x=1761125451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bibjzZl8x7/oWBl+3wnQ7RPKahQftRencAh0lWK1z9E=;
        b=KM3GJuzknT9GewpX/QMIJOVhFG3VrGL5w1WO4ozmQpMlEC8Numlqdba+/vubQ0YuFF
         b7h3WnIrnDrzbiwtijy2GYchF0/JSUGBfNqfn3187GljpFaow6qp9tw5g++R1lJgPFP5
         XpjwBqNZA1dZCTp63x7OX3u74udFF3Dru7LTcCwOgS1VVQWBsef3r3wHAoKE/vBxIYJ5
         a6Sv9DOBzt+YsLqLibh8AM6QpZ1KLC4O5Dalrrqc8yJJSwfWfaG2YZuwiixCHSY78xnu
         sPUfjRcG9QBdPeO25cG9ZgQ3Dtv5IzSMzXXl5nsCPZhUSB38uNo8r78Ya7wOWT2DWTZY
         HDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXde5S+nww2OBw2GEzgSzXiDOE+1DBxfKA2APD0h1yXSfdArtUJ078eb27+xoc97NKX4XgiQsyeSauuabY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3uZV5J2g/XEa6eHu/XSHy125YfeJvT0vGRi1yTPZocPmnUQwb
	RIQ0ouiX2gAzaavd3SXpp+geQhvc/7WbK+EUvwNhml4HE4bK0/+HnjyVbRavPFNNTF7ClAlImCs
	ZsFie8qvbNCgpkuYAsdVQSW3mO+1c1qsr5RnD5PkdJxHfAqfRxdVmQvws135Y+rB7x7I=
X-Gm-Gg: ASbGncsrco//VPyXtKHpeqQLLLw+tr9EuPGYuqqNHbvj4UAAhshRpnUgoZlo5KApkkN
	XIvCrtPkiX28AVLAS0lYnsGg8ApiGB/bk8X2A2n1Nw3efyHaqZswotnGx5RX1b0R25yrz5eVy/o
	TavBNmQxb/kxJWLUbUJeUPYRNGpWduUE5L+sOahbur8dW7xLs2XwDTRcTpSbOXYGtf5tnGAPRoG
	k+DPDxoa6OhIpChpzLwNjpaU1RUhZ1Ogr60fLleE1hymOexVAKdVpri7vCien7qS06PgY+T211L
	oD/U1dEYONMk8aAaSYyCh1znhoOIIFfjDkS7pRm3tZqcACqC/QCl7AIE6xlUPldOGcJa4CnC2Hy
	542zM+oeMk5FTwYqiLqQnk0lYJjafgaT2T1w=
X-Received: by 2002:a05:6a21:9990:b0:250:1407:50a1 with SMTP id adf61e73a8af0-32da812f4d4mr39680808637.24.1760520651183;
        Wed, 15 Oct 2025 02:30:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq10chiIhKhq19WqTJMjtj0EfFMp6QP8Ip196WmNxZwsrrNbna+jzhT7vQd5+R5mkrFfBirA==
X-Received: by 2002:a05:6a21:9990:b0:250:1407:50a1 with SMTP id adf61e73a8af0-32da812f4d4mr39680769637.24.1760520650642;
        Wed, 15 Oct 2025 02:30:50 -0700 (PDT)
Received: from WANGAOW-LAB01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09aa20sm17946745b3a.39.2025.10.15.02.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 02:30:50 -0700 (PDT)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
To: vikash.garodia@oss.qualcomm.com, dikshita.agarwal@oss.qualcomm.com,
        abhinav.kumar@linux.dev, bod@kernel.org, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com, Wangao Wang <wangao.wang@oss.qualcomm.com>
Subject: [PATCH v1 3/4] media: qcom: iris: Add flip support for encoder
Date: Wed, 15 Oct 2025 17:27:07 +0800
Message-ID: <20251015092708.3703-4-wangao.wang@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015092708.3703-1-wangao.wang@oss.qualcomm.com>
References: <20251015092708.3703-1-wangao.wang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: duvAC0ytGiie6MnDfZXg3qGFA8tiCBj1
X-Proofpoint-ORIG-GUID: duvAC0ytGiie6MnDfZXg3qGFA8tiCBj1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX2xW8zFLqy/2W
 bS8AdQRcgeE0RxKFzbKjLgYuv7qIDcrHXpZbskkADH8B1zGDgsv14ICV/SmOiphbnHKkMUkjqZc
 ReLO0d/MM+czsICeyDnyBU49xoScApCrH4jYyY3tfPvAmnDDwsl0OvAK4s+3/F8NX99Smv+oXV1
 Bk5Ynij7EkltPnvFOIDLVAkw3Y32eU71bQEVkKV1NTXPwYAUUymv29nq7Ag/N6FirGNdm0vI/RF
 iCwurZCRfK/LJ67ZZaMLG0m29wLe2+8AkLlAyZ9ISVHczZR5VTYntyNbeLb6if1cNRPj49jiEFF
 z5UE7ebpCyuqPrX5VwRoF4BBcBPG+7Mm4456pP6051LAS3Eu4IqOKeSecQcLhOySpvWRMSGh9mJ
 PFFDD7ThWAGfWQXdYmj+KrRZ3/TuOw==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68ef69cc cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=HX03lubpilNWZfNa7RoA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

Add support for V4L2_CID_HFLIP and V4L2_CID_VFLIP controls in encoder.

Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_ctrls.c | 27 +++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_ctrls.h |  1 +
 .../qcom/iris/iris_hfi_gen2_command.c         |  2 +-
 .../qcom/iris/iris_hfi_gen2_defines.h         |  8 ++++++
 .../platform/qcom/iris/iris_platform_common.h |  2 ++
 .../platform/qcom/iris/iris_platform_gen2.c   | 22 +++++++++++++++
 6 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_ctrls.c b/drivers/media/platform/qcom/iris/iris_ctrls.c
index 00949c207ddb..8f74c12f2f41 100644
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
index 3ea0a00c7587..355a592049f3 100644
--- a/drivers/media/platform/qcom/iris/iris_ctrls.h
+++ b/drivers/media/platform/qcom/iris/iris_ctrls.h
@@ -33,6 +33,7 @@ int iris_set_max_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_i
 int iris_set_frame_qp(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
 int iris_set_qp_range(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
 int iris_set_rotation(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
+int iris_set_flip(struct iris_inst *inst, enum platform_inst_fw_cap_type cap_id);
 int iris_set_properties(struct iris_inst *inst, u32 plane);
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 15db4f9e85ff..1f2a5b4d3977 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -245,7 +245,7 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
 		right_offset = (ALIGN(inst->enc_raw_width, codec_align) - inst->enc_raw_width);
 		left_offset = inst->crop.left;
 		top_offset = inst->crop.top;
-		if (inst->fw_caps[ROTATION].value) {
+		if (inst->fw_caps[ROTATION].value || inst->fw_caps[VFLIP].value) {
 			bottom_offset = 0;
 			right_offset = 0;
 		}
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
index 4edcce7faf5e..0f92468dca91 100644
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
index 9a4232b1c64e..284d6bde6d6b 100644
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
index c2cba30be83d..5d76f638020f 100644
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


