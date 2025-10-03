Return-Path: <linux-kernel+bounces-841548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3656FBB7A13
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0824A0974
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3702D46A1;
	Fri,  3 Oct 2025 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyIpRZ10"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCAD2D46AF
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510635; cv=none; b=QeP5ywVyHRE2RbVDWSO6TC8zhxB28aTXEWLSBMQ4tWB8JKZxA3nvpL2i+/tXCRkLBH89mlh6F+gkQjiZuxVhLv4Aw3zOCY2n+jxyiy8JbnWlukt+MAW5TzNwsvdaqMIzrCmmGGWOC5Li8dQaDkps5zw4lnTb3Om+oT/UJbTQo84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510635; c=relaxed/simple;
	bh=fhtGb8MKf0acPfP7W+qYvuGjDAQFV/6NeqY3BWv6/q8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nUqfm6CSaysKJyQokQuX+ncXAUu41TzBkQl5A61HMiIOigO+VhO77GWfADMEZ13mz32lZrS4HNi61knMeVVqCw52nMlFMOuMwpxUJgryCdzMW4167SSZJk/E5QB6V25GpPAwFRo8i+0E7DD4cZ5eao04aHqAao7Hg0oJ3FW2sMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyIpRZ10; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-36bf096b092so7140931fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759510632; x=1760115432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhtGb8MKf0acPfP7W+qYvuGjDAQFV/6NeqY3BWv6/q8=;
        b=WyIpRZ10LdSclUQ8BdebSdYqLgOQ3eTHafYx0s/J+Kt7ysDDbj9dtN1qOuye1XNGdH
         UCdpg7qDKeHmV+LbkcztEttYXPUrckY3DKoAApTBtgTlaFD1zI7tXMlj2/SWJDJKr7oo
         Yf4tgc5MSJ2aakoZqx83xODWvAzWpkNaPp5uxTSSN0DxWFuz4IbROtU3cqcyB8t2+hdU
         ZbuYD/YhP832Jp3e5+bKkHQ1eiZWEGGK32d+BjB5a0FkQFN6PFoP8X52riru3mdvG6XH
         hMMtaMr8WFYH4PyGcu+sPCcM/Xx6hJ1kjAhO00Nb2q9VM2I5oknDlnkzJETofbciIuB0
         cM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510632; x=1760115432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhtGb8MKf0acPfP7W+qYvuGjDAQFV/6NeqY3BWv6/q8=;
        b=lBaSSGE+3AeZYtRPkWiGpTr/KaHNSktGJQXy7xWmbBOKDvAErfMZn7xE+HD6ri/HSS
         oet4cJuQK5gyoaq0nLVpt3edk8SNK8uy/2tA3o3z/drlQnEEcDoVHXWZtUhEYzquSal/
         Y7/9hL2CC7FKLz6Dl2+jjl6j1FlA9lry/pQufXeYeRg+RXzPW3xPSbZHh+D2P2bq/vko
         IGlMCf5JY5o2os4FEDQFwqCI50pstxKEyDY6S/3vXpnkjHbdXp2Fk+JAg9/EA83+sT0Y
         9th07NMojtPtoU2yxqTevANOcMnCBgC/e2M2KwpJCN3MUEkjMc4m1JR8yx3jFsFE8azZ
         cuKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyjmdf+f14BgsOmi5oRQqQeQ3Su2thGbXX3/fQ5Mc+mvVa2Ify4qh15uxdEAR3/WVsB6K+DODTv7sH5XY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7qxEa0BZViwRHNOH/5luW2jmqblMyh9ewChfznR036QPboZQM
	kVRw5ZwBDiFofFKPHPRKvTD26DuYuoll7mPrpWo4tjs3YFzLxMQ3OGakTFTojJ3ENrLVftkUDHj
	C5JCrQw89XGogKzhe+ZA0AYG0Re5vQvsmT4AhfKVQ
X-Gm-Gg: ASbGncu4lMtRnFi9IHR3kZFBldTJY5RHjhCykRYUufZ+wQ6XKP8Wn1+yiwQNBA65TCH
	kys1nt7XuqcZEE2a+hHYYuPyqdpDqW0HEESkA+QuDFF5syg6xDCk4+sekfkV0KojgAN2oCOIkrF
	Nk09Jspf9lfKXoEGZ54sv0A1chA+ytP8eU4eIwxjwf2fOViEyjxFsNHpsfjsX+hsJHIaWaehUfo
	q6IymjdljFW1j2EMzSsYnbisdXZq5Mg0HamoD/ZIjeW+WRtIA9jbMmFKy0=
X-Google-Smtp-Source: AGHT+IHx4msmP8R5V9b/xox6XRZLBn0CUiuZpFE8vOZ7vDw17w2ogkYyO9PNCJUCLBBZcfaX3qrzD8wpS9Karp2Eb1U=
X-Received: by 2002:a2e:bc0b:0:b0:368:2cf8:5121 with SMTP id
 38308e7fff4ca-374c37e9321mr11855241fa.27.1759510631679; Fri, 03 Oct 2025
 09:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929174831.GJ2695987@ziepe.ca> <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
 <20251002232153.GK3195829@ziepe.ca> <CALzav=cYBmn_t1w2jHicSbnX57whJYD9Cu84KJekL0n2gZxfmw@mail.gmail.com>
 <20251003120358.GL3195829@ziepe.ca> <CALzav=fci3jPft+SXJ6tPG3=jRX7jjJPwnP=zWAb2Sui++vKPw@mail.gmail.com>
 <20251003161642.GQ3195829@ziepe.ca> <CA+CK2bBLuGAMwVgj87p_H12P9yy6J99WwX8vwZbFfY0RTYsXDA@mail.gmail.com>
In-Reply-To: <CA+CK2bBLuGAMwVgj87p_H12P9yy6J99WwX8vwZbFfY0RTYsXDA@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 3 Oct 2025 09:56:44 -0700
X-Gm-Features: AS18NWCIcQQViHOaxbODIYnXboXPFcH0JzxYcP4VPxMerxQhIMypGFFdK4P9F68
Message-ID: <CALzav=c9wJvN2Hy+XNjZfmKFEPomTyMBVfCXQ4601_CtN7SXfw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 9:28=E2=80=AFAM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> On Fri, Oct 3, 2025 at 12:16=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wr=
ote:
> >
> > On Fri, Oct 03, 2025 at 09:03:36AM -0700, David Matlack wrote:
> > > > Shutting down enough of the PF kernel driver to safely kexec is alm=
ost
> > > > the same as unbinding it completely.
> > >
> > > I think it's totally fair to tell us to replace pci-pf-stub with
> > > vfio-pci. That gets rid of one PF driver.
> > >
> > > idpf cannot be easily replaced with vfio-pci, since the PF is also
> > > used for host networking.
> >
> > Run host networking on a VF instead?
>
> There is a plan for this, but not immediately. In upstream, I suspect
> vfio-pci is all we need, and other drivers can be added when it really
> necessary.

Sounds good to me.

