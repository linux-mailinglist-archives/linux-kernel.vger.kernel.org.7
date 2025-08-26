Return-Path: <linux-kernel+bounces-787151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968F4B37207
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 20:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52EAE7C8543
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920EF369345;
	Tue, 26 Aug 2025 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K/2fyven"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD952F28E3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756232128; cv=none; b=KvRHZYDatyNgBnLCvNaOlsCaZ7h2PWgjLRwmuu9sMIHcHWl1dzZX0GwB8NNO9CESvwh2xsKOhVNzlinOWk4Z0pT7nvJtmb19/L1eWpxrV8UalZuxhdvjdISx+Ga9qM6MxpkTygLbBOOnilqq/xJwP+j9IWjBvH9rr5LYiHcVov0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756232128; c=relaxed/simple;
	bh=0qNN5G0trkSGssI8DdO6WhMsx6naV5xeqsAx0Itjr2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YEvPSm76KikH3iO1xFqToiHqTvDdu5TLbJebXZM1g+cjVrK/NgYMJyiWfJmajHYqqf0iMVFHKL55VMhvM7/dQi4YxdcDCOdF34fBCrDa2D8LVMmEhTuuCQSi0yswj6tOm7ztFLlcG9i9J5cUkm9qqqwwBkfdk7JgT1Sy8bJrvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K/2fyven; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QFEkqL012095
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+ihNg7dapi0
	zoNoXXHZt+X7WOykNzgoKa/7zoDikPNo=; b=K/2fyvenmJ/P2YNPLj/yoDyeqrq
	mnUhkMHsKkwfrrhnW4GiYlQ50foZ7eu79dhse3IezGAcjREDLTEQTDvpWG5cEdH8
	21Jtcw+eIC1KqeZ3IhqcbDcc2GSVHbYcG7TgKzmPdix6JndqW104kX5oz8OTqWWh
	XGhuNvkvjZp0zAjxBns+uR5hOPIzY787c592sFdyX5qrqKELg3utNIJHbigNhnOb
	LV2rYtYetf7qxpxfB8JFdj+VwmprPu1lZ5+fpvRI//WZi8vILxxAyOdRTE0yBGe1
	9FC0VBzqXSFVKftsHyBni5pELYMj153FBOGTXnnekgQBDDK48KxqNsLFWQA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615hvd4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:15:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24687f890e2so5088055ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 11:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756232115; x=1756836915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ihNg7dapi0zoNoXXHZt+X7WOykNzgoKa/7zoDikPNo=;
        b=NKwVsS6Zhvuc18TxG8QYUXON095AqDQNE960hybpekw6QoJb9xkR/dEW5LajlYNZMa
         1LhqU+/Vpad9YGewX9eeQyB7mPqfrHeqEuPtwh5LhctKJqnqRA+LMCx3u8DKi19XFdf/
         i51IqClX1pR7gxopD6w26XibQhQszEnbf6ADMR0+ukIogmoMMh9y5PnPWL0MrBLx7ope
         JFfw06EW0SHMCDjaD1Glgx3DCxsBK7zN5ObP49l1COnRdDlzugLMWt8bS1Ihvu3eHg54
         F0DjdRb8AEGU5kiIXLMAUZ007mE2VEZ3DNaV72AuqCwZUmkKmUVBfzuqRWuN4LeIjgY3
         nqcw==
X-Forwarded-Encrypted: i=1; AJvYcCUl1GTnZVCC/zyEADuF4QW8rifNRtlpBuMZZBJ967Pnm4+b0HzXbt0mFRZNthEu5aQTmVGGRoBZm4a1iOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw11PCjOLz2biz1cEiQuknYAnr26ez7+O7NmAMxqjvLQ5vOb1oY
	0haBvc1EsGJz25To87GfRYfJlylCt6VQU7N8zn0c1mtDVvCTW26RQvdtXQy0Osk4Z8ECW7bolEe
	jTCd0OxP4HghKM0+ZMsDz8o2/4T8VXlN476pJGzOf5Eg7kQ2nYXLw9Op0E01jGJcOYsA=
X-Gm-Gg: ASbGnctt1dRdAKmJuDjlSDD5EdrjCv/lNSkI4klIYF1VxglpgfPdh+eZcCbyX8eiw2J
	tK0nTDMZ95wEsE7uS5JkieY9RWV4XWN9OFmh/mNTr2mlRzwtjug4u4g/gCLosv2n6DEh9/fNeIS
	1Ce7/0JMsxwdAXr3qeMOMqUNmVgiTL6+vbfAYH9rQfjN1va5qLdB+ka7Tr756t2VXEjPYX6ZCw1
	WWaLdLfgHUGls+gYkJcuTs8mR1sLqsgtPQF7tyrnRK4BVtmU/f8HrnIBKwFEtT7wnygbF3QH4kU
	iT3YiW3kFZ+VHUNnsJpqJHS6MX2c1XnpUlGMZnI/37cbcz2fwswuH7FGn0kK3zj5G/4ww/Y=
X-Received: by 2002:a17:903:2f88:b0:246:b35a:c655 with SMTP id d9443c01a7336-246b35aca38mr69796875ad.8.1756232115037;
        Tue, 26 Aug 2025 11:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGATiV+04qck3dgjysFlVeEpbFtlXyRspOnVjNEGZ5zaJRMGiEP+KPvuRcHNp7ykWZ//qnDrg==
X-Received: by 2002:a17:903:2f88:b0:246:b35a:c655 with SMTP id d9443c01a7336-246b35aca38mr69796605ad.8.1756232114565;
        Tue, 26 Aug 2025 11:15:14 -0700 (PDT)
Received: from hu-uchheda-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffb47b9sm11065536b3a.3.2025.08.26.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 11:15:14 -0700 (PDT)
From: Umang Chheda <umang.chheda@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Add Monaco EVK support
Date: Tue, 26 Aug 2025 23:45:05 +0530
Message-Id: <20250826181506.3698370-2-umang.chheda@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250826181506.3698370-1-umang.chheda@oss.qualcomm.com>
References: <20250826181506.3698370-1-umang.chheda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfXxSjDxstxxs1v
 9azqW4fUZyzuPozILMeUhCLxK6ZwFmiQ2oVrTLEeruvLu7Hrc0A3oiqxo/ju1v31NKxrx5wMjz9
 PH2dtbly4z4OW4dJUko4mf4ppWSfYz8529Vz+0kz8cZlEXZuTMxbirwNyay0CHiC26PzXl35y+I
 wfgx6VFXh1aBEtBnVKT+DcoCLCXpxI7JPHYhF6t3+FxmHYO1RzuI70Ev/vYkltbr5tmLuEwCuWU
 kXVAs3gNzOUjXl2xjqtaDQsheGKqfWf82ca2cdltBTIwwbIuFA0T42tbAUtBhE6YY1EEq4F5Mpu
 wXquPbXzygn3Xm/CU4wK+QPpzDsPwRn2h3gQjFDb98mYVHDtCTC2emDqAsJvxV+uh5yHYFlQVPi
 BxmkRsKn
X-Proofpoint-GUID: xStojxwg_1g95eudVfwYnyW3WTt1Zprj
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68adf9bc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Zd15BVePnIxtF9Lu70oA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: xStojxwg_1g95eudVfwYnyW3WTt1Zprj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

Introduce new bindings for the Monaco Evaluation Kit (EVK),
an IoT board based on the QCS8300 SoC.

Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 55e5eb75af89..a4b125f83450 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -854,6 +854,7 @@ properties:

       - items:
           - enum:
+              - qcom,monaco-evk
               - qcom,qcs8300-ride
           - const: qcom,qcs8300

--
2.34.1


