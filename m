Return-Path: <linux-kernel+bounces-888353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 759FDC3A922
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE9EC3510F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F630EF98;
	Thu,  6 Nov 2025 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f53txkOr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fADpZRzx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0A4309EF1
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428567; cv=none; b=CidZ++JUDdn8o2bcnBRFLk++Qy53azsO4li+auxWp67qkRnCfd23lC9aW1z6wrGNDukU49NnLqRrLqfrxTyboEb93ZKapk+049G6Ry5J2PPQ/C3lU8f31FPqzZKCl9DtDyDzcmoe36O9kD16i7Wl/PA6ZUBX+NqIKEM8w4OcQ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428567; c=relaxed/simple;
	bh=WiXwaZ7wk2ejbRxQyW4OJIj/24cbdJjgusG6PUfSP3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BYlQ8jDVYbp65mMYtTNZtQ6oDCtDSkEdHtgBQyTTGCjOpJI3oC3FbYmgwMlHCoGCGJ+X8LxKQe/FIPFKEIYPhrYmsECcGDDGlGJKpvTO3gp44iPiXTR9QiZksyzKwaH/KnjYi1y1VE9V+6o/aVUIWTbWA+2I9tm3g9CdL1wAcr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f53txkOr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fADpZRzx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A68kKkg2326595
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 11:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=CpG0B9NdSTpR4vRsiBshUT01
	BMltg9VAt81WmjUMcSk=; b=f53txkOrNbj/o1C3+AlDeemTjSLBHjOtJTUw8CU5
	/n5R1Ezk43jPqZvRRGhHXKBtWCcLlrjVs8rP91gefWrJHCZl1/z7RNZzxrSI8y2V
	FzTX/M5dWM9+uoCsLOcCnWk0L/gYiLyqnP+jruAuwdq8hXseVjEysTC0D0fCjm4F
	+FaP94X7tyjUKI5s3g+8E8G9D9Ym1kKQDwYJ4awGbm99RNzXeEkqFQB/RHXCG29j
	XxuDlTqc94Sa3DX8Sp8FRVtR1FoQarQ6f/R3LvePE912OmvxHc3c/6ZOOIkw8a0M
	MMymppl4rwbssT6t3tAW/WhgiBFv4v0b/xR4Qlgemhf7rQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8h0v1pv7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 11:29:25 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e892f776d0so10253681cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762428564; x=1763033364; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CpG0B9NdSTpR4vRsiBshUT01BMltg9VAt81WmjUMcSk=;
        b=fADpZRzxsjSBeNGfunJLcMHFyTI+LIw7nCgn6Nawyln8Ps13FIBuNLleGHLc5HVRpX
         XA0GrgBMtSoBweKcA6CcM3mNM2IgGyzDo1HfDOzYa3tVGgY/7Q/qv9hSN0FbD8E0Ay+J
         AFJleq7voNUWHlKc6O0V8Fz23g42YBv1aPrWVtZO+f2nca5U2+Qk2UI3O/8uVus4pQYr
         plGDgbr1NTQBqLauWUY6cHQun4TojMtUMhES2EbxJPVocRJE/St1A9IEHHwwQCsOYcD+
         dFWZ3WJ4J15jxUDdgPA6BgW2Ante9P6BeEH/cd0JhXQUif4cj5lM4P06JO2WOX5eoR89
         pMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762428564; x=1763033364;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpG0B9NdSTpR4vRsiBshUT01BMltg9VAt81WmjUMcSk=;
        b=qeoa93VktY9+AF07/qgQm6zCbz6ADp6Ddz8n/YeAlILZ+55hOr5Sv/f2UQ/IwIvtJC
         nv171SrCHz3LrjxoQbuPC+V8kpN82MwAF3rgzq4RMkpwa+4lNvvA7GdoLS/7/HqNgqsM
         CJbiy15PxR41ykfRPLEp4p26+P2KbHK3FPHmw9b037+UA0RYzXb0OBezCkGYdE9rMSoQ
         lv/Iht0L8xps1McGSlJYNZJ+VdeEukvVkLtBRheuyH3xEPx4CZ9VNUDItf3l8X/qHuf8
         1Kxm/B0QJAjXZJ8/hE2dRmFDl8OBdmY8ApsdVWfhIW52VVw2lWgiGjbI7NvReI9uusOp
         NJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCUaYNvIEHqUq0bkA5LPjZ+bHfVDfNOLiFlzGe46G+nQWn8uxfwt1DiF6S7DBztzvqA+1BiH7PjswngE7/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQiHiwQcrKhJ7jPa5MEgxA/1sp+AntL4iscdCAwPwUnSLhKyMY
	8R5OvTsUpZK8O2/xFVwRzt3374GFwEy64BKSIokThvv3rrNE4yW4Cv0QSFbj1t1USkHjDpCWQqP
	OBkw0fwl7v5gfuo2X66AzVhxWiUGX7RJtDdbJVkMLRHIsZfhcoUSfOvgJx6atBGot/3w=
X-Gm-Gg: ASbGncvhtvmmY+2jo1bcZHnAQBeavJhUcp94bJ3qZmwl6mfIADTmTWrXeQsIB99rfuY
	4rIOatFZND89yiTqNU7bL77liQ4PMm1D8Cix2mA97J7bWNHtYABa3UHxBv1G3F47Ab8jUs3n+2X
	XH4KU9Hi2A2rso/ZEP+zAoCCbY/LtDKbBLqKyS5mEbXpGwdkBQqY8V1jWHGH9HEIZIohhpsn8Dw
	miNRavyBNxLXDD1af4fmvZnuYLyOFq4Ih4Ix4RluUcXxYDG613OBgbrryx9HdF883uf+lPN/+PL
	eAtG5IFNHXRTsvoEsTJ/gg06URFPpPTVg4abWrVhhCb0C5z8P4ursxsQFfIHZseztFiwEGzBfei
	dMvhGQs5rsjvTDw==
X-Received: by 2002:a05:622a:420b:b0:4ed:4369:f3b0 with SMTP id d75a77b69052e-4ed726035eemr84625311cf.57.1762428564464;
        Thu, 06 Nov 2025 03:29:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF5Y9MrAJi1CkAcyWCqIoql0rG+uICnIKE62F+OoH8UXgnjQwIAZmIHx1jJlThrKLOO7tPJA==
X-Received: by 2002:a05:622a:420b:b0:4ed:4369:f3b0 with SMTP id d75a77b69052e-4ed726035eemr84625071cf.57.1762428563906;
        Thu, 06 Nov 2025 03:29:23 -0800 (PST)
Received: from localhost ([2a01:4b00:b703:c200:1ac0:4dff:fe39:5426])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429eb4adde4sm4792649f8f.46.2025.11.06.03.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 03:29:23 -0800 (PST)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Punit Agrawal <punit.agrawal@oss.qualcomm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fabioaiuto83@gmail.com" <fabioaiuto83@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jamie
 Iles <jamie.iles@oss.qualcomm.com>
Subject: Re: [PATCH] drivers/usb/dwc3: fix PCI parent check
In-Reply-To: <20251106010123.mbtqd5epssrpbawv@synopsys.com> (Thinh Nguyen's
	message of "Thu, 6 Nov 2025 01:01:37 +0000")
References: <20251105145801.485371-1-punit.agrawal@oss.qualcomm.com>
	<20251106010123.mbtqd5epssrpbawv@synopsys.com>
Date: Thu, 06 Nov 2025 11:29:22 +0000
Message-ID: <87pl9v9z71.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ekFrNc_24_KlgTqpBxrz1iddf2a-NODW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA5MCBTYWx0ZWRfX4FX1z2AUJif2
 PlxO9zkpLVqdOJiooErYhgtiGg6UjaAFhmLbRDhpkPQ73l/6TE2neuOhnv/vul5i8Ga+0RcnZlU
 9vlWLNT9F4CGg3DwGnFSb4JGSpxsBjytI0/K3kow4slwmHEFELYmNEo7h1A/2W3Mwg9IvlvjB0P
 8KE+o8ujVwqEIb9xhg1aspewz4KAMQ3GktlmJj9QexbR2kjSNLjayQYU0srhsvnTvhfGJEhrYxy
 SMSUnEqF/O+5SEysGGCL8wCqlmVrV+D4chKKzMxjV13/C5uywk50n2MuZT9B+PZ/GQOBcYFhtfj
 6+5/LuwqV3CScOBL091I/zAwWcXaFL9wRHTTUkqT/zc3Ua6KzIrX9P7PT6PjdVLLRNe6Rme+dg6
 DLwO36MNS5lAjtVZvtC8e0ltDFpc0w==
X-Proofpoint-GUID: ekFrNc_24_KlgTqpBxrz1iddf2a-NODW
X-Authority-Analysis: v=2.4 cv=PoyergM3 c=1 sm=1 tr=0 ts=690c8695 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jIQo8A4GAAAA:8 a=EUspDBNiAAAA:8
 a=PokAWiqaKQyFClxnvusA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060090

Thinh Nguyen <Thinh.Nguyen@synopsys.com> writes:

> On Wed, Nov 05, 2025, Punit Agrawal wrote:
>> From: Jamie Iles <jamie.iles@oss.qualcomm.com>
>> 
>> The sysdev_is_parent check was being used to infer PCI devices that have
>> the DMA mask set from the PCI capabilities, but sysdev_is_parent is also
>> used for non-PCI ACPI devices in which case the DMA mask would be the
>> bus default or as set by the _DMA method.
>> 
>> Without this fix the DMA mask would default to 32-bits and so allocation
>> would fail if there was no DRAM below 4GB.
>> 
>> Fixes: 47ce45906ca9 ("usb: dwc3: leave default DMA for PCI devices")
>> Signed-off-by: Jamie Iles <jamie.iles@oss.qualcomm.com>
>> Signed-off-by: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
>
> We should Cc stable also.
>
>> ---
>>  drivers/usb/dwc3/core.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index ae140c356295..c2ce2f5e60a1 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -25,6 +25,7 @@
>>  #include <linux/of.h>
>>  #include <linux/of_graph.h>
>>  #include <linux/acpi.h>
>> +#include <linux/pci.h>
>>  #include <linux/pinctrl/consumer.h>
>>  #include <linux/pinctrl/devinfo.h>
>>  #include <linux/reset.h>
>> @@ -2241,7 +2242,7 @@ int dwc3_core_probe(const struct dwc3_probe_data *data)
>>  	dev_set_drvdata(dev, dwc);
>>  	dwc3_cache_hwparams(dwc);
>>  
>> -	if (!dwc->sysdev_is_parent &&
>> +	if (!dev_is_pci(dwc->sysdev) &&
>>  	    DWC3_GHWPARAMS0_AWIDTH(dwc->hwparams.hwparams0) == 64) {
>>  		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
>>  		if (ret)
>> -- 
>> 2.34.1
>> 
>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

Thank you for taking a look.

Not sure if Greg prefers a repost or he can add the tag and Cc: stable
while applying. I'll resend next week with updates if there's no
response.

[...]


