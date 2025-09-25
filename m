Return-Path: <linux-kernel+bounces-831856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB72FB9DB55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 078581B22DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F1D2EA483;
	Thu, 25 Sep 2025 06:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fOPGaQD0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185A134BA2C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758782119; cv=none; b=sgS27kAo6FtcdC73UXfTrFBlNafUvxGh+obcLnTerj1jlgUDHcRlCfgYq+wCKFcpqa5ezblPVzGANIqiU/L67QBVS0uueLELUGrqffj7C+bRJ8qRaJGzOaC+N/GqkNiU1o9qkdz0StmxgRTpoSVt2kfKVdxbx3QgG8W3SzinSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758782119; c=relaxed/simple;
	bh=8CzwFeH+yIXjlzWaCoSk23WgOJJjLFsIX6nHBB9c3UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cFM/BlQdtBLSbVTbstJ3Qgb2KNJCVz5owsbYWofAG3w8pCoBwe9tyStzq7luZDnuDMxpIWUNvz8Rcxlh89cgfBmdjKnlPKMpXUqrtCc+dN91hd2OZ2OdpRwQsjG9uJzsr06bId9wiDcwymX1wUIKYv69HUnF2IhsIRHahn2o4/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fOPGaQD0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P0Aw55018033
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:35:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aAc7gWKSiz+kYOTOknPiCGQw/8WrCJW6B2yOu/tuGb4=; b=fOPGaQD0KuBhZmJO
	ZYOE+zxFLvEL41s+ZbCxghdzzHfd4XyTfp/BRmp/5WLl0b8NpfYSvST0z8whpJoQ
	SOCw02IRPGxfqo6DZ8fKIF2eFw6T7hYOlXfqVm+KteSkllkCHdno9pdc9jyW3RH4
	4ZjTi7NNXWmQyIjE9294pFXSNN7XEW5kY4vMWZjfQ7xbqofB4j5tAA3bjuE3y0eZ
	XCh10CfFNqr3tDV11dhrqVzQwcl+tZBPu8A0cfF94+5tISwie5OCxjvMu7XP1KqB
	a56Mkj8ggXI+BC3s+KyUAakJM/nEmcEpNtrlmr3enNejpCmlD32iPOFiRT7qc9hm
	i98jjQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3kkb0qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:35:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b56ae0c8226so471476a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758782110; x=1759386910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAc7gWKSiz+kYOTOknPiCGQw/8WrCJW6B2yOu/tuGb4=;
        b=LOhXScRl6of45XswYqGETCw+wIrc6NYvjwukSMTa3ZAU/Fhw3Xpo4PCCWdRw13Yu0X
         CouJ+bD4TgsW7lcaVO+eGJRtduWgAbrMg1xuDEdEJXNP0UPZ87kI1ng0YN6JNJy0sHna
         Zn8rlwHXtpbfuD/fxOhjh/sddkX4yPJf6hHVIMNjhSu/vCgeiFUhIRM+449HG6dfP14X
         YlQC87Xd5vpXA9s/oQU226VwxHPeS1Beir3KEYIsucWqE9yLQm2UIBxpGOaUYfndadt8
         8xbxiZUvoQfrcyVCPqzg01Cs3bWtaigesX4umOaCOEWLhsWEb9HJ3WjO7kM6tQTK9il+
         4CSw==
X-Forwarded-Encrypted: i=1; AJvYcCXM13hNdwIf3ypggZSe8gMqIzIDbhZfdedTIDk7hlMYX8Q1IkSc/Bs7A6KtOBrwht8qjWgQfgFtlNA4irk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGsER0pTjd9OuIQv26GNR1jaL4rHZqbaAJC4962RxvOmKBLiNu
	qUP0u3PPPLU2yVPS1D5GJkpLc8ZPmExPXf9wqFNQFot5SsuzxuyDhZ4HjWHqUrlVhCPxXKKWuZo
	FuaskiEjZGv03TpWsgujgkkAzDTbvYSIEI4SNKJLtPh1uBmNZudQqpEyqEiAgYLgKZ8Q=
X-Gm-Gg: ASbGncvHRFeH7PFBk/x0W5t1D2pIN8aUrcfYrua2s17VZI+2CUxghX72ZvgaOyi9D95
	K7tqkiLwP58fpI9agsUiiYJ8Ke85BZ+9ge3iLEMGdKGLG2WIEd970Uz5hVWNMc3erw4eSIhS57G
	EpsiFOMd9tME4PY3l9XUyuDWWzUllsukhEioznsZ96ef67Tzji6BA/wBnnNiw9dDlmhweKC3lwm
	ciSbR4hIPz+NDRkxFiaUPpIl+h+hs/FPT43h6XXpB5YGqMqosyzi5UyzRcRBitHu9elhB26jpDg
	3ZJlqOk6HbWummupVEhZLoy+gHMU9WkaBpxb3/l3ew7tAPZ3iu/SNX6lxXMXmb2cIoXNTUI5bf+
	K1rDavNmhbTbkEbYNVzju1GdSMtzu3PtPQcsNM9zCJg9/hx9n9JC4jHMeio8=
X-Received: by 2002:a05:6a21:32aa:b0:2dd:5de9:5372 with SMTP id adf61e73a8af0-2e7be9f1e47mr3129243637.1.1758782110266;
        Wed, 24 Sep 2025 23:35:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgX1HSnRnVr9goBSIcjsYZH7K8MTQ2VofCEQX3a7oGkITnuM6yXYGhavG7od74rBEAOisGKQ==
X-Received: by 2002:a05:6a21:32aa:b0:2dd:5de9:5372 with SMTP id adf61e73a8af0-2e7be9f1e47mr3129202637.1.1758782109774;
        Wed, 24 Sep 2025 23:35:09 -0700 (PDT)
Received: from [10.190.200.181] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b2865bsm982437b3a.64.2025.09.24.23.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 23:35:09 -0700 (PDT)
Message-ID: <1d373c80-8589-424a-bd12-1a14784cca71@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 12:05:03 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/24] arm64: dts: qcom: Introduce Glymur SoC dtsi and
 Glymur CRD dts
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AVECTkhEvndY_rX85Y4xNw61g070pcVA
X-Proofpoint-ORIG-GUID: AVECTkhEvndY_rX85Y4xNw61g070pcVA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA4OSBTYWx0ZWRfX5uWE6GeRCWaD
 GlTvGd/zMV2Yt2fwmK1GNqUS2+Kc8E8gKhp66CiLNKn598dvLcANcsgTRIs6+/kRJLxxgp+fpCD
 BE72s5ILIF7ov0MHHWMg64x16Tme3qmrapIeQyJNYa1uYC3zhZT5LVGz3/5Dz074HfEwd9Wv1SX
 YheoVwGYVg313I05fO4+Zih1x1GJRmlvOdrGaRGTu+Zp0W9I/MOYmkI8LVL+0fvEDEdSvx28FTr
 vetVuLnS/rf1C9cezpEgFIQRDw1XxlX4PDKxLnDwi7FLJWmDWTyYSDU9x/M7aAka44GbP8JN7W2
 DMN0EuCEKTF0mt+7ylas9jei6dH/ZACTM5CXalXdOQqdyP/qEPJeZMWpwmDOKhnp6zsimstw8Wr
 Ck2OnmkU
X-Authority-Analysis: v=2.4 cv=BabY0qt2 c=1 sm=1 tr=0 ts=68d4e2a4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=qC_FGOx9AAAA:8 a=_QuE1zyTwyAq7hhy9skA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220089

On 9/25/2025 11:58 AM, Pankaj Patil wrote:
> Introduce dt-bindings and initial device tree support for Glymur, 
> Qualcomm's next-generation compute SoC and it's associated 
> Compute Reference Device (CRD) platform.
>
> https://www.qualcomm.com/products/mobile/snapdragon/laptops-and-tablets/snapdragon-x2-elite
> https://www.qualcomm.com/news/releases/2025/09/new-snapdragon-x2-elite-extreme-and-snapdragon-x2-elite-are-the-
>
> The base support enables booting to shell with rootfs on NVMe,
> demonstrating functionality for PCIe and NVMe subsystems.
> DCVS is also enabled, allowing dynamic frequency scaling for the CPUs.
> TSENS (Thermal Sensors) enabled for monitoring SoC temperature and
> thermal management. The platform is capable of booting kernel at EL2
> with kvm-unit tests performed on it for sanity.
>
> Features enabled in this patchset:
> 1. DCVS: CPU DCVS with scmi perf protocol
> 2. PCIe controller and PCIe PHY
> 3. NVMe storage support
> 4. Clocks and reset controllers - GCC, TCSRCC, DISPCC, RPMHCC
> 5. Interrupt controller
> 6. TLMM (Top-Level Mode Multiplexer)
> 7. QUP Block
> 8. Reserved memory regions
> 9. PMIC support with regulators
> 10. CPU Power Domains
> 11. TSENS (Thermal Sensors)
> 12. Remoteproc - SOCCP, ADSP and CDSP
> 13. RPMH Regulators
> 14. USB 
>
> Dependencies:
>
> dt-bindings:
> 1. https://lore.kernel.org/all/20250918140249.2497794-1-pankaj.patil@oss.qualcomm.com/
> 2. https://lore.kernel.org/all/20250918141738.2524269-1-pankaj.patil@oss.qualcomm.com/
> 3. https://lore.kernel.org/all/20250919133439.965595-1-pankaj.patil@oss.qualcomm.com/
> 4. https://lore.kernel.org/all/20250919140952.1057737-1-pankaj.patil@oss.qualcomm.com/
> 5. https://lore.kernel.org/all/20250919141440.1068770-1-pankaj.patil@oss.qualcomm.com/
> 6. https://lore.kernel.org/all/20250919142325.1090059-1-pankaj.patil@oss.qualcomm.com/
> 7. https://lore.kernel.org/all/20250920113052.151370-1-pankaj.patil@oss.qualcomm.com/
> 8. https://lore.kernel.org/all/20250924-knp-pmic-binding-v1-1-b9cce48b8460@oss.qualcomm.com/
> 9. https://lore.kernel.org/linux-arm-msm/20250924183726.509202-1-sibi.sankar@oss.qualcomm.com/T/#m46501fe9edb880fc11f69442eaf4d2855f7e4608
> 10. https://lore.kernel.org/linux-arm-msm/20250925002034.856692-1-sibi.sankar@oss.qualcomm.com/
> 11. https://lore.kernel.org/linux-arm-msm/20250924144831.336367-1-sibi.sankar@oss.qualcomm.com/
>
> rpmh-regulators:
> 1. https://lore.kernel.org/all/20250918-glymur-rpmh-regulator-driver-v3-0-184c09678be3@oss.qualcomm.com/
>
> PMICs:
> 1. https://lore.kernel.org/linux-arm-msm/20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com/ (Patch 8-11)
>
> PMIC-Glink:
> 1. https://lore.kernel.org/all/20250919175025.2988948-1-anjelique.melendez@oss.qualcomm.com/
> 2. https://lore.kernel.org/all/20250924232631.644234-1-anjelique.melendez@oss.qualcomm.com/
>
> spmi/pinctrl:
> 1. https://lore.kernel.org/all/20250920-glymur-spmi-v8-gpio-driver-v1-0-23df93b7818a@oss.qualcomm.com/
>
> PCI:
> 1. https://lore.kernel.org/all/20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com/
>
> Remoteproc:
> 1. https://lore.kernel.org/all/20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com/
> 2. https://lore.kernel.org/linux-arm-msm/20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com/T/#t
> 3. https://lore.kernel.org/linux-arm-msm/20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com/T/#t
>
> USB:
> 1. https://lore.kernel.org/all/20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com/T/#mb7879fdba16496554a53c3726d90f94b6063dd09
>
> Linux-next based git tree containing all Glymur related patches is available at:
> https://git.codelinaro.org/clo/linux-kernel/kernel-qcom/-/tree/glymur?ref_type=heads
>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
> Changes in v2:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v1: https://lore.kernel.org/r/20250925-v3_glymur_introduction-v1-0-5413a85117c6@oss.qualcomm.com
>
> ---
> Jyothi Kumar Seerapu (1):
>       arm64: dts: qcom: glymur: Add QUPv3 configuration for serial engines
>
> Kamal Wadhwa (10):
>       arm64: dts: qcom: glymur-crd: Add RPMH regulator rails
>       arm64: dts: qcom: glymur: Add SPMI PMIC arbiter device
>       arm64: dts: qcom: Add PMCX0102 pmic dtsi
>       arm64: dts: qcom: Add SMB2370 pmic dtsi
>       arm64: dts: qcom: Update pmh0104 dtsi for Glymur CRD
>       arm64: dts: qcom: Update the pmh0110.dtsi for Glymur
>       arm64: dts: qcom: glymur: Add PMICs dtsi for CRD
>       arm64: boot: dts: glymur-crd: Add Volume down/up keys support
>       arm64: dts: qcom: glymur-crd: Avoid RTC probe failure
>       arm64: dts: qcom: glymur: Add PMIC glink node
>
> Manaf Meethalavalappu Pallikunhi (1):
>       arm64: dts: qcom: glymur: Enable tsens and thermal zone nodes
>
> Maulik Shah (1):
>       arm64: dts: qcom: glymur: Add cpu idle states
>
> Pankaj Patil (3):
>       dt-bindings: arm: qcom: Document Glymur SoC and board
>       arm64: defconfig: Enable Glymur configs for boot to shell
>       arm64: dts: qcom: Introduce Glymur base dtsi and CRD dts
>
> Prudhvi Yarlagadda (1):
>       arm64: dts: qcom: glymur: Add support for PCIe5
>
> Qiang Yu (1):
>       arm64: dts: qcom: glymur-crd: Add power supply and sideband signal for pcie5
>
> Sibi Sankar (3):
>       arm64: dts: qcom: glymur: Enable pdp0 mailbox
>       arm64: dts: qcom: glymur: Enable ipcc and aoss nodes
>       arm64: dts: qcom: glymur: Add remoteprocs
>
> Taniya Das (2):
>       arm64: dts: qcom: glymur: Enable cpu dvfs for CPU scaling
>       arm64: dts: qcom: glymur: Add display clock controller device
>
> Wesley Cheng (1):
>       arm64: dts: qcom: glymur: Add USB support
>
>  Documentation/devicetree/bindings/arm/qcom.yaml |    5 +
>  arch/arm64/boot/dts/qcom/Makefile               |    1 +
>  arch/arm64/boot/dts/qcom/glymur-crd.dts         |  795 +++
>  arch/arm64/boot/dts/qcom/glymur-pmics.dtsi      |   19 +
>  arch/arm64/boot/dts/qcom/glymur.dtsi            | 7445 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pmcx0102.dtsi          |  179 +
>  arch/arm64/boot/dts/qcom/pmh0104.dtsi           |   84 +
>  arch/arm64/boot/dts/qcom/pmh0110.dtsi           |   66 +-
>  arch/arm64/boot/dts/qcom/smb2370.dtsi           |   45 +
>  arch/arm64/configs/defconfig                    |    6 +
>  10 files changed, 8644 insertions(+), 1 deletion(-)
> ---
> base-commit: fdcd2cfdf0db0a8b8299de79302465f790edea27
> change-id: 20250923-v3_glymur_introduction-e22ae3c868a2
>
> Best regards,
Please ignore this series, it was marked as v2 by mistake.

Thanks,
Pankaj

