Return-Path: <linux-kernel+bounces-795011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34480B3EBCA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC02174392
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0076C2DF15F;
	Mon,  1 Sep 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oIBPQkem"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E68F2EC0B0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742500; cv=none; b=bJU/RXesNZkOvZ2dVEE31p74RGLfiJhOfoDGV9bg7SsruDyONvCP1+cFZ56XHo77gVBaxmZiF2Bfxy1Hn5soivfD8XjwspBd5zjFDRAZfNQk6vh/yF+TDaziHszDfTENAhh31xHnlPivf2taHtw5z4H4NVd+C8mwNocAZFwWXuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742500; c=relaxed/simple;
	bh=8TyjAR1n0XSfbG60TdTWK/jacRRmZXapnaL2IGz/6Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMumwHFZ+tlgumIWvVhqLxYm+dL73jR+ks185a1nkH8dzoPxUoxOvEWEdEUnlrliTs8GGhmlqxowcMD3TblJJfPRmltNt8sesq9d1OkrmGHaiQK2442mJMY9Wv9O0YEhvdmPJfH8rTsT3f+Gji5SPezWxZuBIn5NIBZ/GPMmHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oIBPQkem; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-618660b684fso14243a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756742497; x=1757347297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZe1rDSyUDwGrcf6JDGl9NSkofhGepazU+Zm8DpoTMU=;
        b=oIBPQkem/eVPKJ1Zjg/1p8LFqeN/u8T0aMSa5O5IOlCq3YJtIPzeCjNXHdFCxbJFM8
         w0gNLW35a+syGJ1D8T2wh3ORVNkNOe5gtCNGbnSynicyIZ4n9d1Q6RcgyWDXfkbIkkLz
         57Vf7Re+Ltz79H8Uxtdlrf8ka0k0TKosb0O9BZreMq+1s5TEvSOrrrY0af4/EfUV97CF
         Jpc0g8ef0u6m8aM6Eo05mUyM5tMNrd1fUSOjtE1lTXpNk7OQ3eTG157rXnkFXnYFdUtT
         QD3gRuI70ZZYQwfB+azOwLq/vAyFzH4o/YDnapNOZ5rZlRbu09BdAtF1R/sxXhuLNSAv
         nlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756742497; x=1757347297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZe1rDSyUDwGrcf6JDGl9NSkofhGepazU+Zm8DpoTMU=;
        b=j6WnSerwY3zngn56EVuUfNAFURjfQPwO6Z+W5tSpq64EWjGC3EAooVIJfhLqnaFjv1
         SZDs5qMUnW3+x2Bf0K7GuZGxfCZoOHRpnVLwYQ7+H6ir3rkmvmCexFO/1ypGbhwhZoko
         QeqN10lDnuuv/maUJvNPmImpfxaQc5Mp5SI/J2M/Td4tvCPgzO8wLpULt5kZTuxbywtW
         ANnwOZH/m6bJ9a4a+HRcjQao3l3ZghaqENsi1br1LWqIx+iZytlvRxXdNqKopGjsuZR8
         /CS5OValycEejC6LHRzTMbXFjzICSx6QQDxHetakQ9aNiHg35BBKdNsLQlsP50gauXz0
         XtLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqfwj1x+VBv76srtsf0rBsiNVwDiZne+Y2LdJLpCchEAjdPkYXduK7EU99aA1lfGwjJRbHjtXBCKm1iqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwTymH26CwsdsCSR1NA9rI3RPl/aLpf2NrawcF+OtQ9v8TyIe2
	BlUPwCbs9zdDWv03E4ZWUo0v2izYCUWRFJJb3+F3y/fOe8B2+IY/DWLOwWnyAdk8+6RQjvM/XCx
	t6J4H4jEQyqPogTBRTMFTNO+9iZFR03HCiWHgHSu+
X-Gm-Gg: ASbGnctYI0zAsawE2+TbW6qUZxLDx/vYt3fQt3x4cytFrXNDVkRygk+7pNw37B8yJa/
	IZxMnM83iBW8Acirq5BWRLI5o89uJgiD7D0aECeEKsjmuRxnn4uLgvI1sJi//cK0cKA0UG0Vo9d
	d/RGK/g/p1/i5eLalRYPEFrk1DSMuS8jeLwTqbmd2OrAkITOfEGOYTQ1bMRjs7jS7+cg9W5ldAe
	tJpmxQqmJNgo4xhDlD255eSFCScnhNsHUkFmsMBgcEvZ7PFCdAD
X-Google-Smtp-Source: AGHT+IFBPjo7BYjYjXhGo6U2wXlVhFIeOC8a9cufcwphz6VE6bbVgfUe4VeQNXzBXooQi/RcCrbbTira2IpHTqtwCBw=
X-Received: by 2002:a05:6402:2898:b0:61c:32fb:999b with SMTP id
 4fb4d7f45d1cf-61d21c8e8f7mr134455a12.1.1756742496601; Mon, 01 Sep 2025
 09:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826080430.1952982-1-rppt@kernel.org> <20250826080430.1952982-2-rppt@kernel.org>
 <68b0f8a31a2b8_293b3294ae@iweiny-mobl.notmuch> <aLFdVX4eXrDnDD25@kernel.org>
In-Reply-To: <aLFdVX4eXrDnDD25@kernel.org>
From: =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Date: Mon, 1 Sep 2025 18:01:25 +0200
X-Gm-Features: Ac12FXzkGAkQY2x4K6zNLnLOx6A5Qe40b6_I_CpXPyMEmRkQBFx8GaoL9LPzUlo
Message-ID: <CAAi7L5eWB33dKTuNQ26Dtna9fq2ihiVCP_4NoTFjmFFrJzWtGQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] nvdimm: allow exposing RAM carveouts as NVDIMM DIMM devices
To: Mike Rapoport <rppt@kernel.org>
Cc: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, jane.chu@oracle.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Tyler Hicks <code@tyhicks.com>, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 9:57=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi Ira,
>
> On Thu, Aug 28, 2025 at 07:47:31PM -0500, Ira Weiny wrote:
> > + Michal
> >
> > Mike Rapoport wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > >
> > > There are use cases, for example virtual machine hosts, that create
> > > "persistent" memory regions using memmap=3D option on x86 or dummy
> > > pmem-region device tree nodes on DT based systems.
> > >
> > > Both these options are inflexible because they create static regions =
and
> > > the layout of the "persistent" memory cannot be adjusted without rebo=
ot
> > > and sometimes they even require firmware update.
> > >
> > > Add a ramdax driver that allows creation of DIMM devices on top of
> > > E820_TYPE_PRAM regions and devicetree pmem-region nodes.
> >
> > While I recognize this driver and the e820 driver are mutually
> > exclusive[1][2].  I do wonder if the use cases are the same?
>
> They are mutually exclusive in the sense that they cannot be loaded
> together so I had this in Kconfig in RFC posting
>
> config RAMDAX
>         tristate "Support persistent memory interfaces on RAM carveouts"
>         depends on OF || (X86 && X86_PMEM_LEGACY=3Dn)
>
> (somehow my rebase lost Makefile and Kconfig changes :( )
>
> As Pasha said in the other thread [1] the use-cases are different. My goa=
l
> is to achieve flexibility in managing carved out "PMEM" regions and
> Michal's patches aim to optimize boot time by autoconfiguring multiple PM=
EM
> regions in the kernel without upcalls to ndctl.
>
> > From a high level I don't like the idea of adding kernel parameters.  S=
o
> > if this could solve Michal's problem I'm inclined to go this direction.
>
> I think it could help with optimizing the reboot times. On the first boot
> the PMEM is partitioned using ndctl and then the partitioning remains the=
re
> so that on subsequent reboots kernel recreates dax devices without upcall=
s
> to userspace.

Using this patch, if I want to divide 500GB of memory into 1GB chunks,
the last 128kB of every chunk would be taken by the label, right?

My patch disables labels, so we can divide the memory into 1GB chunks
without any losses and they all remain aligned to the 1GB boundary. I
think this is necessary for vmemmap dax optimization.

> [1] https://lore.kernel.org/all/CA+CK2bAPJR00j3eFZtF7WgvgXuqmmOtqjc8xO70b=
GyQUSKTKGg@mail.gmail.com/

