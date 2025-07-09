Return-Path: <linux-kernel+bounces-724015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB5DAFED96
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217DC18891B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286022E62D3;
	Wed,  9 Jul 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PReXMYE9"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7A295525
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074384; cv=none; b=FhDAOKgM6XWKGLTp2/C1QCMOUnyhrwarpEDdQmaBQQ578ceXADEejjOoUlmcYOZSusmzBNqcFyK+33NLuzjgmTQKeruauNdF3ngwZojEf+4MWgvNqsQFDzAAHVcOZ7+9TtJhiHREail/AhxjgpOB6Df9IuvoFUWZjLeAjR8HrBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074384; c=relaxed/simple;
	bh=jX5tGhwQ7UlQseFYx0r6Xq1z1pSzCZuykZeE/E6aZLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=em1m2pJC+wx2QYplSccbnEQzMTYL5hNwTr6GQO9zdNfO7fXpENQgS7r20VM3PFfavHjiLoJVlCCELTFRtcZlp7T/BlmyRZPw1NcNX/mzCZJhRvHX246y3YBuasHFo49CHBPOa9vQaG64qhn5KCwi1YJ8GPzKhwNjH0cIYR8AgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PReXMYE9; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e75f30452so218367b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752074382; x=1752679182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzEGonVmXproAomin5eIhv7ocY+0CXz52Ye0JGlwwtY=;
        b=PReXMYE9vxDaCblE0ryYjn329fImJCE4IW1XDWhk+ctbfYYeukIAD+qQDBPrQyV8fb
         mgGell5vdkvPLhx2roO83HBztkglI5Y1rOjxeEuwjX2HRHQi6L4GvfJD/95sba+VPg/U
         hMdnUlrGjNu7ov7hP+Gjrz7LZTDdThNIPEmhLPd/8vX0wwUrRvnfQxkmftAu1ZoduwuV
         5rM0qigpQhZzgH3EnBR0gKuV/NlKVfvxiodqgXjIVZLU5lJGm+9uxtdMXebLAL689M7Y
         ng1xu910hSOHK2S4c3L10Vb/X8Y2fxb4vis3B7Fve/ZY3mi+cpdx8vTovJA/ZypvxBmF
         7diQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752074382; x=1752679182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzEGonVmXproAomin5eIhv7ocY+0CXz52Ye0JGlwwtY=;
        b=EDZk1vRQRmWwB+UQqI90+ZHMGte69sDS+wuFJGkKnwU7IxlX+QIzPptHpb6EqfrFmL
         rseaiUwGINa/oCCfQFaVq6BcEt5+kAgkB6/r6oCkbmcwGFF5oU12uHktmhgvw4feuJH4
         ebkgJtBALr6O8fjvXBumKHlO2KVqkqfAOSRnU8rrNYoBYARCag9IEWRV+7zV61hNVZAF
         dkaIvApIeQhRLX14ux7MQ3nvKBi7imFXLPm6OVp57y3kR8oPhuyvuv4DEq0a8BUY0eEW
         M0YlBqxJRZi772QDBuES8JMqRNJkBxotVPSP8PktOfzzZdZmFEP9WVVTQ6qyvt5DBIO7
         6Xuw==
X-Forwarded-Encrypted: i=1; AJvYcCWmdeKlVD8ki2Y0gcTGLfuDIw/gOB9urTuZmUhD0+Io9zMpbcNVEP4qTBqN/0LafFG3laQlXyvhw8T8wEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrjHOpS8FPenVgXohLDZKmRqfRarAf/f1DXG4ljvv8NOeIFMo
	tttfsCCnB4VZ4Y1CImpwuoIqY0Kg/QCIh+0IAPDfUx1odmV873KcjAF1aQekUOE4R1EcTLAqCS3
	+0FYtlGvP/CB9R3wet4P4AIckBETDLXVmbzL7XK4a
X-Gm-Gg: ASbGncvYcFYXQWCbMVfW+1KyZep+i3YyMl9nzr1iPCSkReO0NTPI+88fzA9lTVHt1wM
	/jyBTIcpItFnwbi0XkQpBWB3823IVZ1sGEsW19IHV8CG8m18YJ+vDGJ+rENA5GPgtG5c4aoViil
	99q8V0yRYrfIgdlfYQgEfIzH57uw0sjx1FiNpDrBXPuv0=
X-Google-Smtp-Source: AGHT+IFjdm/SLcamSWISUQ66DrdwMnktjlqu7nOrNWg4Q3frFotVmkLuYoFvM0O8pXxaPwSx2wsTZlYITGZbRbzkEHs=
X-Received: by 2002:a05:690c:62c5:b0:70e:7706:8250 with SMTP id
 00721157ae682-717b17ace8cmr45883167b3.16.1752074381801; Wed, 09 Jul 2025
 08:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708230504.3994335-1-song@kernel.org> <20250709102410.GU1880847@ZenIV>
In-Reply-To: <20250709102410.GU1880847@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Jul 2025 11:19:30 -0400
X-Gm-Features: Ac12FXxwFg_uAGld7AFSlsXAxl6RXBEAoPyYFqRJUVoeSEfIzHaujAQ4qrD1sLk
Message-ID: <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
Subject: Re: [RFC] vfs: security: Parse dev_name before calling security_sb_mount
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	apparmor@lists.ubuntu.com, selinux@vger.kernel.org, 
	tomoyo-users_en@lists.sourceforge.net, tomoyo-users_ja@lists.sourceforge.net, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org, jack@suse.cz, 
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com, 
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com, mic@digikod.net, 
	gnoack@google.com, m@maowtm.org, john.johansen@canonical.com, 
	john@apparmor.net, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	enlightened@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 6:24=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Tue, Jul 08, 2025 at 04:05:04PM -0700, Song Liu wrote:
> > security_sb_mount handles multiple types of mounts: new mount, bind
> > mount, etc. When parameter dev_name is a path, it need to be parsed
> > with kern_path.

...

> security_sb_mount() is and had always been a mind-boggling trash of an AP=
I.
>
> It makes no sense in terms of operations being requested.  And any questi=
ons
> regarding its semantics had been consistently met with blanket "piss off,
> LSM gets to do whatever it wants to do, you are not to question the sanit=
y
> and you are not to request any kind of rules - give us the fucking syscal=
l
> arguments and let us at it".

I'm not going to comment on past remarks made by other devs, but I do
want to make it clear that I am interested in making sure we have LSM
hooks which satisfy both the needs of the existing in-tree LSMs while
also presenting a sane API to the kernel subsystems in which they are
placed.  I'm happy to revisit any of our existing LSM hooks to
restructure them to better fit these goals; simply send some patches
and let's discuss them.

> Come up with a saner API.  We are done accomodating that idiocy.  The onl=
y
> changes you get to make in fs/namespace.c are "here's our better-defined
> hooks, please call <this hook> when you do <that>".

I don't have the cycles to revisit the security_sb_mount() hook
myself, but perhaps Song Liu does with some suggestions/guidance from
you or Christian on what an improved LSM hook would look like from a
VFS perspective.

--=20
paul-moore.com

