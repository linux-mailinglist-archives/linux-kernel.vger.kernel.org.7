Return-Path: <linux-kernel+bounces-865875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238FEBFE38E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC6019C67DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75DC301466;
	Wed, 22 Oct 2025 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV5qQxjG"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872B2FE579
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761166212; cv=none; b=d3nS32nwY29xxD24jDQiHzTlVyt/EtMSSi1CimVfRKHlPNIC9BHEOxn7XM9bBsTeLBbu5tA8Tq6FppISIUgylNejKM3zcHm6gevCppJPyCecexot71ba+WnNXpZtSbJf8H5P2cHlJtXwzFJRwZqOB2HNIiPpOLBGo3S57Mdp2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761166212; c=relaxed/simple;
	bh=0JgR9WDTUHynjtqt1SVok1mWflkxdI3OpEFCJjXRJyo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rlaiRIZ/yaC+2disMYrg+uAm3xHLWZJHuEwmTLdGzxTSdNeO1B8ujEYSYGd+2rla/jfBGQpVgrBTPSGkBZErtVUQmANFGM3MxpnzMCNBFZmUTpbecADM9YNLovws97RkbKmnDcI8aISgz+qd0CmyBjcvufD8Y9v0LMGUc/ru7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV5qQxjG; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77f67ba775aso83918b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761166210; x=1761771010; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UgUcpfhrvyt6eYMrfd8U4oPFhV6AvkhtxDSF2rQSVSI=;
        b=VV5qQxjGw2JFEZQCvGzS2/poqbV9qTsMs2kOpFchaAzpoN0v5pOGu9R/BP6RH0S08f
         wtQblirjAeAqt8gjjKkhOvF3F4rMHMiBi3yHdBGTTbljoI4o1i/hinzUIkwbNH2GkcRu
         wN2MduilJKpI2RhSMoWt6Rt5k0HVme+Lbj8cb5H848zQh1q8nHGdlKWYhq6x2t88q8qa
         a7yndMZxEuTfSoCuU8Scl2xKPHA85JJMUUKhZ4uh31Mue4MTUfV1lWgOLzcoZsufEst1
         8xUWpPIzvjUJsLmd+gVUpEBA3upvWgMNN1yZbKOevNzPbJ8h3zhl/tOtm8RrHC6EPsod
         am7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761166210; x=1761771010;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UgUcpfhrvyt6eYMrfd8U4oPFhV6AvkhtxDSF2rQSVSI=;
        b=sq3m8ZAlKQqxG3ycerJgnvv/QDoPDuZVuNTtGCD6bV0oNh0P26vTDESdfKUj/1HR0D
         aJgGK/XeVWcyFk2xlqSSLNCbHLw7+fAHA93K1787UB+Z/RyPWJwILBVx6hu/LmCrwyc+
         hvPEQUckmzZiM8BBZu8V0bZGB10wX67k2IsZuXevWLiGCud1AHo2lFJx122XjfktHXH8
         sk0yAqbfz+zpGw7Jjo1YdlJ1PALOA7jvdoC+Ps9bVFCrdxaTB3Kgwc1nBq2aYEyG6LrI
         rfHZ9XU2w/Gs5kBACEb70VKOSxavcNY8ICWeyE6WF/T5vtsY0mtMCk62UPXQlLumYaQ7
         fCHA==
X-Forwarded-Encrypted: i=1; AJvYcCUvWteuF+DDZzSaUkxkd4TfTTpf/CeD5z1zWfAGj8y9r+NqKzyWHIIsmdWMbLzlefpxyJPyl6SrsRIuibY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcDPA5/s4HEu5M/z++kv4Y9mFJFTBHpx+Fv9mthXulvCcCf0dH
	GDpfqRYHaQyrUkfQUBoEgVmGA/bWGN/+W+Ddoe+4pfJ1Suc0Z019whcYGVxrGMVt
X-Gm-Gg: ASbGncsCCkiRTPuGMt/PQmJetVYxKkvDnqZn8RPpdK0zMa1beHx7ymNVDvBYg8kOFSg
	ZQFfROV+CRsoRqpWsw9kTkMfJXz6Q/WXTLEvQvNGUsnq/JXZ2REdqTxBFbIbuUvUB7BqNkylff0
	XyzXjR7HcFiLW0imoqc84ABOG2a2ULNSq9rVMJEZwMxKsvmprGqSvUJJ6zU3vhGtnss62P0M8Py
	4Ijd1Cw6kIouQijzhrCxfUejG614lLF6p4ydzLokYuFxJKYwEGGyqQ9nxni9OIp3XbqvYbbz4p/
	4CY7PZ2mj+wIQyYVhZ+89Il7mBkJyc5nIp3aP8FBSpV10CUHtiToN7/YpNvUdJU9gJg7uZqeNqY
	b8v/eVGoh0fK89BwmGKcjiPJzCkNMasqMVirhFqF/dPY7EJ/oUQMw0xYBKD5277NCvCRTn3M32r
	IKI26AXI4Y8tQIVrT31f8mlXYWT42N7ZrhVuQ=
X-Google-Smtp-Source: AGHT+IEV7pugFPydmKhRrO5R/SjYxtWqVbY5mI6z6oTdXgS9HtSf1+AY271CZOh4AWxrX2zJPvrYFQ==
X-Received: by 2002:a05:6a00:4f81:b0:7a1:373f:c216 with SMTP id d2e1a72fcca58-7a220a9ded3mr27481912b3a.14.1761166210420;
        Wed, 22 Oct 2025 13:50:10 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fa8d:1a05:3c71:d71? ([2620:10d:c090:500::7:b877])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9e912sm161398b3a.22.2025.10.22.13.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 13:50:10 -0700 (PDT)
Message-ID: <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to
 enable binary search
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire
 <alan.maguire@oracle.com>, Song Liu	 <song@kernel.org>, pengdonglin
 <pengdonglin@xiaomi.com>
Date: Wed, 22 Oct 2025 13:50:08 -0700
In-Reply-To: <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
	 <20251020093941.548058-3-dolinux.peng@gmail.com>
	 <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
	 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 11:02 +0800, Donglin Peng wrote:
> On Wed, Oct 22, 2025 at 2:59=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
> > > This patch implements sorting of BTF types by their kind and name,
> > > enabling the use of binary search for type lookups.
> > >=20
> > > To share logic between kernel and libbpf, a new btf_sort.c file is
> > > introduced containing common sorting functionality.
> > >=20
> > > The sorting is performed during btf__dedup() when the new
> > > sort_by_kind_name option in btf_dedup_opts is enabled.
> >=20
> > Do we really need this option?  Dedup is free to rearrange btf types
> > anyway, so why not sort always?  Is execution time a concern?
>=20
> The issue is that sorting changes the layout of BTF. Many existing selfte=
sts
> rely on the current, non-sorted order for their validation checks. Introd=
ucing
> this as an optional feature first allows us to run it without immediately
> breaking the tests, giving us time to fix them incrementally.

How many tests are we talking about?
The option is an API and it stays with us forever.
If the only justification for its existence is to avoid tests
modification, I don't think that's enough.

> >=20
> > > For vmlinux and kernel module BTF, btf_check_sorted() verifies
> > > whether the types are sorted and binary search can be used.
> >=20
> > [...]
> >=20
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index c414cf37e1bd..11b05f4eb07d 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c

[...]

> > > +s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u=
8 kind)
> > > +{
> > > +     return find_btf_by_name_kind(btf, 1, name, kind);
> >                                          ^^^
> >                 nit: this will make it impossible to find "void" w/o a =
special case
> >                      in the find_btf_by_name_kind(), why not start from=
 0?
>=20
> Thanks. I referred to btf__find_by_name_kind in libbpf. In
> btf_find_by_name_kind,
> there is a special check for "void". Consequently, I've added a
> similar special check
> for "void" in find_btf_by_name_kind as well.

Yes, I see the special case in the find_btf_by_name_kind.
But wouldn't starting from 0 here avoid the need for special case?

[...]

> > > diff --git a/tools/lib/bpf/btf_sort.c b/tools/lib/bpf/btf_sort.c
> > > new file mode 100644
> > > index 000000000000..2ad4a56f1c08
> > > --- /dev/null
> > > +++ b/tools/lib/bpf/btf_sort.c
> >=20
> > [...]
> >=20
> > > +/*
> > > + * Sort BTF types by kind and name in ascending order, placing named=
 types
> > > + * before anonymous ones.
> > > + */
> > > +int btf_compare_type_kinds_names(const void *a, const void *b, void =
*priv)
> > > +{
> > > +     struct btf *btf =3D (struct btf *)priv;
> > > +     struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> > > +     struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> > > +     const char *na, *nb;
> > > +     int ka, kb;
> > > +
> > > +     /* ta w/o name is greater than tb */
> > > +     if (!ta->name_off && tb->name_off)
> > > +             return 1;
> > > +     /* tb w/o name is smaller than ta */
> > > +     if (ta->name_off && !tb->name_off)
> > > +             return -1;
> > > +
> > > +     ka =3D btf_kind(ta);
> > > +     kb =3D btf_kind(tb);
> > > +     na =3D btf__str_by_offset(btf, ta->name_off);
> > > +     nb =3D btf__str_by_offset(btf, tb->name_off);
> > > +
> > > +     return cmp_btf_kind_name(ka, na, kb, nb);
> >=20
> > If both types are anonymous and have the same kind, this will lead to
> > strcmp(NULL, NULL). On kernel side that would lead to null pointer
> > dereference.
>=20
> Thanks, I've confirmed that for anonymous types, name_off is 0,
> so btf__str_by_offset returns a pointer to btf->strs_data (which
> contains a '\0' at index 0) rather than NULL. However, when name_off
> is invalid, btf__str_by_offset does return NULL. Using str_is_empty
> will correctly handle both scenarios. Unnamed types of the same kind
> shall be considered equal. I will fix it in the next version.

I see, thank you for explaining.
Checking the usage of kernel/bpf/btf.c:btf_name_valid_identifier(),
it looks like kernel validates name_off for all types.
So, your implementation should be fine.

[...]

