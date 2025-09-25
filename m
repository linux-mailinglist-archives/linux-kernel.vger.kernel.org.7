Return-Path: <linux-kernel+bounces-831830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D905B9DA74
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F374167318
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7869C2E9EB1;
	Thu, 25 Sep 2025 06:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hHUpleMQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D292E9EB5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782005; cv=none; b=orYO3HL0qcEvvFzv7J++bXb51oj3vcJqjqnEnaXAz88oaE7RJ9ZG6bFUtJd1zRculOkHHT30oOtUELckCOvwTFXD4suOILvISBATrbjjhVEpt0yYT86AoNV6qmNet/jEzdF5aLa2Am3OvGLsLyQOSo+foigN2MeETZtNHdqFdYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782005; c=relaxed/simple;
	bh=n2E0mp+seSUA8aHrFHM2UWmk8Kv9jJZg9+NDfsxNcdw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HUsrufzoZZQ65k0ZPvXxlzURDtJmQhw+c5PqvsO92AP0RKh33pbft1H/LKbLyXqDXXpydrtziZU7BPhIKR1Y/zjRaufyXnQds6otW8WCgONlFHs2xL/t/UQh6EpTjqRJ7AktlICjOdIqFUuZ3nJI5ZBVR1NyhxaXBENMAxf8+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hHUpleMQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4a82M026654
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kqQZ9waO5d5dVcHhCFEwue
	14AdXjBmYspplJy7uLais=; b=hHUpleMQt8QOnd32ORQoL2H81ZBqrECzfMgZm5
	PFVdrzD+vqmwF3W0YWgVWUhz+FN2wVDLet3/4Kq4+mFxe7T6GJTcluSyNseKRwo3
	DCGt34RZHywWE+bFEU1terq95bSg+gMaKUMxfY/afAVTZWCXTGmHp+39X2HPfZpK
	UqqwuNibo9NyDwmqYaQjBYH1wFsymBQPOim86/KvyGmVAHVLVp2wmNpOkiXoLVjc
	j7rZkwiStmTOUgIegPX0p92kxigtJjXc5ZYQr/aSwB222eS4Dc7W5WC4PvvH7dQg
	Vwc4pHFRcLWn4/2V97U1n+7unEmX015H7dN/jrOJdmBEZnTA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup08su-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:33:21 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b55251a4309so496337a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782001; x=1759386801;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqQZ9waO5d5dVcHhCFEwue14AdXjBmYspplJy7uLais=;
        b=rQ9ssni7ExzVq97SVhY0mq0c/GNv9S/J46DEOtpAxjSEIyjzOpJfL6+sIHz2OK4c3x
         mv0s+fFm4Za7r5DGoflBrclj6FZ0UIIk+d/i755VbFnFfyx+e3II2Id5q+IEc8lCzCGK
         ZLPQRf6kuNaRG33ZhMYByAMnvU9p2m4Kl1glepE4PIEn3eIklvss9WK4OpokUNjt8zBX
         UfGqTWG4oCZLi+cl+bQiURmUs3EmbSHDDfhSO43+Qr8Bk5j8YxM0TC+5GFjsSEr5l3Le
         pQmDHgXmQbhP+YhK7cuLVx7hnDClVDrhLkuCFiSzMTDcOt62qo2UhVKAVl/f2XksXBGO
         tIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXge5gMPAWOsx/1iN0yAazsQxGwNxCYAnUx5BRFW7v6wK1NfMqjhQWZVL82FEDaTxCs/Z8CIsrbNmSQJgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC+3nUf4eC9tr2Y9W5X+FxDXZaNIbo7wfX/IhPDPaIKptmbyal
	Fmxjd6mm3tkrAGXrNiHn02yqdkdr3HMwaR5d2Tx853/bTuUKMB3iYCQNmYQdDZgSZRQAOVDBAjB
	GoOnmJUneGRoig78DKUPS/MWkxJrpzQr4lYVHdazXfj+WO3le0DDRNpxQbooMGIOyTrI=
X-Gm-Gg: ASbGncuAbd0064pdYUsiSllVPow/dakNuxUlJ271hiGNahMXFQosqcSgETvC6YfIVd0
	g7vF4kYfkIwnpPwn5jH/OeAspVw3UZDopAoee9dnPlrBLjzX0HPiQlKVWvEhEYOKLCSn1C0Cw3y
	p//8/TThXn/GGd7pU/yUFmhKPUMxXV/7PsHQrVcs4kUjQj397qrrPGR7FhCYDjUqbyhUCnnkhrc
	ffQKLEBI7JK1jeDifeb387KXVTPQc9AVQ5lMTprEelqRIU4xtq5LZcXCwvIQSlltv2kR1UoGDMk
	HJi/5b0VNXybGZ5tAhlUxrJi/dw4lHcY0/KlOA7LVhLgjcfmv+MGuGkKz64+ioLoIvCFBhUA9Xk
	G3PVgJHmt9ZIDjVknFVtHl60BLUPNqFWPFpfPCPdLfC+gwpJL0nhSU9y+173n
X-Received: by 2002:a17:903:fa4:b0:26e:146e:7692 with SMTP id d9443c01a7336-27ed49d0931mr29600115ad.17.1758782000926;
        Wed, 24 Sep 2025 23:33:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHykZrPZvPICgBYuffDzXRFVCNuxV04b5qgpTzqPc/Aytx2Xc0PD4jUf4NXvoUd76VAaxrYsA==
X-Received: by 2002:a17:903:fa4:b0:26e:146e:7692 with SMTP id d9443c01a7336-27ed49d0931mr29599645ad.17.1758782000430;
        Wed, 24 Sep 2025 23:33:20 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed671732asm13793515ad.49.2025.09.24.23.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 23:33:20 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Subject: [PATCH 00/24] arm64: dts: qcom: Introduce Glymur SoC dtsi and
 Glymur CRD dts
Date: Thu, 25 Sep 2025 12:02:08 +0530
Message-Id: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOjh1GgC/43N0QqCMBQG4FeRXTdxZ81WV71HhIztpAN1tulIx
 HdvCt0VdHPg/+H/zkICeouBXLKFeIw2WNenwA4Z0Y3qa6TWpEygAFGcgdPIq7qdu8lXth+9M5M
 e04QigEKuZSkVkDQePD7sa4dv95QbG0bn5/1PZFv7IcUvMjJaUHFkXEnB2EmXVxdC/pxUq13X5
 emQTY7wnwZJk8gE50pIA+aLtq7rG/qzJbIRAQAA
X-Change-ID: 20250923-v3_glymur_introduction-e22ae3c868a2
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Taniya Das <taniya.das@qualcomm.com>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d4e232 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=qC_FGOx9AAAA:8 a=9ajADY_X5n7qQr6QzggA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX01BEVW09d5EE
 d7wjgkAbMlZfKNWs/4p2q/FIfTiPqyemvdEeyhbBZxPMVNiZWKI2RoJe0vO9/ciNAYzVfPvKNCW
 tgs80wMDH7J+KlbMKYv1BsWxtK+BTvlST3ONrlqTqGag4GeZL2WozcVL1VQtzFI8K1x7xoQa/9v
 JLEj1VE+I1Hd3iEmGXCWqfWkne3Av7gwYcc2OcqGfv/0Fg/9iKSG50ENB1LBzXu4oi/BZFJ9Dan
 tzpyAEhgC90ryWHrV3Hs+e6WdMw+SDS3irPGVtnlbB2vRpaB42TXosA8ZXsC0WBEkfr9wQUQwLO
 ZbulGja+B+x3z6ZYdfm8tWVAZOUIqUYxmKck2lrYHOBuKny05TOHyN1MFzgPvsUKTDKzyeja8OZ
 sML+/p6x
X-Proofpoint-GUID: ArQ_mxTK0dQidC4VDzrMIkRTqzRY-puc
X-Proofpoint-ORIG-GUID: ArQ_mxTK0dQidC4VDzrMIkRTqzRY-puc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042

Introduce dt-bindings and initial device tree support for Glymur, 
Qualcomm's next-generation compute SoC and it's associated 
Compute Reference Device (CRD) platform.

https://www.qualcomm.com/products/mobile/snapdragon/laptops-and-tablets/snapdragon-x2-elite
https://www.qualcomm.com/news/releases/2025/09/new-snapdragon-x2-elite-extreme-and-snapdragon-x2-elite-are-the-

The base support enables booting to shell with rootfs on NVMe,
demonstrating functionality for PCIe and NVMe subsystems.
DCVS is also enabled, allowing dynamic frequency scaling for the CPUs.
TSENS (Thermal Sensors) enabled for monitoring SoC temperature and
thermal management. The platform is capable of booting kernel at EL2
with kvm-unit tests performed on it for sanity.

Features enabled in this patchset:
1. DCVS: CPU DCVS with scmi perf protocol
2. PCIe controller and PCIe PHY
3. NVMe storage support
4. Clocks and reset controllers - GCC, TCSRCC, DISPCC, RPMHCC
5. Interrupt controller
6. TLMM (Top-Level Mode Multiplexer)
7. QUP Block
8. Reserved memory regions
9. PMIC support with regulators
10. CPU Power Domains
11. TSENS (Thermal Sensors)
12. Remoteproc - SOCCP, ADSP and CDSP
13. RPMH Regulators
14. USB 

Dependencies:

dt-bindings:
1. https://lore.kernel.org/all/20250918140249.2497794-1-pankaj.patil@oss.qualcomm.com/
2. https://lore.kernel.org/all/20250918141738.2524269-1-pankaj.patil@oss.qualcomm.com/
3. https://lore.kernel.org/all/20250919133439.965595-1-pankaj.patil@oss.qualcomm.com/
4. https://lore.kernel.org/all/20250919140952.1057737-1-pankaj.patil@oss.qualcomm.com/
5. https://lore.kernel.org/all/20250919141440.1068770-1-pankaj.patil@oss.qualcomm.com/
6. https://lore.kernel.org/all/20250919142325.1090059-1-pankaj.patil@oss.qualcomm.com/
7. https://lore.kernel.org/all/20250920113052.151370-1-pankaj.patil@oss.qualcomm.com/
8. https://lore.kernel.org/all/20250924-knp-pmic-binding-v1-1-b9cce48b8460@oss.qualcomm.com/
9. https://lore.kernel.org/linux-arm-msm/20250924183726.509202-1-sibi.sankar@oss.qualcomm.com/T/#m46501fe9edb880fc11f69442eaf4d2855f7e4608
10. https://lore.kernel.org/linux-arm-msm/20250925002034.856692-1-sibi.sankar@oss.qualcomm.com/
11. https://lore.kernel.org/linux-arm-msm/20250924144831.336367-1-sibi.sankar@oss.qualcomm.com/

rpmh-regulators:
1. https://lore.kernel.org/all/20250918-glymur-rpmh-regulator-driver-v3-0-184c09678be3@oss.qualcomm.com/

PMICs:
1. https://lore.kernel.org/linux-arm-msm/20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com/ (Patch 8-11)

PMIC-Glink:
1. https://lore.kernel.org/all/20250919175025.2988948-1-anjelique.melendez@oss.qualcomm.com/
2. https://lore.kernel.org/all/20250924232631.644234-1-anjelique.melendez@oss.qualcomm.com/

spmi/pinctrl:
1. https://lore.kernel.org/all/20250920-glymur-spmi-v8-gpio-driver-v1-0-23df93b7818a@oss.qualcomm.com/

PCI:
1. https://lore.kernel.org/all/20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com/

Remoteproc:
1. https://lore.kernel.org/all/20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com/
2. https://lore.kernel.org/linux-arm-msm/20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com/T/#t
3. https://lore.kernel.org/linux-arm-msm/20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com/T/#t

USB:
1. https://lore.kernel.org/all/20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com/T/#mb7879fdba16496554a53c3726d90f94b6063dd09

Linux-next based git tree containing all Glymur related patches is available at:
https://git.codelinaro.org/clo/linux-kernel/kernel-qcom/-/tree/glymur?ref_type=heads

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
Jyothi Kumar Seerapu (1):
      arm64: dts: qcom: glymur: Add QUPv3 configuration for serial engines

Kamal Wadhwa (10):
      arm64: dts: qcom: glymur-crd: Add RPMH regulator rails
      arm64: dts: qcom: glymur: Add SPMI PMIC arbiter device
      arm64: dts: qcom: Add PMCX0102 pmic dtsi
      arm64: dts: qcom: Add SMB2370 pmic dtsi
      arm64: dts: qcom: Update pmh0104 dtsi for Glymur CRD
      arm64: dts: qcom: Update the pmh0110.dtsi for Glymur
      arm64: dts: qcom: glymur: Add PMICs dtsi for CRD
      arm64: boot: dts: glymur-crd: Add Volume down/up keys support
      arm64: dts: qcom: glymur-crd: Avoid RTC probe failure
      arm64: dts: qcom: glymur: Add PMIC glink node

Manaf Meethalavalappu Pallikunhi (1):
      arm64: dts: qcom: glymur: Enable tsens and thermal zone nodes

Maulik Shah (1):
      arm64: dts: qcom: glymur: Add cpu idle states

Pankaj Patil (3):
      dt-bindings: arm: qcom: Document Glymur SoC and board
      arm64: defconfig: Enable Glymur configs for boot to shell
      arm64: dts: qcom: Introduce Glymur base dtsi and CRD dts

Prudhvi Yarlagadda (1):
      arm64: dts: qcom: glymur: Add support for PCIe5

Qiang Yu (1):
      arm64: dts: qcom: glymur-crd: Add power supply and sideband signal for pcie5

Sibi Sankar (3):
      arm64: dts: qcom: glymur: Enable pdp0 mailbox
      arm64: dts: qcom: glymur: Enable ipcc and aoss nodes
      arm64: dts: qcom: glymur: Add remoteprocs

Taniya Das (2):
      arm64: dts: qcom: glymur: Enable cpu dvfs for CPU scaling
      arm64: dts: qcom: glymur: Add display clock controller device

Wesley Cheng (1):
      arm64: dts: qcom: glymur: Add USB support

 Documentation/devicetree/bindings/arm/qcom.yaml |    5 +
 arch/arm64/boot/dts/qcom/Makefile               |    1 +
 arch/arm64/boot/dts/qcom/glymur-crd.dts         |  795 +++
 arch/arm64/boot/dts/qcom/glymur-pmics.dtsi      |   19 +
 arch/arm64/boot/dts/qcom/glymur.dtsi            | 7445 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/pmcx0102.dtsi          |  179 +
 arch/arm64/boot/dts/qcom/pmh0104.dtsi           |   84 +
 arch/arm64/boot/dts/qcom/pmh0110.dtsi           |   66 +-
 arch/arm64/boot/dts/qcom/smb2370.dtsi           |   45 +
 arch/arm64/configs/defconfig                    |    6 +
 10 files changed, 8644 insertions(+), 1 deletion(-)
---
base-commit: fdcd2cfdf0db0a8b8299de79302465f790edea27
change-id: 20250923-v3_glymur_introduction-e22ae3c868a2

Best regards,
-- 
Pankaj Patil <pankaj.patil@oss.qualcomm.com>


