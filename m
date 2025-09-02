Return-Path: <linux-kernel+bounces-796947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FD7B409D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4264B7B37D2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6083375BA;
	Tue,  2 Sep 2025 15:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LoQqkchV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E4132C336
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756828485; cv=none; b=bXNKrVfu1rWfGCVX3AKNUbMLQmo1dEIesvNSITg3HJ42bEZKUTut4F2mcwXxB0PiCAOVIW1ZOAoPruhX+Av4de/LIwoThohLF1Nt85XErRxBZXePY3pf0JjtyoDOOROdL5ggZX3PWy5to0GrVspvpKpwvt9G8dt/8OxMdvvECTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756828485; c=relaxed/simple;
	bh=SIeqemmlWZjtTDFt63QTgsr6TSr3ywAaj+98hdV61Tg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mrqmqQSxn764QR/oosfaOlK+dgaTb1jVXOVnU8Qnp+iDpE1sqYVdZndaSSOuDFAHsQsgv8dq7AY7g9aGZmabvVJRTf5VvEonhwyT38LCVNjFIhxhMMmLv6BNxhqNOVfeMkxdeg0J1LPI4plY+F0WcjURvk8zcqOV0flHpido3ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LoQqkchV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582EqAUX001367
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 15:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H0/NKsmoyFLkbDVaC3DDw/RfCF+8mLvmzVh8l0oPx0M=; b=LoQqkchVSHE33PUd
	SkEU4hr3knPdoC293lQKOh6/2FHCILPARZK9yLo+VLMnsRuHb0QPvKmFJs9OHycF
	sTsBJciI/6+hfPLy5o7uIGM7wIPHbzWDiP2Ddr0/KJfPDYRNRTFvPlo/KCNguyQj
	p3N4VxH6D9knhtEDiZt2QRI/EDtRjsKfMCmiQYF4cDcLkUPFjAXwzWKvg+MXsLVU
	2BC51rRZpu+I6TneQ6EOfCCeL9+Gsp/mtUJ0D7C1t5Svafe6nS4oV7yW57xNg05T
	8G7ziW473qIKOkjdBVNY20FsMDiDgCDA8fOdgZIeFMScTa3Zv4jYFNrbJpGpvHQt
	KuFfrA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy47kh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 15:54:42 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70de1a3cec7so94718066d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756828482; x=1757433282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0/NKsmoyFLkbDVaC3DDw/RfCF+8mLvmzVh8l0oPx0M=;
        b=fXEeQHr+fWYWtZ0Hr1b85fQN/rhj/9Ho0vb4ODKAgU6WV+D0v9nOT6JrLPYcLz5vDu
         p2x3lIhCsmRtY1MUyPRL19WbYBbVudiFcnPca1ASxslhrgsFNWJHbWLpLqyRK9Q0FGOB
         wVBgOYnIJgCtKPWyYvp+HsHbFK1xlG6pszTsMl2hL7l+1o9IY+gwmV0Nv0OFz0NBue4n
         e81Po6sfO/BctBnjjs9e+vJIUYkXyZIP5lo0eiUVdFjU9iV7wWbDP0yVQSpwuHtHaP+G
         rG6TxZRCkJJJar8/reqgzjinx/K6dvCSWjDAETMSDbrLbTcQGrpMaf/GcL+wn+Zg3MH4
         A90g==
X-Forwarded-Encrypted: i=1; AJvYcCW3uXkGMWehFf6sSjYFhtBEiIPjpjZ6hWR/FolcAwjZivwY41RTgd/oLJwqPMDqCfJkPXOQQ3lmPuzOV7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVP0MiQGDQNmmngAb7H6kXuJ94MxsYkHhkXS1D96puwfKyYlZS
	uYhBfjkcHIVlEP/pcoQqqXHTcb63laNwpU1KFSQv8XR3vHMQQRhdvK3RAejgRzV97jaJUOeXS3L
	OkfPh7jD1fEmBzQMDbwI/AbfOAtZFT73BRGRSUSPtjG4eV3KCMR179WJ1uWx2MCbOjAw=
X-Gm-Gg: ASbGncsxxhTxaWfwuMOY8uEEJMsPJ2s4A3fIaF6ryhIkRbbaSq+pByp9OVxX67DcVHN
	X4e/1AOuv46G3WiBj4kCVuJpki+q9LwUZ5u6TpCkBmSiP5aUXksw2Pk8pFzJosqKoiyM8kr1L3W
	S61Z18kueTBwL4aE8LteuKdsYWCfNz7Tv6IoGwmh9SVSRmxbyo+fnDGQgEjmn7lkFa3cGXbHmDE
	Zx4g9TW+M8I6VybQjVAdsODU4wKJ795/IFBwlvOfiKWNwob0Ksfe8nUv5VnjqxPlCfgfexRv5SX
	tnNl6EK6AySMYaxO/sQ6ctjuaNuFdP+ox8IhJTXk86Cbax3FwGXKyg==
X-Received: by 2002:a05:6214:20cf:b0:70d:f719:df3a with SMTP id 6a1803df08f44-7209d44bc7emr31784556d6.61.1756828481834;
        Tue, 02 Sep 2025 08:54:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESgAsgiQPlE4blyzeowkiKWqxqSOmSkJn6p3dseobdu0TaIys417DbFV6epXYxdrrnD1xuNQ==
X-Received: by 2002:a05:6214:20cf:b0:70d:f719:df3a with SMTP id 6a1803df08f44-7209d44bc7emr31784226d6.61.1756828481321;
        Tue, 02 Sep 2025 08:54:41 -0700 (PDT)
Received: from [172.22.19.48] ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61d330f9f39sm6782677a12.14.2025.09.02.08.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 08:54:40 -0700 (PDT)
Message-ID: <be8961be-2964-4571-9818-b5a23867b27e@oss.qualcomm.com>
Date: Tue, 2 Sep 2025 17:54:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] SPI: Add virtio SPI driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
        Haixu Cui <quic_haixcui@quicinc.com>
Cc: quic_msavaliy@quicinc.com, broonie@kernel.org, virtio-dev@lists.linux.dev,
        viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdanton@sina.com,
        qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
        quic_ztu@quicinc.com, virtualization@lists.linux-foundation.org
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
 <20250828093451.2401448-4-quic_haixcui@quicinc.com>
 <aLWMZH3NTfM8qOUy@smile.fi.intel.com>
Content-Language: en-US
From: Harald Mommer <harald.mommer@oss.qualcomm.com>
In-Reply-To: <aLWMZH3NTfM8qOUy@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b71342 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=zryznllHkYnWp0Pe4IwA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: UwufyB2p0zDy5ydR8b-lHUEZUj5zlvgU
X-Proofpoint-ORIG-GUID: UwufyB2p0zDy5ydR8b-lHUEZUj5zlvgU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX7Ki3pkbBgHfN
 XjmhKjLYK09JPcCLkusT4PHkjdjVUts9uVGgi4EnBDIyrmrdd+S8IFp5WVBV3xQI/41hAL37LZY
 Xkin3cwO5hB5Vkz2tM/WpMj91yK1vhOyz2Dg53hC6ompKLS1TWgtWXIduFnTuuzralRpaA0a+nf
 srJvmoRFN6IZypPQjTEd12sGqELBRj0WttNClQyHP1dr1YCVfaNiDQKXUzMpfqY2XNQIby5s9ng
 eZH9nZFJiOBEhE8C1CzYPae/sabZto0uhEcKapTPNvIUtSGihj+EPfRDOkqqM+qsSUFXyQtxbpC
 dbCH33N4TQ03XKA/iFdbXlonVMiOQ9KuVV/aVc/abcdl5w8JNagF8LTnENQN7K4ImoZSEU2RMS5
 G+i/VFpB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

Hello,

On 9/1/25 14:07, Andy Shevchenko wrote:
> On Thu, Aug 28, 2025 at 05:34:51PM +0800, Haixu Cui wrote:
>> This is the virtio SPI Linux kernel driver.
> 
> ...
> 
>> +#include <linux/completion.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/stddef.h>
> 
> A lot of headers are still missing. See below.

The driver should compile with the set of included headers.

> 
> ...
> 
> 
>> +struct virtio_spi_priv {
>> +	/* The virtio device we're associated with */
>> +	struct virtio_device *vdev;
>> +	/* Pointer to the virtqueue */
>> +	struct virtqueue *vq;
>> +	/* Copy of config space mode_func_supported */
>> +	u32 mode_func_supported;
> 
> uXX (in particular u32) is defined in types.h.
> 
>> +	/* Copy of config space max_freq_hz */
>> +	u32 max_freq_hz;
>> +};

u32 is for sure defined in types.h. But looking into another device (gpio-virtio.c) I see that there is also u8 and u32 used and I don't see that there types.h is included directly in the C file. It must be included indirectly as the driver compiles. Same happens here.

I'm not aware of a requirement in the style guide for the Linux kernel that all used headers have to be included directly in the C file but this does not mean that such a requirement does not exist. Can anyone point my nose on it?

Regards
Harald Mommer


