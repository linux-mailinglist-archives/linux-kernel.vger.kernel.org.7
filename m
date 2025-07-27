Return-Path: <linux-kernel+bounces-747057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6467B12F33
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 12:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9593B9F16
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 10:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ADC20F09C;
	Sun, 27 Jul 2025 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fOx5Na5+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1E52066DE
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753611788; cv=none; b=N5BdCmOzNJNwJx7dZXuVIr6VRuHdQX2aX5KjBAmKK0jtfWM2FVzPNFgNWlmcNGQ0YAuNeSi8Zy6zz3PSe1qrbAM4le6aZUIJMvogRU0hoK/khPukp4cGl92uXmZtwgL9beNpQheH30G5iqGxPpDD3FCYAADVkyEPo24bcN9WkSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753611788; c=relaxed/simple;
	bh=zsNDOxtssyyXKwrA/Xqhu6xlTQfQcZiumpCvpHLeiVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=df/VSWkuN62WkvF9jzQAS9/j8K1eT3m6A7rSQPoR5Ww+mET5/89YpxbxSHf92Q3PAXhnIP5mxsETHt/knRpsmGLdQ6zLKBaSPX7bLVMOdelSr/mBla9Aqe9LAmnxu+5BzI9e0+19ET6xbdQ4QFaSk1OtCF5d4mH3gNFutE2mBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fOx5Na5+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56QNh7oC004870
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K9lCHtaEWJJtL5rVllaD+CR/7jxFq0pVmlc9VCIqSOw=; b=fOx5Na5+yJX7QcjJ
	+D8ruVw5Bc7kYIcH7JxnxYR4LOO8gmnbhymhon63OpAPebOrApIwILcMl+NAjAEr
	6qZLYh9noYhXpzVeWMwgScgAZ73TyRcd0I64L3VJClQf0+orO482Vl1wvL2MspVR
	kYkt3MjMcua2sVOUV++zgPo56BkfEjtIfRnVJ43Kq+SNsimu53vwHsK2OLbEfltH
	QVpSiVV38N7xcsFr2dYoetYmlbKPEGzsojm1QMIPflVWUMSuo6tKCAxSwwMRL4Mk
	p1+z7NY02pWD91oipfv3VXPMR2z/dMNqn6KyRXdBp1TfJQIq5KAylMD6N71U13oS
	ufjsfA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q85syk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 10:23:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-23fd8c99dbfso5862245ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 03:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753611785; x=1754216585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9lCHtaEWJJtL5rVllaD+CR/7jxFq0pVmlc9VCIqSOw=;
        b=L+BdXntOhOVR3qmQ9BlBsYqN+6Ivk1KnClp668+Hmp6T/PNXMkeAh81w8FSAJIMbd6
         eq51BbnJDnZrYmANjP9dPg3YAI6yoPLIomM0e3KCdgIl8lu59S2CvOVNgZYIg4ft0DIW
         UVCrHgy/l8hQ8vcFwfhh3i3NrkRchjB6f4sfzYZ4BGM+SuIUFYXCwUrKF2tnzlGD0crg
         uArylAIVKTRK5WpkDwQyjLHZjoiKbwmmCUrdd9KT8i82235JYqNPLuvx2jMY4mjQfvq1
         ZdvYe6AmBaFfwI/AFlj2oSCxyV5pXBSpJdceysaNEMyAMu92NY71Qp653lZ2EREijI/q
         INOA==
X-Forwarded-Encrypted: i=1; AJvYcCWR7wucmf3Y7f2ey+H+nBo3xqX1I+FTtDad4Z7odYTrRkargu/RiBHvJvOlPzha3Rk3NJtCYMGcXDU/K4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCsfOPcc8pqyMHJD5tWta6fLH9dlZVnZH1KJ1wiyOYaFxzp9jH
	PTFfud7QNOXggdIgYpqyNQog+jZotMfPL+70ToRcPa1yB1c+6m5z86obKPqcoVn/eYrNlLYMWNp
	OFkDCJ2NFmKvD99fWUt9YAS4u02k+39hNh0GYH0GPb/0WX+hnsv8/s/ItjyJxUWtBWkmZRZOeej
	aZQQ==
X-Gm-Gg: ASbGncto9g6J/RXmn7pwwQLEhGwYTXMAp7WSsaRsCya4DtiU+ntbf23HfOYJtnw0sMB
	xUAbiCcKOJ9j7WupVYOCv+Pw/VXbHsxzg++ds2xAEE8Ox0LbaupR8j/GVvn0Aq5jzf/B/yYMAWy
	aZYw/cIVTTbn4ic/e15xesqWUPJUi2/rlFJ7mL9AUyBjfVMYFWT/D6kf7ziTxaSWQ0Skn2kz8L/
	newu9AakID4aZFcYKgXPyqPkepdpLg2LTjfOs9KJFTfGRn8Xh0L4q6+kbxzUTLMUUet5gTuUMj+
	39rYWlceWNiy0MWMVGsknQXRRN5Nc2y5rc4gRZbdOTv9eiFd4w1B3FX6wTSR0u4sM3B8aS1ubSz
	/yYUcKggio95L8vfbGkzFc5CMWI4=
X-Received: by 2002:a17:902:dace:b0:237:c8de:f289 with SMTP id d9443c01a7336-23fb30cc9damr120223055ad.36.1753611785241;
        Sun, 27 Jul 2025 03:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEffSp9Hod9Mf4aXUsaJsrmaY+GjvtK57/b+hyNJcIhI4juMtZi1jc/Zap/MP1wvUdJkllr2w==
X-Received: by 2002:a17:902:dace:b0:237:c8de:f289 with SMTP id d9443c01a7336-23fb30cc9damr120222905ad.36.1753611784809;
        Sun, 27 Jul 2025 03:23:04 -0700 (PDT)
Received: from yuzha-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe533b1esm31869715ad.158.2025.07.27.03.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 03:23:04 -0700 (PDT)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 18:22:36 +0800
Subject: [PATCH v7 1/2] arm64: dts: qcom: qcs615: add a PCIe port for WLAN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-615-v7-1-2adb6233bbb9@oss.qualcomm.com>
References: <20250727-615-v7-0-2adb6233bbb9@oss.qualcomm.com>
In-Reply-To: <20250727-615-v7-0-2adb6233bbb9@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Yu Zhang (Yuriy)" <yu.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753611779; l=943;
 i=yu.zhang@oss.qualcomm.com; s=20250625; h=from:subject:message-id;
 bh=zsNDOxtssyyXKwrA/Xqhu6xlTQfQcZiumpCvpHLeiVE=;
 b=w0R2/WhIyOdaw3Fhq8slMtc3HXofznoztUpoYdRqstMtPQPpAEfGHbxGo85HknOpeuNmAW5TV
 xTShKiJ9oojC1t5IHRHFwyFfWmXKexEdvENrdVXzQyPglqCuF4JfBcq
X-Developer-Key: i=yu.zhang@oss.qualcomm.com; a=ed25519;
 pk=ZS+pKT1eEx1+Yb0k2iKe8mk1Rk+MUki89iurrz9iucA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDA5MCBTYWx0ZWRfXzwqzEswedXTo
 dNn4ltTvu1ldS+j7hAjtm+RHxOkw+G3HlpOJJNmYnF1DM8LPRlWyUGCk5/joWclHaiYQnEfCgeL
 xUhbhzEcKlDKMWmpS0DM8PSJgIoDeK8BlYH5+ZmMSot5vMkGeMMtUfKC4f1Xs2h0PQrTzUctWri
 WE0ZqL9fEIcfN+/dkWZjWQhyWnhWbCCLtESG1i4DlXhjjxpRkz1tAaareyzVehHmyFnJedgrpK8
 utORwtKObHk4FODLANwQ0Ds61qxn7NhdQDiG5K7HeSDfNgptp764AOs867Omg7xzACbyTGjOG3d
 hRgozHxDxBvIUYUXcHo2i+Q++EHvTbPAxbRBroPhhRKB+go8rnUtZ1HEbOuwY8qeQF3bHdNNu21
 EHhaI5Kv30Q5hk6IocewPLoUXQjGRehRRLBoDR7A2M+/KVS8mQvqFaTs0WcPcgkzp4KGyjak
X-Authority-Analysis: v=2.4 cv=TqLmhCXh c=1 sm=1 tr=0 ts=6885fe0a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=dI-8CA4c5Xf8_vBnWYsA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: gBVR6QndkeKWiAIlnEX5eDfcPCWwUFiT
X-Proofpoint-GUID: gBVR6QndkeKWiAIlnEX5eDfcPCWwUFiT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxlogscore=992 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507270090

Add an original PCIe port for WLAN. This port will be referenced and
supplemented by specific WLAN devices.

Signed-off-by: Yu Zhang (Yuriy) <yu.zhang@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
index f4b51cca17de5518aad4332330340a59edfdc7ec..b4fbed517cde18e088096d182fe6b482363e403d 100644
--- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
@@ -1173,6 +1173,15 @@ opp-5000000 {
 					opp-peak-kBps = <500000 1>;
 				};
 			};
+
+			pcie_port0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+				bus-range = <0x01 0xff>;
+			};
 		};
 
 		pcie_phy: phy@1c0e000 {

-- 
2.34.1


