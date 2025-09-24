Return-Path: <linux-kernel+bounces-831429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0449FB9CA42
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E8A3A9617
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317D328E9;
	Wed, 24 Sep 2025 23:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+Q1OWyr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A5C2C032C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757057; cv=none; b=bm+ofTbYqepuL+7/p+COt/snVJsgm0hdAsUT8EmTkZVxOFKjTBlht8AYuhExZFj2b+EpFJQN6UjrUM3uz5iCbWniqApwpZKx8zZ8NqoZtKKsE7wFk/fLb8DRjPyxVugr7M61IP9xRcAB6Tjx0Rb6E7nu8gzH9p4iDbctr66Lz5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757057; c=relaxed/simple;
	bh=yEh271CzwWaC8AljYBxBXpSjh6rUZDtONCY/hWD2UMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npFafn7yvDAsGkXb5NLr6wWlcwax1GJ9RfIDlobY5fPiHm9PDKVlpEfM+VFr9TtZBzCDUhE8cPLYL2N/nd50NVy2/eeqiXUuBEknvkbWcJr/nu3z4ygN4a5jAd6+ps6t3sxOKWL8kk9RgFt7rF3/XpHXTg0m8OaQKEHk187mJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T+Q1OWyr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODY2cq029979
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sVcW8Q66ceh6MYrzZqjm2SaMfynWCP8KmOA8erMrvnU=; b=T+Q1OWyr61TG8a2o
	f+XWNxmTqoegl9+fULRYU6QZ+hr6fWbTGsUZVIUVGym7pC+D4xYJpDe2PGB4jz9q
	wXcI0q61NjIKF6lScGpk5NJ5aL6wCF5a8RPEIAsZxz2KyCaaK8BWFrPSeMsc7StX
	yiHxGOXXHc71vaEcQMiwO3xOvcvIoGmMtlZcJm7l5LiVFkXE+3TjBBfUktf+iBsK
	VEGr/99ntAuiWjGvy32+wq7R3A9oKWHcFW+iG5C1CBAyTO6WQP4w3AVkRP8WqrgP
	lcmparsFaJgYrZcmIBDBJzQ20gJM/sQxtWc4EQcRcGeGbgdHoRO91mP9GvUXz8n5
	Z574zw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fnx9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:37:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-32eb18b5529so395760a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757053; x=1759361853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVcW8Q66ceh6MYrzZqjm2SaMfynWCP8KmOA8erMrvnU=;
        b=IyYL0NWXcbI3+dJX2YXEY5bHMYEJ57WqqX9q4aokIoYt2U6YKFJgGr6v4Em/an3r6g
         gEZ0gTy0zSKYzMvBrAfDu7yf+G05S6EOo23WCeeU9NSeyMeYq5I53iwWLwCQoUmSZR8r
         82CCNVdVXZO71XZkMX0OL5FxOIzT7vmZ6PQyaYxIuOFQ2Rastzjp3CjJLsU0pITZqhTA
         g3jXrqVvkMvE7uBiL12Rq9yO/l8wIQk8Daegc+NWb+tVrhfA3XHN75N4DiU0XlxwQ89g
         FhqugEppLB9m/KKtN2TusO4RLASC70pJFVbYwfsWC6kNPQtEYw57P8gkh2B9nYCzAJrl
         SiAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLmznfOmE7bJ7yNc60UoiKYQc678swQLFYOZvSGvF2X9ANYHvlP5rkflwCbWiPX/Br5jmBcbM7D2a2tc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyItJduKqxinwd5m/nsY2EYlJyWYSbl2eV6lbHi1BOa9odQCOiD
	IgW6huTE6MrOQzGLCkIza/FT3Ir9PSclFUi+jWBQEwJffM/yEGTTgpx1nmI6QtnQfiGVh/WalZS
	Sqc83ue8WZ7M5ZkNENKAsvH+nFDGEroi3Ps9TC0JVpocew2RG3ZmxOheh5j7JIf5+VL4=
X-Gm-Gg: ASbGncud4RV0nBQ8253WddzvSD11yoX5hc1a3jDIQxKq+F0syhrjck5CsCzLGIHgdfZ
	PGARdVFDf6QKQ6YU2qyMe4iQ1F8DHCygifrlcjRyKXzg+B/Hm17jP7tmUToOzFLq5f9uJEOXbqH
	72eblC/LX4lUPfzH0fSwUcQXZGMllPOHWT5Q/UFwTOCELEU+nuZTwritCKuRdOa9LbRAOh7yRYq
	DyX0uTQpVXZBS5k/LBdaU81S2zW/iGZBxMdNwCfcLWUJYGKkr34mZFmSpvgqO6ZNOseRtL0dpwa
	2uHvjmlhAiD/mSI6z9zHWkRkQxs6ERZkVF643XCkOCe7hUrZ9nwYk/7y6wXTOlpP1v/UqDQ0Exf
	Q9IJUblDZuwGgIYw=
X-Received: by 2002:a17:902:cecb:b0:269:8d85:2249 with SMTP id d9443c01a7336-27ed4a0b73fmr14564495ad.22.1758757052695;
        Wed, 24 Sep 2025 16:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXmjvrEnPvGjw08T9XlJAG8e9A/cjwzkIN1aq8g/j/hd6m6hrQcO13lIbbk2ZuOVJncfQ00w==
X-Received: by 2002:a17:902:cecb:b0:269:8d85:2249 with SMTP id d9443c01a7336-27ed4a0b73fmr14564295ad.22.1758757052285;
        Wed, 24 Sep 2025 16:37:32 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33471d73550sm227187a91.3.2025.09.24.16.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:37:31 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:37:24 -0700
Subject: [PATCH 3/6] dt-bindings: remoteproc: qcom,sm8550-pas: Add
 Kaanapali MPSS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-remoteproc-v1-3-611bf7be8329@oss.qualcomm.com>
References: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
In-Reply-To: <20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757046; l=1334;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=yEh271CzwWaC8AljYBxBXpSjh6rUZDtONCY/hWD2UMk=;
 b=WgDbDk1afzYHwLEq85KNb5qbz0+EvdnzpgXWnfc3RWJBu97y3uO3RboLzFk3znzNlEShHGrwa
 mRri/sVeo0rAbUjCUirYvhiXbK0n1FQI9Pt6nAixhXy9r80MswFJnqv
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: v0kXqgCj6QyiZ4ake8-eid_Ly2F2VjEh
X-Proofpoint-GUID: v0kXqgCj6QyiZ4ake8-eid_Ly2F2VjEh
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d480bd cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=nKf7ylKirmyFfaXDjPgA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX/fS7pEHNMaQz
 0n7liDqZGqhKkEjRclW4npp6y4rT8vZ3eNURldvMVx/zDMpqJyc95H2LSxx7iIqq3sSdnuIdpVt
 DvugZb5I75m3VuEqFa3TwPLSKfzeT/S7IKN4ylFBfr9xO5e5frP/7gVA+XtKEWmHRYhxS4+Bm0f
 rlS8DgwwxO20MNDYmSvjG9JtHZYUbQ2A+hvhh7xHZXzPMHmQGjTxZxjW3MA7hILVdmLZFtcFX14
 mB/pgsomEEEhQW4B85t/yozGlLjjukj0dHLB6+UHn5h3llgr75pC+wpBgImkb109BHJy9huXVJs
 uZrztPMXREPCyKkSkFkpu1WZkhkj05h5jXbZS0iho8C+aBsYT6DajcIOi3Za97uE+1Nh9R+mUJF
 DYLPH5e2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

Document compatible for Qualcomm Kaanapali SoC MPSS PAS which looks fully
compatible with SM8750.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index 031fdf36a66c..b0d2f0371e5e 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -38,6 +38,9 @@ properties:
       - items:
           - const: qcom,kaanapali-cdsp-pas
           - const: qcom,sm8550-cdsp-pas
+      - items:
+          - const: qcom,kaanapali-mpss-pas
+          - const: qcom,sm8750-mpss-pas
 
   reg:
     maxItems: 1
@@ -191,6 +194,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,kaanapali-mpss-pas
             - qcom,sm8750-mpss-pas
     then:
       properties:
@@ -227,6 +231,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,kaanapali-mpss-pas
             - qcom,sdx75-mpss-pas
             - qcom,sm8550-mpss-pas
             - qcom,sm8650-mpss-pas

-- 
2.25.1


