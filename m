Return-Path: <linux-kernel+bounces-885606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AED00C33721
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED8294F3BFE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF94224AED;
	Wed,  5 Nov 2025 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR2n8Zj1"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480121D3E2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301491; cv=none; b=SmCgee3gCJVqnUq4a1dtsr2ETaBZ/zsuGNzAXCuTFhoA3vqj49yCsZPHAVPG4d4abDr9Ht6aALsb6E50Kai42zPw6RqKkNIfEmiMdvsUKXi09PCMrLrhv2V1oUdokCJqw/K8F7Z//xrV4LLP652urClA/XD5PF0Y28VdVsufHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301491; c=relaxed/simple;
	bh=lSVnESYdfLy8nAkFll10s/SAT7iPd9NundFANgp6f5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrFKQOKK8MKN1+gFHHqVICQKwqcEUN0VJ+L97zmr+KoGmok0meiCkbMB/KRLRvT4ysihgdUk64QxG7koxtdAYuAYlWy4RXkg0Rlwqc/zkckFW8Je7FNldxqzGyCDzl5vUilpJsb+I2T8sPFQYIfdwD5umY+vxUzB4y7zcBYzxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TR2n8Zj1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34029cee97fso6291457a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301489; x=1762906289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8DZur4QOQcUHG1u/YJb+NGmHk1irYhxbax2sQBslrM=;
        b=TR2n8Zj1bcxbfN2x3chQ7p1qGhR0v79gApgz+kgHU3vNYnKMPCK4hR+6+mr6kBRAzA
         Db0aCnWMcOEfRYGnBbb7gkDMMzB0X47KSzyK2WlcbDBXbCqQjqEGYnkk5oN4a5zXeikY
         GKf2SqHN5gPoZLwjj3gEkF29FbXiA3a4g6XXQIAaFDcfMnVmOk0jfNlaRsN3QOPEza/g
         nKlGnrmaKBUB/aNCHDMXXkenj5SQYva0y9V93g5cgOQ4jHYACKLG1lj6ucVmiHa+uSid
         JOMsDeu/NT1z/R7pNpycA+VHQXUGUreOY02od9bk8is0oziExhrSdMlMRdccW5P3tpBW
         h/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301489; x=1762906289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8DZur4QOQcUHG1u/YJb+NGmHk1irYhxbax2sQBslrM=;
        b=gqpmMcf2/PI5WmfgycwlQqgNYKx7/d54tq4D3DMA5fcRAh6I74yZ7G8+f8kPeZ8ZMz
         XHoxqA3Tv0VGQUq/oXpAYSbfrfzK9mqbzjKFX9VwYG1uea+/y8zPuEx1kKSjZfXU0KT5
         gH6NiqiCXbj+C9nDM73UL0sXuVMUDMNRLHu/TYQYr2Jx2b9ipyLnjLxSxsE9EVB/kqtd
         CwtP7rtzHsfRcCb0FT2Ur/XQYENBr5zeYmurj5ZnVIiUAcErFstX2GBf6YYDipVawM4t
         aK7PCj0Ivutd6o/Mw7RSt0PGg1LLRo/eB4RUOIm2omMj0VTczYIMm7HJ2TzQBv6nJLwa
         CirQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk78FHQDwpAnEX4+WZy8P+2V6aKAwf3sYoB7FxLtdR/xTg2XBOpwFiHvh5i9YIZXlhMJwGPRs4ywTOElg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJI5y6sDFQSddTO6qTH9uxWHAm2TcH1xvZbzcTE4NcnWt9JCac
	G+kQViiruzcNHMFNOn6+8xfC9VKx2dc8Z/Sc6dZafdi9z77UeZsxzV+cLrmt020Em+/ioJVbzP9
	I2dRnGBvXycml+AljFlXQy675ktQvWVM=
X-Gm-Gg: ASbGnctRbWUnnX0zIOjyHAcNah/LL4713FJv8m8kOMdk4gg+wmeed4+qOF/KROPTLcD
	NSb0E0c3gulc6qmUw3Usu2Lddb8nulOPNJKNEc6wvEcVihq0SuwAyC6LRJ9DCgYafT+x+gdSEyx
	KUURmDGoO5HXCN2xg7w5DKxCb1vz8NmoNCRF5VaDIPVIMn4xL+R1v3e4YaylWwdMt9qh8JyFess
	hVkcR0uUdz0b+7qPmZdAC+X9+195r+uSGBPv/ib+axkgNmQzvbPvf+aiNWBxSvrUofMTTyxb4tI
X-Google-Smtp-Source: AGHT+IEk6UnkPbgevIb10GIbQiAWkN1BTifm55vgK+7RHHx0xOq4hXNKY+5/MYTSs3zQxV+apFFLvnhHIUuf92znXow=
X-Received: by 2002:a17:90b:3803:b0:32e:3c57:8a9e with SMTP id
 98e67ed59e1d1-341a70091c9mr1450345a91.35.1762301488775; Tue, 04 Nov 2025
 16:11:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com> <20251104134033.344807-2-dolinux.peng@gmail.com>
In-Reply-To: <20251104134033.344807-2-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:11:14 -0800
X-Gm-Features: AWmQ_blR0Xr3KPtmsM6E46MV3vRaErLLKXxfHExgU4F8QXTbLGLGRhtclxsbFkI
Message-ID: <CAEf4BzaPDKJvQtCss4Gm1073wyBGXmixv4s9V5twnF7uEHRhPg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/7] libbpf: Extract BTF type remapping logic into
 helper function
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Eduard Zingerman <eddyz87@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song Liu <song@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 5:40=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Refactor btf_dedup_remap_types() by extracting its core logic into a new
> btf_remap_types() helper function. This eliminates code duplication
> and improves modularity while maintaining the same functionality.
>
> The new function encapsulates iteration over BTF types and BTF ext
> sections, accepting a callback for flexible type ID remapping. This
> makes the type remapping logic more maintainable and reusable.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>

Signed-off-by is supposed to have properly spelled and capitalized
real name of the contributor

> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  tools/lib/bpf/btf.c             | 63 +++++++++++++++++----------------
>  tools/lib/bpf/libbpf_internal.h |  1 +
>  2 files changed, 33 insertions(+), 31 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 18907f0fcf9f..5e1c09b5dce8 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -3400,6 +3400,37 @@ int btf_ext__set_endianness(struct btf_ext *btf_ex=
t, enum btf_endianness endian)
>         return 0;
>  }
>
> +static int btf_remap_types(struct btf *btf, struct btf_ext *btf_ext,
> +                          btf_remap_type_fn visit, void *ctx)

tbh, my goal is to reduce the amount of callback usage within libbpf,
not add more of it...

I don't like this refactoring. We should convert
btf_ext_visit_type_ids() into iterators, have btf_field_iter_init +
btf_field_iter_next usable in for_each() form, and not try to reuse 5
lines of code. See my comments in the next patch.



> +{
> +       int i, r;
> +
> +       for (i =3D 0; i < btf->nr_types; i++) {
> +               struct btf_type *t =3D btf_type_by_id(btf, btf->start_id =
+ i);
> +               struct btf_field_iter it;
> +               __u32 *type_id;
> +
> +               r =3D btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
> +               if (r)
> +                       return r;
> +
> +               while ((type_id =3D btf_field_iter_next(&it))) {
> +                       r =3D visit(type_id, ctx);
> +                       if (r)
> +                               return r;
> +               }
> +       }
> +
> +       if (!btf_ext)
> +               return 0;
> +
> +       r =3D btf_ext_visit_type_ids(btf_ext, visit, ctx);
> +       if (r)
> +               return r;
> +
> +       return 0;
> +}
> +
>  struct btf_dedup;
>
>  static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf=
_dedup_opts *opts);
> @@ -5320,37 +5351,7 @@ static int btf_dedup_remap_type_id(__u32 *type_id,=
 void *ctx)
>   */
>  static int btf_dedup_remap_types(struct btf_dedup *d)
>  {
> -       int i, r;
> -
> -       for (i =3D 0; i < d->btf->nr_types; i++) {
> -               struct btf_type *t =3D btf_type_by_id(d->btf, d->btf->sta=
rt_id + i);
> -               struct btf_field_iter it;
> -               __u32 *type_id;
> -
> -               r =3D btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
> -               if (r)
> -                       return r;
> -
> -               while ((type_id =3D btf_field_iter_next(&it))) {
> -                       __u32 resolved_id, new_id;
> -
> -                       resolved_id =3D resolve_type_id(d, *type_id);
> -                       new_id =3D d->hypot_map[resolved_id];
> -                       if (new_id > BTF_MAX_NR_TYPES)
> -                               return -EINVAL;
> -
> -                       *type_id =3D new_id;
> -               }
> -       }
> -
> -       if (!d->btf_ext)
> -               return 0;
> -
> -       r =3D btf_ext_visit_type_ids(d->btf_ext, btf_dedup_remap_type_id,=
 d);
> -       if (r)
> -               return r;
> -
> -       return 0;
> +       return btf_remap_types(d->btf, d->btf_ext, btf_dedup_remap_type_i=
d, d);
>  }
>
>  /*
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 35b2527bedec..b09d6163f5c3 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -582,6 +582,7 @@ int btf_ext_visit_type_ids(struct btf_ext *btf_ext, t=
ype_id_visit_fn visit, void
>  int btf_ext_visit_str_offs(struct btf_ext *btf_ext, str_off_visit_fn vis=
it, void *ctx);
>  __s32 btf__find_by_name_kind_own(const struct btf *btf, const char *type=
_name,
>                                  __u32 kind);
> +typedef int (*btf_remap_type_fn)(__u32 *type_id, void *ctx);
>
>  /* handle direct returned errors */
>  static inline int libbpf_err(int ret)
> --
> 2.34.1
>

