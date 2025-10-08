Return-Path: <linux-kernel+bounces-845247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC49DBC424F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 11:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF7974E3370
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 09:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016C2F533F;
	Wed,  8 Oct 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WCXeKTrg"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E9029B8D0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759915180; cv=none; b=I8qcVICJRp94UmSs478DSdHWcMvcrnXt+fcYo/570D8iO+jipjBcOZij4mg3N7llMWAFDqrc+TpfGFwsybqa3waln4gVrQzRghrsSA4YroGaAD3sqNKp2k9FZkD0bigbMmn2GqjALdun6WW1WsXIH9/kUy9wYmU4lxwCKNfGQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759915180; c=relaxed/simple;
	bh=7QRpahmcmOdw5PQH5i1we5xeffs7vinNRUO2Yk6g8rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDhRlIbGHEfvEFN5zJW/3qw+hOac4eya1X65stLCHt6Qm4ud99uZ1f9fiPn3t7C2zLqhudQOlDJ0OMeuLiDgk3EnFbk5a5ykpeQlBr4rpiDKeNw/MqHXbSjUPoHSOzQnDkywD4u/2skv5u5gSxE069aCwIX1gZAIFxCf2yJUu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WCXeKTrg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890SGi009627
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 09:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DDebG30uzC8d/gzatvcnaoRcwyzXptUm9ibGKb8H8Lw=; b=WCXeKTrgFRUsUMWM
	vKLcmY3fLjkDW8xAjUmfLuR67jar8W60WZJBTMzWqK7rKvz6srdwR0qTsnaDwbrQ
	Tjg4RRzSMnHlp03SoV1ZkLUwbK6SE89t056abEGJ43s19o7S3Kw25oSPjjdlKLRf
	p7L/E0oj3X4vF4w2PQLm1DvpX75ltYIIwF+rwGlb1PAl30FsBkgd4dtR1rEYsLKa
	BbayXb9YO3/vznh7hM0k2fdbBBRWxwuSYNseDKFw+sDMwDaTC5BPlzfODLsAPXtu
	mUMfOlRs+YIqoU+O6hafIu/V81eZtZSQWA0AJfKlt7rfYfUkXc4H4eGDG7Z6zrxE
	HbfoOQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49junu9x6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:19:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-865c7dee192so153893285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 02:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759915176; x=1760519976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDebG30uzC8d/gzatvcnaoRcwyzXptUm9ibGKb8H8Lw=;
        b=WBXUjI1chquTmJqYKT4azZm9QuLFklgiOjL7i2jsWI2AS1EpQHuQ4FAJwmufxdoXcj
         8S68bCvOQAy9wztGm0RkFWF35KoqT1I0KXFZdxLhIGmmZGir+ksr4zxCn9alNBNUDbEz
         Wj3mpS3OkNH8kBjCol0DP7skdfbZm4K7uNP5tYKNoN/fqinGgvybBEyt7Z9IUwvldB6W
         +mrJ1XXEzerFKjvMU/hNP6PLHOcqXv0ND207+J14uOJlupRrLk9HVFmY/cUggbFBnLu/
         ULIVYdPRndFhduc4qnqefYI5BeNEBL4Zp+ziW1xj4ZB6EucXfKmE+Jh41wyBAC6BgvSn
         QaJw==
X-Forwarded-Encrypted: i=1; AJvYcCUqWL0kd8QDkK2EoAFD01WL1YByKujG12MEEgLEFNjP6ivJ8DI4beLyYPG+e89zr0t4wNMTpRCLdH9vsjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1VHeuHhfJlg9eIBBBzkh7K/m1g+u7vkbQQjNyRpd5C1RdaWG5
	Zn6QVNRUktBtyHo1Kje1jYonY3rs+KaiVLyzQ10vW+v0XUlgpsPCdm9m8bjLZxY5j+cFVrlqsnZ
	jE9xN1mU04KHq95Nug+fWNBm1pfITjrtCx+s8BXP45rP+EhDaFWdC25J2+B2mrqRaaUk=
X-Gm-Gg: ASbGncuTieQ6ty6OGs2CiaB4iO4JOr43jTo958jK0D9AvqMBMuR0WVvExKtB5mtaNpB
	n2tUxrfBWxdEjZTSV+kqn+VHTdFRAcYeXjQAuIumSXFIpu8KPtx9i2xLy+t0FxQ7hZdpPA+G151
	9NYZLhEo2SIryRc6A7WS/3dOf/OPs5CztmQ5cpyU4fucqrpJzi/rSHjyNZKIooWl5uwVVFfaLjq
	U0xmnbc8LgIjC+2iqKSKLvSho/BU3YsJzqRYryQdYHqizhfFkKDIy8Vc03tpS9eGRz2Szkl531r
	MO+WWSygkGopBZRaOmRWtsaho1sZ8kFt4OzvL2axWj3gDyLa3JMIdhMD0wgrigeidtKODTGtIh2
	3lhSJpC7XlPyNiviLxuRPi0yCH3o=
X-Received: by 2002:a05:6214:20e1:b0:798:f061:66bb with SMTP id 6a1803df08f44-87b20ff97f9mr21368896d6.1.1759915176055;
        Wed, 08 Oct 2025 02:19:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9AtoSWRycJFNeyXgDRo0UkanPNUKvhGlX9n3GDw60mCueMa0GPqxCfk2qdRytGJj+xJFElg==
X-Received: by 2002:a05:6214:20e1:b0:798:f061:66bb with SMTP id 6a1803df08f44-87b20ff97f9mr21368696d6.1.1759915175560;
        Wed, 08 Oct 2025 02:19:35 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639773d4d8esm8542528a12.30.2025.10.08.02.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 02:19:35 -0700 (PDT)
Message-ID: <65e6d61a-7648-4125-8550-8a8c6d476b0a@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 11:19:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] remoteproc: qcom: pas: Enable Secure PAS support
 with IOMMU managed by Linux
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251007-kvm_rprocv4_next-20251007-v4-0-de841623af3c@oss.qualcomm.com>
 <20251007-kvm_rprocv4_next-20251007-v4-11-de841623af3c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251007-kvm_rprocv4_next-20251007-v4-11-de841623af3c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iL7oQut-Z6IktW2z7srYfa6dDy-lZNSM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyMyBTYWx0ZWRfX4UdhkFynbfYj
 4BrH0Q7z7zjf6Hx3GTHI8tsCLnVNmgnh/EBTz+upNUDK/9i+wArfBB60702F0V5NNu26UX/4l0v
 XgC+iYiwuZGRiUo/j2zwKhghpR78XpP9ArdRhfJwu1TbBYkzGPtx7PnnQPW9VuAlrFCuV4Rp3Md
 NTjxp4zb8ZqhkBLfWK4cMSsdN8egGA8kR/+ILnBNK63lJ7meBNaZVqHDckQ7nV2m3lfenCOt/1B
 povTpVmc2H5vad5aZeLPV1j9uqpKuZGfvRNh+KIc2pLOUflOYLxpdZllhpih6kMeKSFbwi02uIF
 titA26Oqt9dHasUmVF6O2RT/967WOvRFdP/oCat6iyUDtiXWW3vi4fZjwfMnLe0CUc4J8gg3fNY
 wA3DZAfFEB+Nzb30TIiclcJyM1ef2w==
X-Authority-Analysis: v=2.4 cv=CbIFJbrl c=1 sm=1 tr=0 ts=68e62ca9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=XzL6S5KsqyWbBsQ6UhUA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: iL7oQut-Z6IktW2z7srYfa6dDy-lZNSM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040023

On 10/7/25 6:48 PM, Mukesh Ojha wrote:
> Most Qualcomm platforms feature Gunyah hypervisor, which typically
> handles IOMMU configuration. This includes mapping memory regions and
> device memory resources for remote processors by intercepting
> qcom_scm_pas_auth_and_reset() calls. These mappings are later removed
> during teardown. Additionally, SHM bridge setup is required to enable
> memory protection for both remoteproc metadata and its memory regions.
> When the aforementioned hypervisor is absent, the operating system must
> perform these configurations instead.
> 
> When Linux runs as the hypervisor (@ EL2) on a SoC, it will have its
> own device tree overlay file that specifies the firmware stream ID now
> managed by Linux for a particular remote processor. If the iommus
> property is specified in the remoteproc device tree node, it indicates
> that IOMMU configuration must be handled by Linux. In this case, the
> has_iommu flag is set for the remote processor, which ensures that the
> resource table, carveouts, and SHM bridge are properly configured before
> memory is passed to TrustZone for authentication. Otherwise, the
> has_iommu flag remains unset, which indicates default behavior.
> 
> Enables Secure PAS support for remote processors when IOMMU configuration
> is managed by Linux.
> 
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> ---

[...]

> +	if (of_property_present(pdev->dev.of_node, "iommus")) {
> +		struct of_phandle_args args;
> +
> +		ret = of_parse_phandle_with_args(pdev->dev.of_node, "iommus",
> +						 "#iommu-cells", 0, &args);
> +		if (ret < 0)
> +			return ret;
> +
> +		rproc->has_iommu = true;
> +		of_node_put(args.np);
> +	} else {
> +		rproc->has_iommu = false;
> +	}

I think the above is a little heavy-handed..

rproc->has_iommu = of_property_present(...)

should suffice.. if the developer puts something that isn't a #xxx-cells
-marked provider in xxx = <>, that's on them

Konrad

