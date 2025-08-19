Return-Path: <linux-kernel+bounces-774800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B03B2B7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0DB07A6E80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4342D8DD4;
	Tue, 19 Aug 2025 03:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oVz1uf3C"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB79824E4AF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574480; cv=none; b=L9wU9d+do6rzieUZvhPBECC5s2YCV/tkSVMygIqV4j5PdHI7YEwyYJ9WipihdFEQMMny0/xDdnkrRb8uT0zt9fgwIFBc+UQANxX0cBfFCEGDso/bXC0QxtYr9LPdmkU21qufZNCBD2yvVdydN4BhAJeG3QVUva8WN74HgEZdKkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574480; c=relaxed/simple;
	bh=PkZh52tFVW68m2fUUsOwG1KUdbGeXKurw+4OaZvkX8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtVWc6Irjm9QKZ8rhP6Yna/BWxs/S1RBCe+5FuL7gX+U9mEW1pbcYv7ENBByZmJ39XC2Uiz2soqUf7BFNnct7U2ai8DBpAn/NUJ3s5yokvNGSrIW/T07EGrT9MHpxtatCvK2eyBFChwKZMOi5RCQb2pQspXJ7tacWgTxBZuH/wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oVz1uf3C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J2HWl1010055
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R5/ed+iMJVza84RA4CmOOZSSACg+IzN4IYjyPBClVDw=; b=oVz1uf3CRu6f4Gjh
	JnK6KXd5EzzWQnGXvUqANguG8cz5HxvpU9o0TcUTmQukj57RbmJcGW18xVKUJJnC
	9+Yq2fhB4ju3JvGICCHrZWP2EDcyxFuYCuzxIbawxELhzSCvkOpO1hFz7oAhLCmk
	TSxP8rFGcOQ7vyEb4TTa8qh08HVXJW2o+kB0DDPFBCh80ApYOTeuiQk+JTGnhnvx
	Km6US/rQb6xl/1cqBATmZ5y0Njf1Og/iLuL0wSz6AtXp+ua2cb3m+K7yeHhsZ+QJ
	WaNKDp+vkH72H5uwaW5v0ek4tF/W6bqAq5WnDM4a5fbas0SDQMrDBr7/ItjTh9rV
	+Ha6mw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jhagxyyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24458264c5aso49862285ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755574476; x=1756179276;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5/ed+iMJVza84RA4CmOOZSSACg+IzN4IYjyPBClVDw=;
        b=r6/VKTxU/RnKp/RqJu5HqKss+TfF1mrXCkigL30agpzMsacKDt4ZYG66S1tEp3zUPA
         RmgCXSbQzeEAMW8GOIPqQwH43T4xABxx+gsQwdp9FA+SxU5ZFcTk6Lym3kiCQVVqM2UC
         NJ7OqIx3W8e0LGm5U97uQ05fnplPQUWcRbJZk5zwcDtCQNBJvwp/aXXl6wiaEh4GPG2R
         KkKcD0MMFFUgokr/LdIg0E1vhNB/ibMXnecKenDcrTNp+0BMMgBoVMAgjt0ON1E4y/PB
         HnyGtwZYtNFGZ/1mii8vA8qP7cr0VaDhuQ11l26/GyMT2xjHInMWn+YA/rAGk/RUWlz+
         LHrw==
X-Forwarded-Encrypted: i=1; AJvYcCUy302a4hfUO+8yT2FTkp4uMDyFdW0j1Ck7cPWa0WkfBgJ+7IFKRHZWNBd7p1WhgeZkjKlsdMH1OEYnvHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpjjGXdpwc8L2dbZ7lT6+9/B2ij5ckgK1ZQyIS3VPguQJHdnM6
	bEq2zIrzX4j/4/HI+BP/jWMAQ+77XHwaWTEhH3CrYSXOQyZhOurcLOLDzBxsVcz4O/J9HgeEDbI
	9p0HJ2gbyIC3BnCHLqBqJrwQr3sio+Xh2vWsdQAfJACXe+jdopTlxQlALcRoRGPp+37I=
X-Gm-Gg: ASbGncuKDXTDL6OZLxPGF667+qFptHTQsxfjiHZefIT6UndnL0Th9Ay3cZimXsCGgPR
	O97E2W/z78V+YprC0+IJT4rY9gYH1ha0FzdjM77L55GpdFmaqv6n4n2GWDmG9ctVMM03NYi5a2Z
	y8Feq6VChVYtEscOQ4jsuMpcT0zUQCYsVdKINauhY4clx+eSKrIfGJzlwpadNAmXplUusWg4wWA
	E1DSsmpCgi7tu8OF23gHTYXbi6q+1N6dkrjlw9JUI/xh7VgNtBpK7UyHehB/Q3H1rAYj/mkPNWq
	PRjZ+9gnPXuGqDjOWICnpjzMUhuGljSgMHUfPHSMgOTa7LpJJ7DTtJG4NPSppF7NVRyxqdk=
X-Received: by 2002:a17:903:1249:b0:240:6fd0:25b7 with SMTP id d9443c01a7336-245e04ac757mr15321275ad.38.1755574475918;
        Mon, 18 Aug 2025 20:34:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeF3q0NRFaqzmeniqpQaJM8C07r12p9EeneZ0E+iAYto/zETVgcNSjCv0p2TC+5I/zykn6ig==
X-Received: by 2002:a17:903:1249:b0:240:6fd0:25b7 with SMTP id d9443c01a7336-245e04ac757mr15320805ad.38.1755574475483;
        Mon, 18 Aug 2025 20:34:35 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f55esm94486325ad.82.2025.08.18.20.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:34:35 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:33:33 +0800
Subject: [PATCH v7 6/6] drm/msm/dp: Add DisplayPort controller for QCS8300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-qcs8300_mdss-v7-6-49775ef134f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755574427; l=1239;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=PkZh52tFVW68m2fUUsOwG1KUdbGeXKurw+4OaZvkX8I=;
 b=dQ6aru+yQ61EPbqt3DsNB3TZCLkB+30rVHlgf5Qp0xqAZ4vNfPSKD+2OoesGCp3xqCbOVmBvY
 qnw3cp0Vl/PBskaHMLYtoqm56M0lLnVkiKAh8YdMn+BnF6esphosG4P
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Authority-Analysis: v=2.4 cv=D9xHKuRj c=1 sm=1 tr=0 ts=68a3f0cd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=E9mFum2VwHQHOKsBOicA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 35-_lUBX-LiOS7sbrMkhUVJ7uGNu6z1p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAyNCBTYWx0ZWRfX8jqF2ShAj1gO
 DOM0bvq6QxZqwi7Vr21KApPTx9X/zfrie3hulPAf5twpuCjp+olGA4SU7YJu0OIcx/Xav1CfhxY
 Ot0TUDu/skg2VdCL6uhPN+RSJ7lS9FRE6r74OuwKCP589mV4IepJZAPs+Ygf5l2OZxc2cBENfuG
 +GDcVBRCoIy4XtohkLV6oBFHt9umIekebzHb2fDauGo2Y6jaeK4wsAdONTxIOJClBTe1J90/ofI
 sWouhE36vomNKG+05st7srRzp1p8o0P4/NgsIGrRhiy7sVBlBJUdb0nveKVh2QGRwAkjXxTkYJe
 XlyRbNFF3AvXVh68ubZWsPMpIsouAhI5I/MaWMFt45kBnLPcQ788MPMpjeoWPUtwTkKh9ETOuZk
 2yRAXYVM
X-Proofpoint-GUID: 35-_lUBX-LiOS7sbrMkhUVJ7uGNu6z1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160024

The Qualcomm QCS8300 platform comes with one DisplayPort controller
with same base offset as SM8650. But it requires new compatible string
because QCS8300 controller supports 4 MST streams. 4 MST streams will
be enabled as part of MST feature support. Currently, using SM8650 as
fallback to enable SST on QCS8300.

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


