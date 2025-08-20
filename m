Return-Path: <linux-kernel+bounces-777377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61755B2D8D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8E61C45FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068192E0B45;
	Wed, 20 Aug 2025 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c6ZzACJ9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF83A2E0924
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755682542; cv=none; b=UmOkgDscuLTWAShlPNkNUUen3KFyAqqZnUmm2icZhShST0fGO4w2LunFHQxW51COZ6MRARGb9m6cVZf1znLb95vk5O5ebuPAoVzbYI0kMOR3pt2EfmU50iUb63w7126aT9ZfRLILhHIAUUH+Z8x4Rd+56doKqF0t6sedXyF+1s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755682542; c=relaxed/simple;
	bh=TjE7e881JVJnbF2pC7aHvYEjeplK5Jqgj7gdtmDIJTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IYpbyOlqYfKj68wcapNaUlKhWKsSy3Uzw4MghYBvFlGs7mNlvceyuxA48lvMMftGFtOLDCrJ6m/ldjeOlSP5buBI2T/5SZusd3gAvysi5khrRIZBbGieFqH6OgojjPmYkGUr9YSGrJ1XSFa2NTd++wrBvwGWJp2/Qv0Dm03Qaxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c6ZzACJ9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K1oXIC019721
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lfdbDDF0iaKbmDjAc10VCP1/rYHdufYQTCEri5cSINM=; b=c6ZzACJ9ntzGn7pd
	F4Yq/lTRlsaCdklIJw6c6npphgDFDfNqymLrq7dGBs2GWKk0poBKof8gjfnWh6TG
	ZsE0QPKZ0JcTsTkKPneiTRnaufKaOqgjMSDmrlNlSnGITiWNe4wIP7Fz/YhXPpC9
	/kGUBHVxBZieZZt4XPU3cAWhHTpGAbmurdmkt7ZKPeQKftuCRjxXhlYcKWZNHOmk
	1OcwLH+UL+0NgnPks1OiMbgRaQYpRTQVBXBrgUshD2uZUmfHnN+4IzbwUdI9xxO0
	fuEFaeuqD2+EadfBcv9f4JXOYIbGjnLB/3E4aqzgtW0sbsAnYNCOxWkwDkzrQ7Fw
	IP+yFw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52916yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:35:39 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244580538c3so16660095ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755682539; x=1756287339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfdbDDF0iaKbmDjAc10VCP1/rYHdufYQTCEri5cSINM=;
        b=DSZuEk3a8LG+FxfHQ8+qVIdCpKm4PAj+z/zidaW9oje7uvqev4s0Z61Mjwy+OmaWEc
         HEh7IvSl8fjkjPe1Bfkp00P6Anc/u5xFltADqKxG91DYdFR7g63Fk2uHcXRY8ZqmfwJD
         IhLtAzQaTLqaucS/KDg1gyqLM+RmvuBJhTLQ8Mui95eVogxQMXOnTTwvzITRw0mc7jsm
         it7A/quvCx8/CWFlli1jLtcobIkaedm1YRN5CRwISx2S1+u/tBQaDhFdf8yQzyljpe6K
         PcsxBou7MDmEFWl8EXHdTt60Kvjpekv1ZAIA+qB8PLZ5W9DPuPOs4H/4per61+XnMlSr
         1Bwg==
X-Forwarded-Encrypted: i=1; AJvYcCWG7xJ00qVtqbYrBtc5bbX/KmEafws0dai43NBzznHlkEgTmf7+n1da/eu14IdzCGLrqcatntqlMJl0pYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys/eez7bsKaHpVsSithjRrOiLYd5KhKYeZe9d8q/wx9z2uFsde
	0nP+uE50uXH9jGGFVyfGe3t31WbxL1jPZMFP6bfk4UJ65VTKMtxn6qsuOdfMBmXlVC0vreFRTBb
	Wr/Ppaw9YFQ5iMZq6BzjkuykHl2jqtIQp3NzI9fx1TNNfJ0v/g7tBP9w5u3ZjnLm1bL8=
X-Gm-Gg: ASbGncsYyrw59MJ2aEK31QYV8VyI470hwtBO2haWvTSdYu8O7XtCkC5v3CmjqNHXXWh
	N0d0+zJS3OPtZHEbHjn/m8jzWxKvOMHiZkqjNj6YwPkEw2CEm9lhsWsS++C7yxkB5+U2egpqRDA
	hcxh8WxwFhRI2ewQI25ExNzUqnSl1lMgP2q/J12CA0XJaR+ESeCLJ42G76zGoEd2bl4/iagLKII
	/fdUayjLUHzV2UQy0tJj8LhdbrBJtdOc5jrSWpGe+ZkhwQp2qdTM6rmBhtlX45i2Drez80e9M8n
	eIGRTRJcXKmVDrSctxX6F0xRyGDaPfWSTdrh5xI5RXljICX2m7BrCmmQKEX4hU04CcNBnOvPrG2
	HWP9M9b3uBwzrLHZQ7Hi8WVGa/bco4ZiOxKFBKJQZTLDG3XYX9ywcG6q2
X-Received: by 2002:a17:903:2301:b0:245:f85c:8c6f with SMTP id d9443c01a7336-245f85c8f03mr878745ad.3.1755682539161;
        Wed, 20 Aug 2025 02:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGruFqyjDNjNZap3tlQ1QMYvoarVGmRE48uLqorBf5FfkGpP/sCgL8kWEJHeFetKvlW2BsAQw==
X-Received: by 2002:a17:903:2301:b0:245:f85c:8c6f with SMTP id d9443c01a7336-245f85c8f03mr878395ad.3.1755682538659;
        Wed, 20 Aug 2025 02:35:38 -0700 (PDT)
Received: from sziotdisp01-gv.qualcomm.com.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ec100sm20954305ad.116.2025.08.20.02.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:35:38 -0700 (PDT)
From: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 17:34:43 +0800
Subject: [PATCH v3 01/14] dt-bindings: display/msm: dp-controller: Add
 sm6150
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-add-displayport-support-for-qcs615-platform-v3-1-a43bd25ec39c@oss.qualcomm.com>
References: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
In-Reply-To: <20250820-add-displayport-support-for-qcs615-platform-v3-0-a43bd25ec39c@oss.qualcomm.com>
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
        Kuogee Hsieh <quic_khsieh@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        fange.zhang@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        quic_lliu6@quicinc.com, Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755682519; l=1064;
 i=xiangxu.yin@oss.qualcomm.com; s=20241125; h=from:subject:message-id;
 bh=TjE7e881JVJnbF2pC7aHvYEjeplK5Jqgj7gdtmDIJTo=;
 b=YwFU8m0AxT0KFGHqI+UMpcgWIIE1IgQqEACZ3mvVMDlXo2yCND45p9Q1LVkk1fS+g3Vf0Oj8h
 owjuMU/XXy9C5rqcHiom1RQmoTnCAwpm4ldZajHq6LLdCFeZzebhABE
X-Developer-Key: i=xiangxu.yin@oss.qualcomm.com; a=ed25519;
 pk=F1TwipJzpywfbt3n/RPi4l/A4AVF+QC89XzCHgZYaOc=
X-Proofpoint-GUID: Zu2eqNOqmWrnjrxxOIpRvMQm4OlXZzGA
X-Proofpoint-ORIG-GUID: Zu2eqNOqmWrnjrxxOIpRvMQm4OlXZzGA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX1dwUjkwU57nD
 E5dB2cxa3l0zMNf3D8ihqmgewyQHrAma6Gp0vpr1wcuJk/wEjF/kT8ptVGRIa7hjgjAbllf5wCj
 VbsC6Rv/6VpyTzUBHUE1jg25La2cxyBvbFKYEaWfrumP5Ow1WrBoxKmFI3lnsWBPh60MIuY3nhN
 6C6G1HOv7MPoJY2vG0bKCwY62jcQgLrUk2Jz9lAMltS2+WFYx9rNzOB3z46/9/6GyguX3sxZa8u
 Tk4zH5Yd80pRfVnO2cHe5plphIjVU4RJ/vTbkT5baymcKv4B2SPu9cOFfh+x8ObkehCqxvXIvwA
 14kTZsIT7wCM9Yjsu4x05LFKhoP9rZgeaYmfHQZblj/t/LbFHv09A5GP4HIfJeXdxVddjgULwif
 mXY1Wkqu8Zum5xPfTJQx7Ttrj235Kg==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a596ec cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Hz27nZlvLZz7BoqxLNkA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

Add DisplayPort controller for Qualcomm SM6150 SoC.
While SM6150 currently shares the same configuration as SC7180,
its hardware capabilities differ. Explicitly listing it ensures clarity
and avoids potential issues if SC7180 support evolves in the future.

Signed-off-by: Xiangxu Yin <xiangxu.yin@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 9923b065323bbab99de5079b674a0317f3074373..996d0132e084d401db85014a1a4e445d00d62ed8 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -27,6 +27,7 @@ properties:
           - qcom,sc8280xp-dp
           - qcom,sc8280xp-edp
           - qcom,sdm845-dp
+          - qcom,sm6150-dp
           - qcom,sm8350-dp
           - qcom,sm8650-dp
       - items:

-- 
2.34.1


