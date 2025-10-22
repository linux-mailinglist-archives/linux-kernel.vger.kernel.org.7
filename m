Return-Path: <linux-kernel+bounces-864911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 840B0BFBD4A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B53F1A02F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD07343214;
	Wed, 22 Oct 2025 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CcXotwCh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B78E3431E6;
	Wed, 22 Oct 2025 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761135778; cv=none; b=TzrntupGTYLzNT1kT245U58yIedXtDv9yHs9/Lqwj/JT74iBg4TXhEiuEW9Qwgn/3WaOP2bw0PDZwU8fmDYWmoeCFp0pcQ7DSxGj2ACfZxIKZi1tNR12vfFhIZtg5tShqZGHvXFNGLhPKNTrs00bBipbGrNOdmKw3KeFHAEH4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761135778; c=relaxed/simple;
	bh=/Q0YQ2QK+Lyjmn1wydFwJuA7SioUFyLFslDItMQUjRc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IilbhLCZshMg5M9CDo+KCuAfizziEMJkOFXpsNp51C4x5G0lnZv25zZAZdz8EI1OaH4UC2V5mDWgREvQdfkTGo3ByyN9sGvYFYavfZECPqgDWscVfuUAqUbuKhZkFYWhgIjgXJbauz1mMFgoLKKG/ko1N2wAgAfp9BlqA5NBiVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CcXotwCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D92EC113D0;
	Wed, 22 Oct 2025 12:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761135777;
	bh=/Q0YQ2QK+Lyjmn1wydFwJuA7SioUFyLFslDItMQUjRc=;
	h=Date:From:To:Subject:From;
	b=CcXotwCht9ruyJExY3IUpICe+wM758/qiedEHWv4mMZelOprUMEs3hEz2C03sHPOR
	 IklWBnYUx7glgWT35pR/JJiWlVDVzDKoUls/HK+HVPFhNsKfoqnYKKGNxODygr3PJ7
	 hUpwlCP8FyKetjM6g8PgBBIU2MwxQqDmMTdqQksQ=
Date: Wed, 22 Oct 2025 14:22:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: usbutils 019 release
Message-ID: <aPjMnie4RSxRvRHf@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hDfqqGy0tvK8M7Ov"
Content-Disposition: inline


--hDfqqGy0tvK8M7Ov
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Another year later, so it's time for a new usbutils release.

I'd like to announce the usbutils 019 release.

The "big" change in 018 was the move to meson as a build system, luckily
that seems to have worked out well with no major problems reported by
the distros due to that.  There's no such large change this release
cycle, so packagers shouldn't have any surprises.

For "modern" Linux distros, the usb-devices script was starting to show
warnings due to updated other packages, so this release fixes that up to
properly handle leading spaces in some sysfs files (the sysfs file
format has not changed in decades, it's not the kernel's fault here...),
that's probably the most pressing issue resolved here.

Also added was support for better handling for new USB device types that
have come out in the past year or so and other minor formatting tweaks
resolving reported issues.

Full details of the changes in this are found below in the shortlog.

Tarballs can be found on kernel.org here:
	https://www.kernel.org/pub/linux/utils/usb/usbutils/

Or you can pull from the following git locations as well:
	https://git.sr.ht/~gregkh/usbutils
	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usbutils.git
	https://github.com/gregkh/usbutils
	https://github.com/linux-usb/usbutils

thanks,

greg k-h

------------

usbutils 019
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Alban Browaeys (1):
      usbreset.1: fix typo in the busnum/devicenum example

Aurelien Jarno (2):
      lsusb.py: add usb.ids path for Debian
      usbreset: fix swapped vendor and product ID in help/manpage

Bjarni Ingi Gislason (1):
      usbreset.1: fix groff warnings and small fixes

Emil Velikov (1):
      ci: stop manually creating build/

Enrico Joerns (1):
      ci/codeql: use filter-sarif to filter meson-private

Greg Kroah-Hartman (8):
      Remove commented out code in usbreset.c and list.h and container_of.h
      lsusb: turn a FIXME comment for dump_comm_descriptor() into something=
 real
      lsusb: remove FIXME about wireless usb device
      lsusb: change FIXME for bmEthernetStatistics into a TODO
      lsusb.c: change TODO into a fixme in do_dualspeed()
      usbreset: move the serial number forward in the output
      usb-devices: fix up bash warning for $altset
      usb-devices: fix up some minor shellcheck warning messages

Guillaume G. (1):
      usb-spec: remove vendor specific entry

J=F6rg Hofrichter (2):
      usbreset: apply clang-format
      usbreset: support resetting device by serial number

Lucas De Marchi (1):
      ci: Fix debian/ubuntu installation

Michal Pecio (1):
      lsusb: Show wBytesPerInterval field of the SS EP companion descriptor

Sahil Siddiq (2):
      usb-devices: Make devcount 'local' to handle recursion
      usb-devices: Make devnum 'local' to handle recursion

Stefan Becker (1):
      lsusb-t: add verblevel 3 to print_usbdevice()

Torleiv Sundre (1):
      lsusb: improve usb2 device capability descriptor

Waffle Lapkin (1):
      Fix display of HID descriptors

dependabot[bot] (9):
      ci: bump the all-actions group with 4 updates
      ci: bump github/codeql-action in the all-actions group
      ci: bump github/codeql-action in the all-actions group
      ci: bump the all-actions group with 2 updates
      ci: bump github/codeql-action in the all-actions group
      ci: bump the all-actions group with 2 updates
      ci: bump the all-actions group with 2 updates
      ci: bump github/codeql-action in the all-actions group
      ci: bump the all-actions group across 1 directory with 3 updates

--hDfqqGy0tvK8M7Ov
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAmj4zJkACgkQONu9yGCS
aT6UcA/+J8eUw1Nh26VQcedVOovVorZNgEmWalwyod1nnq8vQf48YfCgxVtM9Js9
CRf61Epavy2aAqwneqKHMAAMHGh3byYm3FdjBD2KBwoCJ8rPYWo4I5iRU0sUc8jW
fLz/Bj4FefCLw6hZvR4mewv9W43T0diVbjCYEaVrqVPoyyOqCq4k6pLCXzGilVGn
Q7XpGE5JcevM4u01PAZBMRwvplHw0tOKb4Z/+NN76eHy3aK8itnQ4GMlUU3jVbA8
FQ4lmLhv/KdoE0SdynKo0m29/Et3pa5Ho/NVaMlFBgSElwPoJgORvd4LWTyivBqs
CT2PXm0ZMYqj1l9bvTrZGUc3SanQYw+tTYx2HeZ43uBLmt0eTIsZbrrhpa4JSs7n
ySaBnIZIgQdMm/xKai+00aXHGDsw0ex+5rsN7gD4bFUp005/rNc2dJoYfZDl1vU6
7cElIxadg0Ve30hFv8dWAqTMtHUEyclQlfoo9DzxVDC9RIYmmtpI5Y2cADC25wXx
Ig/aRB0Ea1pxRdjnNADNNLzpgOoaTnp48iITNw0m/bqDOOaSbyJVau+BNTQ6xOJQ
WKQ208bFzUkKPmC0AE8VmZc/eF45mCWUNrBMYh6aY2umqePcYxx7YrJ/d0XOpjj3
QiErNsXdTgNWjupl31VSuW/jylnLIu4g9pQ48PdcgX7SUEDglF0=
=MVjB
-----END PGP SIGNATURE-----

--hDfqqGy0tvK8M7Ov--

