Return-Path: <linux-kernel+bounces-851474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ED4BD6963
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B2F18983CE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3172F3622;
	Mon, 13 Oct 2025 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BUS+a4Ef"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54903223DF6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393523; cv=none; b=cgshJiLudc7iqOqqdh77dGprYgoIhEjKqhqJbpKfh6fQ5Pl0Y3SnZ0NdV3fMDCKbmqBK7P5wqJn/bSdgm3x51xspVBY+iZfYqXCOQtUNH4aLq4foVbTYIFx04h8dHiJgMMqXujjDB03LSwbj8Rc6moSgM/XDpCJhZKTMgz+sqas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393523; c=relaxed/simple;
	bh=be2JClIJrJxBvNDhrBkl734DHApdgwSRd2qYm+Z2B4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GEEWbCWgbQDHFwSV95Oc+zFA7b7q3PjMbINVjrZbAJecn1aaKqSpWnepNkcBqXaXM2eymiEfniwcdqG+abO0rRCTZpjwl1tqiUaJnGXl7zKWWDei67QZJNfu0F3rs3cnz1oKo9jgmkFDzGAzLhU2NFud4nvxvu2v1enZ1gN5YXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BUS+a4Ef; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27d2c35c459so33201365ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760393521; x=1760998321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nV4/lwpAKyOkjUBhIKqRVppxc4INpbpW5Cdx7jCocQQ=;
        b=BUS+a4EfvbutITz6O72lNnqLkt3ORJXUbag3z9Sn8rk40Bu26MKuLYsJcOoLbpXnmR
         94je4MotmuBNbXpDtKpGw7cQXH4Aln0mo3i26KZdYmwmOk0PMtKYGlP/Q3W2Ogg0GZtV
         HhskKH5pHEWireG33pp/8AWzZR6W5AXEW58P0TFugQ5QaVIsnoQKZHK7BMkVAZLRFR6j
         alRFAYhYw5AXVpVIHeRg4VBN4/8J6wS+gY156NXobkGj1iIsFChkM1LsSPkXEpCmWZ7x
         WETdfcu3H+ConbM+ZXnsGbF4e4rkBAQl6I+TqUEldmToBDwCe8kT6jsungwFc0gNt/z1
         qzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760393521; x=1760998321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nV4/lwpAKyOkjUBhIKqRVppxc4INpbpW5Cdx7jCocQQ=;
        b=QzZ6kT+QW09x4G737VcQgLxrf5kYLheod1fcQkkjCxqZsloOtLX3M7kxCrvlipqSWo
         0lgHgm+bJXcgt26lXgCIlMjLcBANs5aMuCds46/1MqN1yDXLYk+gAPKW9IuPRlr4NdkL
         Y6WmrI7/e9CIJAbHLBKZ/L+QU2MLZ4fHpVp1NRginptX3S73Pw7qa9HO0QhaDPKU0QHI
         ZlwrFjp2hkHZO1kkQy8H0gHUDN5Eea8wRGMKZa1nOhL0wxgYXbbjv/DWuw/D/h6lhSE5
         +MrClxhG8KJmALSF7OWIg7ap37lTHx8igVFVZGfrlw/VjNVmenqSwplcNxhULdYh4mdi
         qDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj+dTlit+TA0eMT0rBPo7f2eNyq3ybzS/Y4BW8ksWpFnRTS9RzhKQMRbR5cSmGTAYMjg3G2/QGZLGT6mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxrPyiVDKJdf4AzD+f/TwN+w298fqdgZYqxdHTBY0axh9HYP0/
	sVCvh5uhh4nk/QYgymn7XpYZHlxDwLTCO0fr0Q/qfiXB7Eaa1btIBMASbrutS9wNxYV7phLs4G2
	2dmeSNgXKUWqyK81HSKaeElNQB5CCi7WN4Gi7OUFA
X-Gm-Gg: ASbGncu4zMobAzsYHORmmX+IamPyR1PCSEvTchoprEYa8dFUq+dX9I8FJVg5g38KaqD
	W+hl0Ysn0HZq+gOryTTG5MXBsHvNNwVzYnSIgFHJbYfOm55/o3Eu9UVK9mv0k2DGWUUTdL2cwfU
	1Wt7j7F+NZC77y6oW0zO7+Z1mIdUtfgzXSiv2ZoqpY6IyAW1njH2UAjIFBQgc2EVNSp6Y311hZz
	7GAlKInxRBxynI3mH/CEtz9FKUR55B+CmXD
X-Google-Smtp-Source: AGHT+IFThnEwReVhjbUWRuYz3JPM9/iH4m5a/UxLJsLUrdJeFsAXhN7ECjBnR6NRtSdH/5tYnnD056fNYIQ73AAr1cI=
X-Received: by 2002:a17:902:d50f:b0:246:4077:4563 with SMTP id
 d9443c01a7336-29027344a82mr330497705ad.34.1760393521514; Mon, 13 Oct 2025
 15:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001215643.31465-1-casey@schaufler-ca.com>
 <20251001215643.31465-2-casey@schaufler-ca.com> <CAEjxPJ7M4qySg+ZMujTqMQFSncWNbG21W+kpLzji6c4F+hyprA@mail.gmail.com>
 <d091c8f1-798e-4b58-bed4-5f71478373c4@schaufler-ca.com>
In-Reply-To: <d091c8f1-798e-4b58-bed4-5f71478373c4@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 18:11:48 -0400
X-Gm-Features: AS18NWAJfwOwScl7pg4qOX9NfCT3x6SC4JsaXLI_2aS9YiVP27tKLnaQy_hL_Ec
Message-ID: <CAHC9VhTr_0XtFfp017vXmaQVm77kkN+4ZqxNqNnBOW6MpFQqkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: Exclusive secmark usage
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 11:03=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 10/9/2025 11:49 AM, Stephen Smalley wrote:
> > On Wed, Oct 1, 2025 at 5:56=E2=80=AFPM Casey Schaufler <casey@schaufler=
-ca.com> wrote:
> >> The network secmark can only be used by one security module
> >> at a time. Establish mechanism to identify to security modules
> > a mechanism to inform security modules?
> >
> >> whether they have access to the secmark. SELinux already
> >> incorparates mechanism, but it has to be added to Smack and
> > incorporates
> >
> >> AppArmor.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  include/linux/lsm_hooks.h        |  1 +
> >>  security/apparmor/include/net.h  |  5 +++++
> >>  security/apparmor/lsm.c          |  7 ++++---
> >>  security/security.c              |  6 ++++++
> >>  security/selinux/hooks.c         |  4 +++-
> >>  security/smack/smack.h           |  5 +++++
> >>  security/smack/smack_lsm.c       |  3 ++-
> >>  security/smack/smack_netfilter.c | 10 ++++++++--
> >>  8 files changed, 34 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/security/security.c b/security/security.c
> >> index ad163f06bf7a..e59e3d403de6 100644
> >> --- a/security/security.c
> >> +++ b/security/security.c
> >> @@ -283,6 +283,12 @@ static void __init lsm_set_blob_sizes(struct lsm_=
blob_sizes *needed)
> >>         lsm_set_blob_size(&needed->lbs_xattr_count,
> >>                           &blob_sizes.lbs_xattr_count);
> >>         lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
> >> +       if (needed->lbs_secmark) {
> >> +               if (blob_sizes.lbs_secmark)
> >> +                       needed->lbs_secmark =3D false;
> >> +               else
> >> +                       blob_sizes.lbs_secmark =3D true;
> >> +       }
> >
> > So if I understand correctly, the first LSM to register with
> > lbs_secmark set wins.
> > Not sure that's a great idea - seemingly some LSMs may want to insist
> > that they get to use secmark regardless of registration order?
>
> But what if two LSMs insist on getting the secmark? The whole point
> is to make it possible to use multiple LSMs that what the feature at
> the same time.

My current thinking is that if two LSMs *insist* on access to the
secmark, one of them has to fail to load/initialize, even if that
means a panic on boot (we should flag that as an invalid config in
Kconfig).

Perhaps the solution is to have lbs_secmark as a tristate value: don't
use secmarks, would like access to secmarks, must have access to
secmarks.  Upon registration a LSM that requested "would like" could
check to see if they have been granted access and could adjust
accordingly.  A LSM that requested "must have" would fail to register
if the secmarks were already taken by a prior LSM.

> The limitation on a secmark being a u32 is a huge problem,
> and Paul has battled with the netdev people over it for years.

I suspect the only way forward at this point is to convert the secmark
field into an IDR* that we could use to point to a LSM security blob
that could store LSM specific structs for both secmarks and general
LSM state associated with a skb.  This would also allow us to do some
cool things in the forward path that we can't properly do now and
would make it much easier to handle a wider variety of packet level
access control scenarios.

It's on my todo list for <hand_waving>someday</hand_waving>, but if
somebody wanted to do it that would be awesome.  Just a word of
warning, this is not a quick task and it is probably only suited for
someone who already has a few netdev inflicted scars.

*I see that IDR is now deprecated in favor of XArray, I haven't looked
that closely at XArray but it looks workable too.

--=20
paul-moore.com

