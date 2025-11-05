Return-Path: <linux-kernel+bounces-885619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 795A8C33797
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4573B40C7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1552356BE;
	Wed,  5 Nov 2025 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6eZUR2+"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27418EEAB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762302565; cv=none; b=d3AkquYW+4eF1XCFUSBj4ddtJU9L4uuiLi28byR+tVGkTP6zdcTgrFQfmlXG0PiYWhq5octezcCJbI9chppllqAa45trIUGCGIi+e4Fg5az4RDQu+cqtCOSfG1YPGkoJwU0Ks/URLtV0cRznkyQKMYhmDyHk8wZucvxK3/tu7Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762302565; c=relaxed/simple;
	bh=f5aIiFy5mSzEtHXYFs8wRFblnfTWk3IdBkJ2/t5G3Qg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K0gWE+n7ouEDB+yB3GPQw8zewSSiuLeHnGG181v/jjUYgSBm8u7/iWWiFamdhMoJLyD8bbmUGTaSk9oHakCxh4mqxUgsK1ijRe85yOj2BVc2KjxblixzNGO6swRu3D8KvIvYJZuHxJBr3NU+IWuSDxsPvheKu1k8pPpVlC7WdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6eZUR2+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-340c1c05feeso3354329a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762302563; x=1762907363; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hMhLnyIfG7UbkKgdpPmZtvjp99PUyucsrPbWxECJVAc=;
        b=U6eZUR2+7fKGnXSvEaLO60nR6gkubM58I9bV0UuE8Mk/zuwNRxlG4YpnTtnFLRpRW/
         gEprhj+xy1nIwcOjIdbaU3K1d2fXiPQt0hFQ+2D43Cu0bcMYv2q9vnqwPceTVEHUBGGR
         BzdwQVQtD6botKTfySSj9a3wWquk1uZhfwkxO9I0ozlmARd+LJcAL72+BDNgZMRjygjm
         18aJWB1t8+W1WTiFOIgxRI5JOheSOQra9FNMuM43l3KdluaEup1O5ae+z+0byQn0Hz1Q
         BnMBf+w1w1COTHJpyf09r1SKQp5exyFI9IQdhuRbfR6rW5VTu5EvYyKUCn/hUTvuYs+I
         3z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762302563; x=1762907363;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hMhLnyIfG7UbkKgdpPmZtvjp99PUyucsrPbWxECJVAc=;
        b=UFk3mZ8VDkNL3tDBSfxdYfa9dpi7YlqBeFj9dTYzpREhUFBkmIXcdkk7FRu2CDZyas
         YQLRlX6/BZc4tlmoKd/Vn708/Y9fwJLuPOx3PpmRkpJRXvJXnJxmr9Uy0Krl/ESAwwck
         sI7A8Rr5p+mlpozspxAh733c10ilLdLIEEpLS2RglmkJSm/8783CNhbFnhTvIVkbb5Ew
         6zUFn4OuqVZvhQUjmxvKRH/bd1j3L6/6xDS5GHw1IwXgvL1zV9sklfXVNzwbxA+f+D5k
         OgEyX/dJt6YdyYq9N6zkNCGPZeTkHRp3FMUXq6KmZooKFUVioizMVY0oelF7yCeG7w9N
         gZNQ==
X-Gm-Message-State: AOJu0YxNaAHqeC7R3dDMKRGHGyQWAfNCG2VY2OSu1zgFsy5C2yhCEiL+
	DjS3Usif71LR9ZeaBw3wN3KacWsyx6ADIEGTpFBFebSZCCcZfS7GVHSX
X-Gm-Gg: ASbGncvAnozYZG59mK8Ut2zJHFubSbj9K+HEF+Lv1w/SBJGa3/ef2SaLCnHec2ekUcl
	vXSE7p7S4nq2qDcHcchkKANg8Qq/JnKBm1emoxtH5wtZpdm65DdgZ7Q2N+mk84H8WRAVt9bS6o8
	gAkcLYO1dugWZbiFEranJRaDG1Kg3sdI6D6t9GEFUpJMYWtbdAkXcTEoiKFH6OZEn5PH/OIwY5H
	Np56Tkz/+E0DjP9INBzhfbDYFaLQQWNnHj3wG3UE4CO4ItSnHaM5kgGL8smGVYres5l+dtVmT31
	YYE/kccIT+rbWK+LxdjXLecGOehPHEq3KaC/dl0AbPASkQQM2Z3YTxTEsgwIZyWLe41HywTh3jm
	ok4D9+2ef1IdAlPWrYfXUTyn0a9Tk5SOIEty0DLSqooUDxEoqs6aCf3nXPnX20DRLMHsa7Rfdpe
	LTCsy3jArhrHfHArhhlCfyuIy2sdaobjN+QQ==
X-Google-Smtp-Source: AGHT+IEur4L3kpgPLQKd1EkackNoAVMpsy7agVybkv3A/vREqnQw12q4zI6TWGxQu61ecJlnrazP+A==
X-Received: by 2002:a17:90b:6cf:b0:340:2a38:d45f with SMTP id 98e67ed59e1d1-341a6c5f60fmr1508831a91.16.1762302563233;
        Tue, 04 Nov 2025 16:29:23 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a9e845a4sm526091a91.21.2025.11.04.16.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:29:22 -0800 (PST)
Message-ID: <123fde84e56aaa2dcccc16a2eac00d0e28a0823e.camel@gmail.com>
Subject: Re: [RFC PATCH v4 4/7] libbpf: Implement lazy sorting validation
 for binary search optimization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 16:29:21 -0800
In-Reply-To: <20251104134033.344807-5-dolinux.peng@gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-5-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-04 at 21:40 +0800, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>=20
> This patch adds lazy validation of BTF type ordering to determine if type=
s
> are sorted by name. The check is performed on first access and cached,
> enabling efficient binary search for sorted BTF while maintaining linear
> search fallback for unsorted cases.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 76 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 74 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 5af14304409c..0ee00cec5c05 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -26,6 +26,10 @@
> =20
>  #define BTF_MAX_NR_TYPES 0x7fffffffU
>  #define BTF_MAX_STR_OFFSET 0x7fffffffU
> +/* sort verification occurs lazily upon first btf_find_type_by_name_kind=
()
> + * call
> + */
> +#define BTF_NEED_SORT_CHECK ((__u32)-1)
> =20
>  static struct btf_type btf_void;
> =20
> @@ -96,6 +100,10 @@ struct btf {
>  	 *   - doesn't include special [0] void type;
>  	 *   - for split BTF counts number of sorted and named types added on
>  	 *     top of base BTF.
> +	 *   - BTF_NEED_SORT_CHECK value indicates sort validation will be perf=
ormed
> +	 *     on first call to btf_find_type_by_name_kind.
> +	 *   - zero value indicates applied sorting check with unsorted BTF or =
no
> +	 *     named types.

And this can be another flag.

>  	 */
>  	__u32 nr_sorted_types;
>  	/* if not NULL, points to the base BTF on top of which the current
> @@ -903,8 +911,67 @@ int btf__resolve_type(const struct btf *btf, __u32 t=
ype_id)
>  	return type_id;
>  }
> =20
> -/*
> - * Find BTF types with matching names within the [left, right] index ran=
ge.
> +static int btf_compare_type_names(const void *a, const void *b, void *pr=
iv)
> +{
> +	struct btf *btf =3D (struct btf *)priv;
> +	struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> +	struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> +	const char *na, *nb;
> +	bool anon_a, anon_b;
> +
> +	na =3D btf__str_by_offset(btf, ta->name_off);
> +	nb =3D btf__str_by_offset(btf, tb->name_off);
> +	anon_a =3D str_is_empty(na);
> +	anon_b =3D str_is_empty(nb);
> +
> +	if (anon_a && !anon_b)
> +		return 1;
> +	if (!anon_a && anon_b)
> +		return -1;
> +	if (anon_a && anon_b)
> +		return 0;
> +
> +	return strcmp(na, nb);
> +}
> +
> +/* Verifies BTF type ordering by name and counts named types.
> + *
> + * Checks that types are sorted in ascending order with named types
> + * before anonymous ones. If verified, sets nr_sorted_types to the
> + * number of named types.
> + */
> +static void btf_check_sorted(struct btf *btf, int start_id)
> +{
> +	const struct btf_type *t;
> +	int i, n, nr_sorted_types;
> +
> +	if (likely(btf->nr_sorted_types !=3D BTF_NEED_SORT_CHECK))
> +		return;
> +	btf->nr_sorted_types =3D 0;
> +
> +	if (btf->nr_types < 2)
> +		return;
> +
> +	nr_sorted_types =3D 0;
> +	n =3D btf__type_cnt(btf);
> +	for (n--, i =3D start_id; i < n; i++) {
             ^^^
     why not -1 one line before?

> +		int k =3D i + 1;
> +
> +		if (btf_compare_type_names(&i, &k, btf) > 0)
> +			return;
> +		t =3D btf_type_by_id(btf, k);
> +		if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> +			nr_sorted_types++;
> +	}
> +
> +	t =3D btf_type_by_id(btf, start_id);
> +	if (!str_is_empty(btf__str_by_offset(btf, t->name_off)))
> +		nr_sorted_types++;
> +	if (nr_sorted_types)
> +		btf->nr_sorted_types =3D nr_sorted_types;

I think that maintaining nr_sorted_types only for named types is an
unnecessary complication. Binary search will skip those anyway,
probably in one iteration.

> +}
> +
> +/* Find BTF types with matching names within the [left, right] index ran=
ge.
>   * On success, updates *left and *right to the boundaries of the matchin=
g range
>   * and returns the leftmost matching index.
>   */
> @@ -978,6 +1045,8 @@ static __s32 btf_find_type_by_name_kind(const struct=
 btf *btf, int start_id,
>  	}
> =20
>  	if (err =3D=3D -ENOENT) {
> +		btf_check_sorted((struct btf *)btf, btf->start_id);
> +
>  		if (btf->nr_sorted_types) {
>  			/* binary search */
>  			__s32 l, r;
> @@ -1102,6 +1171,7 @@ static struct btf *btf_new_empty(struct btf *base_b=
tf)
>  	btf->fd =3D -1;
>  	btf->ptr_sz =3D sizeof(void *);
>  	btf->swapped_endian =3D false;
> +	btf->nr_sorted_types =3D BTF_NEED_SORT_CHECK;
> =20
>  	if (base_btf) {
>  		btf->base_btf =3D base_btf;
> @@ -1153,6 +1223,7 @@ static struct btf *btf_new(const void *data, __u32 =
size, struct btf *base_btf, b
>  	btf->start_id =3D 1;
>  	btf->start_str_off =3D 0;
>  	btf->fd =3D -1;
> +	btf->nr_sorted_types =3D BTF_NEED_SORT_CHECK;
> =20
>  	if (base_btf) {
>  		btf->base_btf =3D base_btf;
> @@ -1811,6 +1882,7 @@ static void btf_invalidate_raw_data(struct btf *btf=
)
>  		free(btf->raw_data_swapped);
>  		btf->raw_data_swapped =3D NULL;
>  	}
> +	btf->nr_sorted_types =3D BTF_NEED_SORT_CHECK;
>  }
> =20
>  /* Ensure BTF is ready to be modified (by splitting into a three memory

