Return-Path: <linux-kernel+bounces-851691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 236ACBD7114
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 124124ECEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8962E3043BA;
	Tue, 14 Oct 2025 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DAcJC8AI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA43043B4
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408504; cv=none; b=ZLiWhdl9oyNbQagyGim8GqzGJdKZhjLSk7TZQhgITXgjJvdnnKBxAcbT/lzSueEzXqU4TzoS7Xn9JhyU4aGZ/wBAzhTRi2mrE9wUWZ0PJFyYmcmADVfchzayRs5eRUzwU2lwEC+sg5hhgdxqrJ2R0iaXrXDAVFYt1AxnDqNvXJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408504; c=relaxed/simple;
	bh=7P/Mjb/RILrSyr86CTC8+aPwM0m8i+WFJ1L4pDQSCEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwW29sR0qv68msTI32LjiNzrof6Fv1Z7B1DLbTsKQ0u1qzaJgrbQpFvDqdAuP8MB7zwk6+ObvfETKjZ6jYzml4smt7+FqeskVskfXiworYdUYx6y6jH+4mlrXNJTu6FQzbd4dbvX06FQpbHWep8ttsJ6zSnnHL0LsSht0VWsgKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DAcJC8AI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DHDK8e012552
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=D9Ft7XtSCuw
	tEHNJ8fyMK9A5/LjPjLdSBZAdJsVq9gY=; b=DAcJC8AIpKBLtcJSKkf+Z+snwjh
	iIVvqflE96867iaz+kXN+eTzkes+vLxOtxjNBF6P0rYIoPesIrsmEprFakdJDLoa
	0AgxDkMmzskGXEWdhcBk/v+mGpy3oLzei0/qwahxPfnyOhANzyQZH8wIsBoD+W/9
	M02/Egy9B0vZIZ2nt3uN087gPsEfzaUD2k5PwZATAMLozOzfRovaeKZmrlVGIfqE
	oirisjFKEZcnkMLt35IZ5bjCZCRT+xVW7Ie472uDYMZM7FpNExaw2usliNjwvQWt
	2Grs6clWhgPB+KDttGF3nDV8pqzeAlfhhUsIgY+x0YsGgrmc/6o9u/W3cQg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfm5ev40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:21:42 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-336b9f3b5b0so10910752a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760408501; x=1761013301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D9Ft7XtSCuwtEHNJ8fyMK9A5/LjPjLdSBZAdJsVq9gY=;
        b=uCO2chHG4a69ZV7ERnZ1FpF8sf756Ny+f9yN7r1dpgtgeqqyCOAt0A0xjUQv44FniZ
         fCk52vmNCp1TwutI/vUERygbvskHKO5UhOw2zUtsZSmB/IvGBdDWZC5iaI4kQ+z479sL
         rXcUG14Os29DTkjAfxpZ/tnR9ZPzyvU3I34TfqUALYvlsI9XMwZmtg14Lbe3sn9IaDwr
         Oa8d2QdJUn5sAGfv5zu4SRxLuaZrKmaQomsaQLz2Kycq872OfmcuhVnMFUcNHWops6nh
         jAMOA7f24yHksYvziaThFWWkmFOBp+16wmjbFWYuJsXN0DLEpWHxRw4fObyYmrYs/S0C
         SKYg==
X-Forwarded-Encrypted: i=1; AJvYcCXLRHDmBuzP9DWXV11NPbSD0l5X4pU1XD5EoQyGx3kh7m4/O8VuvKuTR0bJ3PRhRF0CEqXOA8c/fc1VSDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc+B3+ac7DOFX0meo0Un4q0ym01I/vBW/a0DTbs5VrW30+/3wx
	pSSLS7D1et5zgQxMlLSrcf+YoJ7Lc9q1oAugie+7SORAJZpXCNGc3e9qPgAyjDFtq0CFC19pZuv
	qnik6qKs/T07KlfoM/K/dDs0WqtmpWk5E38jiTU+78j/AfYXdKaXh+4RFH8nnToMMbuRDBe1l69
	8=
X-Gm-Gg: ASbGncu6w03E0ck0myPaBLBGePKGcMAVaRSWjwJQunQDGz71vFekoU69NZ73N+Nifc+
	QWe3BcMsd1/CXlI4Q67n/t5miWbttatAxHymLfRLIEQt8iRJu0QzZjeFHD4hI4wex54BJObsoCI
	hhc8+dgfxiohIomN3gK+I9hUCIwedAOxKvjoz3OFcAnIvSVirIpUD3xIHboh8My2Zai9CLsYJXJ
	Tr5i6SgjU2t7hYGwt5UYhR8oFh9n8G6s8Ha68XQtXuuy5s7Vz/HudWfWhJYttwIfpBTfZr3oqt4
	2OEmVJPt8+qL/4Gf/BA8IvxjpwW0VMwfHN1nrRb/yI3RgWJ1Hkx/Ibq7Gu6XaltHPjDpWhNXSHc
	k+Q==
X-Received: by 2002:a17:90b:1652:b0:32d:d4fa:4c3 with SMTP id 98e67ed59e1d1-33b513cd9damr30188440a91.31.1760408500789;
        Mon, 13 Oct 2025 19:21:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZaeDbQuCRtuJqKS6dnyGZ+CH6r1Kps2oEH5rhJK8P72l5hXvpds7qoUKbRUfaNCKF4WTfTw==
X-Received: by 2002:a17:90b:1652:b0:32d:d4fa:4c3 with SMTP id 98e67ed59e1d1-33b513cd9damr30188416a91.31.1760408500320;
        Mon, 13 Oct 2025 19:21:40 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61aab6c1sm14006978a91.13.2025.10.13.19.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 19:21:40 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH 2/2] arm64: dts: qcom: x1e80100: Fix compile warnings for USB HS controller
Date: Tue, 14 Oct 2025 07:51:21 +0530
Message-Id: <20251014022121.1850871-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014022121.1850871-1-krishna.kurapati@oss.qualcomm.com>
References: <20251014022121.1850871-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xFuJJg-ZDUSag4fHytc7voAxebwl2XnP
X-Proofpoint-ORIG-GUID: xFuJJg-ZDUSag4fHytc7voAxebwl2XnP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMCBTYWx0ZWRfX/zF2EdNPe28c
 j5lZom47NXLqRHPSxXGkFzs5F/relTvrLjfcYu/bj1+OFFc4pzRP9G1WRYXhUGK+CjNBjR8kvzR
 XjEz9ch19aDGk1yRGKJShaCEqzZlN1X8dlTr2UD2u2OUHSNrDHVuG4CxZuFQcqvj6HEtnTgtSZO
 2llIQPZrMWt9sWQWv9YW0oIS1DMaR5wlHm82ei+KSoQ1BEfFMuPMb4bmf6bBA07SjnZf+ARyAjG
 fTgsYDjxRy1v2GzBGjWk1L/0giXmCRUx7MMwODKhfjTsXIF1UCf3TbzAO4V85Lj9X+gQ1vofJo2
 /PcVPn30HeSwgr1rDKRqOCBTJdG9yMq3+miYP9WOFSGWASAGkh9eEstv7kPYQIeO4LPu3m5evbe
 ikD7cOlEKra17+0N4bPxJGGAYEzyYA==
X-Authority-Analysis: v=2.4 cv=V71wEOni c=1 sm=1 tr=0 ts=68edb3b6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=klVtoc-wQiETt9k0NaEA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110020

With W=1, the following error comes up:

Warning (graph_child_address): /soc@0/usb@a200000/ports: graph node has single child node 'port@0', #address-cells/#size-cells are not necessary

This could be since the controller is only HS capable and only one port
node is added.

Fixes: 4af46b7bd66f ("arm64: dts: qcom: x1e80100: Add USB nodes")
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
Note: This patch has only been compile tested

 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 56f787a8d821..f66764299290 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -4926,15 +4926,8 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 
 			status = "disabled";
 
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				port@0 {
-					reg = <0>;
-
-					usb_2_dwc3_hs: endpoint {
-					};
+			port {
+				usb_2_dwc3_hs: endpoint {
 				};
 			};
 		};
-- 
2.34.1


