Return-Path: <linux-kernel+bounces-804748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BACB47C84
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 18:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 390721899815
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 16:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5914284B4C;
	Sun,  7 Sep 2025 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QsRCqpT8"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2107082F
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757264327; cv=none; b=nch/VwUFWxQoeaaknyM6q2sbaAIt1ew2UZUUN5mvnY0s3VKi4L/HgPDTtuQ7qqbO0rqK6ZhO9jmD66HmTjQVZjLXsO3aTNQTdISQ5iDeUIiUuXw9z+65Ldcwcjr6Fgd1pojakWSEXd32GZw9N2JkGGjdfCvhktGGclGyf+rsSfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757264327; c=relaxed/simple;
	bh=UG6aaIt/J4hlqTLrVipzyXLPRoWjC628BnP36N7T3tU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFewgakAzxtGeYoa1ebGVuZL6ufiaBGXSazawuFTTk3+AIbOkhDuy525ljyF2EG8NrnGUmNv3fknRjhs/59yCfvnmDycfqxsoA1QMbvk2guLEX+rpaCiQ4EjgPjzbSlSAIOtoWik3zZCm7ee7o2ub7EDCP9P6ziLanv2NZwERa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QsRCqpT8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24c89867a17so34366285ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 09:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757264325; x=1757869125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8rxZBcVWqeQttZjBzXJXbXm94rgTwoH9ei9j3iaczA=;
        b=QsRCqpT8mfEfDjQk9wir2rYkxZyBxKdUdVaAilyomOJ0wDXQ8sckCyP1nVibeeD7fI
         5zCIukFyw1Ktrs3ABSvf2rGEJUUrrI8NF1QACheZoywakeAxqdlnLL4edIGrnDyJflKN
         gZFQuzojroFnuBVyFc8rrrLTrdZ3C7JMiXYv5xZNmt8M9b2madgtQJ9S50BwAoFYOhzb
         KATyqvucVbNudODuh4/tnUeOpKkXohZrHnGUdhP9dPnwldsdPUf7poMIgjjvQ9Q/Anpm
         5ATc2UaxgwJlWCGHA9t+afOu97ghCPTKmNtAijd3yQYccDk5kD2JtTMKrCWgkKfRNzM7
         ZPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757264325; x=1757869125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8rxZBcVWqeQttZjBzXJXbXm94rgTwoH9ei9j3iaczA=;
        b=rSo84edP0m2l1fvgxWT7jJbucvmLJZmirrKaZZtoc0x0Ab2KBrAyUiq8VKdf1Hxg3p
         fWKKvL9v/1VINNU6UYnIhZxq7QCYJG9svxTdSN4gGbNCBsRPU8SNI578Q8O0CnpiZ0RY
         NT6EPX3crPiylCuml7qZJlQ2apuqp3UqgcZ/LHQKLJhaZp5zTBNTdvXAA3rp+aA56YNf
         rYNG6j9qmCVSVvtCl0cye0c7TkguLNoexuEv4o6NNq/5Ji+LcGSVk3DTOCJPHvAN30df
         +Z5OutYgG5aYWagQkXtPpIm8/PEqP6v4gp6acPyEZcvnaM8ndrX/vbBSrFrzGTsb/m+u
         D+Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUbx8N4m97YRYJvPGjtMIKDIY8Pl2mufLVODFOkiKITWI9C0jjswUOJ7n33JR+oRimZqMCb/QJjprHDdFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGCgD/XmojVUL251XralLDilO6zC4mJmW3x1oIgH1nmBM70WMi
	MJ5i4+o30Wm2IYf5NTrwmmWpZmh51/3XuAkw5GXhjNxsNIp4RjD7bk238E68/H7ojEKd0v393qg
	PYKlIiOdOnjJgrClNneMR6suo33NMqlEe7DKlgjEpk2Bij7aOvrg=
X-Gm-Gg: ASbGnctt8WvqnB1S0PgWIe/PQS8RPp6hgkf2P8ZKQfwkVskqo9OPiilXHkUJnrifOws
	4gMRdjUwxm9R3wsyVyvZOHk6lY8mWvZ8ymS7OdwFjGRKyWTbKTlYxjsNn9TmrIO5M8q8/SLDmIj
	uG9y+okWp51c19FOmXjTcc9Q/nE9hjpDEHkiHm/WD7a/dhTrXiE3XViSI2tJu8R2rEDzV+aQGmi
	XJvHN/+YSyt/qx/yg==
X-Google-Smtp-Source: AGHT+IFaE++x7GtzCCIsBv907Sl2uWTltDpZX4herwHYVlHepL8ORXOJe8XeTw2pWIVYggy7DyLPn5X/oi9GlRRt5xk=
X-Received: by 2002:a17:903:1b68:b0:246:b46b:1b09 with SMTP id
 d9443c01a7336-251715f3129mr65953055ad.30.1757264325209; Sun, 07 Sep 2025
 09:58:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905222656.3692837-1-nkapron@google.com> <CAHC9VhT8NrsXMM-PPZJ0EPLxFHQ1vOu+ASCd+82Xth_mJPnDiA@mail.gmail.com>
 <aLunR_0BPCrATnBP@google.com>
In-Reply-To: <aLunR_0BPCrATnBP@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 7 Sep 2025 12:58:33 -0400
X-Gm-Features: Ac12FXz4UWnBPZx5fAUVbpMVPdPjXX8qeZE7T_l2WMRkmXHmb_U-YFwEaovDvoA
Message-ID: <CAHC9VhSaAm3G9bnJ86Aj+DnTio19ePE1Pu3voaB3XUvBveodbw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix logic issue with per-file labeling for functionfs
To: Neill Kapron <nkapron@google.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	kernel-team@android.com, selinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 11:15=E2=80=AFPM Neill Kapron <nkapron@google.com> w=
rote:
> On Fri, Sep 05, 2025 at 10:13:01PM -0400, Paul Moore wrote:
> >
> > With the original patch sitting at the top of the selinux/dev branch,
> > are you okay if I simply fixup the existing patch by adding the
> > missing '!'?
> >
>
> Yes, that is fine by me. I could submit a v4 if you would prefer that.

No need for a v4, it's just a single missing '!' and the commit
happens to still be at the top of the patch stack.  In cases like this
it's easier for me to just apply the fix manually.

Fixed the upstream commit and pushed back up to selinux/dev; please
take a look and verify that it looks okay to you.

--=20
paul-moore.com

