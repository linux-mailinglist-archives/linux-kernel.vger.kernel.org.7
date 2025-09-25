Return-Path: <linux-kernel+bounces-831822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FF4B9D9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19B193BCA28
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C592F0689;
	Thu, 25 Sep 2025 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cbw6CExh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D8D2EFDAC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781797; cv=none; b=Ljv2AnMPgiUqnbT28UORREC9TPWKsHV79+8ZkIbg1EnxQ3mUHJM8LUz/mmvIW0eoMNZsi1tdkJ2keBNhLozDksuV72ngvve9q84sfMtlVWiKTT5wBSI+wjoynLCDt7iB+ktSOqB080vv2YqM1QW5t3/YXH3NpgWORtxPvSWQceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781797; c=relaxed/simple;
	bh=zAluZpUSdpNgn+3ulofSw8QkVZRy9NzA5+UkWEERqLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=okEeH6ECwJRp14R/iGnwCdfuEBNtcC5onRvzwX3g8P3J8DTxHYFeFJJGvPUVoHIlcwlQfi3ABVYGkRBQ56WcCnTbKOaPSZz5d8ERNtA4aSzwUY/PYMxwdsksz3kYmepFLK9qb+sb4vFokytMYcXsJpvTknX8THpIJjO/9nahhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cbw6CExh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0t4ai029720
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ueg8cSB9cvZ8zN3y2yyPUU6opBQriygJdKD3HM9HZ1c=; b=Cbw6CExhiWtoiCM4
	5WpRZqowOQtENxXL8KK0X5IWnwNBwDHbr9ottS+Hr/o4AMp59qEsDjnsfIpOO4fH
	WhGbqsvvEunx2Bjkwcc+hQblYQTy5NJ1O2TPsBlkjlDtubnNwPNCnE6Wx/wxdIMr
	+39fiK3BV+nKYBupcl6GLdkxP5jvXHcfeLJTmVY9emwb29UZ3RThWx6YOjQNeEJB
	+K2I86IkXblt8Oahw7lc6jFGJHn/B/SEIOxNSvgaR1R9UbjnFp30miJnSHiHp/WF
	PEe3XhwVM7dJ04uVdXa8kl3gFgTwwIniSdXcCQGppT0sypWwF5Ttv+xmvAosKLe7
	azqYyA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499n1fpwbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:29:55 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-780f914b5a4so706079b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758781794; x=1759386594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ueg8cSB9cvZ8zN3y2yyPUU6opBQriygJdKD3HM9HZ1c=;
        b=oLqW/XtZmNXBwhTaS0QWjngAvFbgYa8nJq1Q/59hK2oNuplFR98IwDMpkSPJf2/PfN
         3HEYedFcSsALKgcpiTXqvQRyu3LsANVioLc7BvnBCiQJJtD2c3nOeT1aVkZMn+lgLAes
         5EARoL0RUqN2oAX9HkCzrKWsHIBFeGRqJtx3kiBTZ6xKNzB9QTY9gk8UWyRI7FM78GGc
         o9FtriDDejmri2r73mniMP2Snw+BONTJPT1BzszUiMcaub9MGjfR0keDgUT9xIATYUm0
         a3oaIZO8chP01BB98BrRbIZ06veTHljUnw6lnH4gaOurdU9Mszlb/gR0Qae546y/xdtF
         cFDA==
X-Forwarded-Encrypted: i=1; AJvYcCVKZauCArK68xMlxAXepbqcf6v9r62VHG7MN3pWm31Mnt/6PHsAVU34bI1e7Qs4dDjTPqfFqEmBcIXEnK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQr1iPaNgkDOM8ggi1LiK9fSDDuBRrGoBlWJ5Y3XmjfIUODcRL
	2lLqSy5V6JQAZM28UIoNvyGIkRsjot8qcdJNCPrSVF/57LQv9fG2Khg8HFBS/Cn1+sRTKqQ8ZK2
	HEQ36iRB1qm8NknyLks9GG4wUhfoYQZRBs00c9nuCRiVcielduQNtcMCmN0SwGNtz0YI=
X-Gm-Gg: ASbGncsURX1TEzlB33Gh5J43sSwguT4YkCDwUozCxHTRQ2/9aZRtzGWvWUcbFQi1Rpj
	kZ12ThBBxzY5f4Y04ybR8z8kUZr2874nKehIaW8xJ9FZU5t5ERCO++cvqW9CAUM1Isc98xHRKxk
	kxXzYmQsrFz7ycXH1FQ6IIsO9ARtGHwF4D1bGc6ey+KT4IBkiqEKxVOtcGJRvcY9k06HfyTKJ50
	9B/SUBmKSBcDovubAicxn7RzNUnp9/XxFYIHMx8AAMmFFX6u90FzSz/kcFOK+Jz1EcmYpdAaNDF
	D1rywXnDkZ0Kp4/etTfunKfaqsQDGVyL/2xo9pN4R28gCSEaY4n+i/q222oQ6Zug8onWXVaceVi
	rJSHhTodXJWrt0FEN1Cv4mrL3AnkFB6FTIzIagWFxeB9/mDL07787GVY/tKKm
X-Received: by 2002:a05:6a00:854:b0:77f:156d:f5a8 with SMTP id d2e1a72fcca58-780fce1fb4cmr2847504b3a.11.1758781794420;
        Wed, 24 Sep 2025 23:29:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDHNVbByT2YfiBzQeOeuygXP4u8xrlwF4Xrp7NrE3lyiiFtUAMelKHPzX8XSDaQONjz3u+Sw==
X-Received: by 2002:a05:6a00:854:b0:77f:156d:f5a8 with SMTP id d2e1a72fcca58-780fce1fb4cmr2847485b3a.11.1758781794013;
        Wed, 24 Sep 2025 23:29:54 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810239136dsm952962b3a.5.2025.09.24.23.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:29:53 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 11:58:24 +0530
Subject: [PATCH v2 18/24] arm64: dts: qcom: glymur: Add PMIC glink node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-v3_glymur_introduction-v2-18-8e1533a58d2d@oss.qualcomm.com>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: UikGZFzMaJr3cJvaiB69JYlYg0Xtu5ya
X-Proofpoint-GUID: UikGZFzMaJr3cJvaiB69JYlYg0Xtu5ya
X-Authority-Analysis: v=2.4 cv=No/Rc9dJ c=1 sm=1 tr=0 ts=68d4e163 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=eTml_EgcGECvy2QnpD0A:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNyBTYWx0ZWRfX1W1EDjgYbqkg
 Io9+EFKjbuJOtptPJdLrmHauSOnwPVQzDgdaRsI6R/bFC95B/qYxOWV8Y866DJ+ykjiXd+Tx8W3
 qnH4W2wRejotNReD+AeQoQnaTAp6tiPoTbpzNPsNaAkO3an5uXdyFIkVG5iO0/gwqQ3X9UfSzyJ
 FUHCpjm5ArBvdtKIeqLuxZ6SSYIVHarKvfDk+Sf1lQRAd+9oAidRPG/Hsh+V2wfis8jhzeNwEWw
 shtn2ooUslij6twPmQvaqQQabbIjv3iP0pGPAaPoAGeGiYeuI9blSx5tuAjaCdWxKPekAidwQzZ
 mbW0JQ8C+G7IgXBITpByet5iwWuj0N7uJxaqeOxkvi7ojuqv3YXpZLi/FDlBFKFY9O/E+RyFdhX
 oPpC5UYC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200037

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


