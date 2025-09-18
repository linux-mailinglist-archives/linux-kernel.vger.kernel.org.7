Return-Path: <linux-kernel+bounces-768368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 568A3B2605F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CE95A281F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1AA2FD7CB;
	Thu, 14 Aug 2025 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B/vckcoO"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85E2F745C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162244; cv=none; b=lKFUvTpWDnIIb82xqiWIEkC5H/VimHTMyPhV1Od9av+G1ad4ONIs8VxzYKVufqjOqPvEU/3deHaMxPeSF1ZH3oErVPmujiKhbQsDlp40n19cQZ4EmYdKluhvr8F1yW6hLRsz8qRTfGR0b2S/BfA+rF7CISVqoCvsckpIPxPjC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162244; c=relaxed/simple;
	bh=x1+uoR6DK/zzENBs1biL7ixyQghwHfyH3Yl0nLD18uk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9r/7iGtmMrHpmd+HpSIGRp+TPEYuhKbqFNFfYhDa6RJM2bnUVjoq2pHlGtEfAfu8ONiHg+3OHnq99od+ltZj1N4e6nFufVSZkYBOdw2M8hoFkqDU9fKfEXGTO/i5Mn1qMX7Nmc1FIkBqD0Xvj3B09/8O5212N8/VNtrEKdubYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B/vckcoO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DMbK6O028898
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:04:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aIDmT3Vjazdu20kMJ4BX2RBjNrDk1VVgRL6F8M3KzWE=; b=B/vckcoOm5f2YMgD
	+/Dj6B+AJX8OT8lXnK6y4caZNrt+20bYjFGKCrOIBIslhO4iSVHQdtxSdWBDugS9
	EU9iGMcw5zgX16VUGBrgHU++AUI+Nbq3jZbv1brA0juNwAD6YTCMTEfhGM5LdjJ6
	ZcRnEK3aScsPqeVCsqRn3IbKBBy5A15SQ3AiFVFXNumWT+W/jYwGHEOq4hEGLeNM
	aq61mWdyOQEB1u1A0W1Aq9QWTFm+CqFeRCyjnVbnMfT8E7ENosG0g4cV2N6aS9lR
	6zcvUE9//2Ah3R+qZYCPClGK+AUu6XgwDYEBofpKi26JCDD/P++NvN5TWUXp2Z6g
	lXoZWA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48g9q9x4a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:04:02 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b109bbf062so26676911cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755162239; x=1755767039;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIDmT3Vjazdu20kMJ4BX2RBjNrDk1VVgRL6F8M3KzWE=;
        b=uDe5oOURogzEWg2aQ83NfeOkEDYnMdtPNEZZ9ZouuiFEtZlT/J+KdqfdnaPL/GMXBA
         //yMT0XQEOiANBawgD6UCaANh2pt1Kwk5IIMmWIF/tTfA+3VrMbKRGspdYBiC0VHA4CO
         yaL32OCk0wydKmV0lr2F4QunaUI9k9SYQBpRdHuB0mpYh80alc2djmftlCCuHt7c7kj2
         Fgb7ALfbgNSE6zKkVKzLDAGF5Z/PKxCCPurD+RzUCWMVjBHK4Zh8uXVjni+JiMus75Uz
         ho8wJXBR8ENSQSb2azJE+k18jWonJnYVHL64jgjALsE5Y8mB5BVVmjjImmGsV7NE4LF6
         WIAA==
X-Forwarded-Encrypted: i=1; AJvYcCVlJxn76URLEUI4BJh43rfhSDnIPNFBRThnQwubhJUkdzw2isIOkgtWVuxZSG7cj8TwOWGprVpqxf1my7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuwLBg5ErHxBj6ZGlFCi+Sl/LMAUIexgJfyCVNEdcUEdrDqVf
	NRM469A5K+9vvA52KyjGOZouaSBPl/zF527U5usvBhrmiaVaLtqj7lTWez5mvsrXwn6Qnm1pJT2
	XTxbh491JL946DnOx0z2ttqOxZyGo8XMUdi2EX2wAuJaKJ65hwj0pJ6PJdN0FCLrbItE=
X-Gm-Gg: ASbGncvlg38sV5PsElTYmVzHaDnXWKa0IcjdCmzLvjqB3+owmn9K78VMt/XDhba80qo
	5PxvQXIdcrthSFq5v3WjNjO5X9EYAfab2CDs9IMhM+HHCL5nLXGWeN/kQv+dBrMAxhHEe8kHuap
	OZvDhnMrSCAISG4riNUwujPF+bJGDPYzhXzKY6LDyci4cywDwKPV+Md4sDvTFDoZaoX4TuEgv/x
	ZhDLEP+cqReZrTN4Mp1lXKcSl1GxikzcSlhZoxB5OgNGA+ycATS84YH/DHqpg7NFMvZvgG0Ypwr
	I3L+VylsIDuBTvRnlebPtYhG6BVPywdzlklRYKVCYJAd2urXDVCNyLcPjVjpYKGHg8rx+F7qQZL
	vCFxwkuOJWwLVaymAUi46VXuEMbyftjZ2CGs0rQD3zCinVV/D2VL5
X-Received: by 2002:a05:622a:15c6:b0:4b1:103b:bb85 with SMTP id d75a77b69052e-4b1103bbfa8mr10989951cf.63.1755162239403;
        Thu, 14 Aug 2025 02:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD9qQFqpwtznbPcmUxJdvj47MhjUbFSazuQ4GppfdzdhfX3/IrXaEKp7ZdwwaTSxTH8lo5Bg==
X-Received: by 2002:a05:622a:15c6:b0:4b1:103b:bb85 with SMTP id d75a77b69052e-4b1103bbfa8mr10989591cf.63.1755162238859;
        Thu, 14 Aug 2025 02:03:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-333f8cec11asm1720061fa.23.2025.08.14.02.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:03:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 12:03:53 +0300
Subject: [PATCH 2/2] drm/msm/dpu: use full scale alpha in
 _dpu_crtc_setup_blend_cfg()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-dpu-rework-alpha-v1-2-b4baa4ffa8fe@oss.qualcomm.com>
References: <20250814-dpu-rework-alpha-v1-0-b4baa4ffa8fe@oss.qualcomm.com>
In-Reply-To: <20250814-dpu-rework-alpha-v1-0-b4baa4ffa8fe@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3889;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=x1+uoR6DK/zzENBs1biL7ixyQghwHfyH3Yl0nLD18uk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBonaZ5rc7BAh2AxRI3+bXMuEuFAF7/5c5xMVidZ
 8EeiwqAfYuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ2meQAKCRCLPIo+Aiko
 1cMrB/46FUXKKUYBhusstbpScHzDsEIMDop0sMPXTnBYirrWOXU2gv3XZ7/ZZRgw/Lgiy3K+s8D
 VX3XRggWyVzC/9Cu4lsaDdWbyx39D7nE61DOFpdHLU1IrVkFdk8iHeoLNbw2leLjc8clCfQnHpg
 /EYyRtLNMR7ywhXmMEisZESNJiwWOeaxKo35v0HlFrv/TrK0LxPICLGSKo6hZcFKeT0ATi9ukeS
 tqcB3U+CNnEmENifajSaR2LZvC2a95fUIDEGzsujp9xMNMQJEJh5KMdVgVKf33rZfI+e3boUjKa
 l7JkDJysEHQ04TXET2LUCDgx/Y7LKUDaR8J7kPr6DDQJDCnh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=CNMqXQrD c=1 sm=1 tr=0 ts=689da682 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=QNru2a5V_XkHKSg3hPgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: CDvuLUdRWYEZlQccapt6PLuoMqOxmUWT
X-Proofpoint-ORIG-GUID: CDvuLUdRWYEZlQccapt6PLuoMqOxmUWT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE2NCBTYWx0ZWRfX5GX4tjGza7+P
 P8BUqGLXkmdjd5WsEcHpCq/Qqwx3y+eY4/KC9aI3QmUOAPjwsl0Hirce8GKCLTj4mwp89CE5fEr
 f1VF2Zjb2q4Mygzkvh+4B6+8XyeZWCPXvp/YDFp7btrAz4oMNYdr6NUpyn2MRSCcHV0Ba1+hPsH
 GZuiC2y/KSZhg4K6bnEVHXtAeoC4nsDcZprDcQMDBcOnoZbrVCowTar5AAcgbw1Uk11G/XIkbcF
 FNXL2MGHDNe70EZwWDEyFS5Wv322iRhS1BKuQPfJzfuKDox+TVJnvAfgbhjn1NtWqdzvglsRycg
 cqzOb8rDlOCnDuXZOGI5SkfMZoOyWYMwYUHl25AuJP5VcL6osI00Rzfdxork98COvjnT9Cz+/EF
 BXYpOA91
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120164

Both _dpu_crtc_setup_blend_cfg() and setup_blend_config_alpha()
callbacks embed knowledge about platform's alpha range (8-bit or
10-bit). Make _dpu_crtc_setup_blend_cfg() use full 16-bit values for
alpha and reduce alpha only in DPU-specific callbacks.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c  | 16 +++++-----------
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c | 10 ++++++----
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 651159e8731194d75b52c05158bfd1c9bad8b10c..a280c136104added1dbb2b432f15680bc1d5bd36 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -326,26 +326,20 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
 {
 	struct dpu_hw_mixer *lm = mixer->hw_lm;
 	u32 blend_op;
-	u32 fg_alpha, bg_alpha, max_alpha;
+	u32 fg_alpha, bg_alpha;
 
-	if (mdss_ver->core_major_ver < 12) {
-		max_alpha = 0xff;
-		fg_alpha = pstate->base.alpha >> 8;
-	} else {
-		max_alpha = 0x3ff;
-		fg_alpha = pstate->base.alpha >> 6;
-	}
+	fg_alpha = pstate->base.alpha;
 
 	/* default to opaque blending */
 	if (pstate->base.pixel_blend_mode == DRM_MODE_BLEND_PIXEL_NONE ||
 	    !format->alpha_enable) {
 		blend_op = DPU_BLEND_FG_ALPHA_FG_CONST |
 			DPU_BLEND_BG_ALPHA_BG_CONST;
-		bg_alpha = max_alpha - fg_alpha;
+		bg_alpha = DRM_BLEND_ALPHA_OPAQUE - fg_alpha;
 	} else if (pstate->base.pixel_blend_mode == DRM_MODE_BLEND_PREMULTI) {
 		blend_op = DPU_BLEND_FG_ALPHA_FG_CONST |
 			DPU_BLEND_BG_ALPHA_FG_PIXEL;
-		if (fg_alpha != max_alpha) {
+		if (fg_alpha != DRM_BLEND_ALPHA_OPAQUE) {
 			bg_alpha = fg_alpha;
 			blend_op |= DPU_BLEND_BG_MOD_ALPHA |
 				    DPU_BLEND_BG_INV_MOD_ALPHA;
@@ -357,7 +351,7 @@ static void _dpu_crtc_setup_blend_cfg(struct dpu_crtc_mixer *mixer,
 		/* coverage blending */
 		blend_op = DPU_BLEND_FG_ALPHA_FG_PIXEL |
 			DPU_BLEND_BG_ALPHA_FG_PIXEL;
-		if (fg_alpha != max_alpha) {
+		if (fg_alpha != DRM_BLEND_ALPHA_OPAQUE) {
 			bg_alpha = fg_alpha;
 			blend_op |= DPU_BLEND_FG_MOD_ALPHA |
 				    DPU_BLEND_FG_INV_MOD_ALPHA |
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
index e8a76d5192c230fd64d748634ca8574a59aac02c..fb8c94fdb829be6f89bfcc6c5a83fdbd27778bf2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
@@ -139,7 +139,8 @@ static void dpu_hw_lm_setup_blend_config_combined_alpha(struct dpu_hw_mixer *ctx
 	if (WARN_ON(stage_off < 0))
 		return;
 
-	const_alpha = (bg_alpha & 0xFF) | ((fg_alpha & 0xFF) << 16);
+	const_alpha = ((bg_alpha >> 8) & 0xff) |
+		(((fg_alpha >> 8) & 0xff) << 16);
 	DPU_REG_WRITE(c, LM_BLEND0_CONST_ALPHA + stage_off, const_alpha);
 	DPU_REG_WRITE(c, LM_BLEND0_OP + stage_off, blend_op);
 }
@@ -160,7 +161,8 @@ dpu_hw_lm_setup_blend_config_combined_alpha_v12(struct dpu_hw_mixer *ctx,
 	if (WARN_ON(stage_off < 0))
 		return;
 
-	const_alpha = (bg_alpha & 0x3ff) | ((fg_alpha & 0x3ff) << 16);
+	const_alpha = ((bg_alpha >> 6) & 0x3ff) |
+		(((fg_alpha >> 6) & 0x3ff) << 16);
 	DPU_REG_WRITE(c, LM_BLEND0_CONST_ALPHA_V12 + stage_off, const_alpha);
 	DPU_REG_WRITE(c, LM_BLEND0_OP + stage_off, blend_op);
 }
@@ -178,8 +180,8 @@ static void dpu_hw_lm_setup_blend_config(struct dpu_hw_mixer *ctx,
 	if (WARN_ON(stage_off < 0))
 		return;
 
-	DPU_REG_WRITE(c, LM_BLEND0_FG_ALPHA + stage_off, fg_alpha);
-	DPU_REG_WRITE(c, LM_BLEND0_BG_ALPHA + stage_off, bg_alpha);
+	DPU_REG_WRITE(c, LM_BLEND0_FG_ALPHA + stage_off, fg_alpha >> 8);
+	DPU_REG_WRITE(c, LM_BLEND0_BG_ALPHA + stage_off, bg_alpha >> 8);
 	DPU_REG_WRITE(c, LM_BLEND0_OP + stage_off, blend_op);
 }
 

-- 
2.47.2


