Return-Path: <linux-kernel+bounces-735396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E15B08EC1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19FE177A86
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D035A2F6FBC;
	Thu, 17 Jul 2025 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SIg+XjZz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43D72F6FB5
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760919; cv=none; b=eZ2wWTlbg4WRJVjf/Bc3CPXPIkX+ItdvLbkJsn6cjs+IKPwEvQvT3BIXNWYJEZE0NFM1+3DASrJs02h7MO5IQy4J5M1Y0KI50c2E2VRvcca/0791hLaO5z8s6OV277Tv7lrKrKb9VRJKbHgWfDtSujhKREfRWZPCIVFJ4fH4OOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760919; c=relaxed/simple;
	bh=e62XasrSHfC8Z0rurv2mAXh/7HxCFsu1wN+MrwN9ftk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CgMEegm3iThh2YPPQg93ZxAt5TIhyDqD+O1nkWa99Xu3A5OBil2bxFQR5DJ2qrFL5jd8lVOE1nVpJy00iRvisvH3O6cFW2Cy+qOVOKx0/WCJ/NVHy2Qtl3EcxTul6SXs8F5av4kj5rRqGt4kBGpmKiuStSWs65O5eTkn6oJMyWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SIg+XjZz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBj5ju003066
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EOr/OjPds5RpcIm2BU/TDEzd1odaEkIi56AvFfjSPPU=; b=SIg+XjZzdNtHWPcX
	BEWDOFV6r0YmEmgqNFN9JMn9P7DdwEWKSfgpfCOs9aeEf/9N5R5Q3VQ4YFoPyPyc
	F9/CiylnChK6PxkrqYQkOod0BgnJ5BLCkGy2S99cFgAWUF7Dr8Ljj7DF8Dn0ttUU
	JdtWjg0UPL6OoHU6REgNE1e337vzhwKFGnQ3UmqEXdzps+mr4BzVuO/hUwwBCOmj
	gIMUrEfue6U7v4u/rRC5T4NVAMm9cHFPNiEVlzvCEg5HBextE1Z7za1zDTQtHHK8
	qniRQpxsOGfHdTlAsCowgmG3CBdOgHelRN98bL7jDashvre4VKataiSzSnL+6ajW
	HKNxHA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xsuksqyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:01:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b362d101243so771349a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752760915; x=1753365715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOr/OjPds5RpcIm2BU/TDEzd1odaEkIi56AvFfjSPPU=;
        b=utAq6FriwOGVlEe6nOdkg2Oa9NdHpXpez/1IGDBPUIIpNh/entanZAnYD4EDv7Pexh
         A7+0O6hi6/vckjJnGzTUMa2Ib6BnO9WwFq+RLDGB+TAXnbWMbnNzcwKypJkvQ0l0qtK1
         Bo3L5E9C3SOnQEm0QLZlOZaysBSIQsGx9pMk0EJbuMIbYhmrvWvxem4S+v8Yrpcz2SRq
         enYGuy2VyDMqkUZ2kqSaGCSolqnj5fMBJikX5VY5JE0iAVxFY12DN8tNP81TCxc+woCr
         /HsGGHJ1P1oOsoFhgxTJr7XfRTkqu5MKr3EO2r8dSYfGOGtRc5+3ElaAJHvRVZComS32
         vrSA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4Kmo9IMuJA9wvgtOx9kQRrukOL6Vj+3wuPgRo71GCwbAoSDpsG0mviPewJpTjuV/tmz3oxoMXimCoSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDc2t35B1bHyWJB8Dx7ZiMgBEkdBUOPV8sxgEuQExkvsVejmJp
	FcgbaxlnFdYxs/qUl4yGQMoZR8ysBmyD/wpzzvDrN9sevbhHNClw0J0OyK/vIqnteYA29vM5Trs
	JmewPBCc07rjDWuCOqiJyF2XBdWDeq9GAj3P6twNPQzBIgP3L/qRkoe4zDgijdB/gzXc=
X-Gm-Gg: ASbGncsh73p8lAIxmThslxvsgqUb5VEZHvAvCd4Ug/AlBuyE15cbm/fEr64408AVuhe
	022PrEYhKYwCne+e43ttgOYPwTTI0cHOXbRo4bpi4R6qhDCFAyHYWOUVT65nSgwuzv/MXoAowx2
	FepqoriiqoP6ggvnl9LMOtZTBcRd9cDb+eL4Bsje5Ss468+Hob0i3TN/kwVZPINQYDiJMqaHefR
	bQgXkXqFy21ic42Ci68Vf4P0UhIF1RXNb28pNpLhc0pHfEDZSzjSIoqEiMT0JP6Z5Wm6r4zQJs5
	77aGVitqPVDBhFBtxw+2xoDMfWKbgAQHGXSXirtQjv/Pj0kee5/wiLZu0qTYmYavtcbHYhAbfdk
	=
X-Received: by 2002:a05:6a20:2588:b0:222:1802:2dd7 with SMTP id adf61e73a8af0-2381143f214mr11866942637.13.1752760914184;
        Thu, 17 Jul 2025 07:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMvl3MAcM4sjD4kYy+/+p3tdz64aMRUaqIYkDD07g/QLTinAeONBpOyIiIidysTHEQEjPUng==
X-Received: by 2002:a05:6a20:2588:b0:222:1802:2dd7 with SMTP id adf61e73a8af0-2381143f214mr11866851637.13.1752760913624;
        Thu, 17 Jul 2025 07:01:53 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7507a64b57dsm10311986b3a.14.2025.07.17.07.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:01:53 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 19:31:18 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: sm8450: Keep only x1 lane PCIe OPP
 entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-opp_pcie-v1-3-dde6f452571b@oss.qualcomm.com>
References: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
In-Reply-To: <20250717-opp_pcie-v1-0-dde6f452571b@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752760888; l=1743;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=e62XasrSHfC8Z0rurv2mAXh/7HxCFsu1wN+MrwN9ftk=;
 b=r7CoP3HyktXj92XLKc2jPHd7tzYKulq7P2RE5k93K7GbLTC10b0OfqnOXhwx0gCvpiisoVuOh
 qpz2HrEPlbVA3JZgk6dOhKdIF9rXgbkjo4GDl5FCcacO4lWG0e82ctF
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: PyF9MIVCMEcGQh3yqDAZikz9B4NvRrps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMyBTYWx0ZWRfX8FdmxbVrK3F1
 8mSxipgcCgy9TuNcq97sbxmiSwMl8CKCqR2frVxW+05un8SGf1fnfIBimPbS0l/L++9qn37Sq/s
 +4fZsyC0NhkvPVNmn60BlJiDdpJwwQeQ+GMHruSUPq2tLvDPsAMAYeQ9j+zPi9lpFCsrDijd7+l
 TmPbKBUd3xhHFf6uIWFsIR7vO+pt8OuKTIJkGHlMAUHMalA/kE+gN/DVoIPC8ev4XBFUz8UulEy
 lmJ5JhbuVj7OMmTF59KX4LQiNXgHfqcnwA5/QSp3TbxKKUNRJ6nnwi8viwkL7+7j5zDPyx/XOl7
 8wMGMSM1NKx1AXpNH8NwH8YhewHoDy/eCGAQ+T68m9mU8zY9svxoptAz7lPN1bOAsa61MpXgPc7
 ijwMaCoqi9aMvpKXOFg4rR1uyrdQzUsA99aoWiKQ6mZsVb4dVl1WI0AmEXxlq3BUMUhmz+RD
X-Proofpoint-GUID: PyF9MIVCMEcGQh3yqDAZikz9B4NvRrps
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=68790254 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_k9ig2nQFDp-gxZIyLcA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxlogscore=614 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170123

Currently the PCIe OPP table is included entries for multiple lanes
configurations like x2. Since the driver now uses bw_factor to adjust
bandwidth based on link width, we only need to define OPPs for x1
lane configurations.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 54c6d0fdb2afa51084c510eddc341d6087189611..d752dc2b17f03284fada7584b5fbdf7672e06142 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2216,20 +2216,13 @@ opp-2500000 {
 					opp-peak-kBps = <250000 1>;
 				};
 
-				/* GEN 1 x2 and GEN 2 x1 */
+				/* GEN 2 x1 */
 				opp-5000000 {
 					opp-hz = /bits/ 64 <5000000>;
 					required-opps = <&rpmhpd_opp_low_svs>;
 					opp-peak-kBps = <500000 1>;
 				};
 
-				/* GEN 2 x2 */
-				opp-10000000 {
-					opp-hz = /bits/ 64 <10000000>;
-					required-opps = <&rpmhpd_opp_low_svs>;
-					opp-peak-kBps = <1000000 1>;
-				};
-
 				/* GEN 3 x1 */
 				opp-8000000 {
 					opp-hz = /bits/ 64 <8000000>;
@@ -2237,19 +2230,13 @@ opp-8000000 {
 					opp-peak-kBps = <984500 1>;
 				};
 
-				/* GEN 3 x2 and GEN 4 x1 */
+				/* GEN 4 x1 */
 				opp-16000000 {
 					opp-hz = /bits/ 64 <16000000>;
 					required-opps = <&rpmhpd_opp_nom>;
 					opp-peak-kBps = <1969000 1>;
 				};
 
-				/* GEN 4 x2 */
-				opp-32000000 {
-					opp-hz = /bits/ 64 <32000000>;
-					required-opps = <&rpmhpd_opp_nom>;
-					opp-peak-kBps = <3938000 1>;
-				};
 			};
 
 			pcie@0 {

-- 
2.34.1


