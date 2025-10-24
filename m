Return-Path: <linux-kernel+bounces-868321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0604C04DF9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A031881360
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E9F2F6194;
	Fri, 24 Oct 2025 07:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wi2oG8yn"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445002F0C7F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292564; cv=none; b=TAMDo0Kty66nv0pFaztaucEcM+MZ08QfxPtxD3QHxueSEMqBa4q9ODZsLng/ulwozQmCDO9/HjMmck2euLBbYz6+3nVhx4egCYyEEBJD4kMRA9+QkBomWxquxHXLfoPSKScxpuLZNkk37ReaAKKqemnTHv1FlwcUZlHwdgUPZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292564; c=relaxed/simple;
	bh=ijNMXAGHEloq3MWzjWdu519b1yKZRu4keumrCc47LMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuaLAbVFj4o5XSqsGcT8FBlwr2wKP6+Fs1CZK3yT2XqDtGwBFjwq/95vzFt7J0+bD9zW1qvbduCx6NXBejGR9oQKjh1Vktbu6b8xnZ1ggxjHgQpNvQfZV9qcnPm6iM++2dNDpQZSO1aoCEtJfnJGSXvzCUPYhlJn18IxMNK/rYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wi2oG8yn; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b6cf30e5bbcso1211054a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761292562; x=1761897362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uRO27mPvjlq1Gmjws1js7XoJW9NFcThjF4sz95gEPw=;
        b=Wi2oG8ynRH1k1lgIQ71f+1CprFEpH9ecIGdu3xd/Q81yEbkWTBH99pkyABzXrCsrij
         LN5M4UZo1GWEFLDZSTtJPLfEVtpoONf2DvLUunyig7RC/G+YUk0Bgo02jtFoH2pCgGnj
         5St9w2GjiDJ3ZHS+xkgKAqGjB7eA15it6W5/JoMVN1gTj1qSd62GS4lZOru1ApZ62Snj
         rTiOSrLzIr+uxdqEzp4bNjgBw6joSlI/1YF+5BLFLKvV2oiPxKCHSjgObeZ05BamESLU
         7Q0YOR4s2hwOJ/MKC87ImQgxRkUiyCQDpHIJkQWq/jjtSBPQ5dX/Gb0S+7QFx8Z+Jhbk
         xeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292562; x=1761897362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uRO27mPvjlq1Gmjws1js7XoJW9NFcThjF4sz95gEPw=;
        b=R/kTtYjTw6yqdDUD2zXG32Q2n1C+d9vOTVs6ReUvrG/RFJU0s/oS10OYUsvlhnjLeA
         2X5IwdfFYi7iy60SDLItvkxvz4MbtPwcSTPKCKE549fLQ8mIiWp3EmS6GiYwGwwcO/I4
         MA2MiU2613K+RpftHpxMwYl063mUT2gAMwXKv0qCB7yqoVB8mWjQgx2PmtL6rG76KV5w
         LamRjd4b8fXlwtvDum2hC0HY6600+cl41TXxndI33wPm7ytWakm91iDbGLfRmzhTFkxq
         waMfjcL4z+9yJTiwVnwgJA1CkkZFrsob19dg0fY7XemIH/IIHvgfZ2PnaJ08VYQu7UIh
         YlDQ==
X-Gm-Message-State: AOJu0YwmQPv0uJByBPJYtgLWIaM3O6yqcAkoULqZZb/9lLGUGAY8RmtU
	EgNePG5ib21c5LRmUkBqitrU+jYh38EhATtNj+vwNPBnTcO8bX35ZzRMBk7NwR/vothNLTQqPs3
	GTNKfmpg+B0h3uLHVQxdtogURrnvv8lg=
X-Gm-Gg: ASbGnct8T3cSZgbDazZFJWTscwbVX0GXCWQH5oEhgMJ5SjWZ9Srx3zsP/yfIA+nZEb1
	Ke/R7qGxbez4nR+SjM1HKctcBOtaAadPM2qPNqpAezo/SxmAwuMmCjCoumYGHRJGePajokKIK3b
	yfjSu7BTUD5WE3Wx7KzBl2j0q2tQYIJ21wPcpjlFEPpcYYxBVMZK5mrymMAholfK1irpo3aJ5t9
	KzksixOH3uSKWVKEnAcUtLi9UivtwQu0bWrXRK3G3YyZD6ziLdjm58W1mtBf5lSNYhMve0=
X-Google-Smtp-Source: AGHT+IHK8ra9yfzuc4UzCuPOPCF0a9fkZ6OHOYa7+1mzZSw8cgx/k2AvqlS08ZKXCgOl+bU90FQCGSikyL5fPfxHaF8=
X-Received: by 2002:a17:902:c411:b0:249:71f5:4e5a with SMTP id
 d9443c01a7336-29489e619a7mr22649315ad.26.1761292562492; Fri, 24 Oct 2025
 00:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024060720.634826-1-jianyungao89@gmail.com> <aPsjSZtNxeQK239J@krava>
In-Reply-To: <aPsjSZtNxeQK239J@krava>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Fri, 24 Oct 2025 15:55:51 +0800
X-Gm-Features: AS18NWBZaG0Ysv0zopji-OZrXuo35dlHz4dN9X8MiEYrk2THM63xKhszYGw9le0
Message-ID: <CAHP3+4Dg7aBqaVWs5vfydtWuSpuRS+p43XNJk9TwxAPrVm=7NQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: optimize the redundant code in the
 bpf_object__init_user_btf_maps() function.
To: Jiri Olsa <olsajiri@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri, thank you for your review. And I have realized my mistake in
this patch. I will fix it in the next patch!

On Fri, Oct 24, 2025 at 2:57=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Oct 24, 2025 at 02:07:20PM +0800, Jianyun Gao wrote:
> > In the elf_sec_data() function, the input parameter 'scn' will be
> > evaluated. If it is NULL, then it will directly return NULL. Therefore,
> > the return value of the elf_sec_data() function already takes into
> > account the case where the input parameter scn is NULL. Therefore,
> > subsequently, the code only needs to check whether the return value of
> > the elf_sec_data() function is NULL.
> >
> > Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b90574f39d1c..9e66104a61eb 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -2988,15 +2988,15 @@ static int bpf_object__init_user_btf_maps(struc=
t bpf_object *obj, bool strict,
> >       int nr_types, i, vlen, err;
> >       const struct btf_type *t;
> >       const char *name;
> > -     Elf_Data *data;
> > +     Elf_Data *scn_data;
>
> makes sense to me, but this rename breaks compilation later on
>
> libbpf.c:3027:53: error: =E2=80=98data=E2=80=99 undeclared (first use in =
this function)
>
> jirka
>
> >       Elf_Scn *scn;
> >
> >       if (obj->efile.btf_maps_shndx < 0)
> >               return 0;
> >
> >       scn =3D elf_sec_by_idx(obj, obj->efile.btf_maps_shndx);
> > -     data =3D elf_sec_data(obj, scn);
> > -     if (!scn || !data) {
> > +     scn_data =3D elf_sec_data(obj, scn);
> > +     if (!scn_data) {
> >               pr_warn("elf: failed to get %s map definitions for %s\n",
> >                       MAPS_ELF_SEC, obj->path);
> >               return -EINVAL;
> > --
> > 2.34.1
> >

