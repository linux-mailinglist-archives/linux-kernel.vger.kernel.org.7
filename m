Return-Path: <linux-kernel+bounces-846201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDD7BC7449
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 05:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 691DC4ECBDC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 03:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB65217736;
	Thu,  9 Oct 2025 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ND241/W6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBBE2144CF
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759979146; cv=none; b=IGg5XqI+7z6ANqKRKyRK+evmD+JVPd74cEZBIQNNVik08BEO+om8eTo7KQ85j1dPyB60X6NZotidEGFZfv2LZGti/ocLkmejdsMF0zPl9EiONNudIprI520T0WuyWpqdBTGZEZFsa0uthZ6Zq9twoOxMK68c414CARisCx65F8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759979146; c=relaxed/simple;
	bh=adDtwrABqJItP/LyGiv+12nt0zW4ItDbkMVAAXVZyZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxvH2c7Vepu9xAxK/S95RytVhirupykwtYVCARo6RTED7ep6Gdi7OZA35iZQwomVftAZZajxduGa71VNM6pHht6rZWq41P6ErGYjQcsXgG98FFpfneDgo+SqTjLill2JTL1ygK18RQZ3yFySuudN3JNBRqgKLFsPS9yUOSwaD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ND241/W6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598I5HcL004429
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 03:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	maw0nAtOoBVHhqJ9ExerU0/ECtcBryU6vpXt6hYX7LY=; b=ND241/W6roZpTLMY
	8lUSgg8HBk+LobuHZI6DurU0YtpM1lVcdu49kvkvHfia6vg8KMA8LTNv3d3fLoPv
	aPzhoQTGWwc48lgdBV8VZdRWVP7PV9IAXi4Sis6ZiHTejJG/NeQRhTOz9AL1aQ3O
	VupH+Bq11JzqA/S/qA7U6ibACD0C7zXGqjrDNT+2JZH8SeAHUoZoKmFtznMRFeQV
	Mdl95/Z6iEk/6mIGhBvYshkpFOJq2xEZh3TOyWpFiWxj50RQDZZoO82QHiQ7kRj7
	pVKCNC5sVxd/HpRbB3TuKdunx8/LE7v9Gng5KMFxvZpnMwOjpWskaXCg6VHdYJiv
	KTmPdQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4ks8hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 03:05:43 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269a2b255aaso13765815ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 20:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759979141; x=1760583941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maw0nAtOoBVHhqJ9ExerU0/ECtcBryU6vpXt6hYX7LY=;
        b=V1EVKp2AS1KeauWz7mca6Ikr1xnCE/qVhlFq6Zo6HNx8ePdYOxr566hDS7ejY1vaYK
         nzwiVPr2Sfpr3ATq1HdFo8vVIm3SAZnsn/MicLf1X4wJI+aBWjieh2PuVuCUdMVXr9Ug
         UaG+L5MQ1BfVqU657rLxxytsF21hgHDId+4pnZt9U6+hNmQOgJXCG3/9sxxsnO9mHhvq
         OaGxAkExjLlmlAteiNlz8PPhLdOc/9/w+GMVmOeijyWnlenzZLYHkCqB5ixWLGsy6tUk
         OZ/yc5PdFpyDWPWKd6s1OJHPjs26FbfwduuRnwKMnQbxlzBhODMw5LOk/eUoJZ+F8BzF
         BV4w==
X-Forwarded-Encrypted: i=1; AJvYcCV+VcxrRuch0E+hsAtdOoIpQm5WXz7iyWeZc+v6Cv8DmzC+bdNubnvXPYvhTjmfVJL0v0AHTy8dmGFSY+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMVcR9LE7i1i/kwJijLK8eDl3SZtdy35TiZee3PYt3pDt7h5iW
	Jpq6NgUfMeAKwnVF8IyCIapNIs5vcNugOYrPjEqdoYV/RvZk37fQiG6+Rug4Y+ubA9J7cY9svQ5
	TiIxNr5Mb/7P/T37xuHrYSriSfzfscsj7zQ5Q37aX+4Uy8VbIcp0FHM6kZMrVlBbEb55ARO8u43
	o=
X-Gm-Gg: ASbGncsB8lD1gqUIBbmHa3vwFDTp8N1WbCusJN1Jn+IfcP6oW3FMvwYpsYYunVpLSTv
	EaL7Uo8E2d/kBX949VmJJhQOqYwo7j+in9lEHx7gPnTu3LI5SXpmkfLZ/hnLcJ00J/5HDxlG9bC
	ASiAOgg1nJbJWry/gSCNCHw9nWogojNxTyVehvgapxfXuD6d3rJ73L4dtW+mX7lZwCJ1ajk7RqN
	e762VyxRlw+5kQ5cMXYswLN1bUxF6m5FEZS0wg+tJSlL3l9Jd6nLvHP+MZBLdOx6z+DTSDgq3EC
	PQiJ/94hUQPFLSiG+WqhlUaHEkOzl5wg5y7D4sTeF5jpgBSx9YKSfg8VHqYXPezYNKeBBfWUi/V
	x/wnK
X-Received: by 2002:a17:903:37c3:b0:269:a4ed:13c9 with SMTP id d9443c01a7336-290273ee214mr75265275ad.30.1759979141306;
        Wed, 08 Oct 2025 20:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnBY9dBUVR4JO7ffBEWJAcyiS5SqEqUqPfk7J2CB3UN/A0lC50/P3L8vjezocgdBSm41IWow==
X-Received: by 2002:a17:903:37c3:b0:269:a4ed:13c9 with SMTP id d9443c01a7336-290273ee214mr75264785ad.30.1759979140837;
        Wed, 08 Oct 2025 20:05:40 -0700 (PDT)
Received: from [192.168.0.166] ([49.205.248.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f56c04sm11854475ad.110.2025.10.08.20.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 20:05:39 -0700 (PDT)
Message-ID: <1151394a-5f76-5ba8-bd5b-0635a9a57be6@oss.qualcomm.com>
Date: Thu, 9 Oct 2025 08:35:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 0/3] Introduce iommu-map-masked for platform devices
Content-Language: en-US
To: Rob Herring <robh@kernel.org>,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        saravanak@google.com, conor+dt@kernel.org, mchehab@kernel.org,
        bod@kernel.org, krzk+dt@kernel.org, abhinav.kumar@linux.dev,
        dikshita.agarwal@oss.qualcomm.com, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20250928171718.436440-1-charan.kalla@oss.qualcomm.com>
 <CAL_JsqK9waZK=i+ov0jV-PonWSfddwHvE94Q+pks4zAEtKc+yg@mail.gmail.com>
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <CAL_JsqK9waZK=i+ov0jV-PonWSfddwHvE94Q+pks4zAEtKc+yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXz0m0ItQpTh89
 s3KfQCtmgm0xrpKKanYDXlRTAv84WEUFd6mER7REzwg3oqrqLCUXKsznx16JrBAfL7CPRS/Sr0Q
 Tbq8ivjaCl82hhBAU8R/Ulan17Q8LHnHA15btmpH29A4dRIscolfr6Cj2WNS8rt8Ss6pDHtysVx
 gbpxbdf+f9+VPlLPQxhade82YTkozkfy3IOdkZ4542JYIKGiB7TouZ41GnGYGuHdYFF8rDgPTbS
 PG+DgPjV9m90HFpF/NXPeJrDpo6Xxj7PLfQHP4bxKx44ndFQJ9nRpTXWVjFz6rLbZ8+JQ5tyGQI
 7fou3jIGo0eGy6YxuJHV9U4iLAwvj8EkdftU43AV7y7gGiAB6SG3JNde0MezLmd0m2GLRge4ble
 mN1NPbLpQ6j0R5J/Ynboon276n/1ew==
X-Proofpoint-GUID: laSFJL3fQoy6H62C4bH7n4LCssnvKRTr
X-Proofpoint-ORIG-GUID: laSFJL3fQoy6H62C4bH7n4LCssnvKRTr
X-Authority-Analysis: v=2.4 cv=SJxPlevH c=1 sm=1 tr=0 ts=68e72687 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=5kJkhVZBw43gkfrlxLPpYw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=sGZhk1M-rbKiZVnir_gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121


On 9/29/2025 1:53 AM, Rob Herring wrote:
> On Sun, Sep 28, 2025 at 12:17 PM Charan Teja Kalla
> <charan.kalla@oss.qualcomm.com> wrote:
>>
>> This series introduces a new iommu property called iommu-map-masked(may
>> be there is a better name), which is used to represent the IOMMU
>> specifier pairs for each function of a __multi-functional platform
>> device__, where each function can emit unique master id(s) that can be
>> associated with individual translation context.
>>
>> Currently, the iommu configuration - at least for arm architecture-
>> requires all the functions of a platform device will be represented
>> under single dt node thus endup in using only a single translation
>> context.
>>
>> A simple solution to associate individual translation context for each
>> function of a device can be through creating per function child nodes in
>> the device tree, but dt is only to just represent the soc layout to
>> linux kernel.
>>
>> Supporting such cases requires a new iommu property called,
>> iommu-map-masked(taking cue from iommu-map for pci devices) and syntax
>> is:
>>    iommu-map-masked = <FUNCTION_ID1 &iommu ID1 MASK1>,
>>                       <FUNCTION_ID2 &iommu ID2 MASK2>;
>> NOTE: As an RFC, it is considered that this property always expects 4
>> cells.
>>
>> During the probe phase of the driver for a multi-functional device
>> behind an IOMMU, a child device is instantiated for each FUNCTION_ID.
>> The call to of_dma_configure_id() on each child sets up the IOMMU
>> configuration, ensuring that each function of the device is associated
>> with a distinct translation context.
>>
>> This property can also be used in association with 'iommus=' when dt
>> bindings requires the presence of 'iommus=', example[2]. For these
>> cases, representation will be(on arm64):
>>    iommus = <&iommu sid mask>; //for default function.
>>    iommu-map-masked = <FUNCTION_ID &iommu sid mask>;//additional
>> function.
> 
> Where does the FUNCTION_ID value come from?
> 
> Why can't you just have multiple "iommus" entries where the index
> defines the default and any FUNCTION_ID entries? What's in each index
> is specific to the device.

Are you trying to suggest something like this [1] ? I am not sure, if extending
the iommus would get us "unique" devices where those SIDs (from different
function_id) can be associated with respective device. AFAIU, existing iommus
entries associates all of them in same device.

[1]
https://lore.kernel.org/linux-media/9bae595a-597e-46e6-8eb2-44424fe21db6@linaro.org/

Regards,
Vikash
> 
> Rob

