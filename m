Return-Path: <linux-kernel+bounces-877919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 828B8C1F598
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30E504E939B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07737342CA2;
	Thu, 30 Oct 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjcff35R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7DE341661;
	Thu, 30 Oct 2025 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817228; cv=none; b=hD1D78bffxlV7cyXi0beO1zAqYIJT7K/zdXVsA8yukkvvk/qj5CgSlnLVqWnypiNzwR1pKPJQZmT7Dv18AAUzwiIIdmLt2FdFBm+c2TPsQJd4gIfzf8O3y5yI08ox++pklewhG2Ly4+ZJ8NPz/2si38gxLZZdQiaCutv1gVRFXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817228; c=relaxed/simple;
	bh=WrfP/raxXECm6y+BjC6Gos4EkPPABLN2YvzRMU/SBBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW/MH91H3tKQxlJof5/yM+ByVFl2NJH7bOtnsB7DPJy5V8K0T2ItFa/mxZrVYXybDzkCCiNw7chgAhoP/vCKxbpvWEnQZYATv4VhuVYCsQ1NfAybCltaOgQoCtsip5/MNbtG+nX6IFKto7SJR8CFSoU/UKsL7mlTn2unKnU7QRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjcff35R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF9FC4CEF1;
	Thu, 30 Oct 2025 09:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761817227;
	bh=WrfP/raxXECm6y+BjC6Gos4EkPPABLN2YvzRMU/SBBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hjcff35RmI/X7nv2sjMFkjeDZnmBvL4gjMlh5dTozmH/gFabhgd+lJXnIOnQMG26E
	 KxreF0viO0R9Gf4W5KPO0fkdolQ23fCpntkrUjSPr3aYa9c/xX5MVYKA2ayigrggC8
	 sSmM3D+66Ilnw3x7ZF8bFprGouh8ctVdAsLdtiH0GQNMIdGJLVyEI/C53zF5nfT9uU
	 cV994T2rOov+nC/TvmXslFuU3hrSLi97qR8K/1Yzdtk11SZ4u0KiRImoe7L54F1XA5
	 gN1vXsW/+CD6Iy2U6tAEu++qaHwHd254I9vbFvo3Vjn0lrycE08wbxuclgetC3PhMz
	 DgwCOKezyRMvg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vEP90-000000004db-3QzY;
	Thu, 30 Oct 2025 10:40:34 +0100
Date: Thu, 30 Oct 2025 10:40:34 +0100
From: Johan Hovold <johan@kernel.org>
To: Oleksandr Suvorov <cryosay@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: add device ID for U-Blox EVK-M101
Message-ID: <aQMykuOFuwi0OTdi@hovoldconsulting.com>
References: <20250926060235.3442748-1-cryosay@gmail.com>
 <aO5kBAjE6EMG2aUE@hovoldconsulting.com>
 <CAGgjyvFATG4PpHrbWV87tqtLeO3zeM_0508wtATrsxw3s06zVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGgjyvFATG4PpHrbWV87tqtLeO3zeM_0508wtATrsxw3s06zVw@mail.gmail.com>

On Thu, Oct 30, 2025 at 09:39:36AM +0200, Oleksandr Suvorov wrote:
> On Wed, Oct 15 2025 at 16:36 Johan Hovold <johan@kernel.org> wrote:

> > > has a USB Type-C port that presents itself as a USB device
> > > (1546:0506) [1] with four attached FTDI serial ports, connected to:
> > > - EVK-M101 current sensors
> > > - EVK-M101 I2C
> > > - EVK-M101 UART
> > > - EVK-M101 port D
> > >
> > > This commit registers U-Blox's VID/PID of this device so that FTDI SIO driver
> > > successfully registers these 4 serial ports.
> >
> > Are you sure you should not just register the UART port? Some FTDI chips
> > support I2C but you'd need a different driver for that.
> 
> Thanks for pointing this out, looks like I should add a custom probe()
> for this device.
> Preparing v2.

Actually, you can just use USB_DEVICE_INTERFACE_NUMBER() in the match
table, no need for a custom probe function.

> > > Datasheet: https://content.u-blox.com/sites/default/files/documents/EVK-M10_UserGuide_UBX-21003949.pdf
> >
> > The user guide also says "Do not use this COM port" for all ports but
> > the UART port.
> 
> Yes, you're right, thanks. It's just not that easy hacking the kernel
> while defending from russian invaders :)

I can only imagine.

Johan

