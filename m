Return-Path: <linux-kernel+bounces-866423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C89BFFBA6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EFB818925F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9DB2DCBF3;
	Thu, 23 Oct 2025 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UCqh9su+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C432DE6E3
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206109; cv=none; b=ZZHyufjH/nkv31aVL+7PLj6dhMZC6vtz/RFHKpSpg6XEW/XvrEqyAR6+sWuCCVmWRr2ZbquNvS/498nZtAUHcXetj2HD0HVFg3xoNmwXrTlRttJ094r17WK6KRZxD8/RHfOkKvsUz7PhxHT3E6r46Wnvt918lTbqbL6nfS0J7ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206109; c=relaxed/simple;
	bh=dLQWeX36WOw1tGMGQWa7Z/3xkwcHtkl603TdrHkHt/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aduB4Vv2P+okaWJt1/7lUwfO2Q4vMggZ8EHwFjLh7v/e4681TwfhrfNga8uVPYiB3FxIvvs6OhkRsep3Rt6y3M/qmpHkriyYy1Rh8+wH5Ni1eZ8QhbN8hLU4LCSbUlVJd+ErvP30GcNAiOz555c9UN+bJXEbukQmSvbtJnm9k3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UCqh9su+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6ttLA007459
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hxn7ShIYBtn
	ywIoj5z7bF8woB+YQ7/3kOpn9agNkuO0=; b=UCqh9su+0S8vwPc2G3kzO6ABdEI
	zGLJGtTbs6TcQjhPdV99Td6N6bWhLg8qCAWg3Jzi2E+eYAf420vl5e8xoQlQnxxJ
	IN0iTZr1SWzsSxjmh1/Ro+7TgiXgng3H0RUag+C34IO8/33lD0dedWxqt8Fk3WjK
	DxvcPZyi6tFE2iilFJ5vPW6IWKt5tsCpXuQ+WVOmD+8prh5Lpp2tHbjfHExuuR1s
	jhBwFrU24+A8em7FaumQVDbcxn5xuqF5C32HGrkPHKwVIF+k/02KnkCekIcOhCfd
	sv1XknS6jGMVIOs+s+QGY96+OHSpHB2U054ncfd3POAiEQysDkr0Ds1DmKQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v3447k32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:55:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28c58e009d1so14338035ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206104; x=1761810904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxn7ShIYBtnywIoj5z7bF8woB+YQ7/3kOpn9agNkuO0=;
        b=h6oHD2Gue9v8/YLpNUxSxEwIzmEC4yaJwcl0AQi/lSH4wSEWfli2jn+5LzUI6oeTCr
         fsq4iSxJi6VZBCNfCJAL14PN1JWHSChRohoqMoH+u2vUPZkBiYWVVOwLdj276+niu6Je
         2gz948Yj8t0MueiQt8R5j/n2/ZJBlfZtuPst6K51f3hoo7ICAjMqPCvS/A+nbDB3Zpph
         sxdaJbShQ41GRpJB15qR7Cu8h1RoMmoy35b6EFOjoEaSJvUTJZ2Xp83/s7U1rSg03U44
         /fP1RyQNoE2F6L/JNn5Dmi6R0PTmCLOgxoPU5bbeuN7M9HbymFnZXF5Bzih/9HI0naGp
         h72g==
X-Forwarded-Encrypted: i=1; AJvYcCVvc+TpQU3rYxAFpb/DUJSUf75iYFU9/MTR+XtVSUdzH4RvivRevKepukt7ibZXj/5EP5NKwUrLHBiTkkE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Gim3WYbF1bJQjRu2a8O+7ABB1Hp8hIdF+UAPKShpmSkwYHu9
	hZZ9XaNNtzLBQOd3jEVNP+KysyXdVIUWOh/ouVypbDtMPEMzSOv3yZDYYQSTjJM7xCYHjvnOVSJ
	FgsBJaatVmOIgsqLCyUYJJ3ktDk6qIxaOFT/ph4Lwuq796axvjKvCrJDNMjqjh/y05vI=
X-Gm-Gg: ASbGncvMYk1kKVUQB6wPA3asolcDLCpEsLBeybKOcwdqQEXSVd5ryZlb/SUAxb9ak0z
	HN5v4cZ8kyCyt3B4W31OfsnxUv0EqTkYaK1HseycQPdwl1JcpeEyIJPBXOzmhhZOybZI/5LZqJ1
	s8jFawcOoSjwFfweOkiGDesHlkNDxZc042iEbxCn3LhVmGA813TwxkKCiYtVohBo8t+Nn9ED7fC
	dWMUI7WaFV5j1gv5Sh558hI1DntPF8EQaRWBaw85r2IC8S1XQAbSXL77GASjWpV7OgZSGnZcATf
	JwKSJy73yCPuSSVj+uX7foSZXvjUyO1ZBRtOn1sOwjDRXHZQdNoB9u19cjw/Mu6QrtE/hY8sHu3
	zVZVseee9f0XilvxkSH9iQJmtByWeIOVCxjFOTSXu17V07HMtVg==
X-Received: by 2002:a17:903:98f:b0:277:3488:787e with SMTP id d9443c01a7336-290c9cf8e7fmr298783775ad.12.1761206104356;
        Thu, 23 Oct 2025 00:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbPua/PqYedRnSX1LyIiA33Ruaseb4k4MVB5/62weZo4u2AYpakMUmfxzI5Qq0e4u2523ZLA==
X-Received: by 2002:a17:903:98f:b0:277:3488:787e with SMTP id d9443c01a7336-290c9cf8e7fmr298783445ad.12.1761206103942;
        Thu, 23 Oct 2025 00:55:03 -0700 (PDT)
Received: from yuanjiey.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1231b0sm14371265ad.97.2025.10.23.00.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:55:03 -0700 (PDT)
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
Subject: [PATCH 01/12] drm/msm/dsi/phy: Add support for Kaanapali
Date: Thu, 23 Oct 2025 15:53:50 +0800
Message-Id: <20251023075401.1148-2-yuanjie.yang@oss.qualcomm.com>
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
X-Proofpoint-GUID: UNp2InZvgH1JmRfYhN3hKExdna2nUmSp
X-Proofpoint-ORIG-GUID: UNp2InZvgH1JmRfYhN3hKExdna2nUmSp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX9re5xZstvIme
 5wNPzS7QWZ5WrwDqnsmtllV1JTYH+PpsrtuedadClxfF56zb5RU0HEXD5jKPdqeE2rps5kXGoYu
 lIfSdZdZekAfuKp3eRor+U5Y+OnqJv/X2ZISxt1nh0UFdUiL8JNBGv9rTsS6pvhmdxCwlsG3MNQ
 yyzB5we2YAOdJCmTo2z4KKvYKV+Gcuj5glgzvUBtE7Uiv4xK2oUt49Gni6L++MwOnaWRVfS9PGZ
 xiD98pH8WTXE4EzO7RclIIVgCD/tYc6fFVHKfUTXCaHvB1uVMn+iNiMN/duta15/Ugzrq/r0bXU
 aI4XR9l7y2/XEi3+bxybUWtCphK97ZnewJJW56OJlT9XPCyiWoHuAb5ZzenfaILDsNgXeDi5nMT
 6sKz+RtyWyLptKPKyi1zY8a+KGonkA==
X-Authority-Analysis: v=2.4 cv=E/vAZKdl c=1 sm=1 tr=0 ts=68f9df59 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=B1tu1MuE3RNTBmX3WhkA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180023

From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

Add DSI PHY support for the Kaanapali platform.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |  2 ++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 23 +++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index 4ea681130dba..7937266de1d2 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -577,6 +577,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
 	  .data = &dsi_phy_4nm_8650_cfgs },
 	{ .compatible = "qcom,sm8750-dsi-phy-3nm",
 	  .data = &dsi_phy_3nm_8750_cfgs },
+	{ .compatible = "qcom,kaanapali-dsi-phy-3nm",
+	  .data = &dsi_phy_3nm_kaanapali_cfgs },
 #endif
 	{}
 };
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
index e391505fdaf0..8df37ea50f92 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
@@ -64,6 +64,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_5nm_sar2130p_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8650_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_3nm_8750_cfgs;
+extern const struct msm_dsi_phy_cfg dsi_phy_3nm_kaanapali_cfgs;
 
 struct msm_dsi_dphy_timing {
 	u32 clk_zero;
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 32f06edd21a9..93e53fb8b4fa 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -1518,3 +1518,26 @@ const struct msm_dsi_phy_cfg dsi_phy_3nm_8750_cfgs = {
 	.num_dsi_phy = 2,
 	.quirks = DSI_PHY_7NM_QUIRK_V7_0,
 };
+
+const struct msm_dsi_phy_cfg dsi_phy_3nm_kaanapali_cfgs = {
+	.has_phy_lane = true,
+	.regulator_data = dsi_phy_7nm_98000uA_regulators,
+	.num_regulators = ARRAY_SIZE(dsi_phy_7nm_98000uA_regulators),
+	.ops = {
+		.enable = dsi_7nm_phy_enable,
+		.disable = dsi_7nm_phy_disable,
+		.pll_init = dsi_pll_7nm_init,
+		.save_pll_state = dsi_7nm_pll_save_state,
+		.restore_pll_state = dsi_7nm_pll_restore_state,
+		.set_continuous_clock = dsi_7nm_set_continuous_clock,
+	},
+	.min_pll_rate = 600000000UL,
+#ifdef CONFIG_64BIT
+	.max_pll_rate = 5000000000UL,
+#else
+	.max_pll_rate = ULONG_MAX,
+#endif
+	.io_start = { 0x9ac1000, 0xae97000 },
+	.num_dsi_phy = 2,
+	.quirks = DSI_PHY_7NM_QUIRK_V7_0,
+};
-- 
2.34.1


