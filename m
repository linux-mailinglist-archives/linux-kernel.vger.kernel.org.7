Return-Path: <linux-kernel+bounces-881448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B7C283A6
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 18:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5CE1A2222A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 17:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9F91DFE26;
	Sat,  1 Nov 2025 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VKSAlrvI"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206A519309C
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 17:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762016448; cv=none; b=Z1hZ+8mBxD6jr05tpmjFAoi0TpIqH6n+RLr6Xi8UiMREug2bOydYmMHSdu9N4zCLF6v7oARMGC3MAsit9Ah+s86Wem493TMzc/If47fK/n+E/Wb1aW1mj4Iv5eEocwoqaDdrGvGMUP+iYLiQit+I/8AwTtCr/a/kSIOjVlx3eAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762016448; c=relaxed/simple;
	bh=ZVKAtJQ7YxW2ydkUhmrqBw8xd9VSlPorpAYP+7y4b9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4PZ2gLkMBv2dh3WzWCobkPX9mIMzdMh+LPZLN7lOKLB3jX7fLL9HzLD4xKEeK+BXCp7Bf/0ReA6ZXEvnfK6Jaqc5kkI0AJU/ZK8C2VNUh4VtLrcFW7vXkoKLqWO0tjt93d0Fq1VT5EFaXMtDgUZ3mfuDQLEPuRkZ0snQLtSuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VKSAlrvI; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so2930571a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 10:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1762016446; x=1762621246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bQwNAi66Xq10BeoG6s8poTPGkQCGKxfLLVH03d/lh0=;
        b=VKSAlrvI6QIfiVCdoTdXr/VAuXZXB9Y4BgSD2dQXTtm7hT1GdYR/qiWdpv9oo4kx1d
         TMzr8dnsGUZtf+DEYynrVkmIbsWxFu6rbMtZ2SLIWqHwQW1x8bidOIVPOnQd21q8vRxJ
         +IJEDuV5Xt+ubp9yEWVH6TdmAoHwS5AkdTujd7A/NyvLT1ED6ydIcd2GrS9s44y9Az7m
         5e4elTAX5TjJga0YjxFRKJ15Plr6p7MxvYzEzWk/+BkHJoWxabz/YbmEfoFDtp8bmk7M
         OQ0K/htqI3qz6yaSYLNOmXmMROAvoOUHb6yW6WsXb39SXRw9mRjasznnaOMcO2tS1pZx
         a8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762016446; x=1762621246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bQwNAi66Xq10BeoG6s8poTPGkQCGKxfLLVH03d/lh0=;
        b=w+QCZUxxEomYRNTWdU0w/8eUB+NOpx3YDA8nyMyWATFUeeaclZ+ytjGksIKsXq7DaR
         2fRlbRz3O1jaa4VRVLkeBATBi/8Kn1/dOVit4DpIAjyGnxpIcbtj4vdVS+qSskr5+2Uo
         vgQZQeK8ZP/isOQ0w3X0INZGvgaqJ2Z1LWgVsEdrOEyWxgdqu34bmV7VGLChvepnU3MN
         6+Wx9wPRDJNsYaBfmfyNEinCB3FT3talpla0LT8JIyc0yyTgvcNwrMlgnzo1JcqSttVX
         j2vbBAZ5LJJ5sfvDn5XNZkRgQP/owXKxBHYPQDoXIMhZScNM1Dim4Dytya/vEHspJJBV
         rfYg==
X-Forwarded-Encrypted: i=1; AJvYcCVMM7tA74v91YynaCv8tVGOdnNgTKNQmZ2TPTJ5ddhYcaoejS9A+//mN211mNuSHhaMWZ8jYoobBR5oQIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBec/o83A/8gtsyRIse5dbkwwwP490QouRNJtR03uMgsdhIVsQ
	qGhk7dmmPfSpsTxQ7EuciF9Du8EdnGOHcKmSs8kfPB5grYtGlgVdzDGL1XpdyCo/JL2+eM5Xhx5
	P4oZ1K+6PK8AEo9t31C1u0lz/4cNsg4TkRNlTlgiK
X-Gm-Gg: ASbGncv0dd3r5Rww8eKfjKHjMP2xYGbtyd0o5qabn7u3pWFu8hW0Y5k5+UT5lFL/u2I
	MPtmuvaTF22G2JxZvlFSwdcR3AC9r6r+B5jRsE2ndLOY1zhhgAB7a7Zl6Q4uYkawpIOkfhC2Rkh
	wLrx8xRJsY2QTixonB2XQPNdfRJhfT8ejz0PO8IWeYTKU9vfxOCi4ldUI8wRy27IPecfa6oQpq/
	VTKcdC3DnDlYhgSNhtWGAuBm77YT4/IElPJ668sBUZIi2Kq50xsH6zn9FjlnH/uqCLqUqI=
X-Google-Smtp-Source: AGHT+IEGxfHBAfIq6y58pVGnMEg/azCvX8aaX6JSItHLFd5Voo6bXcarfvoQmwX9lQYzeehfVz2aLCPmZPU47JHX8+U=
X-Received: by 2002:a17:903:94e:b0:28b:4ca5:d522 with SMTP id
 d9443c01a7336-2951a496d09mr102011965ad.39.1762016445731; Sat, 01 Nov 2025
 10:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031110647.102728-2-thorsten.blum@linux.dev>
 <20251031125916.3b0c8b22@pumpkin> <FE3AAB5A-9AB9-49B6-BB67-FCB97CD5AF29@linux.dev>
 <20251031165417.4490941a@pumpkin>
In-Reply-To: <20251031165417.4490941a@pumpkin>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 1 Nov 2025 13:00:34 -0400
X-Gm-Features: AWmQ_blUrxe9-_hCXsnuI7mX--XQCm306FtUwVkeT5LISw4c3OmPPoz0yMf9Sxs
Message-ID: <CAHC9VhQ3nhAjupyENXnZN0WXsbibjeA6OT6fCXOfXBjWaw0=6A@mail.gmail.com>
Subject: Re: [PATCH] device_cgroup: Replace strcpy/sprintf in set_majmin
To: David Laight <david.laight.linux@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 12:54=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
> On Fri, 31 Oct 2025 16:23:02 +0100
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> > On 31. Oct 2025, at 13:59, David Laight wrote:
> > > Even if ex->major can be ~0 there are much cleaner ways of writing th=
is code.
> >
> > Thanks for pointing this out. Looking at the bigger picture makes it
> > clear that most of the code can actually be removed. What do you think
> > of this change?
>
> That is sort of what I was thinking about, but it doesn't quite work.
>
> >
> > Thanks,
> > Thorsten
> >
> > diff --git a/security/device_cgroup.c b/security/device_cgroup.c
> > index a41f558f6fdd..cb845b1fad6b 100644
> > --- a/security/device_cgroup.c
> > +++ b/security/device_cgroup.c
> > @@ -244,7 +244,6 @@ static void devcgroup_css_free(struct cgroup_subsys=
_state *css)
> > #define DEVCG_DENY 2
> > #define DEVCG_LIST 3
> >
> > -#define MAJMINLEN 13
> > #define ACCLEN 4
> >
> > static void set_access(char *acc, short access)
> > @@ -270,19 +269,11 @@ static char type_to_char(short type)
> >       return 'X';
> > }
> >
> > -static void set_majmin(char *str, unsigned m)
> > -{
> > -     if (m =3D=3D ~0)
> > -             strscpy(str, "*", MAJMINLEN);
> > -     else
> > -             snprintf(str, MAJMINLEN, "%u", m);
> > -}
> > -
> > static int devcgroup_seq_show(struct seq_file *m, void *v)
> > {
> >       struct dev_cgroup *devcgroup =3D css_to_devcgroup(seq_css(m));
> >       struct dev_exception_item *ex;
> > -     char maj[MAJMINLEN], min[MAJMINLEN], acc[ACCLEN];
> > +     char acc[ACCLEN];
> >
> >       rcu_read_lock();
> >       /*
> > @@ -293,17 +284,12 @@ static int devcgroup_seq_show(struct seq_file *m,=
 void *v)
> >        */
> >       if (devcgroup->behavior =3D=3D DEVCG_DEFAULT_ALLOW) {
> >               set_access(acc, DEVCG_ACC_MASK);
> > -             set_majmin(maj, ~0);
> > -             set_majmin(min, ~0);
> > -             seq_printf(m, "%c %s:%s %s\n", type_to_char(DEVCG_DEV_ALL=
),
> > -                        maj, min, acc);
> > +             seq_printf(m, "%c *:* %s\n", type_to_char(DEVCG_DEV_ALL),=
 acc);
>
> type_to_char(DEVCG_DEV_ALL) is 'a' and this is the only place it happens,
> also acc is "rwm".
> So that could be:
>                 seq_puts(m, "a *:* rwm\n");
>
> >       } else {
> >               list_for_each_entry_rcu(ex, &devcgroup->exceptions, list)=
 {
> >                       set_access(acc, ex->access);
> > -                     set_majmin(maj, ex->major);
> > -                     set_majmin(min, ex->minor);
> > -                     seq_printf(m, "%c %s:%s %s\n", type_to_char(ex->t=
ype),
> > -                                maj, min, acc);
> > +                     seq_printf(m, "%c %u:%u %s\n", type_to_char(ex->t=
ype),
> > +                                ex->major, ex->minor, acc);
>
> It looks like both ex->major and ex->minor can be ~0.
> (I'm not sure it makes any sense to have major =3D=3D ~0 and minor !=3D ~=
0).
> However this should be ok:
>                         seq_putc(m, type_to_char(ex->type);
>                         if (ex->major =3D=3D ~0)
>                                 seq_puts(m, " *:");
>                         else
>                                 seq_printf(m, " %u:", ex->major);
>                         if (ex->minor =3D=3D ~0)
>                                 seq_puts(m, "* ");
>                         else
>                                 seq_printf(m, "%u ", ex->minor);
>                         if (ex->access & DEVCG_ACC_READ)
>                                 seq_putc(m, 'r');
>                         if (ex->access & DEVCG_ACC_WRITE)
>                                 seq_putc(m, 'w');
>                         if (ex->access & DEV_ACC_MKNOD)
>                                 seq_putc(m. 'm');
>                         seq_putc(m, '\n');
>
> A less intrusive change would be to pass 'm' the the set_xxx() functions
> and add the separators between the calls.

Yes, just pass the seq_file pointer up to set_majmin() and have it do
the writes/puts directly.  Might as well rename if from set_majmin()
to put_majmin() while you are at it.

--=20
paul-moore.com

