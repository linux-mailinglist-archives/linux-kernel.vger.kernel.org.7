Return-Path: <linux-kernel+bounces-871154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AC7C0C881
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15A2A1887684
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A12F39DC;
	Mon, 27 Oct 2025 08:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W7aPEElT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C292F3C0F
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555284; cv=none; b=e2Cw6UHyqS8V7blBXLFy1xMLCcN2D5ezKh8Ga0EpWL5P4oeS0caW+IWaU6/WvivO8+4W4aZQ4YKfSabVMP7Ux8pOPr8akIUh3scqw0jWke7PpdJ0ZqlMaJK3iVj5sT6FxvCK9Qd9WlNZSMByGAyBNZtNX0fa3KPLG+PSYi/wqRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555284; c=relaxed/simple;
	bh=T3wiDzCS8Cx2yECDwJLg4DR2PLGzEmuefrc+tf4FsdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRWPuu5q0+iptQDy3aY1y70KUg1gM/59BFtHoxhPhlnwYx9ntdYSiEWVvf/v+qJ5xw0/Lpfgim6JXjVeF98dLjkBu4JKmCinEKGDtXKjXLrlOMxJ5ahS9wTUMwqV2+yMSY7J6ykBOIL99EVgRRtYkCXPzoYU5A7g/sjBr1s/Eps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W7aPEElT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R0f3SO1245461
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OoULc+URpmAWlFcWdA1+PXx4DH1SpECI7395nut0v2Q=; b=W7aPEElTWRi+7kM4
	auGXstipGxx2h55w0mNZ9Xph91szY+gjfCWp8fguU6FSmoh2WD5TFRGw2bE04dif
	/1puXIbwOI9AKitKwp6tWC3Grbqmqc/xt8Q+00CE++/yUPhV9ovE7FwjieBZY5Al
	CqhY4gCzQxEh/S+bSP1jhZ8ST/aUlnsFi5EpFnihcV6BIn41XQ8Hq6zgBWDgHt1c
	IibjEuav1evJWCMn7zyXL1lNUXbPJdSa1hBJNATe4zcxiYR74ow4qWxNmNQLcx1H
	VoM0P0MhuzdTenmLAP70x1ofNxxciKvCNWR+PZE+zyuCDIaps0olSivY/DRZsO9/
	v7+ZTg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a1uc59a00-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:54:42 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-87c0e043c87so13138856d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555281; x=1762160081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OoULc+URpmAWlFcWdA1+PXx4DH1SpECI7395nut0v2Q=;
        b=AVKxbH92lhT+X8qjniSCqdxtANQNzSZvFqjfI8+pXUgB4a2mlzh4NY4XVGiNKd6cfo
         eEdw2cPtiWjIPemWRe35SsTtezUj5b2LpbjpES5C9ecqaOrqrckgGg+4xpBqz+0H3O67
         8UB8D75QuQk3/a0BghrQzmjF/i08XV7ZAGT9IzRwSp1krQuqKseJMzJ9aNcaZYVUiN4W
         DHBjSvj2EVChRlh948jCanh3tsWZXG8NBKR7JdKTz8oXOlCjYJeRE7l7y/PVkGNXH/Vi
         27oPZJ9vReNlqoL84joaj7WhCbnlPacQ1fX1aV4fU6wbjEE1FDkAE+KOTl4LbfS4nB8u
         OR+w==
X-Forwarded-Encrypted: i=1; AJvYcCW0CdfAzsDdAXG5z+0Wo5J3Iw5onGsobFqmWHhrjpCCmzPAN9sFVj5mnv1xoy52qDLz3TAjmhURah6yYOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YweKJkYWYuxPEiHuqeKWLE5Va7Af6AUbSJLzqNvyGCabOek2aaA
	Z6jdHebvvaDDfOfVUF20BgLOqrr2dUXkfG8+I6kURepKFzURBCRyh4ks/77+BNGH8hQkD1bpn6x
	mhuOC90M1JTJgaB0rQSYsJAlV/lHrXXLvjIz8XaxgFN6yxmS/4qawov21lRCyspX5F4w=
X-Gm-Gg: ASbGncsOzEB+Y03hjO8lP6HKTYLtgZQFCCv7HNem4uMqnFO8stBfK5lK17Sr5OAuFIv
	kNSbQCJu6AVUd8bKgo5VZgKFzubxCOTIG7eYWykbDnJu9SgBT/dpfpghrSsfLdS1OPPCtJlLoAk
	dyhvlRpW5zpHIWq2sOR3MyvigiXvglqaraxB4QRss1o3dTCW1vsI/o58OaG801+cVPSlORKlrs9
	gTlUG0rqolGx87Z0JALjva4+TWjvRdDxmNcJwAs5idHoOIyo1FC86sgCT3sjYwYLrKBxtrasyyU
	sxyeibSGVQZ53KE8dxkWzpoBx2AV99mEacC23WQtGrsNQwNyVoJ5P/91hbeVtHhLUNelzuJZc9h
	5o0N4kyPfmZAmX7ru5+KopIt4cXMi+UyGw+G1/NW8tRMVjlP8IXqxR8Dy
X-Received: by 2002:ad4:5c4b:0:b0:87c:cec:70c8 with SMTP id 6a1803df08f44-87c2068e2f2mr303759526d6.7.1761555281269;
        Mon, 27 Oct 2025 01:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsD82goqIriQhooYA1UI8N5XkNryp5MmcrzsMjrad5PP3m5SwFja48sBzlrZf8IGQYcKJ5Tg==
X-Received: by 2002:ad4:5c4b:0:b0:87c:cec:70c8 with SMTP id 6a1803df08f44-87c2068e2f2mr303759426d6.7.1761555280776;
        Mon, 27 Oct 2025 01:54:40 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853077c7sm703606866b.7.2025.10.27.01.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 01:54:40 -0700 (PDT)
Message-ID: <bef7c78c-2257-47ff-bccc-a9422afb1c42@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 09:54:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: Add HWKM v1 support for wrapped keys
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, andersson@kernel.org,
        konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251026164708.2771213-1-neeraj.soni@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251026164708.2771213-1-neeraj.soni@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 03N4McR2KuaYajXBwv6OwcakKr1dcdFO
X-Proofpoint-ORIG-GUID: 03N4McR2KuaYajXBwv6OwcakKr1dcdFO
X-Authority-Analysis: v=2.4 cv=Z4Dh3XRA c=1 sm=1 tr=0 ts=68ff3352 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Gubjpvm8v4gaY5oPTcYA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA4MiBTYWx0ZWRfX8/obEncogPa7
 9g+EzxUhdpmqceQbdvVcfcGn3ZB98TYEsR9jwmPERi2QNT9Jyj1xNcstdEwyiYpemOJPXwnWDmE
 YDo+hbcqhLOb7jLvjhsUilM/rQEHDPRzDKuzPYbWBixIBxOlu2z6z/diO07sPhwO0j7nbSGU3vX
 TPGJ81wo7i6r8Vo8RuCn7gmCT7J09OdeQa+dIq8YPIElU1eMy1+TYQouxDTOnisTGFMwlZjrKFx
 wOIcCPO9iALi3ZWkwvcvDV4ZsIKFHXmDUb0G2evqYgr70nGy2WklELykOIu4R+/8X0mEJX4WuZs
 52Wo1vdTcmAEAclavZEcngtJUXAzdxzzfIS11HYrSD40HyH3tgIoj8CwkBvrD5YYQNw5i5t6AB0
 yMbCwxzMTHj1GSIfOW1RtfVQvfjZCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270082

On 10/26/25 5:47 PM, Neeraj Soni wrote:
> HWKM v1 and v2 differ slightly in wrapped key size and the bit fields for
> certain status registers and operating mode (legacy or standard).
> 
> Add support to select HWKM version based on the major and minor revisions.
> Use this HWKM version to select wrapped key size and to configure the bit
> fields in registers for operating modes and hardware status.
> 
> Support for SCM calls for wrapped keys is being added in the TrustZone for
> few SoCs with HWKM v1. Existing check of qcom_scm_has_wrapped_key_support()
> API ensures that HWKM is used only if these SCM calls are supported in
> TrustZone for that SoC.
> 
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---

The subject must say "ice:"

[...]

>  static bool qcom_ice_check_supported(struct qcom_ice *ice)
> @@ -114,9 +126,26 @@ static bool qcom_ice_check_supported(struct qcom_ice *ice)
>  		return false;
>  	}
>  
> +	/* HWKM version v2 is present from ICE 3.2.1 onwards while version v1
> +	 * is present only in ICE 3.2.0.

What about before v3.2.0?

> +	 */
> +	if (major == 4 ||
> +	   (major == 3 && (minor >= 3 || (minor == 2 && step >= 1))))
> +		ice->hwkm_version = QCOM_ICE_HWKM_V2;
> +	else if ((major == 3) && (minor == 2))
> +		ice->hwkm_version = QCOM_ICE_HWKM_V1;
> +	else
> +		ice->hwkm_version = 0;

"if major > 3" is more future-proof than "== 4", unless you know for
a fact major == 5 etc. will have an incompatible software interface

>  	dev_info(dev, "Found QC Inline Crypto Engine (ICE) v%d.%d.%d\n",
>  		 major, minor, step);
>  
> +	if (!ice->hwkm_version)
> +		dev_info(dev, "QC Hard Ware Key Manager (HWKM) not supported\n");

"Hard Ware" looks *really* poor

[...]

> -	BUILD_BUG_ON(QCOM_ICE_HWKM_WRAPPED_KEY_SIZE >
> +	BUILD_BUG_ON(QCOM_ICE_HWKM_WRAPPED_KEY_SIZE(ice->hwkm_version) >
>  		     BLK_CRYPTO_MAX_HW_WRAPPED_KEY_SIZE);

This is not going to work how you want it to..

>  	/*
>  	 * When ICE is in HWKM mode, it only supports wrapped keys.
> @@ -238,9 +266,18 @@ static void qcom_ice_hwkm_init(struct qcom_ice *ice)
>  	 *
>  	 * Put ICE in HWKM mode.  ICE defaults to legacy mode.
>  	 */
> -	regval = qcom_ice_readl(ice, QCOM_ICE_REG_CONTROL);
> -	regval &= ~QCOM_ICE_LEGACY_MODE_ENABLED;
> -	qcom_ice_writel(ice, regval, QCOM_ICE_REG_CONTROL);
> +	if (ice->hwkm_version == QCOM_ICE_HWKM_V2) {
> +		regval = qcom_ice_readl(ice, QCOM_ICE_REG_CONTROL);
> +		regval &= ~QCOM_ICE_LEGACY_MODE_ENABLED;
> +		qcom_ice_writel(ice, regval, QCOM_ICE_REG_CONTROL);
> +	} else if (ice->hwkm_version == QCOM_ICE_HWKM_V1) {
> +		regval = qcom_ice_readl(ice, QCOM_ICE_REG_HWKM_TZ_KM_CTL);
> +		regval &= ~QCOM_ICE_HWKM_ICE_LEGACY_MODE_ENABLED;
> +		qcom_ice_writel(ice, regval, QCOM_ICE_REG_HWKM_TZ_KM_CTL);
> +	} else {
> +		dev_err(ice->dev, "Invalid HWKM version\n");
> +		return;
> +	}

The else path is impossible to reach

>  
>  	/* Disable CRC checks.  This HWKM feature is not used. */
>  	qcom_ice_writel(ice, QCOM_ICE_HWKM_DISABLE_CRC_CHECKS_VAL,
> @@ -298,7 +335,8 @@ EXPORT_SYMBOL_GPL(qcom_ice_suspend);
>  
>  static unsigned int translate_hwkm_slot(struct qcom_ice *ice, unsigned int slot)
>  {
> -	return slot * 2;
> +	/* The slot offset depends upon HWKM version */
> +	return (ice->hwkm_version == QCOM_ICE_HWKM_V1) ? (slot) : (slot * 2);

The parentheses are unnecessary

Konrad

