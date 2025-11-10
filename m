Return-Path: <linux-kernel+bounces-893767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01483C484EC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEF33B31B8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112522BCF46;
	Mon, 10 Nov 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZTRkEkpy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bit4ocRV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B132BD001
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762795312; cv=none; b=mHgU/4HgSNh9E20v9PSAHBoTZDbn+TbvexIQdRn2g17ATK06wnyRsPoEl4+fJyN9jNfKQIhwzBWZtIakqaLIepcn0lZKR+KB7y91LzFmSkYmIoZVRT0RNw/TETfBkQTrqUEhKJeApuydL1o32fsDTEKnmvmXXO1p+JnX31ajU5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762795312; c=relaxed/simple;
	bh=oOyxVfvfN2aRyBhPTf8mwV/DdTCr77BufMFYqC2fNCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReM6qFka7KGOnRG/C/Eyni3nl4/HJq5kd1Qo1xo6A98LOYmn1SYsi5HcysAv2dLtr69q7MubDVcWoHDLIqQ5vTsKvw0S30/TZyXeFSg6GROKhTD5X0U8jvrZIUu4qcVoUdmNZLcQSGFBAHqw1Hf2O/7NFGtn4jchFc1uWNDBFUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZTRkEkpy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bit4ocRV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AABZT3u3271011
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KzEs6QNzdu2qhytoCaWZmKH/MfHn62bBmZSzoL1GAIY=; b=ZTRkEkpyQ7iLYLgt
	qDVsqFH8TuTytvJhA44WRofEY6PBkIhpGlUf0J84hEpxvdCDSf/285d4P0LLnmRQ
	OomSLvt1DEmF414KzoyWR6g3rXb+Eu/59P7O2bUvxtxji/1uJL14sRS/kLwXlf1t
	QqYA0gEPP439zPTXFcCPoINFRd7EHHmZKqVMK95Ou1YBmo/+Wo5r/qLY1K5+8g+6
	udshw6HQf1j2Yp2Rt7Tbz4ZTg+qBmkCGwlgat2hRmbr9kiY3+YsrgdNaE0TDOi1B
	NHI7f5rJJNzRXaq2zlY9zEwv8FUD75CZgvyKVy69vytG9Sk8IQCpQ9xqb6N9kXI7
	I6QQTA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abfafs1c5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 17:21:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2964dfacb68so10882485ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762795310; x=1763400110; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KzEs6QNzdu2qhytoCaWZmKH/MfHn62bBmZSzoL1GAIY=;
        b=Bit4ocRVDSlvLZ/1Yo8bF+J24api2iA048nUIjdZf4DjQP3ezXYOVuMTmsPFZakCDe
         wUvDDjwD6qHr2WrfFpTYdUqcmPdQbZ80ETfe3QaXDWbKNUUWQsnCGZYRwl81yHzU1lJX
         IL77GUU+3Nh2IW3wd4utYVh7IFYWW6rpxIkVrq8hrNS75aHurJ+APM9DDDL2EK8uxqBj
         5StQA/6MeAE7CFJLnqXjv+8zhkFYZOc1/DC8a7EhCPo4AGyBOYvXVXrCKpp7nPTXqozh
         U7fnE+yh3As3S07zkubdCT8fpeSCH2B9WUKSq8gPnG+5Q3XybLHt8YJBDf7+E3SZs+kQ
         mSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762795310; x=1763400110;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzEs6QNzdu2qhytoCaWZmKH/MfHn62bBmZSzoL1GAIY=;
        b=XP7fpR21olABitcviQ9wPP+OZpn2gCNejaI6Z6s1UZBqaOnkUOiPEpxFV0W//Gfeon
         m9AwidDmW5zCVNxf986/wl7to9rB1mkGZeHD9wZ3eYngRPaosMcaShrMMWZmODL3CJ7C
         wNMCsYO/BTVfq8pg9cULGn+bqXXPGL3QM8zaE93/sYB6LVVGp1MMTWB3WItatTWh1qvh
         ZDxC3HuymSiVV2OH0y1CUcTI1eDm4LZhFFXrCk5qEyHni4xFpy6ur4i41Qib38yGj22v
         nu8ft3Tt1b2GzCZDdc71fUg2yf6sJNwF9Ez/uVF/VGgvSZC1oYB3vlqEXzPe/Rhm5NbF
         hJRg==
X-Forwarded-Encrypted: i=1; AJvYcCWaX8J6UySNl6tlMa98kfOg5hf6NfpK3BYktMhe3qQZZ/vikuePP8Dlfw7Rnst0PzSDchxnDAghIP7PTz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySX1eKp8v6E2a1vqWiraDfF08W16CHHpt6OMpEeZV1N1y8001e
	mx3QOvQI4tLV7rO4oa7Dv7lS4nE3U9wwrsuwiM6LX4NHeWIC26wqr65Q9awBM5Kg5R05Lj1pYKt
	6Xp27sUGHynMJOFobxuZCoWguNXoOaKr1sjAe5EVHrIIdrTyGAMp7IiXLDqZzJQACgRs=
X-Gm-Gg: ASbGncvZt0oZKMeB9hilDb8r3azJ4tjkCDNkFLeJ7EXw8aTmXjgncQZPAzl9EIQn7wG
	ciTcaBKyvjWfsAOco+Hkq7Z17TFsi67aqQPwWs2PbWJWC7iddnjnhx7mteSfZ6iwpOH1dMkOGqt
	1vkkKJ8t+inyWZJRQxWGSOuyXCdYofD1HhFtbKa+JqnzW9putI7A97tAlG0j8nRIwaDL1i0eMnH
	zh/Zp5hgF3YX/f/ft1Mhfh8q4zkx8S9dtQKXhEHJbM4DKQlF6Fweli+0be6NHV7J5Q+6/FTl172
	8NGMn9zmohCFXOemft5Cmv0mGmmZOnJPvgxu11OPWpdrazaGDFjYA9oYuRRw966FZqC+Ib4NDC2
	PAA221rT2/tC1x8i/noos2UgeawnSB2J0HW1p2eUaseuyllV6Mo27MPyrEJV+Ew==
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr65139975ad.7.1762795309741;
        Mon, 10 Nov 2025 09:21:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELGhkx48AwbIGq6vB2KJ644Ff+ve66z22iNyFkftsJjOkeg8StfG0sIWyldz8RRpbhI3STtQ==
X-Received: by 2002:a17:902:dace:b0:290:af0d:9381 with SMTP id d9443c01a7336-297e56cf5d7mr65139755ad.7.1762795309239;
        Mon, 10 Nov 2025 09:21:49 -0800 (PST)
Received: from [10.110.83.178] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296509682bfsm155611875ad.4.2025.11.10.09.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 09:21:48 -0800 (PST)
Message-ID: <33fcfc82-14c9-49fb-89b7-657b7ac640a2@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 09:21:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] media: uapi: videodev2: Add support for AV1
 stateful decoder
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20251109-av1d_stateful_v3-v6-0-4a9bde86025a@oss.qualcomm.com>
 <20251109-av1d_stateful_v3-v6-1-4a9bde86025a@oss.qualcomm.com>
 <2a458127834680ea8e4bc74639536a20494f1357.camel@collabora.com>
Content-Language: en-US
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
In-Reply-To: <2a458127834680ea8e4bc74639536a20494f1357.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uYTZsQmwWeBGGInbiFoCiQuLUKCeCBpA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE0NyBTYWx0ZWRfXzNhCP+aUi3Ip
 tsPkr1wm5C0L4ANXowfLyRGeR8yeEoqTCOv2LyQQmA/9ua+DTeUW3C2g/RKPtrFVqf17GRlZ+oo
 Jwfi72+z5saAk6YjH6hMgCmFzmD5ucuD191yzph4Fh/mybPeWLRL0gWWYKdXBcYiEo2fiaA8jh7
 hUmw+NDl2EUxqBjqiSrNOMAh17s1BknwSDsAzw43vn9pMcQ16s/+Vf1L1KKMfWi0C7lXzBb5zOx
 5utFb28H3G4L/3eIBIg1u2nb1DW+T9mjoIH/+yR0iju5+Z4QVvqKdbIksP27zYYYxBUtskLLqY/
 yzqb1+lGqQRBtcyZGB+nwHHk0nSOjALq1R81lHwm2X0fCEQxdlKaafBGE0JTjAmpuaxVLv4x0uH
 0s2lZkGbA+oWoCiOVd1kQEXpQBI+sw==
X-Authority-Analysis: v=2.4 cv=UZJciaSN c=1 sm=1 tr=0 ts=69121f2e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8
 a=lfnHfZgCvS1hSVXH-IcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: uYTZsQmwWeBGGInbiFoCiQuLUKCeCBpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_06,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100147


On 11/10/2025 5:59 AM, Nicolas Dufresne wrote:
> Le dimanche 09 novembre 2025 à 21:05 -0800, Deepa Guthyappa Madivalara a écrit :
>> Introduce a new pixel format, V4L2_PIX_FMT_AV1, to the
>> Video4Linux2(V4L2) API. This format is intended for AV1
>> bitstreams in stateful decoding/encoding workflows.
>> The fourcc code 'AV10' is used to distinguish
>> this format from the existing V4L2_PIX_FMT_AV1_FRAME,
>> which is used for stateless AV1 decoder implementation.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>> Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
>> ---
>>   Documentation/userspace-api/media/v4l/pixfmt-compressed.rst | 8 ++++++++
>>   include/uapi/linux/videodev2.h                              | 1 +
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>> index c7efb0465db6480fe35be8557728c196e0e530f4..6ca63f35b801b8aae142b69eddfaa549a5568a3f 100644
>> --- a/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>> +++ b/Documentation/userspace-api/media/v4l/pixfmt-compressed.rst
>> @@ -275,6 +275,14 @@ Compressed Formats
>>           of macroblocks to decode a full corresponding frame to the matching
>>           capture buffer.
>>   
>> +    * .. _V4L2-PIX-FMT-AV1:
>> +
>> +      - ``V4L2_PIX_FMT_AV1``
>> +      - 'AV01'
>> +      - AV1 compressed video frame. This format is adapted for implementing AV1
>> +        pipeline. The decoder implements stateful video decoder and expects one
>> +        Temporal Unit per buffer from OBU Stream.
> This should be something like, "one temporal unit per buffer in OBU stream
> format."
>
> Nicolas
Updated in v7. Thank you.
>> +        The encoder generates one Temporal Unit per buffer.
>>   .. raw:: latex
>>   
>>       \normalsize
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index becd08fdbddb857f8f2bf205d2164dc6e20e80b2..cf0b71bbe0f9d397e1e6c88433a0fc3ba11fb947 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -775,6 +775,7 @@ struct v4l2_pix_format {
>>   #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
>>   #define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
>>   #define V4L2_PIX_FMT_AV1_FRAME v4l2_fourcc('A', 'V', '1', 'F') /* AV1 parsed frame */
>> +#define V4L2_PIX_FMT_AV1      v4l2_fourcc('A', 'V', '0', '1') /* AV1 */
>>   #define V4L2_PIX_FMT_SPK      v4l2_fourcc('S', 'P', 'K', '0') /* Sorenson Spark */
>>   #define V4L2_PIX_FMT_RV30     v4l2_fourcc('R', 'V', '3', '0') /* RealVideo 8 */
>>   #define V4L2_PIX_FMT_RV40     v4l2_fourcc('R', 'V', '4', '0') /* RealVideo 9 & 10 */

