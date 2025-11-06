Return-Path: <linux-kernel+bounces-887734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0380EC38F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC1D3B5621
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E224A2367A2;
	Thu,  6 Nov 2025 03:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eBzy19CR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K9NArQnL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765DD2BE652
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399848; cv=none; b=fVjce6NZ7bTshD/E0rHLAYx/7I73Cc3lRYaIAD9KlBj7rMe5V/GAIQqGNgkYnAi3Ncv1Tv3B12WaBtSde29oEhCS5iNz6Y8uON4ZN8WQ1wu2Q+MuWDMdMNspBAY1mJ8GrMx3CxPAHQeDx5d/vfMc2GOCOOGGQKkUz/1hzARKcXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399848; c=relaxed/simple;
	bh=thA6qmpbfU2WMMOPXi0eVnEW+mgjzoA7E14BdSZFLhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=niJT5fc5vRrYo7qVWHpYjUwTkj7kYOHWVRSanCBlBW+e6Rd54iem0RWMAbCWJ/bUkpms9GZ6bUhYVFv+vryBecoYQjAh3Y6uJWILRriqoH4M/ZCJoDgnq36O5g9A9W2pC7jqWIlH+t7o6ZB1bxXgDOh5rHsANXHa5z/hTGnX9V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eBzy19CR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K9NArQnL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5KFVll1785434
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 03:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xg/QfOBjMwyvyZvl+AHPeoKV3ZIzdwArDAMeG9l+vfI=; b=eBzy19CRV0IzBM76
	xKtDgZNZManVBbsDWNryf5pfUTv1paX8how7v67mlNHm5Zyhh7M+qEd2dkqJjWlQ
	Su0jgkGTOp2fEv6aoXMW01vqVMfRnFMxpDLuTUEjdtwv3OV3mjOw70QLq75WuCGW
	C7e4UzoiktWlWGeNvnF7dMSY+SEsl5RzXMfzTRkZHHciiaWJqhfMYVRL9OYsWCFj
	PqGDCqbxgqgoU6H+bYGg5x2hx+xBShhvUjGn2E9zASMecgNL4DJARK5jrY5+MvIV
	bfJcgbrgY/+jWKHUaZtJQ4o3A4I62c4GCMWF0bmNMkYKIaVN+vZO4sEOqjeDU9rl
	Y/amMg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8amx9m3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:30:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b5535902495so359321a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 19:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762399845; x=1763004645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xg/QfOBjMwyvyZvl+AHPeoKV3ZIzdwArDAMeG9l+vfI=;
        b=K9NArQnLS59K02yVPmiIceXZwCbOal1ApIwjmPCZuMEbKz8lJcEzfoAhsi48s+T2BI
         MlMvjQUZ8jOrxz+Ft4TWchgJFLwHyxfjDkqWCY1pimw7FZdBc81M/uieYrmBmRZ1qKai
         MlGa/Gr8wy3yx7CaVktkEDw6UU71AiAqSXYyh4817ApUL9IJPN/Z2qaT0IQJmwQdk8tb
         kvEcHDqUVHZWfkjn1qFfsbEn+oKHG0LxJex0nhPvd6hHEBGT+mG9eLsePetDAdOpTLh0
         +cVQK2Cd9pUao4q9wL5R25hVRJk8iUx7wiVmCICbQIOWns/WFvVOfUy5oR5IuCCqdN6H
         we1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762399845; x=1763004645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xg/QfOBjMwyvyZvl+AHPeoKV3ZIzdwArDAMeG9l+vfI=;
        b=L7a3FvKzPLcfXjrImn+3/nKpo/OCZDx7fMX55aj0APjxy9uZIY44V6APZZNrTf2YFb
         Yg/HVGRHJAfohkEhB/SI7wmEIqb9oYUYeYzhz5b82XD7fZ1/ZEBq7qAnBuvg9zNPgPuN
         I8PBARzAZKMAAbFSZ9a3zbANAoUfyHUDRuk2aUuuqcXpT+rScCyTd0He7nBIDs26uijc
         s+zdTi/bIAbm6Nk3+akzCH/H7WE+8rqgtREJM59rdnhW19pFpLNZvWe+TV5eO+2aA/yr
         I7J7zgn6IcYiCHCbbNLRwC0CBJXzEWV73LdDoW1hq/qfH5WYPiXxGFYZAdlKzyIyJA6U
         Sweg==
X-Forwarded-Encrypted: i=1; AJvYcCXPzQYXtvw96+lIzMatT8ZX+E268nhCQuwpK+/J7UKXGnVY2MSBqVXeXlDHL02AZHUYzkuI+MVDcdt9x8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9LllzF/I2/po2GSqwitgjTd0ApcGxDLtCDtRqQu3oPx2xsHCW
	tRF+KY4h4fsvl/Luqe3I55byGW26sU6spXE1qa3gwbaPJm/Z5SNfvj643Hu0yFDy/ucenMCaYar
	p2ZrQ8vOuYZ4+Fy+ZcgRNYhaGjOfSW3BU4RINzJ0GnCD5SMAtDFfCV993Gy0uoA+ivCczEXBrQR
	OLdw==
X-Gm-Gg: ASbGnctR6sqrjRt0gQ0kmwfIoCo+dAm4teV+fnOIpZTcMv/N2+5J7lgvT19Vlnd/vbw
	x37NcPnXWpGsyxeh3or8T4IsEMwtpXYLBpCl20fD8YoiCcff/3UeXD9APQ8bwj+mYKLULSltPVj
	K6DVnFCWWl9dUFEhlE46SiO3NVmH9fNy6n3Rfctn3hO62ppBbfvvwdyWNWtOT7Rhriq7IVUdX6o
	SjIOcFS8TdSkxkjaTCccs4AQ5sIeRIKk5b1vk6z5MjggV//Igv5bpN136j4Kr6FlYgNZcP0iX3/
	7HqJnnRDcC/Oz9ln0kr1CUJEwCMLcGOk+B8UgO7Qmrw64lLEeazNgNwQOuBwNgggiJVLxddgPps
	+LapKU/HuTtUw899L5w9AW8bUbcuqugo+nfyG92wN18rNYPWfKAHVryeGry4RfOEk/sBzEWnkOw
	==
X-Received: by 2002:a17:903:1447:b0:295:4d97:8503 with SMTP id d9443c01a7336-2962ada67bcmr72245055ad.30.1762399844625;
        Wed, 05 Nov 2025 19:30:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1H1G4TG7zItxp58QWOZOBjrrVr5ew13L5mbBoqhJzxDXw0Ktt5pzyO+03XLcuEKSHlyhPZw==
X-Received: by 2002:a17:903:1447:b0:295:4d97:8503 with SMTP id d9443c01a7336-2962ada67bcmr72244655ad.30.1762399844089;
        Wed, 05 Nov 2025 19:30:44 -0800 (PST)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd0060sm10361925ad.108.2025.11.05.19.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 19:30:43 -0800 (PST)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Thu, 06 Nov 2025 11:30:33 +0800
Subject: [PATCH v4 1/6] media: qcom: iris: Improve format alignment for
 encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-iris_encoder_enhancements-v4-1-5d6cff963f1b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762399836; l=3922;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=thA6qmpbfU2WMMOPXi0eVnEW+mgjzoA7E14BdSZFLhM=;
 b=geJGuuAnUGUrsDLs25MURCPSXOFKqxqoAIM5ajaua7qhOwbfOpUln+Ro+Cef/4WvuZIkiWIRG
 U2JEjCp2xY9ART+oBey0u5zI+ihehI+nXeMIipx2Ob711ZXt090744j
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Proofpoint-GUID: butdWQfSfXtg4HfNDXVOY48uTQ5B4V-L
X-Authority-Analysis: v=2.4 cv=P443RyAu c=1 sm=1 tr=0 ts=690c1665 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Ydk8v881x4eQe87C_TwA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAyNiBTYWx0ZWRfX7maqExhxLCRa
 dRZC5D96f7U1OTS1me+A9+bw4azp5I02J72qhSkZWwyk7u2MjijiMbB9DcXazczEOCgPlql4wAL
 q4gJsmIufYVVjOU7oe3jdbt1rS823olQaAgHiEGRK9WYWYc36/hUpY7AkARC00CYw+aJUvs1OcY
 ILKRSx2DDtAbbjbRkNadJ858T+IdendeNaj7J59DfCh5wRPZJhwEGQYavCNMqP0GgP3uE0FSGq7
 fDFUBzGw3Z1xXJQR+HejbVK2oMd2EWrVygOTzh+47EE8R/1BBU5+AeLcv2lEBGW3vufQsBiYK7B
 STR/56p9Yy8nsY2KcoJGy0CL3S+N1RuCgUwD35Bi4p16J4g66KTOwhi5ANOl5TG91siHLk3iA/X
 2Sg3CStwB3JNyKkTYav7/D72f0+ekQ==
X-Proofpoint-ORIG-GUID: butdWQfSfXtg4HfNDXVOY48uTQ5B4V-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060026

Add members enc_raw_width, enc_raw_height to the struct iris_inst to
support codec alignment requirements.

HFI_PROP_RAW_RESOLUTION needs to be set to the actual YUV resolution.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK
Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c | 7 +++----
 drivers/media/platform/qcom/iris/iris_instance.h         | 4 ++++
 drivers/media/platform/qcom/iris/iris_venc.c             | 6 ++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index 4ce71a14250832440099e4cf3835b4aedfb749e8..aaa79dfe2db281bb77be7274233f093b0086b5d4 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -168,8 +168,7 @@ static int iris_hfi_gen2_session_set_property(struct iris_inst *inst, u32 packet
 
 static int iris_hfi_gen2_set_raw_resolution(struct iris_inst *inst, u32 plane)
 {
-	u32 resolution = inst->fmt_src->fmt.pix_mp.width << 16 |
-		inst->fmt_src->fmt.pix_mp.height;
+	u32 resolution = inst->enc_raw_width << 16 | inst->enc_raw_height;
 	u32 port = iris_hfi_gen2_get_port(inst, plane);
 
 	return iris_hfi_gen2_session_set_property(inst,
@@ -231,8 +230,8 @@ static int iris_hfi_gen2_set_crop_offsets(struct iris_inst *inst, u32 plane)
 			top_offset = inst->compose.top;
 		}
 	} else {
-		bottom_offset = (inst->fmt_src->fmt.pix_mp.height - inst->crop.height);
-		right_offset = (inst->fmt_src->fmt.pix_mp.width - inst->crop.width);
+		bottom_offset = (inst->fmt_dst->fmt.pix_mp.height - inst->enc_raw_height);
+		right_offset = (inst->fmt_dst->fmt.pix_mp.width - inst->enc_raw_width);
 		left_offset = inst->crop.left;
 		top_offset = inst->crop.top;
 	}
diff --git a/drivers/media/platform/qcom/iris/iris_instance.h b/drivers/media/platform/qcom/iris/iris_instance.h
index 5982d7adefeab80905478b32cddba7bd4651a691..a9892988c10bc28e9b2d8c3b5482e99b5b9af623 100644
--- a/drivers/media/platform/qcom/iris/iris_instance.h
+++ b/drivers/media/platform/qcom/iris/iris_instance.h
@@ -64,6 +64,8 @@ struct iris_fmt {
  * @frame_rate: frame rate of current instance
  * @operating_rate: operating rate of current instance
  * @hfi_rc_type: rate control type
+ * @enc_raw_width: source image width for encoder instance
+ * @enc_raw_height: source image height for encoder instance
  */
 
 struct iris_inst {
@@ -102,6 +104,8 @@ struct iris_inst {
 	u32				frame_rate;
 	u32				operating_rate;
 	u32				hfi_rc_type;
+	u32				enc_raw_width;
+	u32				enc_raw_height;
 };
 
 #endif
diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
index 099bd5ed4ae0294725860305254c4cad1ec88d7e..50a3eb975a2523abf1c2df128a66a762a1ed35c6 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/iris/iris_venc.c
@@ -68,6 +68,9 @@ int iris_venc_inst_init(struct iris_inst *inst)
 	inst->operating_rate = DEFAULT_FPS;
 	inst->frame_rate = DEFAULT_FPS;
 
+	inst->enc_raw_width = DEFAULT_WIDTH;
+	inst->enc_raw_height = DEFAULT_HEIGHT;
+
 	memcpy(&inst->fw_caps[0], &core->inst_fw_caps_enc[0],
 	       INST_FW_CAP_MAX * sizeof(struct platform_inst_fw_cap));
 
@@ -249,6 +252,9 @@ static int iris_venc_s_fmt_input(struct iris_inst *inst, struct v4l2_format *f)
 	inst->buffers[BUF_INPUT].min_count = iris_vpu_buf_count(inst, BUF_INPUT);
 	inst->buffers[BUF_INPUT].size = fmt->fmt.pix_mp.plane_fmt[0].sizeimage;
 
+	inst->enc_raw_width = f->fmt.pix_mp.width;
+	inst->enc_raw_height = f->fmt.pix_mp.height;
+
 	if (f->fmt.pix_mp.width != inst->crop.width ||
 	    f->fmt.pix_mp.height != inst->crop.height) {
 		inst->crop.top = 0;

-- 
2.43.0


