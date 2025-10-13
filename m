Return-Path: <linux-kernel+bounces-850007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F66BD19BE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A24F3B8DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0A2E0412;
	Mon, 13 Oct 2025 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VVkEe17o"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD5B2E2840
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335906; cv=none; b=idgLr90krZp/mKfaYZXEcn7oBDA1s2YPAAN0ygrc/L17jR7dIG8DpFb6di7XWb2zHlg63xne7SEjA35r+QWQfXmxRsRj5tEAtE3HOM45aLLjv5y48Kb2KRDFv+g6LvOKp/JjOspbiI6wV1fE+ee8k0fYBvmPNf3EdEcRNWH2N1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335906; c=relaxed/simple;
	bh=ril99Wt36AaQWNv+PDjT8BlLjpjvdFqefjO73sSkLmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jzhE5VTZwYZty7I5j9jf9aIOQFkCzgYP23oRr5AKjuH0h/B5v9W8OK3B/MzJJrcqeb/4mH/Hvo3sNUQb9F7ebZpB0R+BGs/NcW+kN8Epyu9D6LVgNMRPzbJmjyicF4mcUJgQgOBGV60xyI9YjIm+dAQ8lnr12Q8a6/Y5rhoOLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VVkEe17o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nMMq005399
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iYDtPrC3G6SjHluGEZkqxO1EAHQjQdzxEg9eUYrW+6M=; b=VVkEe17oCPV8uPhf
	QFMprB4pBsjr/jsvuiUR3AFthZI44/2qHNQIgmIF/rHd2pu77KbuhDiNeokJVJD5
	E94to2/M7jKqB3F7ug0iaennxHjIrP4wHLWIk1+eug8MBszbxMmlHzBeeDcp5d/q
	dCeYP0TTdIm+7PNh2t8AfzJY4LZccKHnavjJIZ0usL6RgCUAFFN2eUYvMmMRt3OB
	rEtV2JFsocwDCZCHp6F3iqFI2RF/PAvrtVUEgNBRBlHR3gMwE/mMLlDPlU2dE8vo
	47zrcFZVaMbwJojuxd4PPGG8xsWh8dEwkY6by09syQPgoR9TudBrPZMCAr9FbOup
	MflMGw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbs3e7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:11:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-267fa90a2fbso103581565ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 23:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760335903; x=1760940703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYDtPrC3G6SjHluGEZkqxO1EAHQjQdzxEg9eUYrW+6M=;
        b=iKQSzuj6UjmfJRz6HaLnXZHU6l+R5TV9wLq6PUSWQcgTd+KSf5L9wChAOZWzsyc+r2
         UkJ8bSzrhLwT4CQB8/LcX+aiH6p/MuwiiMTbWaCYbW5Q8YoYChzxBcgxL/L/rcdN0Ev0
         RP+NriuFG1QTDnkSmOP1gdscJ4Cgvw8NR0MH78ek6jKWeH9u1voNnbcYECZ7L1W+eJn+
         Ni4ZjQpJ5o3YEOGDTf1TgCVMgJD1ZctK782E5UJjlw0nBm49y3d9LO6waMqpZUhjayNm
         Y24IyY4SwiEVeRBGuy18AwODC5UNp2CDyI+MTaQDWoZk/lnWWeG2JjnYijCKg8kbbQHa
         cnkw==
X-Forwarded-Encrypted: i=1; AJvYcCWwTeD8EgvsjH1Wrf9ROtUyCMUG3S0v5tNL0CvwHRiK4aAAKn91ZwmLir/FM4n3A9kFCxSmOYbzlz0W5mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8AMFCqw6pMoT/zR5P1yP4VaInTy1NBvGsNniJaNHNlxO0FmUA
	joiz1Z5h6rMy3aNh9uQ9bYtHu7TKBn+znUMT+RI8SEcWUfOYSLS+CSj08aPGWMSGliDNnWCaKvp
	0RpxY0ZzlP7PUTztPhEK+OR2YWHvP68Gxal/ggIgiP0pn2fJtz+FhKN2upGMUIEIX9so=
X-Gm-Gg: ASbGncvu8epM0Z3G0XP+bCS2fxny75xBXOrx38bB2itXgTI6oBAKVjxMLGRP+6sAE6t
	l16vEU5qb8YgfpgYnxRljR9AAHTdKoPFGTHjuM3zFQDTWsIty526sELPHVXc2Dvj80XSsQncO73
	OnFFzkkYvqTNsmZLDCc2UO5eK0VGccH1UEr3BQOGDkG8bd0+8bP/rVE9K5kLv5UUyS5g+Tad1hK
	QVhVfrXzzaTaWNwLPELS8oi/G1lTrlHILedLoiXwYxqEznAL0Gz6CrvTY1B5LnvCnJ46PjcBdFU
	JSdmMk+HKZct2z/oTrBd1+6OHA8k+2PKNhrz6pvDR1bC3+WKkNHG2uIQ7AAt0YOBw1t0cviBsgB
	FpikZJTWD1spHv2lDJHnyhTAJr64=
X-Received: by 2002:a17:903:46ce:b0:26e:43dd:ae77 with SMTP id d9443c01a7336-28ec9caed29mr272651905ad.24.1760335903089;
        Sun, 12 Oct 2025 23:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEULiUky5u0eNgxl6LX527XaD4MnbBTJXkMtMbnf0uwC+4g+DhLvF8iPLBmq67+54X1JcIZNA==
X-Received: by 2002:a17:903:46ce:b0:26e:43dd:ae77 with SMTP id d9443c01a7336-28ec9caed29mr272651735ad.24.1760335902680;
        Sun, 12 Oct 2025 23:11:42 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2904f61a1desm64388675ad.82.2025.10.12.23.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 23:11:42 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 14:11:16 +0800
Subject: [PATCH v3 1/3] dt-bindings: arm: document the static TPDM
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-add-static-tpdm-support-v3-1-a720b73e83db@oss.qualcomm.com>
References: <20251013-add-static-tpdm-support-v3-0-a720b73e83db@oss.qualcomm.com>
In-Reply-To: <20251013-add-static-tpdm-support-v3-0-a720b73e83db@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Tao Zhang <tao.zhang@oss.qualcomm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760335892; l=1550;
 i=jie.gan@oss.qualcomm.com; s=20250909; h=from:subject:message-id;
 bh=ril99Wt36AaQWNv+PDjT8BlLjpjvdFqefjO73sSkLmU=;
 b=HvBZBhPoXjlRC0YdVww2PK4swhc3dY0OMjVa0IXNyNsiaBHrYx6rix1xuT7DU9SRmw+65geZN
 kJyQ54ZKrmwC+pp8TNSXg0alrdswDbuTaVRsA3/6eNF0p7W2T1KcFWJ
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=3LxxUZRPCNkvPDlWOvXfJNqNO4SfGdy3eghMb8puHuk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8igkiNaw4h4/
 cRUAYcyn1vpkgin0Cg676IRrr9BK6Zw1lPitp2s1gcyC8OH3UDVoc6kqGj0gcuFefknObBsnyeS
 6UUGKH8MIO5FJtqsUGFM15a/AxzQiF4iV8D7uxLIQ4nqxnbOBoHb3XBM/F8kamKOFvMjMQN5t3n
 U6sHLk7mv0WeyT0+ZG18sc1dtFQoZ75JHhwuj/UAZf9V0PXXBYt7/+o+dk4wEpYK/+Bw7DNNNXX
 RiRGXJtmFRz/B4U/dVjpOO8NZxPeIsrE2P4u7NF0556Rq6/dey19zodu+fLG3TCfTRwTvUpTTuO
 Cv17MgPX5Rhc6cv6OatuBTwIJjE8DTWn9/evsb6fajf7T/vp0hNF7COk7cE8cJpWOvJMzKKgJIe
 cJI+H+iO5QRixBAIj672eELdB/cvow==
X-Proofpoint-ORIG-GUID: gTMhVhIcsEUxuiMHyZByzx0Z-_bm8vl8
X-Proofpoint-GUID: gTMhVhIcsEUxuiMHyZByzx0Z-_bm8vl8
X-Authority-Analysis: v=2.4 cv=U7SfzOru c=1 sm=1 tr=0 ts=68ec9820 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=5Z_N_GBq0btHVWfAyk4A:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

The static TPDM device is intended for sources that do not require MMIO
mapping. Its compatible string should be documented clearly, along with
an example illustrating how to define a static TPDM node in the DT.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../bindings/arm/qcom,coresight-tpdm.yaml          | 23 +++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
index 4edc47483851..c349306f0d52 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml
@@ -36,9 +36,12 @@ properties:
   $nodename:
     pattern: "^tpdm(@[0-9a-f]+)$"
   compatible:
-    items:
-      - const: qcom,coresight-tpdm
-      - const: arm,primecell
+    oneOf:
+      - items:
+          - const: qcom,coresight-static-tpdm
+      - items:
+          - const: qcom,coresight-tpdm
+          - const: arm,primecell
 
   reg:
     maxItems: 1
@@ -147,4 +150,18 @@ examples:
         };
       };
     };
+
+    turing-llm-tpdm {
+      compatible = "qcom,coresight-static-tpdm";
+
+      qcom,cmb-element-bits = <32>;
+
+      out-ports {
+        port {
+         turing_llm_tpdm_out: endpoint {
+           remote-endpoint = <&turing0_funnel_in1>;
+         };
+        };
+      };
+    };
 ...

-- 
2.34.1


