Return-Path: <linux-kernel+bounces-741442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE31B0E421
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0A9581392
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E86E283FDE;
	Tue, 22 Jul 2025 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="LmmEy/FC"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0F027FB31
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212423; cv=none; b=dIqr/OFUzU6pR3hFvAjbnsTNjNrLLPg6m7oBnDXgjFIETQ+6kcl1NXSLzEpZmGNd06+Yq9J5IOUFYc1H05RyD6Tn4Ul8tvf6UVYvaLQL/4DB2oKr4YdxI3RpLycp5nyFXX7Qmmw6JKYZtCw4du1P4dADeEDLFRJJi8ObEdnudus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212423; c=relaxed/simple;
	bh=nL7kBrzyr7z+2vE9AXFIMqKnMDrBlfMMLL7j8sAKYoM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U2wnHO2f1jApTJd9gOLdsZ3q6EWxk5qw1zzezPTutVm6wfCbk6NmbPLQKMdh5puQBybSXhFK8oHpBs+JzD9Y6W4+jxvoRZpa9jHUO+4UTfzYcIBoAK21wk/9bVbLzvYfraKksRH3+iFywU65KG0GP1DLN0v/H0vcBgEaqjfyYI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=LmmEy/FC; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8bcbe46cf1so5534539276.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1753212419; x=1753817219; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f6rA10mAFSIy2EN44P/5y4VeVI9jpKueAsjkjfz2urE=;
        b=LmmEy/FCJwFTijiejYVnrXN9xZpk1rl/WeLb672iXR6USCKJ3VhtMPcN8Vq4Ttueha
         jBms13N7wPy7ueHXPJGv/cQOTgugvsXy4V22P9/I5O2wLeB4NqCgcUAdINnRlehR4zsW
         VPJltNdP9RQkz9bqmjCZhtVAk/U09va85yeDio8d/pwkij4MXyDf3Q8XT1voIgtS23AW
         8d2Pg2XsVPktqMh+M534MkMkqLkTMehV38PPwFvVG7EUficHe5HseIzTIeqZKDYTWzED
         iTaaBmunNDdp/+o5+H5Qkwqsep2x3vh8i0nP1Xn0qTqMmot5Nie1oVpu9+vfgWg3nhOG
         OENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753212419; x=1753817219;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6rA10mAFSIy2EN44P/5y4VeVI9jpKueAsjkjfz2urE=;
        b=sgtJ2oBNBnpSM0dEPFwiQJKs1sIQGGSXpc+5wNZcj7W9avRgwcbNFFZwdgUqZTcUgl
         a9HB7tbiDrb9BoMtUnvO9ccMec6KVPdQ38zftlebhx8Ia3l3OMu230vJmO2cOBe9HqhZ
         g0JV4HbtahZ8rBYpjx8wUR2RIbm9FhBbze/+GkCFIA43NJ3ufE4UqWtsVkTknygpHmro
         wFugqI+cygL/tRJ6aCx5BRJEKznowfq34QqWdT7HISu00J/mXLK91WdMtvjMdKLBg4hU
         lg645npagWOscOjHXf7v6jP+xbqepTYqi2JfgvF6r9QPHhqXiYwcxcNT+NIPacABcS2z
         6Nfg==
X-Forwarded-Encrypted: i=1; AJvYcCW5Z3QzntnHYNlnzCM2i2U05xw2Dq1GNDAcIhWGEMvQucKBDPqjSI5ohZmZa5FEcNEgrZzfGuJIOBUurCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyfHW3iy5s5iqL7dt1en83g0r2/o1po89jq86JWrZt3lz5hhbE
	pywUiHfs16Vphz0Q98ApxnP3aDdgcTB55ogzWqlBHKAz/EL6hnjX6oKsn6S60mQMTUOYmOPC7UU
	9sOu0
X-Gm-Gg: ASbGncvChifZ4HZDD7cY+69cyGIKyjVV3jT1kTSm/lk8LDapdMrDFWEh4efhod4UOyz
	5rWVQ+CimMv8RCHZ1mvKjcn6ZYS07H8Sew4H9J3UoA4lOQDwWtjD/6cjWX/vaTPMtxjWAihatzP
	6waWvMBqo3kcLHuPo5uC/4uASbVfv9dkGFUbcWfqsdgaxf3cnd7VdtmEQpKDJqMgGA2zwfZ5/Tz
	KhbTSFu9WHihzfirBzm8xW0hVtkAhG4QfS80jxoo/zYX/y3gFPNYs5gnxeqhRp8s9m7e744Btyb
	69PUb2yUcNUgbJWc0ONX4dv/5Bh2zbypLvct6n/jRCXeP3LLHx3qvn4LZHb5uRDv1dG+wWB57Oo
	CbEX2+Ai+ib9TNbwhGepdRY3mNOGdEmUoeC/Z0kWHvUwETvEWmav1EVS6k0/WoBh8TFUS5g==
X-Google-Smtp-Source: AGHT+IEM19VoZ2NkyDOPbbFddXU+rX7b8ADde+ckX3B0jE15Ou9SvsZhtRtbB/s4TGJTCugucCzFtA==
X-Received: by 2002:a05:6902:161c:b0:e84:3657:e50 with SMTP id 3f1490d57ef6-e8dc5873435mr671236276.3.1753212419284;
        Tue, 22 Jul 2025 12:26:59 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7b5e:cc7f:ebd6:8d83? ([2600:1700:6476:1430:7b5e:cc7f:ebd6:8d83])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8db79336a4sm787559276.22.2025.07.22.12.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:26:58 -0700 (PDT)
Message-ID: <4a9de6f3edb1d7a894437fb5dda18d709285a628.camel@dubeyko.com>
Subject: Re: [PATCH v4 3/3] hfs: fix to update ctime after rename
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Jul 2025 12:26:57 -0700
In-Reply-To: <20250722071347.1076367-3-frank.li@vivo.com>
References: <20250722071347.1076367-1-frank.li@vivo.com>
	 <20250722071347.1076367-3-frank.li@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-22 at 01:13 -0600, Yangtao Li wrote:
> Similar to hfsplus, let's update file ctime after the rename
> operation
> in hfs_rename().
>=20

I am not completely happy about mentioning HFS+ in the patch for HFS.
:) We make this fix because HFS should work in correct way but not
because HFS+ does it. Imagine that HFS+ will completely disappear or
HFS+ code will be heavily changed. Nobody will be able to follow this
comment. I prefer to see the explanation something like "The file ctime
should be updated after rename operation and blah, blah, blah". :) =20

> W/ patch, the following error in xfstest generic/003 disappears:
>=20
> =C2=A0+ERROR: change time has not been updated after changing file1
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v4:
> -update commit msg
> =C2=A0fs/hfs/dir.c | 17 ++++++++++-------
> =C2=A01 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index 86a6b317b474..756ea7b895e2 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -284,6 +284,7 @@ static int hfs_rename(struct mnt_idmap *idmap,
> struct inode *old_dir,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *old_dentry, struct =
inode
> *new_dir,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dentry *new_dentry, unsigne=
d int flags)
> =C2=A0{
> +	struct inode *inode =3D d_inode(old_dentry);
> =C2=A0	int res;
> =C2=A0
> =C2=A0	if (flags & ~RENAME_NOREPLACE)
> @@ -296,14 +297,16 @@ static int hfs_rename(struct mnt_idmap *idmap,
> struct inode *old_dir,
> =C2=A0			return res;
> =C2=A0	}
> =C2=A0
> -	res =3D hfs_cat_move(d_inode(old_dentry)->i_ino,
> -			=C2=A0=C2=A0 old_dir, &old_dentry->d_name,
> +	res =3D hfs_cat_move(inode->i_ino, old_dir, &old_dentry-
> >d_name,
> =C2=A0			=C2=A0=C2=A0 new_dir, &new_dentry->d_name);
> -	if (!res)
> -		hfs_cat_build_key(old_dir->i_sb,
> -				=C2=A0 (btree_key
> *)&HFS_I(d_inode(old_dentry))->cat_key,
> -				=C2=A0 new_dir->i_ino, &new_dentry-
> >d_name);
> -	return res;
> +	if (res)
> +		return res;
> +
> +	hfs_cat_build_key(old_dir->i_sb, (btree_key *)&HFS_I(inode)-
> >cat_key,
> +			=C2=A0 new_dir->i_ino, &new_dentry->d_name);
> +	inode_set_ctime_current(inode);
> +	mark_inode_dirty(inode);
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0const struct file_operations hfs_dir_operations =3D {

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

