Return-Path: <linux-kernel+bounces-844133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB579BC1183
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E10C74F5013
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA2B2D7DCF;
	Tue,  7 Oct 2025 11:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTc6VxMn"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D42D7DE0
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835305; cv=none; b=MXE4hCKekUBpZyLeJy27RolG2PSNPwftlYmR/IoSo248CBKlp8y4T71iZMjtjAD3WGgFIzvzh+KDgEV6RP7dOgyUyt/C2AgC8DMOnTGVc5ybBB5gIUvFl6YR1eeJcwwM69lBdUHoRtgcm+Qr4KMTXYmv1o4m4zhWiublALg/rjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835305; c=relaxed/simple;
	bh=UYjxP2t5m3TSDV72mhr1AaddvxDwKD3qqqOjv0SKlxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WzVDlD05SgfGqszF8fbmQSRWs2wE9UdPrwbxqIrLFlI6kU5VnVyohDSMnRsuPyw4HZul4jC+OU7+N1ZYzF/WdiqtXRrN8d/i4/fyfWvgWB8QwSdpsNq7pEXBHtKtwTn37CEfE5CUQihmTGmJOScHWv1a/t0781gLwbuewZoF0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTc6VxMn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1239133666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759835302; x=1760440102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYjxP2t5m3TSDV72mhr1AaddvxDwKD3qqqOjv0SKlxI=;
        b=YTc6VxMnrbOxAxg0dymgOMnAKNqjMIyuPLXBH6eEu6/JVt/86hfbdnVhS87c7bxKdf
         ZAapAJKUDHw7nBE0p4fxdPzfII/LpqegteJ58dR4HuGAJaeSJtr4rIU2uUQyxX2Hk/0z
         lme16YJPCk+/Pkrz8w/OIZ1NQG+mG0ZHJu1X4LyZNsF3nuiHF3VrmOq8eRA7mAc61a7K
         2X19cVg+GMNJrmVt8yq9xI5u5zRSuq1ldT3/MdFipk1UraUfPatmutd10Q3VlynE91PJ
         S+PgoTaHPN30XSYofAJ9N7f9O/+uzl016zS1il2OI3P/DCTbZgfhP4FdVwd3ZX5s4ahP
         XFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759835302; x=1760440102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYjxP2t5m3TSDV72mhr1AaddvxDwKD3qqqOjv0SKlxI=;
        b=exFybkyADNWwHdCKjjmdNneAtYCngSgeyvj67W1L/CRIIX9tAliFC0Xm6cmO5JpmyJ
         ebvHzJNcjCDALZdh1uqd81RUoXf4EX7fLx8Y4zZi9TiEPcxukTWb1+1IXJKCt1Ka5NhS
         wLmR+tYSR9EBwSbTHhJPhtdd9nZliAAD6wLFZKfBNIRjQj1oosw6jwFOcNSJrRWtCOxY
         UWYuNsMV1hd5PzxwD9QaBkXbvPJkvr4msH5S1GWT6Jm6mETBJxnIzVEAOqLXsjt41smh
         P9t0fW1mnnnj68N60jJohYn3nEkpCONWw6zTVoiUTzvRkK1TkUDC8VmpKsp9q9FXHQOV
         zMzg==
X-Forwarded-Encrypted: i=1; AJvYcCW93d+ZvKaldooVAR90m0j/3fxtYbkTS73Rle1mRCCbUv7IU5epMqYdPB6v3TURnXXga0ZR4SKr+P2ZftM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4cSM5k5JcEDd3lQOJQLKCbR/IN29uuOvQdCvVNz/ay5wCDal
	bUNh2gS1MfTFD8sUTs0LuYYae7/EcXsnbS0aQ3lvJnGSqUFprGY0A4YkPnDgOwSzvczi0KvrmDe
	DR9tImdnOeXZiUvNBpknVYEVMWqtKGVA=
X-Gm-Gg: ASbGncspYljvjvcHI3IpuOrCXLaHR5ByDGjXnq8BEcZsyMDKTWemfxORyWDnpICsQD1
	nr9z3mcFZeGxtHTMxpceYTPf5+ekYVxeRW3zf+bJ+vG22hcvpyHiWbUo6Je3p/PBMK+BnKQF4he
	i1HTEzE2y+dVd/lMssMXO9WgTqVTnNqoaKgbR3KJkTxOzVVinhxNB+nRLCULuNe8G3+7POeQkqU
	JKCfAxPNnEmrHmeUHsbPVrUHXHsUkFZw1tP16+dwK1YWUcnf4gf+KoH7FDmHsYfzQ==
X-Google-Smtp-Source: AGHT+IHTIee9up7m92yTA0Zsk+7eOEOmCuPn1i2HEpHrFMMVIsPmZ/Ha7QPfPMEmx8EgOfImzZOVCi5jgu6WcAE+r2M=
X-Received: by 2002:a17:906:4fce:b0:b40:98b1:7457 with SMTP id
 a640c23a62f3a-b49c4cde268mr1621336566b.47.1759835301952; Tue, 07 Oct 2025
 04:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003155238.2147410-1-ryan.roberts@arm.com>
 <edc832b4-5f4c-4f26-a306-954d65ec2e85@redhat.com> <66251c3e-4970-4cac-a1fc-46749d2a727a@arm.com>
 <989c49fc-1f6f-4674-96e7-9f987ec490db@redhat.com> <CAOQ4uxh+Mho71c93FNqcw=crw2H3yEs-uecWf4b6JMKYDTBCWQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxh+Mho71c93FNqcw=crw2H3yEs-uecWf4b6JMKYDTBCWQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 7 Oct 2025 13:08:10 +0200
X-Gm-Features: AS18NWAe14dfNSbsR0j5kwg1mzZpCKRfTUR5zwp4QxEyNvIbDN-ZzhaGc85_2tM
Message-ID: <CAOQ4uxh-FJMtpyDrZpRQcWV6ScranQWUia4yz+rb82yQSdjSUQ@mail.gmail.com>
Subject: Re: [PATCH v1] fsnotify: Pass correct offset to fsnotify_mmap_perm()
To: Jan Kara <jack@suse.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 4:40=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Mon, Oct 6, 2025 at 3:53=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 06.10.25 14:14, Ryan Roberts wrote:
> > > On 06/10/2025 12:36, David Hildenbrand wrote:
> > >> On 03.10.25 17:52, Ryan Roberts wrote:
> > >>> fsnotify_mmap_perm() requires a byte offset for the file about to b=
e
> > >>> mmap'ed. But it is called from vm_mmap_pgoff(), which has a page of=
fset.
> > >>> Previously the conversion was done incorrectly so let's fix it, bei=
ng
> > >>> careful not to overflow on 32-bit platforms.
> > >>>
> > >>> Discovered during code review.
> > >>>
> > >>> Cc: <stable@vger.kernel.org>
> > >>> Fixes: 066e053fe208 ("fsnotify: add pre-content hooks on mmap()")
> > >>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > >>> ---
> > >>> Applies against today's mm-unstable (aa05a436eca8).
> > >>>
> > >>
> > >> Curious: is there some easy way to write a reproducer? Did you look =
into that?
> > >
> > > I didn't; this was just a drive-by discovery.
> > >
> > > It looks like there are some fanotify tests in the filesystems selfte=
sts; I
> > > guess they could be extended to add a regression test?
> > >
> > > But FWIW, I think the kernel is just passing the ofset/length info of=
f to user
> > > space and isn't acting on it itself. So there is no kernel vulnerabil=
ity here.
> >
> > Right, I'm rather wondering if this could have been caught earlier and
> > how we could have caught it earlier :)
>
> Ha! you would have thought we either have no test for it or we test
> only mmap with offset 0.
>
> But we have LTP test fanotify24 which does mmap with offset page_sz*100
> and indeed it prints the info and info says offset 0, only we do not veri=
fy the
> offset info in this test...
>
> Will be fixed.

Jan,

FYI test enhanced and verified the bug and the fix:
https://github.com/amir73il/ltp/commits/fsnotify-fixes/

Will wait with posting the test until you merge the fix to make sure that t=
he
commit id is not changed.

Thanks,
Amir.

