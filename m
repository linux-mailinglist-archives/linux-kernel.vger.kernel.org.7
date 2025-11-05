Return-Path: <linux-kernel+bounces-887013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0305FC3729A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2D2660B2D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8B7334C3F;
	Wed,  5 Nov 2025 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W4AnqI+8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xt3Aumls"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7712E541F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362715; cv=none; b=H6tIQUiYoBPtPZ7V0fNvYtR7FcmnJ9o5VWjyZ2G2JJGq/5GeplFfqgOebaslDzXDZl87uGkf/CNc+KUdyRKDnDR+6QUjTcRPcIUCU8tDJ7tCYwEX+2g8xnPCmdBvEJIZ1+yd6mpS/uW6daX74WDMGVhRYdcxYaiISL7QzZwwK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362715; c=relaxed/simple;
	bh=lMX4kCPNqOTeLDOBVzvhpufTCfXT63k6HW4Tn9TNexM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dRz+67vdkceX/qyPOBmbBmDh42epMYlJhnhkk5WkN0m7zPK5O+uOj65VgK+AokvEbOHL9D+ku9opTOVY31YdHkxaKMapIaqcJMHqoJlp9jmy1OZVPyTsq6GsmPbwB4133qBvAHz0WksBOCPQR9JeqGHpiZPqrJ+EmB03ESzhLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W4AnqI+8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xt3Aumls; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A59AEE8357437
	for <linux-kernel@vger.kernel.org>; Wed, 5 Nov 2025 17:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kfzOcZZirtT8HZ7OD4E7+z3+wIvlIJKhbk0Cjfs6V6g=; b=W4AnqI+8Pt/PhvvU
	r7ioCxxpegd0b9tcPcRGGFnbQ7nrui3kzG9+d+8EYiAIjh5u6+5CNb4f+ILd6SO2
	v+i0BOYXvYpvtE95m1C8tFh83JIkrjBm4ld0Tc+GvX+UOpWurfPV2kBTTzuOpEIM
	UiKn68JaKPUh/iMddIm68jnURAWlymBHQ05lgAqrR/ewmZvCsoN7916sHRYieXNW
	rMiCjj9Xs3CkwDXvm7RgJyeTm/3SvGTejBskYb0Wo+//YpeAE4AVYAhZEpAQoN9+
	ARgNEwYrha8SD/qEoeARseVxaOwYI90v+3rel3ezpUbdXnJgXicDYzAkRYdNvxK7
	vSrDgg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a83q5hc1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 17:11:53 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2955f0b8895so14060795ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762362713; x=1762967513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfzOcZZirtT8HZ7OD4E7+z3+wIvlIJKhbk0Cjfs6V6g=;
        b=Xt3AumlsRBBQYCB6qwSGqYZzX+CioRFXVPeqo7PxXS7BoYMyvUfIjCohS68esAyShB
         V3C8ezuYJPvfLYSpSO6M0LOc24jw8tusF157z2zGFMdrTDIYdciF80N3BPzgXQpqO0eN
         Aio4raQrdCcW8XGS2+KLzaVsTbChIT9lSMCYmbBGjo49G9Oy6JCjL+l4INdSEc+vms74
         jeoU8++d3aiXIhn6PfO49SJMAGZEPj/YJvUWd46moFrzIhHWeuLIQ2nLvkRn7n4baZxw
         X8EWgwCnZPkWAA87ImRla/nH6JtgGXrxqGpn8yxsD0pAJ4ivZj4uovlt3aY9KHiDZVGH
         xB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362713; x=1762967513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfzOcZZirtT8HZ7OD4E7+z3+wIvlIJKhbk0Cjfs6V6g=;
        b=xPRwEpZmPK2/FLBmWiOif9JrulMkh6MZDPtHLNUuYN2RU6RMJ1mjH3Hyo2TlOyczS9
         igvePbZRFTuP7uMKYvhmldYvzdeUPpY/MSk/CSMvAyaB7RCBOWHvMLwr+9w28WUPLtju
         OcEZf0Ooh22MWJtutljj4UkJXSStWcDEX2GntzrjyEW2z08s8nhREvlytBBtRhtjXwEo
         02QVqBilT7kLzd2SfMOfvyX9TIQQhODjFgm0hkqAQaDzDOajFjjohHolPYjm1lIjj9yY
         h8vRNASsNn9Wr7YIeGdsdQ6soVFmbnz5Os5b6jbWee3d512OS2PohViAYZeC6B8V6B60
         32Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWz8WLURThqCuAXjN7ObRFlqGZN93SO6X3niVnLee3gykJgzGvS/41OSV4AInHJ6f1awfI5OMyskm4EElo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynop7u1o+U7fv1BZjPXaPEz1krittR567n7HB3d523Ef4bAFja
	H6fPZAE3XLijGtOBHmlVzbrOAnDhaP+FgNUFXfmXNO2oQ4oqHxS2xlkAfVxjg7Sqs+1uRyM+oWP
	33i1DKjJyWsyzd2Dxqjyq1cJ7W1/evmLJ4oJVV0mqZlQURpgdYM6ODJdVVbDSjiA5tyw=
X-Gm-Gg: ASbGnct1FBygwYQvjYNvKDU7rEudTDTv0Iw+E2cdaBPX0/uaI3aZwbO2hc0m+uioS3c
	kp58iMPE9pf+O8qli4ACu0WVXGJJXhMF/g4Z3660GGLFZbEfx4szdSnNCS3+/vVVdjdxnBD86XC
	uTbilEtFtUCjKyHGwa03pbS8ZaCLr3cbi3Q9Rl49awc2lHK9tbp8d34LIVW7iO+ueh1i8zVjPaJ
	G99x7qcuxB+G2h3flka1MbUfDCsClELWZWd8IANqVovvTTQP9jGj6CfEtrTiwDoukUnLlHE1MMs
	6Azj6QXQ2E8HP+om+ZzcUzgfJ4RYz6PYOTXQSd/Dc9AAs1UfAM0g2F3H1y0DEc6l3sh9Rmalkc0
	xCufXtX3435e+2OqEkvkRcEs=
X-Received: by 2002:a17:903:41d2:b0:295:4d97:84f9 with SMTP id d9443c01a7336-2965161d7a8mr1503835ad.26.1762362712601;
        Wed, 05 Nov 2025 09:11:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvIW1HFqhmvIwAwGv2rLknSE++L/0Kik510kANbZIL8U4gqvYBCfAwpJ0+R3u6sMecZDEktw==
X-Received: by 2002:a17:903:41d2:b0:295:4d97:84f9 with SMTP id d9443c01a7336-2965161d7a8mr1503005ad.26.1762362711797;
        Wed, 05 Nov 2025 09:11:51 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e3c5sm813955ad.43.2025.11.05.09.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:11:51 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 22:41:32 +0530
Subject: [PATCH v8 1/4] arm64: dts: qcom: lemans: Add gpu and gmu nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-a663-gpu-support-v8-1-62a7aaa551e3@oss.qualcomm.com>
References: <20251105-a663-gpu-support-v8-0-62a7aaa551e3@oss.qualcomm.com>
In-Reply-To: <20251105-a663-gpu-support-v8-0-62a7aaa551e3@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Connor Abbott <cwabbott0@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: Gaurav Kohli <quic_gkohli@quicinc.com>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762362697; l=4605;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=q5yoK0aGVoBG4sHWRtdr6dM5sWcCy8r4teR6JiKmHRs=;
 b=JOGa9ksmoO1BNpsfF4x1iwSIUYHT2rHUFw1iLeJD7sjFmVw7OumZriUCHeixNa3xDxC6EyzDw
 I0fUBTcNTT7Dg9bqiT5cqYyAd9BzgcCKnhbY7XGhU4u4TvLmA8d5jEd
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: OQAo1fW2pB8XvTl7GxOhqjcNwoOXYslQ
X-Proofpoint-GUID: OQAo1fW2pB8XvTl7GxOhqjcNwoOXYslQ
X-Authority-Analysis: v=2.4 cv=YZKwJgRf c=1 sm=1 tr=0 ts=690b8559 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=D_IGQ_qLm8RrHFHUsBgA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfX7iESEQC++Opp
 LWl+FJO2nt/F+D6Ze8sLqVeqjqot/SJ8/9q5dh/hVILwdx/erXi+6nNFJ/T9mnhbznRmgPg6hDd
 yat+XPR73l0SlJMM9LyGa451abvDmgJ5BVJOdSdru8INwH2vLL0EFKMwKn8pw9kK10X+3VlRDdd
 balJdlFsN/UHcR7TvjWXXvGaasCx6O7S48j4uih2p7Un59QJyfSDOHJivKciQe8l+qCGTATjUTW
 t1Iiw6zUx8/cOHasCz5mqm16Mz5SpK87N7Rw1HcWDuT9nf4QpXIEchaC691hRkjbCb6JnrEfnyl
 9wHaSdKMs6G+ob7a2Ixy8roBUDH6bb/j1Y0ERhkOA/fx9OTQVx9hpzMcnfHD0/Ri8K74r/1OHeC
 t5poB5uBDmMV+XoBZxciT+Ub8pM/8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511050134

From: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>

Add gpu and gmu nodes for Lemans chipset. Also, add the speedbin
qfprom node and wire it up with GPU node.

Signed-off-by: Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans.dtsi | 119 +++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 0b154d57ba24e69a9d900f06bbb22baa2781cc3f..883f9e0ab45c98b9e128f3fa141d625431d89831 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -1098,6 +1098,18 @@ ipcc: mailbox@408000 {
 			#mbox-cells = <2>;
 		};
 
+		qfprom: efuse@784000 {
+			compatible = "qcom,sa8775p-qfprom", "qcom,qfprom";
+			reg = <0x0 0x00784000 0x0 0x3000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gpu_speed_bin: gpu_speed_bin@240c {
+				reg = <0x240c 0x1>;
+				bits = <0 8>;
+			};
+		};
+
 		gpi_dma2: dma-controller@800000  {
 			compatible = "qcom,sa8775p-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0x0 0x00800000 0x0 0x60000>;
@@ -4135,6 +4147,113 @@ tcsr: syscon@1fc0000 {
 			reg = <0x0 0x1fc0000 0x0 0x30000>;
 		};
 
+		gpu: gpu@3d00000 {
+			compatible = "qcom,adreno-663.0", "qcom,adreno";
+			reg = <0x0 0x03d00000 0x0 0x40000>,
+			      <0x0 0x03d9e000 0x0 0x1000>,
+			      <0x0 0x03d61000 0x0 0x800>;
+			reg-names = "kgsl_3d0_reg_memory",
+				    "cx_mem",
+				    "cx_dbgc";
+			interrupts = <GIC_SPI 300 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&adreno_smmu 0 0xc00>,
+				 <&adreno_smmu 1 0xc00>;
+			operating-points-v2 = <&gpu_opp_table>;
+			qcom,gmu = <&gmu>;
+			interconnects = <&gem_noc MASTER_GFX3D QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "gfx-mem";
+			#cooling-cells = <2>;
+
+			nvmem-cells = <&gpu_speed_bin>;
+			nvmem-cell-names = "speed_bin";
+
+			status = "disabled";
+
+			gpu_zap_shader: zap-shader {
+				memory-region = <&pil_gpu_mem>;
+			};
+
+			gpu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-405000000 {
+					opp-hz = /bits/ 64 <405000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <5285156>;
+					opp-supported-hw = <0x3>;
+				};
+
+				opp-530000000 {
+					opp-hz = /bits/ 64 <530000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS_L1>;
+					opp-peak-kBps = <12484375>;
+					opp-supported-hw = <0x2>;
+				};
+
+				opp-676000000 {
+					opp-hz = /bits/ 64 <676000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_NOM>;
+					opp-peak-kBps = <8171875>;
+					opp-supported-hw = <0x1>;
+				};
+
+				opp-778000000 {
+					opp-hz = /bits/ 64 <778000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO>;
+					opp-peak-kBps = <10687500>;
+					opp-supported-hw = <0x1>;
+				};
+
+				opp-800000000 {
+					opp-hz = /bits/ 64 <800000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
+					opp-peak-kBps = <12484375>;
+					opp-supported-hw = <0x1>;
+				};
+			};
+		};
+
+		gmu: gmu@3d6a000 {
+			compatible = "qcom,adreno-gmu-663.0", "qcom,adreno-gmu";
+			reg = <0x0 0x03d6a000 0x0 0x34000>,
+			      <0x0 0x03de0000 0x0 0x10000>,
+			      <0x0 0x0b290000 0x0 0x10000>;
+			reg-names = "gmu", "rscc", "gmu_pdc";
+			interrupts = <GIC_SPI 304 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hfi", "gmu";
+			clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
+				 <&gpucc GPU_CC_CXO_CLK>,
+				 <&gcc GCC_DDRSS_GPU_AXI_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>,
+				 <&gpucc GPU_CC_HUB_CX_INT_CLK>,
+				 <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
+			clock-names = "gmu",
+				      "cxo",
+				      "axi",
+				      "memnoc",
+				      "ahb",
+				      "hub",
+				      "smmu_vote";
+			power-domains = <&gpucc GPU_CC_CX_GDSC>,
+					<&gpucc GPU_CC_GX_GDSC>;
+			power-domain-names = "cx",
+					     "gx";
+			iommus = <&adreno_smmu 5 0xc00>;
+			operating-points-v2 = <&gmu_opp_table>;
+
+			gmu_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-500000000 {
+					opp-hz = /bits/ 64 <500000000>;
+					opp-level = <RPMH_REGULATOR_LEVEL_SVS>;
+				};
+			};
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,sa8775p-gpucc";
 			reg = <0x0 0x03d90000 0x0 0xa000>;

-- 
2.51.0


