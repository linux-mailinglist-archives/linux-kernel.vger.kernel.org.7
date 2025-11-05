Return-Path: <linux-kernel+bounces-885643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CACC33951
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6CB584E55A5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B5523ABA9;
	Wed,  5 Nov 2025 01:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTx0A90K"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C673D561
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762304671; cv=none; b=SC2/mO36TRzua1VhownmLtlX3MowcNX9QmoHJX+niXX6F0FInkzpOPZzBnI9j3fayoie3eNdPdVckF2l7cFX/Ud7hNlZ9qAIQWmVqbryTKXt3IH1ngW3Uxwf77nnEUZXTke14Eowc5LZkm6ilkgLS9beKwS770vu28Sd5ul3SQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762304671; c=relaxed/simple;
	bh=Z3ggOd79JIfVyZEfAZAtw3TjnsZLdnZxlRzWgxmQzaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRIs3uv7iw/RzJMwlo17NKjKWJifLL7sm6hIUOXPu8Iblzjw7liISinxDQ36eikGIvjTH2g9so8TrgO2K9GnV7uovUs//+R6M47ttY548vbPq4x4m6GmkppeHJLuaQX2pzrN7DgJoBG0N3TkVxH7/Swjl3yeMRGCqdj6ox/VKfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTx0A90K; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7ae1557db07so356601b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762304669; x=1762909469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyIWyvuzANIOMw4QMzwwGGDQv3dBT6iTuP4G+fMtDdA=;
        b=PTx0A90KIoDFyq2FG3Ie5oFJzWQDabFoCSrHbp4Qs1sN5vy+mQ+Nrs2UAxuWT0A6DO
         crnVRHNvkSf0bf/hQYCV1yWjpjSg+R9MXc62HTPq5FS2EM6VJOZ4CDNFpZp/yLg7+NVv
         UcZNlubmduFSX4hD3WRTf5WxP4ZhQIMkE7EQj+ETqh+JEsLqogCj+gxJ4OBcDxVYM4Pf
         QZQIDzPon6K6HdmkjtMNqgTxlXuH5Gjqb8mg17591gzF66Vg+JriuUGSxPzkVmGdpnF7
         P9qme9u4hKE7FXfZzM9cpOTIAjtkpRToWleyNyGhvIclTDzlkR1/u0lH4Tyn5dPfmddX
         XHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762304669; x=1762909469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyIWyvuzANIOMw4QMzwwGGDQv3dBT6iTuP4G+fMtDdA=;
        b=a0qBKCNPZUpP8HSBLrVCz6Ncp5BUNwpYyk8+tN+1CUxT3GmO0AvtaHahxF/CUn/m/T
         xkERVseFOhiAwoZRPPbksIYvdawpSj05kNsDNG+JCCwjE0phtCA0uMqWvXtxsR1qb3KQ
         U2taI4xQneIUTr2bLvaMfFJf6S2AZVyws5lPzJ9x6dImGFHUEDuW+RzNDMnDhwGdi4pE
         YovkArALq/KFaT7d3c8im0XMaWpkCTI4b0AQk25Xg1jGBJwZWzmFTu3d6A2GY32yfbVX
         Zcfa6pgt2mjVVC+uA3gS3MNOpNtI669ck67FUitrHIbBDyUPpt7GU7nrmvgEK9QZbOEL
         uJUA==
X-Forwarded-Encrypted: i=1; AJvYcCW3RVWUZ7drarjd77YueDn9KP3vS8tpeHbdODqRCQg7369JuElb2YH7Tg8u2xBlthNFHb2T4odUnDlg/wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsMbQx+oS+239QYWcuZZcW9hl9IaW3EdGGr0G3gh7DwFQ3dyZ
	z0ZmeU4hGOEWGHWHiL/EUcSW7qYXMkQ2X0wBHiOSIndq5AADs9Hq+XXFNMTi8LyDDNDrujJDuQ2
	gNDCyRR5R1FHxS55Pf40AHuWaShyfbEM=
X-Gm-Gg: ASbGncvvu66r2t8fO/WytGNkjJAiXtTgkAigv1Dm1fNMjVUnRbiHV2n5tmE9Ow9thBE
	PtNREPUFxOn7gLW/rXBX+fTz8oizdtMSZykQGr6E+9P9bEuNm26cOrIJYuQiZP1DNtsc8c7aH2m
	s7wNOovyp+9sCvyHd1mBH72jRnoViIwd5xSHQz12DzQxr9O+7LcwxrSjirl9+LMRqm4warC2XQz
	989P8fv3sw76p57bw7ILSssLA3sg8v8f/Cat7hyHYvmT8dvV9jd5FdyfK34r5KjOp1wB0MV0Ktd
X-Google-Smtp-Source: AGHT+IHN9o9P5gsHic+cho4sct0SlI6+Z01PLaJzI6naRoeHnQGt1ns3gsNXfqNGaPUEo7GbL2ekFCXyO4fl6JANjM4=
X-Received: by 2002:a05:6a20:3d23:b0:342:1aab:4c71 with SMTP id
 adf61e73a8af0-34f839f5a40mr1651389637.4.1762304668722; Tue, 04 Nov 2025
 17:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
 <20251104134033.344807-3-dolinux.peng@gmail.com> <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
 <3986a6b863be2ec62820ea5d2cf471f7e233fac0.camel@gmail.com>
In-Reply-To: <3986a6b863be2ec62820ea5d2cf471f7e233fac0.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 17:04:14 -0800
X-Gm-Features: AWmQ_bmQV6kvOsH5MHQ6mKpg2Ftv3sZCOkYRFAWo0YOCNhpEqpNzsfdyfIrVm9Y
Message-ID: <CAEf4BzaLmVuPRL4V1VKBmaXtrvT=oLwo=M7sLURgoYU34BkpMQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 4:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2025-11-04 at 16:11 -0800, Andrii Nakryiko wrote:
>
> [...]
>
> > > +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> > > +{
> > > +       struct btf_permute *p =3D ctx;
> > > +       __u32 new_type_id =3D *type_id;
> > > +
> > > +       /* skip references that point into the base BTF */
> > > +       if (new_type_id < p->btf->start_id)
> > > +               return 0;
> > > +
> > > +       new_type_id =3D p->map[*type_id - p->btf->start_id];
> >
> > I'm actually confused, I thought p->ids would be the mapping from
> > original type ID (minus start_id, of course) to a new desired ID, but
> > it looks to be the other way? ids is a desired resulting *sequence* of
> > types identified by their original ID. I find it quite confusing. I
> > think about permutation as a mapping from original type ID to a new
> > type ID, am I confused?
>
> Yes, it is a desired sequence, not mapping.
> I guess its a bit simpler to use for sorting use-case, as you can just
> swap ids while sorting.

The question is really what makes most sense as an interface. Because
for sorting cases it's just the matter of a two-line for() loop to
create ID mapping once types are sorted.

I have slight preference for id_map approach because it is easy to
extend to the case of selectively dropping some types. We can just
define that such IDs should be mapped to zero. This will work as a
natural extension. With the desired end sequence of IDs, it's less
natural and will require more work to determine which IDs are missing
from the sequence.

So unless there is some really good and strong reason, shall we go
with the ID mapping approach?

