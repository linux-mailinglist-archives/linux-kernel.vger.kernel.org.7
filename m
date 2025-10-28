Return-Path: <linux-kernel+bounces-873634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E84C144D2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BA11A26F94
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4F830596F;
	Tue, 28 Oct 2025 11:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nfSJwAQk"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA3B30149C;
	Tue, 28 Oct 2025 11:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649759; cv=none; b=AM745xyuzAXnMHnkftSOaHViazoCW9yv7cXU6hdFrSN9dYROtqphSitScLXDlCWvmY0s1qyH+p0eRK9lxJRlWNE0VH9FpK0z525iyQbCIyKYuEH/aGsz6UWM9vMaQVJFxgG40/zazrYFkWuI6/h9rvZ1s/1qSmki/xkz3jBpfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649759; c=relaxed/simple;
	bh=BdVlfsfsrowrus2tdgKa+O94Z0vKgfY8TLslK6fCLoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhU35STg/k/BiVOefXpF9HVRt2WNEFM+cKsNgMT05t9PqHPcHpV08FPptwhszeMheAjbFCl17xPVMCPd9xOkrSqiLVyiHTedn+/XgNOykJtELvM5uB39YrBanfh9VMkYb1EY6LrHiAdvGraGz98MYf3oS3MONnJnejnbA6/km6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=nfSJwAQk; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 529ECAB4;
	Tue, 28 Oct 2025 12:07:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761649646;
	bh=BdVlfsfsrowrus2tdgKa+O94Z0vKgfY8TLslK6fCLoY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nfSJwAQkC7MOzKqzvJzIzFmJxm1SUreC8et1iR/ujc3z6dVbcSHRWyHwCGcfwDeNy
	 IqtB3xVlzp8upAzFlD6ySvEeznuDC/yIoMJr0ni5iJFzD0IAyXG5i2piSA8uVfu9mo
	 g8kaZ3+xqgD0ZtHOmnEVu7GhBCuVbuDeiXqlelB4=
Message-ID: <d1cef8a6-1c67-4932-85e7-07c0e00477bb@ideasonboard.com>
Date: Tue, 28 Oct 2025 11:09:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: int3472: Fix double free of GPIO device
 during unregister
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc: Qiu Wenbo <qiuwenbo@gnome.org>, Daniel Scally <djrscally@gmail.com>,
 Qiu Wenbo <qiuwenbo@kylinsec.com.cn>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>
References: <20251024050537.92440-1-qiuwenbo@gnome.org>
 <5007d7f0-76ff-41fd-a371-05922c97f8ef@ideasonboard.com>
 <aQCUu5vCPlglC0Kd@smile.fi.intel.com>
 <7898408e-1b33-4f22-84d2-12bcd6254402@kernel.org>
 <aQCg-xZ_kAemfgZQ@smile.fi.intel.com>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <aQCg-xZ_kAemfgZQ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/10/2025 10:54, Andy Shevchenko wrote:
> On Tue, Oct 28, 2025 at 11:38:00AM +0100, Hans de Goede wrote:
>> On 28-Oct-25 11:02 AM, Andy Shevchenko wrote:
>>> On Tue, Oct 28, 2025 at 08:55:07AM +0000, Dan Scally wrote:
>>>> On 24/10/2025 06:05, Qiu Wenbo wrote:
>>>>>
>>>>> regulator_unregister() already frees the associated GPIO device. On
>>>>> ThinkPad X9 (Lunar Lake), this causes a double free issue that leads to
>>>>> random failures when other drivers (typically Intel THC) attempt to
>>>>> allocate interrupts. The root cause is that the reference count of the
>>>>> pinctrl_intel_platform module unexpectedly drops to zero when this
>>>>> driver defers its probe.
>>>>>
>>>>> This behavior can also be reproduced by unloading the module directly.
>>>>>
>>>>> Fix the issue by removing the redundant release of the GPIO device
>>>>> during regulator unregistration.
>>>>>
>>>>> Fixes: 1e5d088a52c2 ("platform/x86: int3472: Stop using devm_gpiod_get()")
>>>
>>>> However the Fixes tag I wonder about; devm_gpiod_get() will also result in a
>>>> call to gpiod_put() when the module is unloaded; doesn't that mean that the
>>>> same issue  will occur before that commit?
>>>
>>> Actually a good question! To me sounds like it's a bug(?) in regulator code.
>>> It must not release resources it didn't acquire. This sounds like a clear
>>> layering violation.
>>
>> I think the problem is that when it comes from devicetree it is acquired
>> by the regulator core.
> 
> Hmm... I probably missed that, but I failed to see this. Any pointers?

They can come through the struct regulator_desc.of_parse_cb(), which is called in
regulator_of_init_data(), from regulator_register(). For example: 
https://elixir.bootlin.com/linux/v6.17.5/source/drivers/power/supply/mt6370-charger.c#L234>
>> Only when passed as platform-data as we do here does
>> this layering violation occur.
>>
>> I do believe that a transfer of ownership ad done here is ok for
>> the platform-data special case.
> 


