Return-Path: <linux-kernel+bounces-754597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365B0B199E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 03:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B310A1895041
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 01:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70961FE47C;
	Mon,  4 Aug 2025 01:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GVhKXJD9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ECE632
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 01:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754271470; cv=none; b=TlsfYcgdUllJE5hMcHTFzNTsf4VsghPE9bFnEpI35ShzHYr7JwZG2nJ4GYGEv0I4yNW2OZtICh652qDtZCBZ9/c8jIIYnF1NO2KA4OqC36Txh/6rTWxBBauU7AsVAfcs4jhB0pPIzH5tnD4hR95sYKqeFasUlKn0fbommqXHiqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754271470; c=relaxed/simple;
	bh=Qi8gRAEJ34INypIr24ID0chs71JhYSBH+rUZfs438Us=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kkY3q+sUlltCqTXnGqjAM7ztyMpHLKweXSD6sG/f7D3ufCYiyusnbfVdoNcoRtgsExKEYJk8Bg9RnFZmGFY/4w8oiq+G/MaPQKhXbSrRPH1vFM8qUBLuU3ddxkQXVQS4V3q16lJpZ6NdmuPssWQVu4BWy0t/lehNKLMoRpLpqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GVhKXJD9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573NcuEe020838
	for <linux-kernel@vger.kernel.org>; Mon, 4 Aug 2025 01:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f9IjdeEMglbRc7avHUFqyJ1eHhJH4uvP7KKrPsQ6vyg=; b=GVhKXJD9J3XWUDdn
	vJzzltKbtIbs2dDFkC8LmWEJbWcMpVCJCPZudgOTOE684IAwN+ro8RQWBWpSmGTw
	Yz5OAJVMQe+YuxPYCo7ybB0z0+bTU4g4g5j+MPf/fZ9vf5RRrxcBGF89Y50t699O
	aj8RE0/yvxpdxea2I4M9r3gH/DHh/BVePwiXioh/2c4lw1ay1yfPBX6eBdrT6ZqP
	CkP1XUheT3wTGyqyE4b10jRJuCGppZB6S+9OfB9orWmLqQJ7Ajk3/qH4agt3MBLz
	4JXAnOU/dlhfyM+OpucdG0QKKhBAOsCHlSi2oeCv5p6hlWlzo681XnI3G303RcHH
	L4HIeA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489aw734hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 01:37:47 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76bcfe2a8a4so3297354b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 18:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754271467; x=1754876267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9IjdeEMglbRc7avHUFqyJ1eHhJH4uvP7KKrPsQ6vyg=;
        b=k+7cG9UGFskafPI1a2EumRyHPro82dqvmdiYH6+qURJ7jrfwQ+AWJm2Z0l2W2WSu/m
         9kygNv+G6U2oCNnVctsWgl7BRy7wJuqauPyjUAkUjpSTfBk1i6SR9Jhd+vnKv7YXZWdf
         qiXk0LSxfBF3w7HOOSD0WT2eoKR2v2ZmJvkyKBEUDH05jMr0PdT9gu28zgBCgjWHDNZk
         +SNka/UCuEUaOsBEaW0SMC6FCsS4bfeRwqMHBwKj66+iE3qPdD/Gi8s+fYLg0QcEFLoX
         L56nC9QlHDRmyONxDQgk8CqK7sppYFy5Y8CKG+FeOoQNYgltP0wDjPDsdGBxMZwXIIdV
         UJ9g==
X-Forwarded-Encrypted: i=1; AJvYcCX5oCAZg1BEk3olgnHvpA49aelV7A/GhaTY0vY3mNBh6ziNWWMHd0HxVGcw3dX8bOAQHAa9R4Nc/E44hf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVUHvgCR6M5kqoa5OGp8vCGYS3rx3THF4ex/92BGu3Zl5GfKi
	bNBG8omJftpvnFBi2skjIf9K6CbzeTc76Fjos/l5khqdb0w1VqMlWoBm7B8BEII+zK3vRSfYYPk
	7Mm/pIksgPc0OfZ0KGQ6N4i2i+xge42zgb8ULQUcF9fMFgUfaxbxQLRgEQIse6afJMBA=
X-Gm-Gg: ASbGncvyYHocoj7inYVVmgFgV03iXJfR6R72nqTpAbvZ1b1bKUqLJUIrUcSPM6EMAUl
	IIZdijFi50lZiSqt1drkxK7jOQfDWm1yZ53h7h+KmcLjAEDOpem0H1z12NlOMCUQPbBDvt7mJt3
	F9ozE2GpES+hBthXCg+vwjeLw0OvVvZ8+g64pQ5+LpdjuhGfEP5E5yuB2cP0S8TW1X4RyQzSl0B
	wbNEdgZJPlCBRn/IayZVwZTfXbDEAr4ztK/7sclCK4x6JagzL65Kz373lnUJhS/IQ6am+NlfZD4
	o11z9Jwl2vHjiRvK0XOj/MxmDvlYLUEWjiOQZLdYxz2/b27He2g/ZbhGz3w495I9tJWrmA4+WQl
	Ni2ffdBZSF9U84WxTTtm6ePK31gxd8nVoKA==
X-Received: by 2002:a05:6a00:391d:b0:742:3fb4:f992 with SMTP id d2e1a72fcca58-76bec352e73mr8215356b3a.10.1754271466915;
        Sun, 03 Aug 2025 18:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUBGG3OwuVHYe0mR/+3ZFomsgrUGYYPu7wDXwsRlzBw10/sl0aEr6cPZX7fxWINSD16zY4ZA==
X-Received: by 2002:a05:6a00:391d:b0:742:3fb4:f992 with SMTP id d2e1a72fcca58-76bec352e73mr8215343b3a.10.1754271466526;
        Sun, 03 Aug 2025 18:37:46 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd8ebbsm9208626b3a.102.2025.08.03.18.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 18:37:46 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Mon, 04 Aug 2025 09:37:04 +0800
Subject: [PATCH v4 1/4] dt-bindings: arm: qcom: Document HAMOA-IOT-EVK
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-hamoa_initial-v4-1-19edbb28677b@oss.qualcomm.com>
References: <20250804-hamoa_initial-v4-0-19edbb28677b@oss.qualcomm.com>
In-Reply-To: <20250804-hamoa_initial-v4-0-19edbb28677b@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754271458; l=1233;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=Qi8gRAEJ34INypIr24ID0chs71JhYSBH+rUZfs438Us=;
 b=YyQA18jWAI5zkIi+fksL8lbXlcam2uVc7NEdatXPYVG0tORktyGT8R4cOcw+3HmQDhhXWscPM
 xQ2WWtw/kVpCjwonhVUuJb6NaLdzdrs5QEUywso1C82tfndyXpPp6pj
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-GUID: dTbFb3t4-awCIGxC4qYqkudrZIFP7kEE
X-Proofpoint-ORIG-GUID: dTbFb3t4-awCIGxC4qYqkudrZIFP7kEE
X-Authority-Analysis: v=2.4 cv=MrZS63ae c=1 sm=1 tr=0 ts=68900eeb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Bh1HEMNN3wmc11-eFpoA:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDAwNyBTYWx0ZWRfX5Z+/SFh0rt82
 lYbaUM8gkdFqP1SZQ2dBDuUoBmZSa/huQUebSdBPpOlAyNEMRXRBpvvSNFg/wQxjX8HPPkmbPo9
 gOhNboP9++yVN3HjHOsiCjyu5fC9yrj+2EyX7w2TgJn32XpKGHCwJva1FRwmWE3kuZ4WItaS3OU
 8bGl73C1tohBx6J5m8QKHDlyw0TZGy8Ph8wD9P6PY8aH9LqIv7TlSRvNBe35Xc0vlPuuMot9zOT
 hBHNi6rY5r2zFn/IWPlb7whpUY4n8yNML51w9Qg+zYOduQD81H7f0LPfiYa6FE1KGHG03Crgc8M
 po1Ej5mHbhLJA3gzXm68Xfkrh2ihdWvrqFWfkHobRQh1FNCbCgD1ccqZbjWiNoTpw1d3PcICRdJ
 cQOkam8S3NBzvIxZ6xykNKY211LsHT70u0Gmeld3DMpf4zSzbPO+zqS3dckKsTgINefQpURU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_07,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=960 priorityscore=1501
 malwarescore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508040007

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
index 47a7b1cb3cac1150bcde8c2e2e23f2db256ab082..65003e16fe72dd4eec9423030fed6078b4a79959 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1165,6 +1165,12 @@ properties:
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


