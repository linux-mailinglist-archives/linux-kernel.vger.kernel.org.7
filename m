Return-Path: <linux-kernel+bounces-761029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D35CB1F362
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 10:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEDDC1893E87
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B08227563;
	Sat,  9 Aug 2025 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W1ujCWNL"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03478280327
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754728453; cv=none; b=X8rsd6zE/cyM1EM6rIKK3yCE30PSSc+k2MWgPbG7oOMrrzoQ/1nCiP4dUzQ/3siaJqWft8WC4ea/oXstJiLMPVqx4XXDDXSuOhZxFKrvu4L8Tq6d+gWjLENjkDpxqyUyikh2cTf7yQnMr6TYrX4X7WNycDIG+DM4muVcajT5yvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754728453; c=relaxed/simple;
	bh=Y2ogXEDYHHH32US4rqwrs2C1gO2dNoRFZhWAu0HutnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XgeiC0KPwRt/+9z0bhiTFHxqj65qTvpJQqyFccCsb7KYB5j92EJRzRp6isOLj/g5asUyzYHU7gBtVX5R++Dr1aUL8xp5T7EWdBmf1rw7g++4uq9HXoiCHYaOHnIJBvoV7V/CLJGG6Q6xBEuS7U/cVOjRVp6wYM/vaENZqTP2R3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W1ujCWNL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5794Bpih029641
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 08:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0noH+yy2UERIjrtWf5Izm7M0t2Ukl6cXD864r/H8zL0=; b=W1ujCWNL3lsMnAur
	4iZbhjWF6Er8Td52ISK4x37YPIryNw3NBgcRn/WQnU6hNORUuaFXIWl2/2GzdILc
	VIp/1tnd1nH9nGdW9Lez+GNzzroQrnR2s/a9GBKEpOCxKEkKtPl3K3K01SqxiWTX
	yR2RPuBOufH2c5puaPOoBfun9rUs9JA70+jsEaF0kJIz30TEKbkikSrHYKQwd+Pm
	dnNIu4h2nEXtHkdhedWvuesUBF/Lw1ejMjay40yRdMvM+P6vcpK3WP20f8tcU15z
	8tmZ26BET/ISWQ2FpmaMoy0z+5DHkxYswrbpVnO524SCjbvIYmUF/drFbQ0U+Ipf
	Od0mxw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g09q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 08:34:11 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b0b507d014so20952361cf.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 01:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754728449; x=1755333249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0noH+yy2UERIjrtWf5Izm7M0t2Ukl6cXD864r/H8zL0=;
        b=QDOjOe/zxg1xmCKdvnhYyGOAd5mN/UJkNINDzRLAgPem+G00TE3dlOKRVRLPARni0i
         lbxd+UcD00tZxv158lt4D/HLr2g9P9egef4qmLcJtamEMB8U8FiM5UZLvY1SEGUfWXCm
         tBH6ccEddozBn6cS/QyXftwdaovel6y+OIyh9ZRvMfqjBG7YoKIA4eWSW7jvwTFA3vI2
         rKw9j0WKeoIy5vSh8s6kdAD/uEH4Ly3jStLfKURWXyWcxvuPPRgx1/ZjixyI9IbdLaRX
         vniimSsrbAK6yR+55m/LQBEfFxue9tNddcXPdc/xdvQYrDQo5jz7PMzSBjKHsph93Kvy
         KveA==
X-Forwarded-Encrypted: i=1; AJvYcCUdhH3Dk5zzHVhKmmTpMoOYeA8IwZ2LeJvwOxTIoALkX//z3QpNVYfmLZJZX7M+c2yySX7yPsx0wcDFUi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpviGpOLYZH4svs6ZPf07WovXKw6jKg725nK79oEICzeDz6k95
	Rp4MNirl1uwNaC/250YrbzwbBCoDIRJxgvZCjLAncHxeKbMTC1SAEwu2aoe0s+VFe0Wp37OkyvC
	c0ynmxZd8xchpEx/RndkDjOHSzvhydUtzO3j1sZZ5F/XnNWHj1QlIoS67sOqzWn1F8fE=
X-Gm-Gg: ASbGncvzeDNTwKVA1H9O4CSwsF5jRDNEN06KwhHZjPGbNLBP2f82AA3UybaicgtMAVI
	t4+A+DJ+ZhPLz3a3yVYM1Hn9sjbfVFAZFa0WlFA7t7rtijD1y90/BbEXKV2BwAPBuRdXKTqlc/F
	2bbfH0kJBvJHd9C4u+T2YzHmDXbUIkh+jbvTelgDqSvALaWn5oCHuDO+MNX/j5TIJ1g+pM1r6ND
	wVDQ37aBD4tto3obv3gCpV6m3kCxz4fE7XHdPGfMFEcOzsYauYlEtVr02ZgSWmGoEYwfxCcvwZA
	Ibzf+3zqpg/8ZOOH9LdihlGKLhhVJjb4uYt18InSVyl4czOjvUqL4ir6s7dTOwt1V7KfqBP86v4
	mDqTaivjlAnBr11gKLhXDtV2ngRvXNmQtTUFJcfasKdpZY0mjePp+
X-Received: by 2002:ac8:598a:0:b0:4b0:6965:dd97 with SMTP id d75a77b69052e-4b0aed46000mr62114941cf.44.1754728449231;
        Sat, 09 Aug 2025 01:34:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7Ab4avSwq1zZ5d2YBZYLBo3nOHk9zflP4onqWeB1kJHzKmCxLZZa6pyaayGdxAMVuH3MvJQ==
X-Received: by 2002:ac8:598a:0:b0:4b0:6965:dd97 with SMTP id d75a77b69052e-4b0aed46000mr62114791cf.44.1754728448780;
        Sat, 09 Aug 2025 01:34:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88c99078sm3268166e87.102.2025.08.09.01.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 01:34:04 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 09 Aug 2025 11:33:55 +0300
Subject: [PATCH v4 4/6] dt-bindings: display/msm: drop
 assigned-clock-parents for dp controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-dp_mst_bindings-v4-4-bb316e638284@oss.qualcomm.com>
References: <20250809-dp_mst_bindings-v4-0-bb316e638284@oss.qualcomm.com>
In-Reply-To: <20250809-dp_mst_bindings-v4-0-bb316e638284@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=rRhj4oU1JzHT8f9jk9qa6uf5IjtK4GGvxWKFr60GaGk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBolwf0g4u3a1NCs2Pi954EIn8pKAWuyUrvgWY4u
 8s5Au3R/ZeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJcH9AAKCRCLPIo+Aiko
 1eLiB/4ji4EZcId3I+Gipm7fUItEaEkdL4jBiSVpgDbR58hgGaGfh+rgg1iUC2K1H2n77wSd8Qr
 SVc9HGNGyoO+RsgWs2Q7TnCVDiYvrZUQnkVc2p9Nd9vNYCrpW87YySLDDgKLZ4bn8BDwb2nwefE
 ffzgcvATuCl1rekKNCxLWqIKz5PUxhd0rTjRXQgcaMpRDZ24nximOaUERVaE8jgKNGqy4nlXPe4
 PHmMFyHM5RlrJhBRvveyw+dPfy+4nluaTtsx3GrtM9qhNowxjd2B4f+K+Bs9fCSSwbTBJFKzuzQ
 klbUlOK1fCXVmzkHriccIeMu1IBi+WdzUkpz5G3GGtC0O0CN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=68970803 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VjVaSBsDX57WhQYIrYsA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfX/TryDETcdQwy
 Y7VO9/hvUqqiIoP6+VBe8jxlUsk4JRqoYLCPxsezYk20O3Q8kbr7F/rFyk/De7c3XD2grX0FxT1
 UPetHEvzUQOaHAOfkPm3D8mnQ8GclaAAwJzsLECxH4az3T+vz+Z+CcnaRKA+lc92rehb0PwtqAU
 ex/4l2wrU9HnOlPQzobDViezCQYPdG4fwCmQljO/4XOu5+ZNnzD+gD+6GueZfPve6xgoTj+aBdl
 JP1TIb6Z3xFcawrQ8n90aTClz9HzDBkhZhKeP/kkhoThwfqzrjpt6RGRt32/hdbBz9X7Nq6iRpE
 4H4qD+7eSimMCW9BO2d1+02Fhor54QlwpKUUiVU0uocoBFwtO0i/wgTVbhmu1n1hu8xaM1P5Al1
 E+8TCNnt
X-Proofpoint-GUID: QQycAVpf_FzAeKRLJXXH3CsTAMbYC4RA
X-Proofpoint-ORIG-GUID: QQycAVpf_FzAeKRLJXXH3CsTAMbYC4RA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-09_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

DP controller schema documents assigned-clocks and
assigned-clock-parents. However these assignments should not be a part
of the ABI: there are no actual requirements on the order of the
assignments, MST cases require different number of clocks to be
assigned, etc.

Instead of fixing up the documentation, drop the assigned-clock-parents
and assigned-clocks from the bindings. The generic clock/clock.yaml
already covers these properties.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/dp-controller.yaml         | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 55e37ec74591af0a1329598f6059475926fdd64e..352824c245224d7b5e096770684795625fc9f146 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -73,16 +73,6 @@ properties:
       - const: ctrl_link_iface
       - const: stream_pixel
 
-  assigned-clocks:
-    items:
-      - description: link clock source
-      - description: pixel clock source
-
-  assigned-clock-parents:
-    items:
-      - description: phy 0 parent
-      - description: phy 1 parent
-
   phys:
     maxItems: 1
 

-- 
2.39.5


