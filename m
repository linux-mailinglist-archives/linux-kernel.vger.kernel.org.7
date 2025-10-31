Return-Path: <linux-kernel+bounces-879870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF52C244B2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1043B74CF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A74333755;
	Fri, 31 Oct 2025 09:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n/bpTy2X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P16AFVMO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF24033710D
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904316; cv=none; b=kzcd/yO2HlSb41xaj45+dfBfDOBIQjv8kG61aTRfAM038+AGsa0dJMKud9Vf0Jr+KE/9/95R0LCyM+lGQS4LpDWYNUEJqIw10qSTO+1cwx7Y/O9V732SXVsc+YC5mlhdFFvNlLMilY4bsQ6G9a1UD9UGtGZKAmJh1yTN0O3ZURo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904316; c=relaxed/simple;
	bh=yXQEX8LNu0TsL9VDTKU5gwOSUNtbhNTnq7C28ggjxog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FZh1+pSU1HZ5c6qvz0kXxrhnOIT6VRyA5N+4yyaDqzXAamCaj/mHcoYqA9+MnCHRM7x4ot7fOrXfoV4HO0Q/VKXM46fgzs3c1xWEcs0Y/wtz4AAN3FoLoDRPCVrhzCIvRBfDsQKX4HuF0os6CATiys10Rd9RNb5ilVlljw6NtnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n/bpTy2X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P16AFVMO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V8tU5N898100
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7mUbZvm4xfQOmMBtO789r8Kq5Frjmsno6H4x8WK3gJ4=; b=n/bpTy2XST7oSEfy
	Ppo83Jjbq67eV08S19JwJUWgkhk0HZUyDGSZlJ921pMeePmRqyjamtE1tnIbg9fh
	hmf0R48u+CFQjiXm0DHK5gA+vJDt52JQkeZxeVc58ZShs6G1cnAwhCU8Ze/XCRqA
	2QDtSMvrhHAGyoDAVvbwKfEko6WheXuSdv7lWrQi/tmFR/v+s7t7DRUSXEBDfUtP
	Pk4jVMrvlm/0VaxqE1/m3FdtWJTdSYTjPwRQC65g5VGdGybiurXDyBwwgTDPrFX1
	lFNapuHYkDn/FgqJT7Z16ZslvdwivkjAk0AunLRPcGYCBprprtWTLb/oIJ1u0CWw
	0aWAqA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4gb21nb2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:51:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-294880e7ca4so42078305ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761904313; x=1762509113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7mUbZvm4xfQOmMBtO789r8Kq5Frjmsno6H4x8WK3gJ4=;
        b=P16AFVMOfU/XhaLl8hnHeFEFlqFR+jlol4rnj1M4crJnrnFP0zVgbB5fhkNgVPxiK3
         UbZbKq8nFa0eQrMNiRV7IWxxLwgLNbG8Az8LvyNtjy6S73ovu0bPvpEP/0pcK9oXZxz2
         YCPgbv2plwMO+P56yjD/jNsCOUdztAiUTQm+7BQaZH9gTg5EsQnvutFt+QOMvSr+kx40
         V4ZlMtl6xI86n0bND9oSo308C5bQUN5t+5jN4RdcKBnA3WStajZZ8RgWOzH44+3aJ4G3
         kZ1IYAO175s8aIJ5zQPpl1hkro85FpEJaitXehXvtHav+aT+gnRzF3hTsruf8OY89JEy
         huxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904313; x=1762509113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mUbZvm4xfQOmMBtO789r8Kq5Frjmsno6H4x8WK3gJ4=;
        b=bEiOo76SHeYMO2A4WZqO1lsrewi5U68cPh/RbKA6FBDjH1pEQ8nRR5zvAPz3l5qdXk
         eI+QscP6+ikRzgRngTcFKsk5nrBpbW0yuH8IvWMETQr6jUzRD9PEzo21pggJ7FARwrT2
         GuhMGMoKP4ZXHNZY4rse/tw+vTCPOFNSrKU6prgwLyuXoGwWqsICJHr2KEr2PUT8JYl/
         3p5PcNi2NjzUU+BHEzp6bcyti3RfFAxtbD8onSIVP6rqbaittXDJzm6sm3CsdXx0ooj0
         wvm8K59gqbQ372+SaAn5iPQ+YCVg6was9jAae3WjAPJyguh+k9ZiPyfaQTnKaEl4m8Av
         r4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXxLL7FcvSyuo0S6sLHyIg+JutmNAMLMiJWyDpsa/5Y9qpA/hEmQOz3MxHtcoWiFChcMbCNlNVet59YCBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXKdI3JQmzXCZa1fMpir3JQTW4x6KviWrVbPZ3smi3r1agWZgv
	X8whjDa0kpeYd77GJ8AShl33kROTJIqryGRodPdR3IpUlk9/ZQPscCyOKqJSVpuZVMy14RHS489
	8354kL852uHo4454lVgPWcqF8X3qVch54EBukKOh2NsIREseH/Jz73eL2x8ebJ9DcPQU=
X-Gm-Gg: ASbGncsbztvPxpIn5Vw2AmmsWc46tWd1jfkjTTia3Ta1geesMr0eEsAcHeVaUo7fVm1
	CNbfR4k+5mxba1MFCf6oxQCZSq8y6xFqe3RWpR6nU8I/uTztBam1DeNReZU3Ck1KVJzxMe6Gs4S
	ZtPZK4ooISy7Saykb3Ts9P/5yUMXlRo5fRGmEeQhHpnF5/s8MA4kR6AONaZA99zG1jjRyuffQnT
	KO/1GvFuABDiPxNG7cckOSZlMThhvL9gkWPy3/j6AP+hw5A3ku4TZlcqDrScUaxOVKl4vdPBF9R
	D52PmJH2XYxdqwmdZZQctrB5NAjbjKFHP1UEH4Z8v3/01/aScpV2CuUagCKDLDmSOzK5WlmL6oX
	RYn0Rhqk6svdPsMpIgv1mgCfkhNsFu+gqE22RDPG9Cdjif8OKtWUVfNkSQ7u8SosDclqY5+KRUw
	==
X-Received: by 2002:a17:902:eccd:b0:295:32ea:4ce5 with SMTP id d9443c01a7336-29532ea502fmr9348585ad.6.1761904312948;
        Fri, 31 Oct 2025 02:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXe9nQdng38o4OJMobcOH9bnesb6ZHCKFN3tvNJRYZ/D77oNVbQxA4cK+EffDly7a5xbachQ==
X-Received: by 2002:a17:902:eccd:b0:295:32ea:4ce5 with SMTP id d9443c01a7336-29532ea502fmr9348255ad.6.1761904312418;
        Fri, 31 Oct 2025 02:51:52 -0700 (PDT)
Received: from WANGAOW-LAB01.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295268716e4sm17913115ad.9.2025.10.31.02.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 02:51:51 -0700 (PDT)
From: Wangao Wang <wangao.wang@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 17:50:43 +0800
Subject: [PATCH v2 5/5] media: qcom: iris: Add intra refresh support for
 encoder
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-iris_encoder_enhancements-v2-5-319cd75cbb45@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761904292; l=6258;
 i=wangao.wang@oss.qualcomm.com; s=20251021; h=from:subject:message-id;
 bh=yXQEX8LNu0TsL9VDTKU5gwOSUNtbhNTnq7C28ggjxog=;
 b=xJS+oQadNRx7R2wufglLZFEq4msH9/kXRJxJPCI0aNVjGHXc6OGbeZe+MIKIEOuHmUvQg1fhA
 9JUVktI7blHCQcRUWg7/286uLaFx8Vec9vxVeZL5ocLW/3i4CFCbR+h
X-Developer-Key: i=wangao.wang@oss.qualcomm.com; a=ed25519;
 pk=bUPgYblBUAsoPyGfssbNR7ZXUSGF8v1VF4FJzSO6/aA=
X-Authority-Analysis: v=2.4 cv=efswvrEH c=1 sm=1 tr=0 ts=690486b9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=-vM60OG-bLC5KXgFrusA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA4OSBTYWx0ZWRfXz34u2rsfuZSp
 StTAy1aDjXjjHEfkPnnBHYdQcOrSaoqrJKmye4+Qr1PK6ot5s0sjlLi1AtGJUdx6qC5Y+eWZuT4
 ke/awnRhQiMOi3W3f77iVjdSucXTZCU2i7FfmEL79xUXNI4+cqKdlPHb/aKMA/Ii4DW2JD3KGiB
 KAlGkPpxFvCOcfVzS2XBH7MVTKDh74KIr1krpg4iicbEAOqolLaJqnlircAuWyRSe6CfpXqqXzR
 FBpHCZJ0g6x11v/07pMgPuFwfor3KfT/JHukXttB/Dj7BCxKNGZbPEG5P1swKUyAE9wXoO2dmN3
 moMwFMi1hw8/uhm2806p5W0Ul+xBzIYVNONhZ+E8sE1gfUE6f7pa8WDxw1Z4SYEiRptjLa+9dF1
 YRujM5As7qF5v3T5HX4gnDStlc/6gg==
X-Proofpoint-GUID: epmLU3OpDrilHnMaw5Epk69IxXsf5ysf
X-Proofpoint-ORIG-GUID: epmLU3OpDrilHnMaw5Epk69IxXsf5ysf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310089

Add support for V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD and
V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE controls.

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


