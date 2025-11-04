Return-Path: <linux-kernel+bounces-885221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CC7C324CF
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7EA1884241
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC73626CE17;
	Tue,  4 Nov 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUkxBdIB"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62985328B6D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276504; cv=none; b=RhTqGEvwDoqzkDlKFcVTgH5DQc1qUFHj04h6YbgfG0wR/J8boup9Z8eCCjWZu7sh6KUeKoI9aQWN6YeU5x+7asVlV4nYK7iRHMdL39tcreCNutGzu39bOmrZs05e3EZQccrAh9tmtAhhsyLuIWEV3fQ1CrQAw+loncp8Oz2sqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276504; c=relaxed/simple;
	bh=ltIUAp0Ncm40SN9BDjzL4HOekKSNBiLZaLjfDxM2WI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Up70C1/rodMgvX3nbvIaNJbnU4qwBWzc67CjIrNvZZkpswIRdIJIWeo21Ir+uzyt9G8ylfNGCiVvbTUhJkS/uVe0xl9pKhvhcT83kgje/HtNKuLwdBZYoii3gV5sp0BCuTtTRbvcv+R37wVYW3zBXhWp+t5iWMXLhGEiLX1mHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUkxBdIB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429b7eecf7cso32538f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762276501; x=1762881301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaoZBohhvrk9X6IahLs5KKKjtGD8B8F0O49y85YnKU4=;
        b=HUkxBdIBY+J35m0xUGG7MY2onj409bNlPRj2A4qygLvuKjwHDnEWjJe8Qn8Gcq6K81
         lZtsU1DtpMMdPfsLQvujK5YkIDYxSZGTLFSr+gQZs9Sjz5PX5edMo16qLi1y0m/1Q3is
         1PJ6r136P1zIj4CrXGJ3Hec/EHyINEh8+tH9dF1JNxMrsJAlKbxSj55Iz/3tKpG1B2Rb
         2EtLeHftt769A+lMIRQ4Ddbi31RNgRRjDdLtjLUZsN0qAGElgvO5BKMK5gYvetk++Z5w
         wds/R7ZefwFGHfgD/OLfkZS8CCZxHcOD8Oz6s+8r9txU8boVefBH2o0+ICTR1zOrcyAE
         gbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762276501; x=1762881301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaoZBohhvrk9X6IahLs5KKKjtGD8B8F0O49y85YnKU4=;
        b=NrKifS0d2j92pvLiBRla7ynsWwuElQiQZ6iYK2xzD0izvpq9hks5tv4+K4zOxu887M
         jASexXj1THh1SiWhoKd45rsSYzsnVneAiC90ZgGmWCKA3jZDfTmOaqGXFaNa3YzI2LGO
         HsD5VJfBEU0NmHsa6y0uAcV7SCFgrfxyhlSI+2uIBh4AmZztx4EH6ZiYVdEG9mR3uBco
         Ajs8xe7gA5p6yL80yQ5rs/bElFGtJYdyFYiVBugcTrTkqf0csf6iIDuLG6fKCEVNMVKL
         nf3OG4jL/cCu7OQAHbcfR87nNz8vWo3rsbzdZAX1eJ5MOstLmL+ibcQ9l7qzijai0iCe
         tJfA==
X-Forwarded-Encrypted: i=1; AJvYcCXe600/hAjGpsM4UTR72rXG85aYoEm76xQ+PXD56pixsk6waRM4puxhGwhL1K6cyj4VJM1HWaUEmGF49qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAi7gFfk6/fDcgBjA9NcWTuSCKfaSPryYngxrSRS/UOsAcm1XN
	tvjMWbuaQ00e/ZR8VBdWElMAIIDvpheV7ZqFH9VHur/ayErtKN97uMzz/hSFksuy8tmcXBYAUZN
	5ImB+8sR+R/Q/gXjQCxo4IlS+QwltIOBm69/f
X-Gm-Gg: ASbGncvBKYl9uwc6da6zRfZ7kMinGfVTuEXERnvqcLOGxIXhhF7GmC2TMo9U2WHTQaI
	wH23uo76Dna21I6MnA0W7ygO/FME3gCaxA/M5i2oNJAoWgpv18VPL5hIna7RXZuGXt1Nvqz8mlN
	JJGoNdjF/b7b69VySvP7RggCEzOrocwtOYb2Nfpl47cbd8XSpDTqDtMCnP/RC//d3Ra2IzgBX1D
	D8YdjFbrB1lNQpORJ5oyt01o97j1X3j03Ron8nhohD79fXayG6YU1ZPsLsZJsCM0hwF3fGfTPzB
X-Google-Smtp-Source: AGHT+IGyQos6i+6j/fPgHNGknJkZvaAenzHKb/XWKRbP3p2LX3ZKsQKIZE+UqBYq7tnH5qZdQgMou/Il4fE7m3DsbC0=
X-Received: by 2002:a05:6000:1a8d:b0:428:56ed:c68e with SMTP id
 ffacd0b85a97d-429dbcdfec7mr4087672f8f.9.1762276500501; Tue, 04 Nov 2025
 09:15:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com> <20251104134033.344807-6-dolinux.peng@gmail.com>
In-Reply-To: <20251104134033.344807-6-dolinux.peng@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Nov 2025 09:14:46 -0800
X-Gm-Features: AWmQ_blqBVF2gna_7Kls9kKFTqv1JFkdXlNKRWyoszSCf_T5Zve1vrCP8cG0qoQ
Message-ID: <CAADnVQKxqScrBhTKOXcwSL_mVXE36YQ_yQX7qwg8C3X1ZnXHnA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 5/7] btf: Optimize type lookup with binary search
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:41=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Improve btf_find_by_name_kind() performance by adding binary search
> support for sorted types. Falls back to linear search for compatibility.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  kernel/bpf/btf.c | 111 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 101 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 0de8fc8a0e0b..da35d8636b9b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -259,6 +259,7 @@ struct btf {
>         void *nohdr_data;
>         struct btf_header hdr;
>         u32 nr_types; /* includes VOID for base BTF */
> +       u32 nr_sorted_types; /* exclude VOID for base BTF */
>         u32 types_size;
>         u32 data_size;
>         refcount_t refcnt;
> @@ -494,6 +495,11 @@ static bool btf_type_is_modifier(const struct btf_ty=
pe *t)
>         return false;
>  }
>
> +static int btf_start_id(const struct btf *btf)
> +{
> +       return btf->start_id + (btf->base_btf ? 0 : 1);
> +}
> +
>  bool btf_type_is_void(const struct btf_type *t)
>  {
>         return t =3D=3D &btf_void;
> @@ -544,24 +550,109 @@ u32 btf_nr_types(const struct btf *btf)
>         return total;
>  }
>
> -s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd)
> +/* Find BTF types with matching names within the [left, right] index ran=
ge.
> + * On success, updates *left and *right to the boundaries of the matchin=
g range
> + * and returns the leftmost matching index.
> + */
> +static s32 btf_find_by_name_kind_bsearch(const struct btf *btf, const ch=
ar *name,
> +                                               s32 *left, s32 *right)
>  {
>         const struct btf_type *t;
>         const char *tname;
> -       u32 i, total;
> +       s32 l, r, m, lmost, rmost;
> +       int ret;
>
> -       total =3D btf_nr_types(btf);
> -       for (i =3D 1; i < total; i++) {
> -               t =3D btf_type_by_id(btf, i);
> -               if (BTF_INFO_KIND(t->info) !=3D kind)
> -                       continue;
> +       /* found the leftmost btf_type that matches */
> +       l =3D *left;
> +       r =3D *right;
> +       lmost =3D -1;
> +       while (l <=3D r) {
> +               m =3D l + (r - l) / 2;
> +               t =3D btf_type_by_id(btf, m);
> +               tname =3D btf_name_by_offset(btf, t->name_off);
> +               ret =3D strcmp(tname, name);
> +               if (ret < 0) {
> +                       l =3D m + 1;
> +               } else {
> +                       if (ret =3D=3D 0)
> +                               lmost =3D m;
> +                       r =3D m - 1;
> +               }
> +       }
>
> +       if (lmost =3D=3D -1)
> +               return -ENOENT;
> +
> +       /* found the rightmost btf_type that matches */
> +       l =3D lmost;
> +       r =3D *right;
> +       rmost =3D -1;
> +       while (l <=3D r) {
> +               m =3D l + (r - l) / 2;
> +               t =3D btf_type_by_id(btf, m);
>                 tname =3D btf_name_by_offset(btf, t->name_off);
> -               if (!strcmp(tname, name))
> -                       return i;
> +               ret =3D strcmp(tname, name);
> +               if (ret <=3D 0) {
> +                       if (ret =3D=3D 0)
> +                               rmost =3D m;
> +                       l =3D m + 1;
> +               } else {
> +                       r =3D m - 1;
> +               }
>         }
>
> -       return -ENOENT;
> +       *left =3D lmost;
> +       *right =3D rmost;
> +       return lmost;
> +}
> +
> +s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 ki=
nd)
> +{
> +       const struct btf *base_btf =3D btf_base_btf(btf);;
> +       const struct btf_type *t;
> +       const char *tname;
> +       int err =3D -ENOENT;
> +
> +       if (base_btf)
> +               err =3D btf_find_by_name_kind(base_btf, name, kind);
> +
> +       if (err =3D=3D -ENOENT) {

Please avoid the needless indent.

> +               if (btf->nr_sorted_types) {

looks buggy,
since you init it to btf->nr_sorted_types =3D BTF_NEED_SORT_CHECK;

Also AI is right. Init the field in the same patch.

pw-bot: cr

