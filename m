Return-Path: <linux-kernel+bounces-846078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BF7BC6FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 02:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02AA19E2B52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 00:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5AF4F1;
	Thu,  9 Oct 2025 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLDVNUOk"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF9C4C81
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759968758; cv=none; b=I1xC7d7Y8tHPEjehazmm9RLUBAvFAdpPCZ00TgcaHf97ug4hpJ/mnotKQNxqOjL6xYEVAeNfUg2GBki6rsnI98xDrkByJPDw77KX3raU2fw7nVibEeHC0tXVXpehUFwLC4d0s0CUZe08QYFBzqa+mpCdTP/zFNfGgkja9+NcwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759968758; c=relaxed/simple;
	bh=Z0JF/h8mBUCqcPAR13Gn4OPXCm3qaHZYWJB6uhLvJtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8oggi9b0qjxeQ5yAelcvLKBCsxDXn2qBnV0gPmvdwkF0o+JLuBhjCfttw1cj2wFpx7W2g1sBKyGybqMgX6eMvfBn7bw1KUEuP8TUoN8tYIkRogmPjUfUEVxxBHa2hbmp1+nfO+twIIlAXjJ/ifDcmFgpbSbBzgAe4D2ps8HvVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLDVNUOk; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4e06163d9e9so3146201cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759968756; x=1760573556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLOs0m+C5vy8eU1JuQcMkicCaJKpraCdPB1zIalrqqQ=;
        b=DLDVNUOkky4k1sok6w7IfZN1sYj1GMmOaLvooxszPDdZn8YxmOwoNqgnOjAiH4AQ+2
         0Gg0nnLNt90ImTl0WeO7iuuVQnxwXl3pAnbusMS9TxlfPhILRqRqLBFGhCjxLiJ11mou
         9gWxK/JMEcxZK2qysIR8oB5yB/CRC0QfPkzvRD+X4pyUEJR4b0SIEctQRUME+mVZ2Ocz
         /hReImJNenpbKGAlmv5KOvkWsARcHHS+AFkIw+tiZoppOcFoieVtFTzHwB83Tq2Z2vib
         PCuG8RpKWOjfwl5mJho2MlY/9XMfRFAPMI8TX56OQQgfg8S5hdKQwWIiMZRTdUiQjLBa
         48Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759968756; x=1760573556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLOs0m+C5vy8eU1JuQcMkicCaJKpraCdPB1zIalrqqQ=;
        b=ZMgfjwCsQBud5JaGA174CJpT4JVm0RH7jTPFcEhLdXP9wZkainBQeHKyrTyOpw553c
         Ad5OC6ZGmk0rFHgqQ/BoLn5i7K7PlDAWjjK29EUVqhIUnAeAjLfKSd5VAnJ2Rf1H+oG/
         pf6ViwXCcnvlwuJ0rVlhKgkHVgSZVb5WU+dWVUScQPsVZI63WRW7VhLgnKb+dZcxMC6k
         ozqXJC0iqZobcEfGKLI6QY5Z4s7ModMVdOhaIArynBNPSaIYp9YsSlILT2rNuhaPf1Sc
         f3AY12iqwhz87aFrP7Fvbe31v9biyOvzH4naYFlncwVviNdWYsdcs8ACL41FRVcAwn46
         S4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWpb7VTX5J58UNxbakrnkFMnqxU7IhTW/Qc6/e+tHFNf3L6brHywDP4QJU28qoZiyy2GXq49ov3AGB3yn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQHSMV2492KnR4eEtG5OsznbCUlD/rQTv0z7ifOErgSC1tq+lm
	XUJuU6L2b2TMBNudxjqI1veZmkZ7U/ogBiMLMuCADk9esP3pbF5/g94FHZAwM6nz01PReOfAQ8j
	a/rOrW582VocPPnPLxi4ppbpf+5PevaU=
X-Gm-Gg: ASbGnct6YU0sDJJhUS9bHd/g3AibYlIiXDw/WQDmYoxJCAAUVIFCwsDR6RNblmVlHF0
	qRx7+SJf/Uz+oUEh+BklVP8f0jMaKHo5tnWdStRQ9r4o7U4MWQb24GwEChdbCOKPGNpO4OlTz+5
	nZJm3jm+EV8R63Um5AElhayCdLlwpWJ7HrWNOrXuiNQM40Kc4vT32qazxHZiMvxETkeorI3MXNF
	mfqgNA3sJlU8JoSEhLGqnB1W9anZXmdFrOzWBw1UYgTQ6VQDgiWWMCycc/aOPIjBpaJL7QWk7Uo
	jgwBY5/8g21eMDEIqgpI82VkLDxBY5b2sSFdZhz6M76Fe0P9OUQy0pZ3tBZHLe9NHOzgct9bzjV
	rjfRgm7adkenbqmUgdl+ACp/qjMJiIuo3i8kBMdA+YdxeZg==
X-Google-Smtp-Source: AGHT+IGTMJxEUzyjJOaL0+NNwHEI9UfsX87q17OQxRmhejzUvwBxmkwB9k17auDXhJE1cMaLG7jkj1CnKy1ELrzjvrA=
X-Received: by 2002:a05:622a:6a42:b0:4e6:ee71:ee96 with SMTP id
 d75a77b69052e-4e6ee71f26cmr35134331cf.25.1759968756008; Wed, 08 Oct 2025
 17:12:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5b95806a-e72e-4d05-9db8-104be645e6e5@web.de>
In-Reply-To: <5b95806a-e72e-4d05-9db8-104be645e6e5@web.de>
From: Steve French <smfrench@gmail.com>
Date: Wed, 8 Oct 2025 19:12:24 -0500
X-Gm-Features: AS18NWBDO6yK69iSBzCC-3F6icpJXqhtpmdffwn6wWQE7dyQKytMaHCk49ryAxs
Message-ID: <CAH2r5mtrT7m71i2928akVarmQ0FTKzaEOu2q4781U8a-_w__ZA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: Simplify a return statement in get_smb2_acl_by_path()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	Bharath SM <bharathsm@microsoft.com>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Steve French <sfrench@samba.org>, Tom Talpey <tom@talpey.com>, LKML <linux-kernel@vger.kernel.org>, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next

On Wed, Oct 8, 2025 at 3:02=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 8 Oct 2025 21:56:34 +0200
>
> Return an error pointer without referencing another local variable
> in an if branch of this function implementation.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  fs/smb/client/smb2ops.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 7c3e96260fd4..bb5eda032aa4 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -3216,9 +3216,8 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
>
>         utf16_path =3D cifs_convert_path_to_utf16(path, cifs_sb);
>         if (!utf16_path) {
> -               rc =3D -ENOMEM;
>                 free_xid(xid);
> -               return ERR_PTR(rc);
> +               return ERR_PTR(-ENOMEM);
>         }
>
>         oparms =3D (struct cifs_open_parms) {
> --
> 2.51.0
>
>


--=20
Thanks,

Steve

