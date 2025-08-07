Return-Path: <linux-kernel+bounces-758492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7880B1CFD7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8271018C1CAB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0CB13790B;
	Thu,  7 Aug 2025 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XTvr/1Nf"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B5611E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754527232; cv=none; b=to3YViImPvSTKJs6VSQN8XiqBOU41GaK311LA060hgG+YFi5Nz4zg7vz8MvXCl1o3yyIRuT8/R8IZtk2feeny+dmkvEx8MloUzx92EJw8P8kNimBUgFqsoPsLFOa7PJ91J9511OF1xryyrjGkxiOU4Nc8N8U2m1+FXD6dFVKCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754527232; c=relaxed/simple;
	bh=4ROGn0oDBTpKlpqUDQ7SoxAMekMiIPw98eYIg1yddKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bdexPZiU+7gmYj0VO6zWs2/8kO2R5p74DjTjDO+DPb7mHIEkM1yZw7w9LVSwrjHwwUHglZxoFfI2Qai1fBuILqkzvVja9k8Qp1ha2oNSIae9xhSlqStSsCSfYmpXbPQ+QJ1syQL9p4Nw2WRQFjk5ALO6988+TPmhGZoBnwIZsfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XTvr/1Nf; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32117db952aso470392a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 17:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754527230; x=1755132030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIDyGCS8xHCqOVsUnrlcD2L9UqKff5ovQLVxd1rVf3o=;
        b=XTvr/1NfCqxCMX2tnzmrsliBg1YYfwSu0OFXOvaa1bL/MNLp7DfJkGLcPzsCeSwvdh
         sBxcDprCAO0KpmOzLs8W6VDElDESKQGx5GDroGKMmMwfizNpmppzYZGSWSo6Wik6c3Do
         j5UhJxYPjzeMs8Ceu5mJ6Cs0OSpCG028I6eLNDBm3pJMDUyATykNHEr4WrL9vqfYZaCm
         XCfV4wZYnI/j/4WWq255W4xU713AZShI7ksvzjBgk9zHnkWuu0M/7WgrBZXtazVoyUGm
         0HTbWV2wpFuQ4Syy1dagVi9Oex+YoNc38V8sWycmw5N2MPhWe6wmM9g3tEEwAyCbhqfJ
         bMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754527230; x=1755132030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIDyGCS8xHCqOVsUnrlcD2L9UqKff5ovQLVxd1rVf3o=;
        b=Ui+wYOPavPUbUXqOgndkhVXHgFBCvhs3Yu5xHXvyXCUfE3LWbMJn66gc6PdcPbZCrK
         dHTtI90tv5CVu8RYH+ChHG5LR+Sz/rTYg7l0PcXUIOMX7fFcqm70WgfzBkis7C6XuGEM
         wA+InGL13Exg6CWiZVPHLsGk8sWBtRKMF+OoNkwNi+G7UFlZ3J6rj8LXf5MzefgT6Wgm
         g6wdlsAZrRZccMFLN4mwkwxd6nUUR3k2/kcCeybedffDV8Gha04MGlvFRr1kiR0tUnPZ
         oG2J0qz7ccjGEG/5UFbGr5OfYzeNW89cpiOinran7x9H/hZoobZ6O5pmdyKAO5qeoKXO
         COSw==
X-Forwarded-Encrypted: i=1; AJvYcCWPtQKNv0gvOC5CouzS2TZiyLCkCgPS9MQaQ5hPS8pna+kysDVHSYEYA412+AmDt0UlsUhpif1RZ5ImQyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfnSHV4roWlR01N8wI3xFv9FymK7v5aMQEbO616ANpk8IhbAyv
	K1wVldVJX2nediVysXCzkcsPK7LcCnEXc7jYf6CE8c9k74a5SazRXj2oVNANqaOAd3Y1XNXa0RS
	aTp7mrAyTrXmWB3cj0WxXhjbmOn5KXJDyextY51Sq
X-Gm-Gg: ASbGncsZ5vRPfdw5aR6TyUkJTTQjM3B1uHSehtSImLICEVVVK7lfqr2dizabkLG+PFG
	rUgjTHUJnhFi+bOcTJaRj+5LtITlKfmkuWU5TANI7kmV1bOPYvXJLcCz6ma26FbeJ4qG0fxYP5E
	aX5giDR2b+6KjBjLZWAijluA2T729cesLEATrKwpuTkLfS6pJIPOlnCY3KdzP2c1WXhsnT9wSrX
	l2kQ/g=
X-Google-Smtp-Source: AGHT+IGKIO52g5ER47wAOh69fA0MNDX9GHEgLcBiFV6LGJZgbd2j5ZJbEzF9aBT2bGdM7sw8tofF8xwzOBbv0tOHAaI=
X-Received: by 2002:a17:90b:1d43:b0:321:27d5:623e with SMTP id
 98e67ed59e1d1-32166cc8ff0mr5381661a91.23.1754527229849; Wed, 06 Aug 2025
 17:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250617210105.17479-3-casey@schaufler-ca.com>
 <f7e03785a79a0ac8f034cd38e263b84f@paul-moore.com> <f3a8cbc4-069f-4ec2-8bb5-708b90360b05@schaufler-ca.com>
In-Reply-To: <f3a8cbc4-069f-4ec2-8bb5-708b90360b05@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 6 Aug 2025 20:40:18 -0400
X-Gm-Features: Ac12FXzzNR0g9jh2zy54Q1qrJNPEp3zGdJnwV4n4YyYgLDuSBPHMhEyzCQhOOus
Message-ID: <CAHC9VhQ29bue6V5=QE6qVUE8zpG3N8yndhtk_JUmt5htTgtQGg@mail.gmail.com>
Subject: Re: [PATCH 2/3] LSM: allocate mnt_opts blobs instead of module
 specific data
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: eparis@redhat.com, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 7:16=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 8/6/2025 3:06 PM, Paul Moore wrote:
> > On Jun 17, 2025 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Replace allocations of LSM specific mount data with the
> >> shared mnt_opts blob.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/lsm_hooks.h  |  1 +
> >>  security/security.c        | 12 ++++++++++++
> >>  security/selinux/hooks.c   | 10 +++++++---
> >>  security/smack/smack_lsm.c |  4 ++--
> >>  4 files changed, 22 insertions(+), 5 deletions(-)
> > ..
> >
> >> diff --git a/security/security.c b/security/security.c
> >> index 8a4e0f70e49d..ec61fb7e6492 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -904,6 +904,18 @@ void security_sb_free(struct super_block *sb)
> >>      sb->s_security =3D NULL;
> >>  }
> >>
> >> +/**
> >> + * lsm_mnt_opts_alloc - allocate a mnt_opts blob
> >> + * @priority: memory allocation priority
> >> + *
> >> + * Returns a newly allocated mnt_opts blob or NULL if
> >> + * memory isn't available.
> >> + */
> >> +void *lsm_mnt_opts_alloc(gfp_t priority)
> >> +{
> >> +    return kzalloc(blob_sizes.lbs_mnt_opts, priority);
> >> +}
> > It's probably better to use lsm_blob_alloc() here so we have some
> > allocator consistency.
> >
> > Also, make this private/static as we should just handle the blob
> > allocation in the LSM framework (see below) just like everything else,
> > unless you can explain why the mount options need to be handled
> > differently?
>
> The mount blob is different from the other blobs in that it is
> only used if there are LSM specific mount options. If there aren't
> LSM specific mount options there is no reason to have a blob.
> I know it's not a huge deal, but there is a performance cost in
> allocating a blob that isn't used.
>
> If you'd really rather accept the overhead, I can make the blob
> always allocated. Let me know.

Well, this is happening at mount time, which should already have a
non-trivial amount of overhead (parsing options, doing the filesystem
setup, mount tree addition, etc.) so I'm not sure this will really be
noticeable in practice.  I guess one could also make an argument about
additional memory pressure, but the mount options blob should have a
fairly short lifetime so I don't see that as a significant issue
either.  If one, or both, of these becomes an issue we can look into
ways of mitigating them, but right now I'd just assume keep with the
existing LSM blob allocation pattern to simplify the code and make
life easier.

--=20
paul-moore.com

