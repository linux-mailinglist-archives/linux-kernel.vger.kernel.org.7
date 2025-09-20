Return-Path: <linux-kernel+bounces-825849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C818AB8CF15
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5553A561663
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9630313D64;
	Sat, 20 Sep 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xtn78Rp8"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409E41D416E
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 18:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758394746; cv=none; b=Qykr4FNqajYVisbpgVeSY9X2vpw6exbyTxs7r3FkpEOTwdsZBjXLSzuHMvNae/+1B1MY2RFTa5TTAZiLsIw7TbRKBINAWxOkgcx0gT+0DNb18GIYs9nDLs0braB7xtcEbGvS7hWpqsIiUq18UB5wU6ZZHVyTptl1fWTbpY9dsNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758394746; c=relaxed/simple;
	bh=kJKPqb5ITXNFMsS2LLt9HdEV0P6O3eXRMkxx5fWkKdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=slMs5gnrpnh9cDAY/8ROeYGfKDMD1aLfDHt9nw7j+ddLiSnamYJJy9CG00r+NZXWDEYvWt3Hw5CbZvmbbUbTFoWBpTKhK8j17g55eOywWo2nVQRPRDqj0+2sdwHEArY8Racg4IB5Jy0lUpiZV7xcYuOnhpNvF4KgsbCOnC0GuOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Xtn78Rp8; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-43b4a0aae1fso48373b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758394743; x=1758999543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6m2W5nx71xMSXVxU+RpAhVoe4BosDpZBLlHtgjTWO5c=;
        b=Xtn78Rp8rq+zMthPi/pRMYb1l3VTbMBqsUE5uGLQEbrRP2WzhIKDfRnvL9VwMrMfOM
         V7XTAMG3xBD21ymwobDlDV0j60OKgyxZ5dVo+aVXuFa2BsJpTdEo8VX8r9UI5+KJ3OYQ
         5NXjietMB7GpEaVwpvAFTPfVh6Z3gC+v/HioE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758394743; x=1758999543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6m2W5nx71xMSXVxU+RpAhVoe4BosDpZBLlHtgjTWO5c=;
        b=RxZn2TU2ivJ0xpZk9Rp8o8FjNxSI8fp8UsFmMW4x968Jk96Hc/IYW/0dtxJz6IpwOW
         WYnylGDogTseNIWZmd6CQhxvKNiKm848S2gl8cHr8whjJtNluDX+FE2FtKvAZXKoOtba
         G6hA7y9D03/IWVY6IfqL+Jj4ylQDWVoc18334PsU/RVcZk1DApmtKaI0XFt23Vrl7EMC
         IW23tZ9xXjA7xEcMEzEnZTs22BFyOlx6df+6eXwWWMx4jnC8NuZk71noVRpoFFzRzrdw
         yeVH+14kl4AwpGTwO/RYlU4ISHJXo07MHXvQPKTQcMENvBwStteuZZJ0D2PUILLOFiwp
         mMLg==
X-Forwarded-Encrypted: i=1; AJvYcCXxxewT7sigOgIt7oDPXqMc2iahBY03KWwgOUPKC8iGl9L/9RVZuVvwtECRts63K9uSDahC2NAAUjyuOHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRzMpb2PlNCefFkWY0auib/SB5pD+96QWj0Q4OMojx0SW+m0s
	Z3nOJsNX3M9IchTcm1CUbwkx6Vo24ocXTYamtSozOC7ytqyPFao3kP25Qg00rsjVgfFKMDEwgPo
	c1gXZMaToy93Rwaduq81Yy1L9In/d5wg6jK3Q1kJXvvlU83/tf/M=
X-Gm-Gg: ASbGnctoIxlQ9/ir0qGl/d9F2ymD2ViHuqJHjaCm97DEvuEwMJKv+HY+vMDxId0gYlQ
	SSYXMHyR9McZgrL35Ez2ogkvOzQKdoSwoQaWPxx/2AzyQ+h1KT63zy3m5H29Mmh+mI3SPOFOJxm
	gz2ISRuE36LWSL9KBH3as4hqGL9xAqn85m5FeD6bWhn+CkkH2xg/EfhXzL3akLq2rHhGiLRcApM
	HHRXRULEkUCxjqWI6LjJ+pDRnMWbL3dPmHhjSuB
X-Google-Smtp-Source: AGHT+IEbtUOHoGxmH8+U+ohTvlhZagORiUWDUjw1ZNRWRQtq3uyJEEBBW+146XDI0TEaj7CC0DarjKctgvx9c6CKZAI=
X-Received: by 2002:a05:6808:4f6c:b0:437:b03d:9028 with SMTP id
 5614622812f47-43d6c2d5ea0mr1674830b6e.8.1758394743248; Sat, 20 Sep 2025
 11:59:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221209160453.3246150-1-jeffxu@google.com> <20221209160453.3246150-7-jeffxu@google.com>
 <CAHC9VhRBMTQvnBdSwMbkOsk9eemYfvCmj9TRgxtMeuex4KLCPA@mail.gmail.com>
 <CALmYWFvrasXnshO01YGWRyC7qKk4o0G88yAgkgjO1YBumF5zeA@mail.gmail.com>
 <CAHC9VhQKsjiGv3Af0iqg_TLNzCvdTaLnhw+BRTF9OEtJg1hX7g@mail.gmail.com> <87o6r5ac2z.fsf@gmail.com>
In-Reply-To: <87o6r5ac2z.fsf@gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Sat, 20 Sep 2025 11:58:51 -0700
X-Gm-Features: AS18NWAgq3wn2Sk2LOUvEfd7d6hzlOiiolow2BKEmFkCuGifdHV5pRX8Z7-PEW0
Message-ID: <CABi2SkUj2WoNpm6repAr0rkmQgFAmfRTYD0k=KcPUXjOd3tvhw@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] mm/memfd: security hook for memfd_create
To: Abhinav Saxena <xandfury@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, Jeff Xu <jeffxu@google.com>, skhan@linuxfoundation.org, 
	keescook@chromium.org, akpm@linux-foundation.org, dmitry.torokhov@gmail.com, 
	dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, jannh@google.com, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Fan Wu <wufan@kernel.org>, 
	Kees Cook <kees@kernel.org>, "tweek@google.com" <tweek@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Abhinav

Thanks for reaching out, it is great that you are interested in
Landlock and IPE use cases for executable memfd.

Adding  the latest discussion/status  that I'm aware of, related to
memfd, for reference

- Thi=C3=A9baud Weksteen (In CC)  has patch [1] for a new selinux policy
for memfd_create in [1]
- Micka=C3=ABl Sala=C3=BCn and I  discussed the security hook to block exec=
uting
memfd [2].
- Your recent patch in Landlock [3]

[1] https://lore.kernel.org/all/20250918020434.1612137-1-tweek@google.com/
[2] https://lore.kernel.org/all/20240719.sah7oeY9pha4@digikod.net/
[3] https://lore.kernel.org/all/20250719-memfd-exec-v1-0-0ef7feba5821@gmail=
.com/

Thanks
-Jeff



-Jeff

On Fri, Sep 19, 2025 at 11:10=E2=80=AFPM Abhinav Saxena <xandfury@gmail.com=
> wrote:
>
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Tue, Dec 13, 2022 at 10:00 AM Jeff Xu <jeffxu@google.com> wrote:
> >> On Fri, Dec 9, 2022 at 10:29 AM Paul Moore <paul@paul-moore.com> wrote=
:
> >> > On Fri, Dec 9, 2022 at 11:05 AM <jeffxu@chromium.org> wrote:
> >> > >
> >> > > From: Jeff Xu <jeffxu@google.com>
> >> > >
> >> > > The new security_memfd_create allows lsm to check flags of
> >> > > memfd_create.
> >> > >
> >> > > The security by default system (such as chromeos) can use this
> >> > > to implement system wide lsm to allow only non-executable memfd
> >> > > being created.
> >> > >
> >> > > Signed-off-by: Jeff Xu <jeffxu@google.com>
> >> > > Reported-by: kernel test robot <lkp@intel.com>
> >> > > =E2=80=94
> >> > >  include/linux/lsm_hook_defs.h | 1 +
> >> > >  include/linux/lsm_hooks.h     | 4 ++++
> >> > >  include/linux/security.h      | 6 ++++++
> >> > >  mm/memfd.c                    | 5 +++++
> >> > >  security/security.c           | 5 +++++
> >> > >  5 files changed, 21 insertions(+)
> >> >
> >> > We typically require at least one in-tree LSM implementation to
> >> > accompany a new LSM hook.  Beyond simply providing proof that the ho=
ok
> >> > has value, it helps provide a functional example both for reviewers =
as
> >> > well as future LSM implementations.  Also, while the BPF LSM is
> >> > definitely =E2=80=9Cin-tree=E2=80=9D, its nature is such that the ac=
tual
> >> > implementation lives out-of-tree; something like SELinux, AppArmor,
> >> > Smack, etc. are much more desirable from an in-tree example
> >> > perspective.
> >>
> >> Thanks for the comments.
> >> Would that be OK if I add a new LSM in the kernel  to block executable
> >> memfd creation ?
> >
> > If you would be proposing the LSM only to meet the requirement of
> > providing an in-tree LSM example, no that would definitely *not* be
> > okay.
> >
> > Proposing a new LSM involves documenting a meaningful security model,
> > implementing it, developing tests, going through a (likely multi-step)
> > review process, and finally accepting the long term maintenance
> > responsibilities of this new LSM.  If you are proposing a new LSM
> > because you feel the current LSMs do not provide a security model
> > which meets your needs, then yes, proposing a new LSM might be a good
> > idea.  However, if you are proposing a new LSM because you don=E2=80=99=
t want
> > to learn how to add a new hook to an existing LSM, then I suspect you
> > are misguided/misinformed with the amount of work involved in
> > submitting a new LSM.
> >
> >> Alternatively,  it might be possible to add this into SELinux or
> >> landlock, it will be a larger change.
> >
> > It will be a much smaller change than submitting a new LSM, and it
> > would have infinitely more value to the community than a throw-away
> > LSM where the only use-case is getting your code merged upstream.
>
> Hi Paul/everyone!
>
> I am not sure what is the latest here. But it seems both landlock[1] and
> IPE[2] have a use case for memfd_create(2) LSM hook.
>
> I would be happy to work on the use case for such a hook for landlock.
>
> CC=E2=80=99ing maintainers for both LSMs.
>
> -Abhinav
>
> [1] - <https://lore.kernel.org/all/20250719-memfd-exec-v1-0-0ef7feba5821@=
gmail.com/>
> [2] - <https://lore.kernel.org/linux-security-module/20250129203932.22165=
-1-wufan@kernel.org/>

