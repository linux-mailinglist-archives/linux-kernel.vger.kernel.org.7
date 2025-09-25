Return-Path: <linux-kernel+bounces-831849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E541B9DB28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474943843AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DADC2FAC16;
	Thu, 25 Sep 2025 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lO/DcirY"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195682FAC14
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782060; cv=none; b=oSgAsz+yGkvWhN4qY9LKGVi6KtmAWo7IE+HWEgccGJBfdcwcOWxk9SlHckKtM6XIXHy5pbVD8bORZgacGVzNmMIE27vA5z9XxXCJjDm6RKRYQDukx4UZjCzxQcR38WMN0IuwB5w1MI/7dgsHWv9c7CnlinnvvIY4fyWN2ymJsjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782060; c=relaxed/simple;
	bh=zAluZpUSdpNgn+3ulofSw8QkVZRy9NzA5+UkWEERqLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JGEpK2pvKtNQ2gNBr/Tvf9qBHTvxoLJeDVm5SMLicnPWDdtICmtiopXufg03KQ3tV1nJQ2YfVQfzZqZA5yYuWQ4qoWEqbLew25CF/jzVZ8ZjwmCL3TL3qJp/xJUPGLSkTWM8j4Oz4Hx+YhiAyCdFPeZGGCTENI1h/Q1fVBrK6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lO/DcirY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1fAfW017420
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ueg8cSB9cvZ8zN3y2yyPUU6opBQriygJdKD3HM9HZ1c=; b=lO/DcirYB2f487eX
	R09xbXyA83a/yT8wr0Kv6EqOfiq35Ks9m66ZVBN8PSndPkdd39YtUgGhL3WC5vWl
	CNkDKiwIYcuLYU3NA4Bturd6ANxBR8PHiFUD1fODtn749HLVHvlCbC7VElXU8Xzf
	YUHzY+ei/hczKpWfz0EcZuCgW+GgMkXA91pnCAD/BBQOaA5O//NmcBFKs9OAiHbS
	86PKlkFAUMR/ehT1LYjo0nFp36uUKqVAKZolGfh4hB3P1nE+ohG2PIGObyXuOLSg
	p46Y/Audp44o9+Eiw4mK311/xegu6YlYUYBvUGx8LKkFe6NYv19MPa0YwwmR63o6
	7PNO5A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvk0c8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:34:18 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-277f0ea6fbaso7845815ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:34:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782057; x=1759386857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ueg8cSB9cvZ8zN3y2yyPUU6opBQriygJdKD3HM9HZ1c=;
        b=NM8VOTNiQvPJKtrkkqooM5df6+jWQRO9naHaKDeMoKlb27UnnmlYueTJxi55iItcwc
         mrftBpEMmRC+bxJtScL7i6QEWM5i4ReZz28s7ns7EVxXoDnj5k+UnvAdQ+WmXw7WHOGy
         yoa9mrHbMhOo6Al7+C+CAHwjhw0SVcwGG/aIyLzK36+WSIOwK3xm8WP8y05rZMWdkzXY
         nzSJaS9duRiq2J1ztoqFe46DzzHsr8WS4njRIjmQF5w1OzjPJXVY3CohlC0vvhakqW88
         NJ5fLnAtPlG1fFa+UNuRGDM2dgEMvNbbftO9ixM4VnAbfPFtfKT9lT6p9snzvLqIhqTp
         IcrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZRdc5khN0W+w35IAYwex//zBDRHWfQ5e4ctgOqVxYyogPkMikTtXj+HlSIaffymjhPQGac21zfMmHGu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3JfZLQes32W0dwDOLwiCO9Y3/+Al43EPWVD2SvagX0XpiG/L
	F0ho/iiR285tQSQalllI250m7m3ZVVdosduuUR8xyWOq0Eitb082Kc7KOISnzhUwaigh+zmYEqW
	Ihz++O0zrRqfdrN3NZS108aZZIkFUOCUP4RCRWhdC12rPcD1LDvwjzIFIntUumCnuh1o=
X-Gm-Gg: ASbGnctyML6DkC55s5oa/O2XUonVfH/ebOp4/Si86V5A91y+WdXymJrX9fW4wscTEZO
	pjJ5Sk3KnhR36ta0iBkTlxykQTGzWTyXheyVN7hSP81cpf/kgFJBU3lzYva8rPJL86QGolnDGAO
	bzBZzcsUcKWagazSAAGzTHkdr/TohvmYj39TraFOiF+A8zRgv3YuLJjn0aRHZAJpl/u3egnRcBa
	eWxR98G8Lk1UZdfIPYgkElymNdeoKvTc7oTAqw5QWZKIWO/SSNx2Pu8vlBa4IIfjAYpf0ZI3x4c
	Z4Nwx2UGWzIXxLuvMwuPLn//GpnA6i/CnD6LaNq8cInkphQ/bVc4xeL/V6mO4stPb+FDcbmSkTL
	X7aF2MDLOTQePYWU66VERDDeDftDk9JA9iMlZn8Ljred+3URP25hyveb3Hi8A
X-Received: by 2002:a17:903:3850:b0:267:9a29:7800 with SMTP id d9443c01a7336-27ed4ae4927mr28093765ad.59.1758782057538;
        Wed, 24 Sep 2025 23:34:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpuQbjvhka6L8uxEmpmFi8kOowFBFt1od6WQeT/Ax2QNgL0pMDrQ7F4TD/30GBC+nOjY0wPQ==
X-Received: by 2002:a17:903:3850:b0:267:9a29:7800 with SMTP id d9443c01a7336-27ed4ae4927mr28093445ad.59.1758782057146;
        Wed, 24 Sep 2025 23:34:17 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:34:16 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:02:26 +0530
Subject: [PATCH 18/24] arm64: dts: qcom: glymur: Add PMIC glink node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v1-18-24b601bbecc0@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: LspEnxFr1kAPYpVaaB8hYCLuBDlOc3qP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfXwZU8kNrvgPRB
 3bASHdEkVj9UAOJwt60SM0gTgzPRkAcnOAX7AuPcvrv70e40ANQMuSq4DtkeWSyfyMjpLGRlhnP
 TWpgUzdLwD4PShSz9YUA281Tb2DIWVf1Y8oCpjDLKS/yZEQkb6zGK6QMHdNq5zMAXGrBkpdVbSP
 aYUputXawtAb10Vmom2mqB+CxNlYJHU9UI7yRCpfp8d7d2QvPYfLOMmUWCOReOFXThiT8oG0S8S
 cF0kE1yu9+PKJdi7AKLj+HrMbthq8cEn4wYPkYC2FSDH4i/T9rnfjyGmKHtqHtXZEjglQmJZ2cZ
 cLNE4odQ+1gQoRL3C2pbzX5oL5Z+sg7/Co/+TRjZl2Pss9G4q/e7ajRn71hynjT0Kw3HFLxFAis
 9nKCEtSU
X-Proofpoint-GUID: LspEnxFr1kAPYpVaaB8hYCLuBDlOc3qP
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d4e26a cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=eTml_EgcGECvy2QnpD0A:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>

Add the pmic glink node with connectors.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dts b/arch/arm64/boot/dts/qcom/glymur-crd.dts
index b04c0ed28468620673237fffb4013adacc7ef7ba..3f94bdf8b3ccfdff182005d67b8b3f84f956a430 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dts
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dts
@@ -79,6 +79,34 @@ key-volume-up {
 			wakeup-source;
 		};
 	};
+
+	pmic-glink {
+		compatible = "qcom,sm8550-pmic-glink",
+			     "qcom,pmic-glink";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+				};
+
+				port@1 {
+					reg = <1>;
+				};
+			};
+		};
+	};
 };
 
 &tlmm {

-- 
2.34.1


