Return-Path: <linux-kernel+bounces-732257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE97B0642A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9E8189CE37
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8162749C2;
	Tue, 15 Jul 2025 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U2ik4K7I"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8FD24E4C3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596432; cv=none; b=dCmy4YiQpeqwokii+qcVCSAGeriRBtvsYse39oma1PdbxWJxS09y0S8N4udhCtJgPKIH/9QwXOU05IA9N0y6BeUkyrbrClfPt1A+nRKysuLkzrx7oT5pgUr6LIUnc/c+1RT7LvacXbOuazGX5IsWgm/zSLvgh2MUBhmMWJAFA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596432; c=relaxed/simple;
	bh=06yesalwqHV8zE2DkczBQBpvVPyzo5fpUk8YlIdky6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKEea8x96PM66fDhcMjd+8m24YEWVqK8kMPXpzc8f78Lo8KrxMZyVDXR8PQEhuAwlokW8hrUYcECHIJJonfjcRmrE4WZl/08WR5+PZaqoxZQwrj7wBa0FWf5q/5Owpwac+TlY9bF7E3NHsXPIQBHYVquBtbdok6P+1wUmeSf2YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U2ik4K7I; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3b35b3a7-3f1a-4401-9b60-ba4afda5636e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752596428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9+/KXgJfq8R20Vlk8EbnswSlV5Trbxu/cuP2QEQUicg=;
	b=U2ik4K7IDOLheqtcp5wpvNCeQTvhXUOOQK2DFBIy4w4JVCdPClyELN5mSxye7iJRDWcUP9
	j3TbrWck9BurNumg/wNaKKY3ESMKRzrXecz0TUZuyv3YLYR2Esh/NJj+mCc5rv3jU3GA3M
	FLwDhDkAjvpaQxbQUCpOZ66pwFDl6II=
Date: Tue, 15 Jul 2025 12:20:24 -0400
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aHYWQOjJEWdLjy7H@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/15/25 04:50, Andy Shevchenko wrote:
> On Mon, Jul 14, 2025 at 09:20:23PM -0400, Sean Anderson wrote:
>> Add alarm support based on IIO threshold events. The alarm is cleared on
>> read, but will be set again if the condition is still present. This is
>> detected by disabling and re-enabling the event. The same trick is done
>> when creating the attribute to detect already-triggered events.
>> 
>> The alarms are updated by an event listener. To keep the notifier call
>> chain short, we create one listener per iio device, shared across all
>> hwmon devices.
>> 
>> To avoid dynamic creation of alarms, alarms for all possible events are
>> allocated at creation. Lookup is done by a linear scan, as I expect
>> events to occur rarely. If performance becomes an issue, a binary search
>> could be done instead (or some kind of hash lookup).
> 
> ...
> 
>>  #include <linux/hwmon-sysfs.h>
> 
> + blank line here..

why?

>>  #include <linux/iio/consumer.h>
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/iio.h>
>>  #include <linux/iio/types.h>
> 
> ...and here?

OK

>> +#include <uapi/linux/iio/events.h>
> 
> ...
> 
>> +static ssize_t iio_hwmon_lookup_alarm(struct iio_hwmon_listener *listener,
>> +				      u64 id)
>> +{
>> +	ssize_t i;
>> +
>> +	for (i = 0; i < listener->num_alarms; i++)
>> +		if (listener->ids[i] == id)
>> +			return i;
> 
>> +	return -1;
> 
> -ENOENT ?
> This will allow to propagate an error code to the upper layer(s).

I suppose. But I think

alarm = iio_hwmon_lookup_alarm(...);
if (alarm < 0)
	return -ENOENT;

is clearer than

alarm = iio_hwmon_lookup_alarm(...);
if (alarm < 0)
	return alarm;

because you don't have to read the definition of iio_hwmon_lookup_alarm
to determine what the return value is.

>> +}
> 
> ...
> 
>> +static int iio_hwmon_listener_callback(struct notifier_block *block,
>> +				       unsigned long action, void *data)
>> +{
>> +	struct iio_hwmon_listener *listener =
>> +		container_of(block, struct iio_hwmon_listener, block);
>> +	struct iio_event_data *ev = data;
>> +	ssize_t i;
>> +
>> +	if (action != IIO_NOTIFY_EVENT)
>> +		return NOTIFY_DONE;
>> +
>> +	i = iio_hwmon_lookup_alarm(listener, ev->id);
>> +	if (i >= 0)
>> +		set_bit(i, listener->alarms);
> 
> Do you need an atomic set?

Yes. This protects against concurrent access by iio_hwmon_read_alarm.

>> +	else
>> +		dev_warn_once(&listener->indio_dev->dev,
>> +			      "unknown event %016llx\n", ev->id);
>> +
>> +	return NOTIFY_DONE;
>> +}
> 
> ...
> 
>> +static struct iio_hwmon_listener *iio_hwmon_listener_get(struct iio_dev *indio_dev)
>> +{
>> +	struct iio_hwmon_listener *listener;
>> +	int err = -ENOMEM;
>> +	size_t i, j;
>> +
>> +	guard(mutex)(&iio_hwmon_listener_lock);
>> +	list_for_each_entry(listener, &iio_hwmon_listeners, list) {
>> +		if (listener->indio_dev == indio_dev) {
>> +			if (likely(listener->refcnt != UINT_MAX))
>> +				listener->refcnt++;
>> +			return listener;
>> +		}
>> +	}
>> +
>> +	listener = kzalloc(sizeof(*listener), GFP_KERNEL);
>> +	if (!listener)
>> +		goto err_unlock;
>> +
>> +	listener->refcnt = 1;
>> +	listener->indio_dev = indio_dev;
>> +	listener->block.notifier_call = iio_hwmon_listener_callback;
>> +	for (i = 0; i < indio_dev->num_channels; i++)
>> +		listener->num_alarms += indio_dev->channels[i].num_event_specs;
>> +
>> +	listener->ids = kcalloc(listener->num_alarms, sizeof(*listener->ids),
>> +				GFP_KERNEL);
>> +	listener->alarms = bitmap_zalloc(listener->num_alarms, GFP_KERNEL);
>> +	if (!listener->ids || !listener->alarms)
>> +		goto err_listener;
>> +
>> +	i = 0;
>> +	for (j = 0; j < indio_dev->num_channels; j++) {
>> +		struct iio_chan_spec const *chan = &indio_dev->channels[j];
>> +		size_t k;
>> +
>> +		for (k = 0; k < chan->num_event_specs; k++)
>> +			listener->ids[i++] =
>> +				iio_event_id(chan, chan->event_spec[k].type,
>> +					     chan->event_spec[k].dir);
>> +	}
>> +
>> +	err = iio_event_register(indio_dev, &listener->block);
>> +	if (err)
>> +		goto err_alarms;
>> +
>> +	list_add(&listener->list, &iio_hwmon_listeners);
> 
>> +	mutex_unlock(&iio_hwmon_listener_lock);
> 
> With guard() ???

Whoops. Missed that when refactoring.

>> +	return listener;
>> +
>> +err_alarms:
>> +	kfree(listener->alarms);
>> +	kfree(listener->ids);
>> +err_listener:
>> +	kfree(listener);
>> +err_unlock:
>> +	mutex_unlock(&iio_hwmon_listener_lock);
>> +	return ERR_PTR(err);
> 
> What about using __free()?

That works for listener, but not for alarms or ids.

>> +}
> 
> ...
> 
>> +static void iio_hwmon_listener_put(void *data)
>> +{
>> +	struct iio_hwmon_listener *listener = data;
>> +
>> +	scoped_guard(mutex, &iio_hwmon_listener_lock) {
>> +		if (unlikely(listener->refcnt == UINT_MAX))
>> +			return;
>> +
>> +		if (--listener->refcnt)
>> +			return;
> 
> Can the refcount_t be used with the respective APIs? Or even kref?

Why? We do all the manipulation under a mutex, so there is no point in
atomic access. Instead of the games refcnt_t has to play to try and
prevent overflow we can just check for it directly.

>> +		list_del(&listener->list);
>> +		iio_event_unregister(listener->indio_dev, &listener->block);
>> +	}
>> +
>> +	kfree(listener->alarms);
>> +	kfree(listener->ids);
>> +	kfree(listener);
>> +}
> 
> ...
> 
>> +static ssize_t iio_hwmon_read_alarm(struct device *dev,
>> +				    struct device_attribute *attr,
>> +				    char *buf)
>> +{
>> +	struct iio_hwmon_alarm_attribute *sattr = to_alarm_attr(attr);
>> +	struct iio_hwmon_state *state = dev_get_drvdata(dev);
>> +	struct iio_channel *chan = &state->channels[sattr->index];
>> +
>> +	if (test_and_clear_bit(sattr->alarm, sattr->listener->alarms)) {
>> +		u64 id = sattr->listener->ids[sattr->alarm];
>> +		enum iio_event_direction dir = IIO_EVENT_CODE_EXTRACT_DIR(id);
>> +
>> +		WARN_ON(iio_hwmon_alarm_toggle(chan, dir));
> 
>> +		strcpy(buf, "1\n");
>> +		return 2;
> 
>> +	}
>> +
>> +	strcpy(buf, "0\n");
>> +	return 2;
> 
> Better to assign the value and
>
> 	return sysfs_emit(...);
> 
> which will make even easier to recognize that this is supplied to user via
> sysfs.

:l

the things we do to avoid memcpy...

--Sean

>> +}
> 
> ...
> 
>> +static int add_alarm_attr(struct device *dev, struct iio_hwmon_state *st,
>> +			  int i, enum iio_event_direction dir,
>> +			  const char *fmt, ...)
> 
> Same comments as per previous patches.
> 

