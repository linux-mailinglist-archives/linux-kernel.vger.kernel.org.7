Return-Path: <linux-kernel+bounces-885607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B24C33730
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153F718C6C81
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8353E22D4DC;
	Wed,  5 Nov 2025 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMHClgnc"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1D2222CB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301506; cv=none; b=fX5HWJldWVHVpcx6mu9gQATXl79PZNVa76cKoW0nA3kIkNa+1kH1YkNjGd0SXfXmyc3ZlhV6XogAvSy7bVNR8B/516GsAmJYeittI0xIokvOaFWI6/7eTv1Iy6lWEeuGUUkF3IXNTUCXfmkAQ3UO/r7H02rJPBxcf/Wcf0rBNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301506; c=relaxed/simple;
	bh=9upztcecBw1kEpkmS9jAWoAKMVSODXK+8nFThvHapWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEZwQy1xCmCP1dxvbNFcOHVfiTNAuN8dS6dcucwtA1Vj/XptKdEmaSZs9Bm1qrOwpupcwHH1IYTd8NU+xEzqiX8plvojgqGVzxXeWybQgSsrKAfiRmby1TaD/ao7McEZn/yYYBoOq3N2ZEMr4Y17cBntiMam9b+LTx5KsmStXLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMHClgnc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so291352a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301503; x=1762906303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tavMxAjGzhkDnTwrSVYGUhACYFwW8M8/eQz6V2FuWRY=;
        b=IMHClgnckx9u+4AKCOhUueNuM/La5AvRBIYua2WD3rEV93DlpLjdoQ4PFVUI+9/IxQ
         oyWE5AxFOj2IwIk5LknW3XCta7Xwqs/bpYCnoWAdimzjyBy9pw1QH2/fUmrU+JxxQfPt
         llS2pjCbJ1olTz767KXzlZtCGmRKMesL9kHD0FRkwhkBc5RUOoqaSDmwyc2fieHHyrYT
         Q8AUuZY6NRHfstt3+YT/gyaT7cdYywknw5ORNMRkwsTIzEhhGAmTkCwTZubJpJEzLBMm
         PaD6zJhPD2f7466ZbKLTBpKFD1nmF3C0NbScbaobc7wU+t9PTIAB3JlulzCnb1T9Ob7S
         sPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301503; x=1762906303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tavMxAjGzhkDnTwrSVYGUhACYFwW8M8/eQz6V2FuWRY=;
        b=Fl9pjDjrkq5oVAyIzFXd3VOzl4wkzsZXRbvvRuWTgpXIU6uhWltrjGA3b5PWMNZ/9z
         gLZ6FGaPwN7RdoRMZ4XCegvvD9s0L1LhlfBhXDuHpekHuvtI2ou4EoQ+J4CYAjUypaM/
         L/eWg9GR/zNKrKKEiLTspiVxNumRqe2wIsz6B1DPnbxJ29Z2o2X0IaQ+z/NSX8kjArE7
         G3xRpUW0pYIOp5ulN//hQyI0uc8jiizBBfTB4w5K2UfHumoG8u05CZrLvllZmNoTZrRD
         4GHckBUimUEo51rXJ+rSGX3uk2SP2gboI3obPiDx5TSbGBm6GpLp0tjwwxF3f3o3r2qZ
         LNgA==
X-Forwarded-Encrypted: i=1; AJvYcCU4IT/cZCcbgwxYw+wB71QmDu+Dz5ziGL94oXD0kTtE6jTJPIMdhhq35+8doHe3/Ejf0Lhm2/7jZS+mxUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpIlRBT0Hj/vvx8peNtr7KSLlad+DUCm0DVZF63yB7fx+IE8KK
	O5WX5V7rTDQvK0YO8+f5EAvmYVoGFK/9aFPO4LCspK+QW0ex+lEOS18FsW6d18yKY1whNZolL+S
	bkua+Zr7xgFboAprE5c+LdqpKZoyMWKh0lA==
X-Gm-Gg: ASbGncsXED0DwY2v+BPdoMUFDFntuSiptaHqzF5f7ikE77Lc8d0UpbhR0+XsqTzIGwl
	5nx9stW+bWKi6OU3NaT585cj7hLrWTrNZXfYJ6LsjFzQ1d1RxMHQv3JFSNLvBVXF/q0vMOITHb1
	z8y4pZ01DbYzT4ok9ULJboYKyVDf4z2bo1AK9XT8jcmzFpFoBD05bmBaBQg3ggKBhW6nh27p7Jx
	+qMhAm9Bhgskh3JIrssZGTSGLS0SOS0DZOd3hDmO1Q2P1+Uvv2vCnMM+rEbO/ZE6lGsUiCMJVtr
X-Google-Smtp-Source: AGHT+IECJTq7hC7va2Tb+2EUQVphnvTYI9W5nwU4nLrwtxEFOQhPe6QAUq7lvxwUqOc+0do9fME4c6DHDyp4Zl5yljU=
X-Received: by 2002:a17:90b:1c12:b0:32e:72bd:6d5a with SMTP id
 98e67ed59e1d1-341a2d96ec1mr2143546a91.1.1762301503256; Tue, 04 Nov 2025
 16:11:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104134033.344807-1-dolinux.peng@gmail.com> <20251104134033.344807-3-dolinux.peng@gmail.com>
In-Reply-To: <20251104134033.344807-3-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 16:11:28 -0800
X-Gm-Features: AWmQ_bm1h86K6WKFYU_6X_6KUHNRi6qmkA3JSaPBKDpA07CQgGN1hfN_3SGYDjw
Message-ID: <CAEf4BzaQ9k=_JwpmkjnbN8o0XaA=EGcP-=CBxmXLc3kzh3aY3A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/7] libbpf: Add BTF permutation support for type reordering
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
> Introduce btf__permute() API to allow in-place rearrangement of BTF types=
.
> This function reorganizes BTF type order according to a provided array of
> type IDs, updating all type references to maintain consistency.
>
> The permutation process involves:
> 1. Shuffling types into new order based on the provided ID mapping
> 2. Remapping all type ID references to point to new locations
> 3. Handling BTF extension data if provided via options
>
> This is particularly useful for optimizing type locality after BTF
> deduplication or for meeting specific layout requirements in specialized
> use cases.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  tools/lib/bpf/btf.c      | 161 +++++++++++++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h      |  34 +++++++++
>  tools/lib/bpf/libbpf.map |   1 +
>  3 files changed, 196 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 5e1c09b5dce8..3bc03f7fe31f 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -5830,3 +5830,164 @@ int btf__relocate(struct btf *btf, const struct b=
tf *base_btf)
>                 btf->owns_base =3D false;
>         return libbpf_err(err);
>  }
> +
> +struct btf_permute {
> +       /* .BTF section to be permuted in-place */
> +       struct btf *btf;
> +       struct btf_ext *btf_ext;
> +       /* Array of type IDs used for permutation. The array length must =
equal

/*
 * Use this comment style
 */

> +        * the number of types in the BTF being permuted, excluding the s=
pecial
> +        * void type at ID 0. For split BTF, the length corresponds to th=
e
> +        * number of types added on top of the base BTF.

many words, but what exactly ids[i] means is still not clear, actually...

> +        */
> +       __u32 *ids;
> +       /* Array of type IDs used to map from original type ID to a new p=
ermuted
> +        * type ID, its length equals to the above ids */

wrong comment style

> +       __u32 *map;

"map" is a bit generic. What if we use s/ids/id_map/ and
s/map/id_map_rev/ (for reverse)? I'd use "id_map" naming in the public
API to make it clear that it's a mapping of IDs, not just some array
of IDs.

> +};
> +
> +static int btf_permute_shuffle_types(struct btf_permute *p);
> +static int btf_permute_remap_types(struct btf_permute *p);
> +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx);
> +
> +int btf__permute(struct btf *btf, __u32 *ids, const struct btf_permute_o=
pts *opts)

Let's require user to pass id_map_cnt in addition to id_map itself.
It's easy to get this wrong (especially with that special VOID 0 type
that has to be excluded, which I can't even make up my mind if that's
a good idea or not), so having user explicitly say what they think is
necessary for permutation is good.

> +{
> +       struct btf_permute p;
> +       int i, err =3D 0;
> +       __u32 *map =3D NULL;
> +
> +       if (!OPTS_VALID(opts, btf_permute_opts) || !ids)

libbpf doesn't protect against NULL passed for mandatory parameters,
please drop !ids check

> +               return libbpf_err(-EINVAL);
> +
> +       map =3D calloc(btf->nr_types, sizeof(*map));
> +       if (!map) {
> +               err =3D -ENOMEM;
> +               goto done;
> +       }
> +
> +       for (i =3D 0; i < btf->nr_types; i++)
> +               map[i] =3D BTF_UNPROCESSED_ID;
> +
> +       p.btf =3D btf;
> +       p.btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> +       p.ids =3D ids;
> +       p.map =3D map;
> +
> +       if (btf_ensure_modifiable(btf)) {
> +               err =3D -ENOMEM;
> +               goto done;
> +       }
> +       err =3D btf_permute_shuffle_types(&p);
> +       if (err < 0) {
> +               pr_debug("btf_permute_shuffle_types failed: %s\n", errstr=
(err));

let's drop these pr_debug(), I don't think it's something we expect to ever=
 see

> +               goto done;
> +       }
> +       err =3D btf_permute_remap_types(&p);
> +       if (err < 0) {
> +               pr_debug("btf_permute_remap_types failed: %s\n", errstr(e=
rr));

ditto

> +               goto done;
> +       }
> +
> +done:
> +       free(map);
> +       return libbpf_err(err);
> +}
> +
> +/* Shuffle BTF types.
> + *
> + * Rearranges types according to the permutation map in p->ids. The p->m=
ap
> + * array stores the mapping from original type IDs to new shuffled IDs,
> + * which is used in the next phase to update type references.
> + *
> + * Validates that all IDs in the permutation array are valid and unique.
> + */
> +static int btf_permute_shuffle_types(struct btf_permute *p)
> +{
> +       struct btf *btf =3D p->btf;
> +       const struct btf_type *t;
> +       __u32 *new_offs =3D NULL, *map;
> +       void *nt, *new_types =3D NULL;
> +       int i, id, len, err;
> +
> +       new_offs =3D calloc(btf->nr_types, sizeof(*new_offs));

we don't really need to allocate memory and maintain this, we can just
shift types around and then do what btf_parse_type_sec() does -- just
go over types one by one and calculate offsets, and update them
in-place inside btf->type_offs

> +       new_types =3D calloc(btf->hdr->type_len, 1);
> +       if (!new_offs || !new_types) {
> +               err =3D -ENOMEM;
> +               goto out_err;
> +       }
> +
> +       nt =3D new_types;
> +       for (i =3D 0; i < btf->nr_types; i++) {
> +               id =3D p->ids[i];
> +               /* type IDs from base_btf and the VOID type are not allow=
ed */
> +               if (id < btf->start_id) {
> +                       err =3D -EINVAL;
> +                       goto out_err;
> +               }
> +               /* must be a valid type ID */
> +               t =3D btf__type_by_id(btf, id);
> +               if (!t) {
> +                       err =3D -EINVAL;
> +                       goto out_err;
> +               }
> +               map =3D &p->map[id - btf->start_id];
> +               /* duplicate type IDs are not allowed */
> +               if (*map !=3D BTF_UNPROCESSED_ID) {

there is no need for BTF_UNPROCESSED_ID, zero is a perfectly valid
value to use as "not yet set" value, as we don't allow remapping VOID
0 to anything anyways.

> +                       err =3D -EINVAL;
> +                       goto out_err;
> +               }
> +               len =3D btf_type_size(t);
> +               memcpy(nt, t, len);

once you memcpy() data, you can use that btf_field_iter_init +
btf_field_iter_next to *trivially* remap all IDs, no need for patch 1
refactoring, IMO. And no need for two-phase approach either.

> +               new_offs[i] =3D nt - new_types;
> +               *map =3D btf->start_id + i;
> +               nt +=3D len;
> +       }
> +
> +       free(btf->types_data);
> +       free(btf->type_offs);
> +       btf->types_data =3D new_types;
> +       btf->type_offs =3D new_offs;
> +       return 0;
> +
> +out_err:
> +       free(new_offs);
> +       free(new_types);
> +       return err;
> +}
> +
> +/* Callback function to remap individual type ID references
> + *
> + * This callback is invoked by btf_remap_types() for each type ID refere=
nce
> + * found in the BTF data. It updates the reference to point to the new
> + * permuted type ID using the mapping table.
> + */
> +static int btf_permute_remap_type_id(__u32 *type_id, void *ctx)
> +{
> +       struct btf_permute *p =3D ctx;
> +       __u32 new_type_id =3D *type_id;
> +
> +       /* skip references that point into the base BTF */
> +       if (new_type_id < p->btf->start_id)
> +               return 0;
> +
> +       new_type_id =3D p->map[*type_id - p->btf->start_id];

I'm actually confused, I thought p->ids would be the mapping from
original type ID (minus start_id, of course) to a new desired ID, but
it looks to be the other way? ids is a desired resulting *sequence* of
types identified by their original ID. I find it quite confusing. I
think about permutation as a mapping from original type ID to a new
type ID, am I confused?


> +       if (new_type_id > BTF_MAX_NR_TYPES)
> +               return -EINVAL;
> +
> +       *type_id =3D new_type_id;
> +       return 0;
> +}

[...]

