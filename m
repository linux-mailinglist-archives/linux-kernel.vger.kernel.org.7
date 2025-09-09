Return-Path: <linux-kernel+bounces-807124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0D8B4A064
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5044E6658
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153492D8792;
	Tue,  9 Sep 2025 03:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PQfAQCcp"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A1B2BE7DB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757390231; cv=none; b=ftnUdDLVoyRrtixoHnR7lN4mEEGVf0X8cbyi2801ptC5bXVFXcatfHhmJ6C3prrA467P7fR9Bm4I+Lbu1MZG5BoQcNz9wJ9xavD0jFUKYOXe+t3Vc/5yCdh/LW1iOaELRFmt48FdkQBPFndK8W2voj9hsCSnHZ4sfcE297fI9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757390231; c=relaxed/simple;
	bh=ES0C/eHUJ0vZMSiE7e9k3eopudAsRoEFpDfAJn+GlGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qUNmYuV1sMZmY/AHNe93rM0y+8sUOLv25pmeaUL3faHc38VAyMudpggyiaGwsgteg+9E7c7DoNTAMpfZiPcMJbzpxMHpZaZ0uoqfA6VtvIPyQxe8ZR9SUJlF5Lf/gNnbN9eqJHt39IrfxiK8mnlN3fNshPDiqO2b6ob5JC3Vx7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PQfAQCcp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5892Eckg023725
	for <linux-kernel@vger.kernel.org>; Tue, 9 Sep 2025 03:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jWgEnfKM2T8SN4ZowpfF7xlxhdEVJCQ/+pQl9CKBY4Q=; b=PQfAQCcpNv25AGdC
	k3zF9v6fO0zsF9XGLndD94Yks/e8iodqIHUDBzc4GKiHTYMBHsbtKpDVZRMuCW5V
	2hFSZh7yDHiB7AschATHXhLT1QW5NDBwvzsLtEG9Kize/YEG7nJItsYsyI+JNF9p
	7qhhbszG8ftkBfbwab7khyGPHQshnO0uUqjBqddw067I4crnzI31wk+E5gDQhG3J
	1gaTUu+8LuSYI7buD1cRLKYGdq6KtXxnYaxp9zR1LmVrWHWI+A7Dam5fiNCsWTY/
	y0JCluF8AFr7mQ3MivV+pj6bFXNEsYpL7X9F938MtnNARqOoPvYsX/JTzZvWACU9
	EYdcFg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfxmyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:57:09 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-258b7567e8cso7130115ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 20:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757390228; x=1757995028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWgEnfKM2T8SN4ZowpfF7xlxhdEVJCQ/+pQl9CKBY4Q=;
        b=eMKrDE8sQusSMZqFWm/nVykaoxKh5K99Pd7HUhZtJ2R+SA2lRG6HeRKmYBLPbBGGDR
         N02zvh5JbabdXC269IeYtPttHakfeW/R21PyZnC4FzLOufjeDdqThThS2XQZtU1Yvu2y
         5QKowtPmDJbN5hPLuHVBiLgIVcbBbo33HNrusAya14NQa02pizI4ZB20YBO4PWOop7Ck
         7k98aCEnTgpkFTEkk8LmDio/PkmMEtFsOGy7vUHMQMSW0Mn4ADkmR3GxZRkX5+FJSl8W
         lJ+QUMFxpP4CU322VSoCFuncsK2fh4rAIDqFwKbbAATHSoDxQGL9HaFxTrNcxPTozO+5
         efnw==
X-Forwarded-Encrypted: i=1; AJvYcCXibwPg9BhMvHR0ejgYKgRgMYMcYeaocJ2VE9e7aWk+8tChZMT11OrMlQvdnrOJmWYVcA7c2UWsXb+ZdIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwmWgcyiZ/Pl1E/0BgoSDQ4ctEdB0LSmK2igiWxFat2MBVQSrL
	qhHssEt9nR4HEryK9AqUJ0qomSKqXdKVYpT6JQV+ndI0AU0U3a44JqmdxextN4aJKR3A7P/yynn
	u27CBxtihOaiubQsSFbYeLTJAGM2MYRoccAC+CqaOxGxSulAz4bSVayAaud0vxngPiLM=
X-Gm-Gg: ASbGncuNA47qJAL6y+lgCE4tgknTQSE+TSkSJNK03ZaUZvpBnRF2bQtpDXJ1offXeb7
	AFzKJsy3/NpSjVTvFwbLKvRMd1uzTYXu7EGcsz1+VQERZPKVG1/ajI/nJf7B//+5bb1w5yVUn8P
	aPBMv4c+VT45Rnr8/ZquLezTp78xXDOQaoLf+s3brM841Kl/j7LMe/YBwomMGla9kGrojXB4tK7
	VoRmJN1vqh0QF6sFdHlXdlWk8CjJH6FhAnXG5DC3pDcAOLc1viDjNMnIcOxiGxGdS3osTNMurd5
	3tWH5o5nPRx4nDMfXv3+hCj+pjzji3MDngsIjgqmDHpeJE2Dabj1cZoDxGcZV+Qy1lKvLA/iD9T
	oTUmGPgLUQNX4Cfs8gymsIB2U0rl3VPNmuw==
X-Received: by 2002:a17:903:2341:b0:24b:25f:5f7f with SMTP id d9443c01a7336-2517301ce47mr117389655ad.60.1757390228111;
        Mon, 08 Sep 2025 20:57:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7mb8A5aGCoWDkFtmq3zKoivGwv/NkrXlnqXNe0qaHkpZDB9o4nPth81JCgbpm1rdwKkhG2A==
X-Received: by 2002:a17:903:2341:b0:24b:25f:5f7f with SMTP id d9443c01a7336-2517301ce47mr117389405ad.60.1757390227655;
        Mon, 08 Sep 2025 20:57:07 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903724b94sm295614705ad.35.2025.09.08.20.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 20:57:07 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Tue, 09 Sep 2025 11:56:02 +0800
Subject: [PATCH v10 1/4] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-hamoa_initial-v10-1-ec10057ffcd2@oss.qualcomm.com>
References: <20250909-hamoa_initial-v10-0-ec10057ffcd2@oss.qualcomm.com>
In-Reply-To: <20250909-hamoa_initial-v10-0-ec10057ffcd2@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yijie Yang <yijie.yang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.15-dev-5bbf5
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757390219; l=1177;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=ES0C/eHUJ0vZMSiE7e9k3eopudAsRoEFpDfAJn+GlGw=;
 b=t+MQ2tj2DlUWTMPD319N41fItYvc6WlBPuP6qjvqrM7LQti3yXgplmhvKWC/kkods3Q1hCVUJ
 4brEley0ODPBDkBxjFhpIGlu2um47HL1e6y2kAgPoK0SWvVvnxbmJSW
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-ORIG-GUID: fI0SvQvqJaCMICAkF-Oy3qtTq7OazAyZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfXzGvutR9Iex+K
 7KF7JYCMwd9ivafuRvfRVthdWHNYuNABcrDUdwq6PBOY71ao3Feu4d0caXQmqoSAzrwyxoFgE/y
 0Pm+wlS78Y8qvuJQIDvJm3sCe4Dc4RXNzYXz2m7UA+SPOqf7pt+nJLgY6UsjacX8xJJuVg3jaRS
 vHCKoBspP3WEj/bdSI+iEvI0xW+mo9JZIscV6wK36xnqk/GbUz3+umfRpGx1sTr7MO/KwMyFN5Z
 Wc+1I+f9VTJVKa2iupq1WELW840jTRHKlEhL7ok83CHzyJflV2I3gW15quoun2TuH3TKuYlPGPL
 HZdo1ii8JxSVb5HbwEeZvFJlpVs3/jw9vsllBjsvZtx7XQBhdW2iZHSZBiNIoGkYOJUzUXk44xD
 dIuUeRnX
X-Proofpoint-GUID: fI0SvQvqJaCMICAkF-Oy3qtTq7OazAyZ
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68bfa595 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Bh1HEMNN3wmc11-eFpoA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

Document the device tree binding for the HAMOA-IOT-EVK board, which uses
the Qualcomm X1E80100 SoC.

The EVK consists of a carrier board and a modular System-on-Module (SoM).
The SoM integrates the SoC, PMICs, and essential GPIOs, while the EVK
carrier board provides additional peripherals such as UART and USB
interfaces.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 55e5eb75af89..6b6503181ad6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1069,6 +1069,12 @@ properties:
               - qcom,x1e80100-qcp
           - const: qcom,x1e80100
 
+      - items:
+          - enum:
+              - qcom,hamoa-iot-evk
+          - const: qcom,hamoa-iot-som
+          - const: qcom,x1e80100
+
       - items:
           - enum:
               - asus,zenbook-a14-ux3407qa

-- 
2.34.1


