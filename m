Return-Path: <linux-kernel+bounces-775047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45193B2BAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 09:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D185560218
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF726E165;
	Tue, 19 Aug 2025 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RYbwKzUw"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F822D9F7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588403; cv=none; b=WF/UMdsOh0jrM3Q+rL0v3hEIaIz+BKHt9Hg+HoZ6o/xOGsQ5/1gs3tJ4s7Z2TsaYG+QwC8p2HgYVi5DKRwHTRGdB2TiDwG8v3nD7SQh3hDFAhiUPs+TdXe1HnJBjreDRThNCfr2qjTXwZ+du4kbWpqKJ54pA48AyKn36aYQM6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588403; c=relaxed/simple;
	bh=Tj7vwO1kZ4Axx9czPqHop9i3vZMHCxOM6b95IoZVIIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+DD/crer7s4+3c5X78DR3xvSgtmXZTWQu7+Fp46VlM7yV/xVzVIH/d55gxOONSad5z60D4f8s5x9Qes87+a0Fl0fnIYEy9OkQ0q9rqDLWqbU7Ub4hQNOXE75ILc7o7anM6PE9XL/IPn/swrV1QXbyZBhiTT0PYIYIHF4C3KYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RYbwKzUw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ILgfPI026592
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:26:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qcRh7foPygOroCMWDQ1NQA55X8vj3i+Vh6ZiklXfPo4=; b=RYbwKzUwRrmywSX/
	8A4VfGjhdH+pruNnW+iBsYNQJglxCTERjGg+7nXlZqIGKgBy6qEykq29n02CFZAd
	AZqE3vaymEZ1+UJPnxT8NW26/wrfvCGOng36PK9eJjaMqh2lWmmu4OchTLgjxCnm
	qf/XCBhtNkBItWLHgL3iwnl7eSH6G2ctOGUwhpSaEGSc+fhLYfrVMQtS/G5lk9dH
	lfkPG6v3yX6iJGSj5uJH7Td7SxOhFn2M8Jd6s8oh2GRwfnL81Pa6T3V1Owu5G6lv
	B7SeD8qoV6zMWhDanx8x3lvNsEqr9h/MUJsch0nf27nzlLrNq2pwPxyfNoVXJby9
	4pkEQQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48mca5ha47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 07:26:41 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b47174c667aso4458844a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 00:26:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755588400; x=1756193200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qcRh7foPygOroCMWDQ1NQA55X8vj3i+Vh6ZiklXfPo4=;
        b=EsJLVqw3RHEK79blddNvb2vIMRCw0/o8RxBAB4heEkcxIsHLxtyBN0lqt/2fLM8AXl
         dI8b4B1zzkgD8GqpXSVJ50cpfScvGf1oLhvrAint45h6PqOWLcmCJemQ83M1r3NkPy+k
         XH3MmFJKifXOcyODAsoFwEgBTO5+Abz+Yr2ctq2jeC1aAe1ebYGyR5ld+SO3RXvxGqpg
         QmjPFNnecUAhAUpWEYW34HDzQsMtNN7WLeCHBBV8jEYOCKWjU1cQGYmXI4lkpcJnC3tS
         ikMSAIcSFd2BbwNK7mXvdc9/IROdtm2nBZjCvd2XmFz9/+qPNBrSFjul2gNuRrRa1kyv
         5HiA==
X-Forwarded-Encrypted: i=1; AJvYcCWlZCUYS+XJ8x/BVihlBTD9JfU/Arsbg4eXDcWoMXkYNrUWN+H85ONldc7j37JKoF35vQinrb5ki2qynVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf5fSN7dRJUdaIG4t5QUACaEn+LG7KmH9+HNXLLj4R7SREQhEH
	cKfnCjiWrEzxu4TJ/ZpGtybKfgBjIHZolMf3QctYBesNiXZFvoCyfzqet0mm54ZLmnsN48AGNiS
	hw5BlzRzikg2a2wS1rBGKdFCQn/faxdjBQLBiQMwJrP41h8ow00ho/nfZlalsInjOzHc=
X-Gm-Gg: ASbGncuoP5Rq+vUkcYa0HEpAeD/hTO/W77kPzjnLD2BDitFICRbzP3Z4NuHfc/RIUW3
	+FPa64lnJRJn3yidaKcaKhvSPtHSv3J8nsw8i6GqMP9a5QhqyD6FE29UOrc/nx9MUjM9rZtP7iB
	7QbyOfRcwJFlHHVT2xHnerXDruqeiwJ2S0ADkfgLbZPteCNQMjYczJwaKhYG0I8tr/B0fCN2VJh
	i12rP4V6vDl5UQ0gUtLkfLFE2WSvs2EvarifyrQzHGRzdIYpG27nG20JqquD85zREW4GDkM0tFW
	9ebYP0KpSMV7r+afoCtXdH/gP0JyqPEJdYmRwTsjnBvx0IWFxjqqyRT6HVuRWDtTzya8I/ebESP
	eyNRC3yp8AdH1T8p14LFxwGlzcf+VaRss10pu
X-Received: by 2002:a05:6a20:6a08:b0:240:30c:276a with SMTP id adf61e73a8af0-2430d4753damr2032461637.39.1755588400256;
        Tue, 19 Aug 2025 00:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzseiVb89NiRC6C6yIK3eckisUcl6OaJcZKhsacw6pcx+RGiMXSxrapg1QR3zJ9Mo/cVVDMQ==
X-Received: by 2002:a05:6a20:6a08:b0:240:30c:276a with SMTP id adf61e73a8af0-2430d4753damr2032438637.39.1755588399820;
        Tue, 19 Aug 2025 00:26:39 -0700 (PDT)
Received: from [10.133.33.94] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d13d312sm1637841b3a.49.2025.08.19.00.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 00:26:39 -0700 (PDT)
Message-ID: <ff8287fc-7122-42e7-b6ab-550576b5d599@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 15:26:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath12k: REO status on PPC does not work
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <aJ7sDOoWmf4jLpjo@FUE-ALEWI-WINX>
 <d6f0b64f-1764-41cd-a7c5-fb34d034ace2@oss.qualcomm.com>
 <aKQg5vLUplzMUMlU@FUE-ALEWI-WINX>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <aKQg5vLUplzMUMlU@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FdU3xI+6 c=1 sm=1 tr=0 ts=68a42731 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=cCZxINV-pdffXXtfpT0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: rb7btT8TzVY5K2lPNF8jcFzGBpW3yuna
X-Proofpoint-GUID: rb7btT8TzVY5K2lPNF8jcFzGBpW3yuna
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDIwMiBTYWx0ZWRfX8otkat+wXJQo
 JNNHQVce/Nk3Q94SmZv8evuZ2m8EfFBMnHBdhUqJ52uRulGAp7W7uA1bbYcUOUUQBbhOObsofxB
 t9m1bWSPHIFQf8EvwI+xxjDJ/j+w6O+BE08JGHJ01oAURJKN3iYZb5rC6lW/RS4OSGdnYlSClMR
 ATrsMXw9g8cbYAjWMegKoBXOat1eNuoXXf2VtosGzsQDsjNyBVXnQN16173uxx68ev4sfjie8D8
 +taRKGrJCxe4B+rJ26wakYzUww8pm2KHHJ00e4fRbWE9gVYkPKlch3NyNOlavyjQHRXJcMR/BQ2
 XUzOTwWZT6UkpGEsOUbrl4b0ugkv5HFA1wU+PZ+wtAJmgLCbafuFlKEE4+yjMgrf6fWJSFw3ZFQ
 E7+twcHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508180202



On 8/19/2025 2:59 PM, Alexander Wilhelm wrote:
> Am Tue, Aug 19, 2025 at 02:38:38PM +0800 schrieb Baochen Qiang:
>>
>>
>> On 8/15/2025 4:13 PM, Alexander Wilhelm wrote:
>>> Hello devs,
>>>
>>> I'm currently working on getting the 'ath12k' driver running on a big endian
>>> PowerPC platform and have encountered the following issue.
>>>
>>> In the function 'ath12k_dp_rx_process_reo_status', the REO status is determined
>>> by inspecting memory that the hardware has previously written via DMA.
>>> Specifically, during the call to 'ath12k_hal_srng_access_begin', the driver
>>> reads the value of 'hp_addr' for the destination ring (in my case, always with
>>> ID 21). On the big endian platform, this value is consistently 0, which prevents
>>> the REO status from being updated.
>>
>> This does not seem an endian issue to me, because either of them we should get a value
>> other than 0.
> 
> Really? I always assumed the value remains 0 until the firmware writes something
> to memory and moves the head pointer of the SRNG ring buffer. By the way, I've

correct!

> already implemented the missing endianness conversions for reading from and
> writing to ring buffer pointers like this one:
> 
>     hp = le32_to_cpu(*srng->u.dst_ring.hp_addr);

I was actually meaning that, when hp get updated by firmware, either with or without
le32_to_cpu conversion, we should get a value other than 0.

So in your cause I am suspecting that hardware/firmware has never sent any REO status to
host.

> 
>>> Interestingly, DMA read/write accesses work fine for other rings, just not for
>>> this one. What makes the REO status ring so special? I couldn’t find anything in
>>> the initialization routine that would explain the difference.
>>>
>>> Could anyone give me a hint on what I should be looking for?
>>>
>>>
>> What hardware are you using? WCN7850 or QCN9274?
> 
> I'm using QCN9274-based dualmac modules.

sure

> >
> Best regards
> Alexander Wilhelm

so did you see any obvious issue?

