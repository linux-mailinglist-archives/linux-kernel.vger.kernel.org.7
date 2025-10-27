Return-Path: <linux-kernel+bounces-871278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A694AC0CCF9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 904394F4578
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EF32F616F;
	Mon, 27 Oct 2025 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mw0v9ebq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF22F49FF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558989; cv=none; b=XbUhIBofbGASeHj/v51w1vzTUlvazXX4w18PmPDlhIpsWqY80nz4JO+sJ5z4wY6An99W3VIKepoAfv314K2DqocOgy9ciM9vjsaN30uZGr/V4d+d8lX1EEQ2XTHdOQydTFauS5K94NewYwEmzrumOj5jrtAG7as6DN5pyQnhlsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558989; c=relaxed/simple;
	bh=49KuHWgqbBEZ9CZ0U7HnAnmXXyvBTiks+mvSIgLBnBg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dPdbjAFswkgZVgPjKSCM2j9Hj8Afh7rsl9DOxqKnglegQWVPP2tw/y15FheJed9m1fc/OLqSfLTRXrqyeZZE9CamBeofA/xNVX/v/7gylhDc62ojFUwtEgFY07c+n590Y4Pzv1fDVV4FBcfRnEkhru+GxzOKAj4X/pGBDMWPX8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mw0v9ebq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R8Vujp1049326
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gZLcxjOuhFLSx2lSfPF5+N4YDSy2K6KZJ1QpLWOVRo0=; b=mw0v9ebqeY5/u/c6
	RG+OB7d7GO1dIAfYQUkzi7EJY8Ijy8dPe+Gq7jbAK34W7xBPYnLYs353pAKTVkfz
	rRz3m8siaNAwDU+i6NhATtZMrqjQphaR0uJn9s4LIZDzXi+CkLNRHK+kyCaJ0mFN
	EnVhphL4eEkzfUwrScoBVkFVSlkQDEH82hOa+ns/MvWSjTK7/qN9Jv6Hb67aCr6G
	zVcCHJ0ynjIjeK3tJ5YhozyYU9ea+GB92V9MM2kWX4dWs7tvD73OnSJVvs57izx3
	PMzywn1yjSTu07cfQ+UMU8VMkLcI8tZTu68HWLBVv8bWoylpBfhJSAvmaPM7FV3i
	TGVz7A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0ps142yc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:56:27 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2697410e7f9so116418825ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761558986; x=1762163786;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZLcxjOuhFLSx2lSfPF5+N4YDSy2K6KZJ1QpLWOVRo0=;
        b=VwFyprHssIoPxhJ5jbvIGBS5KrI7AYE1YgDoXcD0/RURx6GUY/kzkwDvYb2UkqEQ5C
         fy7/9jEA3mcbqMVqC6Wn0aib8VgYYmLtQYVQlLjSTJGvynWb7JyyJbzUM/i44ntaa9wo
         hYwV3QrrgZNvWZvu0+ywa8ZkP2EXNtPCskvMoThNGJipquq3LlUE90AE5qPVjAG5i1FJ
         X70FrxpNIyX9QkZtoJuw2bF4svld2DBQBvqFTUlHuu5t+ujoOG/NgOe0fPMCG1+uyQbC
         LkWLXU4sFNSzr/Sv3Tk6cLvVmfNAip52r7bqSuPY+pqFuCHGn4lfiEcMrnekj1OVYYdW
         DfRg==
X-Forwarded-Encrypted: i=1; AJvYcCUQhV0dzxHdrpyZNTpgGK0bFhSzSTGctVmy4VTDTbDii7/h48v+TB2hOZDEw6+Ab5euqreJIM1bPdqo0xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxqA93MK4aIP83ALn0tLxl8jUKi5XGQPvz4pGXb+H+zVvTh07x
	tF97aLtjwA5Lq0Drx20vfx2N//EMj6MxiYDqUCP6Lb60sRfiFohK0JA5ue0+M+2XAJTTbdDzz2x
	bLd7nwaEUKK+0XTAKtxOzVk8ASFLe9sde9nG6MKrpT9Gn1XCx40In7o5LBfyaiBf/0pXyKgfwA2
	g=
X-Gm-Gg: ASbGncuatpC9tlsP0Xq+R7M0WHVtYR8OYfCyYwlvGLHZcy7JMPSksIKgWrF0i3xNNcL
	cDguBlPlvfYViJcUS5QsURXl7PsN0fL5xH5tMcYrzr0+BsQba3Y+xziQWHVAhdArIN21vmTffBc
	aeNwfowngQ9FJ9HbDfXgcd6FMUpq4whGQrwcndXq9zII6X1mdnUJWc5m5iO3DUYIUUWeYi/a0nN
	MZuIF6rnQsT7v61AdqGbvWsNavxL1cFp2RS2SqDymrz+YcTvbgVZuxx8lp5J6GkjdNF56uBZzr/
	mFoBAcue6ux5TwfmK4fYl8gfHkaMsum+bqaye27BUVrBSKF/6e/qgIt72C88nA/WDraU/tUlAcH
	aBdf39Djb2TzOcfYAaTxANPzURdM7
X-Received: by 2002:a17:902:ce81:b0:294:918e:d230 with SMTP id d9443c01a7336-294918ed5edmr125766495ad.56.1761558986338;
        Mon, 27 Oct 2025 02:56:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpsl+w4c265sP2x7UG/jdmhdNem1Mf2ozhJLDuiYIxf3ORTGvq7Xs5oMEtez0jUwb1ebPw9A==
X-Received: by 2002:a17:902:ce81:b0:294:918e:d230 with SMTP id d9443c01a7336-294918ed5edmr125766185ad.56.1761558985868;
        Mon, 27 Oct 2025 02:56:25 -0700 (PDT)
Received: from [10.217.223.198] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d42de5sm76992315ad.76.2025.10.27.02.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 02:56:25 -0700 (PDT)
Subject: Re: [PATCH] soc: qcom: Add HWKM v1 support for wrapped keys
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251026164708.2771213-1-neeraj.soni@oss.qualcomm.com>
 <bef7c78c-2257-47ff-bccc-a9422afb1c42@oss.qualcomm.com>
From: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Message-ID: <5dfd5c3b-08eb-e17a-69c2-68b5c1b6a4ed@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 15:26:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bef7c78c-2257-47ff-bccc-a9422afb1c42@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ju78bc4C c=1 sm=1 tr=0 ts=68ff41cb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=U52zUqlz1-iEZOZ6paEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: e-fh5PllMi_UIQTbSFfGPqy7VX8vGoxz
X-Proofpoint-GUID: e-fh5PllMi_UIQTbSFfGPqy7VX8vGoxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA5MiBTYWx0ZWRfX60KJx7uYH/qp
 QCR/L+bcG7ACE6xiYxzH1ftp6PFvjPcjr4f+IKFQmpJLbWKrICfhQq79JTc3XvYtpN/etLDyLQH
 Je2sTgPGR59b//WHkurBQ3WQMsCGD0wjgyo7AazPdp605uqjPK5n4uNYqPYZM1agWLim/4811FX
 LEjGgn8otGBQKrPkekSOPu6q4Uc+oFZEtN4WuIsN30STJy3lca6xpWcfjMK9Y3IvX/gwRkgZ13y
 F6QgAfGmzI3MDaD4xq/e1tXLnBCpTpdONBqHJvvzYHTKfuiln2qCTbT7PCZ04EJSiP7oz5hv8TQ
 EwvrcbBi+enIOoVDqrtZyKtUPTvkMOXha7TW7XEwRk082refozzcy9nfgR8SOMeuovdcmHQEPPY
 XDfX6Utwl88hdt1La6B6Y8xdAID3iA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270092

Hi Konrad,

On 10/27/2025 2:24 PM, Konrad Dybcio wrote:
> On 10/26/25 5:47 PM, Neeraj Soni wrote:
>> HWKM v1 and v2 differ slightly in wrapped key size and the bit fields for
>> certain status registers and operating mode (legacy or standard).
>>
>> Add support to select HWKM version based on the major and minor revisions.
>> Use this HWKM version to select wrapped key size and to configure the bit
>> fields in registers for operating modes and hardware status.
>>
>> Support for SCM calls for wrapped keys is being added in the TrustZone for
>> few SoCs with HWKM v1. Existing check of qcom_scm_has_wrapped_key_support()
>> API ensures that HWKM is used only if these SCM calls are supported in
>> TrustZone for that SoC.
>>
>> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
>> ---
> 
> The subject must say "ice:"
Ok
> 
> [...]
> 
>>  static bool qcom_ice_check_supported(struct qcom_ice *ice)
>> @@ -114,9 +126,26 @@ static bool qcom_ice_check_supported(struct qcom_ice *ice)
>>  		return false;
>>  	}
>>  
>> +	/* HWKM version v2 is present from ICE 3.2.1 onwards while version v1
>> +	 * is present only in ICE 3.2.0.
> 
> What about before v3.2.0?
Earlier ICE versions do not have HWKM. Will add this description in next revision.
> 
>> +	 */
>> +	if (major == 4 ||
>> +	   (major == 3 && (minor >= 3 || (minor == 2 && step >= 1))))
>> +		ice->hwkm_version = QCOM_ICE_HWKM_V2;
>> +	else if ((major == 3) && (minor == 2))
>> +		ice->hwkm_version = QCOM_ICE_HWKM_V1;
>> +	else
>> +		ice->hwkm_version = 0;
> 
> "if major > 3" is more future-proof than "== 4", unless you know for
> a fact major == 5 etc. will have an incompatible software interface
Thanks. Yes the software interfaces are compatible with versions having 
"major > 3". I will fix it in next revision.
> 
>>  	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
>>  		 major, minor, step);
>>  
>> +	if (!ice->hwkm_version)
>> +		dev_info(dev, "QC Hard Ware Key Manager (HWKM) not supported\n");
> 
> "Hard Ware" looks *really* poor
I apologies to miss this. Will fix it in next revision.
> 
> [...]
> 
>> -	BUILD_BUG_ON(QCOM_ICE_HWKM_WRAPPED_KEY_SIZE >
>> +	BUILD_BUG_ON(QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version) >
>>  		     BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE);
> 
> This is not going to work how you want it to..
Thanks for pointing out. To fix it, i will define a maximum HWKM wrapped Key size.
Currently HWKM v1 supports wrapped key size of 100 bytes which is max. If this
changes in future HWKM versions then the size will be updated here.

#define	QCOM_ICE_HWKM_MAX_WRAPPED_KEY_SIZE 	100

> 
>>  	/*
>>  	 * When ICE is in HWKM mode, it only supports wrapped keys.
>> @@ -238,9 +266,18 @@ static void qcom_ice_hwkm_init(struct qcom_ice *ice)
>>  	 *
>>  	 * Put ICE in HWKM mode.  ICE defaults to legacy mode.
>>  	 */
>> -	regval = qcom_ice_readl(ice, QCOM_ICE_REG_CONTROL);
>> -	regval &= ~QCOM_ICE_LEGACY_MODE_ENABLED;
>> -	qcom_ice_writel(ice, regval, QCOM_ICE_REG_CONTROL);
>> +	if (ice->hwkm_version == QCOM_ICE_HWKM_V2) {
>> +		regval = qcom_ice_readl(ice, QCOM_ICE_REG_CONTROL);
>> +		regval &= ~QCOM_ICE_LEGACY_MODE_ENABLED;
>> +		qcom_ice_writel(ice, regval, QCOM_ICE_REG_CONTROL);
>> +	} else if (ice->hwkm_version == QCOM_ICE_HWKM_V1) {
>> +		regval = qcom_ice_readl(ice, QCOM_ICE_REG_HWKM_TZ_KM_CTL);
>> +		regval &= ~QCOM_ICE_HWKM_ICE_LEGACY_MODE_ENABLED;
>> +		qcom_ice_writel(ice, regval, QCOM_ICE_REG_HWKM_TZ_KM_CTL);
>> +	} else {
>> +		dev_err(ice->dev, "Invalid HWKM version\n");
>> +		return;
>> +	}
> 
> The else path is impossible to reach
. I will remove it in next revision.
> 
>>  
>>  	/* Disable CRC checks.  This HWKM feature is not used. */
>>  	qcom_ice_writel(ice, QCOM_ICE_HWKM_DISABLE_CRC_CHECKS_VAL,
>> @@ -298,7 +335,8 @@ EXPORT_SYMBOL_GPL(qcom_ice_suspend);
>>  
>>  static unsigned int translate_hwkm_slot(struct qcom_ice *ice, unsigned int slot)
>>  {
>> -	return slot * 2;
>> +	/* The slot offset depends upon HWKM version */
>> +	return (ice->hwkm_version == QCOM_ICE_HWKM_V1) ? (slot) : (slot * 2);
> 
> The parentheses are unnecessary
Ok. Will remove in next revision.
> 
> Konrad
> 
Thanks,
Neeraj

