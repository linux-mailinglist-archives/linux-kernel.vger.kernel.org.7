Return-Path: <linux-kernel+bounces-820893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B31E4B7FD05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A2B63588
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9130637C0FC;
	Wed, 17 Sep 2025 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtTJ71C2"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6197332A5C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116732; cv=none; b=htxCRQpv18lh5zxBhQbOz9JD3P4oxuAp3gB0/NJtaMgjwO95F5idAphvxCqSYBGZoB2GM7aHf+YM3OxZNT+i0nugbyKMIrxVjJk5wgZLkc+tFdlbTEkQdPB4fFM2eCwMjJXMpJVPJjXHQ0KHRC7MXSAmGmM+2uekL4pCvwvQszY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116732; c=relaxed/simple;
	bh=4rCjPUqBe5hDzKQsNZsZO0Si8lwcnSgwqoA91a8w/qA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMY9ZkWU7q5U5ZHtgwZADpg6129I/yjdjROvGho//+QOS2vZSmEI/ZyQlUf1aOadXhJHxxAdQtDYud6RGU/Q3shRvAd4HskXa9t92Z2V3jsbTb3U9FxFdVnNGMGAQE8cnP0GZQ0laUAFgmOm8yvYDUD7qWtfmbo4iAKK18Sam+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtTJ71C2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07883a5feeso1158434466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758116729; x=1758721529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rCjPUqBe5hDzKQsNZsZO0Si8lwcnSgwqoA91a8w/qA=;
        b=OtTJ71C2+f60SZTiEhIWHBQ4o7kLP6xIlRwXDOQmyb2tfI7Ixqe3jdodyDCZ6I/pci
         VrYugBtsM39gl26uU6q8zCgyF3duHSoLIBD9gl91+nd7Px5uTUgcH93KyfqjILZ45oob
         2hyQT1b5NVbgDk8Otqi+IB+ja1semJyZPKvQsfEAC7hIng7aXqM1XAr15ts6n9oJs0l/
         gNxXp4EOLAnzzRWO/qH2GU7yPe4BIjcYQBgQAwknAMvNqZL7IxAeaJvAQQmxzrM6U+58
         Kh1khv7J8EK+n1DRN18PQrohtPa6NfRFhGUeWL6KmBB8uCPW5EUPeAG+sA/Av8BLTks9
         vfxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116729; x=1758721529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4rCjPUqBe5hDzKQsNZsZO0Si8lwcnSgwqoA91a8w/qA=;
        b=sFFlGCvLh7+cJrPm+ZTJgTqyx+5cJWZeZipmXyaSqTY35y+KkRlQwh5VlsZyDNqaBy
         IQLA51eC12sC9jj7nVRkDzAjnxrjQ883ZfeJDk3Mo222qZAQoaGHtWIBZSya4wWUOzVx
         779P1V5W740c3h4mB/J2Xh1E0BBPOwRwIprFFKR0VpLcKI18sRgibzA1NceHECBp77vK
         uIskzkkmxVfoR1OW2ivwfpcvJs1IUGPVawtslImuEUViXhTJGdJhK/u6XSPTDTixsIpW
         UuqfDfuXDia0KYMypksZkoJRzb9e5kI1ZfeopqDMiXkJThDan0JKFDOcR8goraRGUyxv
         zuxw==
X-Forwarded-Encrypted: i=1; AJvYcCUWWjVwrgknsR22aPFBwT3hFvFuEWepk9foHBl3Fuci0oXtYQeV29hpkNCLB8MwNn5UQlR//j0gXVSz20w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFdJM21qbH7hvN6wHpiyvY/rMcVgSkRn8jlEAFEDU6FSHXF6s/
	dDQepCeYCcsc6fMLMxWrwF44QB49p2/vukDXmV8oXmdAJFJS9yss+I4PGNlhbtCe4tXY3Jv/H9+
	El72Cgv75OZuHX6kgVPn95spm3Rkff2E=
X-Gm-Gg: ASbGncuEDc7mMJ39UkYelCUUtVAEOoVbMsaIFVHssqQFymWM4yNC5enxm6392lfQQT6
	+T/Gmo80vNTfbbgnC4uv/Kg+lHAJrzJ8DIYpbTLwDhA1jozEZ3tcdioOmaHd4scsZrEZL9B+OYr
	In9OriLu4vF7ntDlqIh5++cjCGcg9BPR0CftCfTAypvHktyTtRSbeRzF6u9U6JGfP68B10h/eWL
	htyfrrs2UNcD0QIQFQJuGsJd6TTa1IHTccdRMHP8/boWQICXg==
X-Google-Smtp-Source: AGHT+IHJjSAqFzQR7vsvzpBHIle/SM7pkbfcfwBMTr+P1896d+alN/SQihemXVKbkiSRCNaNWJtZu6qP46KZEuNFGWc=
X-Received: by 2002:a17:907:3c8b:b0:b04:aadd:b8d7 with SMTP id
 a640c23a62f3a-b1bb5e56d85mr276690166b.13.1758116728681; Wed, 17 Sep 2025
 06:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917124404.2207918-1-max.kellermann@ionos.com>
 <CAGudoHHSpP_x8MN5wS+e6Ea9UhOfF0PHii=hAx9XwFLbv2EJsg@mail.gmail.com> <CAKPOu+9nLUhtVBuMtsTP=7cUR29kY01VedUvzo=GMRez0ZX9rw@mail.gmail.com>
In-Reply-To: <CAKPOu+9nLUhtVBuMtsTP=7cUR29kY01VedUvzo=GMRez0ZX9rw@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 15:45:16 +0200
X-Gm-Features: AS18NWBMJGX1M7gmLnyGCZI8UTIw8c6hYUtKDGdB2cO4qtZ9mDWgO1MIhRf_XYA
Message-ID: <CAGudoHEhvNyQhHG516a6R+vz3b69d-5dCU=_8JpXdRdGnGsjew@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix deadlock bugs by making iput() calls asynchronous
To: Max Kellermann <max.kellermann@ionos.com>
Cc: slava.dubeyko@ibm.com, xiubli@redhat.com, idryomov@gmail.com, 
	amarkuze@redhat.com, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:39=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Wed, Sep 17, 2025 at 3:14=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> > Does the patch convert literally all iput calls within ceph into the
> > async variant? I would be worried that mandatory deferral of literally
> > all final iputs may be a regression from perf standpoint.
>

ok, in that case i have no further commentary

> I don't think this affects performance at all. It almost never happens
> that the last reference gets dropped by somebody other than dcache
> (which only happens under memory pressure).

Well only changing the problematic consumers as opposed *everyone*
should be the end of it.

> (Forgot to reply to this part)
> No, I changed just the ones that are called from Writeback+Messenger.
>
> I don't think this affects performance at all. It almost never happens
> that the last reference gets dropped by somebody other than dcache
> (which only happens under memory pressure).
> It was very difficult to reproduce this bug:
> - "echo 2 >drop_caches" in a loop
> - a kernel patch that adds msleep() to several functions
> - another kernel patch that allows me to disconnect the Ceph server via i=
octl
> The latter was to free inode references that are held by Ceph caps.
> For this deadlock to occur, all references other than
> writeback/messenger must be gone already.
> (It did happen on our production servers, crashing all of them a few
> days ago causing a major service outage, but apparently in all these
> years we're the first ones to observe this deadlock bug.)
>

This makes sense to me.

The VFS layer is hopefully going to get significantly better assert
coverage, so I expect this kind of trouble will be reported on without
having to actually run into it. Presumably including
yet-to-be-discovered deadlocks. ;)

