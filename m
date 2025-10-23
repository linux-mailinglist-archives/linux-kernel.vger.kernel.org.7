Return-Path: <linux-kernel+bounces-866426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2824BFFBC7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A51A00CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E662DE70C;
	Thu, 23 Oct 2025 07:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SeSnbzm3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC7F2DEA79
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206133; cv=none; b=PYgRVRr48KqnLukYSwL4hzuW1DlmEb2L4aOYzWQERCPwOZYUB1rG6M8ehqsMM+DyKyFL7mQmAruYKddfp45aP4JNU4rLCgv0awf9ejsHwqqcXhALQebl0R2S9r33k+cpHL1qR6exPZNAHMoVusgP3B5YD3QY7+oTEKDv5QpCYyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206133; c=relaxed/simple;
	bh=JEWdZx+uwzrMx0vf6tzTqtOibYqpos0ApsjBKoz9X/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIWzKbb+ugozjGoKWAmvfTifEQRaWmE64/wWEjGvQJeikU76ez3pglg4MqbzwepCAaxWiH1SHNuVrkpzfjBhXXm2aT6BB3XBCJH9P3erNbDR1z2SNWWnGgrM/nEqQOtNgJ5+k35EjJ/FN9mg9GwmaOvFkRSf0qn6QGCyo1o2fms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SeSnbzm3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MKLSZY019075
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lOK2MHSzPbs
	iXffQZgfe3h7iHMKpferDHyC/TWrrCWc=; b=SeSnbzm3H/cw2/2r7DRnoRK4Fca
	8wMZ/x7Yn5bTTaQWB6FSKnvPEpQOe8975TE27FxJWBo6M7wty50N6dzKGmcv8ZGp
	lcyTCnVlYqSztuojTYb3TkboI20wlbPyHUffR2P1l4+7vaiKFSzNyvYls7liJy8P
	EaxgNdE6ANqb0dX+QZdu0Ck0K/LS2TdoASmlhts4SsTjKae5US6wR2BvPKBG1RQC
	iOoEkScnuv6C/yQ3+VxkxO6JhKKsTpxXDU9r+f5PrJBro2XuHleA99tRgx/ycs7V
	u5oP/SuNDE8OmO7Eb8IZTXl0NVfmkHTat05ViJyWVSAUmgUtmoW09Tgfv1g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49y67qhfuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:55:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290ab8f5af6so3798275ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206129; x=1761810929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOK2MHSzPbsiXffQZgfe3h7iHMKpferDHyC/TWrrCWc=;
        b=A4XvFlXHHOEV4YEpLPEGWFY+lnaOU0faKv1+t0MOGMe5hWkRWAkUDAqiJnDFrYLyQb
         SrTPQljcwHRmtLv4isWpgUc8ZbWYgRIbJXOhfoPSXriuORV5QqeVsgYNQnph4zTEXibW
         eIhBEMn83cChZON8CW715RpBRA49sq3fdJmehW+7CsDkQdXzQXwOe4kh897PzdKvw2i+
         0o22yDsjAICv2SYdczUuBfB+tNzcK1B/uX9zCNhn/Tzg2gQQBl1bBh2yQjMI/byGn86y
         2cRVYiybHQfhIj4cSvStiHUvy3Jw5qG+x/zKJ4Fw2I91uarRi16Lhxu6DORXH/QgDl7F
         tE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoQf5kY/jkADKr7O7dhZGF1RQBdvUbOaHxP9hP7HV/XwHmZ6foK0OOT7tRbCRx7rGQwwNh40xOwCsanLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/tXmmR7aK4NLjhOH8684vS4A9KNnKgA9TmhZeTbDFDQjidvfV
	YOde2zLogl4xSPO1W1bdgLpx6ccHCsOT/W5ds1CVmuDr6atn1uYsbXcf/B+U0v+DCZ6BRTKKa+B
	tYFkxAKO8GRnBHGP4jKqr2dO6rVLECGrHj339yhb5ANzKdbJn3l2+Dx76WHL3J3Sg5yY=
X-Gm-Gg: ASbGncvUUl+TpQ0Yq7uWRlOReZIj+yLrf8W6tBcRrNuAW9WMdv4q68EbHwTAXSO5PHS
	fm0Fj5ds3sYYtiImpjbWm0cPDRCSM5dgJLbExb4mri49XZarZxLMpSP/t4ZVnP9GJU5tbubSkl3
	Dos8k0PY2N0sFtHzV0xUABfAg6XGhJSvMRGHd6J5s6YjjpWE8Wc9k6kVB26nohl13ev4w3XPYid
	l4dp1C7fHgK00V5YvAonXQqnPAvMm1IVASKBs9qSSYBkcFlHEWh4AMg0KGDbXatYtFyHF6WIEC+
	g578Qu0nXNc4hPTfUmtJchhOzynSuZmU67ikNFmkT/Ym0tOhYWOTYkraxEWxbAIkPUXXhYVVB72
	wooLZmsjO+cTeCddLeSUU8mxsBZ0+zd3yyWj5Jrt2DwaxAP/MFA==
X-Received: by 2002:a17:902:ef4d:b0:269:8f0c:4d86 with SMTP id d9443c01a7336-290cb66049dmr319783485ad.53.1761206129516;
        Thu, 23 Oct 2025 00:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0QuIZ+LuMNR8q0/YAebLqe1CyU54eHt5XXlt5BpEpKdtKF5ztAJWGBj2FwTltk88GyCTZ8A==
X-Received: by 2002:a17:902:ef4d:b0:269:8f0c:4d86 with SMTP id d9443c01a7336-290cb66049dmr319783175ad.53.1761206129026;
        Thu, 23 Oct 2025 00:55:29 -0700 (PDT)
Received: from yuanjiey.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1231b0sm14371265ad.97.2025.10.23.00.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:55:28 -0700 (PDT)
From: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: [PATCH 04/12] drm/msm/mdss: Add support for Kaanapali
Date: Thu, 23 Oct 2025 15:53:53 +0800
Message-Id: <20251023075401.1148-5-yuanjie.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDE2OCBTYWx0ZWRfX6smnvuhztoSw
 2djLFQsdDH2bVt0xEbEuUC57PLa4KCp9EZWbaNg5sC/6kYzGqtfyHghjmKXYCi5hTRpe5loWsFY
 VR7VFtuVWkg5/0IPlSfC3UBAIErVFI+3mwFY8i+38T2Bh1YWEwm6zhK+FAve32mMJL4a/RYj3m8
 I5+ByiP4nXeHoWNC52avOylLRJo+Z0dlg0/G/zmSctk2wx6bS2cpPaVmBXbIRm8VmULeILrEq2o
 5HtFwOtmOSzJBlV0vxlRJIcuK+Aaw4BViZOnW3RMlx/kujFSnqNnpMuuw4DctbQp8ZjxUa5VaXu
 ym7rKH5S3NnKoKTRVLlAXpuIH3Ofp9PALF/xTe+XHhAAxFeWRH0PuQy7I5RHCSGMwvilvPsMV9r
 shHYcnsBecAiw7wm3M4Ajspuz9wGmQ==
X-Authority-Analysis: v=2.4 cv=LMRrgZW9 c=1 sm=1 tr=0 ts=68f9df72 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=fceNRhxQrX_EhRTcvHUA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: aCQWOJDPkGyhfYzJRQm9GljvX6ZRwOci
X-Proofpoint-ORIG-GUID: aCQWOJDPkGyhfYzJRQm9GljvX6ZRwOci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510220168

From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

Add mdss support for the Qualcomm Kaanapali platform.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 22 ++++++++++++++++++++++
 include/linux/soc/qcom/ubwc.h  |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 2d0e3e784c04..665751d2b999 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -243,6 +243,24 @@ static void msm_mdss_setup_ubwc_dec_50(struct msm_mdss *msm_mdss)
 	writel_relaxed(1, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
 }
 
+static void msm_mdss_setup_ubwc_dec_60(struct msm_mdss *msm_mdss)
+{
+	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
+		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit);
+
+	if (data->ubwc_bank_spread)
+		value |= MDSS_UBWC_STATIC_UBWC_BANK_SPREAD;
+
+	if (data->macrotile_mode)
+		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
+
+	writel_relaxed(value, msm_mdss->mmio + REG_MDSS_UBWC_STATIC);
+
+	writel_relaxed(5, msm_mdss->mmio + REG_MDSS_UBWC_CTRL_2);
+	writel_relaxed(1, msm_mdss->mmio + REG_MDSS_UBWC_PREDICTION_MODE);
+}
+
 static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 {
 	int ret, i;
@@ -296,6 +314,9 @@ static int msm_mdss_enable(struct msm_mdss *msm_mdss)
 	case UBWC_5_0:
 		msm_mdss_setup_ubwc_dec_50(msm_mdss);
 		break;
+	case UBWC_6_0:
+		msm_mdss_setup_ubwc_dec_60(msm_mdss);
+		break;
 	default:
 		dev_err(msm_mdss->dev, "Unsupported UBWC decoder version %x\n",
 			msm_mdss->mdss_data->ubwc_dec_version);
@@ -552,6 +573,7 @@ static const struct msm_mdss_data data_153k6 = {
 };
 
 static const struct of_device_id mdss_dt_match[] = {
+	{ .compatible = "qcom,kaanapali-mdss", .data = &data_57k },
 	{ .compatible = "qcom,mdss", .data = &data_153k6 },
 	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,qcm2290-mdss", .data = &data_76k8 },
diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 1ed8b1b16bc9..0a4edfe3d96d 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -52,6 +52,7 @@ struct qcom_ubwc_cfg_data {
 #define UBWC_4_0 0x40000000
 #define UBWC_4_3 0x40030000
 #define UBWC_5_0 0x50000000
+#define UBWC_6_0 0x60000000
 
 #if IS_ENABLED(CONFIG_QCOM_UBWC_CONFIG)
 const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void);
-- 
2.34.1


