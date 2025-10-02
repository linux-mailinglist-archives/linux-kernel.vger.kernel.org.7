Return-Path: <linux-kernel+bounces-840702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91116BB5046
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E62E18936D7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA328724E;
	Thu,  2 Oct 2025 19:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GJcB7/+1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B8255F3F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433840; cv=none; b=NSGlvCaEwRo1kELjcQV24M0VIW0iMUmPxHCWvWNQFQVRtwtKfqA3wDzhcKgyThTB19lYIE2JA8tvkuE5UPPHaG1CljdWQmJlqnoB3WwKr5V8AdaHnYhyemJWrqMVwIt6DPJsvLBkY0c2ZMFh9vYqdmAtA5EmbQ/w3+B5IDbqyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433840; c=relaxed/simple;
	bh=fSO8CvA3pCTMDoPptUgMnTwph9BJB+1IvdM+4Xco5UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RXxsWVkjb7QsYANsZjCqyCvg+K1IKyzBp0QLM1bUt2bs3GycT0BIThPgw92e8p5Rnt2Yj1LtvdS8w1Gi3FJZPkkS2AYKoS2waslm8QsLehgVWO5laE0gUN69NQ45rPuBoDWAbuRAUSbvQqhI5b54SYlGoPQKHQmUlFOOVF7mOQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GJcB7/+1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59298nFF031548
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 19:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	41mUsnB3TY6EVy7eiG4ANAThuUGl4wFuILLk8njZ6ng=; b=GJcB7/+1vEB5u5w5
	x60BED/94LeeoGJzgK2xzWceLb2CRDR8GHI5PsmKHGFLlr5OKS5dyXpyN8FTwlBU
	vTgGZ5et3QCVYoN2blouwq0IArLH9bTkDomQN6eZ5Ov5qdopx1VLgEAahPcAIAuB
	DKK0KxAy+wxVAprPJQD9rC8M5O6kixQPVKHUYBC9mVPVdantOf5FbnTKyss70H5G
	WNnQEYLuCY861jMbVtWEtOHYbRxNfMkXK0akwx4sYtjaNAavBTQ/mHe8NNlVgrfJ
	EIYPMToriRQZVhWty5VNyD4KQcubhZYOZHytEvEfs2sEwuJhWYaFPcJ1/MbQ9B8I
	n5Pnmg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr8tgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 19:37:17 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7841da93b8dso435313b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759433836; x=1760038636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=41mUsnB3TY6EVy7eiG4ANAThuUGl4wFuILLk8njZ6ng=;
        b=fJAuSHf+DFe2HowTdB7x3xocL+35DuL9jwxlDJzbusfKscpdYHvvqgPpWTOQ9s/Jdd
         jd3H58yxn4FJc9OfQhi4hxDv1+bWhmg9RaZA8K1Od9ii0JDmdvyaXBVsN6oxg63Glujj
         /AqOYFSZTWdDPINVJb2YPfQzvJJXiDNq2O4RFSqeZ5LitGgyzkIw7n16+cXI52146Hk4
         H1MBnF38BavPgAjsSTDKtsvuVyArP9+f9cNydiyBi5+P/jvRLT3hDUdH1CjcUFeuy4cn
         EPUd334rKmK2E7gM7M5v1VYuy0tf38Iq8E7k03rJyfrdulLr0SZZjNJcotsSYsonwI2L
         WIkg==
X-Forwarded-Encrypted: i=1; AJvYcCX2OfRUB09iBrwvQqJmujjrM/a/07/4bUyXlKSyQaUVNEzuH+Jh5XHtbxhEACw1/O8+9QdqFSXBS5D1dZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxND19VdTKJ0o03SQYvpRCMevN5i7srOLgL8/q5kcc4MIZz8umW
	DNXgJ3LZVWxvVZUBdYhXDvQ4qRUSZFoXeufI5Lv9nQGastYFqGOsRi3o7L2bWlgLfCA61uviP/V
	Or54WSDV9TD0DyqrxaRbP4/g31KuZ/WL678d1gah2Li4GHESqMVD0jkt46dQEvZas0lM=
X-Gm-Gg: ASbGncu8MkSJAKccKX0dByuHyaUlohnHJ/4awsry0kxITFCmW4YTtGnVSXAuS1ZJbex
	ogpeirXLaq94ac5lOvVmJzNiWrKekMzWVUjPKwtFJIckgDKzWYqwg2JMQLO2z6IeLMOZ/mzsSRU
	7N//YswJXENqSWDA/PPoZMcgB13ZdCPSTFlbyvwmv63gOZuruEUnUNbTARdjSMJ8EYyLHc05rCV
	WsZYhU6mwd3ub+8ABF9ZhaNnOALIHOl4etJrWf0L+AEB5LmpULcTS9sRCM4lV0QXQ2SzGG3pGbW
	RQkNtaSHlDn+99hizGIKlj+P1G7z0vHUzJEYPxF+VmJq1Yo0MbPbg9yFV98wmxhYZW8x8BIqXiH
	BFwFwM0fEuVlXAIGgVxWFYHD0H51NcWQA
X-Received: by 2002:a05:6a00:b8c:b0:781:2177:1ca3 with SMTP id d2e1a72fcca58-78c98df574bmr376296b3a.6.1759433836079;
        Thu, 02 Oct 2025 12:37:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYwgFwYPHSkxTVgMbR3ecJssERdk9ryMJd9NIRHusph0Tnr0DlMI3WgoZ5RUECPXxU7TeL3A==
X-Received: by 2002:a05:6a00:b8c:b0:781:2177:1ca3 with SMTP id d2e1a72fcca58-78c98df574bmr376268b3a.6.1759433835415;
        Thu, 02 Oct 2025 12:37:15 -0700 (PDT)
Received: from [10.71.110.242] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9a364sm2837840b3a.6.2025.10.02.12.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 12:37:15 -0700 (PDT)
Message-ID: <970f0c9a-a8ef-4899-baa3-83f92d261ba8@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 12:37:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] media: iris: Add internal buffer calculation for AV1
 decoder
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
        Bryan O'Donoghue
 <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20251001-av1_irisdecoder-v1-0-9fb08f3b96a0@oss.qualcomm.com>
 <mbltuHnjNkwD91EqWND77oi8XN26tEarsTmT_fLVkZQYkc7-V_RpAVWo8KC8AnzeyV74zXurscVRHHfAL35xFw==@protonmail.internalid>
 <20251001-av1_irisdecoder-v1-5-9fb08f3b96a0@oss.qualcomm.com>
 <e273f195-fb5e-4b4f-bf97-63ea51ed875f@kernel.org>
 <ec3e93e72e326db4e61fed33ade0547935ab6dca.camel@ndufresne.ca>
Content-Language: en-US
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
In-Reply-To: <ec3e93e72e326db4e61fed33ade0547935ab6dca.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cvdAbgeLMSo2gwX4Z8U3xd2H01isAtkt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX/o0Wxr5rLAjy
 pnW+p+fk8LxgLsR9Ctiigie/Csaw7WDItt9llfRI9sKVtMf6xXhbNqGn9ZsWuVStMP0qDs2UZu3
 Sdjl8O/gC+D7z4p+aly+4cE2WTGkCfx6NkKRPzjgLAknLmj6BvTAKH+1KZKowAHdW3xZZlxjTie
 TTyrijXBl5nnzbpLzDNk8WjZXPgMD02lRtmgC++da+Gdn4HwhajNa/S38GxEqkxxdvvroSkfkWH
 MohBbRHhx6ibfexqqMsWGkKKb2HPFonvK6BW+reneIGn4bjHHiPsXvusljSOMabB0/lc/sdnced
 gzmmev+d2VdXqZmqhBim4jCQ26YO2vX/HZ/le0FTzvtNJfz2dlj7xfa1d4FGFWqLwgs5RbwsPy7
 BpMu/r1a6c9Sk9XMdbrSuS0lpjwKOw==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68ded46d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=wbe282U9EvkHtdHFx4cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: cvdAbgeLMSo2gwX4Z8U3xd2H01isAtkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017


On 10/2/2025 5:38 AM, Nicolas Dufresne wrote:
> Hi,
>
> Le jeudi 02 octobre 2025 à 00:30 +0100, Bryan O'Donoghue a écrit :
>> On 01/10/2025 20:00, Deepa Guthyappa Madivalara wrote:
>>> Implement internal buffer count and size calculations for AV1 decoder.
>>>
>>> Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
>>> ---
>>>    drivers/media/platform/qcom/iris/iris_buffer.h     |   1 +
>>>    .../platform/qcom/iris/iris_hfi_gen2_command.c     |   1 -
>>>    drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 255 ++++++++++++++++++++-
>>>    drivers/media/platform/qcom/iris/iris_vpu_buffer.h | 105 +++++++++
>>>    4 files changed, 357 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/iris/iris_buffer.h b/drivers/media/platform/qcom/iris/iris_buffer.h
>>> index 5ef365d9236c7cbdee24a4614789b3191881968b..75bb767761824c4c02e0df9b765896cc093be333 100644
>>> --- a/drivers/media/platform/qcom/iris/iris_buffer.h
>>> +++ b/drivers/media/platform/qcom/iris/iris_buffer.h
>>> @@ -27,6 +27,7 @@ struct iris_inst;
>>>     * @BUF_SCRATCH_1: buffer to store decoding/encoding context data for HW
>>>     * @BUF_SCRATCH_2: buffer to store encoding context data for HW
>>>     * @BUF_VPSS: buffer to store VPSS context data for HW
>>> + * @BUF_PARTIAL: buffer for AV1 IBC data
>>>     * @BUF_TYPE_MAX: max buffer types
>>>     */
>>>    enum iris_buffer_type {
>>> diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
>>> index e3a8b031b3f191a6d18e1084db34804a8172439c..000bf75ba74ace5e10585910cda02975b0c34304 100644
>>> --- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
>>> +++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
>>> @@ -488,7 +488,6 @@ static int iris_hfi_gen2_set_linear_stride_scanline(struct iris_inst *inst, u32
>>>
>>>    static int iris_hfi_gen2_set_tier(struct iris_inst *inst, u32 plane)
>>>    {
>>> -	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
>>>    	u32 port = iris_hfi_gen2_get_port(inst, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
>>>    	u32 tier = inst->fw_caps[TIER].value;
>>>
>>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
>>> index 4463be05ce165adef6b152eb0c155d2e6a7b3c36..17d3a7ae79e994257d596906cb4c17250a11a0cb 100644
>>> --- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
>>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
>>> @@ -9,6 +9,14 @@
>>>    #include "iris_hfi_gen2_defines.h"
>>>
>>>    #define HFI_MAX_COL_FRAME 6
>>> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_HEIGHT (8)
>>> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_Y_TILE_WIDTH (32)
>>> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_HEIGHT (8)
>>> +#define HFI_COLOR_FORMAT_YUV420_NV12_UBWC_UV_TILE_WIDTH (16)
>>> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_Y_TILE_HEIGHT (4)
>>> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_Y_TILE_WIDTH (48)
>>> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_UV_TILE_HEIGHT (4)
>>> +#define HFI_COLOR_FORMAT_YUV420_TP10_UBWC_UV_TILE_WIDTH (24)
>>>
>>>    #ifndef SYSTEM_LAL_TILE10
>>>    #define SYSTEM_LAL_TILE10 192
>>> @@ -39,6 +47,31 @@ static u32 hfi_buffer_bin_h264d(u32 frame_width, u32 frame_height, u32 num_vpp_p
>>>    	return size_h264d_hw_bin_buffer(n_aligned_w, n_aligned_h, num_vpp_pipes);
>>>    }
>>>
>>> +static u32 size_av1d_hw_bin_buffer(u32 frame_width, u32 frame_height, u32 num_vpp_pipes)
>>> +{
>>> +	u32 size_yuv, size_bin_hdr, size_bin_res;
>>> +
>>> +	size_yuv = ((frame_width * frame_height) <= BIN_BUFFER_THRESHOLD) ?
>>> +		((BIN_BUFFER_THRESHOLD * 3) >> 1) :
>>> +		((frame_width * frame_height * 3) >> 1);
>>> +	size_bin_hdr = size_yuv * AV1_CABAC_HDR_RATIO_HD_TOT;
>>> +	size_bin_res = size_yuv * AV1_CABAC_RES_RATIO_HD_TOT;
>>> +	size_bin_hdr = ALIGN(size_bin_hdr / num_vpp_pipes,
>>> +			     DMA_ALIGNMENT) * num_vpp_pipes;
>>> +	size_bin_res = ALIGN(size_bin_res / num_vpp_pipes,
>>> +			     DMA_ALIGNMENT) * num_vpp_pipes;
>>> +
>>> +	return size_bin_hdr + size_bin_res;
>>> +}
>>> +
>>> +static u32 hfi_buffer_bin_av1d(u32 frame_width, u32 frame_height, u32 num_vpp_pipes)
>>> +{
>>> +	u32 n_aligned_h = ALIGN(frame_height, 16);
>>> +	u32 n_aligned_w = ALIGN(frame_width, 16);
>>> +
>>> +	return size_av1d_hw_bin_buffer(n_aligned_w, n_aligned_h, num_vpp_pipes);
>>> +}
>>> +
>>>    static u32 size_h265d_hw_bin_buffer(u32 frame_width, u32 frame_height, u32 num_vpp_pipes)
>>>    {
>>>    	u32 product = frame_width * frame_height;
>>> @@ -110,6 +143,20 @@ static u32 hfi_buffer_comv_h265d(u32 frame_width, u32 frame_height, u32 _comv_bu
>>>    	return (_size * (_comv_bufcount)) + 512;
>>>    }
>> What's this alignment stuffed onto the end about ?
>>
>> Please guys give these magic numbers meaningful names.
> That would be nice, then I'll be able to document that for Hantro AV1 decoder
> too. It was assumed when we picked the driver that the table was hardware
> specific, but if its not, a drivers/media/v4l2-core/v4l2-av1.c is welcome.
>
>>> drivers/media/platform/verisilicon/hantro_hw.h:555
> static inline size_t
> hantro_av1_mv_size(unsigned int width, unsigned int height)
> {
> 	size_t num_sbs = hantro_av1_num_sbs(width) * hantro_av1_num_sbs(height);
>
> 	return ALIGN(num_sbs * 384, 16) * 2 + 512;
> }
> +static u32 hfi_buffer_comv_av1d(u32 frame_width, u32 frame_height, u32 comv_bufcount)
> +{
> +	u32 size;
> +
> +	size =  2 * ALIGN(MAX(((frame_width + 63) / 64) *
> +		((frame_height + 63) / 64) * 512,
> This looks like div_round_up()  ?
>
>>> +		((frame_width + 127) / 128) *
>>> +		((frame_height + 127) / 128) * 2816),
>>> +		DMA_ALIGNMENT);
>>> +	size *= comv_bufcount;
>>
>> I'm sure this calculation is right and produces the correct value in all
>> instances - probably anyway but also does it ?
>>
>> It is not obvious looking at this code that it is obviously correct.
>>
>> I have a similar comment for alot of these Iris patches - we end up with
>> highly complex calculations using magic numbers which my guess would be
>> even people immersed in the firmware/driver/silicon development have a
>> hard time looking at and "just knowing" the code is correct.
>>
>> Please reduce these calculations down to some kind of define that - for
>> example an intelligent programmer - an oxymoron of a term I accept -
>> could read the code and actually understand what is going on.
>>
>> That programmer might even be yourself. You should be able to come along
>> in two, five, eight years time, look at a code snippet and pretty much
>> understand what it is doing and why without having to have a deep
>> epiphany when doing it.
>>
>> These complex clauses stuffed with magic numbers and sometimes bitshfts
>> with a few alignments thrown in for good measure are inscrutable.
> I agree with this, when the driver is not from the hardware maker, this can be
> justified, but since you have full access to the documentation and probably can
> ask the designers, it would be nicer to replace 64, 128, 512 and 2816 by named
> macro or const. Its not a blame, many drivers are like this already.
>
> Nicolas

Thank you for the feedback. I am working on making this as much clearer
as I can.

>>> +	return size;
>>> +}
>>> +
>>>    static u32 size_h264d_bse_cmd_buf(u32 frame_height)
>>>    {
>>>    	u32 height = ALIGN(frame_height, 32);
>>> @@ -174,6 +221,20 @@ static u32 hfi_buffer_persist_h264d(void)
>>>    		    DMA_ALIGNMENT);
>>>    }
>>>
>>> +static u32 hfi_buffer_persist_av1d(u32 max_width, u32 max_height, u32 total_ref_count)
>>> +{
>>> +	u32 comv_size, size;
>>> +
>>> +	comv_size =  hfi_buffer_comv_av1d(max_width, max_height, total_ref_count);
>>> +	size = ALIGN((SIZE_AV1D_SEQUENCE_HEADER * 2 + SIZE_AV1D_METADATA +
>>> +	AV1D_NUM_HW_PIC_BUF * (SIZE_AV1D_TILE_OFFSET + SIZE_AV1D_QM) +
>>> +	AV1D_NUM_FRAME_HEADERS * (SIZE_AV1D_FRAME_HEADER +
>>> +	2 * SIZE_AV1D_PROB_TABLE) + comv_size + HDR10_HIST_EXTRADATA_SIZE +
>>> +	SIZE_AV1D_METADATA * AV1D_NUM_HW_PIC_BUF), DMA_ALIGNMENT);
>>> +
>>> +	return ALIGN(size, DMA_ALIGNMENT);
>>> +}
>>> +
>>>    static u32 hfi_buffer_non_comv_h264d(u32 frame_width, u32 frame_height, u32 num_vpp_pipes)
>>>    {
>>>    	u32 size_bse = size_h264d_bse_cmd_buf(frame_height);
>>> @@ -459,6 +520,148 @@ static u32 hfi_buffer_line_h264d(u32 frame_width, u32 frame_height,
>>>    	return ALIGN((size + vpss_lb_size), DMA_ALIGNMENT);
>>>    }
>>>
>>> +static u32 size_av1d_lb_opb_wr1_nv12_ubwc(u32 frame_width, u32 frame_height)
>>> +{
>>> +	u32 y_width, y_width_a = 128;
>>> +
>>> +	y_width = ALIGN(frame_width, y_width_a);
>>> +
>>> +	return (256 * ((y_width + 31) / 32 + (AV1D_MAX_TILE_COLS - 1)));
>>> +}
>>> +
>>> +static u32 size_av1d_lb_opb_wr1_tp10_ubwc(u32 frame_width, u32 frame_height)
>>> +{
>>> +	u32 y_width, y_width_a = 256;
>>> +
>>> +	y_width = ALIGN(frame_width, 192);
>>> +	y_width = ALIGN(y_width * 4 / 3, y_width_a);
>>> +
>>> +	return (256 * ((y_width + 47) / 48 + (AV1D_MAX_TILE_COLS - 1)));
>> y_width is a thing times 4 divided by 3 aligned to 192.
>>
>> OK
>>
>> Then we return 256 * ((y_width + 47?) / 48 + (A_DEFINE_NICE - 1)));
>>
>> 47 ? The magic number in the routine above is 31.
>>
>> I don't think I'd be comfortable giving an RB for this. You guys need to
>> take steps to make your code more digestable - zapping the complex
>> bit-shifts and magic numbers.
>>
>> I don't see how a reviewer can really be expected to fit this into their
>> head and say "yep LGTM" needs to be decoded both for the sake of the
>> reviewer and for future coders, perhaps even future you trying to figure
>> out where the bug is..
>>
>> ---
>> bod

Understood, thank you.  I'm continuing to work on simplifying the code to
make it more meaningful.

Regards,
Deepa


