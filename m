Return-Path: <linux-kernel+bounces-890175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD03C3F63E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5602A4E13C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0A3043C0;
	Fri,  7 Nov 2025 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IJxoCSHy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayVzvEuz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400E325F994
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510827; cv=none; b=EDnqUrDxBCofqPCuZUU4FId40IHeV9bGzGeeECZDsSTNbuwRDYOBmZHPWV9G1XPwoeClPblm9XCFjTd12z+WnQdUa5lDqeWmRYQI+zlzwTf/dxlxYt3piAGwJZkaX9h1ZxU9kZvRFxFWjl7zCcxa0jt4jH9Sm5cEPnDeSjzUMa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510827; c=relaxed/simple;
	bh=KDQZASLrkmCmoVDWZ4mfO4WbfI88ohemMu2pR3sptiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d/dAbn3lXwK587p7jmDInSKcdtGzo/tXSLlkk+0jfTEN5ofkd4VrPPqtCj8frkVVbQJBuScpWOyBumOxeLHwPtmg1Yi5CPfJqErYQOskCSs6me6pK2Tl0We6fnTFxZf4CkubNSI5ALCJVURj3Ce/AiCZLxhosCSqIqWEWhMl3vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IJxoCSHy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ayVzvEuz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A757Wiu2273314
	for <linux-kernel@vger.kernel.org>; Fri, 7 Nov 2025 10:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CQVsKl2qmC0w0jI/a351jFJB+7WeW9QV61JB6YU5ccM=; b=IJxoCSHyBFfj+L32
	JuFKfjUhIdJMLOtIQNSJCrgf0i+GEMySGzl+3ijVen+akmBwKRGDlwUhVZ+3/s1z
	JptYQJk9uZ2M7siVtge3Iijw/0WqKVN2a9r8Fg9tnc2ivMXJr5JNyYikeAdpAY3g
	Mxb/kf6yEhRCMw05XaLPNkTnnEjRdl82YBBtNXU74FVuKT6o1CfWTM0aeDAGXA1F
	p/M+wHpRpZsjo/jLjxXmkhJPLzeAIqiCGl3wJK754gLB3i7Ll6QmC8G86OjomOBH
	fhHAAvXl+UMDv0uvyvhlmtIXR8ejS6j/VFDuzG8RIE4fE1tIrk6SjDlGxx4bQv8f
	+EXK0A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9abmrw53-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:20:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8800dd3de99so1650236d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762510824; x=1763115624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQVsKl2qmC0w0jI/a351jFJB+7WeW9QV61JB6YU5ccM=;
        b=ayVzvEuz0D1PTwjizej8sPBaAa28RhPxZWxgRNtE5+Qy525fUj/T4R7KsRDJ3cYdc3
         +E48sipEx/pTi2pmFAUpnTCmRPjL4KS2wT930rpuPSALFwbiH8TluqJ64tLUA34cN4A8
         lpMZu1fLVVMxNFEGpBYc2PXeyoYl9NrOn/DGkXlcm6cGZmShqQC+809OKE79CoghcPR3
         fu6YOEZSHZ2BO4L5kJ3+KSqHRT233e0fF7aioKX2rU01WKqZWhygzhH8qMrm2VaYPq0E
         wCc0yaO5g2SV5LhcFf4vqnpRIwbF9RmZaWHbgFcdp+yNT/XpYQ1pzY6QKSaeKpJ99ULt
         1LZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762510824; x=1763115624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQVsKl2qmC0w0jI/a351jFJB+7WeW9QV61JB6YU5ccM=;
        b=TziYFNLPwFQXdRtUXnLT9789wxPnn4CgEWI7pIKP1sk+u7udS7rP7qSuT26Ehar8Z+
         xI9fJueWRV+ULFhtCeeQs316IiQZFNTmyAC9dLFuhZ068GuUY7RSeivQ0kbhLLTik7Vu
         CZc87pS0p26vUhi2ANe8IT+6sToFiXObi1ZEZ/BIGhanzLNfcXw0jyE6kNTNGLnDbDF5
         BS9mZGko2KrB8/3ePG3fod7WJzvyATnjNu1YQYSmpsKE4KQfH2EuUVyxqouE+oiLNh/a
         HJx+kewJOm8UV/vPNF2r3+ArTTHsbFRsf74p+eYSYJDdmBGrrCpHPxeF65UZri2Y5mw4
         JdMw==
X-Forwarded-Encrypted: i=1; AJvYcCU7B/gJY6Sx761PeUsP80U2WUeT+rti3RKz1soKZ+xdt/UhUd38HJUrq86O4jwujZgf4kWbwVIEmX7b9Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkqXE5pDfTc7UU1Hb1c9eP+UT/x8qqa0dlNk7W7H/rNWKCqSo5
	AECaU7TYvTuMEBPQHUgXGZIXuOEBihCGo9Y9nMZhfSI2RXYwsAWb4BDYUOwAzbgqooYExphgvXs
	dB4J01CF1vWSvKPhUXsEFkphGshDZGAg86jb4a7RNaAiC3w7PJpec7cWR1U8zkjp7J/c=
X-Gm-Gg: ASbGnctmQ6z4orl/JKdGCQQULGJdK0g7Nj22o5+X0qIBZmERnONzaZWQpU0R+dYsi6f
	ID+66RUkKuEVFxD35DHvJTxZ5dBo25KmjovxHqMBp3chklZkaCgxgiYBAJBsWOXcdQrDo0zyqyJ
	ZZFbMM7FiYvFoog2bUh4NcosTH1EpEMu+lRSebNnf4G/aGmou2xigbVc2AffKsW/smdbaADs2Kk
	nb4xbrPEon/8KdgzcYUdxkk8yvcdLqZxl6f5fI0LsOowZ4fcrx6T2EB/jh8yQQ95jX+owrGDNlm
	+fpv2TvM8jd7VKOxFqR+gDqGuC41tgRJf+mcXN3oBZcpZXxW2X2pVl8vJdnBsFLAU9aWyy52Qb5
	VQZZzVkG4SwBscja47yoAtxxR08pdF1pcsEI2IiLatPGFOMAgRi+0Rhik
X-Received: by 2002:a05:622a:199e:b0:4e8:90f4:c3aa with SMTP id d75a77b69052e-4ed94a66baemr18205191cf.8.1762510824256;
        Fri, 07 Nov 2025 02:20:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJIVPnOvmyTVH0e5HZ3aXk1EooLokFdRBCR92GRsoeTkafjiPomnHduQIF3a+MkVDYX/7JZQ==
X-Received: by 2002:a05:622a:199e:b0:4e8:90f4:c3aa with SMTP id d75a77b69052e-4ed94a66baemr18204991cf.8.1762510823728;
        Fri, 07 Nov 2025 02:20:23 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbcb04esm211292966b.3.2025.11.07.02.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 02:20:23 -0800 (PST)
Message-ID: <5239980b-f74c-4458-a7e3-a5e7f6927449@oss.qualcomm.com>
Date: Fri, 7 Nov 2025 11:20:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/14] firmware: qcom_scm: Add
 qcom_scm_pas_get_rsc_table() to get resource table
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
References: <20251104-kvm_rproc_v6-v6-0-7017b0adc24e@oss.qualcomm.com>
 <20251104-kvm_rproc_v6-v6-11-7017b0adc24e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251104-kvm_rproc_v6-v6-11-7017b0adc24e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: o9y7SrAkcHWanwk_WDhAuxyZ992BSKTj
X-Proofpoint-ORIG-GUID: o9y7SrAkcHWanwk_WDhAuxyZ992BSKTj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA4MyBTYWx0ZWRfX6CQvk0Vlu9gT
 baPqbodXe9q8duHeOrAcYxdxU1LcdSDC1uDFto8XlKZvRf8ubND4tZp3rM8Qo8C4BSM6rHLguCe
 5QQu1QA9C+eWrUeuwx0yyObF36pZg40T9lCgL6gPFS/OBorp2eckc6xAsesqz6vxg55t4cylFiz
 Saj0y/UCugHj1PAko7V9bcmWdzVWEupc5YMDA2YGcnvAKR17Raeli+ILmb9OjTnFrapd+2DNMIK
 jqQ3MUJwPuQargDkvATY5PQMKM//bdEYe5LOKJFXAE1IUjLF1rZzIBNZzzZeIKkA8CKKXBfA7jo
 KnJWq6qwreFizlyBh0WMklmzORrOxa/6jt8u7ufhGYCDil8AqZuETasCVflrXIqAKWFnc4qOcNs
 UcmbO/MyBooIJIq9AyM3dP0L5aAzGw==
X-Authority-Analysis: v=2.4 cv=HPjO14tv c=1 sm=1 tr=0 ts=690dc7e8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iT3TN3GgVcFq34hkIgUA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070083

On 11/4/25 8:35 AM, Mukesh Ojha wrote:
> Qualcomm remote processor may rely on Static and Dynamic resources for
> it to be functional. Static resources are fixed like for example,
> memory-mapped addresses required by the subsystem and dynamic
> resources, such as shared memory in DDR etc., are determined at
> runtime during the boot process.
> 
> For most of the Qualcomm SoCs, when run with Gunyah or older QHEE
> hypervisor, all the resources whether it is static or dynamic, is
> managed by the hypervisor. Dynamic resources if it is present for a
> remote processor will always be coming from secure world via SMC call
> while static resources may be present in remote processor firmware
> binary or it may be coming qcom_scm_pas_get_rsc_table() SMC call along
> with dynamic resources.

[...]


> +	/*
> +	 * TrustZone can not accept buffer as NULL value as argument Hence,
> +	 * we need to pass a input buffer indicating that subsystem firmware
> +	 * does not have resource table by filling resource table structure.
> +	 */
> +	if (!input_rt)
> +		input_rt_size = sizeof(*rsc);

Would the expected size of the received data ever be any different
than sizeof(*rsc) anyway?

[...]

> +int qcom_scm_pas_get_rsc_table(struct qcom_scm_pas_context *ctx, void *input_rt,
> +			       size_t input_rt_size, void **output_rt,
> +			       size_t *output_rt_size)
> +{
> +	int ret;
> +
> +	do {
> +		*output_rt = kzalloc(*output_rt_size, GFP_KERNEL);
> +		if (!*output_rt)
> +			return -ENOMEM;
> +
> +		ret = __qcom_scm_pas_get_rsc_table(ctx->pas_id, input_rt,
> +						   input_rt_size, output_rt,
> +						   output_rt_size);
> +		if (ret)
> +			kfree(*output_rt);
> +
> +	} while (ret == -EAGAIN);

This should at the very least be limited to a number of retries

Konrad

