Return-Path: <linux-kernel+bounces-617066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F74A99A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 23:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202AF189393C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604D0283CBE;
	Wed, 23 Apr 2025 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HToZoNro"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF9727935A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745442640; cv=none; b=hLHgT2gwU0RiZDnT/C4QXwinOQUZRsjkpvlKgknBITwB9xeZTU7CeQ/Bd/UqrgaBhmXMdB12AsPa00zPSUJ1BYpxnfEZLF5v1H4FLfQFdAtNaeH+4/y5jyucT7Hx/cr7nBGEEokucb/K8B10wJyY+yKPhEBOJHOVJ6ZvQ//dHoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745442640; c=relaxed/simple;
	bh=CAaKBgr1B4H4/XfgBqgZrClsJ2RATVjIFrYJ7M/x0cA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jsyR0zMhogj+b1JQ7XIRNOSofqKusls9qM6ev1zoGw2rl8JRsdbiQqBsza3RlpFmGS+CaK1nTMtc57P/WK/+0PfQ4WaCznySBkiastpjrOp3vrprjYlwy4VrvNpf40B5cdD+F+85D1a7+aDlwICKaIhRB851gGtq2vehGEQ/+mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HToZoNro; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NApPZc020408
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 21:10:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AE4lzFJnqWE5e+eBkiWINHStPJHmgBESpSkQsX62/xk=; b=HToZoNroAKEI2Jpt
	N7niKb53rvBwcuc6uuzlwHsZw3XKPmwAW1tLLIImoJ5z52am2ResNGXzB/O6Ovzn
	m7jVlAqFkf6Vh8Hp953WrSPLeljcbLf1GpFI6plc/TrZQ0JUpjgmFMw/Ba9vw/Cw
	kRWLiEnzH9lYLkY1ApIL9ioiUfE6ojNqybKc9z1QOs/6VSv3EsuYDtKrXtAilvFN
	UeZV20xht+6NzALRD9cWRqsbKUOyrD+CNAFpDqhSYzlvUyEXJe2azd93eYaFhJIu
	topAX2HBj8nj1Re7bdZDpMHs+OU+CCrWsM9rlfE0i7IdV4x73gEldVJ+4wc0tza/
	Y4hWLA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh23dww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 21:10:37 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e90b13f5c3so7360506d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 14:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745442623; x=1746047423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AE4lzFJnqWE5e+eBkiWINHStPJHmgBESpSkQsX62/xk=;
        b=dJnRODtBlh6aStNpIqJhe72KpXnlQRcyAHISgweRX4fTavS0EC0Rz3BKg2dJI6MUBV
         lZHdJtG+lNUCQxONEPABs/gRRuia7R+iTp8qYra+N3030GGpkrCJ2gqIYpbcZ9lyH1y9
         JzLpIhpZ4AADs53U9Xqa9H0xsA2HLfAx9oHWJIMNPUMpp9frY+iL/th1MA/D7SN6UMsE
         2ECt49UhVNYo8Q+Wtm6a2kIYsK/hnVDLi/oPAjSjZo71gLtnrdMY8HYIWw7RK8C0YzjS
         yd/XkD+8r+2CDgcMwPmxEIm5SaJhPz1rMuZGgvHwe+9EkKNIJ5skxlvlIikXBIzz4HRj
         wTug==
X-Forwarded-Encrypted: i=1; AJvYcCVIvkNwNwWz3TIp0DXilyZXZ1Jco0PAxUKARlYdEEJAE18Q8FX2l/SRQ6LR8QRFJRFbpMKHWkaAZjSP/4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhcmJa5HgK0cK8vrb6911S+x409pAD5AP9OlYTAaD+9VkiqWhd
	gCx4Kg6CczHth1FTQJjAOysr8lT3sfs/YeOU9bBCogBqtqip3Gcvb2i2QI4gExjKk3UaHLdSnX+
	+MK2Qn/Q5gBlyJaIod4OT/ooWAKkVW2ol77Zba1iDuONv0pCZTugq5G0sn/LtAaA=
X-Gm-Gg: ASbGncv7fm7zVlADD2RgjHYMyMPPjtgnt9v+Sf11BWEYlbYQMGatQ53lJImJMLVb845
	a/3kDFOl389FdTu/ukIYk2/cyWSWGJvB4r5HEs+fj57s6Xwjl0Mtz331BlGa3Fl6AoTvKVQZ4MV
	v9UFoNzAIfXPVaC5YBpn5VqO1rSilxLeCvMhBPJbPphr04o6QqH4DsIV+8KFIqfbYwBLl4fcAsU
	PSA1hGHlYdWNC+CjZkb01mCPwwqGlsTducznkH+zUboVGn0pzQdb+7mFJ+Ck88iFUHiCtjaxU+F
	2OPFiBnR7ElXsk7kNfsogWZx0KfMeAfq1wHRtdluD8FJ+UEat/mBfpLGZ5vXBEUbMWDNIT11LX1
	jWKzPODwSztLr9fabb+PWGkCG
X-Received: by 2002:a05:6214:4012:b0:6f0:e2d4:5936 with SMTP id 6a1803df08f44-6f4bfc1a25dmr4264216d6.22.1745442622747;
        Wed, 23 Apr 2025 14:10:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOQ15h1AP0JAje3cYQCQWZ3mel914n0yFh//+go6tWwThRbRFFMxzg8Pu/UU1Bbz0rKcWT0A==
X-Received: by 2002:a05:6214:4012:b0:6f0:e2d4:5936 with SMTP id 6a1803df08f44-6f4bfc1a25dmr4263986d6.22.1745442622412;
        Wed, 23 Apr 2025 14:10:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54e7cb3987csm3852e87.59.2025.04.23.14.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 14:10:20 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 24 Apr 2025 00:10:02 +0300
Subject: [PATCH v2 06/33] drm/msm/dpu: inline _setup_mixer_ops()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-dpu-drop-features-v2-6-0a9a66a7b3a2@oss.qualcomm.com>
References: <20250424-dpu-drop-features-v2-0-0a9a66a7b3a2@oss.qualcomm.com>
In-Reply-To: <20250424-dpu-drop-features-v2-0-0a9a66a7b3a2@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Vinod Koul <vkoul@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <lumag@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2099;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7p9Y0N9fe5J+FNtNErF+g9/bY2UcR9C9Ev4Hmj1Hodk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoCVcqxEjOTPcOCtC1Ywlim/Lp5IZnIZC5/K2Bc
 K7hte49N6OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaAlXKgAKCRCLPIo+Aiko
 1dRgCACwnKb26HlQN7DsIQ7Im1BVHZQbjtHP45Mk/ElrkI4xXujeRO6BKcEr6jWjGHsGuy2PwdE
 G5fx+vQHPQzN7hCzR+qjhsOMk9HVrL1aaqNTFrk5YNDuT/PmV813I1+xzmchZ35z6YJ3IZOPNIj
 zz2XlK//mp7l7CylJzLNesxbpsolSikrCcpefTIR6XSJceQMCpcoAZNFVNv9QeHLjyDtcGKfJfn
 jdqmCJXbySt+CK2a448bZJp5GTg6TpX1T5w4HXPlLQiZP4tn1qWLe2NOhJZotR8sT0c+iVxqF2e
 MEyc2EEEM0WEPsH0ipUK7m4mWiH9ZP6iLKWdtdgm4wFBMK66
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=EtLSrTcA c=1 sm=1 tr=0 ts=6809574e cx=c_pps a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=2ONPo-prfMSwqFkLVuAA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: WbBXLaz2HeEs4p3KM-6G4Zu6Ad8seqxe
X-Proofpoint-ORIG-GUID: WbBXLaz2HeEs4p3KM-6G4Zu6Ad8seqxe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDE0NCBTYWx0ZWRfXykz/heAmCCdg AYxE2xcSAqkJS5xZEVEwQyEhqz6V00p/AynWibqXpg3/0ERWWjHmW3mr5cXtxZOty+f6xnpqO5g QHxyhiydxfYcPEsTB7cd8fY7v6nRCQwRFbrnrrSob4tqOgxbTZE5F0OF8VMj1e9JqIfcGuibE5h
 yA3YS8t9Y+OpG0M8cKtSUJK23MwLZ2/ctWebSZAgQ7Jrg2suKTMivptwkmgJfIyW64H6fofCOK/ OPlwBPKKx27MshehxFkbeNv7vuKE6U6FfWPwYgWky98D+jRlYxOR/FX6kxF8XPMx/ZVmV9SMPnx K78ViydVC3D/LxjRI4ygla4z7QKKuEdFpSUrimNsrteV0WeVgpObRYA6w87xy3ovgY3BSTg0XJK
 FlihcxLu0PStBqCGcioQZXpyQNfwAK62yIqUwUZ9SNXb3kziMsdO1RJPyFFk8cv7zxG6CN68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_11,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230144

From: Dmitry Baryshkov <lumag@kernel.org>

Inline the _setup_mixer_ops() function, it makes it easier to handle
different conditions involving LM configuration.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
index 81b56f066519a68c9e72f0b42df12652139ab83a..4f57cfca89bd3962e7e512952809db0300cb9baf 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c
@@ -144,20 +144,6 @@ static void dpu_hw_lm_setup_color3(struct dpu_hw_mixer *ctx,
 	DPU_REG_WRITE(c, LM_OP_MODE, op_mode);
 }
 
-static void _setup_mixer_ops(struct dpu_hw_lm_ops *ops,
-		unsigned long features)
-{
-	ops->setup_mixer_out = dpu_hw_lm_setup_out;
-	if (test_bit(DPU_MIXER_COMBINED_ALPHA, &features))
-		ops->setup_blend_config = dpu_hw_lm_setup_blend_config_combined_alpha;
-	else
-		ops->setup_blend_config = dpu_hw_lm_setup_blend_config;
-	ops->setup_alpha_out = dpu_hw_lm_setup_color3;
-	ops->setup_border_color = dpu_hw_lm_setup_border_color;
-	ops->setup_misr = dpu_hw_lm_setup_misr;
-	ops->collect_misr = dpu_hw_lm_collect_misr;
-}
-
 /**
  * dpu_hw_lm_init() - Initializes the mixer hw driver object.
  * should be called once before accessing every mixer.
@@ -186,7 +172,15 @@ struct dpu_hw_mixer *dpu_hw_lm_init(struct drm_device *dev,
 	/* Assign ops */
 	c->idx = cfg->id;
 	c->cap = cfg;
-	_setup_mixer_ops(&c->ops, c->cap->features);
+	c->ops.setup_mixer_out = dpu_hw_lm_setup_out;
+	if (test_bit(DPU_MIXER_COMBINED_ALPHA, &c->cap->features))
+		c->ops.setup_blend_config = dpu_hw_lm_setup_blend_config_combined_alpha;
+	else
+		c->ops.setup_blend_config = dpu_hw_lm_setup_blend_config;
+	c->ops.setup_alpha_out = dpu_hw_lm_setup_color3;
+	c->ops.setup_border_color = dpu_hw_lm_setup_border_color;
+	c->ops.setup_misr = dpu_hw_lm_setup_misr;
+	c->ops.collect_misr = dpu_hw_lm_collect_misr;
 
 	return c;
 }

-- 
2.39.5


