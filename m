Return-Path: <linux-kernel+bounces-729100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4419B031BB
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 17:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D2897A61A1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC4E27875C;
	Sun, 13 Jul 2025 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IiIks53h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F3FA920;
	Sun, 13 Jul 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420306; cv=none; b=m88Xck6JwCbrB683Qc+momGeFFBj1Dk2DQ4jmatXBYrSVfbe1sFm1ie0pt/U95YYlfOeGM47LIufSPpWOmvwQpuYpyaBdoi+0VHzCS2mRlHGFDUqmcqG3ZnMXQRV4d2eBhgL2NI4yQWJDwrevwVMwHzS82bBrpOdPxQ0tmajilw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420306; c=relaxed/simple;
	bh=dZdGr2CCAlJGjWO+7HGSxJpH1MKc/Qn0R92NUy8pYKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxWTlpF3G1mh5Mj14cnLgb5V67zIJcwqerKUrrPJkFDauqycWbDI9ODUGF2qoeahiCeiFJ8A84aFt+YdCmOkkWzJUnwv707jS9g4+Mdl0HdgCyT5ZTKQQGgqhV22xBKZTZa/Jv3IQDeep0w9JrxxDTQ42GfX6Vj5rhpMYASlQxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IiIks53h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1515AC4CEE3;
	Sun, 13 Jul 2025 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752420305;
	bh=dZdGr2CCAlJGjWO+7HGSxJpH1MKc/Qn0R92NUy8pYKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiIks53hY96sEnf709yDZnsl1VcME1FuRcrn0DfONtL3QAP58EQe1wiDRotza7XW0
	 r/sXxRDH/1KjG/RsM06Uw3afWnMeNsECDHy6/UtJgt/pI9nvOO5GoLLfuqIe6iOuhF
	 NL/+aTWNhIEB2sbS3dqtNQ6GJUezpI04RFi0kDaI=
Date: Sun, 13 Jul 2025 17:25:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: nicolas.bouchinet@oss.cyber.gouv.fr
Cc: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>,
	Alan Stern <stern@rowland.harvard.edu>,
	Kannappan R <r.kannappan@intel.com>,
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pawel Laszczak <pawell@cadence.com>, Ma Ke <make_ruc2021@163.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Luc Bonnafoux <luc.bonnafoux@oss.cyber.gouv.fr>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Support for usb authentication
Message-ID: <2025071344-possible-fabric-bbbf@gregkh>
References: <20250711-usb_authentication-v2-0-2878690e6b6d@ssi.gouv.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250711-usb_authentication-v2-0-2878690e6b6d@ssi.gouv.fr>

On Fri, Jul 11, 2025 at 10:41:21AM +0200, nicolas.bouchinet@oss.cyber.gouv.fr wrote:
> We have been working on the implementation of the USB authentication
> protocol in the kernel.
> 
> You can find our work here https://github.com/ANSSI-FR/usb_authentication.
> 
> It is still work in progress but we would like to start discussions
> about the implementation design and its possible integration to the
> Linux kernel.
> 
> Best regards,
> 
> Nicolas and Luc
> 
> ---
> USB peripheral authentication
> =============================
> 
> USB peripherals are an important attack vector in personal computers and
> pose a risk to the cyber security of companies and organizations.
> 
> The USB foundation has published a standard to allow the authentication
> of USB peripherals ([1] and [2]). It defines a mechanism for the host to
> request credentials and issue an authentication challenge to USB-2 or
> USB-3 peripherals, either upon connection or later during the use of the
> peripheral.
> 
> We currently envision the following use cases for USB authentication:
> 
> - company networks where computers and peripherals can be privately
>   controlled and administered;
> - USB cleaning or decontamination stations;
> - individuals who want to prevent unauthorized device plug-in into their
>   machine.
> 
> The implementation of this feature will obviously necessitate efforts
> from both the kernel community and peripherals vendors. We believe that
> providing an implementation of the host side of the protocol in the
> Linux kernel will encourage constructors to include this feature in
> their devices. On the other hand, we are working on implementing
> reference code for embedded devices, notably for Zephyr OS.
> 
> Design
> ======
> 
> The USB authentication protocol is based on a simple signature
> challenge. Devices hold between 1 and 8 pairs of private signing key and
> x509 certificate. Hosts must possess a store of root Certificate
> Authority certificates provided by device vendors.

Who is going to distribute these host keys?  Who is going to be
responsible for revocations and the like?

> The protocol exchange is driven by the host and can be decomposed into
> three, mostly independent, phases:
> 
> - The Host can request a digest of each certificate owned by the
>   peripheral.
> - If the Host does not recognize the peripheral from one of its digests,
>   it can read one or more certificates from the device until a valid one
>   is found.
> - The Host can issue an authentication challenge to the peripheral.

Is this the same type of protocol that PCI has implemented for its use
of "trusted devices"?  If so, why not emulate what the kernel patches
for PCI do here as well to keep one common kernel/userspace api?  If
not, what are the major differences?

> On the host side, this requires the following functions:
> 
> - handling the protocol exchange with the peripheral;
> - X509 certificates validation and administration (root CA loading,
>   certificate revocation…);

Is the validation going to be done by the kernel?  Userspace?  And how?
Is a chain-of-trust defined somewhere?

> - cryptographic functions for the challenge (random number generation
>   and ECDSA with the NIST P256 -secp256r1- curve);
> - security policy management;
> - authorization decision enforcement.
> 
> We chose to implement the authentication protocol exchange directly in
> the kernel USB stack during the device enumeration. This is done by
> first requesting the device BOS to detect its capacity at handling
> authentication, then if supported starting the authentication sequence
> with a digest request.
> 
> The implementation of the other functions is open to several design
> alternatives, mainly based on their distribution between kernel and user
> space. In this first implementation, we chose to implement most (all) of
> the cryptographic functions, certificate management and security policy
> management in user space in order to limit impact on the kernel side.
> This allows for more personalization later on. The communication between
> the kernel USB stack authentication function and user space is done via
> a generic netlink socket.

Again, is this what PCI has decided to do?  Surely they didn't implement
a different way of authenticating devices, did they?  (I can dream...)

> Once a device has been authenticated, a per-device authenticated field
> is update with the result of the authentication. The authenticated field
> can be used to track the result of the authentication process in
> userspace thanks to a sysfs exposed file.

This is _VERY_ close to what the old wireless USB protocol required,
right?  And I think you've tied into much the same places we did for
that protocol, but you might want to look into the past history for when
we removed that to be sure.

> The device enforcement point is done in the usb_probe_interface()
> function. This allows for more complex security policy in userspace: the
> user could manually authorize a device that failed the authentication or
> manually deauthorize a device that was previously authenticated.
> 
> +----------+------------+-------------+
> |          | authorized | !authorized |
> +----------+------------+-------------+
> | authent  |     OK     |     NOK     |
> +----------+------------+-------------+
> | !authent |     OK     |     NOK     |
> +----------+------------+-------------+

What is "NOK"?  And what are the two axis?  The sysfs file values?  Or
an internal variable?

> If set to true, the authentication decision is enforced, the following
> decision is made:

If what is "set to true"?

> +----------+------------+-------------+
> |          | authorized | !authorized |
> +----------+------------+-------------+
> | authent  |     OK     |     NOK     |
> +----------+------------+-------------+
> | !authent |    NOK     |     NOK     |
> +----------+------------+-------------+
> 
> Note that combined with the CONFIG_USB_DEFAULT_AUTHORIZATION_MODE=2:

What does "2" mean?

>  - internal devices should be authorized and !authenticated => OK
>  - external qemu dev-auth is !authorized and authenticated  => NOK at
>    first but then authorization can be granted via sysfs.
>  - external qemu non auth dev is !authorized and !authenticated => NOK
>    and authorization can be granted via sysfs

Wait, what does qemu have to do with anything here?

And this is getting to be a complex set of interactions, testing the
combinations is going to be rough without regression tests...

> The default enforcement decision can be configured thanks to the new
> USB_AUTHENTICATION_ENFORCE configuration option and can be overridden
> using the usbcore.enforce_authentication command line or module
> parameter.
> 
> Limitations
> ===========
> 
> The USB authentication protocol come with some inherent limitations, [3]

That's a 2018 reference!  Are you saying that the newly designed
protocol was already discussed in 2018 and found lacking?

> does a good job at describing most of them. During the implementation,
> we also found that the value encoding of the Validity field in the x509
> certificate differs from the RFC5280 [4].

Can this be fixed?

> This has prevented us from
> using the x509 parser included in the Linux kernel or OpenSSL, we chose
> to use the mbedtls library instead [5].

Ugh, why?  Why not fix up the kernel parser to work with this broken
implementation instead?  How is any other operating system handling this
if the implementation is broken?  How was it ever tested?

> This obviously does not prevent
> others to replace it with their preferred implementation. It will also
> open discussions on the protocol enhancement.

Have you done this with the usb-if?

Note, Linux was explicitly kicked out of particapating in usb-if
discussions in the past by some of the core members a decade or so ago
because they did not want us to implement specifications before other
operating systems had the chance to.  So, given that this is a new spec,
has Windows added support for this yet to prove it actually can work?

What's the odds that usb-if is willing to talk to us again?  :)

> The architectural choice to place most of the cryptographic and security
> management functions in user space comes with its own limitations.
> 
> First it introduces a dependency on the user space program availability.
> It will probably be necessary to introduce a fail-safe mechanism if the
> authentication can not be completed. Also, during early boot stages the
> user space service will be needed in one form or another in the
> initramfs.

Ugh, that's going to get messy fast, so putting this in the kernel might
be the simplest way if at all possible.  At least for "boot devices", or
just punt and don't care about USB devices at boot time?

> The second limitation is that the device initialization process is
> paused multiple times. Each time, the hub lock is released in order not
> to block the rest of the stack; and then reacquired when a response has
> been received from user space. The resuming of the operation on the
> device must be done with great care.

USB probe sequences are slow based on the slow devices, so I doubt this
is going to even be noticable.  Have you seen any real slow-down in your
testing?

> Last, we do not yet interface properly with the rest of the usb stack
> and thus do not enforce a strict control of the two authenticated and
> authorized fields. Other sections of the kernel or userspace are able to
> overwrite those fields using the sysfs exposed files for example.

Why would the kernel be writing these values?  And if userspace isn't
supposed to be writing to these anymore, just change the permissions on
the sysfs files, OR just fail the write with the logic in the kernel
itself.

> Status
> ======
> 
> The current kernel implementation of the USB authentication protocol is
> experimental and has the following limitations:
> 
> - It does not yet handle all possible protocol errors.
> - It has been tested with a QEMU mock device, but tests with real
>   hardware are still in progress. As such, the over-the-wire protocol
>   has not yet been fully validated.

Are there any real devices out there?  Is there a test-device from
usb-if that we can use?  Surely usb-if published some example code to
prove that the specification works before ratification happened, right?

> - The kernel/user space communication has not yet been completely
>   validated, including the interruption of the worker thread and its
>   resuming.

What worker thread?  The hub?

> - Device authorization and deauthorization has not been completely
>   implemented.
> - It lacks an overall documentation and test suite.

testing is going to be key here :)

> Upstreaming plans
> =================
> 
> Our current kernel patch is obviously a work-in-progress and not yet
> ready for merging. We feel it is best to start a discussion on the
> architectural choices and gather early comments that could be used to
> improve the design.
> 
> Concerning the user space functions, they are currently implemented in a
> small independent executable as a proof-of-concept. In the future,
> integrating it in existing larger projects, like USBGuard [6], would
> allow presenting a homogeneous USB administration interface to the user.

Yes, usbguard interaction would be good as that's what Linux userspace
has standardized on.  Have you looked into that yet?

> Reviewing this RFC
> ==================
> 
> We would like to get comments on the proposed architectural choices
> regarding the repartition of functions between kernel and user space and
> on the implementation in the USB stack, mostly concerning the releasing
> and reacquiring the hub lock multiple times during the authentication
> process.
> 
> Testing this RFC
> ================
> 
> You can find in the following repository [7] the necessary code for
> creating a test environment:
> 
> - the Linux kernel patches;
> - a python utility to generate a small PKI for device enrollment;
> - a C minimalist service to implement the USB policy engine;
> - patches for QEMU to implement a mock USB device with the
>   authentication capability;
> - a testbed to compile and test the project.

As mentioned before, a usb gadget patch might be simpler than dealing
with qemu, right?

thanks,

greg k-h

