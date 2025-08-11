Return-Path: <linux-kernel+bounces-763655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3477EB21848
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 00:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D65188714C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 22:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9475C2DBF47;
	Mon, 11 Aug 2025 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PqQLCcgt"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5322425B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950916; cv=none; b=cKVJvVUti4iAXySWOm7DqRx6gZoTdCmJMPcYy7g1o7iyFtRkbFc9PU7a4ZQN8LPR4GGCjzh0sn/N9jYkTrG2qAw2Kk+QyddgIe7oxLpLxcMW7XqXbyLyLQxEkhooh8zDn7iZvwTPLQXF9V9Z7e1JcC3mz6Kh5kVqv2WqHFh2BbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950916; c=relaxed/simple;
	bh=hvrFO81+pVnW+NEL2v4vIIIsxTeZIjXLYpL46zMC0p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFY+sTgTcWOmsPhM1OuDIuZ/HSU5BHatLuOgMOAPZLIErB+dQ+rbEiIC2zpmWxNmwf3Dy/St8Eh1lgBQZb0UrhMkWNuK2MU5nifZBGyTUdmo3ZpNnxGUcQG916R9p3DFr1h4a/atvuGo55DX8h2xfkmop4uJSQ94TffcmV5z/MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PqQLCcgt; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31f53b3b284so5426236a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754950914; x=1755555714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sOd2/5UzOQ6IPXWcksDo92rKHXDYOYJmHlu4KHuS/A=;
        b=PqQLCcgtOhgBgXL583LHhNumspV6JNXHclr5MiWJMYybAGHksUQfBjqRUZhbYZ4mEp
         PLgL6kLDIh8VljGHQ0RBDbyqWbqQ8yGeecO/CXnMA1vi8jgkspCQWpHQ5fDsxzTfENoq
         kE1+tLoiUqjqzKlO1TzhKj+ccWUQew0gGPVEsYLlQHLiuDFuKHV4f7lZn6nOINlE1Fce
         jyzSjUDWkbSzEibxreQaaDwhA9dEY2POcrn9eUa8rrJFAT1gO1thlcLYwE5oPfB2NwxN
         w8G1tEFAwHzGehbuYX6djOfORK46960jbqsYNgowErgk+8LoaZ0rAnk9UyJVOziwLdvQ
         eu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950914; x=1755555714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6sOd2/5UzOQ6IPXWcksDo92rKHXDYOYJmHlu4KHuS/A=;
        b=d17hCHleoSliGfQIFNA3Of8I5im8IvjiPlOcaZ/WNNQpCouSN+yEY2C9WmjS87Imi6
         b7sZBq/paPoNNFfUcs19cisDmTlto8b+s/LfV8kypscdNkHBcaJiaEOL8fNEw2nCl6+j
         qOeqdcLTBNDFF4RnRgsxuKrEmTcsgA6r6L9U72YN3Tsxux3ghWOmQNYGxAwBghOclxbp
         tgEdfUuEGkJ45TVW2PrZljPaItZQhdeWlcgW8+HRxKkQUqkD3kljSlBfxQ5zQa3zgvlZ
         2jDnY6dUJeCco/kOFrNryDyjFawcAaiBPFgf4F+rLJGPBU0g8Hl3FdGWRfiG1KMhUD2a
         FcQg==
X-Forwarded-Encrypted: i=1; AJvYcCX0M2H5mooaoP0oG4a4/2dPNwcxTe8WjaDFcHIPSAYjJNzAv5NVrNvntUz6tx7DKVjPCK4GUAZwOBJVmaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzueQZfdByeFPbIbjgLZKyuQWcYBwe8+VKWgXwSvfPCwJG+8Upd
	VkNIUfIR9sGl5Xw7jVAOP+tk4a6mg363oX49Rpr7sbTGDxtjs5uzsWQw/0tUWmisIk2LgSBzUJz
	eFNyTBASdBz1RQK7vv5r/kKLrFHVDQeCLKSW9kovJ
X-Gm-Gg: ASbGncvFcAnTLldhlOdHX4VIonHeo9yG8CAcGTio9xZB0No3/nW3W5rY9aSDid7UR+A
	ECh7KhC8tOdhDNPim47FWbMn8m4B6tB/mq5xOHkguBorp3jmcY9TkPp2FBLqAiDFnGeVx2utQQB
	N3QWyCaq2U4LiMpsr2Vx5dK9Q3+CByfeMrJfUuarcZ6adnt0bVsH/wivG1r4OqFoJynRVRwD7x4
	dHqQSLrVJLS315tYg==
X-Google-Smtp-Source: AGHT+IFPaXyAxbIS4HmKhbNk97XTN257F8PCGf5lSpmuwdoJgBJgfIKi4jJsD4U4Iz3+Yi8t0egwHaNL/4nDwGR6FDU=
X-Received: by 2002:a17:90b:57cb:b0:321:1348:4438 with SMTP id
 98e67ed59e1d1-321c09e6d6emr1846309a91.7.1754950913981; Mon, 11 Aug 2025
 15:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718203734.347091-2-thorsten.blum@linux.dev>
 <CAHC9VhSa_9cWiLfOUNiLPUa7PyECF-2hqzHZikYHj6QeYGMqEw@mail.gmail.com> <CAHC9VhS87wfk9j9_yzUNP-NaKOBL-YctvBLx_O4OQS2WVQ-OCw@mail.gmail.com>
In-Reply-To: <CAHC9VhS87wfk9j9_yzUNP-NaKOBL-YctvBLx_O4OQS2WVQ-OCw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:21:42 -0400
X-Gm-Features: Ac12FXyOofUWjL9ue0ch1jrVS7OsL7RFzTzKQOtEO7nI3S9ASnQ926DM3VVX2v8
Message-ID: <CAHC9VhTxUqW+a4D6cHMutaB3z9dAMoebibiDp04NAPaA=36rsQ@mail.gmail.com>
Subject: Re: [PATCH] audit: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Eric Paris <eparis@redhat.com>, linux-hardening@vger.kernel.org, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 5, 2025 at 3:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Fri, Jul 18, 2025 at 5:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Jul 18, 2025 at 4:38=E2=80=AFPM Thorsten Blum <thorsten.blum@li=
nux.dev> wrote:
> > >
> > > strcpy() is deprecated; use strscpy() instead.
> > >
> > > Link: https://github.com/KSPP/linux/issues/88
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > ---
> > >  kernel/audit_tree.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > This looks fine to me, but as we are at -rc6 I'm going to hold off on
> > merging this until after the upcoming merge window.
>
> Merged into audit/dev-staging for testing, audit/dev will happen after
> merge window closes.

Merged into audit/dev, thanks!

--=20
paul-moore.com

