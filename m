Return-Path: <linux-kernel+bounces-739971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EE5B0CDA9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6E83A7BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27124418F;
	Mon, 21 Jul 2025 23:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FefuridL"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0D2AD0F;
	Mon, 21 Jul 2025 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139920; cv=none; b=g5tksUaXUdg/W64Q5KiP6wo+ix+VTte7NnzXvljY+SMzIVwxac6FsvhK3HFPxkutC+oB0z2Udl0tmzP+/bai0A/JwMAjcc9LKvFNm+IFy/uOzx5QdYApGznOs60b3oTz/1RN7ttWaupUaOUEPW7x0LFg+kJBuHK9GYYbbZ+CQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139920; c=relaxed/simple;
	bh=KYDTNiGj2OH075gtNN9fenM3z2/0Ja6BEMB70MD0P98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DF1WewFoWC/OhFYYKx+ilzbKGPhuY5E14u6EhOX+eFsq+3t/I88RoWe5skda+jqEVN71echR9y52ILRlJden6EHUmyjf5gKEeHfHxKnjR5vJ+vCLrp8ntYFkmvtUFVmki7yjU0boq+uo5INP4mbj5ye3HwFtP5s1wXs1rmEVe/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FefuridL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so922061366b.1;
        Mon, 21 Jul 2025 16:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753139917; x=1753744717; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s7xzDK7fnHYIYR4An/G5hxm5iLY0sPL9yqZfXqApjzc=;
        b=FefuridLb0r5e1DL0DEYL+rXRrl8GUPsnoBNcvUSv8jO+9ItkOY9gMbuaceAXU/k4J
         UDCYNBitPjoMKNV2gQTYloYgn0sZSsUSmi/ZopNhCqJgRZJU7I9IAjTTXXzxWwTjep54
         1tahcUIXeBWpxL/qmUgr/uRjCAC2udEJGH5zf5BTVQHHjaObRpXd0bAakooOa97zAJVV
         oJUn/g4nEfp6RqYv0htWOnSNz+OQFYWGVZHNbKYaK/ZK5R/rNkCtBj+Z0smzlSckiqDf
         +Xr3jjtoONBM67ijTfq61wpDjSGAyH1ikbGze3WB+sCXQ9Ma4lv6CEH08PiZFv3GNDoh
         P4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753139917; x=1753744717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7xzDK7fnHYIYR4An/G5hxm5iLY0sPL9yqZfXqApjzc=;
        b=a7cKSCLhbtq0assk8CMAmVQPCcqGkvGwyPnr2CfUoQykmGsPYfawr9JK0SS3IIZ0Iz
         4OwxHZLEBwR83BY+zdttU9AXh3iLjTMSq5cxStr6WK80vduhD8Q48r9AVaeDsgSnCOh1
         4E12h3jewyCTvMfPBBk3YZ9orDgLdEFX0SFfppeRU9XhIoiMtfc/C/kfpq3AxtDaHcpA
         43zeaawFr0tkDAwxgnmYby7xMxsWWwq+6ptD/+fyLbomqnh2QpzXAIIY9AByfCT+q7nC
         L0Zs9P6zyWtqcACqWFWLzjYJpVPKGiMHZzwhO3MpxHNt1nzL18pFTu5qVNYbryJcqyiF
         Tdyw==
X-Forwarded-Encrypted: i=1; AJvYcCV/rCSVVrtgVwGsH1Btx3WHSukwucQd/2srSLzStIeuYnH3DJE4JpRfrdM2SkG8nelZIuhJ1bmvQhsvqf0=@vger.kernel.org, AJvYcCXQx45/9RCjY3uAEOiEIz5saEWxoVgaekkKjEFFogJlenhSN5uODwwxxoo4XD1dM4wM56Fe/wKZ/WS0@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDtloOdklSvFb2DRrRgSv9co0yxQoPl/6iFi1o3yvikZQyEGF
	nMnMH4HuECGpiw29NPXBEvcw+1pyZCmqHfmx21OMRUZwRthpC5z9Kd3sHNkqirZFWwvfqGSGjeJ
	8+MIYbxiYhKXY+zTQTYBRKs90//EgDtDBG2Y6mXQ=
X-Gm-Gg: ASbGnctq1zcozVrTJc2TO2yol8wWeC9D14cVicWswQxDVlV9ypDDwU9WH9+OAMNMftO
	w6g9BbeXGLgyzVx1tP05iZp4fEqkAW6c8C5v7OfZXPbNwD/QaJXpoVSuTJYcrwFaRIQUZ17hjNd
	v6WbYUWU79BM5Z0NIHKeSxpHKXYPeeMXrll6jJTlg1Y8yzN/akjN1gLUOe3wOb60YOwg3cHNMlV
	eu4WZzj3tle+AyOdVY=
X-Google-Smtp-Source: AGHT+IHVPrKbLmRFLjwhDUVv5i9C6tZLfTSQvqJnGc6itCj7bXH+UIlKRtO+X0j2YF9KA6XSYMqkXLDBXabiBHhtMMI=
X-Received: by 2002:a17:906:6a0a:b0:ae0:34d4:28a5 with SMTP id
 a640c23a62f3a-ae9cdaf527dmr2061661866b.0.1753139916509; Mon, 21 Jul 2025
 16:18:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720210847.30998-1-mtormento80@gmail.com> <36a75fd9-71a4-4f53-9a35-560cd9cd5687@rowland.harvard.edu>
In-Reply-To: <36a75fd9-71a4-4f53-9a35-560cd9cd5687@rowland.harvard.edu>
From: Marco Tormento <mtormento80@gmail.com>
Date: Tue, 22 Jul 2025 01:18:25 +0200
X-Gm-Features: Ac12FXycP-0Em00OJzPfiUA5GWBx_junuJ8LSneBWT2Wc_ajKwkeCMnz3vCTpLA
Message-ID: <CACF_UwqpzNJWm0=zJh=1N_9p1Q6YjmU+DSofB_OOySkdWC_AxA@mail.gmail.com>
Subject: Re: [PATCH] USB: hub: Move typec deattach before children
 disconnections in usb_disconnect()
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Jul 2025 at 03:21, Alan Stern <stern@rowland.harvard.edu> wrote:
> I'm not a typec expert; in fact I know practically nothing about it.
> Nevertheless, this sounds strange.  The recursive usb_disconnect() calls
> should affect the connectors to the monitor's children and the monitor's
> own ports, not the connector or port on the monitor's parent hub.

What you wrote makes total sense, let me add some detail though.
When I plug the monitor to the thunderbolt port, 3 usb hubs pop up, but only 2
are backed by XHCI Host Controllers: usb3 and usb4.
usb 3-1 instead is using usb3 and it has 3 devices connected to it: mouse,
keyboard and a mysterious billboard device:

xhci_hcd 0000:3c:00.0: xHCI Host Controller
xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus number 3
xhci_hcd 0000:3c:00.0: hcc params 0x200077c1 hci version 0x110 quirks
0x0000000200009810
xhci_hcd 0000:3c:00.0: xHCI Host Controller
xhci_hcd 0000:3c:00.0: new USB bus registered, assigned bus number 4
xhci_hcd 0000:3c:00.0: Host supports USB 3.1 Enhanced SuperSpeed
usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.15
usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: Product: xHCI Host Controller
usb usb3: Manufacturer: Linux 6.15.7-arch1-1-mentor xhci-hcd
usb usb3: SerialNumber: 0000:3c:00.0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.15
usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: Product: xHCI Host Controller
usb usb4: Manufacturer: Linux 6.15.7-arch1-1-mentor xhci-hcd
usb usb4: SerialNumber: 0000:3c:00.0
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
typec port0: bound usb3-port1 (ops connector_ops [usbcore])
typec port0: bound usb4-port1 (ops connector_ops [usbcore])
typec port1: bound usb3-port2 (ops connector_ops [usbcore])
typec port1: bound usb4-port2 (ops connector_ops [usbcore])
usb 3-1: new high-speed USB device number 2 using xhci_hcd
usb 3-1: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.36
usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1: Product: 4-Port USB 2.0 Hub
usb 3-1: Manufacturer: Generic
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 3 ports detected
usb 3-1.3: new full-speed USB device number 3 using xhci_hcd
usb 3-1.3: not running at top speed; connect to a high speed hub
usb 3-1.3: New USB device found, idVendor=0bda, idProduct=5400, bcdDevice= 1.07
usb 3-1.3: New USB device strings: Mfr=17, Product=18, SerialNumber=19
usb 3-1.3: Product: BillBoard Device
usb 3-1.3: Manufacturer: Realtek
usb 3-1.3: SerialNumber: 123456789ABCDEFGH
usb 3-1.2: new full-speed USB device number 4 using xhci_hcd
usb 3-1.2: New USB device found, idVendor=0951, idProduct=16e6, bcdDevice=21.08
usb 3-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 3-1.2: Product: HyperX Alloy Origins Core
usb 3-1.2: Manufacturer: Kingston
usb 3-1.1: new full-speed USB device number 5 using xhci_hcd
usb 3-1.1: New USB device found, idVendor=1a7c, idProduct=0197, bcdDevice= 1.06
usb 3-1.1: New USB device strings: Mfr=1, Product=3, SerialNumber=0
usb 3-1.1: Product: Evoluent VerticalMouse D
usb 3-1.1: Manufacturer: Kingsis Peripherals

When I unplug the monitor though, usb 3-1 is not processed as part of
hub_disconnect_children() of usb3 hub, as I would expect.
It is processed on its own (added some debugging log to some functions):

usb 3-1: [usb_disconnect] debugging
usb 3-1: [usb_disconnect] USB disconnect, device number 2
usb 3-1: [hub_disconnect_children] debugging hub_disconnect_children()
usb 3-1: [hub_disconnect_children] disconnecting child 0
usb 3-1.1: [usb_disconnect] debugging
usb 3-1.1: [usb_disconnect] USB disconnect, device number 5
usb 3-1.1: [hub_disconnect_children] debugging hub_disconnect_children()
usb 3-1.1: [usb_disconnect] unregistering device
usbhid 3-1.1:1.0: [usb_unbind_interface] debugging
usb 3-1.1: [usb_disconnect] parent found
usb 3-1.1: [usb_disconnect] removing port 3-1-port1 from hub 3-1:1.0: 0
usb 3-1.1: [usb_disconnect] done with the device
usb 3-1: [hub_disconnect_children] disconnecting child 1
usb 3-1.2: [usb_disconnect] debugging
usb 3-1.2: [usb_disconnect] USB disconnect, device number 4
usb 3-1.2: [hub_disconnect_children] debugging hub_disconnect_children()
usb 3-1.2: [usb_disconnect] unregistering device
usbhid 3-1.2:1.0: [usb_unbind_interface] debugging
xhci_hcd 0000:3c:00.0: remove, state 4
usb usb4: [usb_disconnect] debugging
usb usb4: [usb_disconnect] USB disconnect, device number 1
usb usb4: [hub_disconnect_children] debugging hub_disconnect_children()
usb usb4: [usb_disconnect] unregistering device
hub 4-0:1.0: [usb_unbind_interface] debugging
usb usb4: [hub_disconnect] debugging
usb usb4-port2: [usb_hub_remove_port_device] debugging: port 1
typec port1: [connector_unbind] unbinding connector from usb4-port2
typec port1: [connector_unbind] unbinding connector from usb3-port2
usb usb4-port1: [usb_hub_remove_port_device] debugging: port 0
typec port0: [connector_unbind] unbinding connector from usb4-port1
typec port0: [connector_unbind] unbinding connector from usb3-port1
usb usb4: [usb_disconnect] done with the device
xhci_hcd 0000:3c:00.0: USB bus 4 deregistered
xhci_hcd 0000:3c:00.0: xHCI host controller not responding, assume dead
xhci_hcd 0000:3c:00.0: remove, state 1
usb usb3: [usb_disconnect] debugging
usb usb3: [usb_disconnect] USB disconnect, device number 1
typec port1-partner: [typec_unregister_partner] debugging
typec port1-partner: [typec_unregister_partner] unregistering from port: port1
usbhid 3-1.2:1.1: [usb_unbind_interface] debugging
usbhid 3-1.2:1.2: [usb_unbind_interface] debugging
usb 3-1.2: [usb_disconnect] parent found
usb 3-1.2: [usb_disconnect] removing port 3-1-port2 from hub 3-1:1.0: 1
usb 3-1.2: [usb_disconnect] done with the device
usb 3-1: [hub_disconnect_children] disconnecting child 2
usb 3-1.3: [usb_disconnect] debugging
usb 3-1.3: [usb_disconnect] USB disconnect, device number 3
usb 3-1.3: [hub_disconnect_children] debugging hub_disconnect_children()
usb 3-1.3: [usb_disconnect] unregistering device
usb 3-1.3: [usb_disconnect] parent found
usb 3-1.3: [usb_disconnect] removing port 3-1-port3 from hub 3-1:1.0: 2
usb 3-1.3: [usb_disconnect] done with the device
usb 3-1: [usb_disconnect] unregistering device
hub 3-1:1.0: [usb_unbind_interface] debugging
usb 3-1: [hub_disconnect] debugging
usb 3-1-port3: [usb_hub_remove_port_device] debugging: port 2
usb 3-1-port2: [usb_hub_remove_port_device] debugging: port 1
usb 3-1-port1: [usb_hub_remove_port_device] debugging: port 0
usb 3-1: [usb_disconnect] parent found
usb 3-1: [usb_disconnect] removing port usb3-port1 from hub 3-0:1.0: 0
usb 3-1: [usb_disconnect] done with the device
usb usb3: [hub_disconnect_children] debugging hub_disconnect_children()
usb usb3: [usb_disconnect] unregistering device
hub 3-0:1.0: [usb_unbind_interface] debugging
usb usb3: [hub_disconnect] debugging
usb usb3-port2: [usb_hub_remove_port_device] debugging: port 1
usb usb3-port1: [usb_hub_remove_port_device] debugging: port 0
usb usb3: [usb_disconnect] done with the device
xhci_hcd 0000:3c:00.0: Host halt failed, -19
xhci_hcd 0000:3c:00.0: Host not accessible, reset failed.
xhci_hcd 0000:3c:00.0: USB bus 3 deregistered

As you can see typec port connectors are unbound during usb4 usb_disconnect(),
so when usb 3-1 tries to typec_deattach() after it disconnected all its children
the connector is not there anymore and type_partner_deattach() is not invoked.

Maybe usb 3-1 should be disconnected as a child of usb3, but even in that case
we would still end up in the same situation because it's usb4 disconnection that
is doing the unbinding.
Since there's no dependency between usb3 and usb4 they can be
disconnected in any order and it's just a matter of luck as it is right now.

Hope things make a little bit more sense now.

Marco Tormento

