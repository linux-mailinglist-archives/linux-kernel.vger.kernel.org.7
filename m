Return-Path: <linux-kernel+bounces-864515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F394ABFAF28
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C6B19A153C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401333101D3;
	Wed, 22 Oct 2025 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jZNZOoHj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A934C30EF6A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122475; cv=none; b=J6307aiwB64h4rFPhVM7rt1LBcCty3TFldoqSLavs/U4pz/JB2uuUlkWPEqhCedrSu43ES2QVDfQZ9ztQwPbC3LbnZbAS0LakUhEbLWbMCZy8rE/zifhT2ZM9qsdz4jRceZlIQw65LTIZ+WPRXLMJprgUfxI6tdHhcDzOQOFliw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122475; c=relaxed/simple;
	bh=9BgvtBVuYVEHbYuUn9h0z13dBPpwUOv1H4ZyhEvT1a4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qL3ihHW04zupSDvK7+Z8DvXpN5m6kGHZasMzYk0H6+bZd4Th8njyMQrQ8G5SZXOjqhIfwmOpZ7/AZkfSWa3Y09XeJ7cYbimE0Mh0sKINEBlsTnU/9Pam6TAU2Cv64qnW9KIbLyJECUF8LfAr22CRWOZOIAMNZXx8TU3HTq0EyZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jZNZOoHj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M3SYrS027492
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:41:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rcpnIe2kQH6
	oAlRh1j5LimFvmkLzzm7Un7fgpZ7DvBk=; b=jZNZOoHj498Zlp0ZrBGag+CChZY
	LbAVnLtR890JgX2sNrXyxnd7npCQ8xYDpWE7iBHCOkGdeUx5QEzVdHp4w9UHx28d
	GcwN33i7dJY8UnkFez55r4SSicapJbc4AKNkWyMVACaS7jUsYGV3IMRvb1KIzgXV
	UDrpb/heqlbbeI0T1rJAvO3s1c3VPwZZRzYYQtmSIHI/mIaKnO0LX2XTu4kvOEN3
	TtzRVet75XkK7irDyX/ZCxZ/Outhl0ZIhk4cLiSleDYGsXcPX/Eu8AutLHItldF7
	sPgJnHa9Vir5OtjB0Z6eqFbKUOqdffGbbvk7IV0cGRGxEJYTOGMqCqoGesA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j3wft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:41:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33dadf7c5c0so908156a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122470; x=1761727270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcpnIe2kQH6oAlRh1j5LimFvmkLzzm7Un7fgpZ7DvBk=;
        b=OILBH0MSI+k2eLN/v5QOnp+UJd1yVdHbxUp67IfFBHpMjnagh/ecDxOb9YLbd9+VSe
         2BftzzMRfU75/GB0/Pr8t9J7GE+eTxxyuu8q2UqZrks24P0+Vgnz4EL7UlHYoPNnmTLQ
         Lnf0VCKMAxm1QXns4ZdymwXvdTjDJJQRyOmQjC0Mjq/MbqZDYik3AmJQX9Jd7M08mA4b
         OCwzwF3sNeSEC263/QgJvFpludPdLUiP1KZJd7VREbk5vn/IfjpIE0DbqWTFxT+N1mjb
         GbIrjFihdjGfERN2V3GM22SvdY47h+iQFDK/JRiqM9DD2ma+VzFab9KJmkXqfR16XK9R
         HJUg==
X-Forwarded-Encrypted: i=1; AJvYcCXgYrB3iWr/14PmsyfMe6EeMXsuYiaBAxfDDt/5EeT7YMC9FKGZbCMHRVY8+wnCD51LQboPwnPKHTll5UY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa5dmXjzdNa2f/iOPdnyuanFrHNU7a9YsQCFQtzbapHhSdp9Wc
	ZbjByJEpRJPEfqtlvR9pWnYCix2khXPtVXl92yVaN+RsqRf0tvW0YMH8Om9xqqDE0APgodATd6c
	eH0agrkTLavHH0sU+2knlgHLhXRj4jJDDBkq1VjsM1eozOxPs7D9g91N9T7HaZhOy4Gc=
X-Gm-Gg: ASbGncvcCwdjnCi1E5eR0S9U0rKzLhmbHbQ98/9rWlSLsmEyML7W8powJdeK/j5kyVG
	Z9o1OMsPp1o54ahvVybbGmC6myKUCAS1r8WL46c/xz+dXYflMyYZDWKrGLY/pDoeQDV4q0y9UQ+
	s0wwkkH50bQ5IQdOUWs05MOj5hKJiJ9MFkgirzgMsZjzWl4RX/lB2RXKHoQCXOYnHZY9OZQQLTS
	PC4QYPaumPN3cbFqC/uwHitgssmXu3zUeSS6vA2aBkmR7WCRt8lxV3jI/uzIaowVb/RNQBL5m+K
	6FiE+LWkWnsdo+qqSCroNYMoYebiQ21AsU2nC0rkE+hlQ80kxKLRvP92W1XhPWYTejuJrMPK+C3
	FdE7TOMvi4mgCQAhGxpaIOZUEx6j/JJpplrqR
X-Received: by 2002:a17:90b:1f88:b0:32e:11cc:d17a with SMTP id 98e67ed59e1d1-33e905ddd23mr885289a91.4.1761122470315;
        Wed, 22 Oct 2025 01:41:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYgk7dPlHO1B8hexkjytvuREV5Mqakcse5L2rTllD23cI/RCXl9woZIjksBiokxdnCxS/O0w==
X-Received: by 2002:a17:90b:1f88:b0:32e:11cc:d17a with SMTP id 98e67ed59e1d1-33e905ddd23mr885264a91.4.1761122469843;
        Wed, 22 Oct 2025 01:41:09 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a25e9be9f3sm3740317b3a.71.2025.10.22.01.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:41:09 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v8 2/3] arm64: dts: qcom: sm8750: Add USB support for SM8750 MTP platform
Date: Wed, 22 Oct 2025 14:10:51 +0530
Message-Id: <20251022084052.218043-3-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022084052.218043-1-krishna.kurapati@oss.qualcomm.com>
References: <20251022084052.218043-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX8IYS08zFhzbl
 JounkB/8vbJNeN5KRMSkEfBzxMD8wOwUJJ053PoKgVjPVf6Y2insNPJ/V2+CnJ7j+TJF8+5/ytO
 hnF97f8JVuLbZrvDzNDjElhy7HHccbAQFEPkCmgMGLHAaROjofQDTWA9wUL5Q5xv8zaMfZGfiJe
 7QsTF/KgmF3TqU/1SgtrCrv1ZznFxi9TU7mPnCyy+P6qbYi7HibOCHYO1Wro0Bzdabr7J0MYECB
 Wi1y00bqcAmf5wii5IgKYrh4QUusmG4WEcEA3BzEwmPMq72VCQ1HvC7xI99ZVcKhIGICoqW/omM
 K8ptS1OJRlXFtMTrCT/SOhysuvVKaXQpwN97HY0j/TJWhG8q5pv1yO0qXQFnF6AOhlViGmXlmUk
 XmDPM/iOLDr4YH7AHSwyKp03l2zLZg==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f898a7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=Tsvuh88POXG944tnl6EA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 3xsLeZMzFxM8M4idfjNQP7PFGZqU6CgA
X-Proofpoint-ORIG-GUID: 3xsLeZMzFxM8M4idfjNQP7PFGZqU6CgA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>

Enable USB support on SM8750 MTP variants.  The current definition will
start the USB controller in peripheral mode by default until
dependencies are added, such as USB role detection.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Suggested-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
[Konrad: Suggestion to flatten DT]
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 3bbb53b7c71f..1b526d96fba8 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -1200,3 +1200,25 @@ &ufs_mem_hc {
 
 	status = "okay";
 };
+
+&usb_1 {
+	dr_mode = "peripheral";
+
+	status = "okay";
+};
+
+&usb_1_hsphy {
+	vdd-supply = <&vreg_l2d_0p88>;
+	vdda12-supply = <&vreg_l3g_1p2>;
+
+	phys = <&pmih0108_eusb2_repeater>;
+
+	status = "okay";
+};
+
+&usb_dp_qmpphy {
+	vdda-phy-supply = <&vreg_l3g_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p88>;
+
+	status = "okay";
+};
-- 
2.34.1


