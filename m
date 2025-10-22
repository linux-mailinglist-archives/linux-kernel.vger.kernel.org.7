Return-Path: <linux-kernel+bounces-864316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71825BFA816
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28C7C4F0D5E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4D42ED84A;
	Wed, 22 Oct 2025 07:20:10 +0000 (UTC)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA892F5A1C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117610; cv=none; b=Wed+0c9Z9bGVnwS9N+CrsDHjaYjoVXanMIq0hCX02Fg0gT691bENqGPWzM2MbmddOT/ZPSHnhj8otUrn0gfSCKEtTfWTnT1EjIWe3n6Yw2OBL2s7gy+F4OM7ZrX3VeN6Z8JiADmu5ncyXrcIhoNPKgym7Ug7vU//Uzi+Z5fqt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117610; c=relaxed/simple;
	bh=oj2g+iXtUrFUuNWS7IxNGMMhQzbaj0lpzDuF73afwdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLBQe/kycZg5FqYyaPTQHXZ0b7tEkSNlkIXZ3N3zZPEGOajTZcYCakKnom3cLKzYd5Gam16aChW4/gyOoFhhhIvBbC0npNuH3logHjqvR9gj/9+4lxIPb1F7Bmd7r5klIXV5UjNH4CF2bX+2B9hUsPG3mnxNKq6PHoYO/msctkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5d758dba570so3223459137.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117607; x=1761722407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LB4UmnebrIV6VHjidh9rexno3FG0/9sLJFVzFv+0Cqk=;
        b=g5qEBaFuoKKfgIojJL0rXz7MRJ2aSGMuTsJDB2O7ZDQ2ooJ6rmes6HCtXWI18jkMZV
         o9YEEa2jf5E138Vwhc+5EOwO7uMwK9Br60e1UObTJ1x+LP8ReJEZFGEmWRb8HhgJx7BE
         1Kgz3dI99eW+1t/cKjt+ePhCFUl2cjctIOmxiHalju8my/FuenETu06fG5dRjfn+eIIP
         QRffVO0kxJaJF0ql3FlnFUI/SCooEfjsW9Yb2zgRzllC4w40mpxntRNF4Fh1nLmA3ymx
         Zoyl0biihPcpTgPaPQOppj/iUxGysOT3ET7/wKFGIdxzs69F6AgpxSdnXliYHGoRhEPA
         2clQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE3Zpa0O0deBC7p3BoxjxulcCIeGrLC9gTwgSYBHYTQ+9uKf0KqUWxQnwoqWdg3QlC/5eV2CPzJckrJm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YytWjkrWt10RNv8McOHbZzMADgXL0r5//pTq50XWExJ5UAdEsNo
	EC2lFxDGWTHWBuiv4KB/58Pi/ThZRr3bqZfsqQ/S9q+WoBfhX5C8ZH73enXWiz7K
X-Gm-Gg: ASbGncvUSFUe8nZs4Ad5Jlx2QQl3Jx04NwmXEzVwG3oWlffPQarY7RtglHYNK98YMdo
	9fM/9Sv3dCYwWb8HDC49m+39t5uEShWD1+uupr9ZwYnSekAKhl0e3q0BSrsNnyMpGvOPfLia2iZ
	OldqUXBt6/I5ih9TyQ4tFwwEs6tcH6wsp98WmPW/kfFVhUQrx7vjZw40dh+mTBOHcuNgaqdlfYn
	JKquVEJ4/jmRm16ycjwH6Y+D80+tDiNhPeuw+OGAPA778FfoLU+Fd181lcCMrCqYuoFnNypebVp
	zBih/wvzkialX1P7AcdjxIEjNYgPSN+Tclp8mBhdXCjr+ugaTbZiQdGIBPduD5uTncbqnYHr6Yn
	KtjNGfSTY/cJr6i/0bIvpG8245kt4BPBdrotP3IChhOWFxSOUnHSd7hnIo6ABPVg8sYrcslHtj0
	11xBLk6kofkmivmTcYavZEjQ6LCXGKonA7MRj38w==
X-Google-Smtp-Source: AGHT+IGsG6Vj+jUv9d/TEHgKQAxzfAgRx1EuihAyLIPsIiN4BsQbLdRifAlqjcA0el9KHnAO9tcF6Q==
X-Received: by 2002:a05:6102:c51:b0:5d5:f6ae:38e2 with SMTP id ada2fe7eead31-5d7dd6bbe71mr4716374137.45.1761117606907;
        Wed, 22 Oct 2025 00:20:06 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d96c25dd20sm4409941137.11.2025.10.22.00.20.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 00:20:06 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5d5f8e95d5eso2837887137.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:20:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLCmCFJJnDtBOxqt3Wo8HLYGgJuycUxj3skuYEvReISLQSxYIjtUh0rOm13nb2cfXuA8B2qZzJTU9wvHU=@vger.kernel.org
X-Received: by 2002:a05:6102:419f:b0:5d5:ff0f:aea1 with SMTP id
 ada2fe7eead31-5d7dd634d15mr5387817137.22.1761117605738; Wed, 22 Oct 2025
 00:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010144231.15773-1-ilpo.jarvinen@linux.intel.com>
 <CAMuHMdVwAkC0XOU_SZ0HeH0+oT-j5SvKyRcFcJbbes624Yu9uQ@mail.gmail.com>
 <89a20c14-dd0f-22ae-d998-da511a94664a@linux.intel.com> <CAMuHMdUbseFEY8AGOxm2T8W-64qT9OSvfmvu+hyTJUT+WE2cVw@mail.gmail.com>
 <20844374-d3df-cc39-a265-44a3008a3bcb@linux.intel.com> <aPerdPErjXANiBOl@smile.fi.intel.com>
In-Reply-To: <aPerdPErjXANiBOl@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Oct 2025 09:19:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWjty_fzRp9r8bet7G_YTwAvGRdW73-uxn7Dp8WsFmEEQ@mail.gmail.com>
X-Gm-Features: AS18NWBTgmWnrLRZQpcXx7nybYEdoprYZTPpfACzWUOBzMWL72E1MPEt5nuaQyU
Message-ID: <CAMuHMdWjty_fzRp9r8bet7G_YTwAvGRdW73-uxn7Dp8WsFmEEQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] PCI & resource: Make coalescing host bridge windows safer
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Rob Herring <robh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tue, 21 Oct 2025 at 17:49, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Oct 21, 2025 at 02:54:03PM +0300, Ilpo J=C3=A4rvinen wrote:
> > The expected result is that those usb resources are properly parented a=
nd
> > the ee080000-ee08ffff and ee090000-ee090bff are not coalesced together =
(as
> > that would destroy information). So something along the lines of:
> >
> >     ee080000-ee08ffff : pci@ee090000
>
> For my pedantic eye, the naming is a bit confusing here. Is this a mistak=
e in
> the code or in the example?
>
> >       ee080000-ee080fff : 0000:00:01.0
> >         ee080000-ee080fff : ohci_hcd
> >       ee081000-ee0810ff : 0000:00:02.0
> >         ee081000-ee0810ff : ehci_hcd
> >     ee090000-ee090bff : ee090000.pci pci@ee090000

A platform device instantiated from DT is named after the node name
and unit address of the corresponding DT node.  If the device has
multiple register banks, all its register banks are still claimed by
the same device, so all but the first (in DT) register bank show a
non-matching address in the device name.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

