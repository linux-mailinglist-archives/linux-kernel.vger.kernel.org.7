Return-Path: <linux-kernel+bounces-831537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A09B9CF1A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F312A1BC4079
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA002DCF57;
	Thu, 25 Sep 2025 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jG0gFhdT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A6C2D8764
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761562; cv=none; b=QNBWaGNhQv2zsBnIKaE8oLIwBsgxBrEykWcyBAzzY/DNNhkGKlUTL15D08BndIf/seNfy+P0WrJeA78ihMr/lXnJuIK+ZfHfnaqdfz0M5b4v0ezXN25jUdYHM04sGypgfoBQrLAbBhHpAAWn4Oe1Y174arZG6x+YKJxihaBC76A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761562; c=relaxed/simple;
	bh=hda2Xd4Mz5OnSn10548Jx0ge0zF0dKZ+ZJ+uSDZXASE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOWDyT9amTyToA/0740MWSZwYumLBHrzd72fMrJ+jOnQm9Ib76b7ki9F2sBUa2PT2TmTFgcmKMzbb8fqFi1fiaski3LAAUxq0KOH5JckjXmKVCg6MK003Z6aW139Z2pcpiLwcSuEffvdnyplu8WsAA5BnKMKPTNGtERT30jnYAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jG0gFhdT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONvNwD017438
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DQ/0YD5xMRw
	3lWfka6oyOcJAqHz+tEBt1EbVwdyanDU=; b=jG0gFhdT1ZR4yFW1qAdyqzM5cwE
	23kn9L+vW4x5gSgFe4Y7tl1FAvNV2bIZFbJ9qDbY4VSLxRhdeVzCMTrscGjVqWGH
	d68AcVYKAFRltB4xOeSokbcpZ9mduO4i0PDQLFfDcl1ooXjQrN2edb7uuLnhtStP
	zFLeOY6g0GLT5NH0CgjaUOXXTCjUzIkzDFOUczUcE2lXkRfj8a1ys0S6qRimOQEY
	sfn9lQUEjuTqSxIAqbf6mu1BMSj1Jz8wH8GbMqyrb1tkqnHA8P2GF0DtS0cWhiBY
	HEpCx1stZyN7QZEKULDZaDVW9ztT7APV2tq0/W9DTpP1/mf3fIuJm79M09w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjyj3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:52:40 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-268141f759aso3419305ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758761559; x=1759366359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ/0YD5xMRw3lWfka6oyOcJAqHz+tEBt1EbVwdyanDU=;
        b=Ey7Z4ezh2+wsbrK1Zyq5iR0K7DzgDkT8A2YTy/IFHgP3l+7FgW8odkErF4bfsKlluM
         Goumdcr1MBtvE4X5IwUycHvHjSMU8QsrCsavFQadBYYltq2OdcT5ZjLljkjLHamhDdjD
         m7PbTGwqz7rg/UUdGiskehB4jcIWk3io9Nfjr+NU3lHbPbL4CUs+S2U2+cnOrWK9rzhZ
         JHrJgp55dGo0LrxScyMYkedGk+O/z9h7PeOKEktsFF9+B0WYGPPEszHLN709l3Zsqx9C
         pVxPE4aDcAKtUgJiM5QkXw4CUjurE8ouLYm85DwSsGNUxkEUQc0QWZAr8kElrp1HKV9z
         9xFg==
X-Forwarded-Encrypted: i=1; AJvYcCUqTr7CkxNKlQ/cjQQViKEkbPsJwb+7jGiDYSrm/TUa1WeiBDZAbGTfhy5FeNKBkiw/c2fC8P0tC2RwBGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA7Wnxg+P+AoK0oAR9toS4kNq2KbOfS65Ew9XZSc4ACPw8s7B5
	8hUnGdr11YWd3SgLkzUYUjATrf8Nb73t+X26Dt0EeWXYYS/LyY7pIiWyn1jdpAuxoO5RgOc/z19
	ujqIspii/LdjG+/F61SZS+CejhJPaBLw0wuN0eDG2VsjFzUO/+MXFVHZrW6S9iFv9DwQ=
X-Gm-Gg: ASbGncsBx7gnKqdEzPq0Si4TcevJsswrfjkTpVMWf7oPMx1V8hlhwzu8zTlLd8w/YwC
	VtyxdG65zKHuCV8y7wvN9lpGg2wxgES9unPWy6xtw2OmyJtoibNKOzfYw9OLRICkfE/7EPn28f2
	YWczZZp55NGEEJ81CdlCTvPj4RbqOf8PHHyXGqmWsbeYjkFuydl4/SXATQdhh8I9lYdkHxO0VTN
	ej67Oy1W6ZEdK4j6pM0H9Sx6ZKvBfdAdccBHlYuzXdvrjEvEDqCGePyIcUMkPmJ4wzrdxUTxtYH
	nHepcF+sbpwFeb+OJrxrYqVZCFAbKELklMv1kwcjBgnfakZ+EgEP9Vfkptd4fjcBGyCwYBfjWOO
	2LGcb65H71MONDbOT
X-Received: by 2002:a17:903:234f:b0:276:76e1:2e87 with SMTP id d9443c01a7336-27ed4a4979amr14745735ad.44.1758761559481;
        Wed, 24 Sep 2025 17:52:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0jZvBnlaKAnoEHEDtefVGK6gSjoyOxioVO1pqTLEeDQPqNMOS8vsAsk+dAfSSAhP0dvVSfg==
X-Received: by 2002:a17:903:234f:b0:276:76e1:2e87 with SMTP id d9443c01a7336-27ed4a4979amr14745545ad.44.1758761559093;
        Wed, 24 Sep 2025 17:52:39 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ac27d4sm5238105ad.135.2025.09.24.17.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:52:38 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH v2 05/10] dt-bindings: phy: qcom,snps-eusb2-repeater: Add SMB2370 compatible
Date: Wed, 24 Sep 2025 17:52:23 -0700
Message-Id: <20250925005228.4035927-6-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
References: <20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -oRIwXXspxxlUrDoxz8oaqNVJ197GSbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX5IQUMIEn5+Oq
 sY2Wu2vfZH7Tfv+6zqkvJ082d+0JzEsrOQ0nbdh4owu+qDVtUz14p8YeA90vM9lAWEutc7H/rT3
 JwtYlsRCzpb3b2nMJBaspD9pHo+bRdcphU7G6B+Zqqv2IZMQdSCLucJFbWGVGjH+zyQ19CtUO5D
 OeSbfvaskTJgyeSVvUJSvj7LB/m+C5vByeg2Gu7K+Ts7wDgiXD3o3eKvu+iO58HauKPQRJrIs7T
 3izST+ZS9wuaHBH6tCZmeWSWaiXcooFf2zBuR3Tx9LttaP7fH/O41WSmWhuzggaytbrtwV2dk5o
 +bNKGK6sbZhYJ0bVsbDNrrX+vkSSER25gFqfN0gierA013UO/pXXQh2Y8DCJwouqw6qtTJmsgg+
 AQUxCAl0
X-Proofpoint-GUID: -oRIwXXspxxlUrDoxz8oaqNVJ197GSbY
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d49258 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=9ZGL9VZrYHwIVTkvpzsA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

Add the compatible string for identifying a SMB2370 USB repeater device.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
index 5bf0d6c9c025..0f015a4c2342 100644
--- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,pm8550b-eusb2-repeater
           - qcom,pmiv0104-eusb2-repeater
           - qcom,smb2360-eusb2-repeater
+          - qcom,smb2370-eusb2-repeater
 
   reg:
     maxItems: 1

