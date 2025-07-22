Return-Path: <linux-kernel+bounces-740091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 429BAB0CF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 04:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6A3542F63
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 02:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4D21D6DB9;
	Tue, 22 Jul 2025 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmZ9gg4S"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E0E573;
	Tue, 22 Jul 2025 02:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753151033; cv=none; b=qOAmrHgaH9xu70OhuQoaGp4GGQZyEcyh54S56ZCA4NwzxPHFJoGRLdFt6fBP1vMl1LDBzw57CDLM9n0PAf1Rzk8HsodwihDXgk7tcHjZ6GZvSuQ1+LJIHoRKYZe60TAHLOY4/U0d+cvdm7M58oKsOFQ+84N68FSE6a9M49Nh5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753151033; c=relaxed/simple;
	bh=ZyGlTW1yugcoNtyDmm72FT20mFuf855FzNVR7lnl4H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPeaZc6fSvwvjUadTLPdWPNV+rEhQ9zxK0Is9rpP3VSQ50nQcCAZaaZnLnAkqaE7gyCc54j/dAfW0sOd3SPhO4gXkZOwbdWQXyyTJRxvLzvF6lY+S/pv08tZYt7tvVn0ebAQEbqLgWnju2mzrhHknn4ohpwAvpVefQbHufXQzPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmZ9gg4S; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52b2290e290so1391247e0c.1;
        Mon, 21 Jul 2025 19:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753151031; x=1753755831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/C+U2K3/i43umoAQCo3nc2pCSOMDyoCKEEcB2BDhGM=;
        b=gmZ9gg4St6BIRuLNEnJcXiT9SYfayFiHgPoIfyvOpwP80/hqA14+ueALVH452aeKFY
         BWBDJ+W5e5Xq3XYurYAuktzLG5lQxK5sEIpjndTNH3Eq1xma2gm99rXpwAkZHaS9o/9M
         ezixi0MP6bB4+fNVszCggB+nGhw55d/9oUxvdEw9gnrUEfdORmLXIsDitUDZIVOXfUkl
         VqW/SDKO2g3jv9gM+md/UnuS1hpyab74ZtBDmaA8p5YSPvaekbdqPrjlQEo+Re522P4c
         /ZFpAyvtQ1mvm+9RW35xMLd2+WbiBfRrkxdzHPej1IP9FrdU8WhA0fNZrPD5wZT5d7PX
         0Qaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753151031; x=1753755831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/C+U2K3/i43umoAQCo3nc2pCSOMDyoCKEEcB2BDhGM=;
        b=vWhrYyDR+tsLv0b2DLctPn7I+RvVusYZJ4iBmm4BxyBOsR2MZ2YVLYw+P7pjhkZgG9
         Znc9mVyLJ0kRaGxTYyyAjct1LQuwdds2BnSmME+JkxvpQEs68TXRgrmemXCuupM+GL7T
         6nXOvnuK9imVYIfHshaJZ6M5JqGoo3ZqRKn06L714Guy1apPOzMqATRCcvbmgXZtIp8Q
         4TfOJuhDlLBMG0fqUYLUZnLCElKWtwZDt00It+yIns8EY6BgZq5T71rHcj9wrYMzxMTS
         v6DCs0O2MSwDsphd4tYfw860VA0SVV0Lvt9Kz0xWIY7KM4kd10jMwW3SzVW2qjTOHmLx
         XzUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0L9NlPNsGrjxyJ3ZPw3rFVxfD6Pilk7VFqchtULHgpwDIEUI6EjEXk2UEDV7Ly9Sdj/sB1Vz4BJbeDayr@vger.kernel.org, AJvYcCVSIM4i6+/gSsV9p3vRZlpvZHDv5ExVPNY/sZvGziW1yrIgOSjLfzUkwzT/o9sb9Y5Q6RsnRw4lEKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZpyM0Pyi0Cj1991NuV3n/uvczS9OOzEj+ojxBr2JVZ57rTYVX
	GdjoYZ3/o0vlncj0gVGxxX92N2aNiwlOWGah31ipeV23TcKSfa/YujpVEHAW1V5iXQOx47qJP1P
	KVpld+ttWdRTQcSpxIlZpUgCamnkA8Gg=
X-Gm-Gg: ASbGncv3OcLV55pTzi3bvob1GG//7VKXS4QlIoWg7Udtc2FkOOFt0r9D7FOjZPiE0Ld
	rf5Zq3TzPlfzm13P4bBphzEq05CZeSfuzA7jKoVCibKMDIOMWI8fEgmJSX3jUNIRWEOvSA/Xide
	f3LKJIbSYksTg5dUQaXRwpisVe3hLjWLx87sHw6LlpnERXXa3YT/kOPqWo5xsKUH2YBRRoGhA6I
	bnYR2s=
X-Google-Smtp-Source: AGHT+IGesNlr5e/sM49NBb9K/B4x7qfIWHZWh698rKyBwCLi7wWon4ZhVCgWQfP34NW6TE1MplcctXDbbJZ71bGMN64=
X-Received: by 2002:a05:6122:3286:b0:535:e35d:49f4 with SMTP id
 71dfb90a1353d-5373fcbc0d3mr10995191e0c.11.1753151030620; Mon, 21 Jul 2025
 19:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721155530.75944-1-lorenzo.stoakes@oracle.com> <35df32ae-dc95-48e1-bdb1-90f17bfd4d5c@linux.alibaba.com>
In-Reply-To: <35df32ae-dc95-48e1-bdb1-90f17bfd4d5c@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 22 Jul 2025 10:23:39 +0800
X-Gm-Features: Ac12FXx4o5zzStPLAnFL7QFhqYq_Lgoa4m8TQ4nfuZBMUKJ2dVDoDaKYQTkIF2I
Message-ID: <CAGsJ_4yMLi_+yxJYebTbEALujcVmeqbfHh=ArkZRxMwE+OBWgQ@mail.gmail.com>
Subject: Re: [PATCH] docs: update THP documentation to clarify sysfs "never" setting
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:30=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/7/21 23:55, Lorenzo Stoakes wrote:
> > Rather confusingly, setting all Transparent Huge Page sysfs settings to
> > "never" does not in fact result in THP being globally disabled.
> >
> > Rather, it results in khugepaged being disabled, but one can still obta=
in
> > THP pages using madvise(..., MADV_COLLAPSE).
> >
> > This is something that has remained poorly documented for some time, an=
d it
> > is likely the received wisdom of most users of THP that never does, in
> > fact, mean never.
> >
> > It is therefore important to highlight, very clearly, that this is not =
the
> > ase.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   Documentation/admin-guide/mm/transhuge.rst | 11 +++++++++--
> >   1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index dff8d5985f0f..182519197ef7 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -107,7 +107,7 @@ sysfs
> >   Global THP controls
> >   -------------------
> >
> > -Transparent Hugepage Support for anonymous memory can be entirely disa=
bled
> > +Transparent Hugepage Support for anonymous memory can be disabled
> >   (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
> >   regions (to avoid the risk of consuming more memory resources) or ena=
bled
> >   system wide. This can be achieved per-supported-THP-size with one of:=
:
> > @@ -119,6 +119,11 @@ system wide. This can be achieved per-supported-TH=
P-size with one of::
> >   where <size> is the hugepage size being addressed, the available size=
s
> >   for which vary by system.
> >
> > +.. note:: Setting "never" in all sysfs THP controls does **not** disab=
le
> > +          Transparent Huge Pages globally. This is because ``madvise(.=
..,
> > +          MADV_COLLAPSE)`` ignores these settings and collapses ranges=
 to
> > +          PMD-sized huge pages unconditionally.
> > +
> >   For example::
> >
> >       echo always >/sys/kernel/mm/transparent_hugepage/hugepages-2048kB=
/enabled
> > @@ -187,7 +192,9 @@ madvise
> >       behaviour.
> >
> >   never
> > -     should be self-explanatory.
> > +     should be self-explanatory. Note that ``madvise(...,
> > +     MADV_COLLAPSE)`` can still cause transparent huge pages to be
> > +     obtained even if this mode is specified everywhere.
>
> I hope this part of the explanation is also copy-pasted into the
> 'Hugepages in tmpfs/shmem' section. Otherwise look good to me. Thanks.

Apologies if this is a silly question, but regarding this patchset:
https://lore.kernel.org/linux-mm/cover.1750815384.git.baolin.wang@linux.ali=
baba.com/

It looks like the intention is to disable hugepages even for
`MADV_COLLAPSE` when the user has set the policy to 'never'. However,
based on Lorenzo's documentation update, it seems we still want to allow
hugepages for `MADV_COLLAPSE` even if 'never' is set?

Could you clarify what the intended behavior is? It seems we've decided
to keep the existing behavior unchanged=E2=80=94am I understanding that
correctly?

Thanks
Barry

