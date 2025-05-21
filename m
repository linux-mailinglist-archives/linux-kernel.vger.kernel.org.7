Return-Path: <linux-kernel+bounces-657870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DE9ABFA00
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 17:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5F468C475A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 May 2025 15:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A8B22173F;
	Wed, 21 May 2025 15:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NvyqMsT+"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B094921FF29
	for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841819; cv=none; b=C/byNVbIDPM5WPlVWgGmFmczcmoMPYDJ/XhKFdgJsjVYMaQvQM7E7NCBnWsDQB9mmosBoMc7v7UdoccbPHOLBOijG2qGIB+ul75hZYyYfcJExUkB9EvaOa8+J+kh6B3PG/7mXww8lWX4Ka4M4wW62D/3GDaXSAcnTcNyfUJcTZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841819; c=relaxed/simple;
	bh=SM7KrvI7eLMIkyAD0UVXhjfdPdQtn+P+cabacZ6LcTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzuNcdkXIQqEyTNVwhn+Mrr1I3rmsiJ2hztzbBzZk8Tr3/XOgD8CqSAkLLdWmZmN7jNRqx6M8KWiXUXVBk/dq/OUtPGkv9SlH60I94Fr+Zeh3T40MpD7Wd4F3V3ksbkrzMB+wQG4k3uxwR6qp3MEKajYni1yj+ffbhpU0HLvRs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NvyqMsT+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6000791e832so38336a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 May 2025 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747841816; x=1748446616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfZmxGM2+EUbxWogJjiQEh6M304h/CsnIOCgDa2Sp+E=;
        b=NvyqMsT+Kr7clFVllOptZ80AyebxS1wxDV4PBIxibj4f9gTkkXVRjwfmII68bTd56+
         j003zIgZtlVHeJ96AwM4hXSPeTxu6atwuYyGLlalEC1arcAGMbT+XcPEzK7kfICvgcnP
         eHKe/EJDhwg1iZ0aMgvXQVqdo0EguEvgFTXve0EVsAE81AChDrPlHwqQFk96JAiC9rhH
         sz1n3OrATV21/9/8/talDuLAciozam75U98xafSiDRzwI8/z999/Lod/E76fkn3uFHVY
         WHNRlsRtcruaDjZLpl3dacTwjf4b3pr3maUItyXnbvfNI3dvULxVK9QzLchBmaErdbIV
         /xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747841816; x=1748446616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfZmxGM2+EUbxWogJjiQEh6M304h/CsnIOCgDa2Sp+E=;
        b=BsVvY6kFfWQAzwdRo3mMzX7IAXI5Jitkz5KGQ1oM/gMMcXGMth6gir8nt9B65eBJKc
         EKyWLBQqiqhQ9wBMovT680XbX2Mk1Ql5sCtIMlypmenam0q6AcBKYEigRQo2WCC29oJ2
         /x26tPb0GC0sOLLf0n7l3VPlyiChVaJduwO3ykvtrDFsrg9AcmZmj5rZwYiS4RU20PUd
         U0NevmLgHWUlTiWFUgoAyNe66vTgbna70ADOers/I9R/EOKmU9VVD5vaAhK2Op/GAH15
         LxQjeTMD5LMK7M5HCT7ZEDQN1bLXunnUILMLZVRc3OPd1Bd9Dyu24PkbmfTd03Tr+jJd
         BBEg==
X-Forwarded-Encrypted: i=1; AJvYcCU2XEFQvJcT5p7+Iafgp9+TMJ6q2poQEkJgnVFu1egVhSfZz3hyi9iRBA7HEErv7NMmamrz8N6pEXGf+jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBiziUI60TU2Kwz3mYeJtOIbZjMmXXYBo34n+yVJWRplCcvrDn
	VzNYjLgLPur8O7uHk6R7TPmbnT3Q8jg06TqoirbTklWmgzZE+gJjvA1j8dryjjHBlmmhzZocEK3
	+GnZjN/N7jv/hDB+vQqK/8bKTqY6j3bG/+ZcChmu/
X-Gm-Gg: ASbGncsk2rZqd4F0ixOwUFfSXdyLoVoPnG9lrfYpt/RFJHaJRjKHSPYNLDL8Z60ApSt
	I6YGCPCxyHIjvzAF2yyQiLAi5cbeUD9E9TLmiiCOKfClvVdD6wXhre4uZfGREgipMwNyugDpmh5
	aj32ruhAPNpRVKQHwMDMRmaALYk1AC3vOTMl452UqfyC5qP8hVN6E3yCECqcoxdbWZyHkUc+ozw
	luWjK86F34=
X-Google-Smtp-Source: AGHT+IH0PCZmu9XxCrE1x8a3M5h757rXSLLQQPqZgeIp1ENluSUZFfqmgEsSp7VlY8zsloCLnP6yToP6FboR1V/iGI4=
X-Received: by 2002:a05:6402:f85:b0:5fd:28:c3f6 with SMTP id
 4fb4d7f45d1cf-6019c8884b4mr462918a12.4.1747841815673; Wed, 21 May 2025
 08:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org> <202505151451.638C22B@keescook>
 <87ecwopofp.fsf@email.froward.int.ebiederm.org> <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
 <87wmagnnhq.fsf@email.froward.int.ebiederm.org> <202505201319.D57FDCB2A@keescook>
 <87frgznd74.fsf_-_@email.froward.int.ebiederm.org> <CAG48ez0N_1CEKyMHdjnvwsxUkCenmzsLe7dkUL=a6OmU4tPa6Q@mail.gmail.com>
 <87zff6gf17.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87zff6gf17.fsf@email.froward.int.ebiederm.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 21 May 2025 17:36:18 +0200
X-Gm-Features: AX0GCFuH7zkVGqrB7QBSXnPK059YsKAZdSIDiUFJ2RJe1PMCQ4EwP8ivhAY7NrM
Message-ID: <CAG48ez1z97sCsx53W0O_dCCJL6tnf2pWuv=qaeszcYBfz_01sA@mail.gmail.com>
Subject: Re: [PATCH v2] exec: Correct the permission check for unsafe exec
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Richard Guy Briggs <rgb@redhat.com>, "Serge E. Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>, 
	Max Kellermann <max.kellermann@ionos.com>, paul@paul-moore.com, jmorris@namei.org, 
	Andy Lutomirski <luto@kernel.org>, morgan@kernel.org, 
	Christian Brauner <christian@brauner.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 5:27=E2=80=AFPM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
> Jann Horn <jannh@google.com> writes:
>
> > On Wed, May 21, 2025 at 12:13=E2=80=AFAM Eric W. Biederman
> > <ebiederm@xmission.com> wrote:
>
> > Looks good to me overall, thanks for figuring out the history of this
> > not-particularly-easy-to-understand code and figuring out the right
> > fix.
> >
> > Reviewed-by: Jann Horn <jannh@google.com>
> >
> >> @@ -917,7 +911,7 @@ int cap_bprm_creds_from_file(struct linux_binprm *=
bprm, const struct file *file)
> >>         /* Process setpcap binaries and capabilities for uid 0 */
> >>         const struct cred *old =3D current_cred();
> >>         struct cred *new =3D bprm->cred;
> >> -       bool effective =3D false, has_fcap =3D false, is_setid;
> >> +       bool effective =3D false, has_fcap =3D false, id_changed;
> >>         int ret;
> >>         kuid_t root_uid;
> >>
> >> @@ -941,9 +935,9 @@ int cap_bprm_creds_from_file(struct linux_binprm *=
bprm, const struct file *file)
> >>          *
> >>          * In addition, if NO_NEW_PRIVS, then ensure we get no new pri=
vs.
> >>          */
> >> -       is_setid =3D __is_setuid(new, old) || __is_setgid(new, old);
> >> +       id_changed =3D !uid_eq(new->euid, old->euid) || !in_group_p(ne=
w->egid);
> >
> > Hm, so when we change from one EGID to another EGID which was already
> > in our groups list, we don't treat it as a privileged exec? Which is
> > okay because, while an unprivileged user would not just be allowed to
> > change their EGID to a GID from their groups list themselves through
> > __sys_setregid(), they would be allowed to create a new setgid binary
> > owned by a group from their groups list and then execute that?
> >
> > That's fine with me, though it seems a little weird to me. setgid exec
> > is changing our creds and yet we're not treating it as a "real" setgid
> > execution because the execution is only granting privileges that
> > userspace could have gotten anyway.
>
> More than could have gotten.  From permission checking point of view
> permission that the application already had.  In general group based
> permission checks just check in_group_p, which looks at cred->fsgid and
> the group.
>
> The logic is since the effective permissions of the running executable
> have not changed, there is nothing to special case.
>
> Arguably a setgid exec can drop what was egid, and if people have
> configured their permissions to deny people access based upon a group
> they are in that could change the result of the permission checks.  If
> changing egid winds up dropping a group from the list of the process's
> groups, the process could also have dropped that group with setresgid.
> So I don't think we need to be concerned about the combination of
> dropping egid and brpm->unsafe.
>
> If anyone sees a hole in that logic I am happy to change the check
> to !gid_eq(new->egid, old->egid), but I just can't see a way changing
> egid/fsgid to a group the process already has is a problem.

I'm fine with leaving your patch as-is.

