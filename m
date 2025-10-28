Return-Path: <linux-kernel+bounces-873969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC618C15387
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3C0660AAC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB66338905;
	Tue, 28 Oct 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obShIerl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECE921770A;
	Tue, 28 Oct 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761662221; cv=none; b=LYy7WsWV67uZIS67P1IVmYUBw9cfHrnMdnJjOolC0PYnHqHzvL1vQy7FMiv9iBANsbvccZZwesjjj4hfHB/wN225fkoNzQacAWuU3hXIzqHczXm0Yhk4LYYNwvEAfmcCDeoEKzYOnVnYuqb027s5C0KeAmKOLdhfUlhPH4CFeTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761662221; c=relaxed/simple;
	bh=LaqoH0CNb4p9Z7UL/cJWJo9U5GQeFIJB8EnPWW9e8II=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxj6nePRO680F6MukmWGaCGg8+gxiqFwEc3gzt3uVoTfmRLBWEkVlDHDa7vT2PbKlHBxs5jUfX1xFlTgivTnRmzAX9xKh7SfcQyltluH5muJCvcO9jLzR55/4C+ycO1o98ylUrXLkCqSR81I1X/rjBISx+932ERREA5fVJVyjVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obShIerl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD70C4CEE7;
	Tue, 28 Oct 2025 14:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761662220;
	bh=LaqoH0CNb4p9Z7UL/cJWJo9U5GQeFIJB8EnPWW9e8II=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=obShIerlPdmCrA0t++n7V6yssrbVSSeZECUluphEjWqPS4QqlaMWNoN2DZuv0ddyr
	 8xMfIDYGl5+2jmW5Z6e1LqqrrSVE8GmOE0o4kMoEwgAo8jWvBzpzUqA1DExTPlGUsG
	 bovx80UwAMkdVfUkgGrUglK7Vl0hiKAFBlSx705x3CRtLKb2Tanvo4R31TtWOZdxt2
	 IiGCqpSbODK2rY4b4n03eVwjUwqx4COqMbKC9kMqMEPDMVPpeCEF2Q6HbPOn+nqVTx
	 qWHl5cOjk3m4X7wEbi5xvjDkm6raO1j77jhcBGuEulAxnd1LCa6UfyQyeZz0OHovnI
	 qvPOs4La3ppug==
Message-ID: <492c05bf-bf0f-4cca-af3b-121fdffd05e8@kernel.org>
Date: Tue, 28 Oct 2025 15:36:56 +0100
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
 Dan Scally <dan.scally@ideasonboard.com>
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
 <d1cef8a6-1c67-4932-85e7-07c0e00477bb@ideasonboard.com>
 <aQCrLVBBOBVCnoJ8@smile.fi.intel.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <aQCrLVBBOBVCnoJ8@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 28-Oct-25 12:38 PM, Andy Shevchenko wrote:
> On Tue, Oct 28, 2025 at 11:09:12AM +0000, Dan Scally wrote:
>> On 28/10/2025 10:54, Andy Shevchenko wrote:
>>> On Tue, Oct 28, 2025 at 11:38:00AM +0100, Hans de Goede wrote:
>>>> On 28-Oct-25 11:02 AM, Andy Shevchenko wrote:
>>>>> On Tue, Oct 28, 2025 at 08:55:07AM +0000, Dan Scally wrote:
>>>>>> On 24/10/2025 06:05, Qiu Wenbo wrote:
> 
> ...
> 
>>>>>> However the Fixes tag I wonder about; devm_gpiod_get() will also result in a
>>>>>> call to gpiod_put() when the module is unloaded; doesn't that mean that the
>>>>>> same issue  will occur before that commit?
>>>>>
>>>>> Actually a good question! To me sounds like it's a bug(?) in regulator code.
>>>>> It must not release resources it didn't acquire. This sounds like a clear
>>>>> layering violation.
>>>>
>>>> I think the problem is that when it comes from devicetree it is acquired
>>>> by the regulator core.
>>>
>>> Hmm... I probably missed that, but I failed to see this. Any pointers?
>>
>> They can come through the struct regulator_desc.of_parse_cb(), which is called in
>> regulator_of_init_data(), from regulator_register(). For example: https://elixir.bootlin.com/linux/v6.17.5/source/drivers/power/supply/mt6370-charger.c#L234>
> 
> Ah, thank you, Dan, for the pointers. Indeed, that's how it's done. Hmm, still
> why can't we let the regulator consumer to decide when to clean the resource?
> I think this is an attempt to have a refcounting against shared GPIO resource
> and it should be done in the GPIOLIB (if not yet). In regulator that put
> call should probably be conditional (based on the source of GPIO request).

Fixing this sounds like a somewhat big undertaking. In the mean time
I think we should move forward with this patch to fix the immediate
issue with the double free.

Regards,

Hans



