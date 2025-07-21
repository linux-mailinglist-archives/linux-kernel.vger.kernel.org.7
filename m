Return-Path: <linux-kernel+bounces-739432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A11B0C63E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F0544072
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40672D9EF2;
	Mon, 21 Jul 2025 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A1uYUBhN"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3F02DAFAF
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107871; cv=none; b=QfBV3OOzFhxDvLIsjwyEE0AkC0WUoO56rwvekqTYhsWP8Cjznn75/3GmIPfVI5WoExmSt89iqTShByoIC53cvPXd+b9gFvTGh81fBpjr8+00sF0M3Sp+obTx8walxGN6Onl7e5+A2QMxuZSlAxZr5LE8ISPoND3Niy2TYd3W70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107871; c=relaxed/simple;
	bh=5IvYIaS4DdqMJxN/voFaTXOIxs253avQqC5edoCoWsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWk9uLlWFOfvCgWTIwLQUJK7vDSpb+jfwfa+xnAydVfASETo5R53UVNUbFefAlCY1UgRn/aowjyHE7I2bVx9UV1jikIUi4o/mvNhJIIFcqT8KOFOxPuVno1PsC0xCHfQn1B9AWh7trcYZ1yypIObvonQuWmOwQYb79M3SWp3TTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A1uYUBhN; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1ad78d64-ab6a-41fd-b149-dd52ea08e4e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753107857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9gGU4pTSw3F05tEeC1AdaseQTzgozjPnlHOowK/EfE=;
	b=A1uYUBhNOyQERSiG0SC5BMD8cvKGBFv4jl7OaALhpABNaCOhC27EtMy58yJ6jehBW4/YGX
	/8amahMyBdTr7Im701GUiFNRq1mM9Mq0h5A638uFdPtV0sWlUwa0ehOak0o8P9b7bHAaff
	SQ+MDMig2rCQlULM6WabjRvMdeREfpQ=
Date: Mon, 21 Jul 2025 10:24:13 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] hwmon: iio: Add alarm support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
 <20250715012023.2050178-8-sean.anderson@linux.dev>
 <aHYWQOjJEWdLjy7H@smile.fi.intel.com>
 <3b35b3a7-3f1a-4401-9b60-ba4afda5636e@linux.dev>
 <aHd6NEHcCa6aqJB5@smile.fi.intel.com>
 <e4894ab6-dd75-45d5-a49f-832c64b89eaf@linux.dev>
 <aH3vcye29TrG8s2Z@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aH3vcye29TrG8s2Z@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/21/25 03:42, Andy Shevchenko wrote:
> On Thu, Jul 17, 2025 at 12:23:58PM -0400, Sean Anderson wrote:
>> On 7/16/25 06:08, Andy Shevchenko wrote:
>> > On Tue, Jul 15, 2025 at 12:20:24PM -0400, Sean Anderson wrote:
>> >> On 7/15/25 04:50, Andy Shevchenko wrote:
>> >> > On Mon, Jul 14, 2025 at 09:20:23PM -0400, Sean Anderson wrote:
> 
> ...
> 
>> >> >>  #include <linux/hwmon-sysfs.h>
>> >> > 
>> >> > + blank line here..
>> >> 
>> >> why?
>> > 
>> > To group the subsystem related headers (which are more custom and less generic).
>> > This allows to follow what the subsystems are in use and what APIs / types are
>> > taken.
>> 
>> Then you should send a patch for coding-style.rst.
> 
> Does any of the common sense approach need to be written in the documentation?

Yes! My base assumption would be that includes should be alphabetized,
but that no other ordering or spacing is necessary. Your "common sense"
is not so common.

>> >> >>  #include <linux/iio/consumer.h>
>> >> >> +#include <linux/iio/events.h>
>> >> >> +#include <linux/iio/iio.h>
>> >> >>  #include <linux/iio/types.h>
>> >> > 
>> >> > ...and here?
>> >> 
>> >> OK
>> >> 
>> >> >> +#include <uapi/linux/iio/events.h>
>> > 
>> > As similar here, to visually split uAPI and the rest. This increases
>> > readability and maintenance.
> 
> ...
> 
>> >> >> +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener *listener,
>> >> >> +				      u64 id)
>> >> >> +{
>> >> >> +	ssize_t i;
>> >> >> +
>> >> >> +	for (i = 0; i < listener->num_alarms; i++)
>> >> >> +		if (listener->ids[i] == id)
>> >> >> +			return i;
>> >> > 
>> >> >> +	return -1;
>> >> > 
>> >> > -ENOENT ?
>> >> > This will allow to propagate an error code to the upper layer(s).
>> >> 
>> >> I suppose. But I think
>> >> 
>> >> alarm = iio_hwmon_lookup_alarm(...);
>> >> if (alarm < 0)
>> >> 	return -ENOENT;
>> >> 
>> >> is clearer than
>> > 
>> > I disagree. This makes it worth as it shadows other possible code(s), if any,
>> > and makes harder to follow as reader has to check the callee implementation.
>> > 
>> > The shadow error codes need a justification.
>> 
>> OK, I will return a bool next time to avoid any misconceptions that the return
>> code means anything other than "found" or "not found"
> 
> This makes sense. And IIRC it's even documented.
> 
>> >> alarm = iio_hwmon_lookup_alarm(...);
>> >> if (alarm < 0)
>> >> 	return alarm;
>> >> 
>> >> because you don't have to read the definition of iio_hwmon_lookup_alarm
>> >> to determine what the return value is.
>> > 
>> > Exactly my point!
>> 
>> your point is that you want readers to have to read the definition of
>> iio_hwmon_lookup_alarm in order to determine that ENOENT is a possible
>> error from add_alarm_attr? I don't follow.
> 
> No, my point is that readers should not care about error code. If it's
> propagated to the upper layer, the upper layer will decide on how to proceed.
> And -ENOENT is de facto standard for "entity not found".
> 
>> >> >> +}
> 
> ...
> 
>> >> >> +err_alarms:
>> >> >> +	kfree(listener->alarms);
>> >> >> +	kfree(listener->ids);
>> >> >> +err_listener:
>> >> >> +	kfree(listener);
>> >> >> +err_unlock:
>> >> >> +	mutex_unlock(&iio_hwmon_listener_lock);
>> >> >> +	return ERR_PTR(err);
>> >> > 
>> >> > What about using __free()?
>> >> 
>> >> That works for listener, but not for alarms or ids.
>> > 
>> > Why not?
> 
> No answer? Have you checked how cleanup.h suggests to avoid cleaning the memory
> when it's supposed to be used later on?

Sorry, I missed this the first time. Anyway the reason it doesn't work
for alarms/ids is that those are members of listener and not separate
variables. And I think it's more concise this way. Compare the existing

	listener->alarms = bitmap_zalloc(listener->num_alarms, GFP_KERNEL);
	if (!listener->alarms)
		goto err_listener;

	/* ... */
	return listener;

err_alarms:
	kfree(listener->alarms);
	/* ... */

vs

	unsigned long __free alarms = NULL;

	alarms = bitmap_zalloc(listener->num_alarms, GFP_KERNEL);
	if (!alarms)
		return -ENOMEM;
	listener->alarms = alarms;
	
	/* ... */
	no_free_ptr(alarms);
	return listener;

I don't really think there's an advantage.

>> >> >> +static void iio_hwmon_listener_put(void *data)
>> >> >> +{
>> >> >> +	struct iio_hwmon_listener *listener = data;
>> >> >> +
>> >> >> +	scoped_guard(mutex, &iio_hwmon_listener_lock) {
>> >> >> +		if (unlikely(listener->refcnt == UINT_MAX))
>> >> >> +			return;
>> >> >> +
>> >> >> +		if (--listener->refcnt)
>> >> >> +			return;
>> >> > 
>> >> > Can the refcount_t be used with the respective APIs? Or even kref?
>> >> 
>> >> Why? We do all the manipulation under a mutex, so there is no point in
>> >> atomic access. Instead of the games refcnt_t has to play to try and
>> >> prevent overflow we can just check for it directly.
>> > 
>> > refcount_t provides a facility of overflow/underflow.
>> 
>> refcount_t can't prevent underflow because it's atomic. All it can do is
>> warn after the fact. And of course overflow is handled properly here.
>> But it can't occur in practice unless you specifically load multiple
>> devicetrees at runtime. So we don't need it anyway.
> 
> It will warn the user in such cases. Your code won't do it, even if it's not a
> big deal or never happens situation, it's still better to use in-kernel
> standard ways of handling these things.

It's not the standard for refcounts protected by a mutex. There are
literally hundreds of existing examples of this.

--Sean 

