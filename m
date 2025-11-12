Return-Path: <linux-kernel+bounces-896686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C269CC50FA1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22F2734ACA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF7A2C21CC;
	Wed, 12 Nov 2025 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YWIyzax9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bEwNj5dU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C522DA76A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933343; cv=none; b=AignYhpfYKnntRAwUNx3wjY+3+hCqnCrexPymzaNRTeh48hapVnizCv+2bXw7RCkgkhP5dXT5hL7Nis549YPk0ETrPUXNSQ7IgnfHOF1JI5Rrk4ZDZAqaTBtvEwMSBFTb63YCLu2/liWRWUqSU2QH3gP0bRgf0egJ4s6HjvB5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933343; c=relaxed/simple;
	bh=qnRVyznIp2/9hXbw7y6c4CxmpQo/GrGH0lc7ReCMlUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lC1bRFDYQJZo1rGNcwGj6sdv9CYwIUSekpRkUp5QX9sYxuCihnAOhvry2pb8jBy4ci7PkSxWTE9Cm6LXJ3jpRucChP/nxGMZHEyjJKBhLu13JTtiP2PVLScnCzz79GW2gk8aIo3axqmG02xoAzPW/BYWGLz52tUhydJV03vD260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YWIyzax9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bEwNj5dU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AC1HZi23683710
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SRS46F7+myfHHV7nZlBsNh
	Dj7nA6bojeVEV1V5g3wDE=; b=YWIyzax9YUBwsaSonDzsKghEcyFx6/U1y4L8mW
	ban0xVOBCUoKlTcce2IG29NbgRhaRRyUmGpin5juhoFOuFVbSjYptMM6Lipu2rIY
	x5OLA4j+ps3itXz63ERxFFoxJZalA6TWi5DHG7zYXp00dbdntiP9eSP98L2Lqsgz
	T8er4KWq2XcUdn4WT4ly+2ZcbpmBnIVfY/vW/u3tRKBEgGR8y7qBJdvFBxkmty3p
	5cONehSYKPf7sIcF2ig1VeJKktqd0D6TQnYoRGkeT4V4A/5AaB7O8yZijBaJbiud
	jH4YOEq9HhHvRwirPNmZ06dcM0Z33AWvGoGa1MJ3WPWvKKZA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4acgeu102h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:42:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297f8a2ba9eso15890065ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 23:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762933336; x=1763538136; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SRS46F7+myfHHV7nZlBsNhDj7nA6bojeVEV1V5g3wDE=;
        b=bEwNj5dUW2C0cGf1qM795quWS6aigjAGCEFw2t76ALB3sSYofBRM6auJtB6jOpa8Sl
         KHt+2pmTqlBiUZ9/NHxu3Aufe0SXYSeuXNd44jHKuT+BUvkTc0b/0bAEhFy3GL2luLU5
         HB5mpY9qoSeQEMKr0TASGQCqn9UePvOeXoWcyfkFwMeFWcdW0PkF6VQmqpnuDcjH14dW
         7gwpsjdsyFjVUh2B/wgYcb+xp2ktHZqdCN5fRPvhVIOTdXiaxqlYqRM4WcdnLkf244Oo
         GWpCYyTGU0gQlAcnveRaIgqv/UiSB9dWjWxntHZcTWENah/7MwACRU3RCpEbh482xrsA
         +FAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933336; x=1763538136;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRS46F7+myfHHV7nZlBsNhDj7nA6bojeVEV1V5g3wDE=;
        b=jkiHOoNEscG5gGH3MmMurjwZFAAJHH/RAZwECmsBsisuwBN9u0hsqBg9ZovAjtllUJ
         s2QOAeAB2t9n/8WCVRo1px8Sdl2NUeHmFhH/Ol7643yJQVhNvuzMxMj0lSP/vtGb6cEx
         7K8c/4FIpaSDYKOoikKN38jEBkWtABO7M5D1smSLjLxY7u1btm7dRN4eu4fvPeqEyY2H
         qqX+sIC+kuPBT/cpHfYB19MQCzJA7u5iCUmklhX/2VWva1IDzGkwoDUK8BbHF2t9eHXp
         z2G1m1xap9bCYQ9TcC6NVB1Lh3MaBdaxZbEiMTTAz9Owp0TwrhT3hp5oj3Mg6I68WXJX
         bQ2g==
X-Forwarded-Encrypted: i=1; AJvYcCVJHpltI+2NU4uEWFyX2DuDsaTd0SlPXcOcRgnMWAwcpIIGVbFYw6DaZYJRXjb8cvnlGJVSajjIKHUiu5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPrxENqTCTUWjUC+HOPZ2nqd6HFS1BKQ4rI6WjPdQDy11MpzW
	Gdld2wW+/cNx/gn/xjthWNH8mmv9UTsRCngECc5N1HBFP/IuaclZLECdSDwFKIDwrpBK7WRNCWN
	pZ8fkunkkFVNhhsP0fnwgEypl2SaUKMmB/kDwNYRD4JQiWWf4phkj1Hy2t2zJxDxuywWavo8AEM
	E=
X-Gm-Gg: ASbGncse5iDOQmwquL3MAt9nJ3uA4KAH/TGMHES77SqvgBqg1LpmOcQKJ3zw6TFECpc
	lzS/elaERrCSpFzzv2Fqy5BHtYBYzMAHCmsBS/lIxFuDT/6ddO5HgS48xIMjOz6mQys7zMnVfS5
	MXoXdZMYaZ6IKDjBBlAiT66yn27ccsvbk5yF5e/00yozvQ50kOdQ2UAY8/lkYm0mCT7t5CA/I6V
	Jjclnx2nHTtJnI0QmSOdkUx/ZGWx2vsAAomrTb3ISdMWdKr5c8VQX5ljb1NYSEPiJ1Q9Qy/f01r
	2sfnlPYmwxjQRcqiwRIPWO/GDOnxO2xvw/15trhJ54k+bD2Pc/JkSje4jwVwGcDt0soHT6sgXxt
	H1YGZAvx4n5SmYGc7yKoVk3CWK8yoWkI=
X-Received: by 2002:a17:902:d4c3:b0:28e:756c:707e with SMTP id d9443c01a7336-2984eda94d4mr26638935ad.33.1762933335628;
        Tue, 11 Nov 2025 23:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY/P0lC5DPYonYSA0luXIUsZtxf8uIzeBz3ZJrJSJzy3UVuUdgdDSnbIliXj9jNA4GRFaMOw==
X-Received: by 2002:a17:902:d4c3:b0:28e:756c:707e with SMTP id d9443c01a7336-2984eda94d4mr26638535ad.33.1762933335083;
        Tue, 11 Nov 2025 23:42:15 -0800 (PST)
Received: from hu-afaisal-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf097esm20457705ad.32.2025.11.11.23.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:42:14 -0800 (PST)
From: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
Date: Wed, 12 Nov 2025 13:12:09 +0530
Subject: [PATCH v3] arm64: dts: qcom: hamoa-iot-evk: Enable TPM (ST33) on
 SPI11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v3-1-39b19eb55cc3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFA6FGkC/6XOwW7CMAwG4FdBOc8oTijNdtp7TBzc1qURpClxF
 jGhvvsCpx12goul35L/zzclnDyL+tjcVOLixce5Bvu2Uf1E85HBDzUro02DqFugFPY7GLLApY8
 BJgqRwMcMXE7AM3VnBsnWQl4CxBlk8YjQO9vYoR3ZGVa1e0k8+uvD/TrUPHnJMf083ih4374qF
 gQE15GzXePGntrPKLK9fNO5loRtHeoOF/MHq2dPYgY0oEZyGt/bXbf/B1vX9ReW+/bGbgEAAA=
 =
X-Change-ID: 20251107-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-c8353d7fe82e
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762933331; l=1821;
 i=khalid.ansari@oss.qualcomm.com; s=20251105; h=from:subject:message-id;
 bh=qnRVyznIp2/9hXbw7y6c4CxmpQo/GrGH0lc7ReCMlUU=;
 b=hQK4ahqXPHRqTxFOZI2jgILKMQy08qbldZr4ZchvuRI0nuFSBaW1PhU3Aih2AeuXv0MNXOWFx
 il1jePjFzDvAZKUWV4TKSyyNUUZ0dwQr80Hn1xsoThSl07cIs5YxEfR
X-Developer-Key: i=khalid.ansari@oss.qualcomm.com; a=ed25519;
 pk=eBXrIUgTWV0cgG+GsNeZPPgvj1Tm6g9L2sfcoxMGrKo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA2MCBTYWx0ZWRfX1JMVy5LsG+/b
 IzzdRYibs7XTCGb2hIm4gIKtugk8LVwdIswmUDueWb5OY1pMO50MzI+73P9+UmSZCb4CnoHTR0f
 noJfyJjCTTN3K3Y2sIbIlktIXnGxv+ozky5Lut8ajf6QAMJpZYxwYH3Jsc2wYk1frfzDLGeIzuq
 FRbRkmoBS/IVoa6lOO3m4lX5tu/LsmyVmDiFhd8zeZSQUxesRqryEDD5El1fo7tcN2r7g8PzHzJ
 Mll/puBJkAQzkRjJKYS7zCoxgzbw/P6y8Eev5tgRG0T/kYqF1v6Ud5kvR2nMflhtRoRfvJJ/BwM
 UKl5/F5cYkueGWEww7TrJW/L3D1D5ghTzkuhSIRGs4pTAqNqVdIucUjXN+zLPDrwMFlZKQ/9k3N
 UzLZygTcwYLsi57ibzKRyu3ayTD+FQ==
X-Proofpoint-ORIG-GUID: ItEGDDzS1fkxuju1gpNzOy_qdujFTWxo
X-Proofpoint-GUID: ItEGDDzS1fkxuju1gpNzOy_qdujFTWxo
X-Authority-Analysis: v=2.4 cv=SvudKfO0 c=1 sm=1 tr=0 ts=69143a58 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=0o05X4pXTjTZH81ee54A:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_02,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120060

Enable ST33HTPM TPM over SPI11 on the Hamoa IoT EVK by adding the
required SPI and TPM nodes.

Signed-off-by: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
---
Testing:
- TPM detected via tpm_tis_spi
- Verified functionality using tpm2-tools (e.g. tpm2_getrandom, tpm2_rsadecrypt)

Depends on:
- <20251106102448.3585332-1-xueyao.an@oss.qualcomm.com>
  Link: https://lore.kernel.org/linux-arm-msm/20251106102448.3585332-1-xueyao.an@oss.qualcomm.com/
---
Changes in v3:
- Squashed patches touching the same file into one.
- Link to v2: https://lore.kernel.org/r/20251111-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v2-0-101a801974b6@oss.qualcomm.com

Changes in v2:
- Use "tcg,tpm_tis-spi" compatible to satisfy dtbs_check (was vendor-only).
- Add dependency change in cover letter.
- Link to v1: https://lore.kernel.org/r/20251107-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v1-1-8ba83b58fca7@oss.qualcomm.com
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 36dd6599402b..aecaebebcef5 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -917,6 +917,16 @@ &smb2360_2_eusb2_repeater {
 	vdd3-supply = <&vreg_l8b_3p0>;
 };
 
+&spi11 {
+	status = "okay";
+
+	tpm@0 {
+		compatible = "st,st33htpm-spi", "tcg,tpm_tis-spi";
+		reg = <0>;
+		spi-max-frequency = <20000000>;
+	};
+};
+
 &swr0 {
 	status = "okay";
 

---
base-commit: 9c0826a5d9aa4d52206dd89976858457a2a8a7ed
change-id: 20251107-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-c8353d7fe82e

Best regards,
-- 
Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>


