Return-Path: <linux-kernel+bounces-837781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB003BAD2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A33A1925AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781BA2F8BF1;
	Tue, 30 Sep 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDFLEkY4"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24217282E1
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242429; cv=none; b=OVSmzKYo4ifexs0z5XnwY7JDb/cfgeln1OuKQBqeJOnOC8uqQLPUJkckh/vmQBHmK/38pQj+Oy8Sh6mMNhdo0doAxaU1a5BoJHgdlel00aryXZEIS/4V+jlDhoMLi4c/tXizYJdOnKDad10xAzTEtgUGMTJ3nRMsnawym+0CGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242429; c=relaxed/simple;
	bh=x43Aiv7rPX2GEQZu5NfhE12xepCVe53wujMWizCXNyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4cTCCqwnFTjsj6w+wWx6FNpADn/uTUqZW09V9XSxqwsqeMtsztPtghTQ1YULygw8JAq7onWZ/mjCKu3idNFWmnNB5vxjVjW3+7zTO2nCUScuz5AeJp9r2MNkjVtC5taPOQsBhg3p4u53+YCBSDVLYWFpcftKOhqLVLNEhn0ayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDFLEkY4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-634cc96ccaeso9155a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759242426; x=1759847226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SZy9N2kUaCjLFUFTo+cbervBp1DnEnunIQqdJHxh2kY=;
        b=NDFLEkY4z8JrkEuw8KaheOIS8UYL91tMpbVbg9ClcPpU7uZhBUmAIE49cJmiyhvP5y
         mcYSkwJlernQGdBlCr3Uwi86UpJdLbsxHl39ovGqXG/FnIVe5chA749syVD9uxMIFOE9
         XJ/dC95AqYC2X9o6dMZorwbWQpEn7uxyKQzX3fU7kJ7UfHgjwna3xaiHvg6qg0E0v2CT
         S3gbBVTP4ecWcccIdn7QEg8NS7uuVKRRaUVq0hSI3GvpGHRHQ27TY3cHYvrIw7F+/ZqG
         uLTqt1TxwG6+TjD1FzREY7mBQse8XRae/nj1SLFEsxI0vrhYkyZzike3fOBAqYhlVQLU
         Qj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242426; x=1759847226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZy9N2kUaCjLFUFTo+cbervBp1DnEnunIQqdJHxh2kY=;
        b=N35TB6Jr4kj6BHLeivMTZL1agsVEGDzaZVMcBQmOavAkU85ygZQkqq59UO3qcT9EdF
         ek99wZQEcecXO3mOVliOBnZQjSduBZUf2mucCDBL5hC+c0PlaGGFs0uu8TIDF/SoKKpb
         Ma4QDortcmD+a8v+ZFNHVokt2fhxSRxNMHVP6VT/DrCdWSNhR8bqwrdplGsETV5o6RYl
         VCiNgeQf8iTOpYfKHk+2LfMiDTtptCEQloCgvnw6VGP1UCL9Y0PgSgweT08VhOpeb2dV
         iMEx1c6cTv3sjiii1EmnTtsXy4Smk9Q41+gXaa4gMG50iqnOqBfVGOrUlx1U+GDUB24n
         7bag==
X-Forwarded-Encrypted: i=1; AJvYcCUcLvKa+c+f5kvTUBbBF8A2i15PMb8mObtCmV/yjvl0BetgmHVzh/SKXU3SNOnzdrrm0ZNs/ZRL3wHG3CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyePl18ATdF5Eme8EGLf1PJHf+0NiVWtB/bEKb2OXahaNzzQmS7
	p930skG3d8P2wbbE7GNhOgwkbCEpugAhwzseyiUOztzlHkM2Ub6hb5s78sgC4SGxf9xSVZ7Msv8
	JjxH0FO9IbuyCpVLwCCxoDEmwMyf+ZN98gpVl1vun
X-Gm-Gg: ASbGncuX9jF3BF+V9Njz2t7wg7NCajAMtNMeqHdII6GCnw1jDzus/LGhjHLm5KHvWIv
	TsSkRKlWp2J9YbO7Cr4T+yLsQq+eUzITup+hI8p909RHvj0bO3tziBOY4CMTA6e1nbFliOHD5J0
	HlOHplIhkhXgOK4yLNF62C3M6qkpZANz2lLEPQeqWdLLXVedf+PXVOKH2VY4KIUzJWPp0UQt7j6
	rjoVjV+DjK7Rsh3TiFs58izBVhnFiKs1/ZcMW16UmhsT0j083if2l1fs1hPAkFEm2VuwRXp2Oub
	f85+hM7QCPLa
X-Google-Smtp-Source: AGHT+IFvLNEtH2e5/dO5x9kwTjOA1XboZaWBElllxhFQnYr0glf12eW6jY3ATCxllGYkUI6x229ESRphuK+7A9uRrb4=
X-Received: by 2002:a50:9ee6:0:b0:624:45d0:4b33 with SMTP id
 4fb4d7f45d1cf-6366271cc53mr92789a12.7.1759242426105; Tue, 30 Sep 2025
 07:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com> <ef7c07585e41c8afbb2b97df98fd47c9374b15cb.camel@linux.ibm.com>
In-Reply-To: <ef7c07585e41c8afbb2b97df98fd47c9374b15cb.camel@linux.ibm.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 30 Sep 2025 16:26:28 +0200
X-Gm-Features: AS18NWBrH6EzLSqnkNtObif1pJ0uyYEfSCvr2raYhHSw1EgoC2pdUUiHvV6uX9s
Message-ID: <CAG48ez1jqa2y=aTJ=C+s9v0_xhWra7gezdY+BO=Red-XVGNQJQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ima: add dont_audit and fs_subtype to policy language
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Frank Dinoff <fdinoff@google.com>, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 12:23=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> On Fri, 2025-09-26 at 01:45 +0200, Jann Horn wrote:
> > This series adds a "dont_audit" action that cancels out following
> > "audit" actions (as we already have for other action types), and also
> > adds an "fs_subtype" that can be used to distinguish between FUSE
> > filesystems.
> >
> > With these two patches applied, as a toy example, you can use the
> > following policy:
> > ```
> > dont_audit fsname=3Dfuse fs_subtype=3Dsshfs
> > audit func=3DBPRM_CHECK fsname=3Dfuse
> > ```
> >
> > I have tested that with this policy, executing a binary from a
> > "fuse-zip" FUSE filesystem results in an audit log entry:
> > ```
> > type=3DINTEGRITY_RULE msg=3Daudit([...]): file=3D"/home/user/ima/zipmou=
nt/usr/bin/echo" hash=3D"sha256:1d82e8[...]
> > ```
> > while executing a binary from an "sshfs" FUSE filesystem does not
> > generate any audit log entries.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
>
>
> Thanks, Jann.  The patches look fine.  Assuming the "toy" test program cr=
eates
> and mounts the fuse filesystems, not just loads the IMA policy rules, cou=
ld you
> share it?

Thanks for the quick review! To clarify, by "toy example" I meant that
while I was using real FUSE filesystems, the policy I was using is not
very sensible.

I used real FUSE filesystems for this since I figured that would be
the easiest way to test, https://github.com/libfuse/sshfs and
https://bitbucket.org/agalanin/fuse-zip. These are packaged in distros
like Debian (as "sshfs" and "fuse-zip"). I mounted sshfs with these
commands (mounting the home directory over ssh at ~/mnt/ssh):

user@vm:~$ cp /usr/bin/echo ~/ima/
user@vm:~$ sshfs localhost: ~/mnt/ssh

and mounted fuse-zip with:

user@vm:~/ima$ zip -rD echo.zip /usr/bin/echo
  adding: usr/bin/echo (deflated 62%)
user@vm:~/ima$ mkdir zipmount
user@vm:~/ima$ fuse-zip echo.zip zipmount/

I then ran the executables ~/ima/zipmount/usr/bin/echo and ~/mnt/ssh/ima/ec=
ho.

