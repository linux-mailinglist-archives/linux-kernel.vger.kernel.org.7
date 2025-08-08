Return-Path: <linux-kernel+bounces-760818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B6BB1F097
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5FF1C23214
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BAB248F67;
	Fri,  8 Aug 2025 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="YENAXNLo"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682A02E370A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754690733; cv=none; b=U2vLF2BufTA60fEQ4YoZiGIXlAVTh78CQhnzVwc6NBMfG/edLaINGmndeLlnzIQON9tAzUbAzkK8LQg6cizg6Q3CSuK+NNnCCnkBZxXYY8eCh4k7vNUGmJcLN1MNYUzc+B6wsJ2K1vj3FHYR8Ro/zvhK0ODPR9z18RhUYE8eB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754690733; c=relaxed/simple;
	bh=z0p4fSt/9QtpNpe3fR6Xsb9YfFn6QCE6Uv1Dq/Mm0+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NiFMcbjImUlZ8bNXGg/6khodApkvjBnUkRNucGQMK4qyP6e8KlMLOfwBmOTpPiZtiugHukrN/5C4nAivW51Xw4GSb1DPesYoRbEVKzyvoeOk5+cQ+E/EjVN2pNu3HHzNPQukmQOkt5ELvGLYyMNYydeZy8MAMk3I2vW+yu2irok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=YENAXNLo; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e9052f82d4cso848839276.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 15:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1754690729; x=1755295529; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4q+cdyvWHF2EFZpRv1rdYQz6WreFMS9niRVK6qj7E2I=;
        b=YENAXNLo/c1kmg5gLZp8IZ8I12tdJnNx4i2pmOhQl17AAaAP3HUpq7bSqoYTmWUnhs
         eyb4NukCahrM4TCssYOEowdmc5fM+T55nqwdFrq67yRmf7BPjfOvJhyHwEumfbYqb7hq
         JmBO8mXEoS3QLvrMqyk013nwknPhYHuXAGka5KCGHFB8jwb8V3T3/YY9pCfJl0MRDbjy
         vSnNgFgwS/JCAWCkHqQZh106psd5dIhsRxQRU1NMHuIyn9Qo+abwpBjQ1fJT6Ktj28Vq
         YKltxfNGcSeTP7amjYsymrFcpYDnM5Q7hOtV7AAzbNCBlXi3LOUYHa3d/YVXlRJ2qpi5
         aL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754690729; x=1755295529;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4q+cdyvWHF2EFZpRv1rdYQz6WreFMS9niRVK6qj7E2I=;
        b=b3DOBGQIB3VB8b7I6TOAt3AyfrBEaGLV6VKGOfK1l+X8O/WbS40Zgr9XEblXMYTop3
         JjRBfwrCQ9eLFHDrcjaD8if2JZi8u6OX1pwgyHUG0b9SqbhlvyFYtmhD+lIFp2Z/4F3n
         /IglOKfL8tEg/JzEk50IeZAwQzDWW7xeRiVLgXzaZHwYt04FcMjNCVm9BRU45VA9ap2I
         oRQc9M3LtUL3GzNepCXdY2xEZGQ/4RoVQiGyOkNf6FRzHmi+5VrM3+4fxBBFHRfLbKUO
         DuVxXKsym6yOhsI8/cK6rof50WYw0HysmM6DK1IRjQUh0A53zrvf4R+0WgMa1JQWxfMA
         wB6A==
X-Forwarded-Encrypted: i=1; AJvYcCXoDq1WvMLmbhzrdziXQdgcdOL+6yQTJzk2lDVr818nGkK7W9aikCKyQAh8ZZGO3CG2lbBujtwDbCBwmOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxMoOao325TSU+Wm1MNeFHmobT+gNKQNqt2gKwATMjOsbTyzDa
	xCJyw9FN5FBy+djVn/9at70qnWPfRDuujHPIkhYqY16/uB7Lj0DOMol1XDAHZzVYob8l2noganT
	1LNqFNriNGw==
X-Gm-Gg: ASbGnctR8Qly5ABV/teMFKavDTcrmyL91ch3FDhYXjLv8P61lJ8XSDbXNr/Y0MNdgkT
	SFiIzZGl9Wp3U6OZ+/F4EWJhEUha7ezQ4m743O4kgw+uKpc1iyPaWkjkMYOvUC6FAfgTu+Iikom
	ESEAFR81DuHQfeXwpZDhSTpMR7zzm2Tu7NLNcGAIEYC0fa3mxH68DQqCgd7/Fy+J2rwSf3aWMyn
	jOGBtskEXAaiGaRMa/yGBbOhSdeAZgyz1D71MWnjazI0XVDjZgdLpcs1XGJpn5o6lDiN5KkfkQf
	AaQ/tlRMfGsQmJaT3RSDO/WY42hvyYemTK87V6BHdNSJODqf7I/cowotcjAqIEJw+lsMyMWBeLa
	PMFPQGs7ZMsga7TUOCHjhvcrBrk0=
X-Google-Smtp-Source: AGHT+IHn95Eykij2+QGsYED5ru2MLntLkFJVd9rRLSQeIR5izSO1Ij4Lk7P6QYD3Yuix6ZnMNWNogg==
X-Received: by 2002:a05:6902:4a8c:b0:e90:2edf:9642 with SMTP id 3f1490d57ef6-e904b58452emr5111362276.25.1754690729358;
        Fri, 08 Aug 2025 15:05:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430::3d? ([2600:1700:6476:1430::3d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e905b5c98adsm147112276.34.2025.08.08.15.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 15:05:28 -0700 (PDT)
Message-ID: <201feccdf58b34a6d75285f74109528a66bdfd62.camel@dubeyko.com>
Subject: Re: [PATCH 1/2] hfs: abort hfs_lookup if name is too long
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 08 Aug 2025 15:05:27 -0700
In-Reply-To: <20250806171132.3402278-2-frank.li@vivo.com>
References: <20250806171132.3402278-1-frank.li@vivo.com>
	 <20250806171132.3402278-2-frank.li@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-06 at 11:11 -0600, Yangtao Li wrote:
> Long file names for hfs is 31 characters.
>=20

Could this max name length affects the xfstests in the case if we
finally restricts the creation of files/folders with longer names?

> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> =C2=A0fs/hfs/dir.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index 86a6b317b474..30f6194da939 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -25,6 +25,9 @@ static struct dentry *hfs_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0	struct inode *inode =3D NULL;
> =C2=A0	int res;
> =C2=A0
> +	if (dentry->d_name.len > HFS_NAMELEN)
> +		return ERR_PTR(-ENAMETOOLONG);
> +

I think it makes sense to follow the HFS+ logic. We need to rework
hfs_cat_build_key() [1, 2] and hfs_asc2mac() [3]. It already operates
by -ENAMETOOLONG [4] but it is not we would like to have.

Thanks,
Slava.

> =C2=A0	res =3D hfs_find_init(HFS_SB(dir->i_sb)->cat_tree, &fd);
> =C2=A0	if (res)
> =C2=A0		return ERR_PTR(res);

[1] https://elixir.bootlin.com/linux/v6.16/source/fs/hfs/dir.c#L31
[2] https://elixir.bootlin.com/linux/v6.16/source/fs/hfs/catalog.c#L28
[3] https://elixir.bootlin.com/linux/v6.16/source/fs/hfs/trans.c#L97
[4] https://elixir.bootlin.com/linux/v6.16/source/fs/hfs/trans.c#L125

