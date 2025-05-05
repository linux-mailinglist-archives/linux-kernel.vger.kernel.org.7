Return-Path: <linux-kernel+bounces-632323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09773AA9602
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 16:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B6347A4E0E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F2725C834;
	Mon,  5 May 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="SwbIR0eu"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B047B2586E8
	for <linux-kernel@vger.kernel.org>; Mon,  5 May 2025 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455835; cv=none; b=tTKewhL6vCYg46g7N04NZU8WGRQSfZW0AHYWr9Wf/MmlBlHcciPLvATia2Xl6nNH01hV5pBYzLDjH4soHy3vNfsAvowrsbFCL9MFRg1bTQ61l1SiJhvvzwBIClZzu2XXj1rJ7majLE3vqFWilywZgx7u1Uf2U34l6mu3VJmftQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455835; c=relaxed/simple;
	bh=JmucSS8yHIGvXEbtSfgsHVr9r5nyIh34DSUF08JyRTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXPuYxmFKa8qnBraty+js2bPKbLyuLLCW2x1qFx9JH8Ctlah8oZLAAlhXaq37cD9pKVgigrmOf1kvCPKsEtW/CsX1sQ1uvJPqwewLT4unUNtZnncE3OFNE1aW29MPLLsEgXzmwt6b92fn3ciHV/eVbPlOtnqovLz5bhMCgMD0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=SwbIR0eu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so3491687f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 May 2025 07:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1746455832; x=1747060632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IlruZqZzq0+fswkpFmPD6JiolgWVetZjDH4ysB+h9A=;
        b=SwbIR0eugaKz+3A1KOLmvmgO179zctaCTI5qb4gHCL+WYiXHTVjEB9R0DBgixqPSn7
         0SqG91H9Thil0rDawmRmFx1GyLesRZ+aLS+TB9Xrhc+9rwWDpT6dotUrMC2/3qMdBmJr
         rZj9OKHYoJDsNgn85h5ZBkf+cJAUL2HUIEHrVrxHVtLc/lWLIZPh30rwxM5TuZdFJ+MR
         SKWnKyhTW4hdkOJslRzh0BG0Pc7KnE2vszNApv45nKiS5NdwxBY3XW9lPipjLmz0OCNv
         8OD70zOb8BTeyHKaRDnQGnNYa6wFTx5YTBFcdvHeHqUp/g2mNcfMgC79l94giqtVxiUI
         0Ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746455832; x=1747060632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IlruZqZzq0+fswkpFmPD6JiolgWVetZjDH4ysB+h9A=;
        b=c9xQQ+Cg+J2l43mWCz3sfvOp9zZwpPmzsGmPSYv4rsOfc9Iv2+ZN7tAYped7Kf+sTQ
         hAz3K/fcsMxI2a4+LoueiPXF0FziNkBwDJA1BpKVCZ5n7adsirPGsheQdqqOl6KTNT5R
         x47BmrvoXDi+ur+5Jpb9abKpLTannynvffQ78/Z5GrlfDO+oJqD1eYCYJYqpy6aFhfz4
         LDebt28hjI63dDVb/nzQClhwu6Pk9EUBzgCejyD664fPLh1EZgGie6HwXnN1qVXEFN4F
         PBtuUNN6iJpSk+1NcKMYSKlkbSzHucgp9Pp0xruXjMdW80eoY/JGS0LJ8yeHrChq5i2n
         7Qvg==
X-Forwarded-Encrypted: i=1; AJvYcCV+LDUrpUfIYW8mPUnDF3i6+GyO+MQCOLCaPsdMpzLEuDyonTwEzKJgxMv8v05+zTSyR0VqYV4IdleYYWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqDPF+hL1Nrri4P4WqR4wMUCpRtqGs+d84tsq24kVuZed8pvHr
	RHWbqyABwdzGdTtZf6CCrQzqkOCwIjxeb08NnqmgWgCNaQBj94kQlBe/s0vYpYgc++wsY6RrCSA
	EFGhBiOkMifvWexWG9GSnTgfEEGIOn+9768sbHw==
X-Gm-Gg: ASbGncsFat3XlbuY8nE3+8jEmJ+FkbVMs7qLiYGaWqFBTZRTetsjIEAwfD/QfopXv+w
	KULM1wq/iuB4ZOkiG0MNi2dehyZw+So/LCK/WwkDqKDvc+D5UdTY/xRDVYvCpiNh4ycfl4lP981
	4OzeVLUKZ70rL6xE56GHhrDFgNwoJiYs4YN0Yk7pW5PaCwtg==
X-Google-Smtp-Source: AGHT+IGRryQZey4md2gCZKMAPgpPKfd6jIR1elEkmSqIVQ7Rm5RNzJwqA82lZIzpIZ7of6EckvnAb00PhWCAFAg43Lo=
X-Received: by 2002:a05:6000:2284:b0:39c:1257:dbaa with SMTP id
 ffacd0b85a97d-3a09fdde004mr5248186f8f.58.1746455831960; Mon, 05 May 2025
 07:37:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502-vmlinux-mmap-v2-0-95c271434519@isovalent.com>
 <20250502-vmlinux-mmap-v2-1-95c271434519@isovalent.com> <CAADnVQ+dMwAFPO-ASojjYPxODpCKf_9FCLjUvn2HeHigL53JdQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+dMwAFPO-ASojjYPxODpCKf_9FCLjUvn2HeHigL53JdQ@mail.gmail.com>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Mon, 5 May 2025 15:37:00 +0100
X-Gm-Features: ATxdqUFASGpQMncGff41_zyVmbKXRgRyXvQdozB20vSAY52iy8F4VaheL5-kBFM
Message-ID: <CAN+4W8jLdcJbVvQ_YaPVqP0EB6reFgt8S0AZh_w3K80tsJvX5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] btf: allow mmap of vmlinux btf
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 6:15=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> remap_pfn_range() should be avoided.
> See big comment in kernel/events/core.c in map_range().
>
> The following seems to work:

Thanks, this helped a lot.

> but this part is puzzling:
>         trailing =3D page_size - (btf_size % page_size) % page_size;

The intention is to calculate how many bytes of trailing zeroes to
expect while accounting for the case where btf_size % page_size =3D=3D 0.
I could replace this with a check

    end =3D btf_size + (page_size - 1) / page_size * page_size;
    for (i =3D btf_size; i < end; i++) ...

Better?

In the meantime I've looked at allowing mmap of kmods. I'm not sure
it's worth the effort:

1. Allocations of btf->data in btf_parse_module() would have to use
vmalloc_user() so that allocations are page aligned and zeroed
appropriately. This will be a bit more expensive on systems with large
pages and / or many small kmod BTFs. We could only allow mmap of BTF
>=3D PAGE_SIZE, at additional complexity.

2. We need to hold a refcount on struct btf for each mmapped kernel
module, so that btf->data doesn't get freed. Taking the refcount can
happen in the sysfs mmap handler, but dropping it is tricky. kernfs /
sysfs doesn't allow using vm_ops->close (see kernfs_fop_mmap). It
seems possible to use struct kernfs_ops->release(), but I don't
understand at all how that deals with multiple mmaps of the same file
in a single process. Also makes me wonder what happens when a process
mmaps the kmod BTF, the module is unloaded and then the process
attempts to access the mmap. My cursory understanding is that this
would raise a fault, which isn't great at all.

If nobody objects / has solutions I'll send a v3 of my original patch
with reviews addressed but without being able to mmap kmods.

Thanks
Lorenz

