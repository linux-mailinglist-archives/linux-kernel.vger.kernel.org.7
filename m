Return-Path: <linux-kernel+bounces-838595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C8DBAFAFC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 10:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ED267A2A5A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 08:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C18B28489B;
	Wed,  1 Oct 2025 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Aa6viHzH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569B526B2D5
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759307930; cv=none; b=AiTI6tZ3rH+Cb853n4wCsXXt5MjrJo5Eb2Wk1Ai/kULLLtPggMY3DgV+lIKlXAQZSy15u796pEOBWW8FfFtk2Y5v4o0HSNftqH5B0lkNJvwKaq07bt2AFWc71kP/Ivr4jIBzJhsTLEM4UR/g21u0+VH25HTCpxpoNKYGU2WcyDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759307930; c=relaxed/simple;
	bh=tT14GjbSJRvFF+tIRZgJtNJsNgpoXd6VVrHo2gUtSiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AGkHfeycdN2SHMJlU2Sn51afSysR5WcFf7YMocv0hoVl7lDHqbULtCwGDu+r5TxRvdLe4R1lza537tn14VFm+CP42XKWwOIIimtkHhmCnZ/TwXz2+MAdvIxyQMtK+JYS0rlFqMMcyWdQP+yXFQ9vSrM+Frfb02hEOLB6c9YSstk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Aa6viHzH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ULLqKx030612
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 08:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9sz1tlLQ73dBkAxnOqxNaDvr+X6sM47eAfXet/I+ACc=; b=Aa6viHzHyHcMOn+K
	1+zRQcTvagCfELsDb6xo5lqgHYU6y9m0NlJjGVlBChiL3Zp4qOTulC4lmGmKU8Bb
	O0MbHyneFXCljjYWKIogCpv0hJLggXJ3On6U/6Nzof4I0r+sbwaRU6Snzy37aDKO
	DRM9E989oTyjAYEXNFUH4bFflSL7H5f/wMsRi+3qc56ylmi9wa/W4pVMZ7owffB3
	CQQJBCY/rwG0t8WSTaZPpRnHpSiI/BvMtR7a36NnhXRJjxVIuZlxE03bRx0ZJXUE
	VDG9XCjgYY3zWPB7gCeFDmQhMKNUlCRiTYku+SPN7o8SGYcHSwan2xrqsfJ/vBQT
	TZajCA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8pdkmxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 08:38:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26985173d8eso126087085ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 01:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759307925; x=1759912725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sz1tlLQ73dBkAxnOqxNaDvr+X6sM47eAfXet/I+ACc=;
        b=nTKJ3a3LHLDWKMaU2/NiCqbPVsB+WjQ07AIA5lWsYvRPcNiYB5HkVfZVbypUwtq65T
         7isJWfVphCpwGUenVhrcd2WBKV0xGYJubRioB8lpIHZ6qV9K0NcsVcpp7wptXx1lDLdM
         t/OtBON04y2R5WEQQ+rwKQWGmhAdyYCVPECdDOy4NoVSnzbxaHik+uuJcmry2zzVUwE3
         kHf1gSalWt8xoM9b5Gy++AJfJWd9ifqT7CkHuPEs+PhGLU/fiAIgDaHtkJ/SjImyUqSq
         Sq11JwoeGrhZrOWF3Zb60Hb0uQM+Zbe4r0CkYjK8gRaKS02NpMF5fZDNyKZI/AnZRl/e
         1e5A==
X-Forwarded-Encrypted: i=1; AJvYcCUhllUiXko5el3EjFAqTSQgVdmc/LSi0gonZs6VIiZcQ+9Y8p7V9d/JJuPlmDFMijWoBgJ7iTGpuVh1MWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4lnaO55qu8XrY+4kWq2SiUDhjTtWKSX9UUiQzSmC6Y8sQ0Vh
	h9gt54f2TcZ8XcM+78JU8SOftiJaH6Rp5Ir8ZURj+Sux6tUqNKPZSGz7REMQusP+fEGo0lVg05L
	zYxO0+86Fi4Jn6NaJM1taaeca6JmYB/DYYLCVQTZclyN/fFCfs5webXaKsXRoYsuv3V4=
X-Gm-Gg: ASbGncvDvjDFsWQ9hxXMcIQ98E2hzHTgK8IWtjiHx+kG5DKrF1bD2qswFYxwJWqVLtc
	IyLjEDql19TrqBCnlEQs4UFoosPdzIRsFvPDPOT9SzN+dm5puXJ96so6aoocVqJWrykPDl5buCX
	1SgY333vo08sphPVcj/uGlN/N8lwVtsEYSaQRN39TjUPt/QM2UeOZlpghhNxPqRqr09b4cdZuZJ
	voetDifLPqd2YzXXFPk24O3VadCGq9G+hAgXywGUI29x7Pzlid+xuRbgp1p7qEuCzM4qnrkD36c
	moM57accyGFCWXcuXVe2W+o4V6UZEWArynO4rFrcIVJJVmo//E+eyFsSVVXjIcpnb4lkUNI4yGx
	E/yo=
X-Received: by 2002:a17:902:ce12:b0:267:a55a:8684 with SMTP id d9443c01a7336-28e7f2a12e8mr37876485ad.2.1759307925231;
        Wed, 01 Oct 2025 01:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqxKH7ov1nye79QP0WmmWH0xeQOVkq2I/SI5avXaMOOsQbhEBvLKocBes9EI7crrMSnrN9PQ==
X-Received: by 2002:a17:902:ce12:b0:267:a55a:8684 with SMTP id d9443c01a7336-28e7f2a12e8mr37876115ad.2.1759307924680;
        Wed, 01 Oct 2025 01:38:44 -0700 (PDT)
Received: from [10.0.0.86] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69bd869sm181660975ad.120.2025.10.01.01.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:38:44 -0700 (PDT)
Message-ID: <10bb819d-105b-5471-b3a6-774fce134eb6@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 14:08:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] media: iris: Add support for QC08C format for decoder
Content-Language: en-US
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250919-video-iris-ubwc-enable-v1-0-000d11edafd8@oss.qualcomm.com>
 <OyMR2y907eHs6rnnO6bzy52LY_t8KXKscM-nTPu48x3NCYFU4mza-uz0HqnQlYqPg2JtDB8AhCtGAa26Cbq4PA==@protonmail.internalid>
 <20250919-video-iris-ubwc-enable-v1-1-000d11edafd8@oss.qualcomm.com>
 <27e36fdb-3107-4e7b-b402-fd72ea5c4d61@kernel.org>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <27e36fdb-3107-4e7b-b402-fd72ea5c4d61@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: b6OR1JlfDyBpxt9SXV3iASax0AiUHTFA
X-Authority-Analysis: v=2.4 cv=MYZhep/f c=1 sm=1 tr=0 ts=68dce896 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8
 a=u9E7l7EWuVC1dSZ7WYIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: b6OR1JlfDyBpxt9SXV3iASax0AiUHTFA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzNiBTYWx0ZWRfX4hLejAfrarI3
 ldHK6vlAiNmBy5CjTWEprQFwBxgfa2FOWf+5dIYw2eCbvwNXkZlxdbBIEA1MSgY28DE//osyZgj
 H3MHMheCZMxs+ScPnx2bWsuz8j2yh3+tTiOJuP9nlxEUndnJoqrVaygvxmrD2Lu0+UKWnY73sz1
 Icdk2rmeR9O2RFUEm+ioc28WUvajmYZ+bcTDDC3wdgBCu96I0JJb2S1ijsPZYDRkd6ZyeKqZzf7
 ngA7rN3KyRtEjCsSu11jXHZmiSA0tSuZjbjLn1/WFXo1T0+CXTUkxyyaB9CBOjLpQ4Iln7Pfbjy
 ymUHcrKi4YjcE+H3SJNydJvQmHQKdC0zxhkLOKt+c2ze23BpZB/gcml5ZlxHqLKKhSxA/RK+TqO
 d8kp+sPmqQkqB8GfcYqwujAJg7+Iyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270036



On 9/24/2025 6:58 PM, Bryan O'Donoghue wrote:
> On 19/09/2025 16:47, Dikshita Agarwal wrote:
>> Introduce handling for the QC08C format in the decoder.
>> Update format checks and configuration to enable decoding of QC08C
>> streams.
> 
> Since QC08C is a Qualcomm specific pixel format, you should detail in your
> commit log exactly what the packing/ordering of pixels is.

I am just enabling support for QC08C format with this patch in iris driver
not defining it. The format is already described in v4l2 spec and the
packing is explained in detail[1]

[1]
https://elixir.bootlin.com/linux/v6.17-rc2/source/drivers/media/platform/qcom/iris/iris_buffer.c#L79

The only difference is, earlier it was enabled for interanl reference
buffers while this patch enables it for OPB (Output picture buffer) which
is used for display.

> 
> In other words tell the reader more about QC08C.
> 
>>
>> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
>> ---
>>   drivers/media/platform/qcom/iris/iris_buffer.c     |  5 +-
>>   .../platform/qcom/iris/iris_hfi_gen1_command.c     | 12 +++--
>>   .../platform/qcom/iris/iris_hfi_gen2_command.c     | 18 ++++++-
>>   .../platform/qcom/iris/iris_hfi_gen2_defines.h     |  1 +
>>   drivers/media/platform/qcom/iris/iris_instance.h   |  7 ++-
>>   .../media/platform/qcom/iris/iris_platform_gen2.c  |  1 +
>>   drivers/media/platform/qcom/iris/iris_utils.c      |  3 +-
>>   drivers/media/platform/qcom/iris/iris_vdec.c       | 61
>> ++++++++++++++++++----
>>   8 files changed, 89 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c
>> b/drivers/media/platform/qcom/iris/iris_buffer.c
>> index
>> c0900038e7defccf7de3cb60e17c71e36a0e8ead..83dcf49e57ec1473bc4edd26c48ab0b247d23818 100644
>> --- a/drivers/media/platform/qcom/iris/iris_buffer.c
>> +++ b/drivers/media/platform/qcom/iris/iris_buffer.c
>> @@ -261,7 +261,10 @@ int iris_get_buffer_size(struct iris_inst *inst,
>>           case BUF_INPUT:
>>               return iris_dec_bitstream_buffer_size(inst);
>>           case BUF_OUTPUT:
>> -            return iris_yuv_buffer_size_nv12(inst);
>> +            if (inst->fmt_dst->fmt.pix_mp.pixelformat ==
>> V4L2_PIX_FMT_QC08C)
> 
> It'd be nice to get a pointer to the final level of indireciton you need
> generally, instead of these very->long->lists->of.indirections.

yeah, following the same in other parts of the code.
Here in this API, it is used only once that's why used directly.

> 
> Please consider getting a final pointer as much as possible especially in
> functions where you end up writing those long chains over and over again.
> 
>> +                return iris_yuv_buffer_size_qc08c(inst);
>> +            else
>> +                return iris_yuv_buffer_size_nv12(inst);
>>           case BUF_DPB:
>>               return iris_yuv_buffer_size_qc08c(inst);
>>           default:
>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
>> b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
>> index
>> e1788c266bb1080921f17248fd5ee60156b3143d..e458d3349ce09aadb75d056ae84e3aab95f03078 100644
>> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
>> @@ -774,20 +774,21 @@ static int iris_hfi_gen1_set_raw_format(struct
>> iris_inst *inst, u32 plane)
>>           pixelformat = inst->fmt_dst->fmt.pix_mp.pixelformat;
>>           if (iris_split_mode_enabled(inst)) {
>>               fmt.buffer_type = HFI_BUFFER_OUTPUT;
>> -            fmt.format = pixelformat == V4L2_PIX_FMT_NV12 ?
>> -                HFI_COLOR_FORMAT_NV12_UBWC : 0;
>> +            fmt.format = HFI_COLOR_FORMAT_NV12_UBWC;
>>
>>               ret = hfi_gen1_set_property(inst, ptype, &fmt, sizeof(fmt));
>>               if (ret)
>>                   return ret;
>>
>>               fmt.buffer_type = HFI_BUFFER_OUTPUT2;
>> -            fmt.format = pixelformat == V4L2_PIX_FMT_NV12 ?
>> HFI_COLOR_FORMAT_NV12 : 0;
>> +            fmt.format = pixelformat == V4L2_PIX_FMT_NV12 ?
>> +                HFI_COLOR_FORMAT_NV12 : HFI_COLOR_FORMAT_NV12_UBWC;
>>
>>               ret = hfi_gen1_set_property(inst, ptype, &fmt, sizeof(fmt));
>>           } else {
>>               fmt.buffer_type = HFI_BUFFER_OUTPUT;
>> -            fmt.format = pixelformat == V4L2_PIX_FMT_NV12 ?
>> HFI_COLOR_FORMAT_NV12 : 0;
>> +            fmt.format = pixelformat == V4L2_PIX_FMT_NV12 ?
>> +                HFI_COLOR_FORMAT_NV12 : HFI_COLOR_FORMAT_NV12_UBWC;
>>
>>               ret = hfi_gen1_set_property(inst, ptype, &fmt, sizeof(fmt));
>>           }
>> @@ -806,6 +807,9 @@ static int
>> iris_hfi_gen1_set_format_constraints(struct iris_inst *inst, u32 plan
>>       const u32 ptype =
>> HFI_PROPERTY_PARAM_UNCOMPRESSED_PLANE_ACTUAL_CONSTRAINTS_INFO;
>>       struct hfi_uncompressed_plane_actual_constraints_info pconstraint;
>>
>> +    if (inst->fmt_dst->fmt.pix_mp.pixelformat == V4L2_PIX_FMT_QC08C)
>> +        return 0;
>> +
>>       pconstraint.buffer_type = HFI_BUFFER_OUTPUT2;
>>       pconstraint.num_planes = 2;
>>       pconstraint.plane_format[0].stride_multiples = 128;
>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
>> b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
>> index
>> 4ce71a14250832440099e4cf3835b4aedfb749e8..5ad202d3fcdc57a2b7b43de15763a686ce0f7bd7 100644
>> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
>> @@ -422,6 +422,20 @@ static int iris_hfi_gen2_set_level(struct iris_inst
>> *inst, u32 plane)
>>                             sizeof(u32));
>>   }
>>
>> +static int iris_hfi_gen2_set_opb_enable(struct iris_inst *inst, u32 plane)
>> +{
>> +    u32 port = iris_hfi_gen2_get_port(inst, plane);
>> +    u32 opb_enable = iris_split_mode_enabled(inst);
>> +
>> +    return iris_hfi_gen2_session_set_property(inst,
>> +                          HFI_PROP_OPB_ENABLE,
>> +                          HFI_HOST_FLAGS_NONE,
>> +                          port,
>> +                          HFI_PAYLOAD_U32,
>> +                          &opb_enable,
>> +                          sizeof(u32));
>> +}
>> +
>>   static int iris_hfi_gen2_set_colorformat(struct iris_inst *inst, u32
>> plane)
>>   {
>>       u32 port = iris_hfi_gen2_get_port(inst, plane);
>> @@ -429,7 +443,8 @@ static int iris_hfi_gen2_set_colorformat(struct
>> iris_inst *inst, u32 plane)
>>
>>       if (inst->domain == DECODER) {
>>           pixelformat = inst->fmt_dst->fmt.pix_mp.pixelformat;
>> -        hfi_colorformat = pixelformat == V4L2_PIX_FMT_NV12 ?
>> HFI_COLOR_FMT_NV12 : 0;
>> +        hfi_colorformat = pixelformat == V4L2_PIX_FMT_NV12 ?
>> +            HFI_COLOR_FMT_NV12 : HFI_COLOR_FMT_NV12_UBWC;
>>       } else {
>>           pixelformat = inst->fmt_src->fmt.pix_mp.pixelformat;
>>           hfi_colorformat = pixelformat == V4L2_PIX_FMT_NV12 ?
>> HFI_COLOR_FMT_NV12 : 0;
>> @@ -527,6 +542,7 @@ static int
>> iris_hfi_gen2_session_set_config_params(struct iris_inst *inst, u32 p
>>           {HFI_PROP_SIGNAL_COLOR_INFO,         
>> iris_hfi_gen2_set_colorspace             },
>>           {HFI_PROP_PROFILE,                   
>> iris_hfi_gen2_set_profile                },
>>           {HFI_PROP_LEVEL,                     
>> iris_hfi_gen2_set_level                  },
>> +        {HFI_PROP_OPB_ENABLE,                
>> iris_hfi_gen2_set_opb_enable             },
> 
> 
> As I read this code I end up asking myself "what does OPB" mean ?
> 
> For preference the introduction of OPB would be its own patch with its own
> commit log that explains OPB as an individual thing.
> 
> You can enable your QC08C format as an additional step.
> 
> 
>>           {HFI_PROP_COLOR_FORMAT,              
>> iris_hfi_gen2_set_colorformat            },
>>           {HFI_PROP_LINEAR_STRIDE_SCANLINE,    
>> iris_hfi_gen2_set_linear_stride_scanline },
>>           {HFI_PROP_TIER,                      
>> iris_hfi_gen2_set_tier                   },
>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
>> b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
>> index
>> aa1f795f5626c1f76a32dd650302633877ce67be..1b6a4dbac828ffea53c1be0d3624a033c283c972 100644
>> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_defines.h
>> @@ -91,6 +91,7 @@ enum hfi_seq_header_mode {
>>   #define HFI_PROP_BUFFER_MARK            0x0300016c
>>   #define HFI_PROP_RAW_RESOLUTION        0x03000178
>>   #define HFI_PROP_TOTAL_PEAK_BITRATE        0x0300017C
>> +#define HFI_PROP_OPB_ENABLE            0x03000184
>>   #define HFI_PROP_COMV_BUFFER_COUNT        0x03000193
>>   #define HFI_PROP_END                0x03FFFFFF
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_instance.h
>> b/drivers/media/platform/qcom/iris/iris_instance.h
>> index
>> 5982d7adefeab80905478b32cddba7bd4651a691..11134f75c26dd1f6c92ba72fbf4e56e41a72de64 100644
>> --- a/drivers/media/platform/qcom/iris/iris_instance.h
>> +++ b/drivers/media/platform/qcom/iris/iris_instance.h
>> @@ -15,12 +15,17 @@
>>   #define DEFAULT_WIDTH 320
>>   #define DEFAULT_HEIGHT 240
>>
>> -enum iris_fmt_type {
>> +enum iris_fmt_type_out {
>>       IRIS_FMT_H264,
>>       IRIS_FMT_HEVC,
>>       IRIS_FMT_VP9,
>>   };
>>
>> +enum iris_fmt_type_cap {
>> +    IRIS_FMT_NV12,
>> +    IRIS_FMT_UBWC,
>> +};
>> +
>>   struct iris_fmt {
>>       u32 pixfmt;
>>       u32 type;
>> diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
>> b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
>> index
>> 36d69cc73986b74534a2912524c8553970fd862e..69c952c68e939f305f25511e2e4763487ec8e0de 100644
>> --- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
>> +++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
>> @@ -691,6 +691,7 @@ static const u32 sm8550_venc_input_config_params[] = {
>>   };
>>
>>   static const u32 sm8550_vdec_output_config_params[] = {
>> +    HFI_PROP_OPB_ENABLE,
>>       HFI_PROP_COLOR_FORMAT,
>>       HFI_PROP_LINEAR_STRIDE_SCANLINE,
>>   };
>> diff --git a/drivers/media/platform/qcom/iris/iris_utils.c
>> b/drivers/media/platform/qcom/iris/iris_utils.c
>> index
>> 85c70a62b1fd2c409fc18b28f64771cb0097a7fd..e2f1131de43128254d8211343771e657e425541e 100644
>> --- a/drivers/media/platform/qcom/iris/iris_utils.c
>> +++ b/drivers/media/platform/qcom/iris/iris_utils.c
>> @@ -34,7 +34,8 @@ int iris_get_mbpf(struct iris_inst *inst)
>>
>>   bool iris_split_mode_enabled(struct iris_inst *inst)
>>   {
>> -    return inst->fmt_dst->fmt.pix_mp.pixelformat == V4L2_PIX_FMT_NV12;
>> +    return inst->fmt_dst->fmt.pix_mp.pixelformat == V4L2_PIX_FMT_NV12 ||
>> +        inst->fmt_dst->fmt.pix_mp.pixelformat == V4L2_PIX_FMT_QC08C;
>>   }
>>
>>   void iris_helper_buffers_done(struct iris_inst *inst, unsigned int type,
>> diff --git a/drivers/media/platform/qcom/iris/iris_vdec.c
>> b/drivers/media/platform/qcom/iris/iris_vdec.c
>> index
>> ae13c3e1b426bfd81a7b46dc6c3ff5eb5c4860cb..7fa745c6bf8950d192c2d2fc1770c4b6fd7b8c4c 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vdec.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vdec.c
>> @@ -67,7 +67,7 @@ void iris_vdec_inst_deinit(struct iris_inst *inst)
>>       kfree(inst->fmt_src);
>>   }
>>
>> -static const struct iris_fmt iris_vdec_formats[] = {
>> +static const struct iris_fmt iris_vdec_formats_out[] = {
>>       [IRIS_FMT_H264] = {
>>           .pixfmt = V4L2_PIX_FMT_H264,
>>           .type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>> @@ -82,12 +82,35 @@ static const struct iris_fmt iris_vdec_formats[] = {
>>       },
>>   };
>>
>> +static const struct iris_fmt iris_vdec_formats_cap[] = {
>> +    [IRIS_FMT_NV12] = {
>> +        .pixfmt = V4L2_PIX_FMT_NV12,
>> +        .type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>> +    },
>> +    [IRIS_FMT_UBWC] = {
>> +        .pixfmt = V4L2_PIX_FMT_QC08C,
>> +        .type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>> +    },
>> +};
>> +
>>   static const struct iris_fmt *
>>   find_format(struct iris_inst *inst, u32 pixfmt, u32 type)
>>   {
>> -    unsigned int size = ARRAY_SIZE(iris_vdec_formats);
>> -    const struct iris_fmt *fmt = iris_vdec_formats;
>> +    const struct iris_fmt *fmt = NULL;
>> +    unsigned int size = 0;
>>       unsigned int i;
>> +    switch (type) {
>> +    case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>> +        fmt = iris_vdec_formats_out;
>> +        size = ARRAY_SIZE(iris_vdec_formats_out);
>> +        break;
>> +    case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>> +        fmt = iris_vdec_formats_cap;
>> +        size = ARRAY_SIZE(iris_vdec_formats_cap);
>> +        break;
>> +    default:
>> +        return NULL;
>> +    }
>>
>>       for (i = 0; i < size; i++) {
>>           if (fmt[i].pixfmt == pixfmt)
>> @@ -103,8 +126,21 @@ find_format(struct iris_inst *inst, u32 pixfmt, u32
>> type)
>>   static const struct iris_fmt *
>>   find_format_by_index(struct iris_inst *inst, u32 index, u32 type)
>>   {
>> -    const struct iris_fmt *fmt = iris_vdec_formats;
>> -    unsigned int size = ARRAY_SIZE(iris_vdec_formats);
>> +    const struct iris_fmt *fmt = NULL;
>> +    unsigned int size = 0;
>> +
>> +    switch (type) {
>> +    case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>> +        fmt = iris_vdec_formats_out;
>> +        size = ARRAY_SIZE(iris_vdec_formats_out);
>> +        break;
>> +    case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>> +        fmt = iris_vdec_formats_cap;
>> +        size = ARRAY_SIZE(iris_vdec_formats_cap);
>> +        break;
>> +    default:
>> +        return NULL;
>> +    }
>>
>>       if (index >= size || fmt[index].type != type)
>>           return NULL;
>> @@ -126,9 +162,10 @@ int iris_vdec_enum_fmt(struct iris_inst *inst,
>> struct v4l2_fmtdesc *f)
>>           f->flags = V4L2_FMT_FLAG_COMPRESSED |
>> V4L2_FMT_FLAG_DYN_RESOLUTION;
>>           break;
>>       case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>> -        if (f->index)
>> +        fmt = find_format_by_index(inst, f->index, f->type);
>> +        if (!fmt)
>>               return -EINVAL;
>> -        f->pixelformat = V4L2_PIX_FMT_NV12;
>> +        f->pixelformat = fmt->pixfmt;
>>           break;
>>       default:
>>           return -EINVAL;
>> @@ -157,7 +194,7 @@ int iris_vdec_try_fmt(struct iris_inst *inst, struct
>> v4l2_format *f)
>>           }
>>           break;
>>       case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>> -        if (f->fmt.pix_mp.pixelformat != V4L2_PIX_FMT_NV12) {
>> +        if (!fmt) {
>>               f_inst = inst->fmt_dst;
>>               f->fmt.pix_mp.pixelformat = f_inst->fmt.pix_mp.pixelformat;
>>               f->fmt.pix_mp.width = f_inst->fmt.pix_mp.width;
>> @@ -238,10 +275,11 @@ int iris_vdec_s_fmt(struct iris_inst *inst, struct
>> v4l2_format *f)
>>           inst->crop.height = f->fmt.pix_mp.height;
>>           break;
>>       case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
>> +        if (!(find_format(inst, f->fmt.pix_mp.pixelformat, f->type)))
>> +            return -EINVAL;
>> +
>>           fmt = inst->fmt_dst;
>>           fmt->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
>> -        if (fmt->fmt.pix_mp.pixelformat != V4L2_PIX_FMT_NV12)
>> -            return -EINVAL;
>>           fmt->fmt.pix_mp.pixelformat = f->fmt.pix_mp.pixelformat;
>>           fmt->fmt.pix_mp.width = ALIGN(f->fmt.pix_mp.width, 128);
>>           fmt->fmt.pix_mp.height = ALIGN(f->fmt.pix_mp.height, 32);
>> @@ -268,7 +306,8 @@ int iris_vdec_validate_format(struct iris_inst *inst,
>> u32 pixelformat)
>>   {
>>       const struct iris_fmt *fmt = NULL;
>>
>> -    if (pixelformat != V4L2_PIX_FMT_NV12) {
>> +    fmt = find_format(inst, pixelformat,
>> V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
>> +    if (!fmt) {
>>           fmt = find_format(inst, pixelformat,
>> V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
>>           if (!fmt)
>>               return -EINVAL;
>>
>> -- 
>> 2.34.1
>>
> 

