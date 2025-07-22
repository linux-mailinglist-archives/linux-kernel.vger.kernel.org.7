Return-Path: <linux-kernel+bounces-740457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B83F4B0D45D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6465F188EB00
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 08:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8010D2D5A01;
	Tue, 22 Jul 2025 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WhfhI59r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404A2C326E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172504; cv=none; b=K1wPZiqDvVf7ERMyAoxQneKieGRB7DLa3OLk9c2Hk4odSqQePbBrxPgFg85EhsSFtj4EJvQ+9GUxF3Ycz4fvXQsdgMXwXzmLLxZom9BvCUrNsbtphPaYjWjVNj6xUymh6/g5wsCGQuIKShiAxbAAoe4XBdnQRC2nCmo78+w3MP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172504; c=relaxed/simple;
	bh=zsNDOxtssyyXKwrA/Xqhu6xlTQfQcZiumpCvpHLeiVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RW6oJPXw4yoR3hOnQBqIFWxCSgqUIwe8ZwnTr2Ara2d25vYQBV30JBHBTLU4vFCEPaleWeA3aoMYAEpUeZx5z7XcfhWROBcBQI2/vwAccIfurt3X3FTiCd0Kp7Y6OKbtjV4hlZYGZeFrP4yh997RJx2SZWGVmvGT11b7X1gYAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WhfhI59r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M7W57k009759
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K9lCHtaEWJJtL5rVllaD+CR/7jxFq0pVmlc9VCIqSOw=; b=WhfhI59rGSx+q2e+
	JbK8pIRZaqS0QCBSUiktznOnF1ueX/Ik9b8G86lB/7a6t/dAz0TwzFUU7pOLc6Ae
	TuiYgEfADr6MQL+L9OoJbVVmXMi/1N7UNGAecGQifTU2t59TE+oX+bgcnPE7LIgP
	PLw9N5AHrnsuq2e7IY3LuPOKBFCrVpgJPDfBD9+bCnyugtjvjgPekCZD+5h9n4tx
	1XNaC00CRTDXgigKC46FasIMby11569RbJhGcQWEZA+3MjsJ+VTjuDDjp6BI9oN8
	pKyu2kuq4z8zeUxnt18KzPR/vamblfku+btRl9+kmqTzdugmWQoacDWUFzeBVxxv
	hAv0lA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481g3ekgnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 08:21:42 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b31df10dfadso3479785a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 01:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753172502; x=1753777302;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9lCHtaEWJJtL5rVllaD+CR/7jxFq0pVmlc9VCIqSOw=;
        b=D/otm+Fs2cCSGip/80HuzT+GoU0O5lMgMzAPknDtVNrggSGEzYk2GPWPecO9tqKz8I
         nxoTIhk/nr7YTHv+txpJIQrEfDRqVOHCdnEURosJX4sko5kIdJaSq8xXuCxRgVDjmQK9
         HWqy4FWAjdTSIvHCeDc2FWBu0pb5Sva8/TyzTwWz56iWb+ar13vi3TDgiEbQkCzKImhl
         UhNyiBzGgG37Fy2mAp/8F2d050yDPjdNXHwMjXKVlQjmbm3B6+mPgQv3W3fvZphNNsUf
         xASq6C7g29IiI/GYkwk3FsTDN0U/5Ebraf1pJ2Bxn+jouUPCoYi8ZMo68b/ZP4yywnrE
         SPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHFp/q+cotEgx21VRzx1H8gRckmrsUaejO10cdORICRN5MXgvDjSKAkFpzFa84d3nlICPFTrFCHDYEs8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXOraJwi5+TQ5rXNQVJDP6LvEfrjZ+1n5G5XGWr62rtfiZhebn
	RjoSlnxELXgQvD1tYc86JFh7JVfYGscOOid6kXIYjtd1+Z99CdJXDOHoDzbKa/2jOMW1FELMX9P
	84COSwT7vH/R63yDE5xY4QhyVOII3BUxivwyiv3a3AEqSFCfD6naHcDieJDZH3Uq5cXE=
X-Gm-Gg: ASbGncspUTI5zARB8Rx+ma2ew9jYihLI3UOGkW1araJkJlqqU1BdeL1LIuMj7SnwlOC
	BZZtdbPFe1Rxltr776O9ibyKxwm9895GctDtkakg3HVst2GnBIFtIl9uebZv6hWfK2TsLEyIinP
	J5LhJi+DpV4rGL7dt31EDHza8gl5Qbzh8qB20QyMnUKgxSp0MIDvUmquT4MTScykqx+QJI54Q8s
	5gSECx2Z18X+q3RTnV8L4cpN4E+yie2iQZFvOVTI3ONzUziovIrZ0yaaMVW7MmuUgpfjJi/SrCQ
	SaO+GeTPJ8lYt7M3NrNIYKWNtTkoUslPjYS0iSiWN8W8uB7ww/kiWmMhsCTr
X-Received: by 2002:a17:902:f683:b0:234:bc4e:4eb8 with SMTP id d9443c01a7336-23e3b883340mr253149035ad.46.1753172501886;
        Tue, 22 Jul 2025 01:21:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMHeIru6AMa2BMVF2ulTO1NNIkX+FjZ+wMn9YJ5/aatntmKA4rjfIeF3aKgxv0OKGhiHqBgQ==
X-Received: by 2002:a17:902:f683:b0:234:bc4e:4eb8 with SMTP id d9443c01a7336-23e3b883340mr253148685ad.46.1753172501448;
        Tue, 22 Jul 2025 01:21:41 -0700 (PDT)
Received: from yuzha-gv.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b60eb01sm70994255ad.57.2025.07.22.01.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 01:21:41 -0700 (PDT)
From: "Yu Zhang(Yuriy)" <yu.zhang@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 16:21:27 +0800
Subject: [PATCH v5 1/2] arm64: dts: qcom: qcs615: add a PCIe port for WLAN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-615-v5-1-4677e70e25ae@oss.qualcomm.com>
References: <20250722-615-v5-0-4677e70e25ae@oss.qualcomm.com>
In-Reply-To: <20250722-615-v5-0-4677e70e25ae@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Yu Zhang (Yuriy)" <yu.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753172496; l=943;
 i=yu.zhang@oss.qualcomm.com; s=20250625; h=from:subject:message-id;
 bh=zsNDOxtssyyXKwrA/Xqhu6xlTQfQcZiumpCvpHLeiVE=;
 b=udUQZfWvGiNlY5YaptGAlEF3HxsBO5zF5yaVZjXcmtmaPO6L2TzHSYybE/XnX2HMTpXFJDql8
 xiz87+MSkPlCgCjTVUrtAm83ZiyTJgya3Iujh/e1S/VKhBCuhtRLE/v
X-Developer-Key: i=yu.zhang@oss.qualcomm.com; a=ed25519;
 pk=ZS+pKT1eEx1+Yb0k2iKe8mk1Rk+MUki89iurrz9iucA=
X-Proofpoint-ORIG-GUID: TdNHySI91pfpqWO-zM1KaX6MsRhQuJRY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA2OCBTYWx0ZWRfXx9sVNWZM7clb
 A2gcPFS+iU49rzDEu+BGD60pi5WE2bRUdR7tD6UtHQA8eXF+v/nLnJ4OyQBc/1TSs7LIlYlVssu
 r6Tw4uL9Y+/SfCKApvBcorBaSSV3on7hVSurB9NjZHQRmjCMaMTFrt+x8AAKW6+dTCYfloRRysQ
 rQ0X/SyFZlSGFx6sA5zU3Wj4E9IYV5vMCO10oZlocAtXjPtS6x+Lsal9Ht9GDLhohE1/6fdDsTY
 I44HYogq8XSwnJkJbNnHnvqD0HUN3oljCOIh6jsCW9bsnS3MC6LnEdlGfGgphVtsFNAHqggEh9i
 hISJbgdYYWE7xZ9d3qURMlO2j/CLejiAvDQs7STxEv0doJ9oD8BAVfPdZW5Xmj5bveh07g8NFpB
 6K5w5CaUG3C545ddIBOsxWVIuVmv6X4tEzT9y8v/l/gigSo/U1of10sHXevTY9QOsntAtaPj
X-Authority-Analysis: v=2.4 cv=Q+fS452a c=1 sm=1 tr=0 ts=687f4a16 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=dI-8CA4c5Xf8_vBnWYsA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: TdNHySI91pfpqWO-zM1KaX6MsRhQuJRY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=993 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220068

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


