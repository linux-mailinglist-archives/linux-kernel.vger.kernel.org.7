Return-Path: <linux-kernel+bounces-740132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3091EB0D063
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C7F1AA3B51
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 03:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDB628B7F8;
	Tue, 22 Jul 2025 03:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmma1k4U"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB22576;
	Tue, 22 Jul 2025 03:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155442; cv=none; b=YcF9qJ3eDdnKrvYIhyFlTj6m7x2RGucFEVHVaUK/n+vZHkPk8tWEUWBMRJ8J2jBZ1122TvNUDyQwwSu8Y3n1mgMAyuZ9hFbWU46a6MGTKMjOGK1yvvPhvVN8rg4kOwqPRGXSf7LxBLG4H7z3i7l2JBaQgLfc38v6poIDTZyUF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155442; c=relaxed/simple;
	bh=A0vuGMfZNRIrHTYRNAiLt7mQa+x6fC50iVkYrq5GlPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FiGH4VI2K39QK9Gag0DQw5f3XH3oNFHlYSiezQt4Ln0Za8MXvwp/roHWeJJyX6e2irHqI3y7/S/W7zrEzwwtmr5CrtVOkjoimLAeXtrI9/q2sebzxLgIsSkVRgD8aR4H+2sq5XPCEIeS1KevZ6OUHxB0WhQl0cwWzjAdYP/WEjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmma1k4U; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-880f92a63c7so2499002241.1;
        Mon, 21 Jul 2025 20:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753155439; x=1753760239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVrKVkdiE3XI9rtU+WROK7PUvC79wNx/ZAhQmWdv0qU=;
        b=jmma1k4Uyoep2+a2CapHgq4bmslogjxF+khONtno60Vgr00+m4a04S5NbDTKB0GbD9
         oDfs4JNpPm22yyj0J85X0+Mioygop1zM2dF2sx/Mf6z/51ElyIDHwRh5YR8R5mNUbBTq
         gqDKV1EzZwuETDCgsCuObra1o87Aq0EwbVcVp/Sgb/soh0H3S4/afRO43NQ3QUsadYPT
         ED6st/pESwkrNPgcLR3woXAWQNzOlWNq6yQVPDJYvB3L/41DAQf7LTfn7+JgFKwCXgC+
         VaHDsGe2rE8QkzY9NB5QE48/DBk35mHR7VVwlpdwkzcZ4er7uIYZfLHgyIUPX6i80A98
         PlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753155439; x=1753760239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVrKVkdiE3XI9rtU+WROK7PUvC79wNx/ZAhQmWdv0qU=;
        b=V8IXs8cdATR50KJ36415Qr098dUSd+utHauNAnGBF948oztvAIjkBDACpmEHuzFMcq
         QIV5mWJ0EtH8+MRvqsMTwtVJl2cAZ/T/OYGcVe3qqdhzykpGGt+5FZY2tO1ZID/AruQ6
         fxg1ebz41bAV6THR5VXir4fdcbULqLtr/MZgtoxpgN7u+iI69yj6lUCd1CE9Zs/Q/XJh
         CV1L6iM45zMA//EI1SwgdBbVRgJDgLM3eFbnQsKo3yXWUKbYxImzDfPy4IKszDRroIGz
         rLlL76nXLsBQbFRL6yM0AigrdNwIu8x87B1JRZfztjgZGUWDIGnWOpHp8/82h8sWmi0N
         ZySQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH7Nw+5iuK9ZPHlKfgv6GGkDxUYW3f33a+6CWZ3yBzRFYLqMuYMZrPHKl0k5teRbZWW7mgDjW5ql0=@vger.kernel.org, AJvYcCVihr95E98v8GcWKiYWmHUwLR7jEFKL/ufzMPuj4ffwjatn5oX1/6kkPxK/SC4cTtkQLMMrom5bsrplxhjX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/9EYz/DcOKbTJccZuddbi0+QeaM6dj7pOBCn/r+Qbcko5t1J
	rXr36mePd2kcSgHUJVkzXkQP0YfGzLdAJIB2TIQu41SGn55mmFBBXpBG+V6nf7c27vuIDzI7G86
	/u38weH9Rj0ZND4f3mgKaeIRgvsd3l/6R4hgJq3o=
X-Gm-Gg: ASbGncvh7w3TqyZcI7yCz3kpAv4tNx/RT7UEbgQSKBwLC4ov890jbO+keZw3lyYq5Jp
	WjB7eywOD7rDEAcYcIJ8GoeYadHP4k0f0r4TX/eirrkCa1fnCW7LwSLxPBaktcZDZMdpcs7jIzY
	FOmEheoOpAFL4tVjGMFb7cLQAxufUr2bayduL3sTbS+nm1gZwhbZB0acxG/yFIQV0nLhDuBKxr/
	xib1cs=
X-Google-Smtp-Source: AGHT+IFclDmfRZMBfgkRo+vyKsonZXTN77cM0X+Su+luJY37jRTemshTbwfhPv2FeuLITlw1fo3isL2Cssdeh3MP1Bo=
X-Received: by 2002:a05:6102:3f52:b0:4e9:b0d4:1133 with SMTP id
 ada2fe7eead31-4f95f410c3cmr11992642137.20.1753155439176; Mon, 21 Jul 2025
 20:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721155530.75944-1-lorenzo.stoakes@oracle.com>
 <35df32ae-dc95-48e1-bdb1-90f17bfd4d5c@linux.alibaba.com> <CAGsJ_4yMLi_+yxJYebTbEALujcVmeqbfHh=ArkZRxMwE+OBWgQ@mail.gmail.com>
 <a7062d0d-804f-4b9a-ba7f-62d67064c584@linux.alibaba.com>
In-Reply-To: <a7062d0d-804f-4b9a-ba7f-62d67064c584@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 22 Jul 2025 11:37:07 +0800
X-Gm-Features: Ac12FXxqTKKk2Dd1pvj17lLGUdPMo1rMsVF70mOgS6Fje2FH4DvbmpyAcqvjEpY
Message-ID: <CAGsJ_4wvWZwG6agXOzDoYBD_vnN6k4TRJjhFfR5dw5pQrk2mwQ@mail.gmail.com>
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

On Tue, Jul 22, 2025 at 10:33=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/7/22 10:23, Barry Song wrote:
> > On Tue, Jul 22, 2025 at 9:30=E2=80=AFAM Baolin Wang
> > <baolin.wang@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> On 2025/7/21 23:55, Lorenzo Stoakes wrote:
> >>> Rather confusingly, setting all Transparent Huge Page sysfs settings =
to
> >>> "never" does not in fact result in THP being globally disabled.
> >>>
> >>> Rather, it results in khugepaged being disabled, but one can still ob=
tain
> >>> THP pages using madvise(..., MADV_COLLAPSE).
> >>>
> >>> This is something that has remained poorly documented for some time, =
and it
> >>> is likely the received wisdom of most users of THP that never does, i=
n
> >>> fact, mean never.
> >>>
> >>> It is therefore important to highlight, very clearly, that this is no=
t the
> >>> ase.
> >>>
> >>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >>> ---
> >>>    Documentation/admin-guide/mm/transhuge.rst | 11 +++++++++--
> >>>    1 file changed, 9 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentati=
on/admin-guide/mm/transhuge.rst
> >>> index dff8d5985f0f..182519197ef7 100644
> >>> --- a/Documentation/admin-guide/mm/transhuge.rst
> >>> +++ b/Documentation/admin-guide/mm/transhuge.rst
> >>> @@ -107,7 +107,7 @@ sysfs
> >>>    Global THP controls
> >>>    -------------------
> >>>
> >>> -Transparent Hugepage Support for anonymous memory can be entirely di=
sabled
> >>> +Transparent Hugepage Support for anonymous memory can be disabled
> >>>    (mostly for debugging purposes) or only enabled inside MADV_HUGEPA=
GE
> >>>    regions (to avoid the risk of consuming more memory resources) or =
enabled
> >>>    system wide. This can be achieved per-supported-THP-size with one =
of::
> >>> @@ -119,6 +119,11 @@ system wide. This can be achieved per-supported-=
THP-size with one of::
> >>>    where <size> is the hugepage size being addressed, the available s=
izes
> >>>    for which vary by system.
> >>>
> >>> +.. note:: Setting "never" in all sysfs THP controls does **not** dis=
able
> >>> +          Transparent Huge Pages globally. This is because ``madvise=
(...,
> >>> +          MADV_COLLAPSE)`` ignores these settings and collapses rang=
es to
> >>> +          PMD-sized huge pages unconditionally.
> >>> +
> >>>    For example::
> >>>
> >>>        echo always >/sys/kernel/mm/transparent_hugepage/hugepages-204=
8kB/enabled
> >>> @@ -187,7 +192,9 @@ madvise
> >>>        behaviour.
> >>>
> >>>    never
> >>> -     should be self-explanatory.
> >>> +     should be self-explanatory. Note that ``madvise(...,
> >>> +     MADV_COLLAPSE)`` can still cause transparent huge pages to be
> >>> +     obtained even if this mode is specified everywhere.
> >>
> >> I hope this part of the explanation is also copy-pasted into the
> >> 'Hugepages in tmpfs/shmem' section. Otherwise look good to me. Thanks.
> >
> > Apologies if this is a silly question, but regarding this patchset:
> > https://lore.kernel.org/linux-mm/cover.1750815384.git.baolin.wang@linux=
.alibaba.com/
> >
> > It looks like the intention is to disable hugepages even for
> > `MADV_COLLAPSE` when the user has set the policy to 'never'. However,
> > based on Lorenzo's documentation update, it seems we still want to allo=
w
> > hugepages for `MADV_COLLAPSE` even if 'never' is set?
> >
> > Could you clarify what the intended behavior is? It seems we've decided
> > to keep the existing behavior unchanged=E2=80=94am I understanding that
> > correctly?
>
> Yes, Hugh has already explicitly opposed the current changes to the
> MADV_COLLAPSE logic[1], although there are still some disagreements that
> cannot be resolved.
>
> At least we reached the consensus to update the documentation to reflect
> the current sysfs THP control logic first, to avoid the misunderstanding
> that 'sysfs THP controls can disable Transparent Huge Pages globally'.

Nice, thanks! Personally, I prefer this approach as well. Updating the
man page feels a bit odd, since it's something people are already
familiar with and may have memorized.

>
> [1]
> https://lore.kernel.org/linux-mm/75c02dbf-4189-958d-515e-fa80bb2187fc@goo=
gle.com/

Best regards
Barry

