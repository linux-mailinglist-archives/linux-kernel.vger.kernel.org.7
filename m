Return-Path: <linux-kernel+bounces-826185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B6EB8DC86
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 15:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96ECF3AF84B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438702D876A;
	Sun, 21 Sep 2025 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKgWQQZX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834032868B;
	Sun, 21 Sep 2025 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758462035; cv=none; b=lkoX+CN+fkxUlT9o/QF6rJs4kojVcfOKpbvbF0+0p/qqySc40eARB+DpLzR2pSkeGJnkTGccUi83F4C8H8km4S3S0mBg689Akf6HjycQo6cWTC4W5TyyefW7I1yEb1ujSoqN3iVadgmPnPIcZS0dX+Xl/nhr9vfL4cO9ifkEkoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758462035; c=relaxed/simple;
	bh=95QcD0HJijwOHoaQ6eyOQBU6JkvhnmTwXbdFW5nxPbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n70+U7E3KNvei0SmcN72+KwtrX/pYKe82rbmVPZl5Rx/RQOCVmBBJia9zK6w4lf+YV7p/z1RKGgRboU7EmdMqgmN5iMicFHBQZTUf3Irord9xfkq74fMbMNtmrdbd4j6LvTalg0Rp6cg9LRmh/iFnUj+1IgHW6OJ5A9L2YgtiPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKgWQQZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD449C4CEE7;
	Sun, 21 Sep 2025 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758462035;
	bh=95QcD0HJijwOHoaQ6eyOQBU6JkvhnmTwXbdFW5nxPbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DKgWQQZXjQN82L8kwgQ1cbiOIhuNq4crRXiki+UNkV3qaXbmI8jeQiebAsX9P3zpO
	 V91T12ukCZY9WgU+VsuNXfDS0hwayPluHpc5H3tWZV4/ci7xd0qpNf9MBvGyuBrZIA
	 qzHM1lnthrdQms+WHEs6qy/NvWYV5h+/8RJAtfIv7eKeC+M1P3c+Q6ibITQ+l4olyg
	 zTmZrVXhzWDqEUm0WGrmWRHLrk/VFI+YPj98lgcg8HXmKfMATUCcow5EmJPPQ7sgnI
	 oh8XKMRU2RB2ivVWxRBXC5TqO2KYDgdyi9LuAo1EAucj4CnPsyDIHGs4Wo54MeKJSP
	 jsOrImSzehm+Q==
Message-ID: <41bb000c-5643-4ed2-8d33-a6bd8a549409@kernel.org>
Date: Sun, 21 Sep 2025 15:40:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/22] usb: dwc3: Add Apple Silicon DWC3 glue layer
 driver
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
 Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-4-52c348623ef6@kernel.org>
 <20250919224016.gyao3aoka5ineear@synopsys.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250919224016.gyao3aoka5ineear@synopsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 20.09.25 00:40, Thinh Nguyen wrote:
> On Sat, Sep 06, 2025, Sven Peter wrote:
>> As mad as it sounds, the dwc3 controller present on the Apple M1 must be
>> reset and reinitialized whenever a device is unplugged from the root
>> port or when the PHY mode is changed.

[....]

>> +/**
>> + * struct dwc3_apple - Apple-specific DWC3 USB controller
>> + * @dwc: Core DWC3 structure
>> + * @dev: Pointer to the device structure
>> + * @mmio_resource: Resource to be passed to dwc3_core_probe
>> + * @apple_regs: Apple-specific DWC3 registers
>> + * @resets: Reset control
>> + * @role_sw: USB role switch
>> + * @lock: Mutex for synchronizing access
>> + * @core_probe_done: True if dwc3_core_probe was already called after the first plug
>> + * @mode: Current mode of the controller (off/host/device)
> 
> For this platform, current mode of the controller should only ever be
> host or device mode. Seems we're mixing power with usb role? ie. what
> DWC3_APPLE_OFF is being used for?
> 

So this platform is very messed up and in order the bring up dwc3 and 
the PHY there are four steps:

1) The PHY itself has to be brought up; for this we need to know the 
mode (USB3, USB3+DisplayPort, USB4, etc) and the lane orientation. This 
happens from typec_mux_set
2) DWC3 has to be brought up but we must not touch the gadget area or 
start xhci yet
3) The PHY bring-up has to be finalized and dwc3's PIPE interface has to 
be switched to the USB3 PHY, this is done inside phy_set_mode.
4) We can now initialize xhci or gadget mode.

I think we can switch 1 and 2 but 3 has to happen after (1 and 2) and 4 
has to happen after 3.

And then to bring this all down again:

1) DWC3 has to exit host or gadget mode and must no longer touch those 
registers
2) The PHY has to switch dwc3's PIPE interface back to the dummy backend
3) The PHY itself can be shut down, this happens from typec_mux_set

We also can't transition the PHY from one mode to another while dwc3 is 
up and running (this is slightly wrong, some transitions are possible, 
others aren't but because we have no documentation for this I'd rather 
play it safe).

After both the PHY and dwc3 are initialized we will also only ever see a 
single "new device connected" event. If we just keep them running only 
the first device plugged in will ever work. XHCI's port status register 
actually does show the correct state but no interrupt ever comes in. In 
gadget mode we don't even get a USBDisconnected event and everything 
looks like there's still something connected on the other end.


And to make this all extra fun: If we get the order of some of this 
wrong either the port is just broken until a phy+dwc3 reset, or it's 
broken until a full SoC reset (likely because we can't reset some parts 
of the PHY), or some watchdog kicks in after a few seconds and forces a 
full SoC reset (I've mostly seen this with USB4/Thunderbolt but there's 
clearly some watchdog that hates invalid states).


So there's really no good way to keep dwc3 fully up and running after we 
disconnect a cable because then we can't shut down the PHY anymore. And 
if we kept the PHY running in whatever mode until the next cable is 
connected we'd need to tear it all down and bring it back up again 
anyway to detect and use the next device.


Instead, I just shutdown everything once a cable is disconnected and 
that's this DWC3_APPLE_OFF state. Maybe I can put the explanation above 
as a comment in there and maybe also rename "mode" to "state" here 
because we may get something like DWC3_APPLE_USB4_TUNNEL in the future 
here as well because the sequence might be a bit different there.



>> + */
>> +struct dwc3_apple {

[...]

>> +	/*
>> +	 * Note that we only bring up dwc3 once the first device is attached because we need to know
>> +	 * the role (e.g. host), mode (e.g. USB3) and lane orientation to bring up the PHY which is
>> +	 * tightly coupled to dwc3.
>> +	 */
> 
> The wording here is odd. You can wait for attach to do this, but it
> should not be a requirement. You might not know whether you need to
> switch role, but you should be able to initialize the controller in
> either host or device mode prior to attachment.
> 
> Any particular reason we need to do this? If not, we can do away with
> the core_probe_done condition.

Because I can't really bring up dwc3 fully to any mode without 
cooperation from the PHY and bringing it up here doesn't really buy us 
much (see above). What I could do here is already call dwc3_core_probe 
and then immediately dwc3_core_exit again to get rid of that condition.



Thanks,


Sven

