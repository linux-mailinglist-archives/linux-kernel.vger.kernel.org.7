Return-Path: <linux-kernel+bounces-892828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7B4C45EAD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96FB21891EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04A5309EE8;
	Mon, 10 Nov 2025 10:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cM0sHZ6C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MN9wB/6u"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94243081D6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770238; cv=none; b=k8/IgDnkOm5zsMfFuCE9dieGnl/AFwQ7HK6zzT17kjPCAJ19zth+En4tReO9COV8+zkFgYoUyBVhu6CHLi3JlKkBeAqyD7bSVsPpvF4cY0HocvHT7njDe1lE51ekNUCMBiOZ98+P86/7fkopAKjtkejuepvtNEUDPkRZA8sxxVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770238; c=relaxed/simple;
	bh=GFZAAmw/obI22EUCl/eL6/0v1x66MymdhqoUr6MgD5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BPn3MP8ljQZMTZy9THLCrOKLDZNT/Y+YOrM+AoGbdRGgQ8I5C8hJ7ASYf3o8LidGBNMzJKPKsSZMp/9SJtFXM1CVi4LzdbPk+/1G39HDecL5aArc+0rwzoCSsQGOsNnNfQaxd7HxR/e91IucNwS3JXPU7+njzxygbmpijlIAtaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cM0sHZ6C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MN9wB/6u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA7ha1A2861774
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U9WYMLCJ2+JzWgDs987QI8B2qg2h+hKqv2jLVTrRas0=; b=cM0sHZ6CnynMeTw3
	Xgi/fStaRryZbH7qGKoV2/aAGkqdVn59bRzmPQ2sCq1OjaUR12Irlc0C9lfwDnAB
	1eM9zxthq0fpwjMxKVqjq4yS8lLGXpYqz6I3YFVYlOrbKKb7alBu0SHrQ0PJfMxL
	KMZBf6Nfp/59wtp6XSgsR8/AReLzocEJDJdMhu1hejZ3g8tX6KC4IFWveqsff5hH
	6Qj/bstlj7N9HZy3d5lYrl1u5tmFR7QzORQikyaq6Ugx/1Y7YqgxCuP39a64NUAC
	s81kooKllBWHR7o5b9uz8aTjfzqZkAk7HBFKbAjP9teDM5qsB1AlUNdLy96cxawa
	HV5Htw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abbwe0jph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:23:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7b043e2790bso7364893b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762770235; x=1763375035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9WYMLCJ2+JzWgDs987QI8B2qg2h+hKqv2jLVTrRas0=;
        b=MN9wB/6uZqKGlulUAJKMoOnL4n2UMt7b9y5+vsY20Ls9ph3pWdCXUkphOqYLwkHpCD
         uoXEkmob217NAX9NlDUrimCkVJUWvafQkYcszjxTM75gXMPh4Jprsyre57SlTGPY93zJ
         Zv7pZw38uHINY0cc4/I39e0nPHIOgQKDA/5Aq7gLXd118AcAcYIeL0T4wJHDqosclmCb
         WGpsASsqPkp97F/DBNGt7jwjF2ngVwfKGX9niPB6uvwausFK6ovgtmNhNHTKeR0t/uo5
         +5Z3Q4iyui9jngW/tGPeGXHdfgnSdsTw4mtlfxtwBypwsabtGWmddKrtN5yOn6oonzbl
         6S8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770235; x=1763375035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U9WYMLCJ2+JzWgDs987QI8B2qg2h+hKqv2jLVTrRas0=;
        b=em8ABCxxKp8LAvkgTp8752pWoJMg78K66sGYT6hIN6iu5sYxPaWpreRaCfZOAFxO6s
         DM4U/a/AxeCpsghcb4WDu1BQPo/OqFUyKpFx8sFUAdCsm1Tucogd7Dh22+u/jMqe6LP4
         /tzV8BQy8bEk5eMnp56B+RaU1bfNLlPry8yU1CETtx7laGgalU2a6GjdKmIWTumO0vKt
         Wvd/ESVSVCBV7bct1sLNAOYwpWazMMczDYzKpcPZ6r6K0m/r9fYNtP5MwW5gq29kabvi
         5Fod0c6MgWtUtVcxQVfUwum5p5j075oUiWeRJtOOYDj4jI/TzkpE2DUPn0vaz/5gIxBD
         d0QA==
X-Forwarded-Encrypted: i=1; AJvYcCXyRnRLRlq9CyDv47vr/6H8oP8kGn9fNedOL/3qkdLu31VYXzVD/Ej4ATLbf1CAhX8Gq8WJJuoTMPVLqxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNtKhfNadn5/nA4Sx5kn0WBU1MO5ZGux8K+CbWQKwmgCl+9Bwf
	iAJHbqiqRNgEKcGgk0A8W2Rg80EqaR7wHE84958+U1NiHnvOQRR/kMAjKbWzYmLfenVmo46XlMn
	mLBiaxA8zYfsy++kJct1fDAgzSRWc1IGuiRPlBHA3HO7eZGTLkGBkxLPHClejHkTxypU=
X-Gm-Gg: ASbGncuAzHkf09q/rMa6kuA+F6ukta/xjxTjOWLPJgxkN0DCNmultGZfZLkkZmCXQws
	3bakrmynKzh8ozWLeRhh/RAUNzT2W2tRILc6hhD93NH0BEWYoxj6lMat3QKbAbU0BM9xhSVhOSh
	MNUkCLAjsyoJEvz1WgfSgqsbfbhz8b9HD/X1Bbct7uCwL1XIhtrfpZhHr2/bkk45MnmWt7WuteZ
	cC+XiO0Xj8NKoTeTRNT270+g4AKlhd607KNiafIBmkptU3vydCZ7Z5rJfIgknPqxVM3ZU8HfDwX
	j8+U+x0uPbgKckOa+0yU8G1kGHUE82JDSLtuIo3ShITD0tMa/R0kwnXPvjHNEq2S2rcyl0t21F2
	BBrmT6YhZCv4RBJaL8hUeVC3Okt+VSkN9QRj0amJjAqc9SIUimYg6Kdnc4VuPGX2Kls7Icn3JXw
	==
X-Received: by 2002:a05:6a00:23cb:b0:7ad:386e:3b6d with SMTP id d2e1a72fcca58-7b226699affmr8936816b3a.21.1762770234577;
        Mon, 10 Nov 2025 02:23:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4gerh2cVmZWtk2cc+J1ACUH/rUoT3Yw+RVKWJfF5fhK6iyE1Lf7YrN1S937lZmRnwQC990A==
X-Received: by 2002:a05:6a00:23cb:b0:7ad:386e:3b6d with SMTP id d2e1a72fcca58-7b226699affmr8936795b3a.21.1762770234080;
        Mon, 10 Nov 2025 02:23:54 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc179f77sm11153832b3a.34.2025.11.10.02.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:23:53 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 18:23:16 +0800
Subject: [PATCH v5 5/6] media: qcom: iris: Add flip support for encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-iris_encoder_enhancements-v5-5-1dbb19968bd5@oss.qualcomm.com>
References: <20251110-iris_encoder_enhancements-v5-0-1dbb19968bd5@oss.qualcomm.com>
In-Reply-To: <20251110-iris_encoder_enhancements-v5-0-1dbb19968bd5@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762770213; l=5609;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=GFZAAmw/obI22EUCl/eL6/0v1x66MymdhqoUr6MgD5g=;
 b=MsR5lYdAHsBE7l29x+0QWpHyKXVeRmRCVQebbk5gmTvxQrXGOS817oQvN2EvD6DcbsGm7wea0
 q+Fx4w9AlUoAdtHYAGn+pOg+GelHy5+QxPjHr7tF5NVWc90Mn/WWofZ
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-GUID: VkR_i3WDPbbZ7_GmUMWgsIUkgwI_IsBJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA5MCBTYWx0ZWRfX3fD6+LELaryR
 8rgyXRzb5H+GnBkDETyT+V9t6qH5v4T/ffaMHqKbJcYhmJ67yTkYYTqdT5sCsEvP5xuCHVvBA8V
 cEhBp5L+zGC1ddBLp+m9fKSDTuQ0sH2WvOBq1haShYC9w11zxgUkECe88FSAuCrlNYk4FxFEzKb
 pLFTgbeYbsCb+angwma7AyJ/8ROWKEwnEHoAf8gOukr2YROpsfDHX02Be4w4BO5LjbTrI8J7GMp
 2xwQz2Beu/v56A+sk+I3d3sxeHLIwnkbKpgn0bL+bam5Gj9fYkL/eHID1Fp9OyHYMxunqnt3M2O
 QXFLByMume3tulDuV44by5bMllsk7EzASBq3wogJJvbhsxeCw+EaT1nmWZ+S2rPG0AQmY50OAAu
 RKDTu/XL3v+h5SnTmqsuWVQ9mP0l9A==
X-Authority-Analysis: v=2.4 cv=GbEaXAXL c=1 sm=1 tr=0 ts=6911bd3b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=I7aUD2eJchsgA4-ozh8A:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: VkR_i3WDPbbZ7_GmUMWgsIUkgwI_IsBJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100090

Add support for V4L2_CID_HFLIP and V4L2_CID_VFLIP controls in encoder.

Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
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


