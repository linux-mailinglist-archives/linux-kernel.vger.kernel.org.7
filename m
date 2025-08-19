Return-Path: <linux-kernel+bounces-774797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C26B2B7A8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21DD4E41DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BBC2E22B9;
	Tue, 19 Aug 2025 03:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hrtw1sKo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AD32E2295
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574466; cv=none; b=JBwkdF1htWiZK5uOeyhtaVDKEhGqIlnz0XU0ROI3IyX0fJWMxbRUL5iZW4F8lqrxPPy9MViVxwEj/LdUPmLjwip6RYCJiiSuP4XeDLzv/tpYA0A5wC5yWh/U3smGglslL4q1FmHUF+1QPwj/p+FYBLb+EvvYeksz5OGg98Lj49s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574466; c=relaxed/simple;
	bh=jOpI4nmnKEmv8uXLQgSky6yvZ4rqxGLbRu05MSmbQfE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AInGmfecyPoK38evi1LrG9M999K5TP3vyxjHccHAMzDHLdxWGvtcwgKjSSQRwNSjcXimhD1SV2zg/c0fE5WBYOSvthk5OlxcFSSK+8jxaLEFJ5OCS6J2quipVeEnzOB3RaHuaQG4nZ0GZ9DBj4maTvX+ySPVHnydHNlQbYj3Bbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hrtw1sKo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ILPdXt006647
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OPWsmdBgWK2fzbiKII489PmVXT2aCRqmtO36lTZIRwY=; b=Hrtw1sKofE2SkRn5
	eqE+EmbaHH+lURmilUFvUpZOSNvIo9oYtSr9HmBzIzK5XT/hDatw2LTi3QhFyeQr
	/xRh6j0VCu9RpRN8SPs8Mgar6t7snovEIyvU1i5aX29NaQQfrZ/XkkDanmRCg7Qs
	2RatRD4vD32mevX4ZVbsBjTepv2qbeF9cE2aDrn9fndepz6HheVzcTNeekZ+pLIT
	J+mEkbampmGuOOOquPe5d9NpXu+V+Zbw5G31MxLUBa6HwCWJUWQZ7Wv5DTGA2tNq
	R97EkBtJsMzxwQgg4txqtvcjntPr2qAr8C4yIPSbjivGQSp9zDnv8rZBe1jhbV9V
	aacaCA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2uf3bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24458274406so117432385ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:34:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755574462; x=1756179262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPWsmdBgWK2fzbiKII489PmVXT2aCRqmtO36lTZIRwY=;
        b=qeLQVYUGVd6pE42nc5+IOaJZOKgl5KkTB3yr+KhrjMxhhyh2l8jnKojcDWOxZoGWZX
         T2GIkDQ7VkrHpLnTDv5GMQ1oD4IlbI0D6QWPBzJ3n/75ZfY4R2OUT69ZaobKK1WVSwc2
         MrDPcF1LazpnKjScYQgbqHF5wjJICXUr9NKdDHfxeFsTobeRrWa5tDBJ5AgeBKrwiUQi
         z72UPs6TwI7ZfvsgWs5PBm12dCN8YUJ3tUmu8suMgdIN+qt4fROdGn5AWjs/lKXQNGR4
         fNZtcBkmh7lfNIrL6qLII7GWCqyNeaOhTnCC+7RxkdFHBeHw62LgP2gaGJfYl0mmj5E2
         xgJg==
X-Forwarded-Encrypted: i=1; AJvYcCVLzyjDbmdll5MVQmOxA6EbqPUQHZ9/+I/WHQUOOJ5ivoSbNzIHrDD0Gb9Tsy79iuwgqbZwrv62uCKKmYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1IQwUbeqiIOdX8sAJ8d+WqGisx9+U61L4tkxqsCKhj+Jaskyc
	65/7PZxcKUSLrBpGPpAPzNeVIZcpK6ZocrWwhKNRR1AvRI3YlrNCfT340MahMKCzWH6ZDfNJ5ze
	cEaou+eIZHn8tfP09QYtGDHG/cK/U/klYlpj7MlhRHeiRjKdK668bcK+fL92aJ8bA/uA=
X-Gm-Gg: ASbGncv68o22MwNpdnigz/2yeriuRjNvv15oYAnWybNxa3qaYFqQtr3XaLYd+AHWYyy
	ukAoqOHGC/Txj1QyIvF8rnEhpMvYIWUg5n7vWbjPGxbwxagaQCJXaevYr0ZjnYxYVLMpPogjsVA
	cVv4Y08SXCwi2jicno9Lxk3R6xnG7fBYQea06wZJCyg+wMSpFCEh7fjy+PxhKh6en386xwcqVck
	QfDsJJ5/yKTtqZantiXmfpuVbD//Kwha5HrFkpJbTZOIw7HyOoFZP/x1xEFRqMxgdu2O/xk/Xly
	suMnq75K59MZ1SSw2lYkpOpyEQcEbRmkEdCsUSM0A/ExtS2QqkmhywcVNM19yBknfH8MDcg=
X-Received: by 2002:a17:903:22c8:b0:224:23be:c569 with SMTP id d9443c01a7336-245e030d92cmr15553405ad.22.1755574462448;
        Mon, 18 Aug 2025 20:34:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE13BxWQaZCSpPUM8Su6OLbnLn7Jh+VfY1RtFqcYmy31G07dgHHw7LC/2QnlPkdHOv24QeTAQ==
X-Received: by 2002:a17:903:22c8:b0:224:23be:c569 with SMTP id d9443c01a7336-245e030d92cmr15552605ad.22.1755574461668;
        Mon, 18 Aug 2025 20:34:21 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f55esm94486325ad.82.2025.08.18.20.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:34:21 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:33:31 +0800
Subject: [PATCH v7 4/6] soc: qcom: ubwc: Add QCS8300 UBWC cfg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs8300_mdss-v7-4-49775ef134f4@oss.qualcomm.com>
References: <20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com>
In-Reply-To: <20250819-qcs8300_mdss-v7-0-49775ef134f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755574427; l=1186;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=jOpI4nmnKEmv8uXLQgSky6yvZ4rqxGLbRu05MSmbQfE=;
 b=Mhpyzs75r/w1fcnROY7DFyp/qHvsah/YEHiiC08YAODExISlfqMhgNgkJqs5WTOYQff50uSim
 Ynx34vWm+hVCP/Vw/bmQ/fifpDV9h6NMxRK+9bcfEyVEpmAPeZNaa9g
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a3f0bf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=yyC0Gtz2zuuxwh5CSaYA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: RFpxzqzgNfdVhKo4r85AO8DFihs_V-wA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX91xULVZ7UCC1
 9PdlsyXrRwk7yt3mH+oQpuHlkYbSTs/sPwN+wYVNqT1VA9RME5JGkpd+sdzh/R9X+3CSIGgXg0G
 O9qJZkFImSk/zGFHyFmnQgOSmHxVpBAbruu5zUJ1Zsp/c2H0g2GlNiUfQw+tQowqLcrtixSfN8w
 q2pOfQPjaSbD2UHD1yM0VkRs94ilY6JgH/jrc4dxHrEEMPQpqJ49wWJlNz0QCQ3dyXcRBqrdi1C
 tLy3dxvOkozcxFSLFrxiMe6vC+nvzVW2fD8YGBRZWLfHSYo959O0IqgrvqSu+TlOSbzgsjXEUUt
 nLDA8F2E8KhB2BXsLZWcGARS1WJHCgaKQrPxSf2FQSbRDs37Ot/rDE2yKvVUsM7DoIVqPYSbLai
 JeT5nGle
X-Proofpoint-GUID: RFpxzqzgNfdVhKo4r85AO8DFihs_V-wA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

The QCS8300 supports UBWC 4.0 and 4 channels LP5 memory interface. Use
the SC8280XP as fallback for QCS8300 according to the specification.

Acked-by: Bjorn Andersson <andersson@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 1490a7f63767bba176e8e2e76891d7d2c424bb7f..b70627d40dc4c671b8a855a17d4b8ca2dd9952d5 100644
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
2.34.1


