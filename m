Return-Path: <linux-kernel+bounces-845407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1D4BC4C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF5B3BBFFC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB1522D781;
	Wed,  8 Oct 2025 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W0AxK315"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1712036E9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925909; cv=none; b=U0WscX8cvwTydSucaRsyGKML/G33jobeWYHnQdWuu4jqUzgUS7pNGHNM6yzbl6qLBEtOOUO3HXFs7ubv30IvcCYQiQelGTxzTBDqYia3MZaWjHOMg6kYa+5qsjLD5eJttiHnxmNmOM5pZFM9XPjJlP9CLB/O/DgoqAVmQ2xZPeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925909; c=relaxed/simple;
	bh=EAIIG+pjQ4gXZyIzxLLehKpH7cN9IqpSw+UGcxx1fWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pn1T6XaT6DXgc0r7q431CziimdxBXqe9tkdsbk+M1EEwVOPuXywJsU7V2LnGWnkbJ6HivV056qxfQA5hp3Qo7GNVxblOId8GIIl7r4U/cRsV0TqXTvurv68D7CzyrdOdTzNWsCfpZRe3132pujHWtnB7m659jXtiRkZnGN70jR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W0AxK315; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890MHb001571
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AN/7p1+iy+u6qC3KjWSKiQrrVYUnGqj4/HiYhPktPdQ=; b=W0AxK315mxej4fd8
	if7tWpWDgvrLrx2JVpSLU3HqKcDrbUu64t/0sPi5wPQ7njNmbK4sNZuQQMY74BGK
	XVfVenVdo2b0lUWAzngtxo4PsLyotUPwPdYNA+3iX8lUaGZLa4NNCvNYKASp/fls
	+QIwjsi4YZW4CWL8ttBiS+xW1QiwHwK0YZSaljuaLcVh0u+iN/wUdTJxq/CIHBrw
	ZGZPEmEcOdoiVAT7HFnDlhyz1YB9l8wZu54fcZQq5Ukdv07IBoit5eeE/mQhh/7G
	3QGAsUcCcIBe/0R7otYY58M1mv0/pAQGFZdwr8YLW2NqdvjDGvCgbpglAQOh9r47
	9I6kNA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxnaq80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:18:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-28bd8b3fa67so70170015ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759925905; x=1760530705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AN/7p1+iy+u6qC3KjWSKiQrrVYUnGqj4/HiYhPktPdQ=;
        b=ZMCjQuumXJKT542GUTWhJoYXFbf8IsFrm9C5wi00vj6KdAOiiRY6slJ5kkzTDU1Eo9
         r81JWlxkvuUvRwa7BczlIj39vnMb6nnVIk+EdHXra0XJd9SuV/XVsF84FB1dy4OoR4Lh
         ThVJjJe9DfSsVZtI5uMNTwQJ+HLXpaGcIKf2IEi6hkXE9d3dB5UPCGNuGGaMhuzn/pDO
         UVKRlrxdhhPWwd8WIUqE+IthO7m5l4TeHztpwI+bX6N6wxozCOkVTMGr/ii8NaEQuEMp
         +KnfuSECYDVS1vgJXzq6VOKJ3nPx9MiSzgwQ4ygNqqMVHbyBbaGCXRc6jvTJlOnLcCkN
         NzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHXr3NRCNbmVMk7YP3ZO4dU7LER+mPHbfPTZbOFcxd88KKjQvk4CBhP7+Zv4tzyuB3zOOhtz8MN8rgefk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCShPRqPoPXj6FEcbqcpA1WhdydbJBt1uhrZEUkvwKD6idph0+
	UrXV5KiY3iy1yP05Nr3fehp0mkKjnAIUPtPGJZKKzhl5FW7V/sMGeBUx6rnUvSv3AWMjvMgREUc
	F/wzh7fXxzwVdtl+domMFvcjzraxxeB0finu9aBnSlK3nc4zkyXzGLdc5JNIk26n8xtc=
X-Gm-Gg: ASbGncuif6tJxybEJJZj+RKa3TSxw3JEz4CknxUQBNFulIDjktSDKErsw97OvaIcdTn
	bhf2CgIO0aSBhfh+cloG6P+g8R3ZhuPvMHIeGZhEz7tF79+xFSh2bnU2eQP3ZnECHf3V8hBBx0W
	pGLjr7ID6odeCm/UReQjpquGKDel6E0UivGQM5/09+UCegUp3WtbfA1918Ub11lUXFGAFYYaT+h
	PAqSVkPrsDMAnC9/KKRbk5xQVyDEvhyZ35rxFvIbIJFaIapX4ZWEljba7fImtofsfqwNUFknWiQ
	HGlv8+YfY2zJko+gis6LxBDPMdDKgmVZC5ZC3j/rEL9+Lld7IBNvMcwZXfJow/dr/SyWloyLINc
	j0ndISv/OEP5BsRl0orE7TdcEt6kzcl/orBgtXJ3IoJWLOhxWM8Ut1pTTnTUnY1E=
X-Received: by 2002:a17:902:ce02:b0:25c:d4b6:f111 with SMTP id d9443c01a7336-290272e4666mr45347455ad.47.1759925904909;
        Wed, 08 Oct 2025 05:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHncbR2ufYiXXANSmQUeJIAwNzZ9UKvXSYjMvm+movg1bGrvTPLIrZNPoo9SHIdGgpbrlbk7w==
X-Received: by 2002:a17:902:ce02:b0:25c:d4b6:f111 with SMTP id d9443c01a7336-290272e4666mr45346755ad.47.1759925904061;
        Wed, 08 Oct 2025 05:18:24 -0700 (PDT)
Received: from [10.79.195.127] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ba25asm198168315ad.87.2025.10.08.05.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:18:23 -0700 (PDT)
Message-ID: <40a677b4-15b4-4ee7-85ca-c9ea908f1048@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 17:48:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] arm64: dts: qcom: Introduce Glymur SoC dtsi and
 Glymur CRD dts
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <b3xkzhwfmksknz3kzj273mtkzfesphjetfusnfgcwj4j24kj4e@3sc37anlhweb>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <b3xkzhwfmksknz3kzj273mtkzfesphjetfusnfgcwj4j24kj4e@3sc37anlhweb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX6KPP0itBGVzm
 uKyEnSUW4xkF7iIZteJDHXeFJTLmhMMMcAeAAWZur2QsTT8Iu3XTcoAIU1tUqXoUnm+izc/n6By
 +WGSBGUO4WoYdK+haZiAJAUUK7iHvqTDNyh2lI2tWzrsgcEAceokDW7zAInrIGY3O2sUq7gJoYQ
 0/MgeZALxEWqEVsBiPF1Dt2xVpBFwvXlXnmVwg/ddjRv20E0fDQpPOvPuD+NEDcw4wmTa/F6luD
 ctG8AP6GoYVrJ5TKVtdgVh7P1VX0Uw9aCD6A5bfMibAyWYGc94KdLXerbf0m44O5wY9q3E4Fepm
 dZCi0T4JLxRDRlmL7dOZrRSkOJs1n/ocVlXb5CPf2m9LGBWp173FH8KMDbQzXpfKdy/+uyMKvJ0
 K7IJYu3CBUqzp3uITGpN4ceU/3Byrg==
X-Proofpoint-GUID: 7yXJCr2zLMDO-ZwboV4mVDcRWc8IkQz_
X-Proofpoint-ORIG-GUID: 7yXJCr2zLMDO-ZwboV4mVDcRWc8IkQz_
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e65692 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=qC_FGOx9AAAA:8 a=RKSSqbySQXd_LJkhEWwA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=fsdK_YakeE02zTmptMdW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On 9/25/2025 11:00 PM, Dmitry Baryshkov wrote:
> On Thu, Sep 25, 2025 at 12:02:08PM +0530, Pankaj Patil wrote:
>> Introduce dt-bindings and initial device tree support for Glymur, 
>> Qualcomm's next-generation compute SoC and it's associated 
>> Compute Reference Device (CRD) platform.
>>
>> https://www.qualcomm.com/products/mobile/snapdragon/laptops-and-tablets/snapdragon-x2-elite
>> https://www.qualcomm.com/news/releases/2025/09/new-snapdragon-x2-elite-extreme-and-snapdragon-x2-elite-are-the-
>>
>> The base support enables booting to shell with rootfs on NVMe,
>> demonstrating functionality for PCIe and NVMe subsystems.
>> DCVS is also enabled, allowing dynamic frequency scaling for the CPUs.
>> TSENS (Thermal Sensors) enabled for monitoring SoC temperature and
>> thermal management. The platform is capable of booting kernel at EL2
>> with kvm-unit tests performed on it for sanity.
>>
>> Features enabled in this patchset:
>> 1. DCVS: CPU DCVS with scmi perf protocol
>> 2. PCIe controller and PCIe PHY
>> 3. NVMe storage support
>> 4. Clocks and reset controllers - GCC, TCSRCC, DISPCC, RPMHCC
>> 5. Interrupt controller
>> 6. TLMM (Top-Level Mode Multiplexer)
>> 7. QUP Block
>> 8. Reserved memory regions
>> 9. PMIC support with regulators
>> 10. CPU Power Domains
>> 11. TSENS (Thermal Sensors)
>> 12. Remoteproc - SOCCP, ADSP and CDSP
>> 13. RPMH Regulators
>> 14. USB 
>>
>> Dependencies:
>>
>> dt-bindings:
>> 1. https://lore.kernel.org/all/20250918140249.2497794-1-pankaj.patil@oss.qualcomm.com/
>> 2. https://lore.kernel.org/all/20250918141738.2524269-1-pankaj.patil@oss.qualcomm.com/
>> 3. https://lore.kernel.org/all/20250919133439.965595-1-pankaj.patil@oss.qualcomm.com/
>> 4. https://lore.kernel.org/all/20250919140952.1057737-1-pankaj.patil@oss.qualcomm.com/
>> 5. https://lore.kernel.org/all/20250919141440.1068770-1-pankaj.patil@oss.qualcomm.com/
>> 6. https://lore.kernel.org/all/20250919142325.1090059-1-pankaj.patil@oss.qualcomm.com/
>> 7. https://lore.kernel.org/all/20250920113052.151370-1-pankaj.patil@oss.qualcomm.com/
>> 8. https://lore.kernel.org/all/20250924-knp-pmic-binding-v1-1-b9cce48b8460@oss.qualcomm.com/
>> 9. https://lore.kernel.org/linux-arm-msm/20250924183726.509202-1-sibi.sankar@oss.qualcomm.com/T/#m46501fe9edb880fc11f69442eaf4d2855f7e4608
>> 10. https://lore.kernel.org/linux-arm-msm/20250925002034.856692-1-sibi.sankar@oss.qualcomm.com/
>> 11. https://lore.kernel.org/linux-arm-msm/20250924144831.336367-1-sibi.sankar@oss.qualcomm.com/
> Please, don't list all the possible series. List only the patches which
> define the bindings which are required to _build_ the dtb files and
> which are not a part of linux-next. And also please include them into
> `b4 prep --edit-deps` so that all the bots can pick them up.

Sure, I'll add singular patches using `b4 prep --edit-deps`
Bindings dependencies were added to avoid checkpatch warnings
about undocumented strings, dt can be built without the listed
dependencies except 9. patch 2/5.

>> rpmh-regulators:
>> 1. https://lore.kernel.org/all/20250918-glymur-rpmh-regulator-driver-v3-0-184c09678be3@oss.qualcomm.com/
> This, for example, totally isn't a dependency for building the DT.
>
>> PMICs:
>> 1. https://lore.kernel.org/linux-arm-msm/20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com/ (Patch 8-11)
>>
>> PMIC-Glink:
>> 1. https://lore.kernel.org/all/20250919175025.2988948-1-anjelique.melendez@oss.qualcomm.com/
>> 2. https://lore.kernel.org/all/20250924232631.644234-1-anjelique.melendez@oss.qualcomm.com/
>>
>> spmi/pinctrl:
>> 1. https://lore.kernel.org/all/20250920-glymur-spmi-v8-gpio-driver-v1-0-23df93b7818a@oss.qualcomm.com/
>>
>> PCI:
>> 1. https://lore.kernel.org/all/20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com/
>>
>> Remoteproc:
>> 1. https://lore.kernel.org/all/20250819165447.4149674-1-mukesh.ojha@oss.qualcomm.com/
>> 2. https://lore.kernel.org/linux-arm-msm/20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com/T/#t
>> 3. https://lore.kernel.org/linux-arm-msm/20250924-knp-remoteproc-v1-0-611bf7be8329@oss.qualcomm.com/T/#t
>>
>> USB:
>> 1. https://lore.kernel.org/all/20250925005228.4035927-1-wesley.cheng@oss.qualcomm.com/T/#mb7879fdba16496554a53c3726d90f94b6063dd09
>>
>> Linux-next based git tree containing all Glymur related patches is available at:
>> https://git.codelinaro.org/clo/linux-kernel/kernel-qcom/-/tree/glymur?ref_type=heads
>>
>> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>> ---
>> Jyothi Kumar Seerapu (1):
>>       arm64: dts: qcom: glymur: Add QUPv3 configuration for serial engines
>>
>> Kamal Wadhwa (10):
>>       arm64: dts: qcom: glymur-crd: Add RPMH regulator rails
>>       arm64: dts: qcom: glymur: Add SPMI PMIC arbiter device
>>       arm64: dts: qcom: Add PMCX0102 pmic dtsi
>>       arm64: dts: qcom: Add SMB2370 pmic dtsi
>>       arm64: dts: qcom: Update pmh0104 dtsi for Glymur CRD
>>       arm64: dts: qcom: Update the pmh0110.dtsi for Glymur
>>       arm64: dts: qcom: glymur: Add PMICs dtsi for CRD
>>       arm64: boot: dts: glymur-crd: Add Volume down/up keys support
>>       arm64: dts: qcom: glymur-crd: Avoid RTC probe failure
>>       arm64: dts: qcom: glymur: Add PMIC glink node
>>
>> Manaf Meethalavalappu Pallikunhi (1):
>>       arm64: dts: qcom: glymur: Enable tsens and thermal zone nodes
>>
>> Maulik Shah (1):
>>       arm64: dts: qcom: glymur: Add cpu idle states
>>
>> Pankaj Patil (3):
>>       dt-bindings: arm: qcom: Document Glymur SoC and board
>>       arm64: defconfig: Enable Glymur configs for boot to shell
>>       arm64: dts: qcom: Introduce Glymur base dtsi and CRD dts
>>
>> Prudhvi Yarlagadda (1):
>>       arm64: dts: qcom: glymur: Add support for PCIe5
>>
>> Qiang Yu (1):
>>       arm64: dts: qcom: glymur-crd: Add power supply and sideband signal for pcie5
>>
>> Sibi Sankar (3):
>>       arm64: dts: qcom: glymur: Enable pdp0 mailbox
>>       arm64: dts: qcom: glymur: Enable ipcc and aoss nodes
>>       arm64: dts: qcom: glymur: Add remoteprocs
>>
>> Taniya Das (2):
>>       arm64: dts: qcom: glymur: Enable cpu dvfs for CPU scaling
>>       arm64: dts: qcom: glymur: Add display clock controller device
>>
>> Wesley Cheng (1):
>>       arm64: dts: qcom: glymur: Add USB support
>>
>>  Documentation/devicetree/bindings/arm/qcom.yaml |    5 +
>>  arch/arm64/boot/dts/qcom/Makefile               |    1 +
>>  arch/arm64/boot/dts/qcom/glymur-crd.dts         |  795 +++
>>  arch/arm64/boot/dts/qcom/glymur-pmics.dtsi      |   19 +
>>  arch/arm64/boot/dts/qcom/glymur.dtsi            | 7445 +++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/pmcx0102.dtsi          |  179 +
>>  arch/arm64/boot/dts/qcom/pmh0104.dtsi           |   84 +
>>  arch/arm64/boot/dts/qcom/pmh0110.dtsi           |   66 +-
>>  arch/arm64/boot/dts/qcom/smb2370.dtsi           |   45 +
>>  arch/arm64/configs/defconfig                    |    6 +
>>  10 files changed, 8644 insertions(+), 1 deletion(-)
>> ---
>> base-commit: fdcd2cfdf0db0a8b8299de79302465f790edea27
>> change-id: 20250923-v3_glymur_introduction-e22ae3c868a2
>>
>> Best regards,
>> -- 
>> Pankaj Patil <pankaj.patil@oss.qualcomm.com>
>>


