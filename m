Return-Path: <linux-kernel+bounces-833222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96673BA1750
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C45741109
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B7C279903;
	Thu, 25 Sep 2025 21:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o5oj7i/R"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B07D2741A0
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834404; cv=none; b=tSZLdy0l4G7p7gCwbFt6Q9nCTC6vGy/qiWzvZ4HWVssfsiRnPux9K6QATB9rdwAwC/017tmHXJiUhszDm920YSsmvyKBQ91aeYPvV9suuAr+TMQavycpJbO6uX4JYyritRiStHzjyMRMBAjAiI8nkNWDpmle6H2r2qCGKcT7pVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834404; c=relaxed/simple;
	bh=2DU/adLG9pkWQm+grE5YGZgRglstjeNrt3cNHO+bGqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ784e1sHn2uDsIyGekgWWTLB2VqlXIFk4wvynd+3th1GSrCqe0vFq6FAb+Jqe/+whEtnmYddJMyRpOhypYmGLaT2w91/g+uGHT9rKQOfQx13P2Vz9QOnZqLycfE/lUJC5XSXXpoDtuF5KgrfQjdljqfhmhaH86f44DK1qm4NTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o5oj7i/R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PIUrWD025208
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aYqmcdVOcild8mjHLy/eaUpc
	OfsqKV63wySK2/T5LUc=; b=o5oj7i/Rh5COiNq/iNm9a4K7x+K17sbmFTw13FEE
	Subx+JS2+RAvXMsUwa1fh1NuWtzc8AhdshyFD8yiE9qZgWjBAP2LB3FIDyrKIFSJ
	8JmBawzkE4UuIYzmrbrzQAd4AU17b0WNF6GoJW214V8YnucrBkZBBt5o/fip9PAE
	IMFIhvYmHqNwkz2VZPy4EKA69LBA/zhYS1GyUhaC8375FEUKle5eZzdNddBB+ak5
	R2mTb8pe4j7iNeVyUZ3UVccdlWegHsCt76cTG5Qcrw3qDn6hO2mnKBkcREjxABEq
	B2xQ3+pphrRQhlinWPfxY71Jh6JHHbyKiHci16jrDZTGEg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db34gde6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:06:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d9a3ca3ec8so26796251cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758834401; x=1759439201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYqmcdVOcild8mjHLy/eaUpcOfsqKV63wySK2/T5LUc=;
        b=VNzGoGen2DYTFyPG5LJ4mJXkvl+dO0HocSkst6eL1ebwkZhEucb4+H7ZNXRxK6MzQb
         uxeYA9KifYWU0tr4P83ZndpsQI/jqWGygEMhjSiqx62/RdYfc5RDWmfb+p8KaAyUQEoA
         NIsqMvqeH+L/vs2TmyseEiJpNAndfx2VZVaPtmMAVhC7y5YeezLIpbbVll6b4O47dHXP
         wpLcORUR2zLcfoi6SZ7mNY26ntDbooz4+SY+JzhYyELxD3l9BKtu0KxHc05YBhNlC4sb
         Nt5PLWy8G8oam2n3tgqzvL9s/T1tKKVWiA+D76ME1LksFTlztd5jfW0EFw0DAwsb0klT
         BvYw==
X-Forwarded-Encrypted: i=1; AJvYcCUUbqJRqvK4ZH4RBO4HTwnGBvtOii+/uT0875FblKGU55AvI+DfYHWnwjHTO5L4zWrX8lel901vHs8plBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydlzjyBulrjCtLli+/Jk9mCyWUL5GwNI0UKSRT5gX75dQVNHsU
	g6rZynVPTUgmjNoE9lkWUiCuKy+6E7UPO3DH1p9kQ4xL2syBX8NJnVD6VpoqC2y1FtR1GgBhe5D
	BpE4uSF8xiQ3KgajZenDnSNS/hPJAvPgrBnVt73CY0TlAQp1Ja0wfvj4GYU0s4kTZ6Lw=
X-Gm-Gg: ASbGncvpwZjwM2yUfXgNdKbwXAZJdjSBCVTIk4OxzkihNzkCwduBPks0PMPj07cf1YO
	jIMMo1D24frhcQ5jjbbP9f3GjJU4oqMpnHWFhlZD/dg9QmJjzSMrJRRF39Fbn84MbZBUnO6eX7z
	Flsi5sh3j1XMhw+yXr4Y+3v9P2xLNxvCYnaaYxok1DCi1V63t0AvP/S3pkvmhncuUrC04fLJ4N9
	Q/TB3SiDWTpEOTuMlZHNtUndaxGc2WlzMKEmXzKZqOeJOLQ1uvL8qb26CrmBL9KEFwsViZs146j
	yznhUhsj77bFm0B5/sEtOxl4cZl03UI6S2gixyEsXHEDQ7z16HLKp/aBp7IrQmfmLmkoYr8t9Tr
	NH0W3bWOCKnrnu5S3mHkcEhOFqcXL6K8nCpSTlipE3L+Er9OdLUle
X-Received: by 2002:a05:622a:4a87:b0:4c8:36ff:7930 with SMTP id d75a77b69052e-4da4c591f16mr76061571cf.67.1758834400901;
        Thu, 25 Sep 2025 14:06:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENm68K98a4D8Y5bwT8X6HOEjf44eNgOG7R53vAn+su2QeI4VjcXpmyY0SwMYOk1Es2nkBkiA==
X-Received: by 2002:a05:622a:4a87:b0:4c8:36ff:7930 with SMTP id d75a77b69052e-4da4c591f16mr76060781cf.67.1758834400253;
        Thu, 25 Sep 2025 14:06:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-36fb0eb4a90sm7958981fa.0.2025.09.25.14.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 14:06:39 -0700 (PDT)
Date: Fri, 26 Sep 2025 00:06:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v2 00/24] arm64: dts: qcom: Introduce Glymur SoC dtsi and
 Glymur CRD dts
Message-ID: <76bbww3gsb2w47h27jrs5z32bdtxf2r4hwce3g4sbtjo232tov@yx3pripyve55>
References: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925-v3_glymur_introduction-v2-0-8e1533a58d2d@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfX7v+uMgyaSJ0b
 xQMAYF/7mK+vWH5/lsNXF+c4t08uTqIaLtJk1+oGMi2bGL5fvG88Z3hgXIT+PpettKyMbhm2f82
 9zEwxZJRJuopxSBQcLEfs/mAXVtvXxkJqPoDTbcBbok60sHS2b9O3FfITfKNTj4hgCqPfGZeNvP
 o3gS44PMxUYHsqcB1C8kVqmIH6wbq6lq5lQLQvJVLM9AmuPpWXeHmMV23NPI7uoRUohn5vn8NjC
 mEvLasILIGRSW5NQ3MSKx6eUjkiXcgGOt1Tp1EBFKfnMMKGPLVvVYIfH97TfBwk187W2lDrH93Q
 +7tndberi5gYnYHPWVu0N0EOnklzEywxUOmNVBFWPCXaIqBoecv60YrXw6NrzjPCt7XrywDg+zP
 gjmC1/ew2dFdRcZ4ZZsdu/5kkFnwWQ==
X-Authority-Analysis: v=2.4 cv=Hb0ZjyE8 c=1 sm=1 tr=0 ts=68d5aee1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=qC_FGOx9AAAA:8
 a=YcTb5pCOJs5GMJ2OGDMA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-ORIG-GUID: Qk66D2fxosgVFDTazk5CGNFrOSA-xWkm
X-Proofpoint-GUID: Qk66D2fxosgVFDTazk5CGNFrOSA-xWkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_02,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

On Thu, Sep 25, 2025 at 11:58:06AM +0530, Pankaj Patil wrote:
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

You got the feedback and ignored it. Should I ignore your patchset in
response?

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

Nice. Any reason for ignoring b4 telling you to edit the cover letter?

Please actually describe your changes in the changelog.

> - Link to v1: https://lore.kernel.org/r/20250925-v3_glymur_introduction-v1-0-5413a85117c6@oss.qualcomm.com

No, it is not. Something went wrong and this is not a correct URL.
Please make sure that v3 gets a correct one.

> 
> ---
> base-commit: fdcd2cfdf0db0a8b8299de79302465f790edea27
> change-id: 20250923-v3_glymur_introduction-e22ae3c868a2

And no dependencies here. Please stop and instead of sending v3 learn
how to use the tools and how to interact with the community.

-- 
With best wishes
Dmitry

