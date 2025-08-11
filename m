Return-Path: <linux-kernel+bounces-761886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A6B1FFA2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD26216F777
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 06:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152072D8792;
	Mon, 11 Aug 2025 06:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbXWnRXy"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E142D8789
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895185; cv=none; b=KI5XRsImb1TlShLoTlGNzpui11gewJyJXhw5nJYu0EFER5lZwa6T2MRGJAxnWxst20tABb2T8AP1QivO2WycxftxignK3K0VGS/KMPfhSrK+Cy0I+V530Bt1AuPxbKiGRKYeMi2vDfX6Bsqkuo9GJQ/9ix6vgjNwiC/tZa4u0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895185; c=relaxed/simple;
	bh=/fVsUY08ipVRtRLpv10uWhZA7wsDSRqCmbwogA870dE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uaM40XPRg8Hw5IZEPqLL11bDPgX3NNad7cmmKheKUfOE2dBbH+TTKahZk3ykWq+mbwGu9wLQb5enpEPYOPtRMLjI0Gc4LAObdPGm+SXYQENX+dK/JB+M91tKbRQjIx/EdJRq7OeSRk8o/PujEITRFgQ8lOABRirh1plkUFlijRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbXWnRXy; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-4fe7712bedaso3835742137.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 23:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754895183; x=1755499983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fVsUY08ipVRtRLpv10uWhZA7wsDSRqCmbwogA870dE=;
        b=nbXWnRXy2WMqzm53doYdOxLbM6tSht8EPalMvwmZVSJ6T/N6hU21fkPBCMsWPdN3wi
         C4WxS+VFjYd9S9gTuTYrgFvp3H+/qN1Lc7QPiN6a8h3r2PwtoAiVhE9NJcApw6jN5fAH
         tShHTOxLeTwPCBAT9KTmHPKN5I0N6r+FRKXYkbUbQuOdNI0TGiMa8RrLL/Is4ngBqwi0
         eXmrUMz4fW6dPLagT1EWceNmEqe+O8N2NMtB6KCSPgfni/g5/ZxqS3AM0ogqyCOB7+aG
         bwyKH4SBdadWY4/fYwt7c/K7hRZMOeL97A0vhnXoJCpd/iikLtCliW9OpY2d7YTVnXQ/
         BfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754895183; x=1755499983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fVsUY08ipVRtRLpv10uWhZA7wsDSRqCmbwogA870dE=;
        b=pyHtdlKy5k1+Gdgrgu1IlCixzFJ7sgKQjwDibIXDmuUsdzeEQ2K5Rk2CktD7SihoyO
         YV33gLU6Glh0KokCsLooSIhhDSHsXBD4UWh9Tc9IxwK4sgx1RgioJKYL+kKHrYPJp0Y5
         Gk5nMPWrCoqh+/0BZHzCtqQSThLpdrLr3Tc7hoLDo1dYU+U7FjBmWEr/94PKNy96eC/S
         /33AuwDgWcew1LlOupeULmO1Sg0l4cN2d/rp8ytKo6mdzLKvxIoKH8DwVUh7HEzSXO3q
         O/WCQuZWLGlDPLunY/hY6gzzaJNa1+UxrOIaiUzZLMeT3Cgp5GVDyR4MDIYUC0BW9TTX
         OGlg==
X-Forwarded-Encrypted: i=1; AJvYcCXhBxSh2xPiQjCVxd9JtUoqOi0FTR+EKVU4+qLTYuXDw3TA5bMp4Wg8+NxLBCE9Ogc6QjGEPgK6BCrhQZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ2Fl2CdIMBK41WRGFRH/5/cHQRWjEGWAcrahzLr1V/vnf9yrR
	aZuG/MMMhSuognFvh8VQjMrUvSnt/eaQYXi6WnNlZA6W9TDADNZCXq65PUWbkRp5yaHUNPx5jd/
	pZ1YUE1wcUZrj/Ovqpvsw2iPxZQuzdZc=
X-Gm-Gg: ASbGncsGGXS/QR+i6S3ItwTyvYXABWbY8YmBQcL89WsriZygVCwAcC5K/URFfhYZjSr
	C0Ur/WLmKNVJjSAOoXZr0i3wXGOPxYgryYHshT32TS3VtbCn3AYTQeauH2GvJTJFfBKBJ7NJuQR
	TOBbAobSnBPZQCQoDWEb5g+1qdj52UwEw741iZfB2+aW5YJAhQFlFr1YtOlVLYrneoBE9pYX1BV
	t25ZPk=
X-Google-Smtp-Source: AGHT+IGGDVcXKzHiETBGgnAZpGCC0gWUGYjDWg/fG11MB7bORpn/RJDutDW1kYazG5raVFO+qTH8hQX/k+xxbhGLSxg=
X-Received: by 2002:a05:6102:c91:b0:4ec:c548:ee2a with SMTP id
 ada2fe7eead31-5060f8b41b7mr4400160137.17.1754895182668; Sun, 10 Aug 2025
 23:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807185819.199865-1-lorenzo.stoakes@oracle.com>
 <CAGsJ_4zuEcgg7U0yCMu6ayKqRPACtvuzUsC9vUxBk2PgMzaf_Q@mail.gmail.com> <47ce3db2-38ad-4a6b-917a-c6300fc39543@lucifer.local>
In-Reply-To: <47ce3db2-38ad-4a6b-917a-c6300fc39543@lucifer.local>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 11 Aug 2025 14:52:51 +0800
X-Gm-Features: Ac12FXzg7m8LhV-73jU_CYSdeBumfCC_Ufk6bjZHFOVKRLYHVyElDAX-Y3qBP2Q
Message-ID: <CAGsJ_4w_c3AY1Nw7EhYH3rf0jjqgZ6AYLdr3xuonF9SNgWckDg@mail.gmail.com>
Subject: Re: [PATCH HOTFIX 6.17] mm/mremap: avoid expensive folio lookup on
 mremap folio pte batch
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 12:57=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Aug 11, 2025 at 10:40:50AM +0800, Barry Song wrote:
> > On Fri, Aug 8, 2025 at 2:59=E2=80=AFAM Lorenzo Stoakes
> > > The expectation by those discussing this from the start was that
> > > vm_normal_folio() (invoked by mremap_folio_pte_batch()) would likely =
be the
> > > culprit due to having to retrieve memory from the vmemmap (which mrem=
ap()
> > > page table moves does not otherwise do, meaning this is inevitably co=
ld
> > > memory).
> >
> > If vm_normal_folio() is so expensive, does that mean it negates the
> > benefits that commit f822a9a81a31 (=E2=80=9Cmm: optimize mremap() by PT=
E
> > batching=E2=80=9D) was originally intended to achieve through PTE batch=
ing?
>
> Not for arm64 apparently. And the hint check introduces here should avoid
> regressions even there when small folios are in place.

I still don=E2=80=99t understand why this is fine on arm64. We do have fast=
er
folio_pte_batch(), get_and_clear_ptes(), and set_ptes() with contpte, but
are those benefits really enough to outweigh the disadvantage of
vm_normal_folio(), given those PTEs are likely in the same cacheline?

Unless the previous contpte_try_unfold() was very costly and removing it yi=
elded
a significant improvement, it=E2=80=99s difficult to see how the benefits w=
ould outweigh
the drawbacks of vm_normal_folio(). Does this imply that there was already =
a
regression in mremap() caused by contpte_try_unfold() before?
And that Dev=E2=80=99s patch is essentially a fix for this regression on ar=
m64?

Sorry, maybe I=E2=80=99m talking too much, but I=E2=80=99m curious about th=
e whole story:-)

>
> In similar series to these in other areas, it appears we need the folio
> anyway so there is no additional overhead to deal with, in mremap() you'd
> otherwise just be looking at page tables which makes so this egregious
> here.
>

Thanks
Barry

