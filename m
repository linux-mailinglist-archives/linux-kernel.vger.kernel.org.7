Return-Path: <linux-kernel+bounces-736331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D789B09B99
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F413B6B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4105B20551C;
	Fri, 18 Jul 2025 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kw+5hiIb"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9791EDA03;
	Fri, 18 Jul 2025 06:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820910; cv=none; b=A2nT4fxELXz9v3cqjcC2lahTDu583E3EwWqvaobhL/7SGxq50TFfiLvYSdMcIB34Bpsqz/BTWato8x3SNvYXPOgZJJV4qNCf7XfnYm/1VXud5FPtR4XYScP7aD8lZxdRRGmPN2ni0Vm0jhuM6AlmDfaPGJYKY4Y3B/NZxqnyJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820910; c=relaxed/simple;
	bh=PMGqAXJ5To+NqTilXmxzsLswjifNQ4YAOdtsYVl21zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2MGMzVzbB/RbDd7EdisscLOWCUol0TqpjPrnJ+6qWX0MRgKqvgnI7Ie7I+KWW13M0tGfv9E0QXwF5CvG3eMTSNrH4OP04OVTOaBrPBhOlEZpkyKhHHYO1i9Ak7uXsnTHI2dz8P33v9+FJ+GVOFHDpsUNZpw9PxiwY9BLccC/V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kw+5hiIb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752820905;
	bh=PMGqAXJ5To+NqTilXmxzsLswjifNQ4YAOdtsYVl21zA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kw+5hiIbtUBw5eKiWDr6Xw2pi0gGWQ+WCDoshxN0rqHCAEN9TiQKGOaEUGol6RWCa
	 NWv90cZsPN0o2uHVG0FKW3obxDYqx0elGbu/y6eapLWQfgD1GcVlGxrrT94zuvTzIB
	 cMHLlD3c61xiOntUdZS5xi8nSknhd+J/zRs4Bp3hBiF5QWBEfLwtPVg3dWCTza6/pp
	 FeO/2XnBOcTNtHrF1DmANAYdiaxUGPEdfAaBBN0iBm2avquRlpCF/uxyZqRQjOx1yj
	 jZdK+A9WZn3STTDJ+afD8//0v/784k7nvyEzoCdX4huNsFjCNDjEbNqMZM/CZc2MJB
	 mmMPnqHzH0gaQ==
Received: from [192.168.1.90] (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C686B17E1553;
	Fri, 18 Jul 2025 08:41:44 +0200 (CEST)
Message-ID: <e1bf85c8-930c-4f70-86ea-460e1db8e6c6@collabora.com>
Date: Fri, 18 Jul 2025 09:41:44 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] usb: vhci-hcd: Prevent suspending virtually attached
 devices
To: Shuah Khan <skhan@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Brian G. Merrell" <bgmerrell@novell.com>, kernel@collabora.com,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
 <20250717-vhci-hcd-suspend-fix-v1-1-2b000cd05952@collabora.com>
 <42bcf1e1-1bb2-4b63-9790-61393f780202@rowland.harvard.edu>
 <2a87101f-6bee-4bd1-816a-1dfbe7b4a578@linuxfoundation.org>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <2a87101f-6bee-4bd1-816a-1dfbe7b4a578@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alan, Shuah,

On 7/17/25 10:55 PM, Shuah Khan wrote:
> On 7/17/25 12:26, Alan Stern wrote:
>> On Thu, Jul 17, 2025 at 06:54:50PM +0300, Cristian Ciocaltea wrote:
>>> The VHCI platform driver aims to forbid entering system suspend when at
>>> least one of the virtual USB ports are bound to an active USB/IP
>>> connection.
>>>
>>> However, in some cases, the detection logic doesn't work reliably, i.e.
>>> when all devices attached to the virtual root hub have been already
>>> suspended, leading to a broken suspend state, with unrecoverable resume.
>>>
>>> Ensure the attached devices do not enter suspend by setting the syscore
>>> PM flag.
>>>
>>> Fixes: 04679b3489e0 ("Staging: USB/IP: add client driver")
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>   drivers/usb/usbip/vhci_hcd.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>>> index e70fba9f55d6a0edf3c5fde56a614dd3799406a1..762b60e10a9415e58147cde2f615045da5804a0e 100644
>>> --- a/drivers/usb/usbip/vhci_hcd.c
>>> +++ b/drivers/usb/usbip/vhci_hcd.c
>>> @@ -765,6 +765,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>>>                    ctrlreq->wValue, vdev->rhport);
>>>                 vdev->udev = usb_get_dev(urb->dev);
>>> +            dev_pm_syscore_device(&vdev->udev->dev, true);
>>>               usb_put_dev(old);
>>>                 spin_lock(&vdev->ud.lock);
>>> @@ -785,6 +786,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>>>                       "Not yet?:Get_Descriptor to device 0 (get max pipe size)\n");
>>>                 vdev->udev = usb_get_dev(urb->dev);
>>> +            dev_pm_syscore_device(&vdev->udev->dev, true);
>>>               usb_put_dev(old);
>>>               goto out;
>>
>> This looks very strange indeed.
>>
>> First, why is vhci_urb_enqueue() the right place to do this?  I should
>> think you would want to do this just once per device, at the time it is
>> attached.  Not every time a new URB is enqueued.
> 
> Correct. This isn't the right place to do this even if we want to go with
> the option to prevent suspend. The possible place to do this would be
> from rh_port_connect() in which case you will have access to usb_hcd device.

Oh, I chose to handle this in vhci_urb_enqueue() as it seemed to be the only
place where vdev->udev gets assigned.  Now I wonder if that assignment
should really be here, but probably I'm missing something obvious as I'm
still in the process of getting familiar with the code base.

> This has to be undone from rh_port_disconnect(). Also how does this impact
> the usbip_host - we still need to handle usbip_host suspend.

I've only addressed usbip_vhci suspend prevention at the moment, as that was
supposed to work.

>>
>> Second, how do these devices ever go back to being regular non-syscore
>> things?

This only handles the client side, i.e. the virtually attached devices,
hence I didn't pay much attention to undo the syscore thing (wasn't
straightforward to accomplish via the URB handling path anyway).  I'll
definitely fix this up by moving to rh_port_[dis]connect(), as Shuah
suggested.

>> Third, if this change isn't merely a temporary placeholder, it certainly
>> needs to have a comment in the code to explain what it does and why.

Indeed, will document this.

>> Fourth, does calling dev_pm_syscore_device() really prevent the device
>> from going into suspend?  

Yes, this is managed by core PM infra which basically skips processing of
any PM callbacks when the flag is set - e.g. see how dev->power.syscore is
handled in device_suspend():

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/main.c?h=v6.16-rc6#n1800

>> What about runtime suspend?  

I think that's a slightly different topic - so far I've been only focused on
system suspend.

> And what good
>> does it to do prevent the device from being suspended if the entire
>> server gets suspended?

As mentioned above, the target for now is to unbreak the system suspend
prevention on the client side.  The server side doesn't seem to support it.

>>
>> Fifth, the patch description says the purpose is to prevent the server
>> from going into system suspend.  

Hmm, I might need to improve the description in this case, as I only
mentioned VHCI and the virtual hub/ports, hence I was referring to the
client side only.

>> How does marking some devices with
>> dev_pm_syscore_device() accomplish this?

Please check the link above.

> 
> We have been discussing suspend/resume and reboot behavior in another thread
> that proposed converting vhci_hcd to use faux bus.
> 
> In addition to what Alan is asking, To handle suspend/resume cleanly, the
> following has to happen at a higher level:
> 
> - Let the usbip hots host know client is suspending the connection.
>   The physical device isn't suspended on the host.
> - suspend the virtual devices and vhci_hcd
> 
> Do the reverse to resume.

Right, I was actually looking into having a proper suspend/resume support
rather than just preventing it on the client side (for now), but that's
clearly not an easy task to accomplish, as it requires extending the USP/IP
protocol and most probably also the user space tools.

> 
> I would say:
> 
> - We don't want vhci_hcd and usbip_host preventing suspend

That's understandable, but currently vhci_hcd is supposed to prevent
suspend, which mostly works but it's unreliable, hence my initial goal was
to provide a simple fix for it before attempting to experiment with more
invasive changes.

> - It might be cleaner and safer to detach the devices during
>   suspend on both ends. This is similar to what happens now when
>   usbip host and vhci_hcd are removed.
> - Note that usbip_host and vhci_hcd don't fully support suspend and
>   resume at the moment.

Thank you both for the initial feedback!

Regards,
Cristian


