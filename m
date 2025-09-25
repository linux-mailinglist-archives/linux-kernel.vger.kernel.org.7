Return-Path: <linux-kernel+bounces-831479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D10B9CC7F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F09331BC43A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AD619CD1B;
	Thu, 25 Sep 2025 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GlYZhEI3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500922615
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758582; cv=none; b=sxU97lzPQGFDbkLTNQjpvkfmUMWaKz8Qcj8ecrAuaO3lVEJ6P7MFLYCXIxe2l/FzfXfdXm7RE9m+bavenFHHUoyRqN+iprRTYiEYxqOLpfzJtci0o8AXd8+eAdKlOBToRs5IwLYikASorfJkdEvDoDAIwUeB/VgLl6kMlVuCT6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758582; c=relaxed/simple;
	bh=K2mUDJXRZv+9+neVDLWp4StQfNo9IAdiHfJqlB/hRI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dqpa2+cU5o10a7VA34SS/eBe1rkbbfUibpm1t/OxGslq+7H3d5c0r5abEJne5FRN+WEV/Z5MQK7Pf3cBuujzWT250nn7pN28EmUtgRSzYf0zNr81xnPAOJ4hB0pSDWQ3UTPzhzFhrdUNueUoOWlGW+HzGr+O0Lzya8AyU86d3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GlYZhEI3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OClqKK025248
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:02:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q4OBEzR87oFsou54VovKNGgttpO9q+7QSRhhR2iSBns=; b=GlYZhEI3/un0+yt6
	3sVafURjzYYKuUyRoCOOxfPU8j6WS2hlJKW+i/xczYuOlLFB3BTY03Z0/eXM2DKJ
	GHl+1/18ff9kLhXvh/baKJzhg3tstqIW9NOQTS+WfXMlxEeosmf+rNUPcHHMIjtl
	cJkQEG/Z2BXOTG+2GcAeRA2N72Bu94ZW4YHdQ0XFOp4k8Cs9Bljlnm7qXG/oNDX2
	rOgjeIU56R/PMLnXubAPCOZ6Iz3yzZCjOw5bfkZehHahe1O/3q6Yx6lqLpVJ0Pc8
	DHFZADrarVnYlkdwzW6IKqZZ+BkKzbmC6JWpIa5l7yJQYhxBMgUPK52ibfxq7VOk
	hLkSRA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv164v8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:02:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eaeba9abaso605893a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758578; x=1759363378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4OBEzR87oFsou54VovKNGgttpO9q+7QSRhhR2iSBns=;
        b=ImDEPybMKE4YkL8fIghRbUMdTlV2ytM7gl1cq701ZxqI12wdeZ4hSVAZXEG/INffOF
         9+qm9FXIRTtafpwEUji+XuCEh7+prYpXCa429+avk5u4Bc8xrURjFdmKNvI8TJgWWioM
         TCNpvB1UEMoWizgG9x2LgcmhePOClib4gzjs6TKMGseqPUgpWLZ0AiPHxNqgGL/rsqRf
         jc9sBwKQKR7hMCR4yeulpPVcHPgc6ZgJuwGP3oqUiE5U0eGhLwzWd29XMdzStW6/DOp7
         Cxte8K1XBwfYn9BeDUIIzvJhqd5HDAVpwHT6bTAnYdrUZ/BTzlF5qwdHKQrZIQswff5a
         s93g==
X-Forwarded-Encrypted: i=1; AJvYcCUuDInyh75B2bzKU0CrB39C5odjX6iT5Urld6H/gwQZC0guYxr5h/tdoR5cqXYL/qj1J9hs100ArK3Hss8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyms6L3oUe1jR/mgEHRa/UhxLLmpl0cl8snfQ7NJEIQ3y4TQ59k
	Bk8upAGmdASreH2utSmFZsnINH+jcftoS3R1lj/DtJQ+nx++Xl48t0mq4zPHPGztUBw7/WE4Vza
	tjRJ7zfyhox6MUx5x0EKe0GliOkFox03YTPzjIHrFyUYcxjbNwhAiyBobMlBJ+AIadYo=
X-Gm-Gg: ASbGnctokKPDU/qvuUOayb+51hbVGXIDk6TuKtqyzXA/C+LG745SVJBHB8ExmxEykl3
	4DLZ/8Ow1ecakePnCXLplCgpFpXbuKSLw5maIhKWPDomhG7OhNAKnYrLeEPfjRCWDkDhqcD2lm7
	V5tT62LxXR2soUhit4ckt7xwI51hLtp7HIlC50mnJ5CiY5DEp683WQRvTqL8G7xG9qd5FHks345
	TeKmIBUg8n4wRn3db6z+b19nWB1S7TdZQ7QjYhbCP8BeNYicjbxTyzsX8iq3YoeDOgnFjvOZh2m
	kS7tz3skVIuDqQMqRoDdLRBC+ZPxM6nQcKg6BCpLZC/fASfUyNg9RMEeLiJ7Vlukxsdyf0wfboJ
	tugmrYfd6X4txb2o=
X-Received: by 2002:a17:903:38cd:b0:27e:d4a8:56ad with SMTP id d9443c01a7336-27ed4a85a82mr15084195ad.61.1758758577882;
        Wed, 24 Sep 2025 17:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzjJDR1kYcH4sQH3cYrBVjWXozwj8iO3NzKQVXwBx6AN0+o+X6+UwyN0HdpPfs0t5yyVWI+w==
X-Received: by 2002:a17:903:38cd:b0:27e:d4a8:56ad with SMTP id d9443c01a7336-27ed4a85a82mr15083975ad.61.1758758577445;
        Wed, 24 Sep 2025 17:02:57 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6715f0esm4807215ad.52.2025.09.24.17.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:02:57 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 17:02:48 -0700
Subject: [PATCH 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-cam-v1-1-b72d6deea054@oss.qualcomm.com>
References: <20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com>
In-Reply-To: <20250924-knp-cam-v1-0-b72d6deea054@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Bryan O'Donoghue <bod@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758574; l=1486;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=SnKFLRNYosTxuqZVX+B0aQPl8RyL1Uf+UAocMiXuIuA=;
 b=sygufknQTjfr3CN/gzxxSYpzHqiUEqe2z6cQAJeRpI62jPUmwGqLOqCZ4lU5kQpOX8jV1Zgk6
 I/2lCxstBxCAPrx+cOrLKhy78j8eeMhO4V5GWgSZUOsiJAAUqd+018Q
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: ZXoWyVZEGAYy5d22bU339dE9oOAlhdDF
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d486b3 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=MM0Ubo5ZH5qwHtlmS8kA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX7nzf4VfS//5V
 T8x7RE+0UHnIL9eqfjTb0jfoYMKjhPSlAzYhMDFG6BTpLyWNqWXmIR0QGVSd6fjpbkRZMQBtBPl
 f7hVTiegimX4n847OU9LTl+VsvBdYidvg3tlY3Ae+aUXkGR7o9vQ6oQLFuK03+Mbjbob+EX6kAu
 0e5U66wRHUfu+MdR75OlFF+qAN4QzT6hfK5Y5U/IzLY/xqfImgf6zJzk1lW7dBAur4XNXxYFtUA
 a/YbY01IT/twOA+jfVFLr8KPgZ5sWtBYOdOYMTF+8OmagXfr5i/xJOI4mHFJvuO7Uxhx6oI3Djv
 Ag3W3gGNiew3GbSFaXgsMLT2PBgUqvWcapZI6n4TWl5i3tRuyXmNkxta8I68fctvpXBJMRgoVvo
 fuU7BO43
X-Proofpoint-ORIG-GUID: ZXoWyVZEGAYy5d22bU339dE9oOAlhdDF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>

Add Kaanapali compatible consistent with CAMSS CCI interfaces. The list
of clocks for Kaanapali requires its own compat string and definition.
This changes the minimum number of `clocks` and `clock-names`.

- const: cam_top_ahb
- const: cci

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 9bc99d736343..85a1c9738afe 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -25,6 +25,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,kaanapali-cci
               - qcom,qcm2290-cci
               - qcom,sa8775p-cci
               - qcom,sc7280-cci
@@ -257,6 +258,22 @@ allOf:
             - const: cpas_ahb
             - const: cci
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,kaanapali-cci
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+            - const: cam_top_ahb
+            - const: cci
+
 additionalProperties: false
 
 examples:

-- 
2.25.1


