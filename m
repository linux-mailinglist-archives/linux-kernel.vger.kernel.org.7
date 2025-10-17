Return-Path: <linux-kernel+bounces-858168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8139EBE92F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB6AD5655A2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC816289811;
	Fri, 17 Oct 2025 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V9pErdmI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754EC33970F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711122; cv=none; b=MwAiDmZRfYYjb6tvK4o3ez8ugy+yU4eUqCO8CNEbWM5B5hTxUFKbg+/vwzqVYx9kIZQ+kK3WhbM7rfEeIhmUjEygFEx9lA9rIOY6ZcY6KT89axob35V5HUFEWRULZ2QeOr3J7KgJCiD35r8PZeQ96h1erbWEcqOxqm6SO/r4IS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711122; c=relaxed/simple;
	bh=WvPiwTls8EwkUxiAY19dvsorF4ZCWBhUHbOY89tSmC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7x7c+ofAPPsQ4JvePmbCel5vBN2txhW8KMNfQTmT96PBGRsEy/ngP1SQErbcuMGn7ayqE89P7Hyt5QbuKCjVUiXyQbwYBiRL8nrUVfLUoXQbmaj7u+cnlrklMyL5jBgLMCemk/HrgNeBbmNwy2ljpbhFRHILLxQdh2LCmqHXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V9pErdmI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7bV51022181
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X6I4YOibOxnI0AMuF9jQqhBPQ7jDc9rITl8QqtHTs9g=; b=V9pErdmIvPeRmzT8
	Fo9QxijlwjOsM/Tl3rHj8cXNaN4ElNURNUB9PNqCurg1wp6PgVRfhZoMOh7ohSB9
	ciz518YlXJjgB5jyj/bWOor02A7aQZurvS4YTPzsY+r9Tu5oczy2q/3xPZctY/1C
	adSCpm9pQU5xAdbuQ8OG2AA5q5QUap0EHmo8sRIMS8e/2vDSe2I3MChYFMbnrRcj
	0pW9Hhl4u2oyBu7QkDidC/eNg5kHGvSBRe5sTWqA2uHy2tD0eazWN+vf0kullEVu
	BYihnVk2HjBjeIWuO+d8aV57ns5OsDa6Pj4EF6gDuLaxQcPyG2K634F4fFPM3N33
	iWbU0Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrthg3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:25:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33428befc49so3311679a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760711112; x=1761315912;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6I4YOibOxnI0AMuF9jQqhBPQ7jDc9rITl8QqtHTs9g=;
        b=n4LRTrBnKJphbbLfpuJ161QH6q/TSbaSowIb6iiZe3VlhlNc8V89deVq03qcG/uL13
         Nq9VCXSf9CTYT4bCYLpVwWnhsV4X529NRfbDpp2gtUrvjbnXIO9rIGWPjIb/WXOqPlz2
         KA9ySJZxlknRHzKDjOoYkJPi1Q8sqBiX2xV1mJoRatKwdTxyr3GPiX0zxOoXpKD88kq7
         PHMp8C1KdxySfxdC6pUgs7dudQnrAljysdTH27LJiC/MqmeDA0z/YSFR2/jmO34LSDI5
         03U6we9oSJ16xHajbVJ0kk9XQYEp6A2EVqzoFt/mg+s5niDyp44Q/uAgKLS09P4335hT
         EG2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL8bYFbpKG6XiRCHuR+Yvq3Z//ILWwIuEjcCdTxhndUGGM4e20n4jQrAPYebfC9uPR3wiypdzitBM/bck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3UjIQgYvMAiUJj4tmZHuyMtEpG1NWQtX79gPPKizgttFVdBwD
	jIhBGBb8kmbg9MSa5DwXyLjCJ+NjDHCeYlTiUb61dDjkK6hvKt0HOcnz2JhMEU8Pn1dxW3ynBFm
	O9V8i488LItXQLz4SGqO2zxJNJcFAsYRtzY+2l2ylGRh0SezeFbo43arz9NmQO66F59k=
X-Gm-Gg: ASbGncstwC/d7spOZFhdh9zE715n2I+o+boRSDapXRBZK3y+P3/EKKtjEbGGnx9GSsk
	J40bj+e1RfAqhKV3+VhbnSoQ+8cPqbmEoevVV1pMIN8aWTlfZNTUv/bvCl1KEnjmmU75v9ROYpV
	qG6VNxtlcLSi1z+5e8chun0pOLgdp7yg7wRV5j70HZieOmbuLf/VhXWEkubZ96p6A/D/mJjWgRX
	+D5SxPd98UmX/h3bNDYpXf6wbdxgZuzkEieU8X3hx9tvct2KRdLLYAqy1Z78smWthevry//YZf8
	S44HRL/MOQ32Bgo2zdTmsaQDVCaTuf0jCsQs9pcpbs0SBpqbGHScRip0WxgWI51qyYD1oi7BuLm
	RAvnmS7vnVX06aYdFtPyvg7DexSzCydWXiA==
X-Received: by 2002:a17:90a:d004:b0:32b:94a2:b0c4 with SMTP id 98e67ed59e1d1-33b9e2925e2mr10031251a91.16.1760711112023;
        Fri, 17 Oct 2025 07:25:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpzi1hN1yMdY6cSIJhZZaWyqTeCWz6N72ovTz031iQmmVMeTy7gJVlncPuK2idTupafEuVXw==
X-Received: by 2002:a17:90a:d004:b0:32b:94a2:b0c4 with SMTP id 98e67ed59e1d1-33b9e2925e2mr10031171a91.16.1760711111346;
        Fri, 17 Oct 2025 07:25:11 -0700 (PDT)
Received: from [10.216.52.245] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33bd79b344dsm3149510a91.3.2025.10.17.07.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 07:25:10 -0700 (PDT)
Message-ID: <0683413c-b447-8e3e-8bfd-3edce5a0e14f@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 19:54:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v16 02/14] power: reset: reboot-mode: Add device tree
 node-based registration
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel
 <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik
 <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Srinivas Kandagatla <srini@kernel.org>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
 <20251015-arm-psci-system_reset2-vendor-reboots-v16-2-b98aedaa23ee@oss.qualcomm.com>
 <CACMJSesvTLe28Jz83b=zfHD2rvmf7-i_2+2DoV=dgooVqFEYbA@mail.gmail.com>
 <fa42adf0-8f15-ad4c-3788-578b1bee1c72@oss.qualcomm.com>
 <CACMJSesxazA7Nf6sAhUT16KfwtiUNjvb5JOEWkEb1B5fJtihMQ@mail.gmail.com>
Content-Language: en-US
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
In-Reply-To: <CACMJSesxazA7Nf6sAhUT16KfwtiUNjvb5JOEWkEb1B5fJtihMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: NiWpbMYnYvy7mHdssZ_sFOIKNEC3M63w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfX5Uj8LyH6e7Ag
 bN7Bka0FdcWiti08Dm0VfKige2aoHmNvzRjV9XvkBLO8myYSYS9MjgXvgnlZ7K0xARzcm54k8aF
 4y314qUc80RRSRqRRg2WPCJEqHIrnuuebW3+RQ45vXTwrAi6YUgaS91oP9ZXaCThJ1og8E50hUD
 2ZCu2Tdf8+cvLpBs2i123AXN4ONu6D1hH9AbR1c43oU8Odtbi+Bm4rKwo4d/SzBs+kPh4icNNsE
 x+q/Svum4uab96H1X+rBGgjcDT8OfYozW9HkFWdlhYVi9zhIBZqRwxqQHh3It6u3PAOaF2YMxsU
 QD/O8ku7XU3I5u30urHgywlpVUh25ZeWkg9bjz14iTfuMtAW6yHTklYRXBH4dN+rTwBAgDmeFaf
 p649RCaoWpIB4MMN27FvJY6Wdtshjw==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68f251d0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=9sdP-RPgOja0Ng7vnc8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: NiWpbMYnYvy7mHdssZ_sFOIKNEC3M63w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022



On 10/17/2025 2:36 PM, Bartosz Golaszewski wrote:
> On Thu, 16 Oct 2025 at 19:19, Shivendra Pratap
> <shivendra.pratap@oss.qualcomm.com> wrote:
>>>>
>>>> -                       info = devm_kzalloc(reboot->dev, sizeof(*info), GFP_KERNEL);
>>>
>>> This change is good - devres should not be used in subsystem library
>>> code, only in drivers - but it doesn't seem to belong here, can you
>>> please separate it out and make it backportable?
>>
>> sure. Just to confirm we should separate out the devm_kzalloc part of the
>> change and add a fixes tag.
>>
> 
> And preferably put it first in the series to avoid conflicts.

Ack.

> 
>>>> @@ -123,8 +136,11 @@ int reboot_mode_register(struct reboot_mode_driver *reboot)
>>>>                 return 0;
>>>>
>>>>  error:
>>>> -               list_for_each_entry(info, &reboot->head, list)
>>>> +               list_for_each_entry_safe(info, next, &reboot->head, list) {
>>>> +                       list_del(&info->list);
>>>
>>> Same here, not deleting the entries currently seems like a bug? Do we
>>> depend on the driver detach to clean up the resources on failure?
>>
>> sure, so this should also go as fixes? and should we remove the other
>> dev_err(printk) also as fixes? or that can still got with the change
>> where we add fwnode based registration?
>>
> 
> It doesn't seem to be strictly required by current code as the users
> use it "correctly" but if the API becomes used in different ways - for
> instance the structure may be reused after failure - it's a good idea
> to backport it. In general we should undo everything we did in the
> same function if we fail at some point.

sure. will update it.

thanks,
Shivendra

