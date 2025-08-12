Return-Path: <linux-kernel+bounces-764484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC53B223A5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBEE4500854
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54B82D5A1C;
	Tue, 12 Aug 2025 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMCL0zbH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA3928850F;
	Tue, 12 Aug 2025 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992070; cv=none; b=tfy4dQFzUyxNjepb9Rledhk92BrOFaOMP2zJ3ZP6luT7cZ0reoc4f3J25Uct3C+YvPj0j1D9VLiLnfaezeMP0tSYfexm4tTkX/SVC2Cvqbegz+XD+yZy84KEuieWyYDpVq2Z8Plp3+8hT07jemMql/jhiLklUUzCqSy4FM4PoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992070; c=relaxed/simple;
	bh=3UY+sCVDqlbC3OtzdZ1SlVDYHNKowdCDEMTvCrXyyfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=etcz9tWCVLlJF4ln43Xr4hO7cv6cy+Syq9vsb1lCsw7CiQBisbl/44dFLkQxddWLLPcm+UwJIo8Wlkc/RhPYzrmi7+q/xdiJ/ai9HIy0WIZ70ElNmQuD0GbEKOgQoy+NUbx/ba33nNeVU4x0mV3SJbiVGyEitIAM9ongHO6Xs8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMCL0zbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DB0C4CEF0;
	Tue, 12 Aug 2025 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754992069;
	bh=3UY+sCVDqlbC3OtzdZ1SlVDYHNKowdCDEMTvCrXyyfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mMCL0zbHUULQgEoPO5Br04YtZIFgfmIiUyolXq4jd7CjoO/+fyZIiA5cFnHXdWsuh
	 cR1auQHDEzl48wGSiEwG00deaWkG8IAWaE+3R1gAHfRh2c57iVmSAgwKir0wUV7s9Q
	 r5AUFv0RIxzKGyXgHJsKFEiwfXLS3JlgT+joVm2CjzHM9aojkrPu8RvRyXLEGMlSHY
	 jDSkIQ9Yv8RpkQuNFNBlWAW2NJODdsnaI4OAGXwiE2m2LaXjAgA/lp7m2zuIShZa6t
	 OJyAJ2i3vXhy51O13l3gM3x7uQ/dv+fQX217YMK9tKD7EYs5Y0qTCNLnHu37jdAriD
	 +saCltarsZeSQ==
Message-ID: <ae657b82-acd3-4a1f-ba21-3ce394531819@kernel.org>
Date: Tue, 12 Aug 2025 11:47:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
 Peter Korsgaard <peter.korsgaard@barco.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
 <aJnlnx2qF6P61jJN@smile.fi.intel.com>
 <7c2d08e3-d1e2-433e-b726-307246ab17e9@kernel.org>
 <aJoQE2CQv3nzaSqc@smile.fi.intel.com>
 <uakyig6sp2sfuwtt2aq7ds5dcbsjrgcijenunefqzc46inpees@xc6bfr4mjnan>
 <c60ccef1-7213-4dd7-8c10-e8ef03675bd8@kernel.org>
 <4151a14f-8427-41a9-84cf-e901080d0eb1@kernel.org>
 <7bylxufp3r5qzf5axqrtytamkveaw5dpsidmdyiany4wkexbpd@s4yremtvct4a>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <7bylxufp3r5qzf5axqrtytamkveaw5dpsidmdyiany4wkexbpd@s4yremtvct4a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 11-Aug-25 7:59 PM, Dmitry Torokhov wrote:
> On Mon, Aug 11, 2025 at 07:44:01PM +0200, Hans de Goede wrote:
>> On 11-Aug-25 7:40 PM, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 11-Aug-25 5:49 PM, Dmitry Torokhov wrote:
>>>> On Mon, Aug 11, 2025 at 06:45:23PM +0300, Andy Shevchenko wrote:
>>>>> On Mon, Aug 11, 2025 at 04:20:33PM +0200, Hans de Goede wrote:
>>>>>> On 11-Aug-25 2:44 PM, Andy Shevchenko wrote:
>>>>>>> On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>>> Otherwise LGTM as here it looks like we establish platform device ourselves and
>>>>>>> hence no need some additional magic Hans mentioned in the other series.
>>>>>>
>>>>>> Not entirely like with the x86-android-tablets patches this
>>>>>> declares a software-node for the gpiochip:
>>>>>>
>>>>>> static const struct software_node gpiochip_node = {
>>>>>> 	.name = DRIVER_NAME,
>>>>>> };
>>>>>>
>>>>>> and registers that node, but nowhere does it actually
>>>>>> get assigned to the gpiochip.
>>>>>>
>>>>>> This is going to need a line like this added to probe():
>>>>>>
>>>>>> 	p50->gc.fwnode = software_node_fwnode(&gpiochip_node);
>>>>>>
>>>>>> note the software_node_fwnode() call MUST be made after
>>>>>> registering the software-nodes (group).
>>>>>>
>>>>>> Other then needing this single line things are indeed
>>>>>> much easier when the code containing the software
>>>>>> properties / nodes is the same code as which is
>>>>>> registering the gpiochip.
>>>>>
>>>>> Ah, good point!
>>>>
>>>> This is wrong though, the software node need not be attached to the
>>>> gpiochip (and I wonder if it is even safe to do so). It simply provides
>>>> a name by which gpiochip is looked up in swnode_get_gpio_device().
>>>
>>> Ah interesting. This is very different from how fwnodes generally
>>> work though. Generally speaking when a PROPERTY_ENTRY_REF() is used
>>> like PROPERTY_ENTRY_GPIO() does then the lookup is done by matching
>>> the reference to the fwnode of the type of device to which the
>>> reference points.
>>>
>>> IOW the standard way how this works for most other subsystems
>>> is that gpiolib-swnode.c: swnode_get_gpio_device() would call
>>> gpio_device_find() with a compare function which uses
>>> device_match_fwnode().
>>>
>>> I see that instead it uses the swnode name and passes that to
>>> gpio_device_find_by_label().
>>>
>>> I must say that AFAIK this is not how swnodes are supposed to
>>> be used the swnode name field is supposed to only be there
>>> for debugging use and may normally be left empty all together.
> 
> Hmm, given that I wrote both the references support for software nodes
> and gpiolib-swnode.c they work exactly as I wanted them ;) Yes, in
> general name is optional, but for GPIOs it is needed.
> 
>>>
>>> I guess using the swnode-name + gpio_device_find_by_label()
>>> works but it goes against the design of how fw-nodes
>>> and especially fwnode-references are supposed to be used...
>>>
>>> Having a fwnode reference pointing to what is in essence
>>> a dangling (not attached to any device) fwnode is weird.
> 
> I agree it is a bit weird, but this allows to disconnect the board file
> from the GPIO driver and makes it easier to convert to device tree down
> the road as it can be done in a piecemeal fashion. If you want fwnode
> actually attached to the gpiochip then:
> 
> 1. You can't really have static/const initializers in most of the cases
> 2. Fishing it out from an unrelated subsystem is much harder than
> matching on a name.

Ok lets keep using the current swnode.name based approach then.

That certainly makes things easier for the x86-android-tablets
code.

Regards,

Hans



