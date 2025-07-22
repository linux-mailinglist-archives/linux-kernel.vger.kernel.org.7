Return-Path: <linux-kernel+bounces-740106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1528CB0CFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFCB1891251
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6006528BA98;
	Tue, 22 Jul 2025 03:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="txSruZ0b"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9628B7E1
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153556; cv=none; b=X0Aeg51NVbE7IASnNH77qVAhLXcuQD1PORn6SgydlCj3826U5fnA6gArhOxInahBusd+Yd4zWcym1Bcmog6W5BAsn1KG58kYNXPPbacut6JDKmghegSyhhktDSRzeppCJHfPZyaflDL4GwDJpbHeWeBGJ5oKu7cRY9MFyLzvRQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153556; c=relaxed/simple;
	bh=tIlUbgyzaefMRsD/EiheqUpASZBDkZWFnRy+PUW10jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edgtANvi6G/8Jmwcyhcj197sJNKInXM+g/aeN2MXgxBQhyr/P9bhnFle/jYHtzvi4GenOdL6Nr4oOxoMkY7p+D157c+zUAnk264v19vj5binPqv3G6hq72B5zMQ4t/V9/Im0OZ2m3Y8iq5XRViIBZF4ApoWX7CL3nXRO25fU4OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=txSruZ0b; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d7f0fcef86so476375585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 20:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1753153553; x=1753758353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pXQgbypeScnSKfXHhyJHhtDL8qN8gOL//v5/QEa2oRk=;
        b=txSruZ0bCewyYCgIrL8F9zMvRil5dLkzETj7gn9Bf/n0Uc0Faa2qItI1UJaWzh7jXb
         c4U7gX7Xt5+LWQudAAByuKgKYerHfO/k1PXCZgzV3w99xnj0KyHtvkV6lyFyiaU4Y0kz
         03sLyQwwcKYL1JNqqxfcjT7k24Naa3RtPxCClNz94RN88k8c8DprSidk0WnFkt0hhRZf
         F3z0fYpaDmAfeqDvCkRXX6QhLxGZ5CRC6eJdmdp8csNFUi8O431Oz5c9akmtISErZ9+g
         wGB+Ertziim7TLxNzwmHAVNiVneoqWXNeEQ9R6/VqbiWcdYbhhcXrWounLlPwPdJnFXv
         1Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753153553; x=1753758353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXQgbypeScnSKfXHhyJHhtDL8qN8gOL//v5/QEa2oRk=;
        b=UYUf7OJZTHH2l1BThFRdd6e2fNej77PeUv2Fx2qT+uOojqsp6JuBS6YQaryTj/7L+I
         dsmPDoCELO9wlDiuApNbrXgi04Af4PyrrrTxeP9bHImFU+fw2212JdMVpiZeBylXJ2sK
         GM2Sdv68jeMjgolidjrSKD4z9XOJYNd5BgDVlsMe8QM6oUsX/LahTxATf96TC4zKp38Q
         9vpHNKoxJq+rsfJVgtllxVxsyvFhmlhQngW1sHss3J3UoROYpV2AZWd6TvQwvrrvpama
         6742o+dZ09wqGtceOAmAX+pObj13IU0F+8EOxqvZ7JV0j8xwIApqPt0fbO6QTdW/8WqD
         kBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX09oaw9+53k6irNVSRE1nA48mTjPcI7Uwp4Zif2wyjFK19/xlzZLJUOFeDdeS9GFhfN+PBjhhFh5rRlrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo1Z8p51oRKWnMA/AmnjXS7Rj1xkRX6DV8Z0NNgp4ctJBvB2VM
	84FedU8hR6111guPyUof9q9aSH3rQxJggcckw2WgxOIK1zMX+p/Umhos6o1V5QC1hmtHFpi/v5Y
	o5Kc=
X-Gm-Gg: ASbGncsvfXoQJEdl4bbt+rEtOcAxlmU6eevbUycHR8XVDZkKObjyHrLRWbHBWjxHInz
	QyVdL9fwTT24h1/FLy9fu+YBHe+P8eL5eeBE7d1LncMImUDL2ipmpj/2Dh7F6FxpTycvVs1XEsW
	zTvEQhLNtzWNqIFBi11uiOGPKa+nHJN3R1GyIJbhx93+fdsovWlckWInFVH4aPBjNrkqXPYZOUR
	IhNHU0Di2hDFSYeKQSxcc63TrHH4rmfkr2K0Rm7j9Lb1DrFeRGxC/HqBWTEV3/FQ/QifRcYjVye
	hy3QGVwlGa2o1kppjd3QAmb9T0+XI2ASqbK2quvFD9dvqmjfglsw3pxh/SYW7d204OYkUu0Dxvv
	AOovAm3rV8W1artBvjMLlOiY9YchCG4ZZLA==
X-Google-Smtp-Source: AGHT+IGM2G9zWGTMT+LcPqfNn9K7gUHalwUB3sMFPPDTNwpMJMSJ58HmIh9Ou4aGN66Olq7K3KkAJA==
X-Received: by 2002:a05:620a:8198:b0:7e3:46ad:65f9 with SMTP id af79cd13be357-7e346ad678amr1919329385a.23.1753153553456;
        Mon, 21 Jul 2025 20:05:53 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::401d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c44d69sm479537785a.58.2025.07.21.20.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 20:05:52 -0700 (PDT)
Date: Mon, 21 Jul 2025 23:05:50 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Marco Tormento <mtormento80@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: hub: Move typec deattach before children
 disconnections in usb_disconnect()
Message-ID: <b7468de2-d186-4706-8db3-594285ba264b@rowland.harvard.edu>
References: <20250720210847.30998-1-mtormento80@gmail.com>
 <36a75fd9-71a4-4f53-9a35-560cd9cd5687@rowland.harvard.edu>
 <CACF_UwqpzNJWm0=zJh=1N_9p1Q6YjmU+DSofB_OOySkdWC_AxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACF_UwqpzNJWm0=zJh=1N_9p1Q6YjmU+DSofB_OOySkdWC_AxA@mail.gmail.com>

On Tue, Jul 22, 2025 at 01:18:25AM +0200, Marco Tormento wrote:
> On Mon, 21 Jul 2025 at 03:21, Alan Stern <stern@rowland.harvard.edu> wrote:
> > I'm not a typec expert; in fact I know practically nothing about it.
> > Nevertheless, this sounds strange.  The recursive usb_disconnect() calls
> > should affect the connectors to the monitor's children and the monitor's
> > own ports, not the connector or port on the monitor's parent hub.
> 
> What you wrote makes total sense, let me add some detail though.
> When I plug the monitor to the thunderbolt port, 3 usb hubs pop up, but only 2
> are backed by XHCI Host Controllers: usb3 and usb4.

I don't know what you mean when you say "backed by".  usb3 and usb4 are 
the two root hubs of the xHCI host controller.  usb3-1 is an internal 
hub (presumably built into the monitor) attached to the usb3 root hub.

> usb 3-1 instead is using usb3 and it has 3 devices connected to it: mouse,
> keyboard and a mysterious billboard device:
> 
> xhci_hcd 0000:3c:00.0: xHCI Host Controller
> xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus number 3
> xhci_hcd 0000:3c:00.0: hcc params 0x200077c1 hci version 0x110 quirks
> 0x0000000200009810
> xhci_hcd 0000:3c:00.0: xHCI Host Controller
> xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus number 4
> xhci_hcd 0000:3c:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.15
> usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb3: Product: xHCI Host Controller
> usb usb3: Manufacturer: Linux 6.15.7-arch1-1-mentor xhci-hcd
> usb usb3: SerialNumber: 0000:3c:00.0
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.15
> usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb4: Product: xHCI Host Controller
> usb usb4: Manufacturer: Linux 6.15.7-arch1-1-mentor xhci-hcd
> usb usb4: SerialNumber: 0000:3c:00.0
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> typec port0: bound usb3-port1 (ops connector_ops [usbcore])
> typec port0: bound usb4-port1 (ops connector_ops [usbcore])
> typec port1: bound usb3-port2 (ops connector_ops [usbcore])
> typec port1: bound usb4-port2 (ops connector_ops [usbcore])

Why are the usb3 port connectors getting bound at this point rather than 
when usb3 was registered?

> usb 3-1: new high-speed USB device number 2 using xhci_hcd
> usb 3-1: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.36
> usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> usb 3-1: Product: 4-Port USB 2.0 Hub
> usb 3-1: Manufacturer: Generic
> hub 3-1:1.0: USB hub found
> hub 3-1:1.0: 3 ports detected
> usb 3-1.3: new full-speed USB device number 3 using xhci_hcd
> usb 3-1.3: not running at top speed; connect to a high speed hub

I'm actually puzzled by this line.  Apparently the mysterious Realtek 
BillBoard Device claims that it is capable of connecting at high speed, 
but even though it was attached to a high-speed hub it only connected at 
full speed.  Things like this have shown up in other users' reports but 
I never bothered to point out the inconsistencies to anyone.

Either the device is lying about its capabilities or else it is 
malfunctioning.  Either way, I guess there isn't anything the kernel can 
do about it.

> usb 3-1.3: New USB device found, idVendor=0bda, idProduct=5400, bcdDevice= 1.07
> usb 3-1.3: New USB device strings: Mfr=17, Product=18, SerialNumber=19
> usb 3-1.3: Product: BillBoard Device
> usb 3-1.3: Manufacturer: Realtek
> usb 3-1.3: SerialNumber: 123456789ABCDEFGH
> usb 3-1.2: new full-speed USB device number 4 using xhci_hcd
> usb 3-1.2: New USB device found, idVendor=0951, idProduct=16e6, bcdDevice=21.08
> usb 3-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> usb 3-1.2: Product: HyperX Alloy Origins Core
> usb 3-1.2: Manufacturer: Kingston
> usb 3-1.1: new full-speed USB device number 5 using xhci_hcd
> usb 3-1.1: New USB device found, idVendor=1a7c, idProduct=0197, bcdDevice= 1.06
> usb 3-1.1: New USB device strings: Mfr=1, Product=3, SerialNumber=0
> usb 3-1.1: Product: Evoluent VerticalMouse D
> usb 3-1.1: Manufacturer: Kingsis Peripherals
> 
> When I unplug the monitor though, usb 3-1 is not processed as part of
> hub_disconnect_children() of usb3 hub, as I would expect.

Are you sure about this?  How did you reach that conclusion?

> It is processed on its own (added some debugging log to some functions):
> 
> usb 3-1: [usb_disconnect] debugging
> usb 3-1: [usb_disconnect] USB disconnect, device number 2
> usb 3-1: [hub_disconnect_children] debugging hub_disconnect_children()
> usb 3-1: [hub_disconnect_children] disconnecting child 0
> usb 3-1.1: [usb_disconnect] debugging
> usb 3-1.1: [usb_disconnect] USB disconnect, device number 5
> usb 3-1.1: [hub_disconnect_children] debugging hub_disconnect_children()
> usb 3-1.1: [usb_disconnect] unregistering device
> usbhid 3-1.1:1.0: [usb_unbind_interface] debugging
> usb 3-1.1: [usb_disconnect] parent found
> usb 3-1.1: [usb_disconnect] removing port 3-1-port1 from hub 3-1:1.0: 0
> usb 3-1.1: [usb_disconnect] done with the device
> usb 3-1: [hub_disconnect_children] disconnecting child 1
> usb 3-1.2: [usb_disconnect] debugging
> usb 3-1.2: [usb_disconnect] USB disconnect, device number 4
> usb 3-1.2: [hub_disconnect_children] debugging hub_disconnect_children()
> usb 3-1.2: [usb_disconnect] unregistering device
> usbhid 3-1.2:1.0: [usb_unbind_interface] debugging
> xhci_hcd 0000:3c:00.0: remove, state 4
> usb usb4: [usb_disconnect] debugging
> usb usb4: [usb_disconnect] USB disconnect, device number 1
> usb usb4: [hub_disconnect_children] debugging hub_disconnect_children()
> usb usb4: [usb_disconnect] unregistering device
> hub 4-0:1.0: [usb_unbind_interface] debugging
> usb usb4: [hub_disconnect] debugging
> usb usb4-port2: [usb_hub_remove_port_device] debugging: port 1
> typec port1: [connector_unbind] unbinding connector from usb4-port2
> typec port1: [connector_unbind] unbinding connector from usb3-port2
> usb usb4-port1: [usb_hub_remove_port_device] debugging: port 0
> typec port0: [connector_unbind] unbinding connector from usb4-port1
> typec port0: [connector_unbind] unbinding connector from usb3-port1
> usb usb4: [usb_disconnect] done with the device
> xhci_hcd 0000:3c:00.0: USB bus 4 deregistered
> xhci_hcd 0000:3c:00.0: xHCI host controller not responding, assume dead
> xhci_hcd 0000:3c:00.0: remove, state 1
> usb usb3: [usb_disconnect] debugging
> usb usb3: [usb_disconnect] USB disconnect, device number 1
> typec port1-partner: [typec_unregister_partner] debugging
> typec port1-partner: [typec_unregister_partner] unregistering from port: port1
> usbhid 3-1.2:1.1: [usb_unbind_interface] debugging
> usbhid 3-1.2:1.2: [usb_unbind_interface] debugging
> usb 3-1.2: [usb_disconnect] parent found
> usb 3-1.2: [usb_disconnect] removing port 3-1-port2 from hub 3-1:1.0: 1
> usb 3-1.2: [usb_disconnect] done with the device
> usb 3-1: [hub_disconnect_children] disconnecting child 2
> usb 3-1.3: [usb_disconnect] debugging
> usb 3-1.3: [usb_disconnect] USB disconnect, device number 3
> usb 3-1.3: [hub_disconnect_children] debugging hub_disconnect_children()
> usb 3-1.3: [usb_disconnect] unregistering device
> usb 3-1.3: [usb_disconnect] parent found
> usb 3-1.3: [usb_disconnect] removing port 3-1-port3 from hub 3-1:1.0: 2
> usb 3-1.3: [usb_disconnect] done with the device
> usb 3-1: [usb_disconnect] unregistering device
> hub 3-1:1.0: [usb_unbind_interface] debugging
> usb 3-1: [hub_disconnect] debugging
> usb 3-1-port3: [usb_hub_remove_port_device] debugging: port 2
> usb 3-1-port2: [usb_hub_remove_port_device] debugging: port 1
> usb 3-1-port1: [usb_hub_remove_port_device] debugging: port 0
> usb 3-1: [usb_disconnect] parent found
> usb 3-1: [usb_disconnect] removing port usb3-port1 from hub 3-0:1.0: 0
> usb 3-1: [usb_disconnect] done with the device
> usb usb3: [hub_disconnect_children] debugging hub_disconnect_children()
> usb usb3: [usb_disconnect] unregistering device
> hub 3-0:1.0: [usb_unbind_interface] debugging
> usb usb3: [hub_disconnect] debugging
> usb usb3-port2: [usb_hub_remove_port_device] debugging: port 1
> usb usb3-port1: [usb_hub_remove_port_device] debugging: port 0
> usb usb3: [usb_disconnect] done with the device
> xhci_hcd 0000:3c:00.0: Host halt failed, -19
> xhci_hcd 0000:3c:00.0: Host not accessible, reset failed.
> xhci_hcd 0000:3c:00.0: USB bus 3 deregistered
> 
> As you can see typec port connectors are unbound during usb4 usb_disconnect(),
> so when usb 3-1 tries to typec_deattach() after it disconnected all its children
> the connector is not there anymore and type_partner_deattach() is not invoked.
Yes.  I would guess this happens because of the way the port connectors 
were registered in the first place (see my question above).

> Maybe usb 3-1 should be disconnected as a child of usb3, but even in that case
> we would still end up in the same situation because it's usb4 disconnection that
> is doing the unbinding.
> Since there's no dependency between usb3 and usb4 they can be
> disconnected in any order and it's just a matter of luck as it is right now.

That last sentence is totally wrong.  usb3 and usb4 are closely 
connected, since they represent logical components of the same xHCI 
controller, and they will always be unregistered in the same order.  
usb3 is the USB-2 root hub (the one connected to the physical wires 
carrying the USB-2 low/full/high-speed signals), and usb4 is the USB-3 
root hub (the one connected to the physical wires carrying the USB-3 
SuperSpeed and SuperSpeedPlus signals).

> Hope things make a little bit more sense now.

This still leaves the puzzle about why the typec things are handled this 
way.  In particular, if connector_unbind undoes the binding of the typec 
ports that happened when usb4 was registered, then what action is 
typec_unregister_partner supposed to undo, and when was it supposed to 
happen?  As a general rule, disconnection and unregistration actions 
take place in the reverse order of the corresponding connection and 
registration actions.

Questions like this are best directed at the maintainers of the 
USB-4/Thunderbolt and typec subsystems.

Alan Stern

