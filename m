Return-Path: <linux-kernel+bounces-879868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9213AC24488
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DF734F0983
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AB4336EC0;
	Fri, 31 Oct 2025 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XSXjFdaS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JRjbQsvG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E413358B3
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904312; cv=none; b=mizH+iZ1X3vybVAe/I+Iz6dNTMeRnrlyHrR4i9xt19MwMFxaI3un5yRw25IhdMLyDN3tHdDt3ZWRdSyWo4UDO+kd2dkd4sp25MwQZHh6Jvh1ZxsJQ/B4XVDb2epVkoZMyWTea1Eba6PjRM6zJ9MxXgXhODnmXzHzrj9SYv6PYdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904312; c=relaxed/simple;
	bh=IJkf+YIwrITwSassNOIm3Z8YdfOmrJJE6k+78c9So9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ImvmG97h4Fw41UfkkhJC4X+p78D3gZsKBqeqXCy3B4h9XXIq98Ru87/3nCGyi5OBukyAvOWEBfMrmPWorlkdp7dNxcnZ/RDtokfGFWeCg3JExmOGkExO6FVxMlqEoueOxkLwAYCSmp8cP2hK76aZUEz4xT+z1K9niC0MRNOIXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XSXjFdaS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JRjbQsvG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V8kwUa898142
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YI8Yr8bBFNMts1VlPfmxf6DTF8i4ARw9RijhfrG4oGo=; b=XSXjFdaS3dYcq8cw
	LyD7eUTAl0MQDEjs1OO6AUM4DoD1epArloHXugZvIARpFag0VASarqxLj40EeHuA
	Cozo7AOJN3qQ6CCJs+zF9FW9XA3CP5UIIXSjAtRKqRm7Nf0UJjWlohBAdTefEeQJ
	rep3W67tpGwIKZHgtQ8naPAW/z05PwxMKYZHkyV8Rc1KiFxt6O5qVPX2mkpgKSJx
	Bx2bk3HZDn0LEyVMrBgIHxregdXy+UmZw2aoGWAGPV2vpumfg8EnYTjclDP7hH/r
	pkEWLaJFC9WKoIfSb//8FN4f5JiQr3Vtrlpuu+7zZixngv4vFPOfBGhh0nfPC0+y
	q/OpfA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb21naw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:51:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2950509239eso18516285ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761904310; x=1762509110; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YI8Yr8bBFNMts1VlPfmxf6DTF8i4ARw9RijhfrG4oGo=;
        b=JRjbQsvGmIoR0QAqwiXuY1eKQ3HenUm0tkxv9R+bfsOxwW63hZIJSzZ1uZm4ZSl6r8
         p13cpSRrv8rvcZw+NZKYgBaOzVq2hcDniEWICEGLLUR02ULimHIKYMpHXALDX+1Hu0c2
         vqqVu5wbmO1nsx0xAv4PMAlxRwxxJ5ZCcLZ+HLHyNxpeS1HK43MQ4Mmb4LZwSQaV4PM2
         9ZRu7LlyMpN27eEGKK4PXDZIx2ZwpWYmdzHK9T7CJSzaWF6hZojrp7G1JHEp26qsSRgY
         NY0oy4gSpZ2iSbAgD0s6F5Lo2Fhe5sUW208Tig9sai6MXZFJKj29wGxLVIHEt2AsbA+b
         qTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904310; x=1762509110;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YI8Yr8bBFNMts1VlPfmxf6DTF8i4ARw9RijhfrG4oGo=;
        b=agg06fpEqN71m8JqFDXTlywutvnzAXI05CP6T15dQzUtn+HOhwYKmSKjiUoi90/m8B
         mGoQnhrbA4PgJPrhuBCe/l9ahTXPQxTVGxq1BjVft2okV68sl0ZTYY0kbj2gif73k/4n
         Qo1AvHqiKUYO8p0MwKQ5s+0L7H0UHvKzuIj7Gmzjqn67KPIh9sMwsuwQ7WlePyDygkqR
         2wg5yEResc5dMfLQobPmGGuJnDIXQkqLGiSzFej5oo7fFCPuV0+E8b5SN6xvUeVJeo41
         eYqm05ZUp1Fr2OscTBPciFV+nkimPF5Mv4O6ZazYL6F/ixkLmGiBwwLDxRMB1+dwhqb/
         KhBw==
X-Forwarded-Encrypted: i=1; AJvYcCVrmbuaEoDGV2SAtD9Kqp+ZWMsm+KBMLA5TcQT44Ah7iiHQOKsjXtb9XWuWiciv/KyqflokQlneNKGiztQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwasErBWXEAvDuje4uMJKs6HpwX8x0MimIJgQ6jEjKaBImahcn
	f8/kSkO+SCs2X2kYxZq54s3wCuWhhry1kv3oyQaF7bjFVzcB5LR/8NnVr41YuteOGsFYiiGWtXM
	8MQUzP3YCOIp6ZwNACCNBwla7ImAME3Uacq+Fq7w/7H0GByAkFcdNMXIFPompOKK4ceY=
X-Gm-Gg: ASbGnctY9JOY0TZ6AH4hmQvdkubWTa4TjANU84qPh/mJTCZAFKvfJ8YHAVd1H67swK1
	JpDtM/DB7gU06XZ8ZUpVnvgCA7qw+FD4gfRSj7Y9mRP4uxkzD+T9kR7r/19BVU+yUHWSY8Mn8oD
	TZBgdm8l4RmGKKPQWZgf+hLeDN/MykBUcP+pGO+LEpXYvyIzar6I/lfEYEjXamV3jcwoKFNIsbb
	wRf9TJ7vpnei6LEqvGkpCVLUp83+WrxfOdxLdIgLhn5d+w4L3evMyA9sfCTAJH+pewdraeFu+CH
	/7Njiv/sNuwEnxMsDyDYLUgnAZkHJGPyxleLi2zJSusQ7VQ0aMB+u+a+LNC2/gTxeoC8Hh/I/ne
	SgYDDbf5DTESr8Z72YLg4utrwgMto+Q9bRIZVw+aylq2uwbjz04DL6/fecvyRGUn5PV0UYx7vMA
	==
X-Received: by 2002:a17:902:ecd2:b0:295:2cb6:f494 with SMTP id d9443c01a7336-2952cb6f57amr15103095ad.6.1761904309586;
        Fri, 31 Oct 2025 02:51:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsTN996IzqiFwKphs97HCXFiPxo6pwN7H8m2DAtx7ATrx5QxirKCakwpVUtElaFe5wAGkXcw==
X-Received: by 2002:a17:902:ecd2:b0:295:2cb6:f494 with SMTP id d9443c01a7336-2952cb6f57amr15102695ad.6.1761904309042;
        Fri, 31 Oct 2025 02:51:49 -0700 (PDT)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268716e4sm17913115ad.9.2025.10.31.02.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:51:48 -0700 (PDT)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 17:50:42 +0800
Subject: [PATCH v2 4/5] media: qcom: iris: Add flip support for encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-iris_encoder_enhancements-v2-4-319cd75cbb45@oss.qualcomm.com>
References: <20251031-iris_encoder_enhancements-v2-0-319cd75cbb45@oss.qualcomm.com>
In-Reply-To: <20251031-iris_encoder_enhancements-v2-0-319cd75cbb45@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wangao Wang <wangao.wang@oss.qualcomm.com>, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761904292; l=5471;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=IJkf+YIwrITwSassNOIm3Z8YdfOmrJJE6k+78c9So9k=;
 b=K35f/ZHVJTu2oQJcWIZut+CcfRQe39O3PZFjqUTVMGrfZhbqbLNHhZhmXkww06vIB17GXEtuj
 9Z+aucb82OrBPB8CBUuSMA4FbjpeQ8jHTWgHNoioguzMTJPQ/TcUTmw
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=690486b6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=uxdc-9wEpbf47THqrzgA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA4OSBTYWx0ZWRfX3loSYuIOQPhZ
 8trIuBezzclAT7HCLiefT3cy7O91FVFcMsbW//Nsfvv3sr3JjyZmlXLAva0pUJwdJu7XkWZFNmM
 ndVfyeQr+meFYmDM7E4nobemd9hlTC5aoy9G5XH7S7kx9KK0GE1UaOjhD2TnIP2+7twftckgMQE
 ImGDKjySaqsUms9dGxAMYywOI6avkcdahC6bubzpyso9VKX4DYWthxY+VixFEws5tCjltto/L8B
 VcwP8U7MWTS2mFqir9nbq5iHl8fCX9ruBhXaVCADkL2fWHDr1CKL4B4mzkpsL9eMSgS1yB49Rux
 6VPuPzuamQ4TxJyPflmDNwEqYDCAXlTb6pNURg+CAMIJjQbVlaiGOmn9ndlK+YicC8bnbmnemHs
 WsnwLDI3URRRjx8SRIxB9nRcCIZiXw==
X-Proofpoint-GUID: wKujo_j2hEh2km6nTU3PLklovwNCpkFU
X-Proofpoint-ORIG-GUID: wKujo_j2hEh2km6nTU3PLklovwNCpkFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310089

Add support for V4L2_CID_HFLIP and V4L2_CID_VFLIP controls in encoder.

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


