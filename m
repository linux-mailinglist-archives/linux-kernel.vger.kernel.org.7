Return-Path: <linux-kernel+bounces-829904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7B1B98284
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED962A4815
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453822DFA7;
	Wed, 24 Sep 2025 03:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GkJJsX9K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF72AE77
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758686060; cv=none; b=uFpMtgxdbmBEM5gWpUnceui4+ZZundsw39owXOQtf3qOnCgFA5csql1yDv+rJ4VITgeCvwaUjYTQ6i+ZqiV6HIQ46t+E9mz1AX/NhCjQAX7SQL/CCsB90KYHyaocTF76O0dyGZ89Lo8I5yiCNFW8xZRT5QChuoM4DDpLTlNIdmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758686060; c=relaxed/simple;
	bh=Nu/WF9Ml6c6YsVo7Zy/YIo3B9jWxhA3hMhqvN1Z4F8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hSJkdHDc2OylKrxfp5rSYFuuKydwYRFFgHbfXZZad4A/mpfM+97fa8c6wtxEtq7FDBZL1H/rKzhwKsa9sCoOigwc88TLlJq3yIpd5IQqc2hhCvd5l+1ngWfX1HettlDbxSIZetePM353v1vOvyfO9uYutgoGV7Q5511nxySS9pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GkJJsX9K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O0WO2s015976
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=j/3ckqBWBGaw/aVVkFjuVsL+rcB/4ID+XJ2
	bnAbFK+U=; b=GkJJsX9KglNWNO6J8FBogG76QndvnPu2ZPwEK7T7Atvou9HAFlF
	Z1tMiFjdgD55nGmKwt3XlZdr+5eqMqa/vi6GqV21WUjh50pDKWxeDSewplCcRCIm
	Jt9uF4rY9L1sEj1PBDa3pjCEVO4XpImDJ3+2GNkC/x0/dr6LeUJBnZAQ/6aBWTVs
	Ej2Y8mzLI5xBxmXoxvlsJaZseXomaiI7ZsTwXcc9SMj4LhD+Ru8UawqixGWSMz2o
	STm94gFt9oPCT14FDcU9bewlnx4OhP3RmIw2cO3O3ReVP19PpgYDDiJnK/C6BzCA
	kKS1ehHWqyFfrspasFlJmYs9oeCNb3pXkKA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdv408-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:54:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ea7fcddd8so11690353a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758686057; x=1759290857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/3ckqBWBGaw/aVVkFjuVsL+rcB/4ID+XJ2bnAbFK+U=;
        b=dGGwObP8Wfn7SyuD3BcP+1EN0DhRXCKxbPYgyi+jfkOsAwMkxKtCt/hy6mDYNJXkAF
         +8Kyqfh9emt1vlehpuEhiw+cSJ9zrl2wMEMCjF2+WDinfoxZ5WptaSe9Mw//BwPuf+z3
         1ggC5inQNmI/hnPjfs991zcvBjWwrodHD+s8uAeVy8Ago//833+Fd83mvCazRHrPa5dk
         Rp4djCClALHdkeXgMrrW7xszx1ILsvd4F/jWCqPFSbApZGSpSJ43h8EDTvJYpOd72n4Y
         bHuKPNojELC8fJnCfV/iu+YcIpxfBk43kcGBsQmgzo6UtMKd51ccHW19WJtJtIk5j5Yl
         1jBw==
X-Forwarded-Encrypted: i=1; AJvYcCUtIcGCgychQF8VWr/hcv9K+BP9juYHKi75L0cuK2Yf2t/8Y4m4p4B11Ii0MuNV5cExvTk7ETKGwmdALHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnYEt5MCVKfsyevHEKs+Yn2EE3NVgl2L5zma9CcOrQY3krpsFl
	xKKM1lTRwPo7eROyy32wJ/yZggeMg50UZbKz5EOMBGQh/OzY2duD/c3j/Q/TF5KMST8pIfYqARM
	Ae0kNTMhB9vQDhpIyZx/Cf35Neznf2kJuR8wHkkf01jlGlDIMgJ53hFw+YONX+iBePPg=
X-Gm-Gg: ASbGncuvuTda14x56Ug04KR+z4IM9Mg8yx4FBeBCCEpPIfyMYHeS1uFnjfYLDw+lCd4
	YwULhRyuiMPFNVgOhwIMsb8vy7A2k0V3Aeyq7O7kMpJMuR8B3UcfkwLu1ladi9iXxUDAlQbWTPt
	TtQoCE8PYPG3nLBc0fj3taf6Y92QyRWgivhhE5yWE8lj3RDj95bpboIzbQYkLb0VQVJr2SV4wCy
	MopF+YHGL3/f9vIggL1AKblRn6sgdzGbGm7PcBjHkAuuW57dbSaCEM/Si1TrgQ9VvAVvh8HGIY+
	BYxZKUHNac4Uw/Xko2iMIpVJti9NWLxhRNh9DB7PHplHLZsF1rr6iGg3aaTBl9x1FDAscygW2Lg
	d
X-Received: by 2002:a17:90b:3d09:b0:32e:753d:76da with SMTP id 98e67ed59e1d1-332a95e9263mr6031271a91.20.1758686056696;
        Tue, 23 Sep 2025 20:54:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbrko3GJ0QqG1oehM35y/SAlmwzDijJZMdFCaekD3Nn7gzlJ5Px5HbAR+Bh4TzIkGAvo/bDQ==
X-Received: by 2002:a17:90b:3d09:b0:32e:753d:76da with SMTP id 98e67ed59e1d1-332a95e9263mr6031245a91.20.1758686056209;
        Tue, 23 Sep 2025 20:54:16 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bdb4082sm750903a91.14.2025.09.23.20.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 20:54:15 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v1] arm64: dts: qcom: lemans-evk: Add firmware-name to QUPv3 nodes
Date: Wed, 24 Sep 2025 09:24:09 +0530
Message-Id: <20250924035409.3976652-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: E6BSFTOC_vZ1iHzOqw430si4KpMJ3Liw
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d36b69 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=uj2zFQKwFRccP8yYN94A:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: E6BSFTOC_vZ1iHzOqw430si4KpMJ3Liw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX+OVcV3k4UYvk
 uF9tmaAIo4dlB1Tpsv7W1m0Dd8O0KSpN7Ut6xVCEdm9iAdiaqB3RQOv8jXkszuHWjenZwOM2D6e
 BOUO9Pq1WjnTMUDZ2k62RklNFNIwe812ig4mnBTDSw8GYXLx3uDlBorM5TJU2rvDqDnsKJ04Vh9
 n89W4bt3msX5fUbzHP5G5Om4tvGAXILpOTYG+ohg+cBcY/fePkBvW3iJFxNUUhKkAgMFe8enKTg
 5GEtKS54NOerTb3Ncx8MCDgEBDSuFIMui5zCMyq1JFvZc2N8sxdnmPLbHYiTbWj98+9a++8ene4
 qis0ijJIj6+MIL0RyuXzo6E3OwjOjiiyzkLBzO8grdEdBrLZePdee1JFbJFUehmK8e5I77pHI1w
 v0WRpXE+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_08,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

Traditionally, firmware loading for Serial Engines (SE) in the QUP hardware
of Qualcomm SoCs has been managed by TrustZone (TZ). While this approach
ensures secure SE assignment and access control, it limits flexibility for
developers who need to enable various protocols on different SEs.

Add the firmware-name property to QUPv3 nodes in the device tree to enable
firmware loading from the Linux environment. Handle SE assignments and
access control permissions directly within Linux, removing the dependency
on TrustZone.

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c7dc9b8f4457..b21fa6bc36cf 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -588,14 +588,17 @@ &pcie1_phy {
 };
 
 &qupv3_id_0 {
+	firmware-name = "qcom/sa8775p/qupv3fw.elf";
 	status = "okay";
 };
 
 &qupv3_id_1 {
+	firmware-name = "qcom/sa8775p/qupv3fw.elf";
 	status = "okay";
 };
 
 &qupv3_id_2 {
+	firmware-name = "qcom/sa8775p/qupv3fw.elf";
 	status = "okay";
 };
 
-- 
2.34.1


