Return-Path: <linux-kernel+bounces-756141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E44DCB1B078
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4FA189B9C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA932580D1;
	Tue,  5 Aug 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laNracnf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC691C84B8;
	Tue,  5 Aug 2025 08:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383932; cv=none; b=AUmcALfF7nEB5LkJPSQIGuDTcr79rLYq0KFqojchCSW2JhI4RHEhgnvIoCcuyyOMhu3YnNT1FFcfVC2vlpCG+16c2j9hum7B2MAEvr0385JDG3LFfth3HkkUF6gkqfqR3UK/7PzM8M/QxOSDCeuKrnvCzs6qwSnLjTSI5lEXSNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383932; c=relaxed/simple;
	bh=7e3Jjh/eVa6OnJiKZ1mrQPktmlj6BCOmlcl99VnT8E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qITGWU6QJjaI63dME8dlYOOROvEyCqYsyAxeBSOElDqnf9V7xnYfSyXS9527qPZZXaEuYSMllApu/1p71FkJ3L1ouv3kL1uYs/HZrzBNcMTbC68v1z71XtWMP1Q9beNE6x9OrwNrewP9N3fedEamVdWmD96ictQc3/QEM8lqhuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laNracnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F834C4CEF4;
	Tue,  5 Aug 2025 08:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754383931;
	bh=7e3Jjh/eVa6OnJiKZ1mrQPktmlj6BCOmlcl99VnT8E4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=laNracnfm/7Zip2BJzJ4u6qcQKaS/zVyy3natCLg0mFhJb3CSjNd634N3kVuQyRjq
	 2Izo8R1x1rXEFo9Eu+VWPipj/w0gf+shh5v+zokLsDMwjDOUbfnPfwGyKNHkCwIoFC
	 zbJzY/g5Nna0FyHdtBZcKkcNJKwvvQC1AxxU6KXgtHUal2wM87bmTbIRyiCq5q0UNG
	 aDEU9l/Fef/kD97jol5y8eA0JclEa/1Zq8nJWuhvfCfJHWamdi7lNdiOLG0A39tiV1
	 yc2JARokG0Zd79XTlhyltJIhWR/eVdNstqSdAeADvbAVHCnszNCd/Fdegf9WGioMQW
	 MQz3VWFTrK5QA==
Message-ID: <637240b1-7658-4549-aa17-4998ab72d6be@kernel.org>
Date: Tue, 5 Aug 2025 10:52:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: fusb302: fix scheduling while atomic when
 using virtio-gpio
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Yongbo Zhang <giraffesnn123@gmail.com>, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250526043433.673097-1-giraffesnn123@gmail.com>
 <aDbkBZi1L442jd7i@kuha.fi.intel.com>
 <m7n22g5fsfvpjz4s5d6zfcfddrzrj3ixgaqehrjkg7mcbufvjc@s4omshvxtkaf>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <m7n22g5fsfvpjz4s5d6zfcfddrzrj3ixgaqehrjkg7mcbufvjc@s4omshvxtkaf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 4-Aug-25 8:00 PM, Sebastian Reichel wrote:
> +CC Hans de Goede
> 
> Hi,
> 
> On Wed, May 28, 2025 at 01:23:01PM +0300, Heikki Krogerus wrote:
>> On Mon, May 26, 2025 at 12:34:33PM +0800, Yongbo Zhang wrote:
>>> When the gpio irqchip connected to a slow bus(e.g., i2c bus or virtio
>>> bus), calling disable_irq_nosync() in top-half ISR handler will trigger
>>> the following kernel BUG:
>>>
>>> BUG: scheduling while atomic: RenderEngine/253/0x00010002
>>> ...
>>> Call trace:
>>>  dump_backtrace+0x0/0x1c8
>>>  show_stack+0x1c/0x2c
>>>  dump_stack_lvl+0xdc/0x12c
>>>  dump_stack+0x1c/0x64
>>>  __schedule_bug+0x64/0x80
>>>  schedule_debug+0x98/0x118
>>>  __schedule+0x68/0x704
>>>  schedule+0xa0/0xe8
>>>  schedule_timeout+0x38/0x124
>>>  wait_for_common+0xa4/0x134
>>>  wait_for_completion+0x1c/0x2c
>>>  _virtio_gpio_req+0xf8/0x198
>>>  virtio_gpio_irq_bus_sync_unlock+0x94/0xf0
>>>  __irq_put_desc_unlock+0x50/0x54
>>>  disable_irq_nosync+0x64/0x94
>>>  fusb302_irq_intn+0x24/0x84
>>>  __handle_irq_event_percpu+0x84/0x278
>>>  handle_irq_event+0x64/0x14c
>>>  handle_level_irq+0x134/0x1d4
>>>  generic_handle_domain_irq+0x40/0x68
>>>  virtio_gpio_event_vq+0xb0/0x130
>>>  vring_interrupt+0x7c/0x90
>>>  vm_interrupt+0x88/0xd8
>>>  __handle_irq_event_percpu+0x84/0x278
>>>  handle_irq_event+0x64/0x14c
>>>  handle_fasteoi_irq+0x110/0x210
>>>  __handle_domain_irq+0x80/0xd0
>>>  gic_handle_irq+0x78/0x154
>>>  el0_irq_naked+0x60/0x6c
>>>
>>> This patch replaces request_irq() with devm_request_threaded_irq() to
>>> avoid the use of disable_irq_nosync().
>>>
>>> Signed-off-by: Yongbo Zhang <giraffesnn123@gmail.com>
>>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>>> ---
> 
> I'm currently investigating a potential "regression" (quotes,
> because USB-C support is not yet enabled in the upstream board
> devicetree) with the Radxa ROCK 5B USB-C support after rebasing
> to latest master branch. I'm not yet sure, if this patch is at
> fault or totally unrelated, but please be aware that it undoes
> previous work from Hans de Goede to NOT use threaded IRQs:
> 
> 207338ec5a27 ("usb: typec: fusb302: Improve suspend/resume handling")
> 
> At the same time the fix from Yongbo Zhang misses cleaning up the
> now useless fusb302_irq_work() split, which had been introduced by
> Hans patch to have the hard IRQ as short as possible. With the
> interrupt handler being a thread itself, the code can just be called
> directly.

Yes the mentioned "usb: typec: fusb302: fix scheduling while atomic
when using virtio-gpio" change looks broken to me.

Calling disable_irq_nosync() from an interrupt handler is
perfectly fine and if the virtio GPIO controller cannot handle
that, then that is a bug inside the virtio GPIO controller not
in the the fusb302 driver.

The patch switches to using threaded interrupt handling, but that
does not fix the interrupt storm when level IRQs are used since
all the now threaded interrupt handler does is queue the work
which does the actual interrupt handling. So when the threaded
interrupt handler is done the interrupt source is not yet
cleared and the interrupt will immediately re-fire.

So IMHO the "usb: typec: fusb302: fix scheduling while atomic when
using virtio-gpio" change should be reverted.

Please submit a revert and please Cc me on future changes to fusb302
interrupt handling.

Regards,

Hans









> 
> Greetings,
> 
> -- Sebastian
> 
>>>  drivers/usb/typec/tcpm/fusb302.c | 12 ++++--------
>>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
>>> index f15c63d3a8f4..f2801279c4b5 100644
>>> --- a/drivers/usb/typec/tcpm/fusb302.c
>>> +++ b/drivers/usb/typec/tcpm/fusb302.c
>>> @@ -1477,9 +1477,6 @@ static irqreturn_t fusb302_irq_intn(int irq, void *dev_id)
>>>  	struct fusb302_chip *chip = dev_id;
>>>  	unsigned long flags;
>>>
>>> -	/* Disable our level triggered IRQ until our irq_work has cleared it */
>>> -	disable_irq_nosync(chip->gpio_int_n_irq);
>>> -
>>>  	spin_lock_irqsave(&chip->irq_lock, flags);
>>>  	if (chip->irq_suspended)
>>>  		chip->irq_while_suspended = true;
>>> @@ -1622,7 +1619,6 @@ static void fusb302_irq_work(struct work_struct *work)
>>>  	}
>>>  done:
>>>  	mutex_unlock(&chip->lock);
>>> -	enable_irq(chip->gpio_int_n_irq);
>>>  }
>>>
>>>  static int init_gpio(struct fusb302_chip *chip)
>>> @@ -1747,9 +1743,10 @@ static int fusb302_probe(struct i2c_client *client)
>>>  		goto destroy_workqueue;
>>>  	}
>>>
>>> -	ret = request_irq(chip->gpio_int_n_irq, fusb302_irq_intn,
>>> -			  IRQF_ONESHOT | IRQF_TRIGGER_LOW,
>>> -			  "fsc_interrupt_int_n", chip);
>>> +	ret = devm_request_threaded_irq(dev, chip->gpio_int_n_irq,
>>> +					NULL, fusb302_irq_intn,
>>> +					IRQF_ONESHOT | IRQF_TRIGGER_LOW,
>>> +					"fsc_interrupt_int_n", chip);
>>>  	if (ret < 0) {
>>>  		dev_err(dev, "cannot request IRQ for GPIO Int_N, ret=%d", ret);
>>>  		goto tcpm_unregister_port;
>>> @@ -1774,7 +1771,6 @@ static void fusb302_remove(struct i2c_client *client)
>>>  	struct fusb302_chip *chip = i2c_get_clientdata(client);
>>>
>>>  	disable_irq_wake(chip->gpio_int_n_irq);
>>> -	free_irq(chip->gpio_int_n_irq, chip);
>>>  	cancel_work_sync(&chip->irq_work);
>>>  	cancel_delayed_work_sync(&chip->bc_lvl_handler);
>>>  	tcpm_unregister_port(chip->tcpm_port);
>>> --
>>> 2.49.0
>>
>> -- 
>> heikki
>>


