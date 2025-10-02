Return-Path: <linux-kernel+bounces-840104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C023BB38BB
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 12:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19FA1757D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916DC3081B9;
	Thu,  2 Oct 2025 10:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ntK33hjf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD692FFF97
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399593; cv=none; b=Tke4G9sw4X5BRo5/+laL5oetZzRXqKp4uEf5nZW6r2TlNu47QxhWu+CzyOw0UYdJlmtXlOABGCEWhIpK9EiHhL19fj1pklmWUp8bAX6ZLk9DtjZOuTQ914nHFl5SUnuqG2YdMbZUcdmqnKme6hzPlvtT8k33PUObxWFrzuE1EXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399593; c=relaxed/simple;
	bh=Xk0ZMuoLn6B1XqtDIyDn5SBbElMp+XKnzPvGOFyIfo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fM9AdgSfbzNyzF/QgZibeuD2ueD1TZ6AHihjjBVCi+F8H5nfE3XZAHoFk8S60sEmz+5lFW2PlhzMiYqWNFrGdd6NizHIBVqthB9RQo/jcH0ClajtfJq/m3vAKMu+/pIaNLgv0xCwx71HcQEjK+50tE8s5vqGoQeCpyz4bwWrHWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ntK33hjf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591Muqrw027601
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 10:06:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lyoR5zFmPjLYNw1L0yVBnS+u3QUDvwCd06FITUk6o6g=; b=ntK33hjfliiF2/yo
	K3T9L4HP1CR4Mozu74/fRoiWxtTA/Bbih/fT5nn5RsZDOLtC14j/6L5aj8eITiPG
	oPe4bDKU7S8mKyJ0cMAu56EyBiAi4ZyM4eKtxSi0jPnK1+oRvgJcb7q+i37Oxdta
	Udwnb2b7T7KhGqkP76y528nIHGAd//icuMMy0HPYi0wBQj9nVwfc8hi7qp5+ltO0
	XC80W0otHfvyeCTcigQLLYeCWQXDRtuK/d6liIYAESFwwce58rwLIxMxhQ+XFRFh
	bYlSVrDw4nGazxJz/2TzPqNGSfJvuvw60NAmg6vK5bolaR9o27GMlskM1nfNl7gP
	15WsFA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e851qf0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:06:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b60968d52a1so1549249a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399590; x=1760004390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lyoR5zFmPjLYNw1L0yVBnS+u3QUDvwCd06FITUk6o6g=;
        b=AG/4dXiJwCtqmn0naOUlVeXQqG7d969XuDMTtN/ZgkQHh6pXJV+RGoqD3p4h4Dv+MY
         f//uzSk2Aucjk50M7Gx5KD6TGdDqS1EHPVMs7qUPahUpBLRdijYAwAz7X5Tv1xnAIWIW
         pJLVWK+z8d4sQidzfzjnsnoqRx+MgnyFc6+q/xbUFMAoFWSr344ssaoAJrtOISt21woa
         yp2cx3fpHyrLP2kx7n17JHqxcuSzRgIkyy3xFlrTELV0GzjOIxfx9DXUYrOWKCD9Z1Nz
         l2vfrrY/pslS3FGoxFSxdsQCNR+drgmI+mH64xT/J84kLzwx6nzzl30jJloaatoiUSdU
         uh2A==
X-Forwarded-Encrypted: i=1; AJvYcCVWGzH9e2wx+adZVHtkcJ/OeB7fimLWSg7hefgGWATEUqZWB1Y9qFyCLiufZEc/jOgy1OIsYq2+fQazhPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDcpK0938qGONVAxfzan2ayQpiCD8PQQDDdjZPB8iRFGfvEolO
	ve7MNy3/gc+6e48oa3zLpRtfCQ0MSmcwvAHeki//9js/wS5MuPShb1xJpJglmcNJtMScuCKu8r6
	no2md749hPJKL5lUtf93rXreg+dfQA0tRCkGM+j9ynYDkYwpSxJGkrPQzLUwo1BQNyuHeTj+LpZ
	k=
X-Gm-Gg: ASbGncspagdiBUWsalM3luqx/xutCdXt58evH5+GYL1W4CRIQDDBznyaibRgPpN8DJa
	SpYGC+lqVbK5W47J1VY83MMqFQ3rPZ5jDXnP/HFmvUqwVRsLh5Iemy1bBd0XQntvaADXJSFP54o
	FV+Vc5YFd1oGDoe/LzSf+9dBK8sepYAl1ljL8T70WY7NiK07T6mDI4cIIL6qM9e9YnGbs558O8l
	oAdXsUS5j1vBb/0HsGnC8mv6qGL6ec+xVsyrRqOxgtq2LGX3Ocg/MpurOM6qDofl1XSxj5biCCm
	gYg1m6NZU7kNySp3jJRiZGez+4xUidGEgdyusilwFkqiA+OunNUIyPxLEeXkpY8KWmpi67I+Hya
	prQo=
X-Received: by 2002:a05:6a20:e614:b0:2f0:4f71:c482 with SMTP id adf61e73a8af0-321d8452aa2mr9556500637.1.1759399590405;
        Thu, 02 Oct 2025 03:06:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcKiWJW5aLjMg3oNcuCPIVwZjr+gQ1x/JxWytHkyrPwo2mPMeoJLrZ9O10AaPCw0B12SvaNw==
X-Received: by 2002:a05:6a20:e614:b0:2f0:4f71:c482 with SMTP id adf61e73a8af0-321d8452aa2mr9556469637.1.1759399589951;
        Thu, 02 Oct 2025 03:06:29 -0700 (PDT)
Received: from [10.204.101.186] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9cda9sm1861043b3a.13.2025.10.02.03.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 03:06:29 -0700 (PDT)
Message-ID: <a8e2906c-9812-0a99-297c-4eceb6c426c9@oss.qualcomm.com>
Date: Thu, 2 Oct 2025 15:36:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/8] media: iris: Introduce buffer size calculations for
 vpu4
Content-Language: en-US
To: Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vishnu Reddy <quic_bvisredd@quicinc.com>
References: <20250925-knp_video-v1-0-e323c0b3c0cd@oss.qualcomm.com>
 <NFzYqaeq5sb1dHtVN0YuNSMRZSaP8tEluFULzxY35Ir2qNpfsn1yP5Ptd9zxuuLzyD7oMcyeZR_NK1DgsO0sKQ==@protonmail.internalid>
 <20250925-knp_video-v1-4-e323c0b3c0cd@oss.qualcomm.com>
 <bee1da42-1108-4d71-a854-e3f76c5a6e96@kernel.org>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <bee1da42-1108-4d71-a854-e3f76c5a6e96@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OJoqHCaB c=1 sm=1 tr=0 ts=68de4ea7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=rPdB782uDU9_FGz_shsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMiBTYWx0ZWRfXwityTFOrlqhN
 fDKme/WgXGWmvHsANGchV/MbTA17ncvcrcuyZzynzPN4w98mUZIhAFd1srCDUXYsn6kPreLIusL
 jXZDx9GK0AwQ+KODspHikuX8QaWp+INC8tXvccZSVa+K0cdnAdsdc+fmzcqe7+V6KcfYYLlxF8S
 DSqCAmQRUcIDdGKo6fal7TD3z6DayznljvjCCPpQHsD6fO2jjK1f2wKjsBIk4US6motnxBh75La
 8yrIFN3vhD8yH7lclcEhbcb59w3HI/gwMNybakHQtB7bydaEQPgfmSXU9ao26lMYuyfVjKnoaqt
 5Wv4wUFJw4EvOsaMmLZBa5b+kgYW0ChVH3qdBnGCILjCo52eM/tFCBkySOrovmzhYv6GsEqQ6ZC
 KCTrxijpTBT1QKhZaxx3eyHzXge4aw==
X-Proofpoint-ORIG-GUID: 3ly8Z7_Gl5waOlrr3ER8vt8flwrzuD3a
X-Proofpoint-GUID: 3ly8Z7_Gl5waOlrr3ER8vt8flwrzuD3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270032


On 9/26/2025 6:30 PM, Bryan O'Donoghue wrote:
> On 25/09/2025 00:14, Vikash Garodia wrote:
>> +{
>> +    u32 dma_opb_wr_tlb_y_size = ((frame_width_coded + 15) >> 4) << 7;
>> +    u32 dma_opb_wr_tlb_uv_size = ((frame_width_coded + 15) >> 4) << 7;
>> +    u32 dma_opb_wr2_tlb_y_size = ALIGN((2 * 6 * 64 * frame_height_coded / 8),
>> DMA_ALIGNMENT) *
>> +                       num_vpp_pipes_enc;
>> +    u32 dma_opb_wr2_tlb_uv_size = ALIGN((2 * 6 * 64 * frame_height_coded /
>> 8), DMA_ALIGNMENT) *
>> +                        num_vpp_pipes_enc;
> 
> I find these calculations pretty nebulous and not very obvious to look at.
> 
> A define of some sort with a comment would definitely help other programmers
> reviewing and supporting this code in the future.
> 
> (+ 15 >> 4) << 7 - I'm sure it makes sense when you are looking at a register
> spec in front of your eyes but if you don't have that detail its pretty hard to
> say the values are correct.
> 
> /*
>  * SET_Y_SIZE(x)
>  *     - Add 15 because
>  *     - Shift 4 to lower nibble because
>  *     - Shift the result up 7 because
>  */
> #define SET_Y_SIZE(x)
> 

Sure, i would trying to gather and explain as much info feasible from my side.
At the same time, these calculation for hardware internal buffers have been
there for vpu2/3x, and is being extended for vpu4 in a similar way.

Regards,
Vikash

