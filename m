Return-Path: <linux-kernel+bounces-811321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34432B52770
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10CD465F56
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6811E221FC7;
	Thu, 11 Sep 2025 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjQyHZ4c"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E17329F20
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757563024; cv=none; b=Oa2h2BpefFT1LVow2Yg+cB33/cyLRw96q60PyRdKwl9rCF7xsacw1phLH4FdLxgxR721nbAf6dPDTjpkHPBA/G5pdFzu93lBLM/U/ti6pw0dQh4xqwsFnX1YRIWoxKhFSXnwYDKpJEBuCNUiIGJ/i2mV3LpHljSHOVUnSnzygbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757563024; c=relaxed/simple;
	bh=Ejf0TercgLfyTzzpuk+kw4YdzKq+khN21Og4i4uVnok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnYR6o1f71p9ReHxvLCtKWlctDPrMkGOIkpP2FT4zIOUxLwfWEAKiYSrfhWMur58mXBFT/Ox1gMg+a1I7TfoO6mcfg+4e6Y/UgJZ+bwgqiSmlLHxY4fJEkiX2iuGDofq7vdAEqJsv/FLIt2knYzMRuiIahNQ0NZzzX23h3KjTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QjQyHZ4c; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-408c236c500so95855ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757563022; x=1758167822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlmnBtCw23cZtEA4nvpZGoSW/X3Mps3sfK77rUgy40w=;
        b=QjQyHZ4cS9DE6aR0DO2M7e3vdCUf7lRKjJiDc1hk2gsGfbvRSsRgrFLkLzPvOe1toO
         CZBQ581Jpyz0naRJvO0TX23SqkLqFPxjgmJg9tTAcD7ryCMNtMpWZleaHc19c2tGyxnw
         wrA5FHdVqwouZOfRR6YXp2lGLYP9QP3cQRkwRPojxuGCOPGVeU1135YfBU6q/V9EVOXe
         MYcestABNwRU5Is9tfk/dFApNfLr8a/sL30fNDuPYiebXtAvp4wi9jAK5CfFid10Q7Ov
         H4CoSVAUsFCEcxVlWIxwaLyRSzZJHwjhIGcIVYM5XJDeTwX4vX5LJC7dFsaughVBLs2b
         PB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757563022; x=1758167822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlmnBtCw23cZtEA4nvpZGoSW/X3Mps3sfK77rUgy40w=;
        b=QisFm+YGmRiS6HtPyqPq/PGOhgKRLl5ZifFPvx25X4v/KLD8pB9iw0w165890yQpEW
         0/gfyixPZKTdy18ta2mkJx5+3K6D8wuXd+HrTzskNSRnVZqR8//dAHHNBfcpxAXf0qdo
         2Mn/jwiuWGL423uj3C/laZ7s8Apnjh7tQR8A58Wxrp4V8u8CYl08v4Ux3E26/eMNdLbJ
         VeUWxALUDrofnPN5K6vJO9KEC3iNf4uIBkJwox53VXv14bwYBDAcxlBCKiE5tnm1eUvp
         p2cpjzin/U8Vc37SziTUcBdW7/AWgaLOfvsEUS4hDQlflTgMtWxRSrj9PT9wxrYIw0Tf
         MVpA==
X-Forwarded-Encrypted: i=1; AJvYcCVGGNoBpaQ9RuiMj5sux+WVrEHl4lixjD5N2MWoy6eXHkMM5WoT9OTC2DpsFbQT0X0yMLsnlDiRIC/JSGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbcpFOH7Khb9SJ47IUIFZg9Bstp32s09OdA1PN0dIrfJ8tRQlm
	PtPiPiBRo9prk5DLUnbyDwyGYSHaH+G8L/12dbU/5R7XNR2Cn8TOklOEJLIvHobNrbzWRuDO2h3
	6XQfYrAfH3BRLjTR6tCheZ3me39NBgVKWDYLTbFBQ
X-Gm-Gg: ASbGncto0mkKovTSjKQdCyxU4A+tNlab8qHYmibqN1DROy1JbVM/kBVTZilp4qMAwH2
	3Gmv9qYL2LHCZdRrn4EweTuEkGH8z38pNb0gxMh4Oe5pEVTl6DLbwO9ccverm2C37WkQ5YdqRIO
	s3E5PXKafqMa7yDRU3m9lEyIi5AAe5Mv9yXJD8NE+mnylH0XUl7i+V/07WMVCx/+0SOp6c/3SAT
	29KurKBPnHq8yJRsbktnnjPQjVe3t1mBqTazrMF9fSnR8s/Q+JWnPYGHpsnzbgNLhCTIhkkyoES
	mA==
X-Google-Smtp-Source: AGHT+IGQX2l2vipOnPDWBuc3xRv8CDDx2d+OGnf33T+SOHNLMmGLor6hmQNyx64traYD5kfhGGtGg4mKEnranUf7eww=
X-Received: by 2002:a05:6e02:12e8:b0:3eb:ee3c:b9a8 with SMTP id
 e9e14a558f8ab-417105406ccmr9999785ab.15.1757563022013; Wed, 10 Sep 2025
 20:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801034004.3314737-1-guanyulin@google.com>
 <20250801034004.3314737-3-guanyulin@google.com> <2025081326-guileless-lego-ec59@gregkh>
 <CAOuDEK3KZHgY7Z2mBOuEhuUn8eLfjS5BPcx3kaMqVYLUhOavWA@mail.gmail.com> <2025090650-decal-canary-8e34@gregkh>
In-Reply-To: <2025090650-decal-canary-8e34@gregkh>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Thu, 11 Sep 2025 11:56:00 +0800
X-Gm-Features: Ac12FXzQCb6O8FRNPDRHFWgRpNAlC18idJU2T9zFMkMxqDe165A-toqWNXNlXXI
Message-ID: <CAOuDEK3UR6ksPSfq02CvBcqcG+1G43UdofNp6ZmpZm0PSB77oA@mail.gmail.com>
Subject: Re: [PATCH v15 2/4] usb: offload: add apis for offload usage tracking
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mathias.nyman@intel.com, hannelotta@gmail.com, zijun.hu@oss.qualcomm.com, 
	xu.yang_2@nxp.com, stern@rowland.harvard.edu, 
	andriy.shevchenko@linux.intel.com, ben@decadent.org.uk, 
	quic_wcheng@quicinc.com, krzysztof.kozlowski@linaro.org, 
	dh10.jung@samsung.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 6, 2025 at 9:13=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Tue, Aug 26, 2025 at 11:59:00AM +0800, Guan-Yu Lin wrote:
> > On Wed, Aug 13, 2025 at 10:50=E2=80=AFPM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> > >
> > > On Fri, Aug 01, 2025 at 03:39:31AM +0000, Guan-Yu Lin wrote:
> > > > +
> > > > +config USB_OFFLOAD
> > > > +     bool "Enable USB offload feature"
> > >
> > > I'm confused, we already have a "USB offload feature" that went into =
the
> > > last kernel release, why do we need a separate config option for this=
 as
> > > well?  Shouldn't this code only get built if the drivers that need it
> > > select it automatically?  Forcing distros to configure this isn't
> > > generally a good idea if at all possible.
> > >
> >
> > Based on the discussion in v13, a new, separate USB configuration
> > option is required to avoid core USB functions being enabled or
> > disabled via an xhci-specific option. The USB offload feature involves
> > a sideband entity that can access xhci resources, which, from the USB
> > driver's viewpoint, means USB transfers are offloaded to this other
> > entity. Therefore, the name "USB_OFFLOAD" was chosen to reflect this
> > functionality.
>
> Again, you are increasing the number of config options here, which does
> not make sense.  Why would anyone only want a subset, and not just the
> whole thing?
>
> Yes, USB_OFFLOAD only works today on xhci, and that's fine, so let's
> just keep it that way.
>
> > > > +     depends on USB
> > > > +     depends on USB_XHCI_SIDEBAND_SUSPEND
> > >
> > > Especially because all "desktops" do not want this code selected, so
> > > having it in all distros feels like a waste to me.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > For the config keywords, we could automatically select USB_OFFLOAD
> > once USB_XHCI_SIDEBAND_SUSPEND is selected to reduce configuration
> > efforts.
>
> select is a nightmare to maintain and understand.  Please just reduce
> configuration efforts by not adding new options at all :)
>
> thanks,
>
> greg k-h

Thanks for the suggestions. I'll use only USB_XHCI_SIDEBAND_SUSPEND to
control all the features, including the core USB functions.

Regards,
Guan-Yu

