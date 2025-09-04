Return-Path: <linux-kernel+bounces-801286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2325AB44332
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BBB1BC0ECE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2EA312837;
	Thu,  4 Sep 2025 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dPrOq2X3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA12D3126C5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003989; cv=none; b=bNhMiStSXmMxmy3/60Ge9sBYmhWZzIn87r84Pozw67TnsTzq7ifhI2vmiPAk88MNYpw1a4RY/Demx09nBdgoKT9rAhF6feGNy2hxIXFMeEVuVezN2D7UwmOHIAGs9uQhWqD5dWYIyCCNEc+py+Afoc11vEsO9pp2fjCuU6UgAoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003989; c=relaxed/simple;
	bh=HhL7R2sKeXiIqlZtecSPlVNqig495+ove8KywGSPyYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZTZvPooJ7NZqeUUZ3Hc71LP0buXhFeeFXksySnVC9zEPWgCEy5AfBAZDM6BUOp/DKiY3PdmYBpuKZ2XSlB0DplYirJTfmoAw8AgaUUqUoZLoEiOmWuSZuNvmZOp4zmIMblXqNYYBUcNhN+yFDnVb9J/kUsvcyIYgJwEtOsup1ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dPrOq2X3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X7Eu013476
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 16:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uKDDTZaIKoToqk8fUCVl9/PoEAVOsBabIY9X0ZzII60=; b=dPrOq2X30vuUjcqA
	qdDU5SBWGN61IJcp1GcTxGrJrHDKbP6MOFgss63MYZeZ8rrALkf/KhDPmwKE+3Yh
	AtPm1SlOx5XQhnSm30J60csq8lbT5MLJrfC4R3GuZHxqPD4k46HRuyD2zRhjT/Bg
	hfg089DB7yhUoBn4Y01T0SqPe6gsanl21ZNXCYqsq+1/QWa8UH0/biBhFqKEEIgM
	ClWfKbAQzX6scc0A+49oUPLSQH0iy8BM4lSQpQsGDgs2POXije92ocGphCeoPnfm
	vXz6UPwEkj38w2BYnKbxzluW1x5kFUy0yH9vrcEESWn451gi3D2vrwXU0v+KfRwG
	OvvCVw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wyc4j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:39:46 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3234811cab3so1426756a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003985; x=1757608785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKDDTZaIKoToqk8fUCVl9/PoEAVOsBabIY9X0ZzII60=;
        b=smPmwopLtoUAxR0LqsFZIfstdiJY4Th8yXDZZs2cnSGD3d+Titym72LfDeFcJWa5ET
         eWFkZvG7gUoaoX5VxTqKeUJlPqHqqa0d4ml0jGZi3wapPjVBxSdwAsSTAXKx18BOnqvR
         8ajyS2wwO/WzumgBxTYUfEoy6PX93ma4bNXAiHoq8JJPF0kw3A4LFB1GaQieS4J8vzwh
         6Se+sOHw5l1lTZzS5eFgg9nCgOln+QsKQMCJgjOZmhvyxkFDvx9g3WlOUE95Ih3L+Lpv
         +4vRyrgvzO7vVR7nPt+LvXuU6TlDm+FOT0DIkOnRtZ/CA72FgVodohfS3GjyrU+6TpCH
         ps/w==
X-Forwarded-Encrypted: i=1; AJvYcCWaybrMy3hxy/NDwjktxO8L2QL4yG1438ET00NbMqlbXGUhjIUXnFCUaxhgPPclnYq32QojiZqBOUYA+wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP1oqngwBT4yoGktP7ZR0tGU56zMB4I+XlpDQ+oDVLrff0ej03
	NFps0VE04ynCginA9DenLVd9f6o/9S57yQzXdhiKlclc7NnlM/YaH789IIjSQHI3+z7VtSJHnHF
	+jlSYBAUsk4rCo67hHm2uTJvPLjPFbrNum/w/N49zgHE2gXE3fTl2iRLqs9UWDd6pO0U=
X-Gm-Gg: ASbGnctpbMFm3jFy/k6WbL0jNEmmtIu+INbKYcsu3pQbr2IxJvCn64Z34uUz9HdzaNx
	FhIj4a2tl9YOHf6QAIq1QzMRkLOp5vlOPN1olwyvrlMnTGYOVb9kEFDJQjq0V0k3L7SCFjKOWsi
	PO8udyv9jV/3WriDv0RPijZs5ngAryz9HDiBxYUpSzxaQkQZtcZJFZ67dXdvBzuKaZHtzNlxIt3
	5Tj5H8blBKisavXWMYB8vKG2zLE3U12ydPQYUGBEFk8JyqwBNvg30KbJpchEO307RH9XCNpK+uW
	GW8AN5+KPTfSBAONu0tJC7oAWrTH/26gHkmg4n5B6n9XXwfbX1bGKtE3CFAlqJTm3hy5
X-Received: by 2002:a17:90b:3c91:b0:32b:6223:259 with SMTP id 98e67ed59e1d1-32b62230456mr7502200a91.13.1757003985499;
        Thu, 04 Sep 2025 09:39:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcJGB1HfigKhlcseZuGD2dtBOZEFUdCtR1Qdkw0I+kOZzDpeSQstZ3kbfO4q41mt5kED78NA==
X-Received: by 2002:a17:90b:3c91:b0:32b:6223:259 with SMTP id 98e67ed59e1d1-32b62230456mr7502162a91.13.1757003985074;
        Thu, 04 Sep 2025 09:39:45 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:44 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:01 +0530
Subject: [PATCH v3 05/14] dt-bindings: eeprom: at24: Add compatible for
 Giantec GT24C256C
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-5-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=724;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=HhL7R2sKeXiIqlZtecSPlVNqig495+ove8KywGSPyYM=;
 b=bgkk/VscrfaA2/hD0MOxPzz3j6BO3GCVxc+5R4gTrIIsO0E6coSAdgcyTz97r1uWzih4pZ74O
 0uVXMCw3Y02AEkF2PrgKKFK5vv/0lgO26zSG7N4OT1QRJWv4W77TVKT
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b9c0d2 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=Yg4z3stHfqcsaZAJ4NoA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: R2n51JsMjsDWFk-ELHTNekTKSQfkI-6b
X-Proofpoint-ORIG-GUID: R2n51JsMjsDWFk-ELHTNekTKSQfkI-6b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX0AFkbe7QmVnM
 9L0PvfT0S7/wg1GkFn9Y+5qgE986oEmnajwEowsl6LThxmPE7kYf9JqNx/+i4/NNzXEAu6AqJwy
 aLcf95c4sSkoBRYyxvz7vTpNOqvh6RyHRB0KKWrkGU25ofSVNcWgltYzeioKvfW4a7LvXHeKuPY
 0Op7zX0cywaSrHfJGrrUXCvwynCzymt7fTr21zeRDhrSd2L1/I6wPhUmLfiW+W9mzRM1S85bdl4
 rYANag0N5WriMMid091Aqmq0BsvBh317NaYz7ys4zax66s3QevutcbvCifdzB5AyC1/jMAIWQpZ
 NOYcS1P7gxJdLM+WTFwfqWeLSnsK8OKs/nY8izqsUZG+OcDhuNOYQMBilCzcIaZQVRoWJrWwvQO
 YS2SRhJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

Add the compatible for 256Kb EEPROM from Giantec.

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


