Return-Path: <linux-kernel+bounces-742285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F884B0EF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A54063AEAA5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710D528C2A3;
	Wed, 23 Jul 2025 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cVibFs78"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693A28C2C3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753265460; cv=none; b=ANYLcJfTNxhnC8CRLbor5a9Ir5i0ZSI5PZCuFt8Uh01prRPs4sKLEY5DYosx+SAkbdKNImhNMS+tFu4rP5LiEY9r/RqDSxdtQGz2iUzk59GJs23Qw9tKbwJeN8fesGKCY9os6FpnTfOAjoiuyJdJeJa/8bs9N1jk++V2OHzaVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753265460; c=relaxed/simple;
	bh=0I2Q5xccO1ZD2zdNQobm3Vr8rIsXJKO9K7RJSS44oig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmiHzbnPIXSZlyV8AbnKLl9aJ5bKgY69Wy3ORT6VEVXA+jIwgk/PScValwrkiFY/TvAA95PvfMWXJiEnpapQna2G/tzmYMYWKYN4wCs7oCiAQFKeRq8VnaPfPn2jou+a8hVM7L+cD6C1FGGCSgrKk04/q61IOQoIThzXMvpQOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cVibFs78; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9Tm6C023489
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	367qI0nz7D+7h4lGNKFfyYMcgYPJRnaZzBeo2TflJFQ=; b=cVibFs78mpAbpqKm
	uF8czhr8zLx2t4Qe27UCNjJL81V0q2OYEG1FpSQWB/bKdWqDmB4M+AE1OgetC+wv
	JHsywSzGtQ/T+n47iZ1WLol0PVw9buC1KizXkkhhJ/QqHcqaXT/VRZmcVvYG/qPM
	Qf4/jw4miQeR5x7PrdId5DJgJ2WkVr/MgKaqKmvTQMoHBdGMzYI2NRbwxn566b66
	Gb56vuMXwJUOp39PMt/ep/xobhf3JTnjOywpHv6WSYl8kKFgoKeSjGisTfhOOxAv
	93kUO9oH4QWUlgBODKksBeK0tTXDMmUWqStrGJiuw9OuPHrVZGa8JNA6ngTO7wlI
	3Y2J+w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 482b1ub98t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:10:58 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6f539358795so22594106d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753265457; x=1753870257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=367qI0nz7D+7h4lGNKFfyYMcgYPJRnaZzBeo2TflJFQ=;
        b=EtlSdUL0Yvv6iARag6/wIUHIHfR8o9824zR7+SpE16KVLgo7IT5RMZH1CYIqD6VPOu
         tdv0eZUtf/EvBJbaBYjTT1G2mbRR9ellX4uetyCzVUdQkPB7SHt64RoJW1nmgcRZi4B+
         l29f88cqRPy7+qlxKbgiWw9OjWigRUV7cctuKcm8UNPryhkKv9fiGuhr4cxLm4ojANMs
         DANKBRtWp4rxmaIUz3TWfBNeJFPPX1fUShvi9LMFInIFbjYN2SvOTzx/1+ywu7H7SwTd
         iDknwg/udgWqE/w3oVFMUhRm0QbfELI1DDKEgLoxs9fphndEqBL1bln7lV/517UYPWbG
         PI8g==
X-Forwarded-Encrypted: i=1; AJvYcCXdv7XcLyYsijmzwRwhFIyeCJ+21GqgYR1AHNVIBPGWYPrvsCxwgbr92QwPQxZPv08aPiXMnLcyMcEelgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOUUGjNI9gi2l1Os/dxiohA/l5hXXNqGoZ0zaJ1TpXlsnnQvgN
	xf5A437THoKPAGilrUw0H3Qmxp7XJr3NFfAoYdLw/4lluf8a3h6l0tvONzxeWH03NB3uXDygCGt
	8TPj62Cdo/yuB6BFP9oyXQ4O1xC8lI/qhU9cEbrS+jKrNB+zqL0UdpKonV6v5+Qpys08=
X-Gm-Gg: ASbGnctNN/icqPfvV5rwJ4nVMbbvpV3q9HVQ2tn1BYPWcMljAgpn8EJySQDEBD/zL/u
	VG3ePtylSlTGLEufbI0Czk+Q/uibcwXGLESTxvsnuSY4DbAHzZ9l9gBB8x7MjIhJ5RqjVP4+/1P
	w2EMh133sglH6s362KAae1L9iCbRz43rTGXKlfR69xZ2s+yAg99PiPWXzo+D4o/72+JG77a5KlE
	f3jgZr1NQ1HGATKpuGc2FW4ifO7IUKi9TscEij6YuOMA+sQvwTWaLkW+R9mMIJOmiFFeUuYcPCe
	DyUyjZlCHafEf75wQCCrnkpQ5yx5W2gER1jjocitccJURRUrq6ARI+2VLVNhmRGxrbTLJ+Gonn6
	3H2K0pKojGCQ2w5200g==
X-Received: by 2002:a05:620a:3187:b0:7e1:ba5:6ee0 with SMTP id af79cd13be357-7e62a0390eemr120703485a.0.1753265456485;
        Wed, 23 Jul 2025 03:10:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR6Y6ZAAWdnN6iFKod/XOWI6twM2I3VQjkDNOIwbsj0NfFRXCat4cq56yGbwtYclqGHHydmQ==
X-Received: by 2002:a05:620a:3187:b0:7e1:ba5:6ee0 with SMTP id af79cd13be357-7e62a0390eemr120702285a.0.1753265455848;
        Wed, 23 Jul 2025 03:10:55 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612f1312e17sm6525453a12.39.2025.07.23.03.10.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 03:10:54 -0700 (PDT)
Message-ID: <ef79b37e-8b63-4ccc-a739-994a119b95c9@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 12:10:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] drm/msm/a6xx: Poll AHB fence status in GPU IRQ
 handler
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
 <20250720-ifpc-support-v1-10-9347aa5bcbd6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-10-9347aa5bcbd6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LdY86ifi c=1 sm=1 tr=0 ts=6880b532 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=LpQP-O61AAAA:8
 a=wn_gRGg2Iv5gsIDpaVAA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=pioyyrs4ZptJ924tMmac:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA4NSBTYWx0ZWRfXzxj7CNQHs3nC
 4vbq/oeO0HEUgUzeE+/07o9vnm8U8Brv/+Cj/NNovEe1jAib259izPaetn88g4rbkKigf64m6xN
 1NqZLwF50DGMn6FQtmvaBofc0JDrGnSr23rPfqtEbqTyhQmN2FEyI3fJgPvgos0xiM3U7grmvg5
 z+2iNq4IqcJoYWmYmRIDksVnK6Cf2RwRyVm2RuotDOiuYx7sFkouqhi69Qh/hR+Ko5si59d8DYs
 0pTv8z81HnKIXtpPiEK1u+7YButBMfi7w0X5jBpjVYS4MTwnTazoFRJwL/9M5pD/sxgncCSCpkn
 qCnzuDw0T/RM3s+LeecZQt3FfFeLwe2luiO5xEhmCf807uQ419yBWgb0igiJ1lVoqSOyStTTTv0
 W3zN6W5TxLpwWAg5VFM9tAmuXxNwXBYnluQqvXAcIisqsvbdrI+fK//ywmY+xkT7HrvWUw9o
X-Proofpoint-ORIG-GUID: eAiHT_FFTlUcP2FKyTfx7OlPxbw_A_LV
X-Proofpoint-GUID: eAiHT_FFTlUcP2FKyTfx7OlPxbw_A_LV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=789 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230085

On 7/20/25 2:16 PM, Akhil P Oommen wrote:
> Even though GX power domain is kept ON when there is a pending GPU
> interrupt, there is a small window of potential race with GMU where it
> may move the AHB fence to 'Drop' mode. Close this race window by polling
> for AHB fence to ensure that it is in 'Allow' mode.
> 
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---

There's some more context in this commit message, please include some
of it:

commit 5e1b78bde04ca08ebc27031aba509565f7df348a
Author: Kyle Piefer <kpiefer@codeaurora.org>
Date:   Thu Oct 19 13:22:10 2017 -0700

    msm: kgsl: Prevent repeated FENCE stuck errors
    
    If the AHB fence is in DROP mode when we enter the RBBM
    interrupt handler, it is usually harmless. The GMU will
    see the pending interrupt and abort power collapse, causing
    the fence to be set back to ALLOW. Until this happens though,
    we cannot proceed to read the IRQ status and write the clear
    register because they are inaccessible.
    
    Poll the fence status until it is ALLOW and we can proceed.
    If we poll for too long and the fence is still stuck,
    the GMU is probably hung. In this case print an error
    message and give up.
    
    <cut off tags so as not to confuse b4>


Konrad

