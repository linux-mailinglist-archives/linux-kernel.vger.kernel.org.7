Return-Path: <linux-kernel+bounces-773510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115BCB2A134
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FB71895512
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E02218ACC;
	Mon, 18 Aug 2025 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fp18PK8o"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F3F27B326
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518578; cv=none; b=KMyqbmDJJFQtJOkaDRa1JBLiHxeTJC/XHQNGdIE8pOQKiJLkUwc6v7WPi1nR9awwx3Nv8+Kw5wy6b+dEpeJGwB7+UozmWADQ2oxR1Gr957QbNRdLIeFiWcuiBJiNImW1Te764gETI9EaOkwuE4zQz79GkEeQ/o/isaXly8fVhzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518578; c=relaxed/simple;
	bh=v8TQVD2vn2z73mguUbqfgNSQQeQbImAiZzcexQv4K1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jECofQWWcyCYbcHe2WC2HVhMX6LMcw8+VW0s56cP/IvjNHsFGNgkBm9DIC1kp+8Ar2B9UTAR5HCkbPTHjI6AZO1gUhXkzdqOwQdXwqzqCIfzsEcyZCGFRhr4O/UPweYjYqNcNUUxV3QdOEknPxHQPuPCsLiFLtIffZcHEzqA1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fp18PK8o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I7VYpW026820
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CCju6bcx4FiaoDBIgpe/cizWDUazCG2B44X0S5ArA7E=; b=Fp18PK8oqdg7eB0Q
	YrzI0r4a7Pjfp5CLiiFL7B2Vm7cSybNXwlFXwRl5UstuBRBxUKbxOb5Mf/+oOmxA
	QNW+6A9BFI5YMvedye3lKFtQhtHo17tI/MvhQ5dtOpx5ZnBePGbb/VBicr8rEMt/
	EX4QItoDp5zFOdKCHXWLZwA7r1je4hHSsUOnnK4nXVQNyrAgshxPVjNUu29uYb5j
	pheu8bg4maEUT8gDego6+8ToSjhH0y1DuV0e86K6RFwNXAzSSS2K8knT2LIcDs2R
	rpyIEgYi1sjlncPg9yFOd+23TsZCxQ3WdP1lBXMf4BUA4Hzw/4FmGq/3U4AKqNJc
	evtmzw==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48kyunru2h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:02:56 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7438204153aso4549594a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755518575; x=1756123375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCju6bcx4FiaoDBIgpe/cizWDUazCG2B44X0S5ArA7E=;
        b=H98mhgqW55o0Vcgh+VQs6jCdoeb+MlQ6BAR8kepLabyxxNFPp48clhuqjsTIYn4yqv
         aknUxA5KX8l7CeP3KQxNmLulNqjNXX7J4WJFwvUeTcFcCZfcvmrvYO0kvC3q0OyTXrbr
         ZrzKLLum2FEBPLAZiu1GznQQOIF6bOd6/frjW0GyJ6MSgjwk8AXz9naEC5qaTVAp2JFR
         eiKVb/q/BIOG/l9xWrwFqUdV8laBgEAtWg/2HkRcBeVePX3H17rc47Fg60pOeIWUWjIb
         76quFz0APcbjCgBc2G/jWPJXgXG5GeV76j9yFurFBUuDId5FLRuuVMI3lrZBjuwjHAGR
         G6bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBMzM943TaVmXAoP5i8POvrkgngeUxKTr9jix1CSqNuE0FV5ezN3n9mg7+FSQHURldL1a4CCRcXcDGtpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRNqXho+iYA/18OzoeQqdQ79hOz3z3TCMUmNK+vCV2fBHdEtLH
	/QhVwkXifCxgvmQH3raiyXYaj7UoTk6eWb+06ZpwHKxuY/3XX0h0d3v5h1SXMv57rcLt299o+NH
	6CJMh+p11bZY1LmeeDfpeETI1iDk+v4vC8U13O7bK2o4Y+LVmVn/BhtzPYHWsbQfTvlg=
X-Gm-Gg: ASbGncsuoXmgs9k5esbvXS8szDTwDsNXiXa9iOGp3T9jJb3kV5j+AxMFMhsA5apduF7
	rh1FLwzKpFs9y4CCTG0Ixnd3Y5PyXfs5plfbcMDyIzJOkO+Sw3RrekUt30XDOJJoDCxsR2kRf4g
	1SUfPPc4kNf2r5Svyp9J9jSIzA44M3gtozcCen1IC/VcWPm2go7rMsB2mZnGjE/LV3DZGdkxAY/
	aVDJN31jsIlvh12BbRv355/syUE2jqPJlXdpm1KwlN5Aufq9Myx41Yp4mJ7UWI4Dm1HZHfSfBRN
	8Qdq/9DoraTvJKBtN2IJIsNzEHQuyDd4sv0c1eBhBeIApPl2pOkw5yfXBC7q47J7K8Y=
X-Received: by 2002:a05:6830:f89:b0:743:2cc:d52d with SMTP id 46e09a7af769-7439248fff3mr7185078a34.27.1755518574796;
        Mon, 18 Aug 2025 05:02:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0S9aYXMwUyd6iZ9WqnqRGP0929twrrupyMw9RBL7nXISanLRiCa0LYDt7gDwmTn4IW7nOhg==
X-Received: by 2002:a05:6830:f89:b0:743:2cc:d52d with SMTP id 46e09a7af769-7439248fff3mr7185018a34.27.1755518574235;
        Mon, 18 Aug 2025 05:02:54 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3bb676ca37fsm12454389f8f.41.2025.08.18.05.02.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 05:02:53 -0700 (PDT)
Message-ID: <ade7d6ed-b4fe-49f9-967b-340ac75a0ecc@oss.qualcomm.com>
Date: Mon, 18 Aug 2025 13:02:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ASoC: qcom: audioreach: add documentation for i2s
 interface type
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20250818112810.1207033-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250818112810.1207033-3-srinivas.kandagatla@oss.qualcomm.com>
 <9f050ccd-0fc1-4fb2-94f5-36ed1f2f4f01@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <9f050ccd-0fc1-4fb2-94f5-36ed1f2f4f01@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rV-V-cKTxxRuXYyxMgoDVWVmBo6CqYDq
X-Authority-Analysis: v=2.4 cv=N6UpF39B c=1 sm=1 tr=0 ts=68a31670 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=OPwlfTSxJuAJHfmk8b0A:9 a=QEXdDO2ut3YA:10 a=Z1Yy7GAxqfX1iEi80vsk:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDA3MSBTYWx0ZWRfX8H+ysJhZqcp1
 bhNbfnTYJ29ndGCzo4nv3o1H5JmpmgBwoIJ/ed4V+2qHl1YZYAnDGY+val4wdgPQ6OeJQ2iL6vR
 T6ogFHh6EbLT1bP9QEkHxOc1Z7QSdMznGhNtu8hRKgK8EzLJoReVeHAEMB+HuvSlJhtiLlXPyn2
 NxCDtaezpxsWzJpOQcCT6NAq6KX/RZhA6QT2UauSd4FR+Djol5wVNQyFeReLlOV2psCUK2ASJzr
 6m4nX1OJTATvexh0waeroDcTSk9kpzAKa7ra27YZttQm8SF3e3J5u4Aa/cwYj76Wn9W6+pvdx4J
 sJpPnKNtmyCjYthNF+rBNdG2Gvx6YjT0iXBa+sR4MnLzqGSSgwCgZ7tO3k6+b24QoHVrmbokU+K
 c+1Dca8K
X-Proofpoint-ORIG-GUID: rV-V-cKTxxRuXYyxMgoDVWVmBo6CqYDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180071

thanks Krzysztof,
On 8/18/25 12:56 PM, Krzysztof Kozlowski wrote:
> On 18/08/2025 13:28, srinivas.kandagatla@oss.qualcomm.com wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>>
>> Add documentation of possible values for I2S interface types,
>> currently this is only documented for DMA module.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
>> ---
>>  include/uapi/sound/snd_ar_tokens.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/uapi/sound/snd_ar_tokens.h b/include/uapi/sound/snd_ar_tokens.h
>> index bc0b1bede00c..3aa5f4928a2b 100644
>> --- a/include/uapi/sound/snd_ar_tokens.h
>> +++ b/include/uapi/sound/snd_ar_tokens.h
>> @@ -118,6 +118,12 @@ enum ar_event_types {
>>   *						LPAIF_WSA = 2,
>>   *						LPAIF_VA = 3,
>>   *						LPAIF_AXI = 4
>> + * Possible values for MI2S
>> + *						I2S_INTF_TYPE_PRIMARY = 0,
>> + *						I2S_INTF_TYPE_SECOINDARY = 1,
> 
> Typo: SECONDARY
> 
>> + *						I2S_INTF_TYPE_TERTINARY = 2,
> 
> And TERTIARY?
> 
> Although, they come from audioreach.h so, well, eh...


True, I was doing vi autofill.. we should fix the audioreach.h as well,
let me do that in v2.

thanks,
-srini
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof


