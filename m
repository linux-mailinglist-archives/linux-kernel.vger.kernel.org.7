Return-Path: <linux-kernel+bounces-751883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C088B16EC0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D541618C39FD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782222BDC38;
	Thu, 31 Jul 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z9CwkqhG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6D2206B2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954413; cv=none; b=QW0BHBOsPWRznLr+EN5Aw10nR3wv18nS9BeCD2zdkDBKWULfeOVPbVYiKYrLg6GIo018n962AB4o/Kf6hVrS3ADarkLHg8IjJMzSTNp/mmlVtQypNg4OoJ2vpvogiOnLjtbcTuiTZ2rq/9Zobbabk4WOAr4gcP/49NcaLjKnNM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954413; c=relaxed/simple;
	bh=C9OYPWcWgVHV/CiiGcURO/bIPuqAlqLabGz8H5AqQlc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FQlPZdncnERd1KxVCASNz8kgrSL+MiziIHwekVB+bqE50hEL4cxpVJ6nkHmpJKIFvmNngUtTOJ1lUPHixoPjh7jXKGBIf8giE8luF2N0drC3Nwv6UdXCww9n8X0WTVxL3IXxE/TI9C/UJr9YRYYXEdoZF3PNkl/ml76aWpO0fjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z9CwkqhG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V1fODP022183
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:33:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	82GPBT7CuEhijOA1vnxlMQVU8JDV/YKIyW9zLCTeOyw=; b=Z9CwkqhGXw5ThcGq
	a7cZu1W2BHNIkHgIFw7U4kPWFNctX/Rp8GYMj/yo4nyA2zOfeBI64E99zT2Q/z5x
	1hp6Pu/eg/e4X+UEiPGjd4rxs7WzbUZnkkhs1dwGb4SqIlZtpxx2f3LnhjkBRFm/
	o0FXPvTZa+msy+PL4FtTRQDqDhbZEI1nie7RG6xRCj86Zp5jQLodPcoAovoh9Zdu
	OD3xNHK+5oy/aKVSgAnlvCOi2R4B5UStikFD7kRqkVfKVf6Z2cibX5pSfonKWsMQ
	cfpVq6QDWxzqNfCQndzdV03y2yY5CINOf46QuZ4p5PjkUKzGY01mYNbsdnBPXgN5
	kacy2A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nyu7hx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:33:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e686981baaso1961685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753954409; x=1754559209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82GPBT7CuEhijOA1vnxlMQVU8JDV/YKIyW9zLCTeOyw=;
        b=ZXpkw6OSlMUVb04AygxJG2cXzzqTXviZZIKRoBq106MfimBKL56D7s4Iwj1znne37Y
         chNJ4mmy21COot9m0AEy+k/9gopFxPvMTDQkJdilbj034ws4jpjMWGG+IA3JW7vQy8AP
         I6jbWRXHh9UNNmoSiFSX6R/GJSF/XeJHhNMVHmKDkpNAO1IA9I0AR/TYVNpAUueNgibU
         Z030Ysv1fPoZX1r8/LU4qhRIOT62Bd3yASr+47FHGwHT3COX8ztL4levD54DfiEQgMuv
         6xu2WYexT1eauR1+ECDriL/DBTX8c76DlWav6Q8m46xdTP2c8te0D00fQpW/SJSxWiph
         WRpg==
X-Forwarded-Encrypted: i=1; AJvYcCW45slYZ8b6m3KVpzwG+ctW+DDjPt95mlEOGfu57W5l6IQLFH+ujC9uCjp19FlVhotqVUnCCYjsWzBSbNA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg31UvUXm0s++flUV64gOEF01JsTiu+asMlG4dhornuH77V6r5
	CEw19fuqVK+pVRkRciBg9Iy7fWOznuoyW/rTElbWr3NGS6KnLGHnqwqAAte7MSJVVLnhU1omG+C
	3jde3PmZpb9Xxo06J/p99a/BOkXtK2YP2p/7FKf3b5s90ApqL4HeYPtO5TTnKXOCMjS8=
X-Gm-Gg: ASbGncuXqxkvLTsaxUGCbCncJsEWti4ftU6lmwigA2XsZtfEDP/IO0mbOg+hshUk3vd
	j8msxMbqnlzDZJqqx4yHM32pw6TCw79M94yHrQztFStRQ9FQgZcEdjh83l6AkGKDY7ljyekGW4Z
	UG86btMkS8YdgqaDPdt5596Rrg4QBJ9m0GNTTGEgwxNePkb2pufPFftuqFzlWaspf55GwX4hu7s
	b8EtHx6xQT4PkXf/noxpagaE482hqqr600FifuQ7c+RjQ461QYo/DtQpKaUJNyWxHLRr/GPno4J
	ACphmEQRUCEZdKy9GKctSaQRjK4SIQnSwXrcWBXpavKUMjE6OTu26NaWcuYu2Zcz77PHpD65E3P
	HtelVVn4B8RykDy0tHw==
X-Received: by 2002:a05:620a:1a05:b0:7c0:c024:d5 with SMTP id af79cd13be357-7e66f045980mr437147485a.8.1753954408935;
        Thu, 31 Jul 2025 02:33:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQJbanGKb37NjK2QkIb/mPbDk8ovAThngSePHzP6HkMxpYQ7Yf3dg+lzf6M7ZNTkULo79eMg==
X-Received: by 2002:a05:620a:1a05:b0:7c0:c024:d5 with SMTP id af79cd13be357-7e66f045980mr437145685a.8.1753954408559;
        Thu, 31 Jul 2025 02:33:28 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a3e80sm81864266b.47.2025.07.31.02.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 02:33:27 -0700 (PDT)
Message-ID: <2496bdb9-2ad6-4fdb-9a35-e9b8a15d744e@oss.qualcomm.com>
Date: Thu, 31 Jul 2025 11:33:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] leds: flash: leds-qcom-flash: update torch current
 clamp setting
To: Fenglin Wu <fenglin.wu@oss.qualcomm.com>, kernel@oss.qualcomm.com,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: Subbaraman Narayanamurthy <subbaraman.narayanamurthy@oss.qualcomm.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729-fix-torch-clamp-issue-v2-0-9b83816437a3@oss.qualcomm.com>
 <20250729-fix-torch-clamp-issue-v2-1-9b83816437a3@oss.qualcomm.com>
 <f3c004a9-dba9-48b5-9930-979053d0a32c@oss.qualcomm.com>
 <e0f827e0-1552-4542-ac70-70903227734e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <e0f827e0-1552-4542-ac70-70903227734e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MsnqLOkgac9CzRjFKpuUuaw0Wzp-dEZC
X-Proofpoint-ORIG-GUID: MsnqLOkgac9CzRjFKpuUuaw0Wzp-dEZC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDA2NSBTYWx0ZWRfX6h5RxZHWx3LY
 xl3iyL6WqbqZMhP3ULzswlWrTaCOQVpBVhmO0VWSBSE9if6Gbj+Za/+bjZqqpDrOTYTI0ccRVBj
 y2P6mQodnY/UNKjyW78TW4EEZTSI9n5C9WixfYcmKK3oDx77FsE0K4/LdW0HMvoKM8PltUYeKpV
 HKqUedsD1oCPYVVTSD1fq0f7WBZBaYIVRfOhymxSktRTwaAJIbbe3HslTvL/qLTwd5Dpj5zBIqc
 c2ULF0qh6YOB/NVkx48UQk6hA8hNHYUwhAYRNjRTg4vFwy5Gco2JIk9UZnEjLQI7LWp9LqwTS5i
 lVkmp5kicw/QkJ9+yy41cMPFGaN1B8gudYRIe0XhSaJfSG8rGucnppRp5eFDs6XYoa+5q0OY9B+
 yEM1RDQpsCclaEc2Zp097Ww6CI2WZNyW1BMWyMi2Q/cJPGo42sf7vxmdlNvy6sVOjHbCfTBa
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=688b386a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=f1a5bq8nv78Meu0PtRoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-31_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=682 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507310065

On 7/31/25 3:43 AM, Fenglin Wu wrote:
> 
> On 7/29/2025 7:01 PM, Konrad Dybcio wrote:
>>> +    torch_clamp = (current_ua / led->chan_count) / TORCH_IRES_UA;
>>> +    if (torch_clamp != 0)
>>> +        torch_clamp--;
>>> +
>>> +    flash_data->torch_clamp = max_t(u8, flash_data->torch_clamp, torch_clamp);
>> Please confirm if I understand correctly, we may have N flash LEDs
>> connected, and this additional safety hardware can only compare any
>> individual LED's current draw against a single maximum value, which
>> we're setting here
> Yes, your understanding is correct!

Great, thank you for confirming

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

