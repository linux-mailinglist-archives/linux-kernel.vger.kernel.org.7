Return-Path: <linux-kernel+bounces-818113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F15CDB58CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9CB1BC1875
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529322D0639;
	Tue, 16 Sep 2025 04:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eyvtSAoh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022F025F98B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757996666; cv=none; b=ogdVd9dt6HE1D+wBLf572tlY3g2xCW/yt8C4vCAI9eIa0E2NULKhysVHioU7/Tg0dtr1ShOB/HyttiiTh65XFJKbraix3e0GsKgDacaRKEo8g+DB4dbELvr52wed0x+wzCy1jDhnKC5TvhBNWggILqDNRHg+4W/xxgnN6gBDXQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757996666; c=relaxed/simple;
	bh=nhd2RHIK/5Wkk1VEUvBtU5/9EbZeITdPPkKg7Vsnmys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ITXvHG623AowtE3qNrtHs1r8vVe6WWtqq+ktMssGuCtiVIL0rqVyTZG76qlZpq0Xe22MbpKqYb4nsnLX3RX8gKPjqXUV2sijcvKR3SCI0miWD/ldOIiEuoOz9k4qpb7ImJy8SPA+TZInNkk2SiNAIwDIj6cHVMwi0w3IqPMW5SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eyvtSAoh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3pi6A019573
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fy02dgHGxGtACOefh+UkfUw5SOovP9+RPFkgwrZZl+4=; b=eyvtSAohgz19I+k3
	ULf1TnqUmsSn5qitT2IcwscI5dQbnPQbSNZcXiQ7iSTT1GN9qgHgbFRq8Zz4WC+o
	f73Vqo/KH8RdxjMRN9PSZw3UA9xMf8ka877Nw6zFa5rhiNO3TMIfIt65Vj4jX6PI
	7McFTz2V/EF4Kvz1MtgREjygfSNeNuGrWn6ch0KfDrqw1MfxdTpnZ3Z38qwPenTg
	PV/Da8z2DKBUjl378i/ZHJFtjNYxyEnrDhk+W44JPDUHpt+BqEsqwgcnSt4+YyJv
	YphkQtx2G09Q9zJnYx7a0My+vTXxkjbEmLWnzxndzLDAsTbOs90qdMy0ZC8ZVKZ/
	CGwoLw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma7cm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:24:23 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-74b64da4a81so10760121a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757996663; x=1758601463;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fy02dgHGxGtACOefh+UkfUw5SOovP9+RPFkgwrZZl+4=;
        b=rxKtTbh3ZWQxx6EUM8ISB2YR4Vr19vwCxYi/ShZfQOFxiLj1f2V/d/xTAj0Awy1aXI
         qkF4hDI2SDIYm5BpFluX87Nq25H0OVQUIJEJ9HNWknWtBEzQaoIjT2IFdlKDEia76Syq
         NbFU7FYDryGQBkHfq2tzlunoxREmGNNKpkZXoIv7MZFIaeTeEyFiZneDRNe0KG90303A
         +CwZUht1HcW90AKBpHwHhL9xGOdt6nAMEVgL1205OcrZMifxifp3w4s4D0p4Y+mrXxIO
         kGZM8jKREHoOOTGTIDfbWPD2VSPLNeJdRlG5TEYKpztBimLjWqQypTdKMtaevnkJ4sy5
         f+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWPEyWPoxj15yO7Gqzvj52KQU1SN7avXJ5UP2Xmo9ba12jnv4cmTn1dchp2q19N5BqNCE6VRqDJYVWKGT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6sgqCyQZT2R+OZ9lbsByTpCRo9rN2ovZrBA5xNea2rLa1Wmgu
	CHeSep7Yj1huosHJcVS6LATaow0jFXqVYqxBwH/ikYsPhSvy70oSqkMcTfZb56G7bK3S57RsOrE
	JKL6HCbRuJY78pl+/h2lDAZdpYkYnBC5FObdHXokYeAln5k8++J7pgbVnvb+VES2U2q/XjGzLhw
	0=
X-Gm-Gg: ASbGncslx4V0iIcIhZje4gqVqHpuOEqVrQEN3I7VATunLguMTStlW10/NV0tT+YqStu
	79MAaSNlvKBHtmzXzGXt1hOOU0FIdc35RfNFFDnJ073TyuPz9voR5R4pgPkyg1phBDU5TmxNMB6
	60Kr9ZM6C1fmK5dhy0SuqEQWZQ/kKvbefgUXMmBK8Emy6p7mTIA7dSoY5mGTxAr932Scp2wBPLa
	oYjscqWGTb942MfQFTJYknMMRKpYHVLGwQE2u0/6m7uNyhra2A6w78q0Aey/WWs7xW9PvT9qpTL
	EYNpKAWlOI7HDLSz4PSI8Ujlp0gOcHEMxMDj+R/FGZd+Rdmtxb8uFEnMdfl27TFTqgoGMOPx3Oc
	Hq2d+stMcM80I6upmCiMZvlV3bNig0fEZhI5Lzcs=
X-Received: by 2002:a05:6808:1881:b0:438:1c9c:4dbf with SMTP id 5614622812f47-43b8d87a904mr8067283b6e.11.1757996662726;
        Mon, 15 Sep 2025 21:24:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGo5uj+Rp//6eSBlEaQ82sl0S4ZcUJU4mROLG35WU2YM36kgfmzqs1AhRCiE/a80HwWw71qyg==
X-Received: by 2002:a05:6808:1881:b0:438:1c9c:4dbf with SMTP id 5614622812f47-43b8d87a904mr8067267b6e.11.1757996662347;
        Mon, 15 Sep 2025 21:24:22 -0700 (PDT)
Received: from [192.168.86.59] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82a73075sm2772862b6e.19.2025.09.15.21.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:24:21 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Mon, 15 Sep 2025 23:24:16 -0500
Subject: [PATCH v2 2/3] dt-bindings: arm: qcom: Add Particle Tachyon
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-tachyon-v2-2-4f8b02a17512@oss.qualcomm.com>
References: <20250915-tachyon-v2-0-4f8b02a17512@oss.qualcomm.com>
In-Reply-To: <20250915-tachyon-v2-0-4f8b02a17512@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=972;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=nhd2RHIK/5Wkk1VEUvBtU5/9EbZeITdPPkKg7Vsnmys=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBoyOZzE6OxVcsRncpsCjDerjCjZb17b2m/rg2vg
 ud2xO90zKaJAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaMjmcxUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcUzMxAAwJUJlxydchMCkwNQdx3zeUuGQ6JQXD6aPD1FQk0
 5SM+Fk416mTsS1xpoNCr+90YcHr/4t2TGhC7OeBNPWgSDYz1PC9OeHXiR9P95d/2WD6RawXjpyP
 uAaYl3qP8mZxwdPLX8/yOE5o4wY0678iFBvF16iN6J4613Gls8k1jRYwbMxjXQ3AjU5EUPgFpew
 xPIR1gBZ4bEBgq8wSdb/r6c/yTyOPU7kF9cAGDAufNc4d7zqk9R6ScRXpl/mmWiaNsR6GrhC74P
 UhOKmi5RABMOtC0WeMfx7zKZb5Zj7gzUZ8r4bqXoNuR7FMcaWkX48Mvj01maxM+MHIDc/WPGFMI
 a7u2hoccGW70NysZaArRDQAxErp8iPVOhCLf+FWM3CjRlLvpwVn9mrbKEjwolJpyMPBpy6vdcvq
 jdV4jR6XdMslMHFXzEn3nH9rhlmTabSdtyhBtns1Wfb57mocAaQFcM1Sn7mLpKTLnxOq9ic0W50
 SnQjbG8d748yblq2niNLoUQKhjO1SYMc7AMGERPuGyiGtUaNIe4HExpdmIU4+grUJK0z7B6tCNe
 D20iQmCmc7+R+ce+TUEq5fpzCSIUlOrnKVlMZwVaqwgjwsWwP+2oL0MhOTng8zLdH0vIJcVfhAu
 i/YTxdMbFfHwA3wnw6RFcSSRR271+pWNrxhcPGo0L4c8=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX7g7aBXWNXM6q
 KXWsmf4Q2aaxJy++Gcsrfq3Lmpd2bcHXvLuEC234CqVnouRc3wq2ks+oOXxn8fxNtSxUBXd4sxV
 E6k9fFw9YXQSJP5Ent5W/zDzWZm/Blu7tjxBXsRDs5YO1Vz1u1u146Ep8TQUgC47x7dPmribtLK
 VePdV8U8qFrI767ydCAW2n1K5BOj52PKom+zUcOHu0d35FzJ+fYVKfpzFNb0rHmOaO9W75k7eac
 koelX086vvzC8JFsmvNHp1fEGrNkBA22I7Xvg0Y6/vYovXboTQ50rm0nCkUSzqdvNiZIEeLXpGT
 OSl8ZZ2NKHEWuJWvSnCUDPyTjCxheYt1qjGvTZrrTnjYRwo4b7O6Bydh1pqk857Ufo5M8FoGMRb
 KB/zWJ1/
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c8e677 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=wQQti8BIFarMilUVRaAA:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-ORIG-GUID: 33LuRXehmdBYx9QrqZzTsJTeNayrl-eT
X-Proofpoint-GUID: 33LuRXehmdBYx9QrqZzTsJTeNayrl-eT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

The Particle Tachyon is a single board computer with 5G connectivity
with AI accelerator, based on the Qualcomm QCM6490 platform.

Document the top-level compatible for this board.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 0a3222d6f3686f1647b9e2ea192c175b0b96d48a..8e0b42ad65607abe687a0bcc5310df264e14157b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -337,6 +337,7 @@ properties:
       - items:
           - enum:
               - fairphone,fp5
+              - particle,tachyon
               - qcom,qcm6490-idp
               - qcom,qcs6490-rb3gen2
               - shift,otter

-- 
2.51.0


