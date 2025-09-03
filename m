Return-Path: <linux-kernel+bounces-798943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9B5B424EF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5155E188EDF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24BB13A258;
	Wed,  3 Sep 2025 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="COfDzCPv"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFDB63CF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912620; cv=none; b=ObsQLwy2ByKX0w7tbeA9Q2Y0k5GRpB3fM++Q1rlISc84/O65+zBoweeV2xfem30nrI8S5Db0XAesSFWfx8MDR/7Tqxw2Rp4qQDBsNzNxWaUxKQSbPmYVzreIRXrTZCo52zRBKQcL1S4q0tYleJu1hgKd2QMqArP3SqNuwcHHeuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912620; c=relaxed/simple;
	bh=byK7zrr1bzY5AYWAm/P3qCdsXI6BM+A7ye4HlXMiUD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqpdkjYkZwSJADu9tvqfQ/wdizWXyOU3wnMvTNBGTLXP2UN/Bnk+HGzAc/jlWK9PQUlRNWQO7xK8pbLKpY9kHTrTCtIB/ZD7AmClcNArKPRAkuRpbHtf6+SNJosxln1pO7NGQxcvULcXEW7CsLNB2T22iI8S8DuJp6NwvBGIUKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=COfDzCPv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3277c603b83so4103449a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756912617; x=1757517417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9xoPboV/qxX+mio2heAhqIyl2Xj0Gq/B/HBIeZiQLI=;
        b=COfDzCPvFbJba28oGi8G6VPPVEK9HWgP22clzPa/paUnyyrCfjA2hlIFpEGXpo//7v
         NH7965VpPcKiHcI/W2wVg+teLWWC4Agj1QT3FNT/GnDlOvbUPoZAsnLlO/4AXWhGAQYP
         owGzZfg92iqbgFvb5TIwfwXPi4hxQwjeB33s97qZl/11hfDjnndvQJ5rPS70j36pMTTN
         f5HAJDugR/DYrtSVIFGY4XR19u99RhcQsaYDuWUf1rBDO1jIAk4yYGsWRw9dy3z3EaFq
         iZj8BB5jBUMPekkgQfZ8kZk1d/DU52/fdmfVXNY2o2AFl+sUmHxYtYMYfLeHz02VgR4Z
         6Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912617; x=1757517417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9xoPboV/qxX+mio2heAhqIyl2Xj0Gq/B/HBIeZiQLI=;
        b=nNgUMowDCiwo0T2dhO+pKISIKoSiIcqhhq1bZnrc745DOZd2dpnIg/fl/77qqHus/k
         T3si5AgPd440ZTRc6g9jAvZcbUuKSAraFELlGZiIPHhWWZTJEVLHlPgD1M0PUz0eBuVZ
         9XUT07JPWvfHubXPJ9mqMzj6LHoz9duJAcrinuLCkZQRAQUHDJRAs64k2QzWkCtMbOHi
         vrKrk8AP3Re/TdbRLrrW4u0tf4RVQlJQlAPgGrdkWJcQeU5YKs+w1Ib0pdYyjG+S0Ojq
         MKXCEQ/dXI0XHHWt1nJsto6YazZqYJEH+HOIZ4mcfQvMxVHSnZzjUp4hJy99eyfln1Nb
         XmIw==
X-Forwarded-Encrypted: i=1; AJvYcCXw68fnJZRAUlI8R25FEvtAZhLTMEe9VoJvA1CHn1CXd/0Mas2Cloif9rOSi1h6d11twyi/Wo3+6XkhJ7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBpsVtHbhWQcaFh4rnUh65g0hWeYXVYN9sLktznXZW5rlMkTcc
	s2sTqxKB40a7+LQ0ukQyPaiK60ds9aQIpW0FC4LfCQDMVR+UVYP8in/L9b8FnAPCLFQdPFW2Jx1
	RNy7kW926tX718/8Sw/qaZiQrNCLvJ197wMaRejYP
X-Gm-Gg: ASbGncsjqkQJT3S6qH4T1pALGboz5uHhnN7Swlt3y9U4N8mvjxS0MpxF6d0Da491L3h
	S1N+d4qi8h33+VIx4lknOB2iTktQHAnjk1M1vZa30Nks/oz6gTYpZq7lK1rzQucMVJZ2y0ydXRT
	qknGiBpHtrFTPobEkJp76pKgc3GXmayC8zrDLu+hPIHx4JcQ7lpljPFIDD0hwz1zWWSOv3SgzU6
	uR1jFQ=
X-Google-Smtp-Source: AGHT+IEssE/AwRco7TF6rJSchc13XdpTJCYeO75MU4xNduI36Ol1h4daL6qVVMfNUu0Gyun/oQgqHdsHmb0F25e3H80=
X-Received: by 2002:a17:90b:2cc6:b0:327:7784:5390 with SMTP id
 98e67ed59e1d1-328154529a5mr20653103a91.16.1756912616791; Wed, 03 Sep 2025
 08:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902110049.4437-1-disclosure@aisle.com> <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
 <CAHC9VhRtXzSGafaqLm_EDq=rj4BhDaOkaS0uJ89W-Scw2Zyxuw@mail.gmail.com>
In-Reply-To: <CAHC9VhRtXzSGafaqLm_EDq=rj4BhDaOkaS0uJ89W-Scw2Zyxuw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 11:16:44 -0400
X-Gm-Features: Ac12FXxk5b0xYb_QejwdO54jHWfoE6P5UxMpliGAjk9JRse0Tc_FuiYv2QlNnkc
Message-ID: <CAHC9VhS7PyKsGnoT17WojZmUEqYh-HgP2TS-DQdct0yv2BfZqg@mail.gmail.com>
Subject: Re: [PATCH] audit: fix out-of-bounds read in audit_compare_dname_path
To: Stanislav Fort <stanislav.fort@aisle.com>, Stanislav Fort <disclosure@aisle.com>
Cc: audit@vger.kernel.org, torvalds@linuxfoundation.org, eparis@redhat.com, 
	security@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Sep 2, 2025 at 2:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Sep 2, 2025 at 7:00=E2=80=AFAM Stanislav Fort <stanislav.fort@a=
isle.com> wrote:
> > >
> > > When a watch on dir=3D/ is combined with an fsnotify event for a
> > > single-character name directly under / (e.g., creating /a), an
> > > out-of-bounds read can occur in audit_compare_dname_path().
> > >
> > > The helper parent_len() returns 1 for "/". In audit_compare_dname_pat=
h(),
> > > when parentlen equals the full path length (1), the code sets p =3D p=
ath + 1
> > > and pathlen =3D 1 - 1 =3D 0. The subsequent loop then dereferences
> > > p[pathlen - 1] (i.e., p[-1]), causing an out-of-bounds read.
> > >
> > > Fix this by adding a pathlen > 0 check to the while loop condition
> > > to prevent the out-of-bounds access.
> > >
> > > Reported-by: Stanislav Fort <disclosure@aisle.com>
> > > Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> > > Signed-off-by: Stanislav Fort <disclosure@aisle.com>
>
> I also just noticed a disconnect on the email address.  I can leave
> the Reported-by email as disclosure@, but do you mind if I convert
> your Signed-off-by email to stanislav.fort@?

Stanislav, are you okay with changing your sign-off email to
stanislav.fort@aisle.com?

--
paul-moore.com

