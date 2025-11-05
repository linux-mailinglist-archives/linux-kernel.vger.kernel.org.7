Return-Path: <linux-kernel+bounces-885602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEC5C336FF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 01:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 129A54E7839
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 00:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9DF1DFE0B;
	Wed,  5 Nov 2025 00:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADz8gGWe"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F281D9A5F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 00:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762301187; cv=none; b=FGTvFlMO6wP/OVDvpyAEl4KDz22inBZPxImpcV1NHqPRuoMfxRWjXsyKaNDvNIzjaDit7lHPV7rS34BMqcu2LlBJl/KyoY0w+aLcIFgvm7OYqQtCsOvYvfU8RotdQEW45fvzexz9WDcSMRTOCHycAFNmgCtocgrR2wQSgJKgfNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762301187; c=relaxed/simple;
	bh=phFITbgMjnxpJ/dMrO7WCFFIx/LYZ/ps+YrcSuanerU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fY9qqsKmoVKh/aBey7KpHZKtMj8FvODLo4O9KbbO6LCAKSnwNSe7qQYyta/eDscTIsojgpZ+fTGKh03BNAYxseNjpd+NPhCkzNIAzjeFdd+hi8KO8mTrJqA9FOR5jgwtIcwFOpZIiLf0vGAUIjWdJ2fWikzuWKAi2FKH5R2DbWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADz8gGWe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-295f937d4c3so11898145ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 16:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762301185; x=1762905985; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v9wGcPcq+Ht/Igx2aO09hGOArirMKZG7Z6lPApxjm8E=;
        b=ADz8gGWeDZB4NqnZWJdLdf4nu/HBDu01PE+rxhOhle+u4nI2qtE4rRmfAmWu53bYuq
         kDNRHvHS14BoTWefboSdg93XqGL4+Dq9Wv0qxOJA9HrPX76ynYBpOjTeg33qV4d2xRjG
         l8RY/IUThb8Escp0vETOQpyCT1Ld/+aWRUh3Im6CJhBvp0sEAgOzoBU+J6XBqCFvd+JS
         Zka7UE6/SXoZ1LTV/yksKrWI+QQpaNxjsgWGbyXMyzHt6HWUIc9z3L3IdfASjZVh4q3p
         cM1efrR34rvTz064brIsiPX924HHNs4FDBfi//+bmdNsAfL1IWqNLOK1k+CUekKCIaVT
         FIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762301185; x=1762905985;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v9wGcPcq+Ht/Igx2aO09hGOArirMKZG7Z6lPApxjm8E=;
        b=uDEhtg8JkxN4Ls9UsAQeuBRQiOs+pxf8OzBbxWyWetT+sUbswfVRTIhMFK7YVd4R/I
         WcaNdq6s+HNdnshnm5LyDA5nAVpkMdFuUFWyRL9/LXcDZ8QRbfELGts1QLNx8k3dO7Pk
         Vs0zO7p4WShnTmWJMlRmJasSP709UgblZoWlwJ7xIklvAk39JM/IQwjLq6bgDK/R69o1
         lkU42C5mjOHk2/pFTMKoSgceJOPFjfVzn+fOJ6saYKDlj94oFieQgLZ/MUow5yH+rzs0
         rLoTtAeQggFSRFS3E301iAhJz+1JoPYCBBuyKYjkxViIyfJWtx5sR5HRsucnlYiadPIH
         FLtw==
X-Gm-Message-State: AOJu0Yw7h78LYhjQmy3xcZQgb4TbStYKd6jkm9V9RNRImV1+RZMWUrBA
	Vg8l8YJuMeKwXWCaOWhbZBrKmgfheKjWEutudxVWkCjzpSB0/DbPGg9c
X-Gm-Gg: ASbGncttZtu3Kh//pkhZlAtxhNFLkZMhr1BbEeH1JMw3psCafbu8JbH9iaekYsBWh2a
	SXyoFT7wGg9RVYXqplh7KoUW+4fKcHg0dtt8FuhXyIxjH3Sx6lZe5lG5r/Ji+2h/r/ZRhxGkecy
	Erk3rFgu+4thz1F4MSjhilJKcxcL5PqOnFQnX6j37b1yBO4K6xHLiDa1bPO65EFxWfRVKHB4LXf
	NZX48at5e42JrM8LQQAqw6syC5sJYeKIkveyHg8ncvi/ej2qa+lwlZav5eIKovasLl7fH+nRzb5
	3ZJF95EmSRSYPTyFo7dkOFq6VpOpWEiL0bRXErIgALzOn7uX1zR7mmcIHDMp2gBJ20xlqzPLpyE
	AIOhfM5GKXukTPu3ylENOpX6i0F8BPogwssgMShz0vhif5oPB29+sFB6JPbUYr8Kdc7Htd4pQxp
	wI1JRoSL96lrCyjYCB7X0nnTZtuv29aQUlEg==
X-Google-Smtp-Source: AGHT+IEeMIf5/7k7T47W1MVu0+3bhcMByZrUb78YW5uv4HwD6H9M4mClCmgcnXFMara1+yXhKrEEjA==
X-Received: by 2002:a17:902:db11:b0:246:80b1:8c87 with SMTP id d9443c01a7336-2962adb128bmr15984315ad.43.1762301184900;
        Tue, 04 Nov 2025 16:06:24 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a60afdsm40559365ad.86.2025.11.04.16.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 16:06:24 -0800 (PST)
Message-ID: <660e82dcf9632b06708f3e8a0bb9025f0d420543.camel@gmail.com>
Subject: Re: [RFC PATCH v4 3/7] libbpf: Optimize type lookup with binary
 search for sorted BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 16:06:22 -0800
In-Reply-To: <20251104134033.344807-4-dolinux.peng@gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-4-dolinux.peng@gmail.com>
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
> This patch introduces binary search optimization for BTF type lookups
> when the BTF instance contains sorted types.
>=20
> The optimization significantly improves performance when searching for
> types in large BTF instances with sorted type names. For unsorted BTF
> or when nr_sorted_types is zero, the implementation falls back to
> the original linear search algorithm.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---

lgtm, have two nits.

>  tools/lib/bpf/btf.c | 142 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 119 insertions(+), 23 deletions(-)
>=20
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 3bc03f7fe31f..5af14304409c 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -92,6 +92,12 @@ struct btf {
>  	 *   - for split BTF counts number of types added on top of base BTF.
>  	 */
>  	__u32 nr_types;
> +	/* number of sorted and named types in this BTF instance:
> +	 *   - doesn't include special [0] void type;
> +	 *   - for split BTF counts number of sorted and named types added on
> +	 *     top of base BTF.
> +	 */
> +	__u32 nr_sorted_types;

Silly question: why is this __u32 and not just a flag?

>  	/* if not NULL, points to the base BTF on top of which the current
>  	 * split BTF is based
>  	 */
> @@ -897,44 +903,134 @@ int btf__resolve_type(const struct btf *btf, __u32=
 type_id)
>  	return type_id;
>  }
> =20
> -__s32 btf__find_by_name(const struct btf *btf, const char *type_name)
> +/*
> + * Find BTF types with matching names within the [left, right] index ran=
ge.
> + * On success, updates *left and *right to the boundaries of the matchin=
g range
> + * and returns the leftmost matching index.
> + */
> +static __s32 btf_find_type_by_name_bsearch(const struct btf *btf, const =
char *name,
> +						__s32 *left, __s32 *right)
>  {
> -	__u32 i, nr_types =3D btf__type_cnt(btf);
> +	const struct btf_type *t;
> +	const char *tname;
> +	__s32 l, r, m, lmost, rmost;
> +	int ret;
> +
> +	/* found the leftmost btf_type that matches */
> +	l =3D *left;
> +	r =3D *right;
> +	lmost =3D -1;
> +	while (l <=3D r) {
> +		m =3D l + (r - l) / 2;
> +		t =3D btf_type_by_id(btf, m);
> +		tname =3D btf__str_by_offset(btf, t->name_off);
> +		ret =3D strcmp(tname, name);
> +		if (ret < 0) {
> +			l =3D m + 1;
> +		} else {
> +			if (ret =3D=3D 0)
> +				lmost =3D m;
> +			r =3D m - 1;
> +		}
> +	}

Nit: I think Andrii's point was that this can be written a tad shorter, e.g=
.:
     https://elixir.bootlin.com/linux/v6.18-rc4/source/kernel/bpf/verifier.=
c#L2952

> =20
> -	if (!strcmp(type_name, "void"))
> -		return 0;
> +	if (lmost =3D=3D -1)
> +		return -ENOENT;
> +
> +	/* found the rightmost btf_type that matches */
> +	l =3D lmost;
> +	r =3D *right;
> +	rmost =3D -1;
> +	while (l <=3D r) {
> +		m =3D l + (r - l) / 2;
> +		t =3D btf_type_by_id(btf, m);
> +		tname =3D btf__str_by_offset(btf, t->name_off);
> +		ret =3D strcmp(tname, name);
> +		if (ret <=3D 0) {
> +			if (ret =3D=3D 0)
> +				rmost =3D m;
> +			l =3D m + 1;
> +		} else {
> +			r =3D m - 1;
> +		}
> +	}
> =20
> -	for (i =3D 1; i < nr_types; i++) {
> -		const struct btf_type *t =3D btf__type_by_id(btf, i);
> -		const char *name =3D btf__name_by_offset(btf, t->name_off);
> +	*left =3D lmost;
> +	*right =3D rmost;
> +	return lmost;
> +}

[...]

