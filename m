Return-Path: <linux-kernel+bounces-720924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3181AAFC22A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096991BC028E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A502621FF3E;
	Tue,  8 Jul 2025 05:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EpiYJ+uq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660DA21FF39
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953175; cv=none; b=u6v/EymsHIwlvpR3Z58+zKEY6i08UdkQ5kaicCrBrrwVefdOPw3IxgaPX6Gj6NYI3E6dWZayL6IOV0jdSQ4T0BtA5ORq+NOwrPZrhq+1vG3+M9eNSJBQwzqlF1/BbspOfLtNkyOa6zjXnA9pShjwV8fNe0GLCg5PDlRWFFmRoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953175; c=relaxed/simple;
	bh=vExvAJ3fzG/Fausbkf5FQmv3KT3IEQ63ck/Zdzvjh0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxYU4l6T0ptwVO4miu7IW76at3fTC/y8lJvSO/HWx8vMtdb8AXHNOaG1XkJsbGdNV1vyHQavAWzdtPMrpCJgFv0pQ/e6t/BoDs4xxUXIBwYdTnqvLNVzzRCaXJXg4MzcxbWvRhkUfrbN+ut2OhpigY+pm4oYcqgG6Lre4YQo0V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EpiYJ+uq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567KVAsT011890
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 05:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d+ZZAEh66WZVpAW83aZKqsIX/NRJBq6LQmw2kBjpVis=; b=EpiYJ+uqxXRyyUGG
	toCjtQz9TD7j4avKK/dz8TQ5LhlF/iq0b3Le2iK//Q1SlOFbB2vjf/YJMbmP0ybq
	1/wcL0cZKGTCyGzUVSnqI3R/6GbY/thOMqY+DooDkxRmqHGDUHiLOQHVGDxjCkaX
	b7Fs8boZ2ZhcZhFJrgRmsgR4bPRlRc/4ttZ6GH8jpUk1FnY+ygVdhI+SOEuJ5yH4
	AswcXO2UrX0+uLSngotNtGVHwttapmft5gOECWw25fe9Y6AfBOCiQnlmo4ytgTRm
	Gb9/Jt9FnamKvV+6KkWuk5NJlxLw1sSv74oJJO7wQkVt1TCo6ifet6RAaWes9IA7
	LzmNdA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pu2b34af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 05:39:32 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-74ad608d60aso2958722b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 22:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751953171; x=1752557971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+ZZAEh66WZVpAW83aZKqsIX/NRJBq6LQmw2kBjpVis=;
        b=v73PwZiO0s/AVllYKelSiYXQVZwfE0jKLuNVO6saUAP3wYBxilF3AkvAvwkq8j3ZI6
         p0xdhmMTeWQtEGcjLMX7tGZtEilr/qACGEFzEfQzSHSDedBrcHqpAZSMuW4w5eXUm01s
         1jp5ke2Gwm7AyfD2A9vpbqgk590SoM8w83JoeS29JMln9Mf9zM8nkdoRp8/wI2Vp5OiP
         S/iW7t94wvLqJcv1Jk8PWXf3L0C/EbCe9N1aXF8g3TdDlwcJhxiXzkG6glCds4mimTxl
         lXPijhePbErIJPDQ6qDzsZukgyKcYcecQ0YTnytLYI0+2EEO0KjrWNIf4ic1dI6y2Hqm
         tqkg==
X-Forwarded-Encrypted: i=1; AJvYcCV0PQzyRY655A2sbn39ZFevJERsGeibNbO5mvir/yqlYQjX4pyupJtwOVbVpEDL6NoCXOHkjU3he+yrS2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCUtBLUvw0nD3TbK+1uJscLyaak4StZ8Km1JwMkfmFAsd5fLAV
	HzDOIXWRFy90crcIyPLeG36Y/7ys2UyHz4vD9Qf9Y7kUzaN9O32Mn2t2mAKChata5lcDLBGrsDi
	2Jl9qOVDHIzv6BkDos4k1KLGU2vRIatRJEO18CQ4h9rYbktCt4b+ktHL6ebYje4AdbwI=
X-Gm-Gg: ASbGncuUobr4ZUYHzNg5MaYfZWhse/99gveHCaUS/eY5t56hREu/xsLmbtoi47BBBzJ
	QVKjTCsMewgoQ6XQcTUCq3Q/dFRMcAZcEH+cMDyzS9Pu+zcjSaRiEs4/tIge0ZxIq1D9bS/VFpI
	2eeZGivQc9H47CHmu0vSg3aN+cWfkUgiEe0BG8xeIk16w3alaJ7XeGAycFmXm663qv0Eob3qjwt
	1k7rbtEr2+x0gc/5ImAg2xFG6tdTBF87v4DNSPUpK1wqN++dNXDlB61Q++lZJ3BPuAoqC6dTtd/
	y0caOJIyvVc4BaSS2dTwlhz0zIQq8BYF/DimbRw/ifnA2lKkiv8RZFj92d0HHNKkMZ3uFLtB7EJ
	KOI6D1kGNE2qgiplPqqY1/eMEyF2wL756ZJhslGeJHGBDT849KvUaZkVOkw==
X-Received: by 2002:a05:6a00:99a:b0:730:9946:5973 with SMTP id d2e1a72fcca58-74ce6306594mr18295009b3a.5.1751953171056;
        Mon, 07 Jul 2025 22:39:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUmTvycbT1dMK2wfBPeep8DQqrSwRAvR5iGq9rzdl7pj0gdnY2VdZoY4Jd+Nt2uHK/ss8u6Q==
X-Received: by 2002:a05:6a00:99a:b0:730:9946:5973 with SMTP id d2e1a72fcca58-74ce6306594mr18294981b3a.5.1751953170615;
        Mon, 07 Jul 2025 22:39:30 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee450db7sm10531829a12.4.2025.07.07.22.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 22:39:29 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 08 Jul 2025 11:09:14 +0530
Subject: [PATCH v2 4/6] arm64: dts: qcom: ipq5018: Add the IMEM node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-imem-v2-4-692eb92b228e@oss.qualcomm.com>
References: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
In-Reply-To: <20250708-imem-v2-0-692eb92b228e@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751953154; l=1207;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=vExvAJ3fzG/Fausbkf5FQmv3KT3IEQ63ck/Zdzvjh0U=;
 b=UmFCaM5iL2gNZNRx5sdIblNCa2cXd5HZso1dr08DbRwuQXB59xOR1LA84ce2PzcUcNnuDQ+RD
 D+Y2MkKfQaXDe+Sz1uUs4cAZ9OPxZdF8fsYeHlwc6+ZXyccvMwPyvh3
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA0MiBTYWx0ZWRfX+GKizgZodnNr
 qY4mELjozEGVU3RXa3teBAUzrX6WR1TDdvYoMy71eaOKE4dvYODyRS2Y12mnqxz9zQwWHK6HNat
 89i9Z5TveKj053mGl+X1f6hOc/eAh2Gj9ih/v75QVUZU3fgvrGoID/Bcf9AAH1CrMtmtI8uPCEp
 iGJNtBUmMs/5jolkrShUE41iODq2Cra77yIaWz4kwlqq4RVRvzA9kjdCae6l6y1Vze6bAm6mOfB
 9XYOfHjVv2agisqZUkiEFuRgF2THHz5QUUVcY9nn45RxAh3YoIb0YEkse6RichqHoolp3AlgjEW
 vkXgK+qyq52lVwCLQ59DOsx4wMOXSg/ucQ68dQeUEhKW7NX9w6ebKojJJbUTnuAXSNQBXARQOuT
 0QTr3fNYmNqRmdWwpyhylLLqa2SCR5yBC9ZtcEv/fVDsMTuo0Po5WXzF5aJRA/7ykLa9qRtA
X-Proofpoint-ORIG-GUID: eDPEwduY9PDkR0G3AwJggty4OY2TSe0s
X-Proofpoint-GUID: eDPEwduY9PDkR0G3AwJggty4OY2TSe0s
X-Authority-Analysis: v=2.4 cv=erTfzppX c=1 sm=1 tr=0 ts=686caf14 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=LzuAw_qlYXXAwiqMVrUA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_01,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 mlxlogscore=808 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507080042

Add the IMEM node to the device tree to extract debugging information
like system restart reason, which is populated via IMEM. Define the
IMEM region to enable this functionality.

As described, overall IMEM region is 80KB but only initial 4KB is
accessible by all masters in the SoC.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v2:
- No changes
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 130360014c5e14c778e348d37e601f60325b0b14..c57d855e373b7cb26a3533f4651df078c1188fd0 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -278,6 +278,15 @@ blsp1_spi1: spi@78b5000 {
 			status = "disabled";
 		};
 
+		sram@8600000 {
+			compatible = "qcom,ipq5018-imem", "syscon", "simple-mfd";
+			reg = <0x08600000 0x14000>;
+			ranges = <0 0x08600000 0x14000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		usb: usb@8af8800 {
 			compatible = "qcom,ipq5018-dwc3", "qcom,dwc3";
 			reg = <0x08af8800 0x400>;

-- 
2.34.1


