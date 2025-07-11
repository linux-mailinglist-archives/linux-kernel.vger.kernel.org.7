Return-Path: <linux-kernel+bounces-727256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E983B01735
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5EE75850ED
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D46221F20;
	Fri, 11 Jul 2025 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="O1zj9ujP"
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1558D1B3925;
	Fri, 11 Jul 2025 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224827; cv=none; b=F97jfnRN6BQBkEnwKuOUg9QcHFFGGpLxZWuyecpN4qIDSfCZSqZTiYqY/O0m4rEh+3NkKBDwk5J2CYaBanYPGkZg9522zPIyckA8u4zlguJoswZhWovb5t30klv40R4FvlZxm/6MZuGTXe99fCeEgAbTZvrm0/QPbzLVE7kPyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224827; c=relaxed/simple;
	bh=1HDhUj5Gs+V3WBDvXWgWv6ZjW/qY+qR9S83ZiCyVRzs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YzlbKDOotv3eJUu9vBAVEkBba6xFFXAvHsZYIL9ZJ//5Xl6Sf7I7+ksI0s3jhD+F3pmq23l+KA3xg0TmeMP97phgaebOpFXZgv/LNwv+bAWwk482u28bizOKsikl6swo1Fk5dBoX51q31TG4oTfGI8Weq4pIioP2IoeduHMHMDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=O1zj9ujP; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Iy37ilPtEsuezKoNTWgSAeMqThjsKLbuOmc0oPVA/RM=; b=O1zj9ujPJUMsQ5p7KsSUFwnP2z
	5WtJeJEaL9BThDKV/+lo+ArrzaEYUkJwGIxyqY381PIdwvyKbcrKdiOLrR/uZJkUuow3eAxfdbijN
	NZYTn8PyU07YrKMiZeZVVbfJd5BJ8voIoNS+Jeel5N8yM7N0XcHCbRVW74l0bt9TMAu5Ll2M8VTwL
	7FSSff3YyihFSPg+zEBtLNDWFnLD6z8fERfHXcp1cnI/sEhc8nz6XLf51kcjcFH3ofuwFB45GJWuA
	DEc0auWH50IcQNRiE8wHmhloWDstfBny8yLwz1OJW9uZgfgjJLTDNIZZfCAXpYbo7/GAP1JopQdRx
	fluyDuNw==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:16749 helo=[10.224.9.2])
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1ua9K4-0000000DVFH-3WrT;
	Fri, 11 Jul 2025 10:41:34 +0200
From: nicolas.bouchinet@oss.cyber.gouv.fr
Subject: [RFC PATCH v2 0/4] Support for usb authentication
Date: Fri, 11 Jul 2025 10:41:21 +0200
Message-Id: <20250711-usb_authentication-v2-0-2878690e6b6d@ssi.gouv.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADHOcGgC/32NQQ6DIBBFr2JmXQxC1NhV72FMgzrIbLBhgLQx3
 r3UA3T5fv5//wDGQMhwrw4ImIlp9wXUrYLFGb+hoLUwKKla2SkpEs9Pk6JDH2kxsdSF1npeTWe
 1tghl+Apo6X1Jx6mwI457+Fwfufmlf3W5EVLIdVCqa0zb98ODmeptT7m2AabzPL/RJpyytgAAA
 A==
X-Change-ID: 20250620-usb_authentication-333bda6f33fe
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>, 
 Alan Stern <stern@rowland.harvard.edu>, Kannappan R <r.kannappan@intel.com>, 
 Sabyrzhan Tasbolatov <snovitoll@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Pawel Laszczak <pawell@cadence.com>, 
 Ma Ke <make_ruc2021@163.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Luc Bonnafoux <luc.bonnafoux@oss.cyber.gouv.fr>, 
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.14.2
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

We have been working on the implementation of the USB authentication
protocol in the kernel.

You can find our work here https://github.com/ANSSI-FR/usb_authentication.

It is still work in progress but we would like to start discussions
about the implementation design and its possible integration to the
Linux kernel.

Best regards,

Nicolas and Luc

---
USB peripheral authentication
=============================

USB peripherals are an important attack vector in personal computers and
pose a risk to the cyber security of companies and organizations.

The USB foundation has published a standard to allow the authentication
of USB peripherals ([1] and [2]). It defines a mechanism for the host to
request credentials and issue an authentication challenge to USB-2 or
USB-3 peripherals, either upon connection or later during the use of the
peripheral.

We currently envision the following use cases for USB authentication:

- company networks where computers and peripherals can be privately
  controlled and administered;
- USB cleaning or decontamination stations;
- individuals who want to prevent unauthorized device plug-in into their
  machine.

The implementation of this feature will obviously necessitate efforts
from both the kernel community and peripherals vendors. We believe that
providing an implementation of the host side of the protocol in the
Linux kernel will encourage constructors to include this feature in
their devices. On the other hand, we are working on implementing
reference code for embedded devices, notably for Zephyr OS.

Design
======

The USB authentication protocol is based on a simple signature
challenge. Devices hold between 1 and 8 pairs of private signing key and
x509 certificate. Hosts must possess a store of root Certificate
Authority certificates provided by device vendors.

The protocol exchange is driven by the host and can be decomposed into
three, mostly independent, phases:

- The Host can request a digest of each certificate owned by the
  peripheral.
- If the Host does not recognize the peripheral from one of its digests,
  it can read one or more certificates from the device until a valid one
  is found.
- The Host can issue an authentication challenge to the peripheral.

On the host side, this requires the following functions:

- handling the protocol exchange with the peripheral;
- X509 certificates validation and administration (root CA loading,
  certificate revocation…);
- cryptographic functions for the challenge (random number generation
  and ECDSA with the NIST P256 -secp256r1- curve);
- security policy management;
- authorization decision enforcement.

We chose to implement the authentication protocol exchange directly in
the kernel USB stack during the device enumeration. This is done by
first requesting the device BOS to detect its capacity at handling
authentication, then if supported starting the authentication sequence
with a digest request.

The implementation of the other functions is open to several design
alternatives, mainly based on their distribution between kernel and user
space. In this first implementation, we chose to implement most (all) of
the cryptographic functions, certificate management and security policy
management in user space in order to limit impact on the kernel side.
This allows for more personalization later on. The communication between
the kernel USB stack authentication function and user space is done via
a generic netlink socket.

Once a device has been authenticated, a per-device authenticated field
is update with the result of the authentication. The authenticated field
can be used to track the result of the authentication process in
userspace thanks to a sysfs exposed file.

The device enforcement point is done in the usb_probe_interface()
function. This allows for more complex security policy in userspace: the
user could manually authorize a device that failed the authentication or
manually deauthorize a device that was previously authenticated.

+----------+------------+-------------+
|          | authorized | !authorized |
+----------+------------+-------------+
| authent  |     OK     |     NOK     |
+----------+------------+-------------+
| !authent |     OK     |     NOK     |
+----------+------------+-------------+

If set to true, the authentication decision is enforced, the following
decision is made:

+----------+------------+-------------+
|          | authorized | !authorized |
+----------+------------+-------------+
| authent  |     OK     |     NOK     |
+----------+------------+-------------+
| !authent |    NOK     |     NOK     |
+----------+------------+-------------+

Note that combined with the CONFIG_USB_DEFAULT_AUTHORIZATION_MODE=2:
 - internal devices should be authorized and !authenticated => OK
 - external qemu dev-auth is !authorized and authenticated  => NOK at
   first but then authorization can be granted via sysfs.
 - external qemu non auth dev is !authorized and !authenticated => NOK
   and authorization can be granted via sysfs

The default enforcement decision can be configured thanks to the new
USB_AUTHENTICATION_ENFORCE configuration option and can be overridden
using the usbcore.enforce_authentication command line or module
parameter.

Limitations
===========

The USB authentication protocol come with some inherent limitations, [3]
does a good job at describing most of them. During the implementation,
we also found that the value encoding of the Validity field in the x509
certificate differs from the RFC5280 [4]. This has prevented us from
using the x509 parser included in the Linux kernel or OpenSSL, we chose
to use the mbedtls library instead [5]. This obviously does not prevent
others to replace it with their preferred implementation. It will also
open discussions on the protocol enhancement.

The architectural choice to place most of the cryptographic and security
management functions in user space comes with its own limitations.

First it introduces a dependency on the user space program availability.
It will probably be necessary to introduce a fail-safe mechanism if the
authentication can not be completed. Also, during early boot stages the
user space service will be needed in one form or another in the
initramfs.

The second limitation is that the device initialization process is
paused multiple times. Each time, the hub lock is released in order not
to block the rest of the stack; and then reacquired when a response has
been received from user space. The resuming of the operation on the
device must be done with great care.

Last, we do not yet interface properly with the rest of the usb stack
and thus do not enforce a strict control of the two authenticated and
authorized fields. Other sections of the kernel or userspace are able to
overwrite those fields using the sysfs exposed files for example.

Status
======

The current kernel implementation of the USB authentication protocol is
experimental and has the following limitations:

- It does not yet handle all possible protocol errors.
- It has been tested with a QEMU mock device, but tests with real
  hardware are still in progress. As such, the over-the-wire protocol
  has not yet been fully validated.
- The kernel/user space communication has not yet been completely
  validated, including the interruption of the worker thread and its
  resuming.
- Device authorization and deauthorization has not been completely
  implemented.
- It lacks an overall documentation and test suite.

Upstreaming plans
=================

Our current kernel patch is obviously a work-in-progress and not yet
ready for merging. We feel it is best to start a discussion on the
architectural choices and gather early comments that could be used to
improve the design.

Concerning the user space functions, they are currently implemented in a
small independent executable as a proof-of-concept. In the future,
integrating it in existing larger projects, like USBGuard [6], would
allow presenting a homogeneous USB administration interface to the user.

Reviewing this RFC
==================

We would like to get comments on the proposed architectural choices
regarding the repartition of functions between kernel and user space and
on the implementation in the USB stack, mostly concerning the releasing
and reacquiring the hub lock multiple times during the authentication
process.

Testing this RFC
================

You can find in the following repository [7] the necessary code for
creating a test environment:

- the Linux kernel patches;
- a python utility to generate a small PKI for device enrollment;
- a C minimalist service to implement the USB policy engine;
- patches for QEMU to implement a mock USB device with the
  authentication capability;
- a testbed to compile and test the project.

References
==========

- [1] “Universal Serial Bus Security Foundation Specification”, Revision
  1.0 with ECN and Errata through January 7, 2019
- [2] “Universal Serial Bus Type-C Authentication Specification”,
  Revision 1.0 with ECN and Errata through January 7, 2019
- [3] J. Tian, N. Scaife, D. Kumar, M. Bailey, A. Bates and K. Butler,
  "SoK: "Plug & Pray" Today – Understanding USB Insecurity in Versions 1
  Through C," 2018 IEEE Symposium on Security and Privacy (SP), San
  Francisco, CA, USA, 2018, pp. 1032-1047, doi: 10.1109/SP.2018.00037
- [4] RFC 5280, Internet X.509 Public Key Infrastructure Certificate and
  Certificate Revocation List (CRL) Profile, May 2008
- [5] https://www.trustedfirmware.org/projects/mbed-tls/
- [6] https://usbguard.github.io/
- [7] https://github.com/ANSSI-FR/usb_authentication

Signed-off-by: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Kannappan R <r.kannappan@intel.com>
Cc: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Stefan Eichenberger <stefan.eichenberger@toradex.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pawel Laszczak <pawell@cadence.com>
Cc: Ma Ke <make_ruc2021@163.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>
Cc: Luc Bonnafoux <luc.bonnafoux@oss.cyber.gouv.fr>
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Cc: linux-kernel@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

---
Changes in v2:
- Fix code documentation to match kernel-doc format
- General coding style fixes as suggested in v1
- Added netlink socket configuration checks when receiving messages from
  userspace.
- Moved usb_authenticate_device() after device enumeration
- Changed the way authentication enforcement is handled.
  - If the device is authenticated, the device authenticated field is
    set to 1.
  - Added an authenticated file in sysfs that reflects the device
    authenticated field.
  - Enforcement Kconfig and cmdline configurations has been added.
  - Sysctls has been added to permit timeouts values.
- Removed USBAUTH_CMD_RESP_REMOVE_DEV netlink command
- The Kconfig commit has been squashed in the commit that plugs of the
  authentication in the usb stack.
- Link to v1: https://lore.kernel.org/r/20250620-usb_authentication-v1-0-0d92261a5779@ssi.gouv.fr

---
Nicolas Bouchinet (4):
      usb: core: Introduce netlink usb authentication policy engine
      usb: core: Introduce usb authentication feature
      usb: core: Plug the usb authentication capability
      usb: core: Add sysctl to configure authentication timeouts

 Documentation/usb/authentication.rst      |   15 +
 Documentation/usb/index.rst               |    1 +
 drivers/usb/core/Kconfig                  |   26 +
 drivers/usb/core/Makefile                 |    5 +
 drivers/usb/core/authent.c                |  586 ++++++++++++++++
 drivers/usb/core/authent.h                |  192 ++++++
 drivers/usb/core/authent_netlink.c        | 1039 +++++++++++++++++++++++++++++
 drivers/usb/core/authent_netlink.h        |   33 +
 drivers/usb/core/config.c                 |   22 +-
 drivers/usb/core/driver.c                 |   31 +
 drivers/usb/core/hub.c                    |    5 +
 drivers/usb/core/sysctl.c                 |   55 ++
 drivers/usb/core/sysfs.c                  |   16 +
 drivers/usb/core/usb.c                    |   16 +
 include/linux/usb.h                       |   11 +
 include/uapi/linux/usb/usb_auth_netlink.h |   70 ++
 16 files changed, 2121 insertions(+), 2 deletions(-)
---
base-commit: fc85704c3dae5ac1cb3c94045727241cd72871ff
change-id: 20250620-usb_authentication-333bda6f33fe

Best regards,
-- 
Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>


