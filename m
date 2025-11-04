Return-Path: <linux-kernel+bounces-885573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EEFC335A9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 00:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 525F234BD7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 23:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258E92D8370;
	Tue,  4 Nov 2025 23:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Io8dkI4w"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAA12882BE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 23:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298195; cv=none; b=NwvdoKclIQcylkB3QxRhQ24gZ+ZabGgIPWAJIdh+9Ny+y6iq6HH++2BlD1jtS+3p0iX5ZhLo2G51x/NE1H1P0ikBCT30PytPNGM77OhcGH8/6JjJlZhBi+W2k0GfXPGZi5a/w/QwtTsNLs6CXrl435b23xdOj8M1/f3S5up261M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298195; c=relaxed/simple;
	bh=V8nVuV0n+sCURNFds7Oo6rBhBJDlAUh0JyVdqPhZQaE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aWQLvVbwpPHl5wvvAlPZ6cnpOlyIncKeTLe+kBx1HT2NU9sSg3L8eg6DmA2ItI0GM10z/4zvfRqETVXmggQSDbu9bxJykODOUkHh6hPXShjhM5PUclLSjgEfRD4Bf+H9P9KnjpzSGKDBnc05jsFlZzVUcxoeAQxLF1RAM98knHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Io8dkI4w; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-29516a36affso47138225ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 15:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762298192; x=1762902992; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EGZr6HMcs4RCfjM1Y9yPGFu8E7vFsFeaGWiFPXlpJwM=;
        b=Io8dkI4wlfvuwgGKwYItNI9G7AqZnsoo+jH+K2HA2lw13rx+uJJse6QYrs6PGvBwR4
         Nls4n1Zda46E1A8daXGK+M1NsEoLs1kUqiyDvOEocj3F/zkf5zrI5etbCLgTK+DullIM
         uJumzw9op1gotbi2mn0caFJ5H+R0unsyT7e/yhOE2L6Sk2E8ND8WY1usk8fSfE0ZT+hY
         pxltk716W+TGa6yBthSNVOgeRwDK+l3sOe5NaBlhV+taXu0TOWH+aZPTO/CwJckxr5PG
         JkeXePjwZI4/mLzwRQWK7HAWVXkWQrxvMAXHernznf8tfDIJHTQCPwFsH9TX7VfLWxd0
         jyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298192; x=1762902992;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGZr6HMcs4RCfjM1Y9yPGFu8E7vFsFeaGWiFPXlpJwM=;
        b=OzsrjKHf/5rhnPQaaN/uXAA5iBrPLWKeSaVvZWPuqRadTBN74q1d8WKnTtN7vRWFh9
         h+O+BtTvEO8VfZZHF1kaBtihtSxzD60YxekaRJuUmw2v597HuzeESSr+j6ujB3DOJwNr
         khpM3Te0noO7/BY6j4kvz173e+ciDM2kDZ66cy0ZxbWOEQrOo7kPP9D9VpqCkfvpM2+L
         iz9w3tfm6xHihUxPFiAg5X30/RaDa24F+HgbzZAGiKUd4Uf29b2Z5GnN6i6W23IRQPdv
         gVk50nH0nVGLINEM4u8+h7tcgWJ4kdIezQaqRpIhCxRPng978NDDHqPh2ptQjHC3n5im
         qZEw==
X-Gm-Message-State: AOJu0YxUOKOCY1f8mcxnoxdnor6Hynwaxu6NvE3Wys65c4Bk7PDSXAFD
	f67VXtF8da8hgwxs0WzURbrV5Y9JzPX6ScE9zxv/GuZI+zgbrx9FLYfa
X-Gm-Gg: ASbGncsw4mktLp5Zx2WshlDuowKSp3bvC+X4JIeEdsgSmtCxaK8YSBLUJrJkIOMcXEV
	CFsOa2h/OWl5ILteKkWTqiz6AHVcl8nm450lxz1/hy3fNqc/FTnNEb2/ax2N6IYpRTtH4BeIkJK
	5Gq8qAghr7MCzgD2pnu6RwbY9b71BAdojQGA9CJU2ub9q/k5Etclcv6N3Jf4ZIzZP3kFROo6z7+
	H36lrpgrXSvXEhA37yphDqq+8MSIu83XjeU3iUl+DJlrZQtq+siux8Ut3IJPPBKwX9oe60msQsv
	yN6EdZu4RYIoa+RoIhpA2W1CzDaCqxdLXuoxBvNQD+ph1/fQ2KvWuGF+gs/ugmMURx9ARRhFSCL
	xMeQMWTfpO9FZMA04eBNegMXpiMtDpEv7Ld15JszHF+1SOUF9cHi/VOnLGi/VEyA69DZMp7zih7
	MUrKjXw2yD1KG6TZ+O1O7jWzuqWIf7GaVEgA==
X-Google-Smtp-Source: AGHT+IH6crtzR+6zUOkBPB5+ybCD3YGJNF15Oi0eJ/TItqEIBk+h6nP03we74gUPUgZhidc6G0zBzw==
X-Received: by 2002:a17:902:ce81:b0:290:cd5f:a876 with SMTP id d9443c01a7336-2962ad1c7c8mr20507755ad.13.1762298192310;
        Tue, 04 Nov 2025 15:16:32 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:a643:22b:eb9:c921? ([2620:10d:c090:500::5:99aa])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601b8f28esm39826705ad.5.2025.11.04.15.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 15:16:32 -0800 (PST)
Message-ID: <ba6272aa416c80c8a4800945b6ed311fe1506a74.camel@gmail.com>
Subject: Re: [RFC PATCH v4 1/7] libbpf: Extract BTF type remapping logic
 into helper function
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, ast@kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Andrii Nakryiko	
 <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, Song
 Liu	 <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Date: Tue, 04 Nov 2025 15:16:30 -0800
In-Reply-To: <20251104134033.344807-2-dolinux.peng@gmail.com>
References: <20251104134033.344807-1-dolinux.peng@gmail.com>
	 <20251104134033.344807-2-dolinux.peng@gmail.com>
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
> Refactor btf_dedup_remap_types() by extracting its core logic into a new
> btf_remap_types() helper function. This eliminates code duplication
> and improves modularity while maintaining the same functionality.
>=20
> The new function encapsulates iteration over BTF types and BTF ext
> sections, accepting a callback for flexible type ID remapping. This
> makes the type remapping logic more maintainable and reusable.
>=20
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Song Liu <song@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

>  tools/lib/bpf/btf.c             | 63 +++++++++++++++++----------------
>  tools/lib/bpf/libbpf_internal.h |  1 +
>  2 files changed, 33 insertions(+), 31 deletions(-)
>=20
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 18907f0fcf9f..5e1c09b5dce8 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -3400,6 +3400,37 @@ int btf_ext__set_endianness(struct btf_ext *btf_ex=
t, enum btf_endianness endian)
>  	return 0;
>  }
> =20
> +static int btf_remap_types(struct btf *btf, struct btf_ext *btf_ext,
> +			   btf_remap_type_fn visit, void *ctx)
                           ^^^^^^^^^^^^^^^^^
Nit: there is already 'type_id_visit_fn', no need to add new type.

> +{
> +	int i, r;
> +
> +	for (i =3D 0; i < btf->nr_types; i++) {
> +		struct btf_type *t =3D btf_type_by_id(btf, btf->start_id + i);
> +		struct btf_field_iter it;
> +		__u32 *type_id;
> +
> +		r =3D btf_field_iter_init(&it, t, BTF_FIELD_ITER_IDS);
> +		if (r)
> +			return r;
> +
> +		while ((type_id =3D btf_field_iter_next(&it))) {
> +			r =3D visit(type_id, ctx);
> +			if (r)
> +				return r;
> +		}
> +	}
> +
> +	if (!btf_ext)
> +		return 0;
> +
> +	r =3D btf_ext_visit_type_ids(btf_ext, visit, ctx);
> +	if (r)
> +		return r;
> +
> +	return 0;
> +}
> +
>  struct btf_dedup;
> =20
>  static struct btf_dedup *btf_dedup_new(struct btf *btf, const struct btf=
_dedup_opts *opts);

[...]

