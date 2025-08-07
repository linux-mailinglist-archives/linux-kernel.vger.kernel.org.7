Return-Path: <linux-kernel+bounces-759344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D00BB1DC64
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00AB97B0704
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC08271466;
	Thu,  7 Aug 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KjRWxR8t"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043126656F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754587277; cv=none; b=D45MwkIqqte9K2nItZUcYp1aVpcGyGSNOkYNSv2llNzbR78fBcd1lv15k6cslPWURyVtpQUV3bMphbi+SUu5PBAYB3ILH1LMZU1lQEv+UHhnI10+pGlRIlOwOfPAtOLSkTE+Gxq14Hzs8oBS5C5OsUdFiIAq60Hfm/sPbBAQFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754587277; c=relaxed/simple;
	bh=S5duOYIsIrTSQJWDktRsp7LMwwNw3gBQciu6NPWEOk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRrJcGHHMJgx0lW0kKaGoIUat+A0DSvzpEJ9vs6p5n0Z1kUrd5AuqSOGZqrzvcJSBjqzPIUi4/kiOkk64omsr64KgPjkEXryosI8QryFH8ftVYtPOJV86/7PiS3SnTvZG7+I1tk1QNDObuTj5b0oIc6Mv6Od42oqE5vz+9uj5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KjRWxR8t; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3214762071bso1555767a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754587274; x=1755192074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCv33JLYlQWvy+u2owQ6Y5A7BoaiU+a+e/6Fp8KCqBY=;
        b=KjRWxR8tU2WfdzQYcLaNY76W1GlrEn6aWc3E9JmwqdaAUjcZAgxcv86KvZ0qFhk8Y0
         Un7NIihk2wfcwu6N8WWWPY4iQf6NjEtIj5pP0k9dF+kagSZ7lQPAbEawfeq1jnoOMtpV
         3QYWKxJDEk2BX2IZxkenvy1EzwSN7F/RBIvp0+8gQAhli07ENYG/ozsjOxoaXVTNXlkQ
         zOttwgwrbSh3NWQ9Op4YuXviS0Bi8/GnYzjvblkPEjS8J988smz2eTeuKUXW6JYO5hBl
         /JnHPugzgvUKdHYavJqpnfbFLnhysbf8t4W+27gTcsT8s0qi2SmO1a5JT2kJKqpYZKGr
         mprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754587274; x=1755192074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCv33JLYlQWvy+u2owQ6Y5A7BoaiU+a+e/6Fp8KCqBY=;
        b=PVEX3fWZJBVb/kvaK+C/qOtoJfo0t4p4DqRAQLE87+NaquCX0SiwQ3e/+SnNBPZsqn
         mtjh4LeOUkqO6DHyUMKl29Nz57aBjC1hA7ut869b7DMUNp1KEKwy46o/7uttkrWL1nGD
         ICQs6Deu6SolVIxWmt2GaAew1UC2ZFdYmXu08sijJBoZmmqkupOI8PnJMS/7U6nL6NQ2
         p1GsAzw89Y+bqpZEttOefP3bL8iS/E3oePhH7C1L40lJ1sNseNltFAVNpdqCf9Z/Wyg0
         9qKh1A6xVUYSXIGcmzGg0gtiHmdN2sd3Z4R00uqjMEP7Vp/+IRDs39hEsN5B+wVVqZ/m
         efRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHHOnbdLgg2CY85wEMLoZNHfDnZ7Vc7NV8j1FC4FJTaAZqdJ9PyCWASyJeL0OkEDq4qN9/XLpKxUgCl8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY8XUTULlC2cJy9GJvXyZn9bFnkCxuG141U9AjVbwNCCKgR3rj
	fJVzmsCk3Qd6zlIeU9H0J8I9rGcouNWwQsmqt2vvuZ7z/ciA6DbUMeiI54jS8fCkxbg50qfXUqV
	CpGiTFATEuuIoc/AyzwxVK+4yBI2GHgt9MG9l0RwE
X-Gm-Gg: ASbGncs7CSLxXaDg4bz9imJ2iHU3TLIhS8OboIa/o8UaVYGy0AY5a0q9J2eqVSruaO1
	8qXfOdM+k3rTMqbjs0bYhP5cAvcgeX85kl9NuydYByu6/27iRwFOoOmONu1h1JD/Q5AKrCPALI0
	9Kbc3gEhipaZEnGiziOg8ZFE42n+ERRaopCr5NxqmzpF7PsD2PqbmI56SL/cAqWuoogAF+da2yR
	qLiTxI=
X-Google-Smtp-Source: AGHT+IE1js9/9cU38IinGxfvXT2Ji0uPC3Bg69YPXOFInZafaUocl0WGvMzZgGZ+mkjiCIVl33QfNGzjWOqBIV71i4o=
X-Received: by 2002:a17:90b:1f90:b0:312:1d2d:18e2 with SMTP id
 98e67ed59e1d1-32166ca45cbmr9173240a91.20.1754587274179; Thu, 07 Aug 2025
 10:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722212139.1666060-1-bboscaccy@linux.microsoft.com>
 <8d6e0d9d4bb99481d01500a7211e5119@paul-moore.com> <87pld788yu.fsf@microsoft.com>
In-Reply-To: <87pld788yu.fsf@microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 Aug 2025 13:21:02 -0400
X-Gm-Features: Ac12FXyww-IWezWFt1gs_pTcPutnWqR1fhfrR3ryTkQDZeZCYr98-5G2rs8gz-M
Message-ID: <CAHC9VhTPrrgRh7v-H7qpizbxHNcW-V1qj-=24+Z8at2w4Co4uw@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,selinux: Add LSM blob support for BPF objects
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:09=E2=80=AFAM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
>
> > On Jul 22, 2025 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> >>
> >> This patch introduces LSM blob support for BPF maps, programs, and
> >> tokens to enable LSM stacking and multiplexing of LSM modules that
> >> govern BPF objects. Additionally, the existing BPF hooks used by
> >> SELinux have been updated to utilize the new blob infrastructure,
> >> removing the assumption of exclusive ownership of the security
> >> pointer.
> >>
> >> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> >> ---
> >> v2:
> >> - Use lsm_blob_alloc
> >> - Remove unneded null check
> >> - ifdef guard bpf alloc helpers
> >> ---
> >>  include/linux/lsm_hooks.h         |  3 ++
> >>  security/security.c               | 86 +++++++++++++++++++++++++++++-=
-
> >>  security/selinux/hooks.c          | 56 ++++----------------
> >>  security/selinux/include/objsec.h | 17 ++++++
> >>  4 files changed, 113 insertions(+), 49 deletions(-)
> >
> > This looks good to me, one nit/question below ...
> >
> >> @@ -5684,7 +5731,16 @@ int security_bpf_prog(struct bpf_prog *prog)
> >>  int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr=
,
> >>                          struct bpf_token *token, bool kernel)
> >>  {
> >> -    return call_int_hook(bpf_map_create, map, attr, token, kernel);
> >> +    int rc =3D 0;
> >
> > I understand the motivation behind initializing @rc to zero, but to be
> > honest it is redundant and will surely result in a follow on patch from
> > someone to remove the initialization.
> >
> > Do you have any objection to me removing the initialization during the
> > merge?  This would obviously apply to the other two as well.
> >
>
> No objections on my end. Thanks.

Okay, merged to lsm/dev-staging with plans to move it to lsm/dev once
the merge window closes.

--=20
paul-moore.com

