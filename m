Return-Path: <linux-kernel+bounces-737182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E512B0A8D1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C401C83B93
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9050F2E7BD6;
	Fri, 18 Jul 2025 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vEPL2M+U"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B932E7BA9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857055; cv=none; b=NuKzGl5F4liSZThMvZQZ4QNU3gXIQ30nOaLnF4mtdzX/0lny5ax78n9OW1eVx/hBUBcty23eKfhGKNsCk7L0BLsqWuoXx9Q+wtxDYUSuYMd0/6ODHnshYmeyGoDfj9KBXBt9xlpKdVydbrHxr/AcBqRS9aWAHjX2m09/RVC60xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857055; c=relaxed/simple;
	bh=CjXVboOD7jqFsvDghr8v4qIw9uJof1firp6NqKPVwxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZT7K9OSZHd0aWmi0uxm51LvD1MvFQksj25kaKpqKPEzunGUMGRK82h8B7dE1NkbC/2gInfWGwtth02wYEyhGWB8SB3PgwzxheG3CwQM8S6LU0O7gx4CgKGjDqMbl3IELjBhSswqYacwHevUlUqcS/87oETMmT1+XTZCgWF/rtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vEPL2M+U; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4561b43de62so2485e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752857052; x=1753461852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYyOeEuwNocsHdGNCsBfI8Qe4KQ4QZ4n9Q1Dj/3rQ6Y=;
        b=vEPL2M+U4NlkFiH8vw9Mi0q0YwQy7SCstLVL0r5OCYmK548HpmG3Zl/xALUvgL+pYl
         VTCPaY2AIlcOkXusskFuOLDQEiS4As2qyZpYeqSso8fgKivA1LN7apYF/DJcrP525Bda
         htNhX/ZuEix8J+BAH+nCAnLCATtBCbvbj5AmOJMg7WMdqqF/a4HlPKiXCKlKFv2SgFPh
         B5+z+pJg4Pc4gFZkj6iCEDJ5anafmrYVkGrev9SdStvLYPLQ+D+Hix3UKf+8OkyjyHhc
         SVxOMWDT9u6cq4hUBS/9SaovcYMmOxOe2agNv0cm2AkkUX5iF+3Jwr724k9Q/P1aGKOQ
         Sfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857052; x=1753461852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYyOeEuwNocsHdGNCsBfI8Qe4KQ4QZ4n9Q1Dj/3rQ6Y=;
        b=G1sgwm64Mt6+NRgXg2Xz5H4L5Ii5Wg1rXruX8r/jDY5rxf64/7/oPXA8HCpe/dg6Gy
         aFvhSxIbkNeJclUg41uKukdbjmuHfaHzx4iosC7rNYJMiCkDGkbyzwf+SoSFy2vX2E9B
         PKkZZOcczH/yL0LoVYwfElPIsKG7w2UcvaQJ288kYEtZ+tz0F0zAKxxKOua9O+tfvgVg
         plzaVi6GkRMVRg1i66JlegWnQRzSomFlq7/bIgHx3KQKZ30HLwfRDL847mAhilTYlxqg
         L/17ZBjeU4vbziyS5Wg1pp/BXxwxAoGJB2NJj9YK+Kr1XxpzXrLGzcDLrB8Cji7xYBJy
         u6OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv4rpP86buQrv8I5gvnhM/Hcxebso5ZZC5Z+2nKqrXz4FspuVoNU19Icy5DLjrs7AgYKxrqGOqIQXpKwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfynW7D0CtYTggfmNTgZVPLjSL9dPNlyfxogGV7gSPAPGGoe0
	5fw1IIXkZLUZ2LhmC+f5fRaTp3DP6e8t7MhIVfbDxOs+G2zkbainohTl8PbAYcQHDwDVY7izNPM
	WqMeNKJibhDX+06QrKB22bhqZD0707jyk0ceaZrAs
X-Gm-Gg: ASbGncsN92c7lhS3GRUFGAMHSBbsxHrVwZxwHWoC2TbyZiLGDr1Ev3VCe0YuyUc8BOo
	zsCbxn7PaEqio6CPHD87mRkt6MDvv7xBKm5sLuh9jOq1rV049jmDdTrsMWYUZxAXhIqoeeMsGMl
	Yio/Y0b4PIUkaICXv5ol7mmkqmtXcs2jgNzqDD+IkHEofDFwC0uA9J9PZlfiTedf/Vw30Cifu2E
	85kHVAghGbWKpe8aF3HqmUhyyjctwwleirS0Qt4SpIM4Q==
X-Google-Smtp-Source: AGHT+IGfFvKzY08YuywrQMEICEvAuGeTVE+YW6Kb55R7MDhzINiZnoYDjpVLaeSISZL79sgVvYJwp63L+LUq6vf/bhs=
X-Received: by 2002:a05:600c:35d5:b0:453:65f4:f4c8 with SMTP id
 5b1f17b1804b1-4563a7821f9mr2358065e9.3.1752857052166; Fri, 18 Jul 2025
 09:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718-yama_fix-v1-1-a51455359e67@ssi.gouv.fr>
 <CAG48ez23HLtb9GJ-BbSXaWFhdPjXyFNED9fbuyaNP5EXJ_Wv8w@mail.gmail.com> <cehkmvl3y3u6qugobjo2h4yez6h5uw5pffqcr3mfjuki3sb32t@nr7nxkk3bdsg>
In-Reply-To: <cehkmvl3y3u6qugobjo2h4yez6h5uw5pffqcr3mfjuki3sb32t@nr7nxkk3bdsg>
From: Jann Horn <jannh@google.com>
Date: Fri, 18 Jul 2025 18:43:35 +0200
X-Gm-Features: Ac12FXzUGFJ7pnOjsyrzSLeBgsD9Po9gE2spiaKDjwY_YHbiT_yMwuF9Rp53xNw
Message-ID: <CAG48ez2rKDc_OPFYYaHahAdZWYTYwnF-cQBYf28=_5aAjYy2UA@mail.gmail.com>
Subject: Re: [PATCH] lsm: yama: Check for PTRACE_MODE_READ_FSCREDS access
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>
Cc: Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Olivier Bal-Petre <olivier.bal-petre@oss.cyber.gouv.fr>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:55=E2=80=AFPM Nicolas Bouchinet
<nicolas.bouchinet@oss.cyber.gouv.fr> wrote:
> On Fri, Jul 18, 2025 at 04:52:51PM +0200, Jann Horn wrote:
> > On Fri, Jul 18, 2025 at 10:47=E2=80=AFAM <nicolas.bouchinet@oss.cyber.g=
ouv.fr> wrote:
> > > From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
> > >
> > > Currently, yama only checks if the `PTRACE_MODE_ATTACH` mode is set
> > > during the `yama_ptrace_access_check()` LSM hook implementation.
> > >
> > > In cases of call with the `PTRACE_MODE_READ_FSCREDS` mode, nothing
> > > happens. Thus, yama does not interact properly with the
> > > "hidepid=3Dptraceable" option.
> > >
> > > hidepid's "ptraceable" option being documented as follow :
> > >
> > > - hidepid=3Dptraceable or hidepid=3D4 means that procfs should only c=
ontain
> > >   `/proc/<pid>/` directories that the caller can ptrace.
> > >
> > > This patch simply add yama a `PTRACE_MODE_READ_FSCREDS` mode check to
> > > enable an interaction with "hidepid=3Dptraceable".
> >
> > Please note that PTRACE_MODE_READ_FSCREDS is actually a combination of
> > two flags, and the intention is that the PTRACE_MODE_REALCREDS /
> > PTRACE_MODE_FSCREDS part of the flags should basically only be used to
> > determine where to read the caller's credentials from:
> >
> > /* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
> > #define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCRED=
S)
> > #define PTRACE_MODE_READ_REALCREDS (PTRACE_MODE_READ | PTRACE_MODE_REAL=
CREDS)
> > #define PTRACE_MODE_ATTACH_FSCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_FS=
CREDS)
> > #define PTRACE_MODE_ATTACH_REALCREDS (PTRACE_MODE_ATTACH |
> > PTRACE_MODE_REALCREDS)
> >
>
> Yes my bad, I should have sent the hidepid [1] patch in the same batch.
> The idea here is to take "hidepid=3Dptraceable" into account. Which
> already calls yama with `PTRACE_MODE_READ_FSCREDS`.

To be clearer: "if (mode & (PTRACE_MODE_ATTACH |
PTRACE_MODE_READ_FSCREDS))" does not make sense, because it expands to
"if (mode & (PTRACE_MODE_ATTACH | PTRACE_MODE_READ |
PTRACE_MODE_FSCREDS))", which is always true.

