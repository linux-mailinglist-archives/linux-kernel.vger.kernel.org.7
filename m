Return-Path: <linux-kernel+bounces-882913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E91FC2BD8E
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96BD91881E7C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43EB30B524;
	Mon,  3 Nov 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cjNHrobc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fPLGQUWI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CBB30C360
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174348; cv=none; b=XUxcf0GoI+KlNwELYP72WApB5L+KWtsceuImMy8Z9exFetmObGJ4W0w1xaGy2fwSqsULUA8HPlLrvzEujUNDWnsAGS0tqt0IHc7EMYukajf4ZYu4zQdO4HGLoh7DMBoti/KfhfhVkk290b1cCk+14feZ0mSjH1EfABqo++MMbow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174348; c=relaxed/simple;
	bh=heVAq7NCx/flJlCN3TIsR27SjYV1cMhTibQl46WN3DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQT11s/vjnuBfQHH6kGDgj/8GInhMWG/X+6UeFH28trvrsS01cFZwGMlJlPQQXYNgmFulHrxx4RtKivW3Wyljh4gIV1WQBkfYAjgHXZtmw7SQ+FcM2D0KHmvuZ5R0r+oAemtR5UZGCuGWBz0lJqjZxQpSHX/gr4dMZfOeHloWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cjNHrobc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fPLGQUWI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A36ArQm2266949
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 12:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ufSdN2+C3wMkejSn2sfN2kc8G6SjeNpP9Coln28UADQ=; b=cjNHrobcZ0S+IcWX
	/jNdPaPmbTOxe3Rf0Lra2hCKyLhfU4PkRLH+AvzBSDW114g1m4hkqZ4ya2LrRLjU
	63RzDLutj9I/MoeLYFESF5qcYPAlgZlq7UCja7T2Xx49wv5FM7ywtVgXq4zum7mc
	Ataajo1tXUE4WAErU4xnO9GIaI6qkTB/6jLY4ld5IXoBXc5/S5APb/NW8eIu9otP
	fgQJPAKreI9D3u6WuHAFLobYvLwpu8FfPsywScv+L2sSQ+19JrWcEzrTiurJZQcX
	LyCF2lspKQBVmhgiKQ8hGEoo5AasOVKNZDJ3znp2S8Z0R59ssdDnVH8GUlwnY5Gg
	++Jj9w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6pwah4ug-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 12:52:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4eb9cfa1b72so18334031cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762174345; x=1762779145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufSdN2+C3wMkejSn2sfN2kc8G6SjeNpP9Coln28UADQ=;
        b=fPLGQUWIWDGyKfIx8mBqZ7tlYzBjOUsVJ8j34naWIuef4l5Eb8TIXrIBNTCePKbnU4
         hX1J0Q1ORAz7/ZYmwYcq008fSyZCD2CmqMQgfcYEAMVfN4/qRnWVlxBOLVJetWOGhsNP
         NRe9YAnkbV8RPbPSnWByeFw91+gH5PVIbB7tad9gymaFPSFgreUre8NKsC1KeXa9xHeV
         hyNKrRmsxNMtQwbQzd/sVrXBEfAxPk0ker8u0xVBFihFNYRi+gf+6gvz864kpt3Rjl2n
         0vKvnuYH3Gsm4Ggq+lTBN3tRQ11BuHGRssi5Zn5a5YWTnE7s5lXmcvQ7IrQjx9EBg1yo
         Rt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762174345; x=1762779145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ufSdN2+C3wMkejSn2sfN2kc8G6SjeNpP9Coln28UADQ=;
        b=Dc3v8qwpvGfahlqPxt0o/oCC/vZiuMeZQ5eQwJVDi18FwI6a+us0ONwLvZpyFpfoQZ
         T+r+1FetQtKoawOXGGZwThJHeudczjMPNF77ReLLPdSFBriiFUqYmnxZSdGdEAR8t2Lv
         l7UVMlW8EDjm0fsCQIlJ5HgP9pWj0ZnkKJfe3wIH26foTK3IjXbJjNJ2toMrQiL3/Q+Z
         hNoE8xNgwH3KC4kmOvo/7Hk3EOkMD/SBLKD79JByywQ4XGSEP3SYRSyGekqlgrgATViL
         o9yxT7mclHCPuR/aITrSeXDnbSGhq/N9MiY9jbmXTeL2J/ZNTPttgKEqDOpdgMy6A49B
         KYCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCiF2p7p8YmTfhn3JGktvTbD6b12qh4PSoM6jNzXnmQNU/62duINlBnp0kww3l90luJv8qIEndXNzXIRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPQXVM+140iUOxwnbyt+vWuVGHpG3ZibLkd3CKpBbq5LmW2JP1
	KXGLg0oCEh7zzIBmqegg5C8CM5ZM1BgHdIjsEpaa1I0t01MRASN5m7EBbPMUD5WaNfRp30vCwx6
	06/J1cOy4LwiwI6w0u4zCyQdGlx7sImcmyv97DpGWolHe3Cs0X2WixTq7fGdNLsiZNOg=
X-Gm-Gg: ASbGncuk7gJZQkKkV3Za398td8TFzi92NpMX/dneo7MigxT+rp3pdmeiAAMldV8TkGb
	AKpura5RO9VaYkjDglGRAg6Z3MHoMyXPW5TuONPqQk84Mq6jGivbv4kFV9d/xmbyMwXc6eTakLO
	cWbusgxNbS4eWiVR0DbYPMn/HdKrMPRr5a/40ptpJf+eUCjXyG6XJVO6L9+idMSArhNXrJ39PP1
	TLadTnOWvvZ3DBMX34tq9Abzvnh+V5XhQh1uLOPcXeq6xuLSmXpAzv6MrhRRUhuwz4ax84SyMak
	WkwLSDqigGrYK6qAGJ6EiOerAVtcgv7iTyU0u5tF0N+XAyPHrwX/aYnxXATHre8eYNZEgNjrOsd
	B8xybpL4ll59y+CACMCtYvXq8HlG9VDf8qGnbCpgAnkuQ8NaLUnSTT9a7
X-Received: by 2002:a05:622a:835c:b0:4e8:9af1:366c with SMTP id d75a77b69052e-4ed30f7f5bbmr90085461cf.9.1762174344767;
        Mon, 03 Nov 2025 04:52:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQK6aZxb1evMm9CSUc6V/nzcWHXNYMRxGxQJOJEOdgSqxZTkvtNL9OfqFSj74zG4eUWypUTQ==
X-Received: by 2002:a05:622a:835c:b0:4e8:9af1:366c with SMTP id d75a77b69052e-4ed30f7f5bbmr90085241cf.9.1762174344325;
        Mon, 03 Nov 2025 04:52:24 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70ada0c289sm513580566b.3.2025.11.03.04.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 04:52:23 -0800 (PST)
Message-ID: <83c3aea5-764e-4e60-8b16-67b474f19357@oss.qualcomm.com>
Date: Mon, 3 Nov 2025 13:52:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: sdm630/660: Add CDSP-related
 nodes
To: Nickolay Goppen <setotau@mainlining.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux@mainlining.org
References: <20251023-qcom-sdm660-cdsp-adsp-dts-v2-0-895ffe50ab5f@mainlining.org>
 <20251023-qcom-sdm660-cdsp-adsp-dts-v2-1-895ffe50ab5f@mainlining.org>
 <07066c46-4121-48da-846a-3a180d245589@oss.qualcomm.com>
 <47b40a91-8365-4431-9fd9-1e48fad2a4e1@mainlining.org>
 <a3cb6633-1595-41e7-8e87-ca48a98f822c@mainlining.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <a3cb6633-1595-41e7-8e87-ca48a98f822c@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OrdCCi/t c=1 sm=1 tr=0 ts=6908a58a cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=OuZLqq7tAAAA:8 a=ITMobWRzqwyUaGoyGfYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-ORIG-GUID: KK2bI8eOlI82T7eTN84lrNtxzbkVhdF0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExNyBTYWx0ZWRfX6vpROYAPzRei
 V3lDkGFxpYhmq17WuKGjgU0tr9bL2gg/E1S3xUBxYucnrmdJaiNdX3BI5imiqXivvdoDtoTydX8
 CscLaBpIXR68no/YZYGjJGgo1XiLemN7+wasyr1OGoL4WmGNAOMwjcVyL6WuIZxXyPHV1Cub2b/
 7I7dDSVncva4z8VUtuKpmlkz8s261rXwxd/QTwNt/vwUnyovVHbKY+63luWW+KYJHSfd9zmluB3
 gAVLAPCrwN4QIHJ94p4MFTZDq30fMmb3rk5+S9LxvWm5tijbGl/2HEAj0uWE1BmQfPz56JP+RYM
 53SBXfQbFLAPPoq1NagehnphRIEKOn8ewkj2lR44oa5iFbwIgPkEV21A1EzIOqZLVbHlnIYmmHT
 8dLRD91603DRsLWZIIw8r60R6hWkSQ==
X-Proofpoint-GUID: KK2bI8eOlI82T7eTN84lrNtxzbkVhdF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511030117

On 10/31/25 12:30 PM, Nickolay Goppen wrote:
> 
> 24.10.2025 16:58, Nickolay Goppen пишет:
>>
>> 24.10.2025 11:28, Konrad Dybcio пишет:
>>> On 10/23/25 9:51 PM, Nickolay Goppen wrote:
>>>> In order to enable CDSP support for SDM660 SoC:
>>>>   * add shared memory p2p nodes for CDSP
>>>>   * add CDSP-specific smmu node
>>>>   * add CDSP peripheral image loader node
>>>>
>>>> Memory region for CDSP in SDM660 occupies the same spot as
>>>> TZ buffer mem defined in sdm630.dtsi (which does not have CDSP).
>>>> In sdm660.dtsi replace buffer_mem inherited from SDM630 with
>>>> cdsp_region, which is also larger in size.
>>>>
>>>> SDM636 also doesn't have CDSP, so remove inherited from sdm660.dtsi
>>>> related nodes and add buffer_mem back.
>>>>
>>>> Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
>>>> ---
>>> [...]
>>>
>>>> +            label = "turing";
>>> "cdsp"
>> Ok, I'll change this in the next revision.
>>>> +            mboxes = <&apcs_glb 29>;
>>>> +            qcom,remote-pid = <5>;
>>>> +
>>>> +            fastrpc {
>>>> +                compatible = "qcom,fastrpc";
>>>> +                qcom,glink-channels = "fastrpcglink-apps-dsp";
>>>> +                label = "cdsp";
>>>> +                qcom,non-secure-domain;
>>> This shouldn't matter, both a secure and a non-secure device is
>>> created for CDSP
>> I've added this property, because it is used in other SoC's, such as SDM845 and SM6115 for both ADSP and CDSP
> Is this property not neccessary anymore?

+Srini?

Konrad

