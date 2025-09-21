Return-Path: <linux-kernel+bounces-826036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612BBB8D60E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 09:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DD718A030E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 07:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420A2D3EDA;
	Sun, 21 Sep 2025 07:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HxvNNAHg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB112D323D
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758438702; cv=none; b=ns/JSiEd5mZ/JEsOPckbeO5gfn4zx7c0NWOIdZ7hxd8hywJLpg/t9O4b2+Tr/vuJsZrzZbj3cJWFYlrrgA/+P7AEl9ogVg6c0xSHCICKzd3ri3LgXw5Wrdvap0SuK906Vffai31f8p3q6zBZJtRGbnN0hpU6PDH/u+f4+WAEzhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758438702; c=relaxed/simple;
	bh=zkiKWQ545lawisDQZ6UcjJ+C2fdKGwCIkk4moVU3rlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L3CPQ3yoiK2TRAAULRPC4efGhu3n2RH16Dn386mw+4V/gP4O0bvMOLWMw5OZRJSwzCTOTzb1NkQlI57b5WcICizSLQs1/gEgeWVp0+vhip79eEs3NyA496TAhg8ISs2agWX7lhqFaO4gJDIiqYjrWuNf0ZJLAkvwxlnPvOl6uGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HxvNNAHg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58L6PGFF003488
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kNz1cnXxXp4gzrXuV4750J5uBw00c5aRRnJI/0NE9io=; b=HxvNNAHgkynK7x46
	K+mUHsqoOIZacNJ4CeC/wq2xlpElfvw7xR4WsmP5XCVIPExFih5WZ3pCokl9b2z0
	JahCdk1gKliFUTQa13RdFEX6fcD/D1C/cSZwrjplO8c/eQiEbtaeEeUGIawEkXV1
	tDVbLs2SvQcJeVJv08eWYT6Tf3rnlALIQlq5DEu9GEuMr+VzBTjlfAOI0LVXBXnB
	Rr2x45XIrlHQJyg/fk0A1l6UsI44gQAb1aT/fk8OQsP6cCAf14wHVhTFAcCMAwKO
	U1YrzkFoErrI4GrLjf8qFM+fRNgYAj9WcvkQjMrqhsy4kcT6GRWtExpp0q76mZbM
	61kN6Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k7ssxah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 07:11:40 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b7ad72bc9fso71362931cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758438699; x=1759043499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNz1cnXxXp4gzrXuV4750J5uBw00c5aRRnJI/0NE9io=;
        b=f1P0kCTHketI/TKn6vElzFaTm6JEpEo3PK5mXYiMaZw5R+fRCXJkgh4YYg3Wx7Ln4F
         /UYnczaoCpupdFHNlPSI/bqqloyIHzyki9IZUhqJMaSsuvr7su6WBtmWC7JU626zjNQi
         ictVusVoRL9UUkNORogxk9qU9l2aZtl8Y8pKQqN39Vkmg2jmlY0VawU8yJI80bL2gIBc
         WVL7mg9GKUJJK08BWIYie2fXIl6XArXvJH18hne96GRek+2SdNEJTSWS799x+sNSEiJD
         i3teQLw3pebpHu9/N67iwwBJRjww+54jcWlFF7hmmqrtc68N4wvnKkLXnl0ZAdqEBgZ2
         ERWA==
X-Forwarded-Encrypted: i=1; AJvYcCWEtDORLOUfPIMjsAKB7QDUJCO1/rV6Y2j75Xa1T5O0I+pGx8ab7yNHAuoJE6cvsat8jFtvOCCMxaOe8rg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1t53FdW5QcstNuLrkbvyZQDeSpIZQpYL4g93yCedf9PCvGXol
	bC9auRHRPzH0DdL8uwWiFIGtoTX42FYJuecLXakLT5SzT5GcAFBS36cXYl8Ac6MhowLTZpJ5drk
	89HMTKL8TKirS3TSbD+njks5GpPv60SjtTVyM+Ic47Cn64BxtbCSE8FLPO4uFz1lxtIM=
X-Gm-Gg: ASbGncuLfe2FTuTgOjaKmO2AZs4C70d6UvFr+7jl77xZ19gga9efpd5DVZlhs5mSmOr
	MAu8DBSag3kJI/DciALP8EwBgvWoiHDnNs17rBIhpXSq2/6sCnHNjwxi0m5dCSecds2SQztDFMJ
	5RcaJRA/Y9TUy04VTCT9Xz+2R6LZAnUyj8/sfKt5Ufi0YBynu4MqRf7W+MBJ6k5Gjz9RGIcVuvI
	dROghj5/g9ne8QqswxfD3OWoHSm5/1j7LGSb9atOM+IdnMOEP07/qQllP7BZxE7Ai4Dn492GhaH
	2SKZqDqEECI3GtvSphKtuuPQbl/g12rIhxhTjVjH8VBd5yK4QmQywP2QeRGd90zQZ5iEcDzhC7T
	xHnpQdwyQu5P+jk8bYFOrPHm5jXO9HIOS46C73CBsFs4cRGhb18Rp
X-Received: by 2002:a05:622a:11d1:b0:4b6:1acb:64c9 with SMTP id d75a77b69052e-4c072d2d5d9mr100406641cf.67.1758438698941;
        Sun, 21 Sep 2025 00:11:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/gPyDWmRNBkl5UV2cfMUtRiih4ggyLOshMaxW+JJa3TbXIgaLn7/c1gLOiBlpPMvvmZz1Hw==
X-Received: by 2002:a05:622a:11d1:b0:4b6:1acb:64c9 with SMTP id d75a77b69052e-4c072d2d5d9mr100406441cf.67.1758438698475;
        Sun, 21 Sep 2025 00:11:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57e06875c2csm144031e87.4.2025.09.21.00.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 00:11:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 21 Sep 2025 10:09:19 +0300
Subject: [PATCH 03/14] arm64: dts: qcom: lemans: add refgen regulator and
 use it for DSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-refgen-v1-3-9d93e64133ea@oss.qualcomm.com>
References: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
In-Reply-To: <20250921-refgen-v1-0-9d93e64133ea@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=zkiKWQ545lawisDQZ6UcjJ+C2fdKGwCIkk4moVU3rlU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoz6Uh9DvFtGnaoCCAOvZ9NsakJUzDIwXmToZnO
 A3ZMODOtxmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaM+lIQAKCRCLPIo+Aiko
 1ThQB/9Hn2Pe1z+Hc+rApl00pow6WaTnztYuv9wPR4zcG749lLNCVs7vNHdbJsR7givMkBAeYYV
 Hiy4rG9wo2zyisJl47tl1Jb7I0iwMHberVBV/8WhPKar+vxO4yy5mb6VZLsVq5Fng1cwx8iYnvy
 xFRi+eQ1U1qwvAspBIe9BiSLTdm1tPnRSObkRAJ0L4K9f0dKNDWQjXGq4e25SXBmpcvbNZ3E0S0
 /MmM0ucHFMVe43VESGrTRgji7I55uLBiKIokey4eiHWqYTaXEv/+KozLlfZ51ONJzAp+3ymqyX2
 xRQ3dkSeeZRMDgBPnipgm+MycRRksjCT1DOAS5LEPhhmP9T8
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfXyJj+8Q4Uwe/p
 Qkp+/ql1e8CJqh8d1n2EHwZQvpbwCBFWUVUe2J6T5WgQvqNmmZNeDCq8lZ2hBA90TEToMtinfHj
 J4Zh2eRpPevq/iig5lcSCZj8kN0MXvkA0FZNv6T25Vt4eSsvhNaHUDxcfHcMiIhlKAszQpVQT5W
 tmNR6QzmUR4oK3rhvcGLkGswPdz+oKKxgaM4qBxgk8L11T3tXEMAvvfNUSBEqsygC4A2vnCA/IG
 OSiNkP8MtbtuANaHqQ5rtblSIwJF+oD65uLV+g/dW3WyDrFs2Ew8D58ewEZihIvZieRwLk0EAs+
 2uDKsNuERye1raxWIduWxd4XtXS7nUi3a67FV7R21rRNKpObbQW/iwatX3GonRYwRmkOU4BDeWg
 VUd0bmOa
X-Proofpoint-ORIG-GUID: KxbivoF31dq6aF-nAtkpJEkT0tL-bCVL
X-Authority-Analysis: v=2.4 cv=bvpMBFai c=1 sm=1 tr=0 ts=68cfa52c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7Z5K0qU3zCLuYjkCW_MA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: KxbivoF31dq6aF-nAtkpJEkT0tL-bCVL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-21_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

Add the refgen regulator block and use it for the DSI controllers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 7b5f0b4d1be75d1aa757069522bbcf20898a321e..b9607cfa117c8a5d71105c7787a8db79d36cc842 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -3975,6 +3975,12 @@ usb_1_qmpphy: phy@88ea000 {
 			status = "disabled";
 		};
 
+		refgen: regulator@891c000 {
+			compatible = "qcom,sa8775p-refgen-regulator",
+				     "qcom,sm8250-refgen-regulator";
+			reg = <0x0 0x0891c000 0x0 0x84>;
+		};
+
 		usb_0: usb@a600000 {
 			compatible = "qcom,sa8775p-dwc3", "qcom,snps-dwc3";
 			reg = <0 0x0a600000 0 0xfc100>;
@@ -4899,6 +4905,8 @@ mdss0_dsi0: dsi@ae94000 {
 				operating-points-v2 = <&mdss_dsi_opp_table>;
 				power-domains = <&rpmhpd SA8775P_MMCX>;
 
+				refgen-supply = <&refgen>;
+
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -4981,6 +4989,8 @@ mdss0_dsi1: dsi@ae96000 {
 				operating-points-v2 = <&mdss_dsi_opp_table>;
 				power-domains = <&rpmhpd SA8775P_MMCX>;
 
+				refgen-supply = <&refgen>;
+
 				#address-cells = <1>;
 				#size-cells = <0>;
 

-- 
2.47.3


