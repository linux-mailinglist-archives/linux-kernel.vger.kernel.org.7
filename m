Return-Path: <linux-kernel+bounces-778862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1802B2EC2C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F407BB7EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DCC2E9722;
	Thu, 21 Aug 2025 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GPtQrzy8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26222E7BDD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747457; cv=none; b=lw0YNGZ9GuDg+pmnpzsY/TRH+837FjY1qQVXT1cD/refkwjivtqypqlfh+NM8ONbCpw4TrvEf7qdcRujbZyOmGy2oKs9A1RFCPzkjhTbswG7oeFoE9AJnGCiif6ymijyWuAH41x6Ftyk16nGP9qhv74ZzBvB2p2AnF/xOYyelrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747457; c=relaxed/simple;
	bh=jmOF3YxLYSDfb8Ohpc4kXPJtA6m1LCaahphFup+ozoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQuH4cbacsRdOqu2GVmcFw7wHuEECqU8i20C7nwZy6Kw2UbSQ2i4oaoVT9lilirZw4Mz3/00sSLmLCaCLd1AA+rN4ToQKXdQyP9yMOJAFA44EPLdV4KLFlO5cpw4QFJQ9Hj2kwiNXiCbR0k3pTePsV/0claD6Z+x9VuGP6euNZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GPtQrzy8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KKF3O9010752
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s5H/bF7V+/uMeSq3g0gxgqc/EofmL6r/gf0PKGC0ccY=; b=GPtQrzy8TIOYTIc9
	Vc74+YztRre+8yF1n0QVmxru+2H6j0GHXcc6EKQv8BDktJXRJ6saZkvOgGIsuB31
	tsp9fmJB2Rlsx8TlE0L23A3wUVkAnvCDUfHMcLYx8QNPymDV0PI/vGePJ8Y1tERE
	fiVSRRVbvZYxMKmgX5jK/CoqqZ0JEBOuUPetF1KDNkJWqUROrbghNoN10UsOHyzz
	VG6kVgX3skmArO55dEouE78l/SyVmCIR8PETcGnf4CikN8EGMqLLAq5gwRBIVts8
	/a5BTcuXQ3bQtFRq1HZwQ+D3n7qL1J6fgP8K/PF1yfIzXd1PISvhFGyN84Xomyyb
	S8i0LA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528ut73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:37:34 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b471757dec5so1012413a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755747453; x=1756352253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5H/bF7V+/uMeSq3g0gxgqc/EofmL6r/gf0PKGC0ccY=;
        b=XkSdaTWl/5C5fgipPblWMJ7zvDxrvAnXC5vAKkdgwtJkFU9Ndu7ivXnStRQaCev3iY
         NBHbauoVtoMd6BPiT2zFWcla8bJ6Fm+cvXuae2OC6zuXbC1Zb7HuWRCUl3EywdIg+myA
         YM/86FDZth6mufsUxTUe1DHaypIkf4Z6HiMWnvRYEJGIWHhIvoJ+a1zBdsVJ5hCDvmcV
         0OrDJomZUFmbA8dh5RFTqcpT/SlDF4YtQAr/vUv7c8K10n+I77htruxy39ORWgvpLki/
         QjaPN6pMWvfe6vDMk0SOOrOj1vmvAwOY+fNbK577XL/BcK7K3ZeUNd+rIBcqSkhdBuPL
         6L7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgskHvhkWKhN/qiE193iP7T8Kg45jlHogxivTYhyD5ngz6Jw8y4arI8WBhjd7eVo2Tuxzn7ko8EeFlLIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOkK+pNyK3go3mMKkKf3f85nJ0bsILtETa7817NbohEkCpzr28
	3yq1SSAzzySK0i86JUBVlm3uqPwutG0YIgiMEi5JU5/5O0NeDctVWvKunSsXEa2pEe/BQqTfPvt
	Nn9XFo9PhEQ4lmhbXOEE5qmUby/XBq5UG3mPDGyMMdmKH7nYrlZ2HEbUvA5ohundxGBA=
X-Gm-Gg: ASbGncv68hc4wbWa0jG6hlO8bGadYBEQbrBJqeRxyq4mXBQbVLMIQEsAgbfiIEFs3Lt
	QN0Qg98Etg7868ALXF/jLc3P4g3ebrLeb1auWcX/mUGj5JbxyYJDNSfZ5ch/LMWxh0WAOOg2GBx
	A432iS8uEXyFUWbleIDgYQ49VJjjRHwDGhmar6liYizls//KINJLjo7NCmdUSggvdyovlhy+1Tg
	Ou/P9kuKiGORST2+S8+cqv2HSSjqmYq6CaWiAeohZlTz7f7CE6YKUbDZrhgl/eOHliI9D3uPW1u
	+z8X4yC1U3WCPuOxHDbYxXnYbwZWnrXvP17lnGZtKrdC3vJCRV8pwrTXEGu/d5mwoxD49II=
X-Received: by 2002:a05:6a20:7343:b0:240:6dc:9164 with SMTP id adf61e73a8af0-2433089e19dmr1159857637.15.1755747453475;
        Wed, 20 Aug 2025 20:37:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi4mGJZ5wAX9bpRLqAWGzqaPdfb8se3vOWiYgqadgqnAUMN/U4mRyTaYFAwyX37dTnizeIeA==
X-Received: by 2002:a05:6a20:7343:b0:240:6dc:9164 with SMTP id adf61e73a8af0-2433089e19dmr1159817637.15.1755747453048;
        Wed, 20 Aug 2025 20:37:33 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640b6554sm3497780a12.48.2025.08.20.20.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:37:32 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 11:36:01 +0800
Subject: [PATCH v8 6/6] drm/msm/dp: Add DisplayPort controller for QCS8300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-qcs8300_mdss-v8-6-e9be853938f9@oss.qualcomm.com>
References: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
In-Reply-To: <20250821-qcs8300_mdss-v8-0-e9be853938f9@oss.qualcomm.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755747404; l=1242;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=jmOF3YxLYSDfb8Ohpc4kXPJtA6m1LCaahphFup+ozoQ=;
 b=9nEXtJyTvuvPoQMKa9vJn8WmfjXRNxEFGH4TAyQUtRSsAGs8a/pirBy7epfxNHUOJ6F3AyD4s
 mxQRny+F73nB+a5BUu1ybLK0EPA9/GcvDWqt7ON6vzsbdDND+MNtPmS
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=I4c8hNgg c=1 sm=1 tr=0 ts=68a6947e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=E9mFum2VwHQHOKsBOicA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: arHOWEuY2xSzYgT-1epQ74skQ92_gMAx
X-Proofpoint-ORIG-GUID: arHOWEuY2xSzYgT-1epQ74skQ92_gMAx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX1GcJOU+vze6c
 iPBfHFPNhHwkUSRn7rOmcDFbZxBbJM3iOeajGFB5ejfte5T0/kBsF+s4torOATGAknKqmEteuv/
 m32Jn2Pu/NH95JD8xQI6q9t5PFNODYIru959bl5mYs8n1g3oqykH3KkZ6gUDybG2ur0iY+pelvC
 jgSyEdOEvBIyXJ/ydbCMwmE9PX1vzf2qQ6QojhF/QOToqK3zCincX1bbiGLQYT2oTA8i8Wg1LGV
 5iKRvyyeHryxIxlrWIeXEIrogtK5+s5XTrWQjE9rb6VFGFKfAskJ2mm9Fr5TI7rmTPoLeCaXHZL
 Np2HQEjfd0DxUrQAHtjcMuGP70urTx9vytj6fWbMohgrg4H5rdXR69ioRlDjjLpwAEJ34rTuVPu
 +mxq+x8SvCKQUpJY8XVXGidZxsHURw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

The Qualcomm QCS8300 platform comes with one DisplayPort controller
with same base offset as SM8650. But it requires new compatible string
because QCS8300 controller supports 4 MST streams. 4 MST streams will
be enabled as part of MST feature support. Currently, using SM8650 data
structure to enable SST on QCS8300.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d87d47cc7ec3eb757ac192c411000bc50b824c59..bb4660585849d1a67921a28e7e12422e0c327ab2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -187,6 +187,7 @@ static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
 };
 
 static const struct of_device_id msm_dp_dt_match[] = {
+	{ .compatible = "qcom,qcs8300-dp", .data = &msm_dp_desc_sm8650 },
 	{ .compatible = "qcom,sa8775p-dp", .data = &msm_dp_desc_sa8775p },
 	{ .compatible = "qcom,sc7180-dp", .data = &msm_dp_desc_sc7180 },
 	{ .compatible = "qcom,sc7280-dp", .data = &msm_dp_desc_sc7280 },

-- 
2.34.1


