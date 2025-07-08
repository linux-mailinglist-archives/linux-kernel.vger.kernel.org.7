Return-Path: <linux-kernel+bounces-722163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7001EAFD620
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA0B544B2A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C712EA140;
	Tue,  8 Jul 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nBSlKwxF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842852E6D30
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751997952; cv=none; b=qQqeAbozEsdTfgaP46i47KtT7AIuSupCgBFxbywDt7k85V3V+ztyaRB7ReEONcfQUjhuSB1h1F9sB9ju/NEvCLD3Me+5SonjLJS40lCf2ogQl7wvQ4XEmInCW5BPOnP3n3n1qVPsQdXBae5GIHyR2THJdxAi6iMDMoG75J1ds7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751997952; c=relaxed/simple;
	bh=3a0MWleIyO3gL2IRZDHzo83tNGJ9l+qQFqUNeP2HJrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ghHoXvbNT+fuzunKlWkPXoaZgTjMgypH9zTqak0BD8/vvS1UFiq78mhjTLwMgeaCzY7XTPtSuUbcO3Ba9vSehXC9pJ3ErysDZAF71wqZaAgY4MqklepYUpxW1lKsJBD8ijnUOEjz4eqKITlHEchTHyq6tWwSXhsYFOBezQIbGJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nBSlKwxF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAPxc001254
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 18:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v5EEqpTBsWK
	2r9AuHuvHgMamXxn21K03bgFNVlidZok=; b=nBSlKwxFq65reUnqR3XPaUODDaZ
	qkLr9zo66sQARJtTgLTARM37EQ84aGp3AaUq7ynXro+kdyERno2xffUVLfieVcwO
	H5aXwXy419XqvWmaFcPQYxAnfmg0GbQ+LOA+LCY/lQPy1AFwRQziFSj8CTzyQruj
	qFqGrabmJb5yeLQQqejREEsHkLu8ouvSxYiq+STCFD2aYUiHoVwAtjcrog9VKali
	/+EYoUjpMpCtcYDj119MQgXKcdjQdmnMUMHshlh4Gcva0gkWCnkwfWR6W32Jsoav
	k1KLSK851BBsqEnOIPgoC/u0ds/sKCdw2msK48sJ3caF0PurS/ksNBsvV3Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psdr1ac5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 18:05:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a584d0669fso97818581cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751997947; x=1752602747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5EEqpTBsWK2r9AuHuvHgMamXxn21K03bgFNVlidZok=;
        b=Eqded/P2+0dwpRzYvXHkF7K10JlKPNwPiquRlcO8eLw0fGIUYAEVTMQIN66T1fnRlm
         KP7/qM2t5L3Vgn6WYADjF4WE804/aM5t0KEJKHL5ZC7sr7Si8vxLqpFcg/IqAgUO8fg7
         ZVJlWzyJb2UtZDVv1MYaa0mp1KXwRrQtUPbrhZSxN1LfGSvqFM6dVd5avzRTlo/cCTgL
         wCLKPA0QhJ7eBoluPTGlTBDmWTgxkyl7Hd/tJoR5D9D6CskU26+R4Z1x4WuFtCaPcydm
         z6BDhbOhvSmPr4lIx6rp3JZWwvVMRyE/SUjjU++6QnHri6fZ9uY2Dc1BWXC14X4ry0ZL
         oF7g==
X-Forwarded-Encrypted: i=1; AJvYcCUSiNO7204j6DNBoJT0c9GpN4M53iayFDCh5xfEyPQv/p6idmf1cReU7h3ipr1DPivXbt5ONHQRdrrxaOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd1uhcUviijK7TxIVwc0AN0SaMK5+91xAvSyQJahbB+CWzQn8a
	ObEty+ynoLA1hJG6jO5VXLaQS8FtR3DO3v68Q7wuXl7NcIWygZCqtCqiprUXwa3jgsupIsb62tu
	K7IwHm9tRNGZ/rit+ji+eOv0URoCMOBowqxZiQGlghABe3QAzu1Ud2GBKNA8tQ+Kj2Ag=
X-Gm-Gg: ASbGncv4JXytdggeTdzmCEsLyFkdTfI5ufmOQeKHyY94cvJwg/cRKtcdZbnT8aGhUvK
	LolY0L/ADhbB5vvSdf18r1p89xV+bOu4WUeCBe/NjQBlbK8uR+xPy48ve2q7fd5K8qkQAj2Cm1C
	lAfjIZftVIRld+gVEjeL9Y4YQrmKUR7BlKbPiDeqcRk455l0hTTQB+uPC38qFIV3o/kOyCUdPaY
	1HfY+6kgvZwU9Vcw7W4c82z1d12fJIxlhMeIyKbtb/EKvDCsEl6fhPU/OuAg4WqLMPOFW02XVnP
	LhWVeEZ19k6ybnLylAy5qsfvwKRxpEu8MlMqlgHGjAWDr0LiLU/fPGaIkv+GZrQ0OHxWxB1TTQ=
	=
X-Received: by 2002:ac8:7f42:0:b0:4a6:f7a7:4d43 with SMTP id d75a77b69052e-4a9cd6c7133mr74848101cf.14.1751997947214;
        Tue, 08 Jul 2025 11:05:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhjWVmMm7n2+pNxplxU2Hy47+FGd6ZQWvQBUcOs7FaKkNrNRd0xCNwdMoqmPKRnemCM1vPcQ==
X-Received: by 2002:ac8:7f42:0:b0:4a6:f7a7:4d43 with SMTP id d75a77b69052e-4a9cd6c7133mr74847371cf.14.1751997946606;
        Tue, 08 Jul 2025 11:05:46 -0700 (PDT)
Received: from trex.. (97.red-79-144-186.dynamicip.rima-tde.net. [79.144.186.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b4708d0a5csm13394906f8f.29.2025.07.08.11.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 11:05:46 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, bryan.odonoghue@linaro.org,
        quic_vgarodia@quicinc.com, quic_dikshita@quicinc.com,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        robh@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/7] arm64: dts: qcom: qrb2210-rb1: Enable Venus
Date: Tue,  8 Jul 2025 20:05:30 +0200
Message-Id: <20250708180530.1384330-8-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
References: <20250708180530.1384330-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ffSty1QF c=1 sm=1 tr=0 ts=686d5dfc cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=oX6B8lV6/A+qF9mARCc04Q==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Qms5JgQ9tnEuTiNUcoUA:9
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: eVlAl6anaFE_m0028zOcJIf8-W_TJZAu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE1MSBTYWx0ZWRfXxH6dt8/EF3mP
 aNh/Y8T8Zu1dXy0eN3fHr4ghK7ZzKV7xnJj96gYmxdXlmMAN6Lm1JeQJuVh2IvHxxTSVEykgJIR
 h7cr+K04emlLbkO01usXb/riw7nlZ9T1IeVhcZ+VpK0yMSMr4SLgw5vayj33yUBmszO6+7J6O3W
 9I7T+BZzPy7HqyrmCvkY0xVv90LtBQ5ort8lJ/n4QmOSeTB1OouPwkIlVPYwGNiLEiVlSyEWvG/
 wVEVaAn7GwXYSa9ZjZns1tQPhmOMPganz0yYbmdNOFldhLQmJxjj/lLMkkgD1uXeBMYd+f/jJ0T
 7jY+zHwiGehxiiLkfAuEYp48MTsHjOhhvZyHvVondrPOPQJREi8qOvgCnqLZVVKkiTszuNTBn5G
 48WxMyfcy4lzf6qkfKSkh54u65PxQr2j6+NaUmkdptVP9JiKTXSZECD2r3Gk5Rtw6njcyCBf
X-Proofpoint-GUID: eVlAl6anaFE_m0028zOcJIf8-W_TJZAu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=732 mlxscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080151

Enable Venus on the QRB2210 RB1 development board.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>

---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index b2e0fc5501c1..8ccc217d2a80 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -711,3 +711,7 @@ &wifi {
 &xo_board {
 	clock-frequency = <38400000>;
 };
+
+&venus {
+	status = "okay";
+};
-- 
2.34.1


