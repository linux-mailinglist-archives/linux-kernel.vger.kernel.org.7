Return-Path: <linux-kernel+bounces-831412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F77BB9C96F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF55D4A7DF2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1CE27EFE9;
	Wed, 24 Sep 2025 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="aO7GILTo"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07DA1A9F8D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756803; cv=none; b=jnOx721uPRm6g5MYdWUoe9yhq5YrWZjxGfPon4oBfkSRqMZ90tOYnaAX/nWgVb0UIA5K4XvJUq6Kaq1vrp7xl5i8PaVHxCyLprS4HnEnX+U9Ypq1RSOcyBp6QBt/4+nm8s752XMs7sGk1Ce0ycJFLve5h06bw85F8rrc1brC3qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756803; c=relaxed/simple;
	bh=BexvBLWe9ilLyfjQx7lfSxdU87TTc4v75SbAwVdNq3M=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=Nr4mqRRR8lTau73BlTmAWPrurkjZQ26ZxgEXVch5d+oEKsZPKH97HqXgN7TKbp0DA7KrJayG0YYPGJqkqsZClKCRFoWbwB7vC+4ObGqNSKo79EqMSG/hdJJRoPc+nz9OEXv/ic2UmYoK01NwUhPP4LcvAwfyAoDp/KAlbFX19zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=aO7GILTo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26983b5411aso3041725ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1758756800; x=1759361600; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M13+AL5iaWUxovfWXVCx02kI2l71HfeV5Z/VI+kVLQI=;
        b=aO7GILToMkYEct6DtBRpGUTBHsLIv63pfOYkpzetm1mRbz2E7+odJiET1UIR9ZdTxI
         A3HaDnP9StsazNVHfUACn+FQe1mMJDal6vAypgErjoHwFa6vrbdYzEYAGhcNxCDmUIvq
         K3LGriXYzp4XY6Boyxbi9ap1ENgUu4ShdnmBeZ3RrSG5JAABiN4v1DEvnWpDoh6/7tOk
         yB+21D8u589SMVCCWUrLkb4FXbBAxuKZZ05rB3z3eRvlpbOEIdTSZmEokl8zGLxkMErj
         iQO/vhO2/lj+66x4Mxqlm/hdUXRahlO0JXQ9Og3apvKtamr5nuhdHJoC7xgXFTzr+fV+
         Gcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756800; x=1759361600;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M13+AL5iaWUxovfWXVCx02kI2l71HfeV5Z/VI+kVLQI=;
        b=euYrtAJ54/w3hbeVQ+jJLBFfEP+dujTIz0DnyZFiFd+79gg+Wt6NvD2Uvktv5U7J0M
         tU4hMSKzq3MR2V0Z+kmrHdNnNLJq5XRb/ryI8V7B973xNvofaM5A7td110lKjvTbDh3K
         Z4vwD86apXokjdLyvGo74gCar/f6ni1vCqSbEfGws/jzFG939G3BVww9Xr057+01ggLW
         +SPEVX27IPHPjMjmdxeevOgD5vjh/dTTDw7IYtj1hVjVMRAuRB78PZo7gENyznKoYsqj
         arqRRxHnUUJAyseFSaKkAYXBRbHJbu5QL1xVmt/gRbqNk1qB8DK9nI4qcxzEDiin9K9P
         ONTg==
X-Forwarded-Encrypted: i=1; AJvYcCWqjBMAMbw+gWa1F31WrwWsTCJ82qxGI3Db9vhogmbHQqXLf+cdfaPW6qGqEeVLWmeAV1uPg13v6JCGdsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKSofRoyP94zXcUaayXmfeEFFsSJZqSFktIx38NWzbw471WpR
	UQOSJG7AhMGv6dE2/0kim+xSaS1/7WxAEru4wcLpyyUFdKRifaiURBIvw2dtdGGYoyM=
X-Gm-Gg: ASbGncvQb+LjGs2NK32VI4WU/ftUBrCSG2xp9akMu6/O0arCxr3u0hQ2X4izuHRosAc
	LEPb01nW8OUqV5NzogK+ceIITHjkmEUHSyyBJ3KSvwhLVaIDKe0YxiQ716YET43RRGx4X5i8i1E
	qbwkgJx9q6uo8VnMcOgBirJtVdLXEl2YAv4eIliySFh8FzSBD2uc0VzCiS4IRP2FIV24aGUCL71
	NCHoXeL8NHoPsZv8bH2V19enffxhX8Kff3lNl8HPVdiIl3RlvSfHJA6WRgXUcCgctYIVpKv0VGo
	eqdBrOtQimClICz1++eRCcyPU0EbG9veWYrZM4uv7bZa5HRhwco5BUcrAqAWo7ul9OKNEdi4K//
	Pa0u0pBSXGe4xPzrREKzyvl3E8W+bZdTwjuJ+g6q9yegjlTXETXKPWOxxhRPESo0hdJXmhIw=
X-Google-Smtp-Source: AGHT+IHrf/fFd6VIegG3nlmHmbRRevDnQaITsbK7dyzLoVqitycl0QpxaLZ5UAv8wQee8BzV4NI6EQ==
X-Received: by 2002:a17:902:ce01:b0:271:479d:3ddc with SMTP id d9443c01a7336-27ed4a1a371mr14270405ad.15.1758756799797;
        Wed, 24 Sep 2025 16:33:19 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3ac4sm4542475ad.5.2025.09.24.16.33.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Sep 2025 16:33:19 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <294A93D3-4FBA-46E7-8814-1C7E0CC82359@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F14A5A4F-4995-4DD7-853B-9A5FD1AB60CB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Wed, 24 Sep 2025 17:33:15 -0600
In-Reply-To: <20250924011600.1095949-1-kartikey406@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
To: Deepanshu Kartikey <kartikey406@gmail.com>
References: <20250924011600.1095949-1-kartikey406@gmail.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_F14A5A4F-4995-4DD7-853B-9A5FD1AB60CB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 23, 2025, at 7:16 PM, Deepanshu Kartikey <kartikey406@gmail.com> =
wrote:
>=20
> Fix WARNING in __alloc_pages_slowpath() when =
ext4_discard_preallocations()
> is called during memory pressure.
>=20
> The issue occurs when __GFP_NOFAIL is used during memory reclaim =
context,
> which can lead to allocation warnings. Avoid using __GFP_NOFAIL when
> the current process is already in memory allocation context to prevent
> potential deadlocks and warnings.

This quiets the memory allocation warning, but will result in a =
filesystem
error being generated (read-only or panic) if the allocation fails, if =
you
follow the code a few lines further down.  That is not good error =
handling
for a memory allocation failure during cache cleanup.

When __GFP_NOFAIL was *always* passed, then the error could never be =
hit,
which is why it was put there in the first place.

It looks like this function can return an error and the caller will =
retry,
so that would be preferable to causing the filesystem to abort in this =
case.

Cheers, Andreas

>=20
> Reported-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> Tested-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
> ---
> fs/ext4/mballoc.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5898d92ba19f..61ee009717f1 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5656,9 +5656,11 @@ void ext4_discard_preallocations(struct inode =
*inode)
> 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
> 		BUG_ON(pa->pa_type !=3D MB_INODE_PA);
> 		group =3D ext4_get_group_number(sb, pa->pa_pstart);
> +		gfp_t flags =3D GFP_NOFS;
> +		if (!(current->flags & PF_MEMALLOC))
> +			flags |=3D __GFP_NOFAIL;
>=20
> -		err =3D ext4_mb_load_buddy_gfp(sb, group, &e4b,
> -					     GFP_NOFS|__GFP_NOFAIL);
> +		err =3D ext4_mb_load_buddy_gfp(sb, group, &e4b, flags);
> 		if (err) {
> 			ext4_error_err(sb, -err, "Error %d loading buddy =
information for %u",
> 				       err, group);
> --
> 2.43.0
>=20


Cheers, Andreas






--Apple-Mail=_F14A5A4F-4995-4DD7-853B-9A5FD1AB60CB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmjUf7sACgkQcqXauRfM
H+A+2Q/+KhJn/qn6CJFMmsDY7t2UYqBz99PI3ZQiloG9zhN8TiA1Dm1sVIBfgjBO
y97wluHI1O+Jg4ZvAsfXGDeCXazItLhxWaBSeV4BZcmQTZLXB71VfP9KNgMWkaLe
h8zNtri+m3zE1/+KHr9K82HnufpLwg1jjOIrl3TBHElR8coCHb7QrQdvyvXlU30n
2HN5kSwxCMdB4VbUxND0IQuTaIC928T2zDB4b+8A65cyBt6Fc5BqfaL/p0rhTZyh
lqna+ssQ6U2ONnNY4/u2uDo/GfYzvWIKMn0uUjeK+ITFurr3keqtY9vveHFT7mol
5eJsfzfM2ArYscESF4N8T5uEyBvN9nO2V++wpn76vK/uStlmN3miRP1YX24/Cw6N
T/AtSLblEWP3+zYFkRp4As/1ZmktUCvm6XAT/XFvtjvQP6g50ZL/bOxRxMhVvvN4
7lr0Pz0FtlkQIkkOZiJR5DlpUT+VK3msa2G7rr4CbB+gsC0vUZ9IkWVC+388rthT
oCTu2Z5scLiaZAo54VOOELRL17h1iGi5vCT+eXEGrBbbtz/du0WAkbnUqrKSacps
/x8invmHwsTVImMzX8bAJVy4klP+Ch5ntqna0NTjEfgV+nt6f1Q4bkRnDRKafyrE
elZX8EiaAviMlq4xiPh2CRL+2drmqI48dQPQV5MWDSo4e8taIOc=
=lAjr
-----END PGP SIGNATURE-----

--Apple-Mail=_F14A5A4F-4995-4DD7-853B-9A5FD1AB60CB--

