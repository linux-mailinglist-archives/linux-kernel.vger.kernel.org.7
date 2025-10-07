Return-Path: <linux-kernel+bounces-844299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7425BC17CA
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CE719A2F47
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B252E11AB;
	Tue,  7 Oct 2025 13:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nXScP99z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706332D5C97
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843406; cv=none; b=lkw2N2jGVvYIgjRVNRVg5BWJPIxFyT7Ha7a6Jxnm2qUEIaVagcvj2dgFiRH7asC1SJdH7Yt6H9Joga9GLI0Ocjcdm1JA5T1PMQlJPG81zt1yri+Ujnf3zWaxrMq6awJqMr/9DFzPu6fuW0F/V/WvoALS81wAwNUdrNo+3HKhVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843406; c=relaxed/simple;
	bh=GWcm9Iqd1K8dGk4aFdnzUCo8n2a9wVNXOCYDYImxl9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVygcFLERmW0LOR1CZCgAEAKBYPJDuldQ6KcoCrkHMPCfkF1WMJLsuFMuygf0e2u6rO3FZ9lfZc3MGdn3TrjEffZ/IBCIDKss/SL1ttEiW9s64J0eno7+OH/UdidseIKjlBfTID/ILCHMGZkGKFgfyJ4cseWWgVUVkAoeywcRNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nXScP99z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597DHKIR026276
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 13:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gtlgJP9r9/bTws0jjX0nVpJJdg3+TInrVP7KgIbG6I8=; b=nXScP99zq8qZwbvr
	dbc5ltlz6CUM25y+DyA74YfJ5euZxlmUVvWnshuPhIaGYV3MPWfTzSHVdYhIM4bX
	l/8FC3+lPWPZyZYRH5+enTNDLy/4uSHhHqb5S3ziTzUlbdYGGFbnMRkMG8Q/PDss
	3zb889N348HxPQvxsbOpvUB0zkaCoIAHnxxWwBEYxtdUDKCwrXXzz/v4chP9MGYQ
	TREx3BSTzjOluuRKZe7+ObtkJBO03fqIAsCpMTlnJhcIu2QhW2JJGLRshUY6s5Sa
	1CBaF6XczS1vZrCfF7Dc2etzQfj7puIWFoWxecxMdwfHJlFcGtJWyQbTk9u1IvBU
	rYCIPA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mgd0k1kk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:23:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e6d173e2a2so6126221cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843402; x=1760448202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtlgJP9r9/bTws0jjX0nVpJJdg3+TInrVP7KgIbG6I8=;
        b=xALAbl8FvT1zXyDlSikTt7McNWAyU0rXzwSMPn2p8QqJE4EQBCqT8B+7nWutSqZ5Sn
         l+oD9Y1QFCxD64gD8fU6GRKf0h1QMUm/jSeCp3GuXzGyYBF2aD0WCvKLtBmntS3Rk2Al
         eE6ni22uN28qAV0sGvwh3XgSCaE/r44nDipUgxnznDxryNTNP2rVrHYSB1txa0vjWNzy
         iBQ2yU/fmR5ACqhCTy/A5mv61xl8/iYlTKtrvwxXStm9oNLwWP+ZPw6CdR2+xxp8Ux/U
         jkk97HWHMgy8/wvc/Bd10wKovbtUggiGshcOyVoYK7WY/uIpaFgwd4em013N/E+1cN5p
         lO3g==
X-Forwarded-Encrypted: i=1; AJvYcCVReA56dlh/GYYOOCqNMkuRTQkPH63qqpboZzUwwpBSnOn6OiiLSgbN/SX/Qq9T55h2ZhpKELZDxIWpadA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoQd0atMaPaM9SDUSOUCP0AosDw7Y1s2LmIB1tu5+i8Ur3qwOq
	iXgvqU66iSOw5IRZebjn3O7yegZZlaOxIdnN08yNQQGtAa2/wEOzMND2+Q3esfGQHCEHt0sOwG2
	LMj8zr+PKtuLGXPxSVvdGC2IMuCJUVKh+cGitQDVFPjdSBBcg9lU9h08EseNWoZ0Wjd8=
X-Gm-Gg: ASbGnctKY+s/RzZxNdarIzPXZezl3AKUqOZF9Lf0NWSV/wsLUgsZ+GkSnG1euQodrhX
	OTUVh5GbHTR5ZWhvLFDBVza5m0m7ghUU5Vumgcxfw8GlCSl4KKgh5umE73Howb0Bgr14c3uP2lQ
	xo47WfpQJ92vgZLVt6rDk3/A0jC1gEVyXRoggdgryG7PTEw7/BjlztuSjQlkDajC7O4OQYYetjX
	D0Ah9W9OeXTVLW72ej3E+6fttWpKHC9+sFSoMtcmdzHYscZ+jghtj0d2kQ+zHMfFtlhyHQ/XlJy
	q9240ZZ+/u/colp7dPpaMQfK0vpXmYKgy278QuJIIu9ehkIeaboeP+OiVNr4CtQcVbiyiULPLZi
	yTftFOcWU670T2gjSi7hp5z68S5c=
X-Received: by 2002:ac8:5804:0:b0:4b7:7dbf:9a81 with SMTP id d75a77b69052e-4e576a56640mr146622881cf.1.1759843401899;
        Tue, 07 Oct 2025 06:23:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTwiKTWukkgKgK9q3K+cBcWv/GpZF9R0dOxSaKX2tCOpUBq88Hnq8CqHgEnzs0FKmcoRdOig==
X-Received: by 2002:ac8:5804:0:b0:4b7:7dbf:9a81 with SMTP id d75a77b69052e-4e576a56640mr146622271cf.1.1759843401154;
        Tue, 07 Oct 2025 06:23:21 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9e66sm1369754066b.14.2025.10.07.06.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 06:23:20 -0700 (PDT)
Message-ID: <80036e24-fb91-4bef-82e0-55b83799765a@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 15:23:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] media: iris: Move vpu register defines to common
 header file
To: Vishnu Reddy <quic_bvisredd@quicinc.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
 <20250925-knp_video-v1-5-e323c0b3c0cd@oss.qualcomm.com>
 <ab28a715-6b5e-4adc-8889-f47ee2e18d5c@oss.qualcomm.com>
 <96aca644-8fdc-8076-c94b-ed655ac526d2@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <96aca644-8fdc-8076-c94b-ed655ac526d2@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _uzHLp3GrbYeiyvS2Bw2Ja_vloJBZ82L
X-Authority-Analysis: v=2.4 cv=T8aBjvKQ c=1 sm=1 tr=0 ts=68e5144b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=YqhKWhOh7Lw7mRpZfF0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: _uzHLp3GrbYeiyvS2Bw2Ja_vloJBZ82L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDEyMyBTYWx0ZWRfXygbS/slGzW41
 bR3rQwtmli+xw1Pe5qxIICjIaJFafURE6kOxDptq64JgkkhK1T2ob0EZBTUIz2pic44RimSF6/+
 CQaJ8Rvdm86pCRkEaz/TOQUNMcQtm9oOmMyunQ77Ejp2MgZ9y/lG5ShbfugBW5weMEla5x0Usc1
 W0o085Us18An3gQx82414yXy3j9UJX0a8OHOTJElNTlD5ZwjWhFnSF+ABSx0WAO56voogcpmv9E
 eeRROnLwQWwJqLQdgvK92if2anR5cijnrGg1bgs8nCc8d2dUCf8JRMy1qyFzwUEvx40Qm+Ccl8K
 E0TGTap2WSm2Ye/5z71jJqyxl7oCiOdLZp2e39orMXI/BTIRb8S/nJapNl6Zare4MpnB84JvBm0
 AB6ioCQ553mn3wwwCW/dwCEkazSt2g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060123

On 9/29/25 7:44 AM, Vishnu Reddy wrote:
> 
> 
> On 9/25/2025 2:40 PM, Konrad Dybcio wrote:
>> On 9/25/25 1:14 AM, Vikash Garodia wrote:
>>> Some of vpu4 register defines are common with vpu3x. Move those into the
>>> common register defines header. This is done to reuse the defines for
>>> vpu4 in subsequent patch which enables the power sequence for vpu4.
>>>
>>> Co-developed-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
>>> Signed-off-by: Vishnu Reddy <quic_bvisredd@quicinc.com>
>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>> ---
>>>   drivers/media/platform/qcom/iris/iris_vpu3x.c      | 36 ----------------------
>>>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 23 --------------
>>>   .../platform/qcom/iris/iris_vpu_register_defines.h | 29 +++++++++++++++++
>>
>> This is a slippery slope. I think it's better if you explicitly say
>> the header file contains the register map of VPU3 instead, as let's say
>> VPU5 may add a random register in the middle (pushing some existing ones
>> +0x4 down). Such changes are annoying to debug, and we've unfortunately
>> been there on Adreno..
>>
>> Because you're using this for a single common function that is both acting
>> upon the same registers and performing the same operations on them across
>> VPU35 and VPU4, it's okay to de-static-ize the function from iris_vpu3.c and
>> refer to it from vpu4 ops, keeping the register map private to the former
>> file which I think will end up less error-prone for the future.
>>
>> Konrad
> 
>  Just to confirm
>  1. You’re saying it’s better to keep the register definitions for each
>  VPU generation in their own source files, instead of keeping them all
>  in a shared header. Is that right?
> 
>  2. The vpu functions (power on controller, power off controller and
>  etc.) which are common for vpu3x and vpu4x are moved to
>  iris_vpu_common.c and de-static-ize to use for both vpu3x and vpu4x.
>  (This code changes are there in [PATCH 6/8] media: iris: Move vpu35
>  specific api to common to use for vpu4)
> 
>  Will this 2nd point is fine or Do I need the keep the functions also
>  in the platform specific file and reuse for vpu4x by de-static-ize the
>  function in iris_vpu3x.c?

I think we can drop this since Vikash said it's not going to change
much for the forseeable future

Konrad

