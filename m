Return-Path: <linux-kernel+bounces-811933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B9FB53046
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 13:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1788C3BF23E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC0B31A57F;
	Thu, 11 Sep 2025 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="etRA6v05"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795731DD92
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589883; cv=none; b=N0nam/r5LgNyly9p+4ZMkRhN4+Pz2TBMC6+daGXQyF31IEhg8TJiG+nY99srLZBl/PFisFcra4Xab71ypvW8qo8Giqrx4PiGesp/F0xJqSEsvIHlVJ6BnHK7a1FTD85oMwgbueVm5dlW8Wg1d9qbAhDc8WtfnWU7JJX+7fwnyEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589883; c=relaxed/simple;
	bh=FEUevD/Bir/UEqCMgp3K3Th3lwTSdx1DDp6SRzW1JOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTr4pl7Twmax4dDF4DSTEeUfxMCz8LiHlqV9QCy6GXPuNRRuotCphyNNrOa0AEHKLFZp6BT5IBboxqw5bTQtaxp7khQCFArd0X5b1oDdZC+4M3NIVdFR350iOyF6W0Vk8dayOwxr8Yb/xMRMq5MeQLtNkWfUnQhUIf4tjEWfB44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=etRA6v05; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BBDSSn015939
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sPoNsm7+PfZj4+jNLDfDUvmKCs26wErm+BDKGeJyvf4=; b=etRA6v05WeY0gSV1
	AAGw3riumuoDZwva/V+yCG332jRGagJmA4AgeLpwLY563RooGGZ1XuNz8HUmeJeI
	0UoVxqnGG69PnFQgn7yXxrzpO44azNFFeMW3uMAED5FvVX0hi/mV5yy6o3cNkpcN
	w4pnvyC4eEYc4FQnw0QxHaCNVMOXIVnPlujc455XJL2o912sWcBBAHmJGOVvs42J
	nNa6J7t0cf6JYtYwyDURzqfuOz6xhKvrdCUeLh6qeb1kaJxGrDBZI6fBpVesv27Y
	PSHe0daUdZ8584T3TA+P1PEQVtpbPCtjmZk9k4OihnU7usNSXzUhVH69bJ/rLI7B
	IyZTgQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4m78wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:24:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24b0e137484so5802875ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589880; x=1758194680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPoNsm7+PfZj4+jNLDfDUvmKCs26wErm+BDKGeJyvf4=;
        b=qh+hYeOmbpDNgAdP8533Te6WUgkN2tA+XIw5KiFnJ2CA0GzESFAf2WKqU+96dwhYqB
         eZfMqDTHniIBTShDsTU37k/DZTIaTKU3pZcGL187rPlJIV19bKLQqbLFkUAhaG9gwQCf
         6SFEn0e9KQvbXtIxki62P+TNmKdViY/FU/ScuOshnGuFIgkjNoCNk/ANexbEqNWpMybs
         AxA7MpijuF4tHThg5s2XMhd49vaaiqzZyya25r1MjNrmxdTM1nmrUBw8wiw3KES5LjRh
         WkYOGJuokCwUdWDSA/azY6phUdWDjyoFeOCFkcFbFjOK7+UnKi8JlI+eOMgyc13zrCy/
         abUg==
X-Forwarded-Encrypted: i=1; AJvYcCUESd8xG7hzriszTd5sp3HDMVhAy5h9ZbQ1ZYTHY2vo+1gHwlccYacw+WVMc4UOsvaItjz0ug1tIorPOtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6GdpEdoip/WwTi68hwu+v3HTHMbcY7bSMHTj5fQUHyUSZtvGK
	kPdc/uL3mVuMWtXy9OA3GgcbL+q68ypphu9nXgPcNpanzRnHjVYDqRtIzx8ZzBBfdnfaH9A3HfC
	ZTOf5lKMTqw0lyODpeVHLLpDv2/kneGeHOG/p4mDtGIl3K1hnXN/jHwCpS7nMgIIzFhE=
X-Gm-Gg: ASbGnctuFrN3/t9w3Sn8Ui55BKmlF9q0pno+pi0xFxveYey6hpufiZUlJJGxIVYXD1P
	xAKbUZhfPItHooa+rmSUysN6PX/Oy+bfc2ky8KrBHE9yCUfip4dqd6hkOLf+rc29gMHrNJ+99f1
	LQdcEvtBr3S3PiIYOJHqt3f1THxTOp2F8cmP/OVSUaAkSQ187Q6pDbOZrEb1XRvFt0PipEyZn2s
	hg1jqbCUlXQlnM0k5eeHdOFI1eotb6SeV5O/l1MxlcNqYe0lSAMIzOHCGo0yQTtuK/+xsut4Hno
	vQ9+63a0364sxzUqNj9J3YHMLvp3HVJHMqN8pTsx0T0UymFOcNCTyvWT1rjzPDDvqLBUdrAxc94
	TNWbg8QomuP84Z7fsHy72lbpdijpxYlTq
X-Received: by 2002:a17:902:ec8f:b0:240:9dd8:219b with SMTP id d9443c01a7336-251737d3ae0mr251493755ad.49.1757589880214;
        Thu, 11 Sep 2025 04:24:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVej9XvECHnfJ2giLr8gHJUx8kOwiI628UxF466o3mzUJFirfad/bnLhSvmHcgicqE/EARkQ==
X-Received: by 2002:a17:902:ec8f:b0:240:9dd8:219b with SMTP id d9443c01a7336-251737d3ae0mr251493285ad.49.1757589879637;
        Thu, 11 Sep 2025 04:24:39 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37294b17sm17005365ad.40.2025.09.11.04.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 04:24:39 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 11 Sep 2025 19:24:04 +0800
Subject: [PATCH v12 4/5] soc: qcom: ubwc: Add QCS8300 UBWC cfg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-qcs8300_mdss-v12-4-5f7d076e2b81@oss.qualcomm.com>
References: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
In-Reply-To: <20250911-qcs8300_mdss-v12-0-5f7d076e2b81@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757589847; l=1133;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=FEUevD/Bir/UEqCMgp3K3Th3lwTSdx1DDp6SRzW1JOU=;
 b=lwy7m2h+u6LYki4ZBIiHe1vbQcfyvBfzCTgg7t+cwNsq18RqfOCaBQmsaMuuol5n/cguidvXZ
 XJ/cgV2mfRAAaS/OKzigEqVCv9kz/eEdFiKFaNFufM/k6rR1v1W/tSL
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX8I9a4hUUc4D4
 v13+fOmC/OYkyYs3RDnDZklO5IQPHOpqzR7NyUkz/BWAoz+mWPqLRWhJZ0KH+byoWw6tMcDEwYi
 cg80CdKM18ydO1SnN2MmTatOsETGPhD2FEmJAhuAkCEhv1xlTK6chRq1cuqFl2b60y4G9RA49s3
 h/r1+NwQ7kSJWGRGpyqxnWkO+qf5Ys0h90hsHU8fP3dIu9h3E6GvVhFIh+bJCcRDj2+pgIAEF9T
 au3uKdbJkW1e0WsYD+TfaCinVFC5VeoVAX3LFXkMPUW9541HWPoyFuhxH39IWhcDGAUiiBCGpmR
 CPjfj+X5pPVBF8KFirU46BTfxpEcel859b0ORMkdlpX3M3k5qCYVqETSHE69mw1b+TJ8U55GbOy
 5ls5ZO6A
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68c2b179 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=yyC0Gtz2zuuxwh5CSaYA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: -Vu6OLYfoHvH3pxAXhcnvlLSvz3AU83Z
X-Proofpoint-ORIG-GUID: -Vu6OLYfoHvH3pxAXhcnvlLSvz3AU83Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

The QCS8300 supports UBWC 4.0 and 4 channels LP5 memory interface. Use
the SC8280XP data structure for QCS8300 according to the specification.

Acked-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 1490a7f63767..b70627d40dc4 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -236,6 +236,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,msm8998", .data = &msm8998_data },
 	{ .compatible = "qcom,qcm2290", .data = &qcm2290_data, },
 	{ .compatible = "qcom,qcm6490", .data = &sc7280_data, },
+	{ .compatible = "qcom,qcs8300", .data = &sc8280xp_data, },
 	{ .compatible = "qcom,sa8155p", .data = &sm8150_data, },
 	{ .compatible = "qcom,sa8540p", .data = &sc8280xp_data, },
 	{ .compatible = "qcom,sa8775p", .data = &sa8775p_data, },

-- 
2.43.0


