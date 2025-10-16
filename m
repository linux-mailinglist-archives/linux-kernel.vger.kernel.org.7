Return-Path: <linux-kernel+bounces-856514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D378FBE45D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 630484E3798
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663AD34F475;
	Thu, 16 Oct 2025 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PHrTfU2C"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010D733EB02
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630038; cv=none; b=Q9hHuOs971BAMZ+MpK+lECu6Q+mMEeHV9st03ePoyDqCWIAvleCjrSg2iS+/6OXe+GUUyt1zosA4NOBD/9XbXEL7B09rcz+UwVgVAJDxkeuGO6yDX9gIYsGrK3cvrEHnZs9v6kqpu13nRKrhoekQhGHikEsTZMw4SU83a41voaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630038; c=relaxed/simple;
	bh=Go0MNDIavsjINpoT06GnTmz2rdEorOkOlbUztzacQjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KqUdj6Woa/W8/beIf2llyRMqarZwTc167N5/xLu9x6hTIDuu9i1VbqnncTZ9vb5JyOxLMGDzq8owl3aCnR2BK8/5akMz3AQE1nqw8BLNaQRF3nZcmjMkul126jdUN+g4jUePPuBpgq+4CJN7tyY7sb7hV48GN8gvapNLsBNRVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PHrTfU2C; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62faa04afd9so11741a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760630035; x=1761234835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2evuexxKw25LtXcesE7/iGA+MJZ+f8Dq3GZy6Z3Oglg=;
        b=PHrTfU2CG/eC855j7PFhsjYHMXFhu7moCfWkCr+/J1mbmXHcUfZ70U3YxiWXcZyQmr
         9yXI2qJbHxa7GqWcYEg/3t8SmyuP0VI2xNksHnTDliRgCdVV7Zgm0hTqvWKewXwx9Khm
         M0i8gfTUraa+mdlhrH5OC7bNnk4+zihJ32iGFxaey9H8axX7g+g10XUxKSXw1ebpLWqT
         h8EQfdslIUgDuMxDaxFOJEFaxE15MM4lk5KnA1nnYYvanKkHun3M9MmZTyfSUroTv5Q0
         QqFH8bM14dIa12FRnhyvYCDNKLQEgs4zROFWMznucMgfv8unfOI415b+dAVYssLAwEok
         t2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760630035; x=1761234835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2evuexxKw25LtXcesE7/iGA+MJZ+f8Dq3GZy6Z3Oglg=;
        b=jU560h8mS4+Gb5FEJ6j9HzQmS/vJ2j9PFFSruzMvAsEWDzSUSEwL6pIV7ML/G2w1X+
         mPIcypbKYwPbTXxr8++jcHxqQcxXWBWmhFa1XQjZLWpb5y6z272u4CHubLGLK6qDYlrg
         /JfYNiWlcRXLDVnPPhWdLb2LM1EiETFgaqS21fNlxCkBFIrF+NwayK05C/vMKqAQE663
         N9RaZtYGK4M3chIxXiUaLnn0BAqcxXNYbLm4pm3A154qwV5KrTnJRnzlR96nE1zxJw52
         mO2Bo6tCS3ZlsfTvHlGJBsVwyapMzwK9ISmZr8t3bqHopFR3s2D3qB6A6yAjONdxd+rJ
         hPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmtdtYwbWK9GfwKc2jpBpjaqn3XzL+7r8nQn9rUuICilLfYKTEQmpTVWzaKJ7+FnFNgtI5VyHs6gBi44w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyfj/HoNDdg2gozZfMogzgtuBczlu0HZY8mt9ptU8F8GZh55wz
	4aJlLbHo/jcQAnFFAMODp32rwAx0qaBEv1D85C5ru2dJpC5rXFiHguHHVrWKGiIIEKiPBtGJBkb
	8UwyirSlgMwpvSP/5f4UrU+ZYurtQDL4EJBQFA4Xd8ZJG4oSjjUKFGvOz
X-Gm-Gg: ASbGncsjVHs8Z9V555y30sxNtbbwDMnyle+qi+SpwdA1Sg+cXWZkAQ4j7jHT8HYi9gY
	JkKcD7RQXjeRuQPzb2pYcmmIVGX+guBdX9lttGU8l/OUibIu9dOSR0SQ7J2PEpZbk+E8QhGFLUj
	d3D7KF6G66E26z8ZBoU9yExqjMsY1dZhSltxg1yn5N0nhQ4CKkK9hJtvcx5DCr71H+3xK8bZT+a
	J0CWnfY6M0TY2TL4AQNiIuvODRqJE1bOI8BgjFwuGzMxRiq8Oe/YXYv+zaELJLmJW4KT6bAwm25
	G7hP2PSupzMqyTA=
X-Google-Smtp-Source: AGHT+IEaURDwO36zJ9ZAjPzX6vspjnrbQ8+1gdePow1SHb0Bsir7kBqLrBvlJHDfnx7sZwxVY9S6IenpSusczCqN5wI=
X-Received: by 2002:a05:6402:2346:b0:634:909c:d3c with SMTP id
 4fb4d7f45d1cf-63bebf9d4c8mr292671a12.2.1760630035029; Thu, 16 Oct 2025
 08:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
 <ef7c07585e41c8afbb2b97df98fd47c9374b15cb.camel@linux.ibm.com>
 <CAG48ez1jqa2y=aTJ=C+s9v0_xhWra7gezdY+BO=Red-XVGNQJQ@mail.gmail.com> <73d071ece8b1773740d494868f552abdd99decc6.camel@linux.ibm.com>
In-Reply-To: <73d071ece8b1773740d494868f552abdd99decc6.camel@linux.ibm.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 16 Oct 2025 17:53:17 +0200
X-Gm-Features: AS18NWAl36TmonZE4Tq_j7rbgF1yH0UJgkJ0unTwaL53hFz4Z23PSJGH9lVf4ig
Message-ID: <CAG48ez2dT+TCoUvx8QOTJKvHY5cxW3sT1H0W1CwPf6Fxd0E-5w@mail.gmail.com>
Subject: Re: [PATCH 0/2] ima: add dont_audit and fs_subtype to policy language
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Frank Dinoff <fdinoff@google.com>, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 5:52=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2025-09-30 at 16:26 +0200, Jann Horn wrote:
> > On Tue, Sep 30, 2025 at 12:23=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > > On Fri, 2025-09-26 at 01:45 +0200, Jann Horn wrote:
> > > > This series adds a "dont_audit" action that cancels out following
> > > > "audit" actions (as we already have for other action types), and al=
so
> > > > adds an "fs_subtype" that can be used to distinguish between FUSE
> > > > filesystems.
> > > >
> > > > With these two patches applied, as a toy example, you can use the
> > > > following policy:
> > > > ```
> > > > dont_audit fsname=3Dfuse fs_subtype=3Dsshfs
> > > > audit func=3DBPRM_CHECK fsname=3Dfuse
> > > > ```
> > > >
> > > > I have tested that with this policy, executing a binary from a
> > > > "fuse-zip" FUSE filesystem results in an audit log entry:
> > > > ```
> > > > type=3DINTEGRITY_RULE msg=3Daudit([...]): file=3D"/home/user/ima/zi=
pmount/usr/bin/echo" hash=3D"sha256:1d82e8[...]
> > > > ```
> > > > while executing a binary from an "sshfs" FUSE filesystem does not
> > > > generate any audit log entries.
> > > >
> > > > Signed-off-by: Jann Horn <jannh@google.com>
> > >
> > >
> > > Thanks, Jann.  The patches look fine.  Assuming the "toy" test progra=
m creates
> > > and mounts the fuse filesystems, not just loads the IMA policy rules,=
 could you
> > > share it?
> >
> > Thanks for the quick review! To clarify, by "toy example" I meant that
> > while I was using real FUSE filesystems, the policy I was using is not
> > very sensible.
> >
> > I used real FUSE filesystems for this since I figured that would be
> > the easiest way to test, https://github.com/libfuse/sshfs and
> > https://bitbucket.org/agalanin/fuse-zip. These are packaged in distros
> > like Debian (as "sshfs" and "fuse-zip"). I mounted sshfs with these
> > commands (mounting the home directory over ssh at ~/mnt/ssh):
> >
> > user@vm:~$ cp /usr/bin/echo ~/ima/
> > user@vm:~$ sshfs localhost: ~/mnt/ssh
> >
> > and mounted fuse-zip with:
> >
> > user@vm:~/ima$ zip -rD echo.zip /usr/bin/echo
> >   adding: usr/bin/echo (deflated 62%)
> > user@vm:~/ima$ mkdir zipmount
> > user@vm:~/ima$ fuse-zip echo.zip zipmount/
> >
> > I then ran the executables ~/ima/zipmount/usr/bin/echo and ~/mnt/ssh/im=
a/echo.
>
> Thank you for the instructions.  Due to the holidays, there was a delay. =
The
> patches are now queued in next-integrity for 6.19.

Thanks a lot!

