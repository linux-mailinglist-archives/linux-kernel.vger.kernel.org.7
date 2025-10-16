Return-Path: <linux-kernel+bounces-856072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2A5BE3024
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91841502948
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983A52FF663;
	Thu, 16 Oct 2025 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XydH7KLN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AD030BF53
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612797; cv=none; b=kRPNCEHdgHWOaHygwWOKFcbn61adiFDApLCBeKdVpesXUuXER6HeqXxymulyBwOBbQh8Il4XK6Lj8OEW8pydWkeLGQAhQe0wyokvN8vOZa6UtDWc/u1OrC4p17tOGabS4jK0/R46FlIqZXa8VIXsxyGRISiPl776+91SwJDkuxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612797; c=relaxed/simple;
	bh=iI6eQ4euIxUTVZlbEdBV/FiJUARLVqwn8IEP/AlBu6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sa+4M+RCn0+IWV2DQq/roBKNw1SYduGkeFeKVNaxLlOIhXeSvnce5PlxdO+tg8zDJHhdbEMuOHQwJfkQIcCzjO/D72Spk9yrurl6ZKIpgYQUKdJYVG7ZirsQO5G001LxPM2gzzkPoN5mVajXm3E3bf1qW/S5wjr1MYP4f0HqzSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XydH7KLN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G7B4fC003755
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5NX/KLfr6t5fxcfNm5GK/I/J8ryOwP+n8K6WCLUYwtQ=; b=XydH7KLNQXS3z9pE
	oNVUd6au1qgh8Z+8G1nxvAex6w2gdkOQtWxRP12mXABHT2Qyf0cDLFSVzoFsgl2P
	R6Tp4q5x2Li3LZlas6FUhGeCNZAiM9oEtShv1GEaRRxHQ6jQwRchPYzsM7CC/0cN
	4u8nDz9UXZ+s3c9Q8IdDGpcVwOofqxNYOht5F2i26300mqEp6IcD4g3CpcQRrNMN
	hMoCkXDuA/lbMSD8tsWwEIfx+cNduJ/wXF9Dpn1LSVXoNy55D8uE2LfOzU/JZpD5
	GJpGscRlsqqUcndUCXdFmVJ/1PGDf2WOqLwykS6OmnyCXrO5Atw/qp3VdEwLywBN
	OG3LyQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd984ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:06:35 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b552f91033cso856830a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 04:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760612795; x=1761217595;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NX/KLfr6t5fxcfNm5GK/I/J8ryOwP+n8K6WCLUYwtQ=;
        b=FEmx5QJ+hMr2I2I8gwZdfiHFeNFC55Po7QsxI74rakxMjvRX7+sipocXa7/01RKTE2
         SDTyaxmoiXkV54PNdZtEvX0pAWW3F3Tq4poydgbekR1IK3n0z1vrrk/SYNKXrYUC74wr
         9ByBUTHiRvWONdbhHG3yRkhZ4Tp8PfzIJJlC5cbA+pZZsHv+VTCca/itvUMeO7cSsHAR
         lCj6hMY42Hxuluhii6ZhTuSBLvFK/TaFxe/AakMDiInagHLhElwmICt1sEV9c8BF+Lui
         wZ8WNQoiYPvZKZ3EVQWGsmGCmSfBA+A/5RHJztc3LiGghlgjHKGAuuRq2iNL3DoWH2sZ
         M6dg==
X-Forwarded-Encrypted: i=1; AJvYcCUX9LOvOTZRDe/gY2ysMOrMqNL3Lktk6YGrht+MpZJJFm8hqUiDpiDYW2hqRdNa1h7FHndtMuX3qfy8D8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwayUqSIImQbIvPPvARcrf3JpJ0rJs0eAXezHrDsKQmoMrvZPxf
	1f6wasE/0tlByVsHt+fEkQkeAF9fJFXYdo4rfnTu+mA49y1U+tjcYyJKfudXS0zMk3MvSn/P+Y1
	0yOQ6cvpbJDPDpSXGkkTtuu0Hd1ac2j+xdqYqdYJNp3IdHzJMVv/m/cVCcBH1nIjvOIk=
X-Gm-Gg: ASbGncvexcQvxn0F6w2H+ynT6KkVvJhL4DmmrlI2RSOB1DtAyUKq1ck5l2tOokf97Zf
	mtzeeY5YrC3nL5Pn1maErkw5cmspfR3/p7zOyPe4Y5UfpopasbHN9h950wE5+as/P8buFxQjdrn
	sfHfOO+61jCyVCNZcLh/F6TxuWcGkGY3sZH18My9U0XsT2U5n18vHp5vtMec8Ea1YJqmoCW/AYK
	kKlkT9ER55nlvf8ZeJ7wjc6FViwq0ELvQZsBgwuaijUDbOnK7JFT4k+ZDnPdXIA6ksHUAGFsE2A
	GGTx2cgNty01R0GfONiEt/V7nJCP2axSz6ejvZGpGcfxsF4EEGYkMp/N+l3Cw5kH/qV1dBPNBAk
	ebsH/uDrVoBoAvpTl0ayzvpYxF3WHv3A=
X-Received: by 2002:a17:903:ac3:b0:272:dee1:c133 with SMTP id d9443c01a7336-2902723facfmr345507365ad.22.1760612794638;
        Thu, 16 Oct 2025 04:06:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/f/UbBVTHNDnGQhsb4+5hS3Sdx511yYCmnD+b86Jeb5QRzKzVrfCSD7m5ae31hSWsHCva3Q==
X-Received: by 2002:a17:903:ac3:b0:272:dee1:c133 with SMTP id d9443c01a7336-2902723facfmr345507005ad.22.1760612794142;
        Thu, 16 Oct 2025 04:06:34 -0700 (PDT)
Received: from [10.0.0.3] ([106.222.229.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099b0249asm26376145ad.109.2025.10.16.04.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 04:06:33 -0700 (PDT)
Message-ID: <d2e0935c-4794-e5de-4baf-7ac7c323eca9@oss.qualcomm.com>
Date: Thu, 16 Oct 2025 16:36:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] media: qcom: iris: Add sanity check for stop streaming
Content-Language: en-US
To: Wangao Wang <wangao.wang@oss.qualcomm.com>,
        vikash.garodia@oss.qualcomm.com, abhinav.kumar@linux.dev,
        bod@kernel.org, mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_qiweil@quicinc.com,
        quic_renjiang@quicinc.com
References: <20251016072517.4845-1-wangao.wang@oss.qualcomm.com>
From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
In-Reply-To: <20251016072517.4845-1-wangao.wang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MdQwkE8qvadvW6_mSQNS3whhtcd44Pao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX6Z+ERpJHtlJy
 lLRmc6UQBcXftPrbnZa+Ut3gRxpD4cZ8qW/kn17vXqlDAcaMbaYeNhzQJ1GVNhBs8RNw26qSkVQ
 Yb3NdE+B37W7Or7/uGo57vxlYa0PyTLr+f0BCeLxGE5reVto3kMvmmR+r9VVdqbGX7FX2x/Xid9
 AT34ly1TUVBFYddPVmINIfsDeJsCzQdZj4a3KWuarcARwnldt7WScjP9jRZdKoJccKDu52Fxybv
 2L9dTk9c7+QaCYXeYYmW1egWDzdimDhoqUB1P+jL53NFVjDg8mlTLQwgvoSw9dXKtQ8zXuSP9XU
 fh189pp2zZ5aoqFTzHtXuosXWQ35rYrNR7zG/ceKb+D+QRRSx9LjAW6AJf2IE2CPNd5gs4Yi5EU
 XbECiS4ocW45DpGTBD2+o3cDI6ijuw==
X-Proofpoint-GUID: MdQwkE8qvadvW6_mSQNS3whhtcd44Pao
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f0d1bb cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=L4UNg9I9cQSOxNpRiiGXlA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=8kNo1vfqJQJ2e38LGaYA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018



On 10/16/2025 12:55 PM, Wangao Wang wrote:
> Add sanity check in iris_vb2_stop_streaming. If inst->state is
> already IRIS_INST_ERROR, we should skip the stream_off operation
> because it would still send packets to the firmware.
> 
> In iris_vdec_kill_session, inst->state is set to IRIS_INST_ERROR
> and session_close is executed, which will kfree(inst_hfi_gen2->packet).
> If stop_streaming is called afterward, it will cause a crash.
> 
> Signed-off-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vb2.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vb2.c b/drivers/media/platform/qcom/iris/iris_vb2.c
> index 139b821f7952..c1647fb4f0cc 100644
> --- a/drivers/media/platform/qcom/iris/iris_vb2.c
> +++ b/drivers/media/platform/qcom/iris/iris_vb2.c
> @@ -231,16 +231,20 @@ void iris_vb2_stop_streaming(struct vb2_queue *q)
>  		return;
>  
>  	mutex_lock(&inst->lock);
> +	if (inst->state == IRIS_INST_ERROR) {
> +		ret = -EBUSY;

ret is only used to trigger a state change to ERROR in this void API. Since
the instance is already in ERROR state, assigning ret = -EBUSY is redundant
and has no functional impact.

Thanks,
Dikshita
> +		goto error;
> +	}
>  
>  	if (!V4L2_TYPE_IS_OUTPUT(q->type) &&
>  	    !V4L2_TYPE_IS_CAPTURE(q->type))
> -		goto exit;
> +		goto error;
>  
>  	ret = iris_session_streamoff(inst, q->type);
>  	if (ret)
> -		goto exit;
> +		goto error;
>  
> -exit:
> +error:
>  	iris_helper_buffers_done(inst, q->type, VB2_BUF_STATE_ERROR);
>  	if (ret)
>  		iris_inst_change_state(inst, IRIS_INST_ERROR);

