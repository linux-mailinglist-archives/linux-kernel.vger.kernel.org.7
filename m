Return-Path: <linux-kernel+bounces-877703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A16A2C1ED02
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B02A4E886C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012C337B9A;
	Thu, 30 Oct 2025 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J71q979l"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157CA19E99F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809991; cv=none; b=Cj4ixp8ycHxzHv/yuVO01tpXqRG44PcpVU8XsbIrt40YKFwMu7bWsShT9g1Hz/HoYoVniC1fE7aDBYsZR2adi5I89FOcQeyXohojSCxlXU3T6ebd6kwD0Uwss00jjCDLqQrBNyMF5MC8YLvDTkxV70vNPj6G3A98pr2qGKk+xYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809991; c=relaxed/simple;
	bh=9yUwP4kPaEdJtvr+CvbfQpL6t1OZzYyk4SU6OBUGdEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMEW2LOh5kgOJG1GoIUZpqyK20//YxXqDApA7QJ217Rw67BUOpdEqlQxCpLyH0wKyTxj0iyiMfGnG1c+wfP7AdlAtoZUCEmSmwVO4cPAQn9sAzvD+eHUF54gml6/x21gJh95tAbOWhVi6A5lia4hkm2TP2J/4Xyzz2arPYpqs8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J71q979l; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-378d61ce75aso8112541fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761809988; x=1762414788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yUwP4kPaEdJtvr+CvbfQpL6t1OZzYyk4SU6OBUGdEY=;
        b=J71q979lDXpcJsnOttVrbrabwoMlFEma8gXf4Ken0UJR1vqSZ2sbZ7CFjd4XF03Sp+
         bYq4VRGwl2gcM5N+H498Za9n3UZsBdJb2h9nO1Va+aYmFGjh1jrNHzP5/91dwAe1ONp2
         jsxKpSjg7jahNFOvXWLpKYLrHBia7y+A85f19cvd7NIEsgUVUmxBlKhTl1QJ56rz9tDt
         m6Pa8nUAc8PCxTIcfbF1/woTy4c9zfhLgLCtiIwRZRSxmiYFbqB3xdcOwjQPQEx38E2/
         98K7ypns9K7zGihzYLey+/wbyb/74TXD9OHN3vnEyI6SeRyy+vOPPWqCTfkH3bdOp5mC
         Wm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809988; x=1762414788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yUwP4kPaEdJtvr+CvbfQpL6t1OZzYyk4SU6OBUGdEY=;
        b=MbrMpCTu5PJXyiSZbUvEijZ6wsOgKq4IVFLwGfSDU25cqfvvWaSNtmECmF41vBT1ZP
         U21CCbzMkaxg1bdcKiyPe06QykhBtp4aPTvFDlDO7MmrQBRvSdbx/Y5KsrWhbdiNutqW
         Ac2KDSIK7GcCQX2Td7uvJlfq570h9NVET1ekM4l4rUML3hSAMsvJfX+M56c+glHFIjRM
         SCoVIwpFIZI6G4PHIkwkNE/GhMMs9ppaZHCZN61YVRRwmDcN/Sw/JPyfVR7YK00DTPij
         53p0xFbcj19nfr+LzyDh80WgQ/dUCznppoy5CaIVQmqVwrw6mwhTALfuIiEKawUcwpAk
         HDwg==
X-Forwarded-Encrypted: i=1; AJvYcCXykGWPRTnBhXpYH4P79YqmqXj5LAoJp1BmSYosK5L04HcnZZ7CTjoWuLLqjmpXUJvUerx9paalV+NDqRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz085tVvRlCHd9AMDIzFfSsRff5cyENScUx6k7cTYOO5+P0K2u+
	5RwTrPFBVk8jclWsMHdxMWMRkZZ2QIwuWYbw/MQ04y2k0m1DVqe0acVfIpfOlfQ/bNpu1UOvVYk
	e/OY4rkeGHuteb600ELiC3goUE/0F+H4=
X-Gm-Gg: ASbGncugb4L2f/6FAi3sfZEd2LuwCO02V4b3IIbSmOHdwsBB/GXzSGcY4W9hiZokxa1
	WZfvEsFMWYGLhRHD/PR+hdHe2ZY0PEVtNmnBVpOQBbvR+ewDh7+mogtSnteTkLmNqxy2GKv7ADm
	+moCobWOAuArPzEakqg3078Vqd/yUgG8tXLxY5WAhgZ6Z4qN9+bGQKZVgggEmoPSsTKHNWLwmWw
	IyhJ98wUF4Ngy+TUo//4Pr54j9KYq3sOjqxK8JWkl8qYoxWjzINtub4VtPhAhr/Wtyh
X-Google-Smtp-Source: AGHT+IH6BHlDGGqZl4xNIme+2yx8hI/HaajLMlkoQe14TrQIC5gP9C3O91U5O3c2DL4xU4uQPZ5+4qia2M/Sbh0/beI=
X-Received: by 2002:a2e:bc0d:0:b0:376:3d8c:4df4 with SMTP id
 38308e7fff4ca-37a1067f994mr7577701fa.4.1761809987851; Thu, 30 Oct 2025
 00:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926060235.3442748-1-cryosay@gmail.com> <aO5kBAjE6EMG2aUE@hovoldconsulting.com>
In-Reply-To: <aO5kBAjE6EMG2aUE@hovoldconsulting.com>
From: Oleksandr Suvorov <cryosay@gmail.com>
Date: Thu, 30 Oct 2025 09:39:36 +0200
X-Gm-Features: AWmQ_bkO7lXe1738HDkGrKIyD0Bk06Av-7OCJrogshstT-ALsPGbL9I210oBCg4
Message-ID: <CAGgjyvFATG4PpHrbWV87tqtLeO3zeM_0508wtATrsxw3s06zVw@mail.gmail.com>
Subject: Re: [PATCH] USB: serial: ftdi_sio: add device ID for U-Blox EVK-M101
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Wed, Oct 15 2025=E2=80=AFat 16:36 Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Sep 26, 2025 at 09:02:35AM +0300, Oleksandr Suvorov wrote:
> > The U-Blox
>
> Missing product name?

Thanks, I'll fix it.

> > has a USB Type-C port that presents itself as a USB device
> > (1546:0506) [1] with four attached FTDI serial ports, connected to:
> > - EVK-M101 current sensors
> > - EVK-M101 I2C
> > - EVK-M101 UART
> > - EVK-M101 port D
> >
> > This commit registers U-Blox's VID/PID of this device so that FTDI SIO =
driver
> > successfully registers these 4 serial ports.
>
> Are you sure you should not just register the UART port? Some FTDI chips
> support I2C but you'd need a different driver for that.

Thanks for pointing this out, looks like I should add a custom probe()
for this device.
Preparing v2.

> > [1]
> > usb 5-1.3: new high-speed USB device number 11 using xhci_hcd
> > usb 5-1.3: New USB device found, idVendor=3D1546, idProduct=3D0506, bcd=
Device=3D 8.00
> > usb 5-1.3: New USB device strings: Mfr=3D1, Product=3D2, SerialNumber=
=3D0
> > usb 5-1.3: Product: EVK-M101
> > usb 5-1.3: Manufacturer: u-blox AG
> >
> > Datasheet: https://content.u-blox.com/sites/default/files/documents/EVK=
-M10_UserGuide_UBX-21003949.pdf
>
> The user guide also says "Do not use this COM port" for all ports but
> the UART port.

Yes, you're right, thanks. It's just not that easy hacking the kernel
while defending from russian invaders :)

> Johan

--=20
Best regards
Oleksandr, sr.soldier in the Armed Forces of Ukraine

