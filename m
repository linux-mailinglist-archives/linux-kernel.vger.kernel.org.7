Return-Path: <linux-kernel+bounces-841475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E727ABB76FA
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 18:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A544C4EBF36
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F974A23;
	Fri,  3 Oct 2025 16:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pG5pggDT"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D0F288537
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759507452; cv=none; b=apWECInGAprnWX+LjTWXoHHmme9HNIY03sxgobKORufajWk9DDNXTS7iQ3pSXQiqAD57MwRfPtbI7AJm7NaNzbH27Or4/Meqn+Xc6kCPoLYjq4qG19Axq+DTwLB+sw/AZht1Tsw8LzVQRrVsvBzupn6oJdSNPmIZuEta+tQaHzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759507452; c=relaxed/simple;
	bh=Mllrto1lI0Irl+/LejjLWiH35HKm+L9bOb7k3YgQoI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mOhVryD+XdKTW1lvCIGJKUX7SHSLZ7T2M0co+ygfIUJ6/RJFrkucuBgw2RwgJCWl4h2GAmG7xskPEVLCH2ZCg9YGg3xbKwAGJE8qnwUJUIkVgqamnqvRromWXs3aMYuHdgaYEQXcZkp2vs8Fvfwi4E2JjhSqN8MUOWD4Tekc9II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pG5pggDT; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-367444a3e2aso29572461fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 09:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759507448; x=1760112248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mllrto1lI0Irl+/LejjLWiH35HKm+L9bOb7k3YgQoI4=;
        b=pG5pggDTbkayQAHuailvhLOQaSc7f0QDJZxtRM5Ocgsg5GDVrJBKJYml1uV4MqtlH5
         x6gFylrPQoj14fnjLJtft8eE5mJStAZwpuuG4y1RSgajHoErEk7lTog7+i7P9Fbj8fQC
         v8+iTZRS4yLXZ+yDB2yq/aEZSPImwQ81G3zGAgghEPHumCrqaIp/Pfh1ucyrdvPoaPQO
         HrLFFL/+5zNSBZAWQHOsa2ZF63roT64VPM3vIEZDCiz0GHId6csOem/75byf9Knq0vlU
         +D+WQCfFWe1BGu2weYdIbdpc3cn75jBTgpqIFr64U7Dp6qxvExPMiE4UaTuP2c8o594+
         hoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759507448; x=1760112248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mllrto1lI0Irl+/LejjLWiH35HKm+L9bOb7k3YgQoI4=;
        b=bJZRr0CJ+S5m4YdUo+FG9XL5mTkONxBcLXxU7TGtKEj5jJQPiZ5VY92OQ0h+eYp+t8
         YfPWQM2fF9LrWAoc01Op1gYyGmahHI3H9nHUWvtiGg/5FEcPfeoDxvltdyowxoeBy4IE
         OhG7tu+YQSM6WtWz7+5Or40FNkcHed7UnZQAKEZkNePdzfKWVNcwBPYGQrhHO2zdprHs
         6dU2ZECyAXGYY60wHXOxTVL2q/kTT0s/4saQW5q4mhUxAPAB0kv1O4gd+fFzC5KmRbSs
         mWI7y06fR226HNhqXhCUjJ42oCv6JbUNOwnLKw8M9eBCeYrj2MWBJqr/akvCiKBmqW3/
         NEWw==
X-Forwarded-Encrypted: i=1; AJvYcCWzIqB9exvkhuO4ErgkTlxgiTfLNUXcAEqGTtCziYTnz7c5GWiyebVNTVFAiGIhRZbSLWJ45CaKw9ll7o8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyog37n3AROORwcZe5avcnpNhutjA6+qcxxflr9xS9+RHnhWDhU
	PVX5nCLDUY62AfC/rnR0+N1a1r+bKyStq72fyVr0U4GS63haueWPUMrWUp+Hu/pXqUUkmJ3wmx+
	FaxMfrSXazzAhEIkDu2XlB/Anm4KDjuXKJMQlJEPZ
X-Gm-Gg: ASbGnctpbtbQUu7DY9J5mGsysqcrce+e5QxKFvb+lRkeIEzowxGyQNFwyAwtrGp/j2d
	QoMvhBcrdVb5AFcBoZvKKv10fPiyLcTC3vlnwadc7whvA85xopfneGiNUIIlT2494JVfql86PPD
	soUlkH5UoAzl1eKq6oFA6NSXs5bvNz4/jPcqOZeAl4CiqLVD99y62QWi4+Jljhup/EKm1swKBM1
	OxGrjzzpBegBWs4IZqJr6eR4EYNVDMxXN2ob4JDqbvJaLrY
X-Google-Smtp-Source: AGHT+IGiMd7rKjwQRWLNmQV2ARjJ6CbLBvJ4uJ7+GgX8fPI3wLEN++8hxxM01GxQ22Ve+kjEe3XbnxIJhiOoe+F2QoQ=
X-Received: by 2002:a2e:be20:0:b0:371:fb14:39bb with SMTP id
 38308e7fff4ca-374c36cbf1bmr11636561fa.16.1759507447942; Fri, 03 Oct 2025
 09:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
 <20251002232153.GK3195829@ziepe.ca> <CALzav=cYBmn_t1w2jHicSbnX57whJYD9Cu84KJekL0n2gZxfmw@mail.gmail.com>
 <20251003120358.GL3195829@ziepe.ca>
In-Reply-To: <20251003120358.GL3195829@ziepe.ca>
From: David Matlack <dmatlack@google.com>
Date: Fri, 3 Oct 2025 09:03:36 -0700
X-Gm-Features: AS18NWC303vSFWFcWUMQr9iYimndopgbWOTEn34kaHamJm2L82qyIyCjJfpVv7M
Message-ID: <CALzav=fci3jPft+SXJ6tPG3=jRX7jjJPwnP=zWAb2Sui++vKPw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 5:04=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Oct 02, 2025 at 04:42:17PM -0700, David Matlack wrote:
> > On Thu, Oct 2, 2025 at 4:21=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> > > On Thu, Oct 02, 2025 at 02:31:08PM -0700, David Matlack wrote:
> > > > And we don't care about PF drivers until we get to
> > > > supporting SR-IOV. So the driver callbacks all seem unnecessary at
> > > > this point.
> > >
> > > I guess we will see, but I'm hoping we can get quite far using
> > > vfio-pci as the SRIOV PF driver and don't need to try to get a big PF
> > > in-kernel driver entangled in this.
> >
> > So far we have had to support vfio-pci, pci-pf-stub, and idpf as PF
> > drivers, and nvme looks like it's coming soon :(
>
> How much effort did you put into moving them to vfio though? Hack Hack
> in the kernel is easy, but upstreaming may be very hard :\
>
> Shutting down enough of the PF kernel driver to safely kexec is almost
> the same as unbinding it completely.

I think it's totally fair to tell us to replace pci-pf-stub with
vfio-pci. That gets rid of one PF driver.

idpf cannot be easily replaced with vfio-pci, since the PF is also
used for host networking. Brian Vazquez from Google will be giving a
talk about the idpf support at LPC so we can revisit this topic there.
We took the approach of only preserving the SR-IOV configuration in
the PF, everything else gets reset (so no DMA mapping preservation, no
driver state preservation, etc.).

We haven't looked into nvme yet so we'll have to revisit that discussion la=
ter.

