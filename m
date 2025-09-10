Return-Path: <linux-kernel+bounces-810013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375F3B5149E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EEA164662
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB82316900;
	Wed, 10 Sep 2025 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFDYSzcz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A73164D2;
	Wed, 10 Sep 2025 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757501781; cv=none; b=jewBsUXi+w3VTMWs76oGjLB6EIob6XqKEIXrwcPMxXeDMKfLWmyltSTRdnQoOA8FSgL6Z+czRUG4pDUzB1jjZNh1kfmDgZI4MpQHh+oEpFDh4CeJLuMAv5BYx+ofJ8Dz4cY2EMY4jbx/Oby66La+HVmJM5WLH32jh3sTmBneISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757501781; c=relaxed/simple;
	bh=Xou+v3jeq2nQmIHLiC5MNDsiYxU46MmPvSS8fVvhtHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkgyGB/gJmi6c6ICk2ydppvNmxaGz7e9OtXhXNjJzfKdtfCfuebSnDRz2J6WCen7OjLW/2tTEmSWruJWmMXT6oK77mP5hM/SrzkLVtHK//h14Z2RHGDRyw+nd2UexiDzi4qfZ45kMI+bGHwzA54+JqN5vzYBHHUE5RgBuFed/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFDYSzcz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AB5C4CEF5;
	Wed, 10 Sep 2025 10:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757501780;
	bh=Xou+v3jeq2nQmIHLiC5MNDsiYxU46MmPvSS8fVvhtHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AFDYSzcz3HumgzAULFhu6JeUWLXGxDABvMZGyh/Vis5mDkUiY1gfFfQD5kJMS33xR
	 /5VxtS862LyHm5LS6W35R2dmjTQWflsyfKlDQPvtVY/5RVNE1WKqfxUomrkR2tb8Om
	 ezLhwwk0Ik9k9sZf1nWNFaC5FqBdG0+cQgj/rhB+UmSudtzpefdQlqkblX12n7MkWD
	 mTVfP1pVR6TgGmQymsrjLt9QDstnHJt2PgN8dz6fyj+RUg4Ox/M+Em79YoSiK8z0OM
	 AvCKZrcVDnbOAbVaKC3BeATqw6Ff1wTz3h4C9Y7XhGZN2eEbnfPK4lyyqliYLel728
	 IiogSJYzAAzuQ==
Message-ID: <323da8ba-4b7e-40dd-a012-380394be1ca5@kernel.org>
Date: Wed, 10 Sep 2025 12:56:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
 Peter Korsgaard <peter.korsgaard@barco.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <2meuzip4qnxvle4bwk4hbow4j34ii3cwb46xd5inq5btif5mjg@iiygy6ir7vtr>
 <aJnlnx2qF6P61jJN@smile.fi.intel.com>
 <7c2d08e3-d1e2-433e-b726-307246ab17e9@kernel.org>
 <aJoQE2CQv3nzaSqc@smile.fi.intel.com>
 <uakyig6sp2sfuwtt2aq7ds5dcbsjrgcijenunefqzc46inpees@xc6bfr4mjnan>
 <c60ccef1-7213-4dd7-8c10-e8ef03675bd8@kernel.org>
 <4151a14f-8427-41a9-84cf-e901080d0eb1@kernel.org>
 <7bylxufp3r5qzf5axqrtytamkveaw5dpsidmdyiany4wkexbpd@s4yremtvct4a>
 <ae657b82-acd3-4a1f-ba21-3ce394531819@kernel.org>
 <ceb10a43-424f-45e8-68b5-d506573a63e3@linux.intel.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <ceb10a43-424f-45e8-68b5-d506573a63e3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ilpo,

On 8-Sep-25 2:48 PM, Ilpo Järvinen wrote:
> On Tue, 12 Aug 2025, Hans de Goede wrote:
> 
>> Hi,
>>
>> On 11-Aug-25 7:59 PM, Dmitry Torokhov wrote:
>>> On Mon, Aug 11, 2025 at 07:44:01PM +0200, Hans de Goede wrote:
>>>> On 11-Aug-25 7:40 PM, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 11-Aug-25 5:49 PM, Dmitry Torokhov wrote:
>>>>>> On Mon, Aug 11, 2025 at 06:45:23PM +0300, Andy Shevchenko wrote:
>>>>>>> On Mon, Aug 11, 2025 at 04:20:33PM +0200, Hans de Goede wrote:
>>>>>>>> On 11-Aug-25 2:44 PM, Andy Shevchenko wrote:
>>>>>>>>> On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:
>>>>>>>
>>>>>>> ...
>>>>>>>
>>>>>>>>> Otherwise LGTM as here it looks like we establish platform device ourselves and
>>>>>>>>> hence no need some additional magic Hans mentioned in the other series.
>>>>>>>>
>>>>>>>> Not entirely like with the x86-android-tablets patches this
>>>>>>>> declares a software-node for the gpiochip:
>>>>>>>>
>>>>>>>> static const struct software_node gpiochip_node = {
>>>>>>>> 	.name = DRIVER_NAME,
>>>>>>>> };
>>>>>>>>
>>>>>>>> and registers that node, but nowhere does it actually
>>>>>>>> get assigned to the gpiochip.
>>>>>>>>
>>>>>>>> This is going to need a line like this added to probe():
>>>>>>>>
>>>>>>>> 	p50->gc.fwnode = software_node_fwnode(&gpiochip_node);
>>>>>>>>
>>>>>>>> note the software_node_fwnode() call MUST be made after
>>>>>>>> registering the software-nodes (group).
>>>>>>>>
>>>>>>>> Other then needing this single line things are indeed
>>>>>>>> much easier when the code containing the software
>>>>>>>> properties / nodes is the same code as which is
>>>>>>>> registering the gpiochip.
>>>>>>>
>>>>>>> Ah, good point!
>>>>>>
>>>>>> This is wrong though, the software node need not be attached to the
>>>>>> gpiochip (and I wonder if it is even safe to do so). It simply provides
>>>>>> a name by which gpiochip is looked up in swnode_get_gpio_device().
>>>>>
>>>>> Ah interesting. This is very different from how fwnodes generally
>>>>> work though. Generally speaking when a PROPERTY_ENTRY_REF() is used
>>>>> like PROPERTY_ENTRY_GPIO() does then the lookup is done by matching
>>>>> the reference to the fwnode of the type of device to which the
>>>>> reference points.
>>>>>
>>>>> IOW the standard way how this works for most other subsystems
>>>>> is that gpiolib-swnode.c: swnode_get_gpio_device() would call
>>>>> gpio_device_find() with a compare function which uses
>>>>> device_match_fwnode().
>>>>>
>>>>> I see that instead it uses the swnode name and passes that to
>>>>> gpio_device_find_by_label().
>>>>>
>>>>> I must say that AFAIK this is not how swnodes are supposed to
>>>>> be used the swnode name field is supposed to only be there
>>>>> for debugging use and may normally be left empty all together.
>>>
>>> Hmm, given that I wrote both the references support for software nodes
>>> and gpiolib-swnode.c they work exactly as I wanted them ;) Yes, in
>>> general name is optional, but for GPIOs it is needed.
>>>
>>>>>
>>>>> I guess using the swnode-name + gpio_device_find_by_label()
>>>>> works but it goes against the design of how fw-nodes
>>>>> and especially fwnode-references are supposed to be used...
>>>>>
>>>>> Having a fwnode reference pointing to what is in essence
>>>>> a dangling (not attached to any device) fwnode is weird.
>>>
>>> I agree it is a bit weird, but this allows to disconnect the board file
>>> from the GPIO driver and makes it easier to convert to device tree down
>>> the road as it can be done in a piecemeal fashion. If you want fwnode
>>> actually attached to the gpiochip then:
>>>
>>> 1. You can't really have static/const initializers in most of the cases
>>> 2. Fishing it out from an unrelated subsystem is much harder than
>>> matching on a name.
>>
>> Ok lets keep using the current swnode.name based approach then.
>>
>> That certainly makes things easier for the x86-android-tablets
>> code.
> 
> Hi all,
> 
> I'm left uncertain if there are any remaining concerns with all these gpio 
> conversion patches (the 3 independent ones and the larger 
> x86-android-tablets series)? While I see there were a few back and forth
> items between you three, it sounded like there's nothing left to do and it 
> was all just based on wrong impressions/understanding, is that correct 
> deduction from my part?

Yes that is correct. The current patches theoretically (untested) is good
to go. The only thing which still needs to happen is test it.

> There was also an almost promise from Hans to test the x86-android-tablets 
> series, is that still on plan/pending?

Yes I hope to be able to test this the x86-android-tablets series this
week (likely in the weekend). Once that has been tested I think we can
assume that the 3 independent patches will also work and merge all of
them.

Regards,

Hans




