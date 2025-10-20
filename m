Return-Path: <linux-kernel+bounces-861844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D52BABF3CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8813C4833FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DCE2F0669;
	Mon, 20 Oct 2025 21:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aICfjdvc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF1A1EF39E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997351; cv=none; b=MhdxSW0bMwBM3qnKS4GkzFD4CKEzRnfpMr/bodnSuaZseJho+jtv3+SI4w6ASsW1xYGZGZLqR9YC4Cn9XRu8iwux8dSzSoC2/Saw+7N1iav0Hstxo8FnYE893eHEZ9vXCj/JvI1Q/IlIQTuJmd4Bj9iTgcJkw3vq44XQ647N89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997351; c=relaxed/simple;
	bh=QyyuSoIUps09NFB1QyIEgzMdVDw/VR5SVVKBK6Ln8Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fywsMtQddjhP7ddjwBZln55PF19/4p4RcCDgHLWiAuAlP1LyxI53VprZ9UfkmZMLwlcFjStqdznakrx28OCjZVvA5HXjmbhtLLywndZ+L5Q0LWbAqSkrH3+qdXTqIhEGSeB/u1Qg/FfQxLZWhdl/Mcgh/ntcWolV4vDYDR9ztmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aICfjdvc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KL0plb026889
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X6eZpH/FR58J5vUSu8ZZ59QOVhzv+a1WRxrcUgHUIgI=; b=aICfjdvct/4nzh6c
	pY2LE+HGE2kPr1O0ILvXxjBvKBv3iOtECMJDusr/KIkCfXcyUpT3noTIUzldAmq0
	tvggGl9t02cDWQE8eadE1gKM1iZLrQECgr0a9aXsXOYrvXA2it3PxhtWW7cuVqgI
	3mVdQcr2AZmdw32rV50gXhTJafZVWzwlZRhNvNy/AEAIo+C7AeF5OOzpZqMBjUzx
	OhwDF39wtAuyphT9d+ybYajjFyJ6ObrC4E4tdzNrs6iL9qX7BIjpguczcAn+A1UY
	oz2HlXWhEJ7A7B1CxRbBIA3tRkhFVAIxQYImYkjGHgiaU97ndydOsDNN3TBG3uFj
	hp4QTg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v08pee9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 21:55:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-33da21394eeso535464a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 14:55:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760997347; x=1761602147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6eZpH/FR58J5vUSu8ZZ59QOVhzv+a1WRxrcUgHUIgI=;
        b=M7og6Yx0JV8ayDul9m5mXBeQwb6ChssASLv9wXUAG3tkSzSodfi6dZGeybO1e6YBRN
         386A+c3XHHkaunWNEf8Pb0NlrhzmwKDNalbTxaFf4dO4CTPo2amqogNl+gJgeOYdPV0J
         w+tutwlB+8aT4uOqUnLwj4mFASeS4exiAUeUc/XawRhS+PXR9tYnmFadcITCOIJYm9X4
         qnDgop3oxM/st0v4zhnEP/d4KGeyrJc3+dcimzbhhjCBPFWlzR86ecBevISYL95k62jp
         Yw4Bl0gwqJO09uQWKur2brTZeSij7Xvz0iAtiqi2WoiguAKrpWe4XEdvLSynmrsC5O0z
         PKhg==
X-Forwarded-Encrypted: i=1; AJvYcCX0/DI2Yg6rxSIPq8t7EaTQNwtu/wPSkrk+Dad+Q/PBbD3oTqKQkbuqJBiV/zo5BL0I22P9EHApKcNedaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGjOgPjhncq7lJsxgLoWOJQrLLBAZzsUP9MPz6r0h6hoBtEioK
	/AAaEiL7YAFHDxnN+d15oNx2tBOPOV24S3Awmcdhfx0aiRDNJddaxw8wzndE7ASF6hBc0dwTPMs
	PS131V+olRAwtXplYTQ7yxrafWBgABPkco9fcmnMRMeXg1lzLBJrIPLfQedX5VLT01X0=
X-Gm-Gg: ASbGncutXZMtebYyFIevxFyfRHLxmz6cenLq30TYqLNuIFm8DYAuLJUgkseqVij8Fdy
	7xg5qs4k/USmduKRnACIj6wYKjgeXJ2j1AZJWOv3zO2ee8dfyQAyP34AtBJMloBImw0oC7SFSem
	ChLpBFLFtJ1gFaCtLooSoPxqXsVs/wbyzEXaj9g6vCgKXNjCH/5jvmxGHM8d5DUu6toht3QTowq
	Gt4wmPp/PXlu9wG9ixi506GAwPmacdcxX+oKerJYeOmgsIzBIeK9F/EKGOH2/eE0t+xHwM34OCv
	eCiHlLsnOtp151c8eQx25QKeA+HFzG4U2Uwp5SOaNLMk2COxayZUp6lt6xVdEA+ksTVMFnnRF/T
	1b94vtlXgGDt5q8tNlQ6PRDBudDTIvBI4whS+d0poxlNITHLgTWT4kGUI4sdfhA==
X-Received: by 2002:a17:90b:38d1:b0:32d:e413:964b with SMTP id 98e67ed59e1d1-33dfab602f8mr565627a91.2.1760997346843;
        Mon, 20 Oct 2025 14:55:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3W8Ie9iEu+45g+BeKR4BDDKLBi8tJatteuLKjPwvcOVNUAFnYWCI0NWqGb5XXgmHpMWmX0w==
X-Received: by 2002:a17:90b:38d1:b0:32d:e413:964b with SMTP id 98e67ed59e1d1-33dfab602f8mr565613a91.2.1760997346320;
        Mon, 20 Oct 2025 14:55:46 -0700 (PDT)
Received: from [10.110.25.117] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5df5c0e3sm9120257a91.12.2025.10.20.14.55.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 14:55:45 -0700 (PDT)
Message-ID: <81d32471-0611-4653-bc87-1885d2939230@oss.qualcomm.com>
Date: Mon, 20 Oct 2025 14:55:44 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251017-av1_irisdecoder-v2-0-964a5478139e@oss.qualcomm.com>
 <20251017-av1_irisdecoder-v2-1-964a5478139e@oss.qualcomm.com>
 <c2acbc028d014ca9eccefc070e50e40a1022f90c.camel@ndufresne.ca>
Content-Language: en-US
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
In-Reply-To: <c2acbc028d014ca9eccefc070e50e40a1022f90c.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMCBTYWx0ZWRfX3AN3X3aM/LbX
 sN1rQH4ZCxNzuOLnDKSo2hKt78qNAxcgmUEm0QMIU9RoCgOdge3v5+uh+NUwmaHQcPRPnFJefx/
 wJb9V06iS7NtuQgaWP/Nslr5rh4exHfS+zavXpCebaRik3PCIc/2E/jLghqMO8lxcIQkV4SwN8H
 zo6hnWrs3Vk5QjFvOHFA4LyYnvK232J/chr1TXHwAZVvoBlMVbrghvxaJlkydsMJuEz2ti/rEbS
 gVKEjCtHjjhQOED/nFzdi7+XJXKh1RaBbjyZnkrB9fqEqyXm5pHvXkJ3hLDSQ+gkCKQxugiH0SD
 ns+BvbWjOPK8KkPEwx2cjzuUC9R7Em5W4OvSa6sFsbY0qqxolbip0A7lsKfinM8pSzhJ/8hZ09+
 x33TRqrz7YDXCzS7ERxIKv0bNmgZqA==
X-Proofpoint-GUID: ObyeRWr5o6L4459gJIovzCdBYA6OOTmx
X-Authority-Analysis: v=2.4 cv=Up1u9uwB c=1 sm=1 tr=0 ts=68f6afe4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pP9GeRwLAAAA:8 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8 a=KIgxDb2ibSJr1G8uLA8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=f-NqBn8Q0oy_k3NxdD5f:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: ObyeRWr5o6L4459gJIovzCdBYA6OOTmx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180000


On 10/17/2025 1:01 PM, Nicolas Dufresne wrote:
> Le vendredi 17 octobre 2025 à 11:35 -0700, Deepa Guthyappa Madivalara a écrit :
>> Introduce a new pixel format, V4L2_PIX_FMT_AV1, to the
>> Video4Linux2(V4L2) API. This format is intended for AV1
>> bitstreams in stateful decoding/encoding workflows.
>> The fourcc code 'AV10' is used to distinguish
>> this format from the existing V4L2_PIX_FMT_AV1_FRAME,
>> which is used for stateless AV1 decoder implementation.
>>
>> Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
>> ---
>>   Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 8 ++++++++
>>   include/uapi/linux/videodev2.h                              | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>> index 806ed73ac474ce0e6df00f902850db9fd0db240e..d82557a6ac30851b4fd432a5ceab969abaed2e25 100644
>> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>> @@ -274,6 +274,14 @@ Compressed Formats
>>           of macroblocks to decode a full corresponding frame to the matching
>>           capture buffer.
>>   
>> +    * .. _V4L2-PIX-FMT-AV1:
>> +
>> +      - ``V4L2_PIX_FMT_AV1``
>> +      - 'AV10'
>> +      - AV1 compressed video frame. This format is adapted for implementing AV1
>> +        pipeline. The decoder implements stateful video decoder and expects one
>> +        Temporal Unit per buffer from OBU-stream or AnnexB.
>> +        The encoder generates one Temporal Unit per buffer.
>>   .. raw:: latex
>>   
>>       \normalsize
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index becd08fdbddb857f8f2bf205d2164dc6e20e80b2..e03cfe0a5ae830595f0bf69b951ca16beaedab72 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -775,6 +775,7 @@ struct v4l2_pix_format {
>>   #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
>>   #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
>>   #define V4L2_PIX_FMT_AV1_FRAME v4l2_fourcc('A', 'V', '1', 'F') /* AV1 parsed frame */
>> +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '1', '0') /* AV1 */
> An alternative fourcc could be to match the one used in the ISO specification,
> which is also what browsers and Android uses. It would be "av01", link to the
> spec:
>
> http://downloads.aomedia.org/assets/pdf/AV1-ISO-Base-Media-File-Format-Binding-Specification.pdf
>
> Though, we never had any requirement in this direction, its just an idea. With
> or without, I'm happy with the definition.

"av01" sounds good. It would keep it consistent with the spec.
I will update it in v3.

> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>
> cheers,
> Nicolas
>
>>   #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
>>   #define V4L2_PIX_FMT_RV30     v4l2_fourcc('R', 'V', '3', '0') /* RealVideo 8 */
>>   #define V4L2_PIX_FMT_RV40     v4l2_fourcc('R', 'V', '4', '0') /* RealVideo 9 & 10 */

