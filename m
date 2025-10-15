Return-Path: <linux-kernel+bounces-854878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188CFBDFA94
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089D218854E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EF6338F26;
	Wed, 15 Oct 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGi+HTAA"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E583376A2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545803; cv=none; b=OQcWayRtXGx88C/vukn0yDxaCAOaFgSAMDbqLv80vy+is58k4OLTFA9n6ZhEdQOL2MsqsLqkLhEcNI0IbVfUV/3SyHQfSNEmz5Jgag9WH3rV6BN4ZRaBYeIeYcnnXadJyesS2SBPtVR+B/X0yb4T56L3V1GQNLYrhGUI3OowlW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545803; c=relaxed/simple;
	bh=Q6rKlCtixSuiwjIXlFbpaB8zSeZrFlDJ0Zg9RlK//Y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tqvlh4m2MT/FxP75ewt7w6ZUuzvGPHq/0CNjmNWmd+OouBdCF1/diTs5lmxHWFmx9eUlHVQYs7rKztq/i6rg8sN6OkR5NdILDnJrjUAAAVXZEXrM6oTC96yuph0Bf2VEnR/JEvz50zaZ0r/Q52IthtQfUh21sC3+6J4GYCKTNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGi+HTAA; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-7960d69f14bso54117456d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760545800; x=1761150600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8GDrJ1rQnlamUx9lojh4fPxJBAOk9fRwuDS8zKFOtw=;
        b=AGi+HTAAYaeKmvdeCKFuFD3QorPfDOYS7yk5MGVHuKv3umIZVNqXDwA5/ijzxO/efT
         7F4nDO+rsjuSoS4TyT8ye8fIohqfptvhHwmCrcfd3ckBhXYNEejJu6a32R0V5Owi6CqC
         A1S8wOr3J4YLOYZ70niUVNgI6cGddCT4kNxDQXfEZ5Lc4+v1EAtnNDmd7bB+6MGrMvvX
         UT7e5DwC+C5RpxbEV49HYuRgR/CI/hMcCg6I8I7aJ+BkF1dNPRQbEVwFD0tkJspQD+6+
         f61slewSLbmHqN5dT8qrKpWW4Z8g3OatwaqvTY7ThbN+hUPzo1dUTox7Oed+zpbcnYGd
         2Hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760545800; x=1761150600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8GDrJ1rQnlamUx9lojh4fPxJBAOk9fRwuDS8zKFOtw=;
        b=KTSooQeZZfwkxpCi+X1w5K4iay9UO9+f+IwJDAci1WSyMxYKAUZl7JJTOGaoJjN9cC
         BfPE+ek/IGHiyqI6LgYaMzBHGx+9oOv+F3OtiV56rXRNyF6w9vETubTa/r/7XStEE9+V
         GKHlR3N7jEv8m79Td7jjImZDbK2qmVEjjMFalSnd3g3U4PSTczsqABwus/vkaSVWF4Pe
         PAOQX+eP/5sutY5cioomU5ZI/fC95iVaBbMCFtmrFW6dOW5YAjSHlKQL11LF42Quxq3Q
         QQy2/qTzoFZrlWohKifUa/Czs4ZBD0Re0U8gh+Rct+faXg5CdBEVM8dbttRrMXSINP7g
         5DGA==
X-Forwarded-Encrypted: i=1; AJvYcCWRUoynHyZPdPMBdq5M1MV9mZUD0V/u+8sSyBq+QEXZFdHhyvRAd86yG4JEvisq5hae4VhslW4w1gr5eKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPxU2smuk7bqDIQ+FK2EqroQqueJNPVoqtCm5gK35Tt2UdHqGx
	3yCzrjXVMOh12PxcfxazuXjZ+NpTVpHG2rH4I4I3IEKvxJJ2XXgHPAHy54S7vZquVwGZQHTEeLc
	l+9YIq48nD7TNfTKm1X4YnqZ9VXOTRAs=
X-Gm-Gg: ASbGncvEPG2e32rAYCTwoJL+URiT21E2iKFsspmYWI9i2vsaIBLptGwdtFvMHUeGr1v
	dnGHZnwhk2181QXmbm9HJ4niHByq29DmB+I/zc82rIdyDz8k/0ciMEHvTWEDJxr9IOX9NlQIkGD
	nfagK9wnkWQW7cNVfcFJUJSm6MAqrKAXgRIEeMzinpDoRz7BM9cS+k/97jOlbq3koDlZ20UCkmr
	p1guabiq5Eovrri5KXAoZt/I1tuCwinkrRqaUxcs/llnGQDj3AqME0pn4l+RCNJShVZcYRKjZZO
	H0+yXdM9xLxb4Gcb85rxxOnWe4DLt48tTmP3bCA6Z/KD/2bz369q2DBvLILjWx6E+etbeUNTIhI
	AOwxn/eTD8KJVHWiAongHhS3iA5YnxM+mFizblQ==
X-Google-Smtp-Source: AGHT+IGVISVKSMZGXKvoUfC3pFbB5+MNCgPpT6oFP0VzuN6FflZ2A58qUHZ/QKyXQmRk6Yh4FFnGDxift44mJ0jL8XA=
X-Received: by 2002:a05:6214:6215:b0:87b:cc00:5de7 with SMTP id
 6a1803df08f44-87bcc005e4fmr188945256d6.18.1760545800119; Wed, 15 Oct 2025
 09:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aOzRF9JB9VkBKapw@osx.local> <6599bf31-1099-426d-a8e5-902c3d98e032@web.de>
 <aO/DLq/OtAjvkgcY@chcpu18>
In-Reply-To: <aO/DLq/OtAjvkgcY@chcpu18>
From: Steve French <smfrench@gmail.com>
Date: Wed, 15 Oct 2025 11:29:46 -0500
X-Gm-Features: AS18NWCziKfp_DI39cJxX3YKcNnedwhMB2N5vzWIwfO4Ia5b8m3SwzD1D2OHnU0
Message-ID: <CAH2r5msK3SDhAM0_monUcNTrf5JCwydD+AJgARaiVziUUo0WmQ@mail.gmail.com>
Subject: Re: [PATCH] smb: Fix refcount leak for cifs_sb_tlink
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: Markus Elfring <Markus.Elfring@web.de>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, Bharath SM <bharathsm@microsoft.com>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Steve French <sfrench@samba.org>, Tom Talpey <tom@talpey.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I don't think the title needs to be changed, it seems clear enough.
The other changes are minor (changing goto label) and also probably
not needed but ok if you have to update it for other reasons.

On Wed, Oct 15, 2025 at 10:52=E2=80=AFAM Shuhao Fu <sfual@cse.ust.hk> wrote=
:
>
> On Wed, Oct 15, 2025 at 04:52:23PM +0200, Markus Elfring wrote:
> > > This patch fixes =E2=80=A6
> >
> > * Will another imperative wording approach become more helpful for an i=
mproved
> >   change description?
> >   https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
it.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ft=
ree%2FDocumentation%2Fprocess%2Fsubmitting-patches.rst%3Fh%3Dv6.17%23n94&da=
ta=3D05%7C02%7Csfual%40connect.ust.hk%7Caffcb410915f4b4bc8f308de0bfa853c%7C=
6c1d415239d044ca88d9b8d6ddca0708%7C1%7C0%7C638961367775911255%7CUnknown%7CT=
WFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFO=
IjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DbThHSbvjokcDU6hNpnYxt4%2B=
lVyzlyxHl1JopGmCLY%2FQ%3D&reserved=3D0
> >
> > * Would it be more helpful to use the label =E2=80=9Cput_tlink=E2=80=9D=
 instead of =E2=80=9Cout=E2=80=9D?
> >
> > * Can a subject like =E2=80=9Csmb: client: Complete reference counting =
in three functions=E2=80=9D
> >   be nicer?
> >
> >
> > Regards,
> > Markus
>
> Hi,
>
> Thanks for the suggestions. My apologies for the inapproriate wording.
> Here's my updates. Please do let me know if it still needs improvement.
> I will definitely address these issues in patch v2.
>
> 1. An improved patch description
>
> Fix three refcount inconsistency issues related to `cifs_sb_tlink`.
>
> Comments for `cifs_sb_tlink` state that `cifs_put_tlink()` needs to be
> called after successful calls to `cifs_sb_tlink`. Three callsites fail
> to update refcount accordingly, leading to possible resource leaks.
>
> Fixes: 8ceb98437946 ("CIFS: Move rename to ops struct")
> Fixes: 2f1afe25997f ("cifs: Use smb 2 - 3 and cifsacl mount options getac=
l functions")
> Fixes: 366ed846df60 ("cifs: Use smb 2 - 3 and cifsacl mount options setac=
l function")
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
>
> 2. New subject: [PATCH v2] smb: client: Complete reference counting in th=
ree functions
>
> 3. Labels are changed accordingly
>
> @@ -3212,8 +3212,7 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
>         utf16_path =3D cifs_convert_path_to_utf16(path, cifs_sb);
>         if (!utf16_path) {
>                 rc =3D -ENOMEM;
> -               free_xid(xid);
> -               return ERR_PTR(rc);
> +               goto put_tlink;
>         }
>
>         oparms =3D (struct cifs_open_parms) {
> @@ -3245,6 +3244,7 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
>                 SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fi=
d);
>         }
>
> +put_tlink:
>         cifs_put_tlink(tlink);
>         free_xid(xid);
>
> @@ -3285,8 +3285,7 @@ set_smb2_acl(struct smb_ntsd *pnntsd, __u32 acllen,
>         utf16_path =3D cifs_convert_path_to_utf16(path, cifs_sb);
>         if (!utf16_path) {
>                 rc =3D -ENOMEM;
> -               free_xid(xid);
> -               return rc;
> +               goto put_tlink;
>         }
>
>         oparms =3D (struct cifs_open_parms) {
> @@ -3307,6 +3306,7 @@ set_smb2_acl(struct smb_ntsd *pnntsd, __u32 acllen,
>                 SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fi=
d);
>         }
>
> +put_tlink:
>         cifs_put_tlink(tlink);
>         free_xid(xid);
>         return rc;
>
> Thanks,
> Shuhao



--=20
Thanks,

Steve

