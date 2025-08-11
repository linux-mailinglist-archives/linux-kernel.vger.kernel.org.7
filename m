Return-Path: <linux-kernel+bounces-763338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3E7B21394
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 19:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E777A36BC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 17:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044062D47F7;
	Mon, 11 Aug 2025 17:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhxqAwUA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB5311C16;
	Mon, 11 Aug 2025 17:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934245; cv=none; b=FEFUmfNbzCXTpak2bLFYQcowclikhh/S3Uv3WyR4j9hd2d3bZyiP0yXxuMN3WyMPRHDNnuSj3yf6XyiLQht/u4iICxir2kuK99khOLvoRzeFi4u54s3KAdliB6zhz5eTZn4ArgbcrtlA5nBMtFojPEoHNpw6vWJUafxiBGkXQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934245; c=relaxed/simple;
	bh=ojD5IyvgvSJowMzheqFP1nv6TAR+VO7H0rnW2TvrEYM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=suhWVZLBlTlil3pD7SWc7Pt8B+PCBxs9uQi6XFUk5DFrdwOBuruqEiSARnTwrSexreEtDU3540aD0oUr4H1+cs3bbTebPfScrDU8a/Mcu5tVwbfY3ilpSd8rzqXOPZFKPTYqhFnHyftd87b40LC8prfxku7rzA1YrZ1hy931kYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhxqAwUA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32031C4CEED;
	Mon, 11 Aug 2025 17:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754934245;
	bh=ojD5IyvgvSJowMzheqFP1nv6TAR+VO7H0rnW2TvrEYM=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=GhxqAwUAO2eyiTOWsKm6wjMtsdrj3VSv4J3XJT0NjBXEIaL6QMHTPNY25HX1A224a
	 Stb4NnEjTWaWFvcUFC7RQNus3qptmeVEp/Te8yyhErfa4VYD8f3OszydSrRC6kN1uh
	 XUqWpK0SgTL1j2uHHMi6Qv71j2YMqhtUaB1DtB67NFhG2bhSLw+1YN+Tf1hVGXf3dL
	 s5OsbvYAmHlAFmZsKj0La7+NZOV0Ag272R2/rXhBWliQ81D7GJUAxSsfV1eapCPTRJ
	 Kn1qz/SdgeIvCVg9RDHwErTNjQjJRk+kpm0iLC6Y9pSFQYYnfNoKD9eK7eNt5U/OFz
	 6rYycYO8Y8FxA==
Message-ID: <4151a14f-8427-41a9-84cf-e901080d0eb1@kernel.org>
Date: Mon, 11 Aug 2025 19:44:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: barco-p50-gpio: use software nodes for
 gpio-leds/keys
From: Hans de Goede <hansg@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Santosh Kumar Yadav <santoshkumar.yadav@barco.com>,
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
Content-Language: en-US, nl
In-Reply-To: <c60ccef1-7213-4dd7-8c10-e8ef03675bd8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11-Aug-25 7:40 PM, Hans de Goede wrote:
> Hi,
> 
> On 11-Aug-25 5:49 PM, Dmitry Torokhov wrote:
>> On Mon, Aug 11, 2025 at 06:45:23PM +0300, Andy Shevchenko wrote:
>>> On Mon, Aug 11, 2025 at 04:20:33PM +0200, Hans de Goede wrote:
>>>> On 11-Aug-25 2:44 PM, Andy Shevchenko wrote:
>>>>> On Sun, Aug 10, 2025 at 09:31:37PM -0700, Dmitry Torokhov wrote:
>>>
>>> ...
>>>
>>>>> Otherwise LGTM as here it looks like we establish platform device ourselves and
>>>>> hence no need some additional magic Hans mentioned in the other series.
>>>>
>>>> Not entirely like with the x86-android-tablets patches this
>>>> declares a software-node for the gpiochip:
>>>>
>>>> static const struct software_node gpiochip_node = {
>>>> 	.name = DRIVER_NAME,
>>>> };
>>>>
>>>> and registers that node, but nowhere does it actually
>>>> get assigned to the gpiochip.
>>>>
>>>> This is going to need a line like this added to probe():
>>>>
>>>> 	p50->gc.fwnode = software_node_fwnode(&gpiochip_node);
>>>>
>>>> note the software_node_fwnode() call MUST be made after
>>>> registering the software-nodes (group).
>>>>
>>>> Other then needing this single line things are indeed
>>>> much easier when the code containing the software
>>>> properties / nodes is the same code as which is
>>>> registering the gpiochip.
>>>
>>> Ah, good point!
>>
>> This is wrong though, the software node need not be attached to the
>> gpiochip (and I wonder if it is even safe to do so). It simply provides
>> a name by which gpiochip is looked up in swnode_get_gpio_device().
> 
> Ah interesting. This is very different from how fwnodes generally
> work though. Generally speaking when a PROPERTY_ENTRY_REF() is used
> like PROPERTY_ENTRY_GPIO() does then the lookup is done by matching
> the reference to the fwnode of the type of device to which the
> reference points.
> 
> IOW the standard way how this works for most other subsystems
> is that gpiolib-swnode.c: swnode_get_gpio_device() would call
> gpio_device_find() with a compare function which uses
> device_match_fwnode().
> 
> I see that instead it uses the swnode name and passes that to
> gpio_device_find_by_label().
> 
> I must say that AFAIK this is not how swnodes are supposed to
> be used the swnode name field is supposed to only be there
> for debugging use and may normally be left empty all together.
> 
> I guess using the swnode-name + gpio_device_find_by_label()
> works but it goes against the design of how fw-nodes
> and especially fwnode-references are supposed to be used...
> 
> Having a fwnode reference pointing to what is in essence
> a dangling (not attached to any device) fwnode is weird.
> 
> Are there already any users of PROPERTY_ENTRY_GPIO() in
> the kernel? If not then I think that we should fix things
> up to actually do a reference match and not a name based
> lookup.
> 
> Andy IIRC you've done quite a bit of work on software-nodes,
> what is your take on this ?
> 
> Note this is likely my last email in this thread for
> a while since I will be traveling without email access.

p.s.

It seems that atm device_match_fwnode() only checks
that the passed in fwnode to match on matches the primary
fwnode of the device. This should be modified to also
match on the secondary node if matching the first node
fails. Like how e.g. fwnode_property_present() falls
back to checking the secondary node if the requested
property is not present in the primary fwnode.

Regards,

Hans




