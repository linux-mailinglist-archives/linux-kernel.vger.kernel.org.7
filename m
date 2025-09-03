Return-Path: <linux-kernel+bounces-798440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 654B6B41E0B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479A3188FA41
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE312FD7A3;
	Wed,  3 Sep 2025 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PGCgS2Jx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40A62FE59A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900718; cv=none; b=Bpj8f8FGR+AafnAk/MT44BsZzy/vix5SY92SMaICzJUkc4+T4MsKZDVTL5EjnV5QKOFPUo3PvAdQwiVi0haE9D/nwIToTMr0r0G+TX+wm2EsrDPEBeSYI/jBWBLnnr9zqtJRf7+fP27vdU/24l0eQ2Edsmq3NUOPRHi4rYgzgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900718; c=relaxed/simple;
	bh=lBevXKdHONx87FeX9ms0nioXAmeKW3/lJZ9j12ovv/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scOHxtecpO0t43zEmhSkRLpg7OaFT/QZCSaW4bbJaIL4SO689N7jTJIbfoUsdJv2q2gwIGMIZpKH1/QL9Yr1qVN2V+Q+xreA3sggfGGEVj2faqBslpgEXdg9XVG0u8k3baDVcdbc1NUDuebistQUCV9foK0O/BET9A/1/ZPYCp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PGCgS2Jx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BEw2Q022414
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H010azYPB1dFkM9rbItrhry3MhtWqv6s9ueklIrUJck=; b=PGCgS2JxDn39MdJk
	Qmtczw8VuWP0yZlwY0GANOUIRW/IpSK81WY9Hp3T071cxMSqfZW46dT9bCHebih6
	q/DITlPq5X1EpFSkdPUd1Mchz31GCkMxZpho0Nf/dFH9k48gCgwW/GE/3bm9byqR
	BZDu37Tl/TPaO6/yzZY2otYquvghond01k81FVmDg68g/y0N3CgFflo72Nhz7SK2
	kPPcAzg5fePIKjrcy9V4ugQmjgs74vx5r1qleAsNgP/5OrAPjit6MkP0+6WltZ2P
	+DAgJpUOFZl2IcCMQ7qwN14GaPKzRFIWd3DMinaVKo4HbYEM+5pKPgQTcAQTTSYK
	SEscyg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fkdx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:58:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b339e7d107so56973581cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900714; x=1757505514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H010azYPB1dFkM9rbItrhry3MhtWqv6s9ueklIrUJck=;
        b=rY7AjO2THxvHDY272GLA3aoD+01+qznEyUvhmubOqic+5zVfYO1SkUHYb6Kb9xq1Si
         GY70G5yWsqKEdGRQ12I3MmccuGPMzVE6E8PGFNM0/quaoSMxBpVJj3ZZKxGSi6jZ8TqR
         SgJevtYkqagA7H99tk9Uhj9x6ZynQRysAfUFJ2CuzhNcK3RcZE8xLhtgGabjDWALAT/j
         fjW6tVQGpgRg4CcYLfuOqi2F3cx5eFmd7GYQvpMUyQVzUWyVo4sdxbOabc7h+ZgsdKOz
         FVhWona5QtbJfBjc6z3EUzz8zvdHYitgpuVNFVB85ZDfybA8021qmvriOg3iCdEezpBE
         reag==
X-Forwarded-Encrypted: i=1; AJvYcCW9mJnk+AItWsOoMwzDVjImLNttTNEYGOtWTjQZch+S3u/5HMdo3NG4lDcrdFgKK0v/Ywmfx1wjh3kASyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs7FfXB3haCCgLRf6OGVTUvJR5hfochzgLwZ1TMRiA0UJIdbeW
	E0yabarpAldVJ/+lZ0if8klARy7qcKjm0KVI5nZgb+8/+030SDrE+RAGig2CvWCz1rYnSkE1szA
	qM/90+bd0ckXZwNHRCRle2NLGowQLHzOhITprJy9k+L6orjhxz/ATFuWI9rA91svPnYo=
X-Gm-Gg: ASbGnctg9aAWSOC/fDgtWPS5tkNxbIo6SGohDavVuljYSpDK4k7QFMm17JKEVKGsh/A
	30wlarNEvoLkfjI57jrkHvj07HfTygq4w/CucKY5pfcPNO8wNTihUt9anbMi/FkPqVvoZgCfF9S
	oE5PEKCn2o/yL3a0p8ZN67R2kr2j8lbDWLk0wvMGMulx4NVMVJtBhhFpGX6jjdn3nh84p6TDk0+
	If5mmhua0eKLOIvcidc2WwwTL+KBcZg42LiL4xXGeHTVBTqkLRwXO1+GBLJ1Vd56SFWKxEdzQlT
	KLWvuA9+6zBa81SgIR3b1M/m/YdGMzOa6ECG6rk7f7RxLt0dMKo+PawYwzQk/NR/Rocl7Osu6dO
	gJIrIwp53IyYI5MMlQv1TCt7kpnmImw5YxBkzlfgtJcPW1KnIO2RO
X-Received: by 2002:ac8:5708:0:b0:4b2:a96b:11ca with SMTP id d75a77b69052e-4b31d8c03ffmr167861741cf.35.1756900714318;
        Wed, 03 Sep 2025 04:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkGGAS3RPAQRRlAhwEn7il9NRls7BjhMAjCYkS0WjfrgqegShhrJEbGNDK0zM3QZXpoVuOfQ==
X-Received: by 2002:ac8:5708:0:b0:4b2:a96b:11ca with SMTP id d75a77b69052e-4b31d8c03ffmr167861381cf.35.1756900713772;
        Wed, 03 Sep 2025 04:58:33 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f50d30b0sm9891421fa.67.2025.09.03.04.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:58:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 14:58:17 +0300
Subject: [PATCH v8 6/9] dt-bindings: display/msm: drop
 assigned-clock-parents for dp controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-dp_mst_bindings-v8-6-7526f0311eaa@oss.qualcomm.com>
References: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
In-Reply-To: <20250903-dp_mst_bindings-v8-0-7526f0311eaa@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=jRBkyHcr8xMj4BTwupyA6gCqxajStjyC+O9UZ5EGgLs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBouC1Y3hkuiW1SdkWdW290s9cpICY2nNpGq9u2+
 ZHdafw7MJCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLgtWAAKCRCLPIo+Aiko
 1RmYB/9/VcpHWh/T/oWqH9QlA/WdaWLvy2U1EC9r0ItZxVKnxhkQSnrH/R515kKz/bJkz0lBrxv
 5rZpsAdlZAs7zfHNe7ImD79Y+IhvUWlWpILd/MT5GHjO/4Y6PusaYedg+kJ4cacVKecLb5FAlYS
 zEVK8LBwv5piuq8veplWWb6t05FnF2Zq2QuqRGR1iJw4i9kK4EzInHt3n2b+7pekkGf1wqffVZg
 veGoMDumdL01DUrZvJP5EjIKnj1g+MmXAqRzfMGmgQG0PXINDlVgzA2ct+f2T/4IIOqF3qy3Qvp
 FIb+7nKcGES5MeMPVPbNLVIPIQricUltNMD3derDF0Ou26eW
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfXy94v4i6q2dPq
 4lLqHZNM8OQe4xNFLuQsoUgW/3w7P0ja45VhALZsUnhT48lDLTGtVxplxp1J9rD3ES0bYe1JZm9
 olybwHdxbdSR9gr0C/3s/i/Cg1IeKiQfY3AZlomqUQb8wEP++MbTrCg/wCdIIZaUBaiwLm078Yo
 kRVDaLbKaa6Ww+V/IlzY2gz4viAR7gEaLE5eS6gLXX4zqJAOWtW9mMnt2DOLHlGBoiiWDrdFHeh
 QPJROh3Ok8cxv9zqz4zBJ5T7Kw23PoOPILyMP28a/uTvNDQry8RKQBKgWILoWMl+JQxk+jQ8j58
 EwQkH9R3yVmqH83gZvBksysf3v9avGag1mxNVne26mi9VORBVj6JS4i6I0csnTn+aN8Oll9RpVe
 owDYO8k4
X-Proofpoint-ORIG-GUID: CU5Do0O2lUu5js-L77xG5iYI5bGxAgka
X-Proofpoint-GUID: CU5Do0O2lUu5js-L77xG5iYI5bGxAgka
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b82d6b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VjVaSBsDX57WhQYIrYsA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038

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
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/dp-controller.yaml         | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 6316c929fd66588b83d3abaf01d83a6b49b35e80..afe01332d66c3c2e6e5848ce3d864079ce71f3cd 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -86,16 +86,6 @@ properties:
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
2.47.2


