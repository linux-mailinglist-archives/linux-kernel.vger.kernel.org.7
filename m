Return-Path: <linux-kernel+bounces-782941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9D3B32744
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 09:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA60584075
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2DC2253BC;
	Sat, 23 Aug 2025 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXKHdz/r"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E08F2566;
	Sat, 23 Aug 2025 07:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755933980; cv=none; b=IenoYexLK5V+Dq/f4YXNauvOyB+xNSBnU/dl073wgfDoHcy86i/f0+mE66k5mVoarRdpzTwkMy7j3Y3s8OSpb2M9TmGOv+fcAdUfoDNvezRfVs8n5X77wRbCujeqd/C04YA++GuojKPZWIMXmtWmp/HwrUNKm3yP/cUZblpAdDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755933980; c=relaxed/simple;
	bh=mYIoenXd/IpYeqyX5AvyE414zM30cm97tDjS5JDQcqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYJuhzYqi2NZw2ZMLtGzMe6ABlJturiE/ziOLai5vJX1yBo1KPfdDIvr3jRyIl5ht1vlsg+jWJMlbe7VynAVXV8ImZJJ4N9I7iIeboM9IMJxYhQx2/CYxRmtATpbp+QKgpB3hhTYsSLXkKbRxXTc7i15bYdTUN6FsQq9VkRuqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXKHdz/r; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-53b174f7cf0so2135720e0c.2;
        Sat, 23 Aug 2025 00:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755933977; x=1756538777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVlSYjVo3nTEnki3rIbRUK8FN5NzrO8Q60sy9BA7q9w=;
        b=DXKHdz/r9Q10eEz7Wt1fYWwxp7sIRT2p13C4ZXMKCxN3xzF8zwatOLo2tF8mpyIaEG
         HKdiTSSngQlJZPQ/q1r+2zIF+ulIRDVATsmHD5nT10HQKBUhOnOrDWjJc0pXk1SyjQ6c
         aNKJXk5P2TObjQZHsLrgIr1wp7TQ2oXthWG9bsIxxkcoqaVmgWJAFJCkw2SKjiT6EVPM
         agZiU1W10MoEisT05hmdHcLX8gO21qApjPTSo3VqCnzhRYD9xkNmsRQJXOt1C1kvut4h
         ByhWnLQX1D6MiChEE8/7zDun6IBXstdW71GJfR18IpsAq/fKApfMxSdOR2Sy1+p3t3/h
         s7NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755933977; x=1756538777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVlSYjVo3nTEnki3rIbRUK8FN5NzrO8Q60sy9BA7q9w=;
        b=XqPy/TN00QtOPbuZZuex4ank3tsrGpfEtm4YO86pCpxauxE5UwHlwOdeuDbcTHStff
         +B1LNXhAWzK/FfsfAC9fcZ/bPXth+PWkmX1gv94583cKw72oOxulZIPoezMbmfj+e8DY
         0ofO9yk60bedxS+93lUw233ZXTG6b4afydDrJBMgIm0RiO2oVvv9XSTRmy5dbZFeW080
         xOhetM6Un5tpNsbgPWMd5gDGOUoZ4kKDM7MrCy/98gkeOmZsxj+lK0f0SIg45EvAFgCQ
         EY1DSoMeGvpo7xOabWxhuRwc0C07BF3QoywqNSbaTYy75NBKfZjj85nq7gGt/mSBGbAP
         ogcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0ze+QgMLpmpZqQVtz7PPfsGQnpr9JZr8AUVmKZcE2yRbRFMtDmBw+6oSTVhC9t2fHrwBBXccMXbMXsonx@vger.kernel.org, AJvYcCXnJvlqzak1KcinBtVC74mhblQGxmdHzrz/zQiTyqwid17sWBmytyk0rmjUL+Lf2NtRLy1UXaBDo+b1@vger.kernel.org
X-Gm-Message-State: AOJu0YwNxhkUVNFb4Bvq/AGf7p2oIqKuFHYkRE0NpnarCqEILMzmvt+7
	QSAuWdqGOPWFNZ0odG899vg7qyRonkCY5UH8K95No2yHcuuotomlJdnshPLAZDmfaCTUuQplPtC
	q683OEbXAHbxXmnI/dA4pHcEpak8bT6A=
X-Gm-Gg: ASbGncvOJUa8egaKvyVOLB2CMRpHDYPxum25jiOow9EKYOiiHRDfs+lxtDwvK+Lii8y
	hU/1tXS5IAfY2mRUwO/YBm7e0h0htcgevxaBz1i6CFVLnPDcT71kBQeDcko0NF4dV4QOZtfzyR+
	9Q+833ivhwsA94I0kALKxP3Zj5szY1n0q8H1vwh+sN9Lhcvq1BQDkWk71iU1xVlJYxYgn8khq8w
	6aPvUTyZjBcNQGcQ0lxS1Og2uA6hojYV2W8Ii0=
X-Google-Smtp-Source: AGHT+IG8HKFFrvXPwmFL0HGsDqh5gr6WMb1N9BQcImjwawf3PcPnwN+u1Q+Ebg42DYzKdWHh3ImGW0i7JXgl3MCjjUs=
X-Received: by 2002:a05:6122:d0b:b0:537:b126:bf07 with SMTP id
 71dfb90a1353d-53c8a2b2a8fmr1582470e0c.1.1755933977291; Sat, 23 Aug 2025
 00:26:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822060417.52935-1-alex.t.tran@gmail.com> <CAL_JsqKQEiGvt8H+7vO38PkMsmb3+CHvb=d2QcLd6zBOfNLs=A@mail.gmail.com>
In-Reply-To: <CAL_JsqKQEiGvt8H+7vO38PkMsmb3+CHvb=d2QcLd6zBOfNLs=A@mail.gmail.com>
From: Alex Tran <alex.t.tran@gmail.com>
Date: Sat, 23 Aug 2025 00:26:06 -0700
X-Gm-Features: Ac12FXzCio97Y1lti_VJO8_NgOsoiu5B6f0wrEzx9lyl0LDZH_IBSR8LGetMykk
Message-ID: <CA+hkOd6hcGAgmSsSuFdrXQU2p2OSfeuVL2re-dPzKpA5+DNVUg@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc/flattree.c: stringtable_insert optimization
To: Rob Herring <robh@kernel.org>
Cc: saravanak@google.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I didn't take into account the substring cases. Originally I thought
that incrementing by each string in the table would be more efficient
than by each character to reduce iterations but now with checking for
substrings it is more difficult. I could use strstr(haystack, needle)
to detect substrings and get the position on top of the changes I made
but the performance boost would be negligible. I'll drop this patch.

Thanks for the review.

On Fri, Aug 22, 2025 at 6:34=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Aug 22, 2025 at 1:04=E2=80=AFAM Alex Tran <alex.t.tran@gmail.com>=
 wrote:
> >
> > Increment string by string instead of character by character.
>
> Why? Are you doing something where this provides measurable improvement?
>
> >
> > Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
> > ---
> >  scripts/dtc/flattree.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
>
> This is a copy of upstream dtc. If you want to make changes to dtc,
> you have to submit them upstream.
>
> >
> > diff --git a/scripts/dtc/flattree.c b/scripts/dtc/flattree.c
> > index 1bcd8089c5b9..156ca5da89b2 100644
> > --- a/scripts/dtc/flattree.c
> > +++ b/scripts/dtc/flattree.c
> > @@ -222,9 +222,7 @@ static int stringtable_insert(struct data *d, const=
 char *str)
> >  {
> >         unsigned int i;
> >
> > -       /* FIXME: do this more efficiently? */
> > -
> > -       for (i =3D 0; i < d->len; i++) {
> > +       for (i =3D 0; i < d->len; i +=3D strlen(d->val + i) + 1) {
>
> This isn't equivalent. If 'd' was 'foobar' and 'str' was 'bar', then
> before we'd match. Now you don't.
>
> >                 if (streq(str, d->val + i))
> >                         return i;
> >         }
> > --
> > 2.50.1
> >



--=20
Alex Tran
alex.t.tran@gmail.com | 408-406-2417

