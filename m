Return-Path: <linux-kernel+bounces-893797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD69C48636
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B523AB01B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C302DC797;
	Mon, 10 Nov 2025 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b02Tkkty";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a65FVDfD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4022D94BB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796489; cv=none; b=kII0O5VWm1XAWhsErEA2RS3I92jJdUcg1hF8jLEwV+nF1t9/3KhzEgm9OjkoFDW2Geg6Z0PFBaGJeajmZnB3W1VgnWpbyHZc2hgZ5519cQcaIe25rhoV9XdLSvFONl603AYxHF3RVC72wEbm3hF6N3rSEZ/ssr/xXvsp798cKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796489; c=relaxed/simple;
	bh=9Le+paz4qi0KOoccQ1CPvXK1zLkPjp6aQajuPiFqnnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VooqubvgdkjXLbKZ7EEIrkB8/xJFb01hKA1rty8kCyrfop68vB7NOiw4naPeEJ7ORR0rhxlfbJwHf+4MvPvYH6RgFME2pdy7WMG+tmSzY7rgbvEzKKmVURI08ptcfiiHSRwPzITNyKBrI8TWi4BMFprMrj9Ipc4ff3sGtCw0n+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b02Tkkty; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a65FVDfD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AACmQDh2407314
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mah6C/CRdzUeB5dh6iBvU8j/VCs5HqFST+oAymfAr+U=; b=b02TkktyNg8o/kxr
	bjmsfHfAkrPVGAfNwqKk3vsoIjEXZbQTbaMvjUVxneIP6EbZdz7FlQEeo/J4CHYS
	KBUlBRvF0BmcxQJ00X9cZ26AekzHurzKHEZltAv7dqZgv5OsLnCggPFsm6//3vA1
	Ms6+6SRmgXLU2vj+w3RR3luRKOYnKAJKlHHiuBFGq0/s/FRmNzZ5F9qPlXNztwyS
	GUvB3TcBUrPN2cDAtOyHxwJozboeLDUP651wZRThTv21TI/KvkLxlXJ1vtlPSgpX
	W3LonqSrtW2nOjyWmr5X6wSODg3iBsERo57PsxKSPo4+ZyCjsKbQw+zuntie+LN7
	qj8z2A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatda2k7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:41:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edb3eeae67so56376851cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762796486; x=1763401286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mah6C/CRdzUeB5dh6iBvU8j/VCs5HqFST+oAymfAr+U=;
        b=a65FVDfDcPnqqfHlbIlfCvQrwIpT+8oB2/7NH2S33ZDzxFfk2bpmWtTcFITJIWvh2I
         p/hcu00wxu3bB7t7j16S99mvumdYKfrDwL9L7Et2P5dy2VDw4spzVViy4vS0LpgjW6TM
         ZrVSF4HhztHrPKDeE5YqLFDrrj+g4T+WFw3wQhQcKTiODzxTReC5q+MjObfghtHA9gNi
         IT1wCRwCM0P0E1gtk+SYly1WVW8VCP0ShwcCiY8wytXZl/bRPo+ZsTIw0pU0M0zbOl57
         wFfLFXAFSo49aUyQR39eJLa2d8TAnqfKPgPpM/+easji61i5EpdxY5ru7AgNp+AEIH/f
         703w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796486; x=1763401286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mah6C/CRdzUeB5dh6iBvU8j/VCs5HqFST+oAymfAr+U=;
        b=HBj9/0A/EQJ89Pef2cCrIzqDn8V7LmKuOibRrFKUXAgkdk25/pe+HLkNuRskRVWFQq
         HGN2ZqhSycbwsQP0lkachrd0ZlBwwyev93RyyMNnKqNQyJaPSlPCmXomf10wR2078493
         RmOWYUuIENOtUjFBBE5DrXy7QxGw8XxYZZPkUWV27Pq0wbqXoMTsP8mNpX8JC4CliSBF
         B3TcxeN8/obL4bEIpmcFJgO05Y2+heiUjl+W5mSX7L/x2ydrNzXIS7JQH2keAcmKc1VF
         +ax94U4Bu3guDB3okcGIp3sM1pb/cvcKIjmZrYm2E5nBNIbAvcq5SDVRALmHjD5WL8o3
         6BLA==
X-Forwarded-Encrypted: i=1; AJvYcCXbj35GjaqtlWinHwaGMgDVBnBo7tOxSexuY3v9/Oe1MXzXQ7Bhn00/W8dKfAVFCWVW1A+mq+R9yuQNIKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUDObErBJrJouXQax3+irl7GWWOoFnSFqDoHPn9ErWezCD0cSh
	nqlm+OzgbUTD/9pManFswDHMQqbZP53Ao8qNjX+0oboynLZ6yk0CugNNiYIDpHvHGg5jdjAiuo4
	EF6N5mdLTRQoUo4GYhTUGugeSnjNxjitTpTE/eyC3LiWKOR/VJXyAWKzMmlTWyHNw3DI=
X-Gm-Gg: ASbGncvj5WklfJmQbGAy2ujuGXAdpbNo2QMACQdZ4zJZ1XXikBhH7dBjXxfph35EpGu
	cXBNookE4LeX0TUudcOc1cqBqwwzOPQacZee+i1jKQ/bCt29LOsHRMzJd/eAjewogO/2ORndcmW
	QSS8Fn+kvCMYU36FJRL/hgIrBt5bh7U16/9oVBRNITA0LuhGWZBMv9p2L1YM1SclRatlGjIaxoN
	B0goOun+GTO9dcFE9xFalIREgS0caKO2A+jwcFbBF8Pvcwc0YtwySNkqezoNI5XBVaYKbIDFdCo
	vNx41sUxWMYpiHi9q2D+NGh3BLrtR7Wmt8VRl7yy9oTd+3o6AVbgZNx10MozlGQ0N5Zk2PWWpHJ
	EHqPuQxdA6rEkm9aIzLMyZwH4fw==
X-Received: by 2002:a05:622a:1354:b0:4ed:2164:5018 with SMTP id d75a77b69052e-4eda4ff3014mr115756901cf.80.1762796485722;
        Mon, 10 Nov 2025 09:41:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBDppgSdzr6FUv3e8RZ2+x7huTFbm7O1GvcAnVaSz7ySOqdi82vnRrM1dsCoHtV2ZgDo/42g==
X-Received: by 2002:a05:622a:1354:b0:4ed:2164:5018 with SMTP id d75a77b69052e-4eda4ff3014mr115756511cf.80.1762796485263;
        Mon, 10 Nov 2025 09:41:25 -0800 (PST)
Received: from [192.168.68.121] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42b2b08a91esm17816756f8f.2.2025.11.10.09.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 09:41:24 -0800 (PST)
Message-ID: <d17548bb-ddce-4d60-8dc4-2c0633989299@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 17:41:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sdm630/660: Add CDSP-related
 nodes
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Nickolay Goppen <setotau@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20251023-qcom-sdm660-cdsp-adsp-dts-v2-0-895ffe50ab5f@mainlining.org>
 <20251023-qcom-sdm660-cdsp-adsp-dts-v2-1-895ffe50ab5f@mainlining.org>
 <07066c46-4121-48da-846a-3a180d245589@oss.qualcomm.com>
 <47b40a91-8365-4431-9fd9-1e48fad2a4e1@mainlining.org>
 <a3cb6633-1595-41e7-8e87-ca48a98f822c@mainlining.org>
 <83c3aea5-764e-4e60-8b16-67b474f19357@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <83c3aea5-764e-4e60-8b16-67b474f19357@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _ZqBpYO2iw4o696Fu74Mls-Gc-THeTSr
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=691223c6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=cjWOPvm4Lta6hPSZL2YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: _ZqBpYO2iw4o696Fu74Mls-Gc-THeTSr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE1MCBTYWx0ZWRfXzfH6hhJbxvBZ
 2xF7efq5XnfueNW0+WDSTSz+lBq1IvFH47mzrkr234N2MAiTUwLNJW1w0pFLfe8SJcJ97LimzFw
 Ytj51u6VtEIQ7NE4hoomZ4H9As1pFW+68aNPEQot+8swWDYAEO2jcaDcYNx5SLEAjLp9IzO1iUS
 mVvyf7mJqFZpDinxCB5e1ZxW4NjrFJnyfDvYl1hk7gNld4LZ+03K8VB1zCoQN7oODmv9JiidWfQ
 oZVn46N1up3w3a2wNnyIkAEoBiXcEicnXAAqaZXn8W0o93L/7dS4Z/ckShnck6sexkvpWPAZ2iu
 XT5TRlEZ9j72qmkfVK+DNCiH+4JbWV9U5QI8yKE76dUYknsTL7F408VF7yGjv+KdlcfAB4iXD/F
 HwcmMyWVbVxxCG4OYW8992r9EH2gKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100150

On 11/3/25 12:52 PM, Konrad Dybcio wrote:
> On 10/31/25 12:30 PM, Nickolay Goppen wrote:
>>
>> 24.10.2025 16:58, Nickolay Goppen пишет:
>>>
>>> 24.10.2025 11:28, Konrad Dybcio пишет:
>>>> On 10/23/25 9:51 PM, Nickolay Goppen wrote:
>>>>> In order to enable CDSP support for SDM660 SoC:
>>>>>   * add shared memory p2p nodes for CDSP
>>>>>   * add CDSP-specific smmu node
>>>>>   * add CDSP peripheral image loader node
>>>>>
>>>>> Memory region for CDSP in SDM660 occupies the same spot as
>>>>> TZ buffer mem defined in sdm630.dtsi (which does not have CDSP).
>>>>> In sdm660.dtsi replace buffer_mem inherited from SDM630 with
>>>>> cdsp_region, which is also larger in size.
>>>>>
>>>>> SDM636 also doesn't have CDSP, so remove inherited from sdm660.dtsi
>>>>> related nodes and add buffer_mem back.
>>>>>
>>>>> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
>>>>> ---
>>>> [...]
>>>>
>>>>> +            label = "turing";
>>>> "cdsp"
>>> Ok, I'll change this in the next revision.
>>>>> +            mboxes = <&apcs_glb 29>;
>>>>> +            qcom,remote-pid = <5>;
>>>>> +
>>>>> +            fastrpc {
>>>>> +                compatible = "qcom,fastrpc";
>>>>> +                qcom,glink-channels = "fastrpcglink-apps-dsp";
>>>>> +                label = "cdsp";
>>>>> +                qcom,non-secure-domain;
>>>> This shouldn't matter, both a secure and a non-secure device is
>>>> created for CDSP
>>> I've added this property, because it is used in other SoC's, such as SDM845 and SM6115 for both ADSP and CDSP
>> Is this property not neccessary anymore?
> 
> +Srini?

That is true, we do not require this for CDSP, as CDSP allows both
unsigned and signed loading, we create both secured and non-secure node
by default. May be we can provide that clarity in yaml bindings so that
it gets caught during dtb checks.


However in ADSP case, we only support singed modules, due to historical
reasons how this driver evolved over years, we have this flag to allow
compatiblity for such users.


--srini>
> Konrad


