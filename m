Return-Path: <linux-kernel+bounces-831924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D912B9DE9D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4251B1B25E51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5C325CC74;
	Thu, 25 Sep 2025 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A54ecc7i"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518EA1A4F12
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786519; cv=none; b=NDB5qP4s9TeZDRQAb07tWJG8MeJDO4z4+piWQI+FaiLyyAAAun4VNX4t6izdsoL9+uOD01DIuKG/54aEYSMFp3SSmSWqnX1w354fVXhSgz+Pmn/Of2SjkIBv5lObd5CeDDPSr/XAF/LJOY/cDE9HeeJP1STiBhx8/jZlKYI2zk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786519; c=relaxed/simple;
	bh=kz8AhvRoxv5DfLNMb3yysS74jj5lUiwIoMBErv8uovc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qlucvNdDCuXyCdTA96z0C9V1RFyOChj7d9qwbriN5k+z61rGgfaUmNpDatLcdOrTWLCzpgXKvd7EuDdwhtlTV26qr52SZ02G3lT59Bg29JdUyX0dxhh0sh28pU2D/qJs/VI6CY+jITQQCUXwr6MncEoUxJBLLN/WlgGARScprSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A54ecc7i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0JSAM017434
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=t4DS4g/Aw4p9+wY0COWtzd
	LqmJu6dcvqt1gLW1rsNW8=; b=A54ecc7iIrfKN8frrBC1E8WDuvKRZCtm5kCYju
	FJFwXpG5MDTe0pUy/Ni22/r037WLxwba3/NTP9HQIh2zKej15dLMiCYEhrsuBECT
	lS/HT9q8TsZsAuNG3GFJqHxmZLtQPp9ibOojVlapjHt3Gy2TUWEAD6+RSgZdBm+q
	3luLt5jMhHgT4nCEYQTJWroEg6cJzONAYSVX9sk7FJ8qs7wbdKQzKk2gCn4tLUpj
	la4xW4UMXCgrOEU25GH3Nm+rs9Q56byo9NVgCTfJJ4YYibj+F/qlk8ebRhdXchrm
	L+nqnVeh31QL4zzZgBbBU/7KpEwBjzd2G4LN/vu2e51sfqlw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvk0k5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 07:48:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b55251a4309so545757a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758786516; x=1759391316;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t4DS4g/Aw4p9+wY0COWtzdLqmJu6dcvqt1gLW1rsNW8=;
        b=J1+t9sJbDNj5PhH0qGDHuOyzC2VSfL/wH9BENddA1tcFq7qJIGEulGClMaHrMJgjAy
         o3lt56rq4IjmK9alTg3cwooVXLHjWDqzb/Qf9G1RYI7R5q6ftMeHfIV6UTSukjTOC2+o
         20fNSRUZlRg4K8gPIfPDw1MGGr+ogE1anJNqD4GaK4eFb1uWXow4De9A0ij6MEQt4FZX
         lj0u9eB492SfaX6mbi2FZcNuB1Hv+2jpWJkKEIgjOprOaXVpQhqgqFTEFEwbk0G4NmsH
         ZUuJQlstn/UVSY45gt1RdS159X2KCn7SNiqeiwqx1ZsTwmFCmzim0EF+3jRiUdn+nTp+
         vn3A==
X-Forwarded-Encrypted: i=1; AJvYcCWzRwzW1tRRTOV5UBe5N8B7JLHNPhVwz6GCYUY8ZnnJ7p9Vrppe4NsgDaP/z2mNBiYixQKp8Y5VIPJCCbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4eG7ZqvPEJGYIupIo7OhauXlQg0mro4YL4kLZ2cM0noIaBGIT
	0hmpImlwapypOfhx/nce2NaC7camPENadQ3rnovZmTmvZbfRu+9BmLXsOvMFsCBFJAex2ZmPEuy
	XfLFn3PtpzWVRu8GDcCtJBPJdPso/OEK7FpvsJuRP/oh816UkjimF2QSEtoeUpr0sAfg=
X-Gm-Gg: ASbGncsbpwouVLFw0fPem3fQWGcUB8MP+uOsRDvKbvysornYWE4detyl1ArJethqX4Z
	/yFK62IB5QG5uu1XwMO3zBKW7Vo+aoWfDd2+tipG/Zh7VgX0aftRGwrqkp5W7nAC7TA12RF9SzM
	oa4WS87cC2sxVDIzYeZZzXYp6rQvwcx5xb1OdgJdIUU4bDJG55EJ+xg5kU3YIS5NhtXJqr9vjfv
	+sZ1y/JO9nvm8DeVKLv2ldNQCVnFCZTN3ybJ+JkmfxQnsDVMJjYiZr8jckkXxb5Oh9aOewE+VNt
	yHJeURWv3erW1IHr30qyE3QlCzoiqw7p6s5lwuxyLpSMopJxta5QWYsQUnX2wNEaNKhTKKnqRA=
	=
X-Received: by 2002:a05:6a21:328f:b0:244:3a85:cd7c with SMTP id adf61e73a8af0-2e7bf47c149mr3190238637.10.1758786516494;
        Thu, 25 Sep 2025 00:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC9M2BzjYTN1XPbvEUL80XC19PxiMlS3DyAurda1UfSKIrYxvl4PtOHp7rKLinnx0E0Otp7w==
X-Received: by 2002:a05:6a21:328f:b0:244:3a85:cd7c with SMTP id adf61e73a8af0-2e7bf47c149mr3190214637.10.1758786516079;
        Thu, 25 Sep 2025 00:48:36 -0700 (PDT)
Received: from cbsp-sz01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023ca296sm1209518b3a.38.2025.09.25.00.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 00:48:35 -0700 (PDT)
From: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 15:48:06 +0800
Subject: [PATCH] arm64: dts: qcom: lemans: pmic: enable rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-add-rtc-for-lemans-v1-1-17fc56451c84@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALfz1GgC/y3MQQrCMBCF4auEWTsQ0yrYq0gX6WSqAybRSZRC6
 d0N1uX/4H0rFFbhAoNZQfkjRXJqcTwYoLtPN0YJrcFZd7IX16MPAbUSzlnxwdGngsRh6vjcWeo
 J2vGpPMvyQ6/j3sqvd7PrPsLkCyPlGKUOJvFS8e93MG7bF1BAsr2VAAAA
X-Change-ID: 20250924-add-rtc-for-lemans-cedb3e630c4c
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758786511; l=1098;
 i=tingguo.cheng@oss.qualcomm.com; s=20240917; h=from:subject:message-id;
 bh=kz8AhvRoxv5DfLNMb3yysS74jj5lUiwIoMBErv8uovc=;
 b=dVdVUOE3ajtl4HqTD/3n77q1GENbi+6wzPD480EffVNQiKPp5G2NdIeSn0+XIc692ldBJfiGa
 9NbQ5CgvNdtCJp2U0CHgeBLc34QT65Ac9bKcx8IA7N3BUBHuDZB7dVu
X-Developer-Key: i=tingguo.cheng@oss.qualcomm.com; a=ed25519;
 pk=PiFYQPN5GCP7O6SA43tuKfHAbl9DewSKOuQA/GiHQrI=
X-Proofpoint-ORIG-GUID: XkKw1ztg9IVb8qiH8BApiLjHPWWk6UkA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX0C3wsrxuAimP
 l9EpPaHtszjqqfObeIvK0T92I/p/T+IkRCAjOYPQuhlJ8dnNb/paoasI0lHGI9NoJ+xD5Ira+YK
 JShpn5pM11xmodve9Hg17HRAeM+QmEZsp+nXQycih5XMyIKonNS+E3Wn6IWqnWBA3eGTzLLqLDd
 N39VcCTnxNRvMFnHVAnHqq23ODiE1XqpSE4CXzWbDd5+kxHQPcAs7/R7sCeoEerRsU5hYA3qSKh
 b54tsNQkCI1fZJ9mIWhFRJE3O2PKWXdr49jm3DhtNM1KTZn+RgZeN0l+kKapY4pGlH0uHf9ZCh0
 mXmfLpG2je1dWbnGMfhwQ836MwVQz0+iktpUPo9Dmk6tq1JsAER13zbbgrPRN41iwfOfxHoTd8c
 GtxYi7DZ
X-Proofpoint-GUID: XkKw1ztg9IVb8qiH8BApiLjHPWWk6UkA
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d4f3d5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=C6FE1wmIh1dHcrcE-zYA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

Add RTC node, the RTC is controlled by PMIC device via spmi bus.

Signed-off-by: Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-pmics.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
index 1369c3d43f866de9d8cd5cd4985241b99c0a0454..9e0d05c1b39ce229d5d4310ea1df1bf02e689178 100644
--- a/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans-pmics.dtsi
@@ -132,6 +132,13 @@ pmm8654au_0_pon_resin: resin {
 			};
 		};
 
+		pmm8654au_0_rtc: rtc@6100 {
+			compatible = "qcom,pmk8350-rtc";
+			reg = <0x6100>, <0x6200>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
 		pmm8654au_0_gpios: gpio@8800 {
 			compatible = "qcom,pmm8654au-gpio", "qcom,spmi-gpio";
 			reg = <0x8800>;

---
base-commit: 8f458a3ce73750c16af26aa154becb22bdf3bb0b
change-id: 20250924-add-rtc-for-lemans-cedb3e630c4c

Best regards,
-- 
Tingguo Cheng <tingguo.cheng@oss.qualcomm.com>


