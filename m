Return-Path: <linux-kernel+bounces-895793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3E5C4EEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D20EC4E65E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D569369995;
	Tue, 11 Nov 2025 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOFdNtAR"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6FB7082A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877042; cv=none; b=M/Irw/OzvVVxu95qScLxBXhmRM458Ki9oUeDONx3JyPP8iz3Ur8hxBqtbk72h7bmPxQb/wkG7vgYdIg6I/O2sx4I/kNKXADv6ahbZuI11c+LxC7b7tKKTPnBA9Hf1HqikNSlUJ9b+spSWt4dfSz/qhr2nzd3BsEI/fwShDpUyDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877042; c=relaxed/simple;
	bh=IqSj1pjWkOxz8XdpRQAu1uWC/z8Cx/Uyiq/kF6bkn2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFdI1dvdt4fpm7h1laTXE4grPQDAsRfSSpYP0WTGwuft1w9wI8XguV+VBVIX0zm7bWFCGkmnS8RyZuSJ/EAnewFALyfuj2YfDRzAhYHa4YSeR/Gcd6o7bHJbRlI7ja2VWd/MY/nRjQGB91LyRFIKDGFhy8Yp32B7E0jiZD2KQJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOFdNtAR; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8804ca2a730so63132916d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:04:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762877040; x=1763481840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p22dqnTP+WT7LTzsUQpMYPFrvPg4fKs8whrEeV7I6/k=;
        b=XOFdNtARQuUZYTaSY1j+/x+r8jPV0QmDjFvPOBeGDp3gwW17Ve9lla8i6FcQPY9Fhf
         HKFl6qxPd/PH1X/fSTDS96FIxnQQnQ0yF6+DI4hpMskFCKkFywsZRe9J6CBaR78nitxA
         NnUDgU+nqwq9OAPLWAj5cx/QKl3X9CcxXE7w3M8uFiIyx8HM7gtz+gfJGdS1lyai6Gqj
         JtCiROn8lo+9wSLn5riA2ey86kDFgI9AfC+PmOGeA/rb1SWuhEFGltLtDiEi11+4PMug
         JQkwIrYw8l6AoJB4aP7/TCA8OMuxT0M5/9J0DbaTbOgEy3CbKlkv3X2/HySVqT/dXjKB
         D+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762877040; x=1763481840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p22dqnTP+WT7LTzsUQpMYPFrvPg4fKs8whrEeV7I6/k=;
        b=mko4eQCWx1tVSYOk40EFcjr5awUa7MRMdUnMh7aHGZvIB0k6k2nIecC1BnhrByCx4W
         am4e60+qaGNZylh9pmGaOBqNO1BkbV+RBZ3VLZM07V4hwZgY2wUBa08ZOTeUJYIvOCS0
         Sql1uDJkOxoGDYMtBQDXsCedU3wk3OQ+gVZGhKIKP0NZ9M8GNIu1J+IwdOjlzAr4yW2q
         KuAAeUIEGpd/O7IQunYY46R+GjwOtLRfeU7eFgOUKyt33+fFeRYvSP38hxeJXx1eSVH2
         CbjTNRuHOWda5h3eFBaojW+0jkz2Kp5kkbKt8Hvbc/OonaBCFcxAFAK/mM/i1S+rxCFU
         tk3w==
X-Forwarded-Encrypted: i=1; AJvYcCUfmKfWqzve+G974vFSAr/PKqZjMHDVgr26K+AjGgafRHZgKx1pPjyaI9jVZmxhy9goaJOHSW6Q0U/GXfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOXVt3Wrve41THapCAb56pWOTgeqag5TdrolFhXRS4ThhYVQIP
	dO9OIDLEnEFuRbS4Jp2j5x9/okEvbfzpAxJonvu+/BPXsmYoO1aB1+lkw6mpptk8W0WNvXGhSKa
	pmonkE57QRWotcgeF1rRnrDBewRXJW9U=
X-Gm-Gg: ASbGncv07WocD8PHRryHY7qjJ8fEV31aDDaP34H8B1JKmE/xRDxNVow/i6pAs9L1Ve2
	iVGNv8VtJNTqvspACSioX1pLuoueCZeL/LEgbSZiuHk8BSq/UVsi/pMgWICGLdE+zTfpS5PYyP0
	BicyLcFCIoj3Lblz4nypThzrUyqUqjnnTdk4BLftiUrKG+gLfGJGQNvBdHgj/RfCv+T9EAPLaNH
	UuWCjye83HkhyzycnL3qTTHlnOH7fILfZ45yXvKgm3rNJvBQZqmsjr0NpWNU4m0yFolTxSG5JHu
	4dCnjc/OyQI/XxXlE6OHl+M7WfSN62V7psauTAg/8fkQk9DG6HtzfiJaClYmEndueYXjqqqkoko
	bKAKxFNL5UArJJbBBXZzDh3eh9rVawNVl5zcyZmgZwkw2zbLSPRfNMunvWjooO8uELZbIzI7/Ox
	V5sWIe0tRkHaKNMSC+DYI=
X-Google-Smtp-Source: AGHT+IGbI2y8BO4zXLUCfMUPsmSUaVvSwPP3A7OqUwFX0uRSKtOhi6kkDFDcw0Vnhb7AgoDQJVNEyWKQqIxY52glLdk=
X-Received: by 2002:a05:6214:3010:b0:87f:fb2e:9991 with SMTP id
 6a1803df08f44-882385cfb7dmr212493586d6.6.1762877039610; Tue, 11 Nov 2025
 08:03:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111070539.1558765-1-sunyiqixm@gmail.com>
In-Reply-To: <20251111070539.1558765-1-sunyiqixm@gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 11 Nov 2025 10:03:47 -0600
X-Gm-Features: AWmQ_bnWa6CPOjA90RODWVbZ9Ca-j58oVz0SxlTOoe6a2Jum9heLBu_4Q52omkc
Message-ID: <CAH2r5msGsFW0GBrZpt1odmn8yXMbORMCHWTnD2xGOhG6GpWoLA@mail.gmail.com>
Subject: Re: [PATCH] smb: fix invalid username check in smb3_fs_context_parse_param()
To: Yiqi Sun <sunyiqixm@gmail.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

tentatively applied to for-next pending review and testing

On Tue, Nov 11, 2025 at 1:19=E2=80=AFAM Yiqi Sun <sunyiqixm@gmail.com> wrot=
e:
>
> Since the maximum return value of strnlen(..., CIFS_MAX_USERNAME_LEN)
> is CIFS_MAX_USERNAME_LEN, length check in smb3_fs_context_parse_param()
> is always FALSE and invalid.
>
> Fix the comparison in if statement.
>
> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> ---
>  fs/smb/client/fs_context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
> index 59ccc2229ab3..d2cf1f60416a 100644
> --- a/fs/smb/client/fs_context.c
> +++ b/fs/smb/client/fs_context.c
> @@ -1470,7 +1470,7 @@ static int smb3_fs_context_parse_param(struct fs_co=
ntext *fc,
>                         break;
>                 }
>
> -               if (strnlen(param->string, CIFS_MAX_USERNAME_LEN) >
> +               if (strnlen(param->string, CIFS_MAX_USERNAME_LEN) =3D=3D
>                     CIFS_MAX_USERNAME_LEN) {
>                         pr_warn("username too long\n");
>                         goto cifs_parse_mount_err;
> --
> 2.34.1
>
>


--=20
Thanks,

Steve

