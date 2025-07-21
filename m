Return-Path: <linux-kernel+bounces-739493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1A2B0C6E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E50318846A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 14:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A161D2D3730;
	Mon, 21 Jul 2025 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="l1893PZG"
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8F284B3C;
	Mon, 21 Jul 2025 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753109529; cv=none; b=phm+oII1NqMJCdsNA25/anVPMjVTFrk29+asWxg4/WNeyAj7jtIV6lpHLzMBb37InRBeTIWSqRjbpmDCTJdHFfzxHY//MStH7qolSuLBEBt3EnaTJe4Nl/ZnWnk0X/rXhXy4QuweOjNq8orxk0SPZVtU1YrJGFyDngwyPAY3iH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753109529; c=relaxed/simple;
	bh=w3IfvAye25rbnizOvVpaRNcvpBUXCAWhpyRn8xEMu5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWD0DiWyOf/d7FftFWVZ1EDYmkAFwKnmVvt+CD18z3ASMRBzOfp+7D3iUIJWpLBewwyx1sC4I2+1uv86VVbdASbQr2necCuL9SnE+hBWLYKG7t3wsvok2+0boXs5gDFZ9mQKhQMZ5uLTYU//mCsSUzNBukMSeqzf4dXbL2/YLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=l1893PZG; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kNz86apTAQtqwj0tspgaX0lc7DdZ1VGN861JTC45x7E=; b=l1893PZGgERXk8ALemj+HuJMt5
	C8C9nR5gvqPyu4S2AjsZ40809v9qqM/nJqdsIJr0n5fCMMndmsadpXLFky2sh1gPu0rgIq1HIPI6p
	luO3t/TNW7/DPx4pknCTXN6sjcEgGPg0ByQj7+TztTvIn+Q+M14kPpJGUV0tZqMoGzOCoyCpXa8FH
	MtfQntOTtsb/au8UD6xuce77MtHOOo/qnivVaUtkIgvE40yiDY3qO0VmFFSORBZMRoy/KemGOv5re
	IyEV9sqCMnaXcSvshv9guBQAfW4X7SQVBJy9dxfzl3pCljQbGS4PHDjfCPrkHspWIJ7u3opdnoHAO
	+RWs2oig==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:18406 helo=archlinux)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1udrrx-0000000486a-1eyg;
	Mon, 21 Jul 2025 16:51:59 +0200
Date: Mon, 21 Jul 2025 16:51:52 +0200
From: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>, 
	Alan Stern <stern@rowland.harvard.edu>, Kannappan R <r.kannappan@intel.com>, 
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Stefan Eichenberger <stefan.eichenberger@toradex.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Pawel Laszczak <pawell@cadence.com>, Ma Ke <make_ruc2021@163.com>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Luc Bonnafoux <luc.bonnafoux@oss.cyber.gouv.fr>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Alistair Francis <alistair@alistair23.me>, 
	Oliver Neukum <oneukum@suse.com>
Subject: Re: [RFC PATCH v2 0/4] Support for usb authentication
Message-ID: <d2ghp3qafwrxiwkrizzxqayzkhu36ke4dolxaloksmz4z5fzpn@paxcer43kru3>
References: <20250711-usb_authentication-v2-0-2878690e6b6d@ssi.gouv.fr>
 <2025071344-possible-fabric-bbbf@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025071344-possible-fabric-bbbf@gregkh>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On Sun, Jul 13, 2025 at 05:25:03PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jul 11, 2025 at 10:41:21AM +0200, nicolas.bouchinet@oss.cyber.gouv.fr wrote:
> > We have been working on the implementation of the USB authentication
> > protocol in the kernel.
> > 
> > You can find our work here https://github.com/ANSSI-FR/usb_authentication.
> > 
> > It is still work in progress but we would like to start discussions
> > about the implementation design and its possible integration to the
> > Linux kernel.
> > 
> > Best regards,
> > 
> > Nicolas and Luc
> > 
> > ---
> > USB peripheral authentication
> > =============================
> > 
> > USB peripherals are an important attack vector in personal computers and
> > pose a risk to the cyber security of companies and organizations.
> > 
> > The USB foundation has published a standard to allow the authentication
> > of USB peripherals ([1] and [2]). It defines a mechanism for the host to
> > request credentials and issue an authentication challenge to USB-2 or
> > USB-3 peripherals, either upon connection or later during the use of the
> > peripheral.
> > 
> > We currently envision the following use cases for USB authentication:
> > 
> > - company networks where computers and peripherals can be privately
> >   controlled and administered;
> > - USB cleaning or decontamination stations;
> > - individuals who want to prevent unauthorized device plug-in into their
> >   machine.
> > 
> > The implementation of this feature will obviously necessitate efforts
> > from both the kernel community and peripherals vendors. We believe that
> > providing an implementation of the host side of the protocol in the
> > Linux kernel will encourage constructors to include this feature in
> > their devices. On the other hand, we are working on implementing
> > reference code for embedded devices, notably for Zephyr OS.
> > 
> > Design
> > ======
> > 
> > The USB authentication protocol is based on a simple signature
> > challenge. Devices hold between 1 and 8 pairs of private signing key and
> > x509 certificate. Hosts must possess a store of root Certificate
> > Authority certificates provided by device vendors.
> 
> Who is going to distribute these host keys?  Who is going to be
> responsible for revocations and the like?
> 
The the first 4 slots must be used by certificate authenticated with
USB-IF root CA. The last 4 slots can be used freely by usb device
vendors or system administrators. It will be the role of the userspace
policy engine to allow the configuration of the trusted root CAs and the
revocation lists.
We are currently on the mind that its out of scope of this kernel
patchset.

> > The protocol exchange is driven by the host and can be decomposed into
> > three, mostly independent, phases:
> > 
> > - The Host can request a digest of each certificate owned by the
> >   peripheral.
> > - If the Host does not recognize the peripheral from one of its digests,
> >   it can read one or more certificates from the device until a valid one
> >   is found.
> > - The Host can issue an authentication challenge to the peripheral.
> 
> Is this the same type of protocol that PCI has implemented for its use
> of "trusted devices"?  If so, why not emulate what the kernel patches
> for PCI do here as well to keep one common kernel/userspace api?  If
> not, what are the major differences?
> 
Currently, as far as we can see in the kernel code, trust for PCI
devices is solely based on whether they are placed on a external facing
PCI port marked as untrusted or not. It is similar to the concept of
internal devices for USB. But in both cases it does not involve any
cryptographic authentication of the device.

We however have been recently aware of the effort to port the SPDM
protocol for PCI in the kernel [1]. We think it could be a great
opportunitie to study if its possible to join our efforts. @Lukas,
@Alistair.

[1]: https://lore.kernel.org/all/cover.1719771133.git.lukas@wunner.de/

> > On the host side, this requires the following functions:
> > 
> > - handling the protocol exchange with the peripheral;
> > - X509 certificates validation and administration (root CA loading,
> >   certificate revocation…);
> 
> Is the validation going to be done by the kernel?  Userspace?  And how?
> Is a chain-of-trust defined somewhere?
> 
As said below, we think its best to left the complexity of the
certificates validation to the userspace.

> > - cryptographic functions for the challenge (random number generation
> >   and ECDSA with the NIST P256 -secp256r1- curve);
> > - security policy management;
> > - authorization decision enforcement.
> > 
> > We chose to implement the authentication protocol exchange directly in
> > the kernel USB stack during the device enumeration. This is done by
> > first requesting the device BOS to detect its capacity at handling
> > authentication, then if supported starting the authentication sequence
> > with a digest request.
> > 
> > The implementation of the other functions is open to several design
> > alternatives, mainly based on their distribution between kernel and user
> > space. In this first implementation, we chose to implement most (all) of
> > the cryptographic functions, certificate management and security policy
> > management in user space in order to limit impact on the kernel side.
> > This allows for more personalization later on. The communication between
> > the kernel USB stack authentication function and user space is done via
> > a generic netlink socket.
> 
> Again, is this what PCI has decided to do?  Surely they didn't implement
> a different way of authenticating devices, did they?  (I can dream...)
> 
We are not completely sure yet if the SPDM protocol is compatible with
the USB authentication.

> > Once a device has been authenticated, a per-device authenticated field
> > is update with the result of the authentication. The authenticated field
> > can be used to track the result of the authentication process in
> > userspace thanks to a sysfs exposed file.
> 
> This is _VERY_ close to what the old wireless USB protocol required,
> right?  And I think you've tied into much the same places we did for
> that protocol, but you might want to look into the past history for when
> we removed that to be sure.
> 
We will do some git archeology. Thanks for the hint.

> > The device enforcement point is done in the usb_probe_interface()
> > function. This allows for more complex security policy in userspace: the
> > user could manually authorize a device that failed the authentication or
> > manually deauthorize a device that was previously authenticated.
> > 
> > +----------+------------+-------------+
> > |          | authorized | !authorized |
> > +----------+------------+-------------+
> > | authent  |     OK     |     NOK     |
> > +----------+------------+-------------+
> > | !authent |     OK     |     NOK     |
> > +----------+------------+-------------+
> 
> What is "NOK"?  And what are the two axis?  The sysfs file values?  Or
> an internal variable?
> 
NOK means Not OK. Authorized and authenticated represent the two
bitfields in the usb_device struct. They are reflected in the sysfs in
their respective files.

> > If set to true, the authentication decision is enforced, the following
> > decision is made:
> 
> If what is "set to true"?
> 
Sorry for that, we meant if the new `USB_AUTHENTICATION_ENFORCE` kernel
parameter is set to true.

> > +----------+------------+-------------+
> > |          | authorized | !authorized |
> > +----------+------------+-------------+
> > | authent  |     OK     |     NOK     |
> > +----------+------------+-------------+
> > | !authent |    NOK     |     NOK     |
> > +----------+------------+-------------+
> > 
> > Note that combined with the CONFIG_USB_DEFAULT_AUTHORIZATION_MODE=2:
> 
> What does "2" mean?
> 
We are refering to the usb authorized_default mode that authorizes by
default internal devices only. The idea here is that, paired with
`USB_AUTHENTICATION_ENFORCE` we can more finely control the enforcement
point.

> >  - internal devices should be authorized and !authenticated => OK
> >  - external qemu dev-auth is !authorized and authenticated  => NOK at
> >    first but then authorization can be granted via sysfs.
> >  - external qemu non auth dev is !authorized and !authenticated => NOK
> >    and authorization can be granted via sysfs
> 
> Wait, what does qemu have to do with anything here?
> 
> And this is getting to be a complex set of interactions, testing the
> combinations is going to be rough without regression tests...
> 
Sorry for that, we were refering to our current test device implemented
in qemu. But was supposed to be any external usb devices.

> > The default enforcement decision can be configured thanks to the new
> > USB_AUTHENTICATION_ENFORCE configuration option and can be overridden
> > using the usbcore.enforce_authentication command line or module
> > parameter.
> > 
> > Limitations
> > ===========
> > 
> > The USB authentication protocol come with some inherent limitations, [3]
> 
> That's a 2018 reference!  Are you saying that the newly designed
> protocol was already discussed in 2018 and found lacking?
> 
As far as we are aware, the last version of the specification [1] is the
last is the last version that includes errata from 2019. [3] is a
research paper that explored the limitation of the protocol. We are not
aware of any evolution since. We saw that SPDM reuses some of the USB
specification fields but we are not entirely sure yet if can be used in
place of the USB specification and if it fixes the limitations.

> > does a good job at describing most of them. During the implementation,
> > we also found that the value encoding of the Validity field in the x509
> > certificate differs from the RFC5280 [4].
> 
> Can this be fixed?
> 
> > This has prevented us from
> > using the x509 parser included in the Linux kernel or OpenSSL, we chose
> > to use the mbedtls library instead [5].
> 
> Ugh, why?  Why not fix up the kernel parser to work with this broken
> implementation instead?  How is any other operating system handling this
> if the implementation is broken?  How was it ever tested?
> 
We think its up to the USB-IF to fix their specification and not up to
the kernel to adapt its behavior.

> > This obviously does not prevent
> > others to replace it with their preferred implementation. It will also
> > open discussions on the protocol enhancement.
> 
> Have you done this with the usb-if?
> 
 We have not yet contacted the USB-IF to report those issues.

> Note, Linux was explicitly kicked out of particapating in usb-if
> discussions in the past by some of the core members a decade or so ago
> because they did not want us to implement specifications before other
> operating systems had the chance to.  So, given that this is a new spec,
> has Windows added support for this yet to prove it actually can work?
> 
> What's the odds that usb-if is willing to talk to us again?  :)
> 
> > The architectural choice to place most of the cryptographic and security
> > management functions in user space comes with its own limitations.
> > 
> > First it introduces a dependency on the user space program availability.
> > It will probably be necessary to introduce a fail-safe mechanism if the
> > authentication can not be completed. Also, during early boot stages the
> > user space service will be needed in one form or another in the
> > initramfs.
> 
> Ugh, that's going to get messy fast, so putting this in the kernel might
> be the simplest way if at all possible.  At least for "boot devices", or
> just punt and don't care about USB devices at boot time?
> 
As we see it we could indeed do everything in the kernel but it will
mean that either every vendor certificates have to be loaded at compile
time as well as the security policy. Or we would need a way to load the
policy and certificates later through sysfs for example.

For the former it would be pretty unflexible. For the later as far as we
understand it there needs to be an userspace available and thus it is
possible to have an userspace policy engine.

> > The second limitation is that the device initialization process is
> > paused multiple times. Each time, the hub lock is released in order not
> > to block the rest of the stack; and then reacquired when a response has
> > been received from user space. The resuming of the operation on the
> > device must be done with great care.
> 
> USB probe sequences are slow based on the slow devices, so I doubt this
> is going to even be noticable.  Have you seen any real slow-down in your
> testing?
> 
We have not seen any slowdown, our concern is that the usb_device struct
pointer is no longer valid if for example the device has been ejected
during the authentication sequence. We still need to harden our current
implementation.

> > Last, we do not yet interface properly with the rest of the usb stack
> > and thus do not enforce a strict control of the two authenticated and
> > authorized fields. Other sections of the kernel or userspace are able to
> > overwrite those fields using the sysfs exposed files for example.
> 
> Why would the kernel be writing these values?  And if userspace isn't
> supposed to be writing to these anymore, just change the permissions on
> the sysfs files, OR just fail the write with the logic in the kernel
> itself.
> 
Since the second patchset, we have been working on the enforcement of
the two authenticated and authorized bitfields. The authenticated sysfs
file is exposed as read-only.

> > Status
> > ======
> > 
> > The current kernel implementation of the USB authentication protocol is
> > experimental and has the following limitations:
> > 
> > - It does not yet handle all possible protocol errors.
> > - It has been tested with a QEMU mock device, but tests with real
> >   hardware are still in progress. As such, the over-the-wire protocol
> >   has not yet been fully validated.
> 
> Are there any real devices out there?  Is there a test-device from
> usb-if that we can use?  Surely usb-if published some example code to
> prove that the specification works before ratification happened, right?
> 
Not yet but we hope that having a host implementation will encourage the
vendors to publish authenticated devices.

> > - The kernel/user space communication has not yet been completely
> >   validated, including the interruption of the worker thread and its
> >   resuming.
> 
> What worker thread?  The hub?
> 
Yes, the hub one.

> > - Device authorization and deauthorization has not been completely
> >   implemented.
> > - It lacks an overall documentation and test suite.
> 
> testing is going to be key here :)
> 
Agreed.

> > Upstreaming plans
> > =================
> > 
> > Our current kernel patch is obviously a work-in-progress and not yet
> > ready for merging. We feel it is best to start a discussion on the
> > architectural choices and gather early comments that could be used to
> > improve the design.
> > 
> > Concerning the user space functions, they are currently implemented in a
> > small independent executable as a proof-of-concept. In the future,
> > integrating it in existing larger projects, like USBGuard [6], would
> > allow presenting a homogeneous USB administration interface to the user.
> 
> Yes, usbguard interaction would be good as that's what Linux userspace
> has standardized on.  Have you looked into that yet?
> 
Yes but we chose to implement our minimal test userspace policy engine
for now. We will happily look into it later.

> > Reviewing this RFC
> > ==================
> > 
> > We would like to get comments on the proposed architectural choices
> > regarding the repartition of functions between kernel and user space and
> > on the implementation in the USB stack, mostly concerning the releasing
> > and reacquiring the hub lock multiple times during the authentication
> > process.
> > 
> > Testing this RFC
> > ================
> > 
> > You can find in the following repository [7] the necessary code for
> > creating a test environment:
> > 
> > - the Linux kernel patches;
> > - a python utility to generate a small PKI for device enrollment;
> > - a C minimalist service to implement the USB policy engine;
> > - patches for QEMU to implement a mock USB device with the
> >   authentication capability;
> > - a testbed to compile and test the project.
> 
> As mentioned before, a usb gadget patch might be simpler than dealing
> with qemu, right?
> 
It's feasible, for our current use we think it is easier to test with
qemu and virtme-ng. We currently use the testbed we published [7].

If it were to be implemented in a Linux gadget, it will raise the
question of a secure storage for the authentication key.

Thanks,

Nicolas and Luc

