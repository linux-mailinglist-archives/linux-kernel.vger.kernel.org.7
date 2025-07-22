Return-Path: <linux-kernel+bounces-741571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C50B5B0E601
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062561CC1196
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB812877E2;
	Tue, 22 Jul 2025 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3GNjtSK"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E6280338;
	Tue, 22 Jul 2025 21:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221595; cv=none; b=BIRRmbgS4nU/iO2xdS2Ayd+K4ds0sMZfjfru9uCi4GWMFCQyCDBDJS/LspL7ZLON5hoCSSeu96/mBqPHp91YZKMbVm8qmmnPXCpO6nln+TiAflTjDbtGx4Oo7M0pgokMXitvoTYq/qT/R7YbcxpzCrP2PSNXh8/BlntZo2pxb/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221595; c=relaxed/simple;
	bh=KvXYd1CwJ7QTIbFtnYdMiYYKixJOHrpPwHoY7QT3uPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6FGpkdqP3IL+5u75rqQSiriIFsoVX7gyF7U9kZvFwcit3uIK+Ede+3CtMQgmUlQCY5h+THkYvv0O8zFiZNqEnZ+6VLH7QlFAy2okTQqgMN8gaeZoeRWu2exRlWU4TDo3qMHyW99TgnAanucj4ocHLzekW8UKip0Cc9Ks8Ip38A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3GNjtSK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so1007172366b.1;
        Tue, 22 Jul 2025 14:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753221592; x=1753826392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=taA4UGn8qSCl0OPntQ8WtwZ5TDYoqD6jr4p1tjoaXu4=;
        b=H3GNjtSKIsPuOpADYXUGAhjr8l0hPyewVHcgYYMh0V4J1/XTwYJiafj6lrhFPLFa4Q
         7UBBntX1gmJeU68cQU+aUAL34bN04bAc1skzYzy+df1j2zaIKcdfpzr4F9R5Dg3F4zg+
         HcYtAZV5F8TxEN2feIQ19VGQ+UYXvgGd6RdoC0Rjy5l09JLGsiqpLaktIj8kXvGIJFV+
         UDwWXA/fzXiPF+/T28zhivjNabTSyrmwpOukCMqOcWUGqWmCwiJ78OkjGzmEzA20YKY7
         HeL/IcJsL39uMpTnaled+zWBq5hD4z/vuRbXfHop1lz2Q5yM3QOl00YKRZZznNac95hA
         ILBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221592; x=1753826392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taA4UGn8qSCl0OPntQ8WtwZ5TDYoqD6jr4p1tjoaXu4=;
        b=C/oqKbZRPInLQ2fx3SR5XtZcO57WhYanWOCmjrO0wGeR6mh3CCSmTTaoSPGfHbP351
         kjmCjRIumIQ2QTF+yoMv2kPX/vFRPHCz4vNu3y8DE1szB3VWw6scqrrAJdA3pzPqnWFI
         7f72P44QV+pcdNHu2LCzbpi6sO3zZFN90+u6BhAiB1uML9sjjWEQ4wHSE16aBuJ0P5jp
         W0G1zUh76Ni4L7+H8gaf2t71d5x30diVN/mYowo/V4XqUBc2A5LSExlLpTiiiM5wD8R3
         7DsTPbjZa4hRB06RfIL2xDpSrkdLBIvy2/+oSkxhV65u9529QmX0hyDWdf7TGXp6jQ/C
         KU7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsR0WTnW3zaxoy0+gRkg8Qt0jTfEWD+FRmj0OsM4hl/IUykaS20y/ScF/lnGNuEyDQyPqaCLvcVkBp@vger.kernel.org, AJvYcCXBI44PfdMgv/Kwlwco93lx4AZguneSCFkAUQ3EL4jNc+PYQyeVhK3oDRA1+xSSGQZqWZNFadL83k4Xl2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeOwoLztv+i58BRgyM2p9cbIBoZLm6cDO1VW983uG0+H/WSTVY
	mNADprFfMHCKGj1lbgcPNS1z9rpAxnKQymWpplLlJPIf7kf32s24qiuZLiS5gDUAN0dR15TJJxr
	wp6GqL/FKmJPSMZVr+k0W/ybezga8ZnTQTrYp9QQ=
X-Gm-Gg: ASbGncu6NVEzX2QdZcDe/qwQn3RmomHTFOSiuXDXLbdMfQeEpfgIAQritUpwaDCtCSQ
	rJWRO8Ugmm6iPKr6nAIyMrj+IaidaQztzyApPjDlPn9wmep0IB0T7+pKctQSsD2iKo2AtkXSEFo
	BUVNhZsshsJ/LVG9Hq9zCbLxVy2EkZOleIrliU9ncAWDAKnJnmXSLg2IHgoQrerYUEg03swxshL
	2lX9QgJoxG9IwwGPA==
X-Google-Smtp-Source: AGHT+IHi+1hksiPT9zFYrGDBMbCTT2dzY7L4GFC1VCmwtvqiIwEbAiL+J5ypVfUJ6i9xgIklCoCZBVzn3xiPTJhI1uM=
X-Received: by 2002:a17:907:788:b0:af2:c9c7:7ee8 with SMTP id
 a640c23a62f3a-af2f928c5d2mr45925966b.55.1753221591450; Tue, 22 Jul 2025
 14:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720210847.30998-1-mtormento80@gmail.com> <36a75fd9-71a4-4f53-9a35-560cd9cd5687@rowland.harvard.edu>
 <CACF_UwqpzNJWm0=zJh=1N_9p1Q6YjmU+DSofB_OOySkdWC_AxA@mail.gmail.com> <b7468de2-d186-4706-8db3-594285ba264b@rowland.harvard.edu>
In-Reply-To: <b7468de2-d186-4706-8db3-594285ba264b@rowland.harvard.edu>
From: Marco Tormento <mtormento80@gmail.com>
Date: Tue, 22 Jul 2025 23:59:40 +0200
X-Gm-Features: Ac12FXwOuXynWvjB4Nb6QEKLH9wqFavKtKG4sOmxJh5KikfBM6ww-qaLncZwxCU
Message-ID: <CACF_Uwo2jZ2duXm_B6GdcLd3yPr0+CJ0sCBTDRqwkuX_KF81Ug@mail.gmail.com>
Subject: Re: [PATCH] USB: hub: Move typec deattach before children
 disconnections in usb_disconnect()
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Jul 2025 at 05:05, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Tue, Jul 22, 2025 at 01:18:25AM +0200, Marco Tormento wrote:
> > On Mon, 21 Jul 2025 at 03:21, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > I'm not a typec expert; in fact I know practically nothing about it.
> > > Nevertheless, this sounds strange.  The recursive usb_disconnect() calls
> > > should affect the connectors to the monitor's children and the monitor's
> > > own ports, not the connector or port on the monitor's parent hub.
> >
> > What you wrote makes total sense, let me add some detail though.
> > When I plug the monitor to the thunderbolt port, 3 usb hubs pop up, but only 2
> > are backed by XHCI Host Controllers: usb3 and usb4.
>
> I don't know what you mean when you say "backed by".  usb3 and usb4 are
> the two root hubs of the xHCI host controller.  usb3-1 is an internal
> hub (presumably built into the monitor) attached to the usb3 root hub.

Mine was a failed attempt at expressing what you wrote :-).
My understanding is that usb3 and usb4 root hubs are somehow part of the
thunderbolt controller, because they are not brought up if I plug the monitor
into the other typec port.

> > typec port0: bound usb3-port1 (ops connector_ops [usbcore])
> > typec port0: bound usb4-port1 (ops connector_ops [usbcore])
> > typec port1: bound usb3-port2 (ops connector_ops [usbcore])
> > typec port1: bound usb4-port2 (ops connector_ops [usbcore])
>
> Why are the usb3 port connectors getting bound at this point rather than
> when usb3 was registered?

Not sure, but maybe this is a consequence of the fact usb4 is on a shared hcd of
usb3 pci device? See the stack traces below.

> > When I unplug the monitor though, usb 3-1 is not processed as part of
> > hub_disconnect_children() of usb3 hub, as I would expect.
>
> Are you sure about this?  How did you reach that conclusion?

I checked the stack traces of usb_disconnect().

usb 3-1 is triggered by hub_event():

usb 3-1: [usb_disconnect] debugging()
...cut...
Workqueue: usb_hub_wq hub_event [usbcore]
Call Trace:
 <TASK>
 dump_stack_lvl+0x5d/0x80
 usb_disconnect+0x38/0x2f4 [usbcore d46dddc5902949f0a284aff7ecf8d6e861774323]
 hub_event.cold+0x73e/0xc50 [usbcore d46dddc5902949f0a284aff7ecf8d6e861774323]
...cut

usb4 is not:

usb usb4: [usb_disconnect] debugging()
...cut...
Workqueue: kacpi_hotplug acpi_hotplug_work_fn
Call Trace:
 <TASK>
 dump_stack_lvl+0x5d/0x80
 usb_disconnect+0x38/0x2f4 [usbcore d46dddc5902949f0a284aff7ecf8d6e861774323]
 usb_remove_hcd.cold+0xc6/0x1bb [usbcore
d46dddc5902949f0a284aff7ecf8d6e861774323]
 xhci_pci_remove+0x6a/0xd0 [xhci_pci 89d1427fd34e7648221e69cd90b20ad6e1fd2fd6]
 pci_device_remove+0x47/0xc0
...cut

usb3 is a little bit different compared to usb4, it has a call to
usb_hcd_pci_remove():

usb usb3: [usb_disconnect] debugging()
...cut...
Workqueue: kacpi_hotplug acpi_hotplug_work_fn
Call Trace:
 <TASK>
 dump_stack_lvl+0x5d/0x80
 usb_disconnect+0x38/0x2f4 [usbcore d46dddc5902949f0a284aff7ecf8d6e861774323]
 usb_remove_hcd.cold+0xc6/0x1bb [usbcore
d46dddc5902949f0a284aff7ecf8d6e861774323]
 usb_hcd_pci_remove+0x7a/0x110 [usbcore
d46dddc5902949f0a284aff7ecf8d6e861774323]
 xhci_pci_remove+0x89/0xd0 [xhci_pci 89d1427fd34e7648221e69cd90b20ad6e1fd2fd6]
 pci_device_remove+0x47/0xc0
...cut

There's a branch in xhci_pci_remove() on xhci->shared_hcd being valid.

So it seems:
- xhci_pci_remove() is called
- xhci->shared_hcd is valid so usb_remove_hcd() is called which triggers usb4
  usb_disconnect()
- usb_hcd_pci_remove() is then called which does a lot of stuff + calls
  usb_remove_hcd() which triggers usb3 usb_disconnect()

No idea what this shared hcd implies, by the way.

I also got this stack trace of the port unbinding, which happens
in typec_aggregate_unbind() in the usb4 usb_disconnect() trace:

usb usb4: [hub_disconnect] debugging
usb usb4-port2: [usb_hub_remove_port_device] debugging: port 1
...cut...
Workqueue: kacpi_hotplug acpi_hotplug_work_fn
Call Trace:
 <TASK>
 dump_stack_lvl+0x5d/0x80
 typec_aggregate_unbind+0x12/0x30 [typec
6de6f75aa8c9f6a0a8c73a05ed9c668a2b7634cf]
 component_del+0xb8/0x150
 usb_hub_remove_port_device+0xf8/0x115 [usbcore
d46dddc5902949f0a284aff7ecf8d6e861774323]
 hub_disconnect+0x95/0x160 [usbcore d46dddc5902949f0a284aff7ecf8d6e861774323]
 usb_unbind_interface+0xb6/0x1ef [usbcore
d46dddc5902949f0a284aff7ecf8d6e861774323]
 ? kernfs_remove_by_name_ns+0xbe/0xe0
 device_release_driver_internal+0x19e/0x200
 bus_remove_device+0xc2/0x130
 device_del+0x160/0x3d0
 ? kobject_put+0xa2/0x200
 usb_disable_device+0xf4/0x220 [usbcore
d46dddc5902949f0a284aff7ecf8d6e861774323]
 usb_disconnect+0x117/0x2f4 [usbcore d46dddc5902949f0a284aff7ecf8d6e861774323]
 usb_remove_hcd.cold+0xc6/0x1bb [usbcore
d46dddc5902949f0a284aff7ecf8d6e861774323]
 xhci_pci_remove+0x6a/0xd0 [xhci_pci 89d1427fd34e7648221e69cd90b20ad6e1fd2fd6]
 pci_device_remove+0x47/0xc0
...cut...
 </TASK>
typec port1: [connector_unbind] unbinding connector from usb4-port2
typec port1: [connector_unbind] unbinding connector from usb3-port2

> > Maybe usb 3-1 should be disconnected as a child of usb3, but even in that case
> > we would still end up in the same situation because it's usb4 disconnection that
> > is doing the unbinding.
> > Since there's no dependency between usb3 and usb4 they can be
> > disconnected in any order and it's just a matter of luck as it is right now.
>
> That last sentence is totally wrong.  usb3 and usb4 are closely
> connected, since they represent logical components of the same xHCI
> controller, and they will always be unregistered in the same order.
> usb3 is the USB-2 root hub (the one connected to the physical wires
> carrying the USB-2 low/full/high-speed signals), and usb4 is the USB-3
> root hub (the one connected to the physical wires carrying the USB-3
> SuperSpeed and SuperSpeedPlus signals).

That makes a lot of sense.
Unfortunately I realized this could be the order half an hour after having
pressed "send"...
Thank you for the explanation!

> This still leaves the puzzle about why the typec things are handled this
> way.  In particular, if connector_unbind undoes the binding of the typec
> ports that happened when usb4 was registered, then what action is
> typec_unregister_partner supposed to undo, and when was it supposed to
> happen?  As a general rule, disconnection and unregistration actions
> take place in the reverse order of the corresponding connection and
> registration actions.
>
> Questions like this are best directed at the maintainers of the
> USB-4/Thunderbolt and typec subsystems.

Should I just cc them here or should I open a new thread with them?

Marco Tormento

