Return-Path: <linux-kernel+bounces-805296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A4DB4869A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03DAE188A595
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5262F28EA;
	Mon,  8 Sep 2025 08:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="laV/wtme"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E042F069F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319639; cv=none; b=rUgvh7fb+TuCPnQ8bLmWHJ98gyPPYC7fq9uVJbvwCTeFzdu+/jsJkqb9BEIvMiq8pW+gxeoPRssY2/jBFiXZnm2w0UCa/fF4XaSo4u4zo1oTm1G4AXvxzaRshqtQrB+Z88gGyDvGiN2UMOc3wWclFPBFWRt/5cjmltNHxmJK580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319639; c=relaxed/simple;
	bh=uCabQVoOFgq1iT3EqXI3YF5nGk8yhaFHTlv/+rDaZ34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtVwcqrzTIZ/qMPG8yFdPIuRu/Hg479f5cAXu/hn8SQ4elKiLUU6vqmy8mK/VREEUVE80+G6QOsP7C17XyfQeIS15VPlg6anXUfAi09ZG+yexFhq8ricc9s+CcCAb1itHab/i81auYtdN4ooKjbWqOmBPyc9VYVA8/a+U80bcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=laV/wtme; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587KR5dr023845
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 08:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/fYjgV0Vl5rUIq58+6skm/bOKinBzNn1z6h0/KEQ/Qc=; b=laV/wtmejxmrY2Yu
	PMgJUVmdOJlKq3MgpznXRTu54pF/ltxlNQYsfeJXsYDhOv8aP57vBuAUkFBlgKQI
	9r0vdzrPD2ParOsdSMfhT1NmG9+fdGDYoOf0MIaTX5mOEetwtLGVe57FjO2JRb27
	GevzX1txTbu1YUZI7w5hUipCwIC3ds1rZ7lbFQ9vzwaYItpTciMMUKEdRey0va1M
	3tsvptHLW7cpKxjRKT6Qgk4eccmRbOg+KHRWq2SsoPhKtQqYPs5ktz3DmYCUgdj8
	nSlPCyNhABGnlcB5LFouHD0kr7hbnkdPrwhd/uHflhsJ8Xo4TFyjIW7LdPOQonUK
	kN3Iwg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490cj0ktcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 08:20:37 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24b0e137484so35043275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319636; x=1757924436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fYjgV0Vl5rUIq58+6skm/bOKinBzNn1z6h0/KEQ/Qc=;
        b=Sny4mYkX/gCDFM+HoULikAFUs6uuL6SbwqschIQisroa1/PN0dx8PArCsgN3FD8Y0O
         AIH4OEUH/nGn04xZrSZ7UOmYmQM96oz+XcBTeqYJ74AK/Ng87BMBTTjhzEZZONt/ZvT7
         LyRZaWyCkR6wA2sogmzezAWHAs/V6bmFnWmRJ82hTcUGxHf5rga812iM1NroaaK62Akl
         sIDJybBjiUWLHLmgMR+N7pjDgQT/bl79Wrr81meLl/mp+zWC5TeNUWYLbbzyQylAE+1b
         gEkV0rfwKl94ZtMszPVYgCKC0nJJ31qd20nJZSunfv96mZwnlg3NEgcvsYPp4m8bDokf
         okjw==
X-Forwarded-Encrypted: i=1; AJvYcCX3PgI0UPK9/mBZiA9xC9h8vPQZqyEeIn/e6YF682q4jmAaybQfASBse/opQVgQpR0/E0apukf0tI5JvIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsLuUxcNgBn53QBzVAGHR71wXizcqClcpa8ekACxc/wtBqEFhn
	wOxX2Iu1z8bwtON1F9TIvT0c9hq05m47m0rcVunEbzJuj+IEkVftndXmWrcUR/lJPj7d7YT9gLz
	Rp/mp1vS7sjr0SODRJXC350MQvEeaqbU7Tk5U2EAIYM+Iepz7Z52/mEKRnCI35xSJF/s=
X-Gm-Gg: ASbGncuZ1alC0FeVxFRp4u4lJlw9hV63Q39Cdet4HerPjV9/vTEkzI7mI+dUUqbv3X6
	qlWb0jZtZLvOBA+x0tsvRAZrXa37o+cuFjz/E+wCqBAw/bKBmp78lbeMNlga4vEZtTyiX0N1IU5
	yumZu6Tz5BJWTj7R4957gf0HJNtP6RGGTdgo0N6rGSjRiwX36ezZtTBqePUPKebzIcqTQRuRCml
	GzzDvU7XN8UXlDq8jzTCiw2tT6YjQpc2GBriHIocaFBm1dfUDYgRvgs68fE8R0XIou2tQafN+oq
	Cf/31egY8mhIRNkYGuP009KOckTJkwnZf46GmEucfj6kHDnP8L8TMWAEnlS+Xhcy/+Q5
X-Received: by 2002:a17:902:f68a:b0:24c:9c5c:30b7 with SMTP id d9443c01a7336-251736df08emr101411665ad.47.1757319635755;
        Mon, 08 Sep 2025 01:20:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKrtFSazAkcLdqZ1WPZZaD95ov6pQ8rl95v1Iw+xmoRmwhbaj9ZEWSRTt6f3p2ZxSAOucybw==
X-Received: by 2002:a17:902:f68a:b0:24c:9c5c:30b7 with SMTP id d9443c01a7336-251736df08emr101410865ad.47.1757319634799;
        Mon, 08 Sep 2025 01:20:34 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:34 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:55 +0530
Subject: [PATCH v4 05/14] dt-bindings: eeprom: at24: Add compatible for
 Giantec GT24C256C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-5-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=988;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=uCabQVoOFgq1iT3EqXI3YF5nGk8yhaFHTlv/+rDaZ34=;
 b=IhpJ+58y31LYj7Hpt5kOaw/sdFIzhsHjVVE8uCnp9wndKJancFej1ClINAR6Q9BToUuPIreGg
 yJhq6NN1fIjAWfT8LoDh78/Y90MXDnxM4pV1qiyr2xupVu5h3bPa2PO
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: KXr2lxDSr0H6pg3BdFQ0dbhJp3ojsevC
X-Proofpoint-GUID: KXr2lxDSr0H6pg3BdFQ0dbhJp3ojsevC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNCBTYWx0ZWRfXwHi5rpDhmOtZ
 itQpIODbt1LECM0csqzH03p0tegCGw1YBfTFBz08r3AGPh+J6uVSg5ey2xuqgfJPcqXXKEim74L
 5h4o7XQPXrjv2GZB1CajwYKi9bVxygOSEPUg8CYnh8D4qbVuEf5tu9mD3RJgM/rZxw7YnZ+0HnP
 hYI0oW7TeOjq9Lb0jW8aViQ21+Roh2tMUDizh/i7sMVCOtb5C3uUSEqZ/ljyVB8ncYOuQvJFMyK
 3Jfkz247N8yqPBIQTQ8BT5qEJKmVP6+tac2DGx1atwrvu4yB65gWxRFr4u5+UX76NZwuJ1lO5bQ
 4s3wqfxeQQVCWotgj4fhUP4bD3J7JPRYuqrYEjTDyC0LHVCG0ZqqvNVDfdR6rLEkHsTJUn8aDVz
 H+Z2XsI2
X-Authority-Analysis: v=2.4 cv=QeFmvtbv c=1 sm=1 tr=0 ts=68be91d5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=phLo9lBTfqDeDZSmmEMA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060024

The gt24c256c is another 24c256 compatible EEPROM, and does not
follow the generic name matching, so add a separate compatible for it.
This ensures accurate device-tree representation and enables proper
kernel support for systems using this part.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/eeprom/at24.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
index 0ac68646c077..50af7ccf6e21 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -143,6 +143,7 @@ properties:
           - const: atmel,24c128
       - items:
           - enum:
+              - giantec,gt24c256c
               - puya,p24c256c
           - const: atmel,24c256
       - items:

-- 
2.51.0


