Return-Path: <linux-kernel+bounces-819092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BFAB59B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76433528304
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABFF35CEB7;
	Tue, 16 Sep 2025 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MnTqs0m0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE929337684
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034820; cv=none; b=DaRF97eYC3DJzqLIETfLeXI+9wgcuXF2p0SCa3+f6YmpKjXHZTvW3TITSSZskMGa+vI8oMKN3PFHGr98eH70vzKsYrTkTYdAfDmmfFWmF9U6AOONl5ovNVlYm38JfARyOaK40ZWSQr4k7amiu5ZV/D9NAuHCE6ucQQkQSyBuV9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034820; c=relaxed/simple;
	bh=VITe518dJvceZYXI5Zs5G2EbxFecKGbskjkdUpE+OBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OubkJPGO3NDZ6od611JP3dFOiZRDU+/7uBaZMlEm+Y5N06j29pRdELdJ7hWIqBC86U3Ik+h1fsiDoExG80FwP5Y+/bS228FJ5y/sKmJqk30fhxaF7yVWGw3/7mIXmTPlTk+ninvuKsXYswHplyh+ZVLXk+HlU4KyJKDlndqNsEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MnTqs0m0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GA7MAe010827
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	B8o0rUX3vuCCRx+XIt3VRsCZEuZbtOTNGliDlDNmyC8=; b=MnTqs0m0BQFkF5uo
	i9LaohX20Vl8eMhtydS4Y8FPYJhLqReF1+E8l1lYLYf+tCGVg0KZrXDWlXs6sDsR
	1hMDou8T0H0I1KAnrn4XJs5sgBOzFqImfV3R7U0Al2Ca+z7UaoxpdXTti4A6ZAbB
	s6GlxwOZnzmrr0kyfE8dKIb50859LFiC1cUTczjLjt/W7tFun+TgZdbeNb+nSZpG
	AZbtBCXjN4IxCNgqZk1D4Igq335tJ9HVTwyWW2EQfSqOECPhFr2WPlfi453KRhMt
	JCXKOpg3A+Y9ZsCeN3Zuh5DnMOYdtB3HglZPRwkXOHZ+eC0PpTS9WOSkB0zV58PO
	/uIjQg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4951sns2ej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:00:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b522037281bso3892211a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034816; x=1758639616;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8o0rUX3vuCCRx+XIt3VRsCZEuZbtOTNGliDlDNmyC8=;
        b=VMSGXky98YqPeqm7S80zcmhtR6s40R/3aSXC2ciuwKKLKZ7oOiAceLYIGEUKPRCmW/
         NQT0mu1XlikHILNl/xk1dBpC9dqoT+Fei+yDQw0EqyF3MlozcAwQ+3mc65cSZwpQ3aBF
         50neAwUtiq3AZWwp0uOjo2l7C6Gtz0I5IEmq3vkKPjgmmyBjvHz+xvEO4Opfd6tXT/gX
         k/BRRMpStikurnuysUaAvJ3I7h50JEpeHlq1DqFMFJW8PDHba8+8zqvZ8NiPJzCqcHsq
         cdI1baPhvtE5Sk4rod1jjIonUhpXJ+WlphgPjuY/joPGhOPK4bt9h5l/th+osYh+R/mI
         OWFw==
X-Forwarded-Encrypted: i=1; AJvYcCWUm+vUPrMpiUmm6XW6ZA5F8Ieyq06v1F+lEraRaQMwRCJkIcAyOkVUHgss1A31WPsLPTn3ZI4LSofS9yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuYw/9j8x7Q+Hx2sfpCaDTtDyaeNmAo/yZoh6ezdjD8aygmm0
	Iv/NI5iGzNugoEWVmpyWoY1LKqArf7ojhwPQBgagJkgtqIDsgApJoDcQ8jkhjhkXw9g3IK1FKUx
	I84PjlGMYYYSu92aIfVfW2ILo0/EjQ1KA4BNfRzWrBDMpA0JZY06wsvCC2DAwg7j5Crs=
X-Gm-Gg: ASbGncsHF9UGFe0eMzfPKr31PaYne+MGdceghzNqXd/xh3FNKaIKP/NbhzR4qS45fwP
	YZfZz5rLteRmvCCil34IQSbqCLXhqXXMp8WBT0QNFIAKE4T25RGYrXO+917Pz1+J/tRs6yTM4h4
	G5Fc0HeBX5rSh3Bc6Ymhx3hGE8I+uTqE+Js17m/X+fNHYBiwcygjv7vYgOYiySxx1VYGUy6a5l4
	TncBgsDEYIKV5tK9rO1o3Ex+YqxMpvtFrhcgMU+T1gmpkSYFanmt2/89wipwFQEIosw1aps5IFh
	H1GGO83niR7nYIYXkkjAkSkuh/HY8U66bEmPhxtXlnyiA5Uj3XO5ilx9tCsEKEk+Yhhi
X-Received: by 2002:a17:903:2f4e:b0:24a:f7a1:50c6 with SMTP id d9443c01a7336-25d26e474acmr191844205ad.52.1758034815501;
        Tue, 16 Sep 2025 08:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnw+Uwp2QJ+pgYTFNW0n9rgW10ooTfi2mixtIM9GmU1l5WTOC9wSvj9pEC52bbnXIrfCo21A==
X-Received: by 2002:a17:903:2f4e:b0:24a:f7a1:50c6 with SMTP id d9443c01a7336-25d26e474acmr191843395ad.52.1758034814786;
        Tue, 16 Sep 2025 08:00:14 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2651d2df15esm74232615ad.45.2025.09.16.08.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:00:14 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Tue, 16 Sep 2025 20:29:29 +0530
Subject: [PATCH v6 07/10] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-lemans-evk-bu-v6-7-62e6a9018df4@oss.qualcomm.com>
References: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
In-Reply-To: <20250916-lemans-evk-bu-v6-0-62e6a9018df4@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758034770; l=993;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=NIyml1MlGj+Kf1AvBGjrERl9vMVGWIsWbRk5tvoG0bI=;
 b=enpnufxvvX/x3jsXtCtPfnox8ZuwvUDUthNXJbnpsvbid5A8yO0r4f+UEK3C5tW9XdoCSjANo
 IUqf2MYDo9EA53ORwebFmbPqjriF2gSNjMB2H9CZVDHO6HMHFb8vQ7n
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=JO87s9Kb c=1 sm=1 tr=0 ts=68c97b80 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=5Avgj7R_EIYQh5X_CpQA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: EufiYLBo6r5UMaVv4FnjcCGpcgGunPZg
X-Proofpoint-GUID: EufiYLBo6r5UMaVv4FnjcCGpcgGunPZg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDA0MCBTYWx0ZWRfX0RypAtAz5ztc
 5edbpHJK4gRDvXKahrDAiFdDy/uvPgrZ9dJinV9GHi/Dfh4uRayqpGB+aFaCq8wNszRJSjd5yKy
 jhqzfCJNm0UAQ5XUKL+MqRJqYdyYGsgwMEWzROxweJWIgG3lAp64PSaKmrjbdevdnnhdPTjvJoh
 FPvd2GQpb8NVZAfZhjzy47EMFRtBKCl5sm27Rm2Dj5k1WQVjOTiEnmctPbbUVmizzySDGUtszgw
 kCHdlkexHVk+ipw7IMI435nrgv0IL3vX539J2bYB9Eb20U/2gRa2h5mQTUaNdrANVdR621ImVJC
 rqV3ZL35n8s80HqQZkvORI9PoJ32+yGPr3RvoTT8pedyEcOZzbmuBcQ1dr/YchwZkB/7PFipzjS
 OGz6Hc+K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130040

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Enable the Iris video codec accelerator on the Lemans EVK board
and reference the appropriate firmware required for its operation.
This allows hardware-accelerated video encoding and decoding using
the Iris codec engine.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index d92c089eff39..5e720074d48f 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -385,6 +385,12 @@ nvmem-layout {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/vpu/vpu30_p4_s6_16mb.mbn";
+
+	status = "okay";
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0


