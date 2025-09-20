Return-Path: <linux-kernel+bounces-825815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC0FB8CDEF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84511560F06
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B238830F95E;
	Sat, 20 Sep 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neI/lwQ9"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841F32FFF8A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758389659; cv=none; b=IPpn8jCBK+C2Suc5ai4a+XLAiDdHI6nG4Sv53tWirg4ZIxuWbpt0M4oCLjI+ceb1wwmoGErWrsP0qyo7U0xT1bYGsZwfSWRArVD41ttv/WDBJGYL68LFPQEaK/n2+aapY0GfBaWY04CQHh9e7Mu00kGQylmhAg64QuXQWtArcqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758389659; c=relaxed/simple;
	bh=fjR9JFlWRTflHruCmH7sfe41GNKR1SlUHyHHAaj6RKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyzuWtjIMzoNCqMPU70txrm0IYfeKvtvh3PxurxZFUmXOWpGmsVTotaexHjvgzSTZf62k66zA66twFLtoZuQkr1Bs5uUNGOx1k673w8m/tV+62WiOcTU+55qA6VcMLDy+fHEGl9Dcz1KeoN6eAq+ysm20C5QUKviIMABlr4kUQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neI/lwQ9; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8116af074e2so315964785a.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758389656; x=1758994456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0VO0A7zIqU8xKhWSL8LGrAnldKkVRxERQhWv6Dw/8kg=;
        b=neI/lwQ9nBBHA5efIEry+PbTsRcID/BJSOtUnmg8Q4KTxFhm3/Kyp2RZIGfB9UYzJh
         8bAgP/bOBtMPk6Y1eyLciSsJgFKxbtSkajeNLInd1L3TdW6LAw5MaP/jklvMilGIDLbl
         SPywHLc7hKG3BUMZChbcoy4+D/6vrmEZFkC09afqxPSKF3BLkgzkLg6GoZQYUdkTTixg
         9tK5xopcel11ctUT3XNgoPaL0N4mCvsx9XpVRUliyNCBKJhg1cw9zZQMkxs0F4s+Exin
         doKXyj7roDS2zXz8OITy9ZM5ih96rZdMQbV+bIAuq60Y3f0yh56dscaA0jSSM3Rg3K0m
         FZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758389656; x=1758994456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0VO0A7zIqU8xKhWSL8LGrAnldKkVRxERQhWv6Dw/8kg=;
        b=l+IwEYnfYQ5igoXZjZERAlca6oP5ozJB55K1rbrFL/CG8BkgV7ksEMB8YZMY0j0BA+
         X3Q6eKwaFsAJ1nrGM7SXVAK0wnFNuehd/XdGkadQj+IYSXJ5yn8rW/OCzIT/HcyrCj7G
         rMxLd9+3tEyUfOTp95lqB5AgU/CaEcWf/BmgnhG/qRycEhFDZ+vhNj3Tc21o1vdzbR6w
         oPzVPc/uCNno+nlqSGY+kA7ijyYcPDKOhKD8XUHphVbHi+PAOFqa+xAdQMI2ch67EHrv
         6jyWVn5QewX4Ape+Uz6MvOR4aLqRHd9alMqYvzqLRIfAeEASi34v335WnOVx3Jh5+4NH
         jhHg==
X-Forwarded-Encrypted: i=1; AJvYcCWefwEjaVH3MZiiwAzBDNN16eIackosVzMCiLotE0pbHFCeW825WQxmWlK/uRMVSNZgM+PTi7wHd+yo814=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJ55obbDMjGXSmGCF9Mr8WWhQQih34p76Wk1j6PAycI0CFZb7
	LINJTvBtYbycDcZXuUYvjtNihqwonQlcqyt0y6lQqi83kccCin4e4+SOLME/JET2bKOm+0DYUCu
	BAvvwjEKFMqxTmWfR7yHpEXPXyjzH27I=
X-Gm-Gg: ASbGnctida5qlQtWexcZQ+21TvDSnwpPAmQTRFa7quqP6ycom/2/S165Z3LoqMk3TYP
	bUTdIAZr6vSMyawm0AD6JuKy5mGumVFam8n3hTkfH48adSidBBViD7qOFPkwqno7ddofVROkVyh
	q0StQRMqWq9hpW4zD7pEi7DQSgRF3REEth16BOqi9WkN9HHEv6l2WL5ovzK3r6JSrOXaRX86oeF
	ONKlcU18FvIUQ+cxC/OJ6C7rEOuGU1RwVm9AMpEL4T5JE7DF2DxqHYdQathksk+1nbL8l1d5j9W
	FkM19K1xrHNgfr/YpDD67eivo6toAqlhE7GNWaEnG0oxktk075yRUqVwhnVYeTjZhWW8SHc3LPp
	e778YC4rC1IvMyIucEC9i
X-Google-Smtp-Source: AGHT+IFj+RVGEr/ivtHi7RmHcKrvMcPpE2DZlXW8IOF7Bb+jli7NjwDWdk/qhy2QEe0DOPw3933HcP3Y/3Ps75OVxsM=
X-Received: by 2002:a05:620a:4006:b0:812:ac32:affb with SMTP id
 af79cd13be357-83ba29b5ce8mr999618885a.17.1758389656258; Sat, 20 Sep 2025
 10:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831123602.14037-1-pali@kernel.org> <20250831123602.14037-29-pali@kernel.org>
In-Reply-To: <20250831123602.14037-29-pali@kernel.org>
From: Steve French <smfrench@gmail.com>
Date: Sat, 20 Sep 2025 12:34:04 -0500
X-Gm-Features: AS18NWASxqdbcjNWSLHLtnvE0gYbw0rjcsQIKcNVkTaxSXs7rmoN24rESOP-ymw
Message-ID: <CAH2r5muoF-OKg9e=T8moEifwJ+RwmGX28nXqgECM891TufqY_Q@mail.gmail.com>
Subject: Re: [PATCH 28/35] cifs: Fix smb2_unlink() to fail on directory
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	ronnie sahlberg <ronniesahlberg@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This did not merge to current mainline

On Sun, Aug 31, 2025 at 7:37=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> unlink() should fail on the directory with ENOTDIR error code.
> Flag CREATE_NOT_DIR handles that.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  fs/smb/client/smb2inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index c8b0e9b2438f..c69293fcf26c 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -1348,7 +1348,7 @@ smb2_unlink(const unsigned int xid, struct cifs_tco=
n *tcon, const char *name,
>
>         oparms =3D CIFS_OPARMS(cifs_sb, tcon, name,
>                              DELETE, FILE_OPEN,
> -                            CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POINT,
> +                            CREATE_DELETE_ON_CLOSE | CREATE_NOT_DIR | OP=
EN_REPARSE_POINT,
>                              ACL_NO_MODE);
>         int rc =3D smb2_compound_op(xid, tcon, cifs_sb, name, &oparms,
>                                   NULL, &(int){SMB2_OP_DELETE}, 1,
> --
> 2.20.1
>
>


--=20
Thanks,

Steve

