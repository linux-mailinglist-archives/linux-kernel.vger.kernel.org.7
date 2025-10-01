Return-Path: <linux-kernel+bounces-839026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 495A8BB0A99
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B271C4496
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248053019DE;
	Wed,  1 Oct 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sNbyUGSh"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F503019D1
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328081; cv=none; b=S1ro1mV1xvUun3fIhyKGqYqcZvuB8Fnaz3WtHDjqq9r3ZTITQvAfpK25ei6wyklj4xgaqlzG7PqCqq7OjMDWdEVAv0nYeL93Dw4q5EKIRN363wB6SCRpbPrIz4E75sDw+RpgXV3GYaT0/fNepNhQl1McQhyuZsBLd6qptvCPLwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328081; c=relaxed/simple;
	bh=9vQ0s5TSz4F/i9sWmzsWBCk5peeVLVaS+98xFNDePoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgmKe6rwMFk43VUxiquogF8bJZx7M++Wtd4NUs+94dhTp1aZjBGxdo263ubS2z+3k6EPl37bb/Qs2/bSKVUgUSl0KetrMWhxKfjRY5UgKZKoVFgJ8TVmWsY//bM0XM11315qnFsOBT39tTrvLkiSRxulpiX4+0BoBWzlsgmNNF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sNbyUGSh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62fa84c6916so12888a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759328078; x=1759932878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vQ0s5TSz4F/i9sWmzsWBCk5peeVLVaS+98xFNDePoU=;
        b=sNbyUGShHvwGW2T2gpyIe5sCzkD3/m0uolGdrHmNloiP2UEMNoL4Av2AYWsvMTvQRA
         RtZa7fsGom8wjwnsC1XMZWQFurLPCzWi+YSeb/bybg/xMACD4IJi8fJlgEVpSalkUaOf
         xyQzF2c4liGgPNFwWR18gIwqIF0WC9hG3cXQar1jLOGK/qVjPkXp85XRP2rsm4ReM4Kc
         jGY3EaabujOU6S7ptYT9+7kIV+g4LEr0+DLubFLWtgJxuKHMfMZakYxL/A9HD+H+7+x3
         1E1P9zK1BU+0HrMW3tdZ/6QhlNXTt2tmu4cpT51G6tmdJPjNTSiAQUIvz2wX0V089j0U
         Qp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759328078; x=1759932878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vQ0s5TSz4F/i9sWmzsWBCk5peeVLVaS+98xFNDePoU=;
        b=w7znO0rXq6PXspbScb1B8nImy6Ug/uu2sbANj1rhTu3/MwxeeCJzHy7zEJ8+hLPRfY
         Y5jTQm4bjXoQPR/+imy/HfgcnCZZhzXu7wfkDnJd/1iLh92lttgzbRb4My5beMJU3ptq
         9Chr9q4TWnEvg0GOfndQpXekIgtUofDsgKu27NJFe1TGeZcFe2/bJBx9lo1EHOeTO01v
         194fbz9B6hgDO0ysIrn21/VBQ/V4iCuYSSgtza0RNZcWGaTofYUmernpE4g2sum9EXkw
         ZBRIvc3nGQGkGyZ1pAS375GA9oYGx9KUH4ay9T/ocElVN4BBfbidT29CjuHBFkwyK43Z
         hz5g==
X-Forwarded-Encrypted: i=1; AJvYcCXnKrlmia6jKnydm9QmRHoruMr4sTKu4jYEi/hR1Gfvdd+wxFiugZyuqlvWnVCEW6b3FrEnpoFd/dOT3gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0UF6CN804hYgkems5cOWciiCzt97kYSEF0B8os0/mcZRZj0Sg
	I6K5VwxKAY+AJx7rlCrxi+Vr2Disjfja61w3Zh9fqv+/EKU85uTJEgqSEOF+3OPml+X+TRqqB7+
	7W/X+qrL/ZwKTz0IrBnUskitHOst47HzXwZ4nBfYX
X-Gm-Gg: ASbGnctC7BrfyDyW/CiQ1NRX8Ks5gPwarnlmAqWhkxOnHZGetyZzFqffDkjJ35HbLJu
	UOVjFWazcTwjo6LkDy8PxJQTIP1hSCG2vY9OJ7PzRUv863D/gNfAD+bcrrsOdNdbwyA+4Of1URf
	68xsr9Om9im8v2fEtlYNbN0RxZ6Yk4TX8UvODE+IHammkwZjn9xsdZrjQZwLkidHl+EVHhODyZt
	9zyBzVYrbRwO+I861z9bca0i1HWZcDfLAKlxbqAsnYoZ6Q=
X-Google-Smtp-Source: AGHT+IGLqBhZz9+YDBmHWDIUabLIii5/VOwZTZuOaZRis96QbRJZ2sPZIrasutvFneCIM0zZ8r7cSIgyUQkuL8zq+VM=
X-Received: by 2002:a50:c013:0:b0:634:38d4:410a with SMTP id
 4fb4d7f45d1cf-6367abc802amr115922a12.2.1759328077633; Wed, 01 Oct 2025
 07:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826080430.1952982-1-rppt@kernel.org> <20250826080430.1952982-2-rppt@kernel.org>
 <68b0f8a31a2b8_293b3294ae@iweiny-mobl.notmuch> <aLFdVX4eXrDnDD25@kernel.org>
 <CAAi7L5eWB33dKTuNQ26Dtna9fq2ihiVCP_4NoTFjmFFrJzWtGQ@mail.gmail.com>
 <68d3465541f82_105201005@dwillia2-mobl4.notmuch> <CAAi7L5esz-vxbbP-4ay-cCfc1osXLkvGDx5thijuBXFBQNwiug@mail.gmail.com>
 <68d6df3f410de_1052010059@dwillia2-mobl4.notmuch>
In-Reply-To: <68d6df3f410de_1052010059@dwillia2-mobl4.notmuch>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Wed, 1 Oct 2025 16:14:25 +0200
X-Gm-Features: AS18NWAplYwA8ED2wnxbfS84xFerjfMylcSyDTOVR-xhJ4A_vsirR904uGdHDpQ
Message-ID: <CAAi7L5dWpzfodg3J4QqGP564qDnLmqPCKHJ-1BTmzwMUhz6rLg@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvdimm: allow exposing RAM carveouts as NVDIMM DIMM devices
To: dan.j.williams@intel.com
Cc: Mike Rapoport <rppt@kernel.org>, Ira Weiny <ira.weiny@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, jane.chu@oracle.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Tyler Hicks <code@tyhicks.com>, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 8:45=E2=80=AFPM <dan.j.williams@intel.com> wrote:
>
> Micha=C5=82 C=C5=82api=C5=84ski wrote:
> [..]
> > > As Mike says you would lose 128K at the end, but that indeed becomes
> > > losing that 1GB given alignment constraints.
> > >
> > > However, I think that could be solved by just separately vmalloc'ing =
the
> > > label space for this. Then instead of kernel parameters to sub-divide=
 a
> > > region, you just have an initramfs script to do the same.
> > >
> > > Does that meet your needs?
> >
> > Sorry, I'm having trouble imagining this.
> > If I wanted 500 1GB chunks, I would request a region of 500GB+space
> > for the label? Or is that a label and info-blocks?
>
> You would specify an memmap=3D range of 500GB+128K*.
>
> Force attach that range to Mike's RAMDAX driver.
>
> [ modprobe -r nd_e820, don't build nd_820, or modprobe policy blocks nd_e=
820 ]
> echo ramdax > /sys/bus/platform/devices/e820_pmem/driver_override
> echo e820_pmem > /sys/bus/platform/drivers/ramdax
>
> * forget what I said about vmalloc() previously, not needed
>
> > Then on each boot the kernel would check if there is an actual
> > label/info-blocks in that space and if yes, it would recreate my
> > devices (including the fsdax/devdax type)?
>
> Right, if that range is persistent the kernel would automatically parse
> the label space each boot and divide up the 500GB region space into
> namespaces.
>
> 128K of label spaces gives you 509 potential namespaces.

That's not enough for us. We would need ~1 order of magnitude more.
Sorry I'm being vague about this but I can't discuss the actual
machine sizes.

> > One of the requirements for live update is that the kexec reboot has
> > to be fast. My solution introduced a delay of tens of milliseconds
> > since the actual device creation is asynchronous. Manually dividing a
> > region into thousands of devices from userspace would be very slow but
>
> Wait, 500GB Region / 1GB Namespace =3D thousands of Namespaces?

I was talking about devices and AFAIK 1 namespace equals 5 devices for
us currently (nd/{namespace, pfn, btt, dax}, dax/dax). Though the
device creation is asynchronous so I guess the actual device count is
not important.

> > I would have to do that only on the first boot, right?
>
> Yes, the expectation is only incur that overhead once. It also allows
> for VMs to be able to lookup their capacity by name. So you do not need
> a separate mapping of 1GB Namepsace blocks to VMs. Just give some VMs
> bigger Namespaces than others by name.

Sure, I can do that at first. But after some time fragmentation will
happen, right? At some point I will have to give VMs a bunch of
smaller namespaces here and there.

Btw. one more thing I don't understand. Why are maintainers so much
against adding new kernel parameters?

