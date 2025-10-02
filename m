Return-Path: <linux-kernel+bounces-840843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BC5BB58B9
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 00:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4004D19C749F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 22:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A20272E6E;
	Thu,  2 Oct 2025 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g6GN9X5E"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D670C1DED77
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 22:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444379; cv=none; b=kbfFQgAFmIFynE/fzZALtpKh5kVoB9G/Z6HN45P1fVJEhbOYwhRH+rUgy0il7gOtTFgJJDHOPSWZI/wceGKae/5mlIjUiHAUXHHLSLQ17N38WfYPJn3l0wM9OlR1Pjm7EKABgY5XKTgt2CMpJCbck/Vs540YGPoT+o6Ox00dTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444379; c=relaxed/simple;
	bh=qGBvGVUOR2k1VrExAC7p734oLxaKwcZqmNkNFkXFeTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KvvXmWAeZTVrRbxPycFLubG5+pzIIy96hQbxu/NjIyukZl9sgZjX67XasHwzbkoKgnfEy8MRbJsAWRJAQVh0n5oFuv+wC6HPqKJGYrqc/eoZxFao7IKw4kZNFsFkmoW8Z59icHfkpKH/c3y7KN+GNYv1Z+38gEjJsiB0EM224lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g6GN9X5E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5929NYCx006633
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 22:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FpwK6wbpl1nHk+Rk54AADbhqSQ/2kNSwRaAd3k0SSc4=; b=g6GN9X5E+IsJIiUT
	c3GcgC/AxotYGLwrKIZYP/4wdgzr2atBF4oD5A9TTnRqNSiKdjVC003noX/XXP7I
	W2mOfIAxHn25XRRLM00aNyYC+EswzahZVc1nMDn2xmVO00SgGvnDb9H6a+5Gh3cl
	UIAznHf0Bib0xFuiy37rsWZ/jSVXz6PB5u6C7vz2fR1POplJ3qB2UQFzdXMXCDqx
	PHECk2c17/tWPTZFi2iqy5LrA7eI58kF5ZBEHDfBG29tSlJTVwTxQWTov7edkvIj
	XkxDuNQ7nvNs7Bni1SQu4Gtklb6ymKoHuzm1sbGmf+N8KrOyjc6CTob2vxCK+A+O
	lmvoDw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851s6em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 22:32:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ed9dbba55so465135a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 15:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759444376; x=1760049176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FpwK6wbpl1nHk+Rk54AADbhqSQ/2kNSwRaAd3k0SSc4=;
        b=EwvQIQAtDbtTmlAzz/3zAp0/7n1HFsX6ruS3vp4JJ6hyfAHfQO0y/hFGDHOy9vtaqi
         QjUqLuzpi83J4A7RTa30C0CUjScD4fbmcjJuz3cFZ9FF8KcJ7ju3GD4Xu37Bu9qj31Hh
         kDzY385nJGred4EykgB2yhAX8c8aIu817Sdr+o3z5wkzIIVsJxzbCFL282B48Uu3BybL
         Z0dhfeobRZk/rHrFKAEWxe45SUeogKe5TH+JtCD3Hq1qHEVze1Y+I1SCvqW+KqzuXOmx
         snw8+MUa9zZZ0dCsn5LEGqS5SfN6KnNYM1ug4BYhM+OnPt3BWbQHlRHBEKH75xrZ5y7D
         GJfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqw0niJkj09McRkX0XbNFOPBpdiKPTp1nT0JtJQccQXuMlZkQmqfeHU8idrimM6dwOrO/l3NNMzQ5xnCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWUcU/xd4IWtbbPzgwWyEkdIowAcvSzrU/Wqat2/9vci+BAF3k
	2f4ZDlYYy02SDTgitNBER6tH5o4xuqY+bUfwW0IFNi9hUrPFSY63kOlbr95eU/a/bhr4biCHBQI
	mluiTaflIHgvU5MysbWllEdtbw2dIibKYV+J3+C/auY1xAQmKE9L1sx/fH82zR8zjRkU=
X-Gm-Gg: ASbGncv1UOpeDu/4tsyP+qzneVezOQpDMBVskLGR283l1JDR1UtVyVmDao6pYNuNjn2
	4G7WHpsShZ0SE+M9Pa1y4FC+2B0fwSqS3XYabWlAIdV9i7hdHWRPkd+xnLshtAM6Qh6yYzNR4Y1
	twn+cNjf42JCtpHqkI8hLazvkLHoPrgP0YCzJk3TiCLMAjv7dcD5ZHRx8q10gmoernoFQBcBI62
	DK3QSjkn0mfWc1HJuXqU9vDoFiQ8V/9RgbmPhb8LSSjYiNzsNH8nEnCDXjHiHDKNxZ9l8BdNRlL
	nneurhOoNK54MgYL8h29FyhsKBbr7HI5OcEKYoAngdAf5shfa5S/MoOa7HoCTcStPdcb9dskcPC
	hnACLT/ZuQozNkMXB37VgyJdQrdBQv9KM
X-Received: by 2002:a17:90b:1b07:b0:335:2eee:19d7 with SMTP id 98e67ed59e1d1-339c27f147cmr548597a91.5.1759444376149;
        Thu, 02 Oct 2025 15:32:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHv7Ezyd2UUjO1KmLcKNimDDT7YbIHUc7nq44OqeXFnjgQivLtCpsrlpOrl4tDqUhXI5zl9oQ==
X-Received: by 2002:a17:90b:1b07:b0:335:2eee:19d7 with SMTP id 98e67ed59e1d1-339c27f147cmr548575a91.5.1759444375693;
        Thu, 02 Oct 2025 15:32:55 -0700 (PDT)
Received: from [10.71.110.242] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399cdef492sm4222624a91.4.2025.10.02.15.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 15:32:55 -0700 (PDT)
Message-ID: <ad9c79bd-b3ea-4dac-96c5-f264eaf91dcc@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 15:32:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] media: v4l2: Add description for V4L2_PIX_FMT_AV1 in
 v4l_fill_fmtdesc()
To: Nicolas Dufresne <nicolas@ndufresne.ca>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20251001-av1_irisdecoder-v1-0-9fb08f3b96a0@oss.qualcomm.com>
 <20251001-av1_irisdecoder-v1-2-9fb08f3b96a0@oss.qualcomm.com>
 <544147436308901fba85d6de48380c0c1eea7c67.camel@ndufresne.ca>
Content-Language: en-US
From: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
In-Reply-To: <544147436308901fba85d6de48380c0c1eea7c67.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68defd99 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=fpfRSM_o4ZOcEIIQWIgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfX4X5QheBHAeg8
 0TN84ScF9t81jYBkIaaR4ZCpreQOEe1IdIlw7ZcDACX7hcZ/+03GFiry+kG9RTCIYn/GufJ0D6M
 f7pqNSjdc9IexDMXAa5zym/AXIcxQZM8LUDq0F56IHiAwwD7S646qIJRU8IXVeyEOJWihfv7a+v
 LlyLkQvOU2GbuUcjzhmVam5ig7+sLqwsxPfYZWLkW/uLngG1Oiyy1G5fXK6xrmLObw+v71dHtl1
 cfhH4yQBNfrJUIq7SXOGmPywqiuL/YDpa/Sud0hKqVCx+BmJI3rAnIwHY+SX2PLd5GMonIPFjT4
 ad3NMpzULkwnpmbKJ68P3OjkmlQk/77sWppZdYmWZNbMsLBhEntdOQh3mh94RIuP/WhpgkRv2fU
 wvx0Y/BpFQlqs0rCXEXrltg9Pl+E4Q==
X-Proofpoint-ORIG-GUID: H0nplsU8_5W-wDxmUY1Oiotpquz7xOSg
X-Proofpoint-GUID: H0nplsU8_5W-wDxmUY1Oiotpquz7xOSg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_08,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032


On 10/2/2025 12:43 PM, Nicolas Dufresne wrote:
> Le mercredi 01 octobre 2025 à 12:00 -0700, Deepa Guthyappa Madivalara a écrit :
>> Add a descriptive string for the AV1 pixel format to v4l_fill_fmtdesc(),
>> enabling proper reporting of AV1 support via VIDIOC_ENUM_FMT.
>>
>> Signed-off-by: Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
>> ---
>>   drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-
>> core/v4l2-ioctl.c
>> index
>> 01cf52c3ea33e1a01e1b306036ba4e57ef5c95d0..d3ee7736b74b0f277d3208782e3ac3282eca
>> 1e6b 100644
>> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
>> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
>> @@ -1542,6 +1542,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
>>   		case V4L2_PIX_FMT_QC10C:	descr = "QCOM Compressed 10-
>> bit Format"; break;
>>   		case V4L2_PIX_FMT_AJPG:		descr = "Aspeed
>> JPEG"; break;
>>   		case V4L2_PIX_FMT_AV1_FRAME:	descr = "AV1 Frame"; break;
>> +		case V4L2_PIX_FMT_AV1:		descr = "AV1"; break;
> Perhaps "AV1 OBU stream", so its clear its no Annex B ?

Sure, makes it more clear. I will update this as well in the next patch.

Regards,
deepa

>>   		case V4L2_PIX_FMT_MT2110T:	descr = "Mediatek 10bit Tile
>> Mode"; break;
>>   		case V4L2_PIX_FMT_MT2110R:	descr = "Mediatek 10bit
>> Raster Mode"; break;
>>   		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed
>> Format"; break;

