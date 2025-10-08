Return-Path: <linux-kernel+bounces-845411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB94BC4C45
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD7794EB3FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF4B23BD1F;
	Wed,  8 Oct 2025 12:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T6EgP+kF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B421B9C0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926414; cv=none; b=DHD7jqzEHXOxzX1Rr/sJyTZJW1PhX9pZu1/q23wBUx73+RU1QYI3mP08Mv/2yi/kVWRaOvT4OLNwp/dExdMoHkAWPQSJNtGZ3xsopdYdGK32ZfQR/ajZ6Bg9xfnZoGmfemoW1JS4NPHx6u0lakgGGfH3rT9XrfxWuuLQaG1ozDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926414; c=relaxed/simple;
	bh=A6LpCOuTZE3xWwWoN+zTO2DdAUncCwlDg/C3+V/ErZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ns5PSuIFPlGyav4Qv/5GyDWcwrcVx3S0W5ZNBLREOSsUrqsg/5IQm94Ty6713KmkA+EZdIRyLiq9ofJxxklrg48PP+tjqell4/A0/lrR6TLLNg7GnBYBYkySefc176QgWiQ3mpq/JF3nZuPU57QnUOPrJuaU+D6O5yzfMTUsN5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T6EgP+kF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890PkC015824
	for <linux-kernel@vger.kernel.org>; Wed, 8 Oct 2025 12:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hTIrLWhCuYswk7gJiyGpHosbap+ykH1fgKQH1NNCHek=; b=T6EgP+kFNxLUxzHw
	+Kh32+tHuIwQjc7TGcbVq7GozsqpRDMw4VtE6GjuWucKeAQSr9o+ImNh9WUxXUcn
	wvnREvkNMIN/NkbWph9d5vLTSHZ0IQbUpxLEm14P00nnu4+vnaWbKmXcR86Eilrf
	PZic7E5UUnaLOjVU90sk0PAcZ2usSEpqLBQDW5XAsZTD7JszvwcZzCCJJnhHxfmF
	mD9OeO2dyOcj5d2bbCQlUVItL3qHJTLadJS0D4hBZOX9MwDD/70V/0yyFztXjLNl
	ifHD0s+af8ocdhWFfBgRVHYZV7V8IVKHVmBlqRrOSS7H3f74p+KcmSFN1lnALvoi
	7Qf3YA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtk72f5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 12:26:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e0f9bedf1aso22859591cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 05:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759926411; x=1760531211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTIrLWhCuYswk7gJiyGpHosbap+ykH1fgKQH1NNCHek=;
        b=kIxbUF1p9cT3kLH70nNQbS83CCTgd3DabOzYKWTlH7OqMYSyfLcxFj+0ZPWCDyg0gI
         TkebwXELyatdafhYe4SuX/2BXHbMg+PIoxGmhWKoE3YRDmtNSop7ykrAgzOLA0K9FQIm
         OuDRdI9+/G6X590p5WdTJwtVQU71O7VvZKQEwTVaMLrFbYvogTresRGs3kWZVLB/388+
         GQWCi1k3MqQNMy+0y3fSF4TkVnxgb3V/TSiHtaO+V9fZoUTljf1mKY5/pufek/55UQtG
         34ZhSPFarLtkr+4nckfclpifn2nZhvAoepgPZU+s/nDZqUbUbZFEWcGMlf4DiBdXcgXN
         W1uA==
X-Forwarded-Encrypted: i=1; AJvYcCUeoGyJToTb/m02ZVjfVBEdgNbylZwxHLsEfwXIzL0auR6IxB9Iek/iRjwjoygdaYzmqjIVc2fSwyHJvzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAzpcqU333Ed3bAQUE0Qhj6j8U7ilTMYVt/6yVRQty+SfJTBvi
	p7qAr+/m+kN0miwymd4760q18qMzNpiAX1EAC7V4Fj3tjg3occtYgX/pQ4+z/pEX5tqezwsYzJh
	Msc5VZ0leyVe3/5jklHaB2PDdMwF8pupgndKhh2cc/3uZZmJxs3vjXxz4bq2wQL0GzR8=
X-Gm-Gg: ASbGncvqVzw0dxTOkvufJChCWwi+eCSbY9PE5aB+IfFxcj/p3OEoAeBLOSJNfGfRkyC
	wqSPfFoHf3g3orF8TRU8MCvqcsCzILDaBlusqe5tTd7roM7MaPSrKKJAnl+y2wJKXpo01Iq3l7y
	WMpGiap8GDXx0itSpz2ieSQ++KFap1O4fqCaMDM4jB20nUuDaPflUl4K2iME981gWKSeH//52JT
	E/0GblmFntZhSesfkIdzcQLGv/c4ACLfEYfWaz8nR/+5e1Xkx1ioix+fQ1z4NLzKAX3KOOfKca2
	maPPcwyTtnuFdAX2ggrd+UNnZCL0gHpqRwgYbZEJAXoPivvPE3sFWIIAHoB9i4AYLXUQjyiipkv
	wIabEGOVk5MkzFIpQNsbJAztxeUo=
X-Received: by 2002:ac8:5fc3:0:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4e6ead1deb0mr28021421cf.7.1759926411091;
        Wed, 08 Oct 2025 05:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWi1lAlUT8aNtQIImWXGA5CVQVacMLVhZrKAblF+VQsTGwx+HRvQ+0r/mIpvsbqWLEs/VUyQ==
X-Received: by 2002:ac8:5fc3:0:b0:4b5:e9b6:c96 with SMTP id d75a77b69052e-4e6ead1deb0mr28021081cf.7.1759926410546;
        Wed, 08 Oct 2025 05:26:50 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9bf1sm1636993266b.13.2025.10.08.05.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 05:26:49 -0700 (PDT)
Message-ID: <5ba5fb11-96ed-41bd-ba21-f30476cdd570@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 14:26:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com>
 <bnlnz6nz3eotle2mlhhhk7pmnpw5mjxl4efyvcmgzfwl4vzgg3@4x4og6dlg43n>
 <c54e8ac4-9753-47bf-af57-47410cee8ed7@oss.qualcomm.com>
 <d6a2937f-7d63-4f17-a6fb-8632ec4d60c8@oss.qualcomm.com>
 <db8241b0-1ef3-439e-8d74-a3cb86b610ba@oss.qualcomm.com>
 <d0871d6d-7593-4cbc-b5dd-2ec358bda27a@oss.qualcomm.com>
 <7c1bd3d6-159f-4269-a22a-34290f1be0cf@oss.qualcomm.com>
 <uuhcud25gcbvogpyywmuv2rn6fq4ssns6x2u22a7eqjknf7oes@kvdrw3iqqkbi>
 <8b74581c-9f74-40ef-8fad-7e172dc303d9@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <8b74581c-9f74-40ef-8fad-7e172dc303d9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxNyBTYWx0ZWRfXz0/JpeoZoUn6
 9C8J4Swf1IulLgMgmfSIs/fsJnmuTKXTxkHQSaN7EOgYG2mT7ES4gBJy26XbuC20KZj3sz5BfbD
 BnaqYKVYP7CsjGRHXyj0wGuMYsYO9MNqEq2D/Gs9OuQfUCLNaqUixRYAeNC+x2w0nsHh9f5tx/z
 alXfWZi4bvGoThe1usg7n//ZkhTARTmHnGG4vhbnS2m2UyunFww+Cc0dZXmkdsbmNav6PBeR8Zc
 +EMOaYeRsxTWY21qwA4wRUUYgWJgtABWRPgIgV4PJeuN34y+lhC9B1WrM3hsTVbkJrUTlELrJXQ
 Oq/1qIqIhJQ5Fr6wYelQNmhNnwT7MbjY+9ub+TUz5jMeUFlv2rOM5JhNCwd7cbIy/21Q65zwCvR
 5YC4Tv2rg9IpAVAhC1Gf1AlS2auxtw==
X-Authority-Analysis: v=2.4 cv=do3Wylg4 c=1 sm=1 tr=0 ts=68e6588c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=zgeHl8ZYYJtjmPDB28EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Tb5kpAZN4q6z07Hnp2U2ztTBb6P2t9LJ
X-Proofpoint-ORIG-GUID: Tb5kpAZN4q6z07Hnp2U2ztTBb6P2t9LJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040017

On 9/26/25 11:41 AM, Taniya Das wrote:
> 
> 
> On 8/8/2025 5:48 PM, Dmitry Baryshkov wrote:
>> On Fri, Aug 08, 2025 at 02:51:50PM +0530, Taniya Das wrote:
>>>
>>>
>>> On 8/7/2025 10:32 PM, Konrad Dybcio wrote:
>>>> On 8/6/25 11:39 AM, Taniya Das wrote:
>>>>>
>>>>>
>>>>> On 8/6/2025 3:00 PM, Konrad Dybcio wrote:
>>>>>> On 8/6/25 11:27 AM, Taniya Das wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 8/5/2025 10:52 AM, Dmitry Baryshkov wrote:
>>>>>>>> On Mon, Aug 04, 2025 at 11:59:21PM +0530, Taniya Das wrote:
>>>>>>>>> gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
>>>>>>>>> boot. This happens due to the floor_ops tries to update the rcg
>>>>>>>>> configuration even if the clock is not enabled.
>>>>>>>>
>>>>>>>> This has been working for other platforms (I see Milos, SAR2130P,
>>>>>>>> SM6375, SC8280XP, SM8550, SM8650 using shared ops, all other platforms
>>>>>>>> seem to use non-shared ops). What's the difference? Should we switch all
>>>>>>>> platforms? Is it related to the hypervisor?
>>>>>>>>
>>>>>>>
>>>>>>> If a set rate is called on a clock before clock enable, the
>>>>>>
>>>>>> Is this something we should just fix up the drivers not to do?
>>>>>>
>>>>>
>>>>> I do not think CCF has any such limitation where the clock should be
>>>>> enabled and then a clock rate should be invoked. We should handle it
>>>>> gracefully and that is what we have now when the caching capabilities
>>>>> were added in the code. This has been already in our downstream drivers.
>>>>
>>>> Should we do CFG caching on *all* RCGs to avoid having to scratch our
>>>> heads over which ops to use with each clock individually?
>>>>
>>>
>>> Yes, Konrad, that’s definitely the cleanest approach. If you're okay
>>> with it, we can proceed with the current change first and then follow up
>>> with a broader cleanup of the rcg2 ops. As part of that, we can also
>>> transition the relevant SDCC clock targets to use floor_ops. This way,
>>> we can avoid the rcg configuration failure logs in the boot sequence on
>>> QCS615.
>>
>> the rcg2_shared_ops have one main usecase - parking of the clock to the
>> safe source. If it is not required for the SDCC clock, then it is
>> incorrect to land this patch.
> 
> Along with the floor functionality we require parking of the clock to
> safe source for SDCC clock. I am reusing the shared_floor_ops introduced
> recently for SAR2130P explicitly for SDCC clocks.
> 
>>
>> If you are saying that we should be caching CFG value for all clock
>> controllers, then we should change instead the clk_rcg2_ops.
>>
> 
> That is not required for all clock controllers and which ever clock
> controller's clock requires it we use rcg2_shared_ops which was updated
> to park the cfg.

I think Dmitry just wanted you to confirm that what you're doing in this
patch is guided by the necessity of safe parking and not only to enable
rcg caching

Konrad

