Return-Path: <linux-kernel+bounces-835085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7801BA636F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 22:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE2617DC7A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 20:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015EC245020;
	Sat, 27 Sep 2025 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K22fpTLa"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEC2367CC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759005818; cv=none; b=r5y+pcT/LKjMaUbU1gipgdeBOH8zKelHwASeUbODEyh9t0DUovX+BfhJMImu6i+wLyJIlNS2to+7sanwVIVE6sc3bWA7uKoOAcglVQo3nN1bir1UZ+ZhWRth9XF/dIjvy1wfvrheikvtUqHnB6Sj4wtN1BOfyWhShdv40KgbXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759005818; c=relaxed/simple;
	bh=UvNClLKNNn9rK6Vik019kICWDMo2uNNhdQgjV8A+LJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiidY5q4nZ0cQnrltDy5eNNAHP8HggvIHcnyeCaKdx2raj3Q54EH09ETisrmoJGfhacq1eRfSI6Wuu/yggifQ6+O46M622LB0y2DhYPaO35AxKdioN5BZNpINy0THjjjgtV17NhiFlT/C8fOHzsqAIMaak2I2re1mhHCRMcNEkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K22fpTLa; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5a0d17db499so2610993137.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759005815; x=1759610615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvNClLKNNn9rK6Vik019kICWDMo2uNNhdQgjV8A+LJY=;
        b=K22fpTLatFi/dMxj6c5ySccFKPGDsAEOSFkFOz56xgmFc8VZ0fZOrMQDIsxIvhHRyt
         IN8flJWiaIWvrNNY76FPIAb0V0Ps5SA1mZzDmIOm+l9yR2pYrxY/Dy0jMp0oaIlx1Zzm
         h3UUsdpQTvXKKabaGBe4Z7z5txzK3j9AmN4Q7pHAuBuFq3jiH1DseXAtOyKDy1ynamxh
         23RrlJwIgP8pzouL3uXZVFxtuKUh8DLudMsTezjQTKTHlR09TltfvCzmlUA6OKASjPxI
         x+6l1jU3UhpL9L+Bzfz97RYHPRHZ5hcqLy2GwBvfjU1nzhxisE1YTL2scYBZeJe3SVK9
         +aFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759005815; x=1759610615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvNClLKNNn9rK6Vik019kICWDMo2uNNhdQgjV8A+LJY=;
        b=FCZO3YE0e6cmOPQaalZodqkjt5gyPMytU+kga4vnx/t9t54aMO1/nIoSJgWh8NHHyn
         zL+ljTrUU2oZW7Bh1qc0RigUxSB4yVhKdWmbIsz9mgxn4MGzoIS5YGdzdySq3xJTQTRK
         jDPR5gSBSEMnZtLoJ8Gb4XYijN4l/n3HlGGOohTaY8IR6lHVlUKEDfLoBmRJ3B96DCYX
         L4c2boJ03e/a0u92dhh/2ALICeO9WeQZstWr/TrkQif5osB9cn5USuaUV0U3b5UVg/Pc
         /AkqLV+wFBxMhSn6VroZrB9Xp+gU9YwGBqP5RaM/jNDXaj5LrJuYPud/vwhdsgVYYx6D
         bnrw==
X-Forwarded-Encrypted: i=1; AJvYcCVAq7SBDGzO/OqGJ5mA/0Q1Vtd/mJll+9C2fN8jL7BeYhOmlYAUPuhzFbZr3jyyEgQ+b5oRVBDPInw6BaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Hz2aWD3MiCfz3Gj2g6RGlzs4vIsY5R8CLQAgbVxVcs9eFfx0
	QdwN2osZV3JmBTS49VN6c9yFGtUIqwO6NAolexXBWc5pEUkFMSjc1lJoNe/7tllGs4N357sWJGq
	DiMX9VsUUhOES0yLyfzykfSI0Tm8jw+k=
X-Gm-Gg: ASbGnctF2XWmuWJWDRuALk8AtqC2zGkbFzmcf/zsvoANX1y4Q2xBbREDxBsz8p6Vnmt
	/mVFymUOMundtFZrCiMm3g8/F4vCE5S4r4Ptvjy/P0e3T+5BxYdqjIL+oz1jhWqanb8WWT+F5cX
	7NT3bxuwuiEs81Ntr26ad6TTt96CKagYhiFwUvrhR3wRXMX7ETe9lRUEs2Pg8g0zJjSEkR2BV9p
	mWtnvoMHzvzz9xZxk8BRS4dVV5ImSU0Qissw4/c
X-Google-Smtp-Source: AGHT+IGYQ8cZXq6p06Ik0TDBdufn7B3v54OBWxKvQ9AFYTgNeyye8BPJ3qw2CKkk7AUAcaDd0Kb3KEG7ImktB5zLhBw=
X-Received: by 2002:a05:6102:2924:b0:52d:1b06:5e34 with SMTP id
 ada2fe7eead31-5b2826795b7mr3196814137.10.1759005815440; Sat, 27 Sep 2025
 13:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org> <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>
 <aNZh3uDdORZ5mfSD@kernel.org>
In-Reply-To: <aNZh3uDdORZ5mfSD@kernel.org>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sat, 27 Sep 2025 13:43:23 -0700
X-Gm-Features: AS18NWBZ4NYpS8oIgxtkL6K4jFZHcC-C1DNvJN4aikZTVbjqp7kQjMuXYe8nY8M
Message-ID: <CAM_iQpWXFQwtayT7Zv7iJd7zQZ=rX_P1ZK2P11-6ohRhLpg7Xw@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 2:50=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed, Sep 24, 2025 at 11:39:44AM -0700, Cong Wang wrote:
> > On Wed, Sep 24, 2025 at 10:51=E2=80=AFAM Christoph Lameter (Ampere)
> > <cl@gentwo.org> wrote:
> > > AFAICT various contemporary Android deployments do the multiple kerne=
l
> > > approach in one way or another already for security purposes and for
> > > specialized controllers. However, the multi kernel approaches are oft=
en
> > > depending on specialized and dedicated hardware. It may be difficult =
to
> > > support with a generic approach developed here.
> >
> > You are right, the multikernel concept is indeed pretty old, the Barrel=
Fish
> > OS was invented in around 2009. Jailhouse was released 12 years ago.
> > There are tons of papers in this area too.
>
> Jailhouse is quite nice actually. Perhaps you should pick that up
> instead, and start refining and improving it? I'd be interested to test
> refined jailhouse patches. It's also easy build test images having the
> feature both with BuildRoot and Yocto.

Static partitioning is not a bad choice, except it is less flexible. We can=
't
get dynamic resource allocation with just static partitioning, but we can
easily get static partitioning with dynamic allocation, in fact, it should =
be
the default case.

In my own opinion, the reason why containers today are more popular
than VM's is not just performance, it is elasticity too. Static partitionin=
g
is essentially against elasticity.

More fundamentally, it is based on VMCS, which essentially requires
a hypervisor:
https://github.com/siemens/jailhouse/blob/master/hypervisor/control.c

>
> It would take me like half'ish day to create build target for it.
>
> > Dual-kernel systems, whether using virtualization or firmware, are inde=
ed
> > common at least for automotives today. This is a solid justification of=
 its
> > usefulness and real-world practice.
>
> OK so neither virtualization nor firmware are well defined here.
> Firmware e.g. can mean anything fro pre-bootloader to full operating
> system depending on context or who you ask.
>
> It's also pretty hard to project why VMs are bad for cars, and
> despite lacking experience with building operating systems for
> cars, I'd like to believe that the hardware enforcement that VT-x
> and VT-d type of technologies bring is actually great for cars.
>
> It's like every other infosec con where someone is hacking a car,
> and I seen even people who've participated to hackatons by car
> manufacturers. That industry is improving gradually and the
> challenge would be to create hard evidence that this brings
> better isolation than VM based solutions..

In case it is still not clear: No one wants to stop you from using a
VM. In fact, at least in theory, you could use a VM inside a multikernel.
Just like today we can still run a container in a VM (Kata Container).

Your choice is always on the table.

I hope this helps.

Regards,
Cong Wang

