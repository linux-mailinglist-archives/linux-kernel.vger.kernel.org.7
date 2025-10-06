Return-Path: <linux-kernel+bounces-843530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C60DBBFAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 00:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7AD3A3FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 22:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4097217F36;
	Mon,  6 Oct 2025 22:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ICoNp2R4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C931FDA82
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789215; cv=none; b=dVFvkUSLHB37hkOL+D8Y7iDqUjeHRn1RLmMSoP4BWDfneqtlEMGcOdRWV4zxsrDYpoAg27iub2H9VU6veHgm2MyKiR9bLlM9yAt3S+6oi6drw7beCYkSLo7X0QNUHet3Akr6xtdPSU/y/uxP3V3HI06dZJaJR5Ku8oTQlDv7Ez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789215; c=relaxed/simple;
	bh=y84fa6fvuCZpJxjEsWR6XfroWoXIZOXTyVARiLBoUh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bbqmRtV8EWFXoCkmNSSOECyLMWwTCdfaIHYhEeBP5yHCLr1lmNXeWs5+zGDj/LBNm6kY3nX6URwpZLQnfpf0EEUFhuvt8CDUQ0v3aDRVmwbVtaSj0JCaiVZGkLuN8F7aXDTtk38Bu7bh7tiloxA+0aXCxgM7Cm0aiP/FDbxPyHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ICoNp2R4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596LKsrB018042
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 22:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=g6hGIMMv3wb
	uPomMpx8H8k/GiKEKmx7JPEl9gfJaIng=; b=ICoNp2R4zS26XwjqroKXK5XltGH
	CswvdsstUgTIoEjd12evPOYEDG/cUADcf/2e+dAvOIGX64SEGFu8+zagkdQsBYHE
	tTrLiGsjCDnMoPDr64FNK00D7jhudTTraCimJSZpOZyCrC+xAgZKjv7XSoxW2YsW
	mLrVwoLx/pVHZi1Fioa4mrxDlkrsUCjFPzR762PjZ3o4foM6n6z/7ExBPIHJ8+y8
	TZPPEHGYXUZBg9tMrAiwGKF0t1ZBdQtK/dRbaI+uZSOsz3trSFtZ9uT7Z/XS+kcz
	UucLm2y1evG37Rz4Y+4a/jDGLT4apOeEMbTvVj6cX9LZVOHbzftp/b4Tp2A==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mnkpr5h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 22:20:13 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-783c3400b5dso3380000b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 15:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789212; x=1760394012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6hGIMMv3wbuPomMpx8H8k/GiKEKmx7JPEl9gfJaIng=;
        b=eRtR4EZNFljqho/APzWSe8m/y2yJYderTuH6rtdQnGZgUpN2ByA9kUHfdG7FESD3UL
         e09h5DbVaSZ0SyrPDqc7BZvKz7Mvo3/yU90YQMIuWWG/gTb8YGHfn4TxhnkzbL/T7KbH
         GpRAQW18524uiDOVlFqrEGK7Mx26rKa34K7zDYUCKsnahBQFVXXlo8tHKq9x0VyrduWF
         qv7SxqVyiriU2lzwZtqVcE6qNbdxZhefb/m/N8g7l0wUzq75/ymJQyoYpcosPzujvMtJ
         /ze/A3zgT/HTbXEQt7KGG3CtQd6SEThNTGksEty9GZj+bDOhSjVY0K6jXFL6lRmoHYzU
         KGcg==
X-Forwarded-Encrypted: i=1; AJvYcCU9R73O+8h1ku1ENalj8JMvNm54VCPKkORUapTj+iGrPs+lvGnEq8f7c2O6UKdBDoeG0ds9DYi4bOfh5BQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGo7481JR+Lh7a3OWbLUfMSeX/I7JA1M6LNzrFLBFVnJ8HwiBh
	aGRg5gEZzisswtMQrC++C0GKm2X8EAfjxZdjqsg3u4zzJQqXmQID7pzK3usB8VJt0ojyUgOlhjf
	EYNSnQD2y027qmhPVCYXDPUpPSfyps2yJhA75BbzjZeyPV9/bhjZM20oj6r7nav+CZz8=
X-Gm-Gg: ASbGncvXDv7jfcWL6eqou8pKaEhB3Cq/qBSyD6Q+/SXupZf9/v9JhYwCkiLgWcpz2W3
	IoALgLr+sECk93NWzcYKFuI2rGVzOlKBS7XX9WGIeo2jz6B4MRLz3dG8AkQI+cC2GZfMXHOfdf3
	rCovuEDxQ0iJBfIaOzVFtggT0c8lotAgmA/en/MdVbKzBjzXiqWbiSZm5MgQucISanv5xTi0d5S
	paLVJ7SsDc9DhKGbsVyRtwU+Ew15qVT8rVQrfQABLx5WAfG3NJPfcoLwxmMD6OBzQNZfrZlkNlB
	YOJz8Ax1qRLBImLOyqlQpGK+lPVR9AiUljZgumPtyR5W/ds7HNU9uBrd8IbD3urIV2LwPzuNiS8
	tiQlwZiwfdmHgjmhVBxV7Dw==
X-Received: by 2002:a05:6a00:3e1b:b0:792:574d:b1d with SMTP id d2e1a72fcca58-792575c7065mr731271b3a.14.1759789212560;
        Mon, 06 Oct 2025 15:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwVIZrtgir0jsxXPAjMTVqs04hKUgCAEt4yAQwrK5Enm7r/n2TXNbFI5l+MOzSFJexLm8MIQ==
X-Received: by 2002:a05:6a00:3e1b:b0:792:574d:b1d with SMTP id d2e1a72fcca58-792575c7065mr731243b3a.14.1759789212105;
        Mon, 06 Oct 2025 15:20:12 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb281bsm13734968b3a.37.2025.10.06.15.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 15:20:11 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, konrad.dybcio@oss.qualcomm.com,
        dmitry.baryshkov@oss.qualcomm.com, kishon@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v5 04/10] dt-bindings: usb: qcom,snps-dwc3: Add Glymur compatible
Date: Mon,  6 Oct 2025 15:19:56 -0700
Message-Id: <20251006222002.2182777-5-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
References: <20251006222002.2182777-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 1OUnQc9vNprMOQJa7uzQMxiV8Kx8W2st
X-Proofpoint-ORIG-GUID: 1OUnQc9vNprMOQJa7uzQMxiV8Kx8W2st
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfXylRzkp6Uii9u
 t2imqImc2jopUXxFStY7ggF1ookbRwLH9msj9RA4vwvqk7whnjxK9AC6hl24JeG98JiY4NqYe6l
 z1UwaTyMgsvdiEyPD+RoDEazPHvB+OjTCCp+G73eMlRlnQcMCUgtCWVKu3WnBZ8flblE+Oi2pHk
 COaUnrME4F5VYE3rQiw4vsnGjX7a/1jJENG4BN8eGVQZtJScVjmtmPTvP7A0z3dz/UaXThHL06p
 Nwl9vCqhBgMhQuZCxFE5a9SY7D9slZB8PiPLUS9HSMSm04vV0VOPWCr/0hJ6PW/t0rUNt556r0P
 h5pwct9WnAHB+kbL9Ax+k4FD5ntv3Vts5e0i1GcbGxOPOvVXILl6hdxIMrNf34XOmeBDDB8EyIw
 UbUw/CDrp78JlcqLy/ANQwx/Grpl8A==
X-Authority-Analysis: v=2.4 cv=BuCQAIX5 c=1 sm=1 tr=0 ts=68e4409d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=JYTQWVwI1XGucIoeipMA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_06,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060168

Introduce the compatible definition for Glymur QCOM SNPS DWC3.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../bindings/usb/qcom,snps-dwc3.yaml          | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index dfd084ed9024..eaa0067ee313 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -24,6 +24,8 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,glymur-dwc3
+          - qcom,glymur-dwc3-mp
           - qcom,ipq4019-dwc3
           - qcom,ipq5018-dwc3
           - qcom,ipq5332-dwc3
@@ -386,6 +388,28 @@ allOf:
             - const: mock_utmi
             - const: xo
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,glymur-dwc3
+              - qcom,glymur-dwc3-mp
+
+    then:
+      properties:
+        clocks:
+          maxItems: 7
+        clock-names:
+          items:
+            - const: cfg_noc
+            - const: core
+            - const: iface
+            - const: sleep
+            - const: mock_utmi
+            - const: noc_aggr_north
+            - const: noc_aggr_south
+
   - if:
       properties:
         compatible:
@@ -455,6 +479,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-dwc3
               - qcom,milos-dwc3
               - qcom,x1e80100-dwc3
     then:
@@ -518,6 +543,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-dwc3-mp
               - qcom,sc8180x-dwc3-mp
               - qcom,x1e80100-dwc3-mp
     then:

