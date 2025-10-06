Return-Path: <linux-kernel+bounces-842652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7ECBBD3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4D79C3493B5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C5A257AC6;
	Mon,  6 Oct 2025 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8okxm/G"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1040B24A06D
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736536; cv=none; b=XaOhAxpaj7JSprHLR0MxTKmhxj3umzUitTLwBBZrzcU1IfxBbwwIobWn8FrU95wxAcu2KzR5Sui7F5wpx+eTk1hNOmjfP6wA5bGWMkL406rkHRPaawOd+mY2oNbbktiW41r5XWU67UqedoYWnGXdONA4su6kfagPIXGJv/z53jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736536; c=relaxed/simple;
	bh=EA5+YhSBaUfXwzSIShV4NvNIreufT+oeSm4z7v1HRHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjYRQwPn9rjcp4/onFTfw2hEI/q1cyrQz5EZ9A6HZcFl6jMO4Q1+gmpzPgeP1Gly9eVbsktf7r56JdY5YPn377hjWq3Gf1uw9jKSZu4IdqcM+SgiS+R0nqk0+XtJuSyIahAXgLo5UrDSCnD7I1q75raF9iI83hoGD6FOAWSt2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8okxm/G; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-86278558d6fso350417485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759736534; x=1760341334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woSAl7bOD989vqWds0TwLp0ZQWrpdmLNuruAIWeB26k=;
        b=j8okxm/G+MPKAR0K8yw047tYjueZMcmuprTn+QgwWLKhGS2Piynf2iVEV6MlYjEV8B
         GK95IvAgnEHaEkGreVZvidk8AHdnt5+JpXaByLdggcVZ696rt0x5YLmm7NTQ5GmuO0FH
         18oKRCzZECSS6xTP32gdnrjIEUTmpbGNHaFS76xIABiSouPgi3Oc/pthVN+T+Lr/VUrA
         iXr6zUTJ/hxY0yGJaaFmCojgXsfg0MkvVPqt+GphPcCFOkTAooBMm1Dtq/7gqSC/tO7T
         zK/QG4hxHjeiX7IQLT4LlwOjBwIMkLw3jErabh1dWi4L9fhMusFLWMuM8crQCflo4BEC
         h2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759736534; x=1760341334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woSAl7bOD989vqWds0TwLp0ZQWrpdmLNuruAIWeB26k=;
        b=TaiqqSTKkUhM33ZTNIFq4eLwwq3L80R+Dsy4D92T85FhLwslg1m9Aya2hwBB9SuKat
         M1r3zr01VJPcNKVEgKgxNwRq3w+cJ2c+vUeju6dAaADvElN9zrOAWnTeYDCdrSRxsYaL
         IP7jBEOZ1G+hNqEev9SjwyIPiEF8yRTXGKrQSrMgu/263oievY6NY7gRdISZnn6KINKq
         nML+yIvKSWIjF1uiTC6qVpY3AvomNZqyEnsHtewRPXiliv+iC7n70+9vWiKM2Dyee7Pa
         lkpGApet/n++ApA4EeleN8V0iW5Lo3S9aoC6ys+RNyb6wB7hIc/IVcSOMXXlHYSEC97x
         kgTg==
X-Forwarded-Encrypted: i=1; AJvYcCU256WvYhhUwmDmyKgAlMyUESkXT43Exozt7PUMtFgfF5UxSqP3Co1NRiCF2cUfy7pK+grMGkiYleUEyTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4tcpvqJFURqWZCqLwgqLgNYJgw+0k1V74kKSBu6WqCe2aQBGB
	d9aZjzXzqETU6pUpKC4oKu310IPZgsoPnC0m8prNV/pFtOxD2edVxgjx
X-Gm-Gg: ASbGncsP6MzPBFQGdqz/b+c4HhsccueB2n8GDcKx6QzM47wcvNvA5oh3k/NdJEPqkK3
	c6Bew9n5T8x3QgiutSBH8MICMcEy1ubX2RqBZhUi9aZiALtPfgY+j79lzi3PrDbtf0houRlsNgb
	r1DBM4NRJ/TMuvpt8O2HR82xqjyZmhnsRlPpZEiX6HQoxtgozn3gbGmlEbkZomAyzuS09S9dPAe
	YppCAUBYsVSWoe5rfP+N2iqUUtniqRrOq58hL+jSHBMd6eByXwe0MNeIOMrj4OPiH8KfWoOFdrD
	OKAdmeRHKPZbB0LYVFtgX471xFoaHnOW4l1GnBlw5dN1ZNYljvOsV3HSa8z+QSUt5bEdCVaopR6
	v20ZHTeECMgjE06Z+ThrQc+1MxipK0hZnwT57I+YfEUEZ9ZJv3B9je/j4HIi2uB26BVScUPHpoK
	j5vMBWc8m6
X-Google-Smtp-Source: AGHT+IGahQ0lLmXwP/YYcAaECZTnIW//G/p0RYMK/3NcjxNtZ8EfYRA09/3KlKfRwYwYYu0VLM0KWA==
X-Received: by 2002:a05:620a:1706:b0:84b:63e8:f04f with SMTP id af79cd13be357-87a3410d4b6mr1493227185a.31.1759736533757;
        Mon, 06 Oct 2025 00:42:13 -0700 (PDT)
Received: from [192.168.0.155] ([170.10.253.128])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129f10sm1171502085a.9.2025.10.06.00.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 00:42:13 -0700 (PDT)
Message-ID: <1a50635f-4525-41dd-8d96-eeee5d25d526@gmail.com>
Date: Mon, 6 Oct 2025 03:42:12 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/16] staging: rtl8723bs: merge nested if conditions
 for clarity and tab problems
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251002172304.1083601-1-vivek.balachandhar@gmail.com>
 <20251002172304.1083601-16-vivek.balachandhar@gmail.com>
 <aN924wqH--MgGEak@stanley.mountain>
Content-Language: en-CA
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
In-Reply-To: <aN924wqH--MgGEak@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Ack. I will do the changes after the merge window. Thanks for the 
review, Dan.

Best,

Vivek

On 2025-10-03 3:10 a.m., Dan Carpenter wrote:
> On Thu, Oct 02, 2025 at 05:23:03PM +0000, Vivek BalachandharTN wrote:
>> Combine nested if conditions for clarity and fix tab indentation in one
>> place to match kernel coding style.
>>
>> No functional changes.
>>
>> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
>> ---
>>   drivers/staging/rtl8723bs/core/rtw_mlme.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> index aa842905a467..f17b16fe8819 100644
>> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
>> @@ -1254,8 +1254,8 @@ void rtw_joinbss_event_prehandle(struct adapter *adapter, u8 *pbuf)
>>   						rtw_free_stainfo(adapter,  pcur_sta);
>>   
>>   					ptarget_wlan = rtw_find_network(&pmlmepriv->scanned_queue, pnetwork->network.mac_address);
>> -					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true) {
>> -					    if (ptarget_wlan)
>> +					if (check_fwstate(pmlmepriv, WIFI_STATION_STATE) == true &&
>> +					    ptarget_wlan) {
>>   						ptarget_wlan->fixed = true;
>>   					}
> Delete the curly braces as well.
>
> regards,
> dan carpenter
>

