Return-Path: <linux-kernel+bounces-866428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC087BFFBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB1C94E7351
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A266A2E2EEF;
	Thu, 23 Oct 2025 07:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WXHjepf5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2C22E0B5F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206140; cv=none; b=MWQBmtrRo7b1CmdT0gsIEnn+UTFcCWCX3IjVe4czVjn+JtFJkxIm7R0Uh0AZKpuvGYvyLUpWyPK3RvhE3o8LCkT2N/5VOGX5VRkOwKzSjS2NiNPC2AQ4xPMzAzQ/ZBfIT874wcZ8qTUTVc96jzTJsnpCdlOjwQ4BLuP/J+IeENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206140; c=relaxed/simple;
	bh=8rdmNQAo9Bd+9bAr+NPJwM1gYXFJ8g2yQPEWjrxSiZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OnjWSdYyjUgIqkfxUD3wRDiXT8LEc8J/LAwlOMsk9DXLNwyBkXGwap8AhXHzp2YsOZgHu7ivino3HLmEGkTX1PuHgCRltjQOAqL72imBIOxGR+Me3cEC2blQ1Jo3F7PQ+5dK15AtU9FabQhjoIWOVifH/WampmVv4V6mBbEGcec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WXHjepf5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6dfV0000663
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=w2fC93DLUlG
	GbUXGQjHhV8DdpBbQi0xLHsTL8o67LJ4=; b=WXHjepf5MYu5cijtLVVBVnTLOW0
	byGMo+foJtSjR30FlSqtQli1zp9opvPqeV2Y4E4KXpRvOdiuB05i6KenLguS3Aam
	xdK8BY5Worl/S4qTrfpd56v3PzLukhHL++qUa+DMs8+uayfUwbcsCb2SOnymMHFo
	1+rGKCfp8+ofdFf8uGZXvrCFtvoA65Gt5sf7V172DEF3WWQGzwud9eoBgxJ4GfNJ
	5wM1mBfikEc6m70E5vFUvemDiGRxH/7BVMVD8FHcTeBasz2WEVoHZisveWNSHxv1
	CLIoTAtAp7aY4gCA9b4WDkD2lzC6tBMAdtzfDRVU6F3g3ao2ZDTHmdyrhXw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49w08wd5xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:55:38 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-290bd7c835dso5584235ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 00:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206137; x=1761810937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2fC93DLUlGGbUXGQjHhV8DdpBbQi0xLHsTL8o67LJ4=;
        b=VwZRr3h/t7sHGMUTfLZH/dVSdEyiwwPiCpb36qVNplyRuDj70Ec9VRoEDMg1u0xMYi
         jxrA+SrmOd0YV0ZqNR4X9Y4kfvx0tfq/3LSHJgWxPDO1v7AmAT4LdE/W5Jen76vZtWGM
         ni17XRhGAABzlWWGwGLDUB0XBufCo8dgLd90wSQI5NJFRyD/HrGLCfZA1hJQ1wV2v77U
         RIWPD0YV27ogTwZa6Hxgykpw4k3csdocL+ZqC32QPXMqQRs0fY7BQrrX+uPsuob2QAs/
         wvTe52IVMDWx96WFy4V5DOWuw/hazwigg5bd3PVopXVEyKJJnf48Lth4AvR3limhAHJi
         r7VA==
X-Forwarded-Encrypted: i=1; AJvYcCVROReAByCl4fv0T1RtY/cUJrDNBlFDpKuDPeN7jAQhmRfUJzcXsoAgFVXW9ft1pckBt+OTWOB5ucgvwL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNIw366hk0gm39oR9v7RelbSyDMjnC6LHkVL2OfH0LFLmCsb/Y
	GRijYld/7h++hpon1fQJIyiECQ+S5dOieDHPAt9n8s/5ecYqOz5Iy3NOCwAgoNthsQYTdHlhTBW
	Nz5SDfJCRRzCo5KXnQULRM3j/tvt6VJRD7aovS+BEolIdHrgpuJdsmzolqycEFMuD/ns=
X-Gm-Gg: ASbGncvE5vlU19LryESKZ33Zg/rzpSF90ukFrk10eyr4PzvFDXJz36DEJ3rHBDnWqid
	iN7hhJ6hCcy7EZT/JpPCylNxYZo+6RvOHqjoCCtRRAc3qjjBS7XqsZiC6Dp+KI5Nccuz+AIGjxk
	zeVE/y52fuVuAxaIvG6UCm5ka2YqYDedjBcdglnC5ZTQAysGsPIO5bADdsry4v4ZxI8TN4IBodK
	82nC8MbH2HxG3gsI3jxayTnGM99R8VdrmNJAwKRXQ8dUKYlI/ZsxrlD1rzdXZJK2xz6bnXcS+P8
	WLawxOf7MoFzkRtNoS9f7bUQhZGjnbiHnE8CkZZO0dkGSZgcPOY/iHKGKKAuuWwuA8WCHyRJQzm
	WQrzCe5peA5T5VrIP1HAQ4XjtcUsowqJXKy6fhJ1uu4EMUpONMw==
X-Received: by 2002:a17:903:2310:b0:28e:7841:d437 with SMTP id d9443c01a7336-290ca121206mr291270645ad.38.1761206137447;
        Thu, 23 Oct 2025 00:55:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH682hkGWt3dvBEItqoe9UCqS26mzJjNqbQjGPbVOBXOGQ063Q1XYvwVWIAZvw9Ki9Hjwp2hA==
X-Received: by 2002:a17:903:2310:b0:28e:7841:d437 with SMTP id d9443c01a7336-290ca121206mr291270225ad.38.1761206136943;
        Thu, 23 Oct 2025 00:55:36 -0700 (PDT)
Received: from yuanjiey.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e1231b0sm14371265ad.97.2025.10.23.00.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 00:55:36 -0700 (PDT)
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
Subject: [PATCH 05/12] drm/msm/dsi: Add support for Kaanapali
Date: Thu, 23 Oct 2025 15:53:54 +0800
Message-Id: <20251023075401.1148-6-yuanjie.yang@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: -wYiI8aScv4-JBlJ4sLY3jeVlCmODBTV
X-Proofpoint-GUID: -wYiI8aScv4-JBlJ4sLY3jeVlCmODBTV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE5MDA5MCBTYWx0ZWRfX/ZW/k/DPpUL2
 gxTWp4dGzIxLJYL0Do6tq8blr4s2+QZ6YEyL1w2cjmOD4enZ/sAFbdONAM3/Fh2LL0klZ9UP9WN
 BcNScgLIwxKdMyND8DWKmaHymRra4TiQaaR/nn5Q7WELRin476EZkXKrbNOXY9AHRugbaAR8bUo
 8JmsOTs8AO5x5DsaI6sA1PnVMqdcm/uESKMoEX6bIsliOxS/FksooUgCuCntd9FzxCh6HQ8KcEw
 f7DA3dhG1hZWJ32nvmvK16Kru1eFvUCENjRV2GZ5hmM8rFM8ahu0q3xR3d7pENiF91uby87/zAJ
 GrzxdrsD9DArKSucTuJRddXyrk46GoDJJHZDoQBkIMGpo2A5PfAPfVmElGWGdck+ou+IV/xfpww
 hI24UaDflIc2ICJeH5I5Aq3fJIGt2Q==
X-Authority-Analysis: v=2.4 cv=V5NwEOni c=1 sm=1 tr=0 ts=68f9df7a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=EGddA7oXPexY6v9tJfMA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510190090

From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

Add DSI Controller version 2.10.0 support for DSI on Qualcomm
Kaanapali SoC.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dsi/dsi_cfg.c | 13 +++++++++++++
 drivers/gpu/drm/msm/dsi/dsi_cfg.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index fed8e9b67011..bd3c51c350e7 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -205,6 +205,17 @@ static const struct msm_dsi_config sm8650_dsi_cfg = {
 	},
 };
 
+static const struct msm_dsi_config kaanapali_dsi_cfg = {
+	.io_offset = DSI_6G_REG_SHIFT,
+	.regulator_data = sm8650_dsi_regulators,
+	.num_regulators = ARRAY_SIZE(sm8650_dsi_regulators),
+	.bus_clk_names = dsi_v2_4_clk_names,
+	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
+	.io_start = {
+		{ 0x9ac0000, 0x9ac3000 },
+	},
+};
+
 static const struct regulator_bulk_data sc7280_dsi_regulators[] = {
 	{ .supply = "vdda", .init_load_uA = 8350 },	/* 1.2 V */
 	{ .supply = "refgen" },
@@ -332,6 +343,8 @@ static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
 		&sm8650_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_9_0,
 		&sm8650_dsi_cfg, &msm_dsi_6g_v2_9_host_ops},
+	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_10_0,
+		&kaanapali_dsi_cfg, &msm_dsi_6g_v2_9_host_ops},
 };
 
 const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor)
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
index 38f303f2ed04..5dc812028bd5 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -32,6 +32,7 @@
 #define MSM_DSI_6G_VER_MINOR_V2_7_0	0x20070000
 #define MSM_DSI_6G_VER_MINOR_V2_8_0	0x20080000
 #define MSM_DSI_6G_VER_MINOR_V2_9_0	0x20090000
+#define MSM_DSI_6G_VER_MINOR_V2_10_0	0x200a0000
 
 #define MSM_DSI_V2_VER_MINOR_8064	0x0
 
-- 
2.34.1


