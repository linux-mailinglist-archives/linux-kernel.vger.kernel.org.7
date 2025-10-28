Return-Path: <linux-kernel+bounces-874458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9691CC1663A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 19:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1ED6A50030F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1868034CFD3;
	Tue, 28 Oct 2025 18:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTaJHWwp"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E58346A0A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761674610; cv=none; b=OhOP01xiy3Tr4zZwbvL6oLmQFMU26sNlR4+JKYR37esu6oZB07p3Hn4nSndU6FDRZsS9/biBE4690t7kD0qrLzc2rVANO7qEocOM/q1LJv1SH1tv8Mr5lLmwQso4q30NtXHoN/h0Vv6on43/OQd4HDByOURWRTNfOYL74tdGvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761674610; c=relaxed/simple;
	bh=N/2n9//+KW7oF6yBywFQdC6s1W8qi+KuEL6BiBiuSSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fl17P4BYveeYvzEu2lR34dDtlJxNteZAhq2h4yvso8ApuqYMUYXl3I4X3kYWmjpy/pTk1Jux5IcttUrQEpSq02KSgkTOjRPGd19Cb5EGDjqCVoKPquAyNTh+EbnCTqeZjKTmbykZCMZeQBrvQSBZGcRv1jiYzvuA6piGAuX5qq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTaJHWwp; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33e0008d3b3so6396420a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761674608; x=1762279408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YUIz8wwdRGbzeLmUHhGiVZlg3eCd3kY9ZjME39qTq8=;
        b=ZTaJHWwpI43QriePMm2vLipy+s8KeR1idVe01X4/H+cxgNNlFwXJd0enZGXcx2AHfd
         0nC5D2s7O3Jr5Bk8Efqrx19rGhEo74U85xfSPSzhieSOkVNwvzCC+o0anH+wTRXSLnCc
         JAr23flMCLbd+C5J02N5N5zvJmkjG4jgBep6VgOz61KRd83CK+OY4uwF4TNf0KDrff0T
         +doIEDg9KDWF5wpfLD5TwgqMJ8Vv4MfhkYhAJDDSge/1UbZXFD8YuUiPYLZFGvwlWpl8
         xA+8J7fTumBZwY0tlKOGzHlE03QusHDraWLFAaky1GDD6ltLJiLsE7wiEWkCeXyHAkgU
         aQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761674608; x=1762279408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YUIz8wwdRGbzeLmUHhGiVZlg3eCd3kY9ZjME39qTq8=;
        b=P+jNx1Ii42NBFsX8+uppow3qFyEHN9crAmujWEtRHE1Nc6tWYTUR4SjcCe8VGECgf8
         wXkB89OyZVqcKZ4ihW2mRggSq/1UCy/3fIfxrx/og6aF0mbRyVVXchQ3C6pZ1+7nYLxM
         FBnRsmPtuVNjBHWX7HqyroSWbKrohH1LVj7+lHWJV50BCv52QvX+4tcJyg8OlFnZ15Fh
         DXrS7wF6J7yhjpF/5YwjUfpeOa7EkQXIZreiMIuHGfZt2OPg+uLOhWDhkMBvoY/oYdMl
         /GE38Zh3TUbTDE3acRsG9LYayG6tJk1HgKzpf4qNZGP/xXWgmGoulJo18u6d4M9Q48WG
         0W9A==
X-Forwarded-Encrypted: i=1; AJvYcCXrHB9LNCUYDlHwUHLQlW617mSfURqX7BauqH37JJ5tKs6yFUHWNJcFblz2nSoKl42ufKZ5Pt3B3VeCxKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeI96XXWqkSZbgBWdoxwtdkpjX69CwtNYey1pntAm8dB6fhB1z
	YHlC4wZ3EA4iKoq6Ybe5jUG+gSiYEfYGbCs3R4s+WpVrIUCi7HPUCt8MmAMb0yDk7SMqu9WMJ9R
	peqicNrr+IGe16GASAk2TMBDqozvU9mI=
X-Gm-Gg: ASbGncvD4jPLff0KrYGkqZuC/PTtLM7spOwu+78EU/foFcQFicSHKSjYn7Y8CVER2Vs
	8RK456orwOgFD+2AP+08nzhTlxhUZRVGbLz61kO9VTMrDtLyP3FjLIXeMnMFX1yOkeUj/oEn8mM
	JRJvOLX0DpxROR6yxWCZUqeVM+jONhOi2wU1hsAlhogzqGUrmHYndJS7qNV2ShRscZhgw51UKq/
	33yd5YaohV+h2JTiueoAx6kakN5a59dDFeaFRVmztmUkF0A9N4VYl3UGmv6VXNb8jc5OsHJSAY3
X-Google-Smtp-Source: AGHT+IF5uRUmVRMsdvmXnOQ/s58+NuQywR1+H1ilzd8u0z1tYFeDtb+IxVChGYm8w5VEsZPqM/8uTgNLgmV5PnDy1Rk=
X-Received: by 2002:a17:90b:582f:b0:32e:9f1e:4ee4 with SMTP id
 98e67ed59e1d1-34027bd6b5cmr6501813a91.17.1761674607530; Tue, 28 Oct 2025
 11:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026154000.34151-1-leon.hwang@linux.dev> <20251026154000.34151-4-leon.hwang@linux.dev>
 <CAMB2axPhcYctJYz0bH032-Kc1h2LcJL74O5iS5g=8Qp74GPK_g@mail.gmail.com>
 <377791b5-2294-4ced-a0d3-918c7e078b2b@linux.dev> <CAMB2axPx2RajLzhoOsnffhrOxkw7Zy=D=vHam_Y_5wKS0cqf0g@mail.gmail.com>
 <971495da-bc0e-46d4-bda4-5e9b8310ca3e@linux.dev>
In-Reply-To: <971495da-bc0e-46d4-bda4-5e9b8310ca3e@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Oct 2025 11:03:13 -0700
X-Gm-Features: AWmQ_bnRheSYG69jQZH0dkLn0sMywDw0oGtZbRALO7WE3C87j6rV9LzVKZj-sx4
Message-ID: <CAEf4BzbRA1Ka1piTiQjBfG2z8tp2ucJh_YuazFWNqAVtOhD48g@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/4] bpf: Free special fields when update local
 storage maps
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, memxor@gmail.com, 
	linux-kernel@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 7:48=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2025/10/28 01:04, Amery Hung wrote:
> > On Mon, Oct 27, 2025 at 9:15=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> Hi Amery,
> >>
> >> On 2025/10/27 23:44, Amery Hung wrote:
> >>> On Sun, Oct 26, 2025 at 8:41=E2=80=AFAM Leon Hwang <leon.hwang@linux.=
dev> wrote:
>
> [...]
>
> >>>>                 selem =3D SELEM(old_sdata);
> >>>>                 goto unlock;
> >>>>         }
> >>>> @@ -654,6 +656,7 @@ bpf_local_storage_update(void *owner, struct bpf=
_local_storage_map *smap,
> >>>>
> >>>>         /* Third, remove old selem, SELEM(old_sdata) */
> >>>>         if (old_sdata) {
> >>>> +               bpf_obj_free_fields(smap->map.record, old_sdata->dat=
a);
> >>>
> >>> Is this really needed? bpf_selem_free_list() later should free specia=
l
> >>> fields in this selem.
> >>>
> >>
> >> Yes, it=E2=80=99s needed. The new selftest confirms that the special f=
ields are
> >> not freed when updating a local storage map.
> >>
> >
> > Hmmm. I don't think so.
> >
> >> Also, bpf_selem_unlink_storage_nolock() doesn=E2=80=99t invoke
> >> bpf_selem_free_list(), unlike bpf_selem_unlink_storage(). So we need t=
o
> >> call bpf_obj_free_fields() here explicitly to free those fields.
> >>
> >
> > bpf_selem_unlink_storage_nolock() unlinks the old selem and adds it to
> > old_selem_free_list. Later, bpf_selem_free_list() will call
> > bpf_selem_free() to free selem in bpf_selem_free_list, which should
> > also free special fields in the selem.
> >
> > The selftests may have checked the refcount before an task trace RCU
> > gp and thought it is a leak. I added a 300ms delay before the checking
> > program runs and the test did not detect any leak even without this
> > specific bpf_obj_free_fields().
>
> Yeah, you're right. Thanks for the clear explanation.
>
> I also verified it by adding a 300ms delay.
>
> So this bpf_obj_free_fields() call isn't needed =E2=80=94 I'll drop it in=
 the
> next revision.

I've dropped it while applying, no need to resend.

>
> Thanks,
> Leon
>

