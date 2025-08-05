Return-Path: <linux-kernel+bounces-756936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E55B1BB36
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38BC67A5941
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D91E274658;
	Tue,  5 Aug 2025 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dtyU/vD6"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4034A267AF6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423866; cv=none; b=G3EUMwqUN5RWdR7C7uWh0tg1cJEQu5lH9oUtcA4gHNhIl6KOO8ClX3kScoqkznxya71IP8WNburNyfoV3twMafaXqsEXv8UNt5kKxf86SDmc+FS7gmYktAVK9LSv+bio8zsdONVZfYkR8G6pPJkSULm/PmUpR1QI8mALzUOOLQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423866; c=relaxed/simple;
	bh=bC+zFzhWtUviZ0EXWS2t+T+yocqJQ0MUviaN2AZtakU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUFqceIFh48RZ4XvBkQIi0a4sRaZSYoqJcB9aN7QBYsCrV/ChQZ5GySHhPikaNzihm8eWv2ny7bgFZ8GVB23j5Sq4Pdh8NPEoji5WHgPxAIuMszspqfeb2jphclNFBlWhzBVC4B45gs3uvxPSK/4YBpLYq7a7GoZMN54vhcO9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dtyU/vD6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32128c5fc44so226938a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754423864; x=1755028664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsxTPw5w3dvOw6Du0TNqYhfP8nKYvG4y7TuULGIfs2w=;
        b=dtyU/vD6+eUz45Iyhye/qTCtmvMAoYhAC7zSJ0HlBeLv4YQ9+UaRn7FwQF5iW3pRYo
         m5v8aNBBbf6Xq64Z8L+Tj7lxKh/R2L1ZsHb7GAEouqxLuAtAzrspBYseiteczUHqlFly
         t8+Itvu7oT3b9sJDJMkMtb5Mup7NL5fcqAxMW3fFx8u56gpg7wyfCO8IWkru0rQliSM5
         5X2GFA8zN9qovslm/EAKJMezGdw8skGJte8nMzVXoIrs3VVdXNY1+9stwGHtvkHo0Mwh
         FByMGHDGTe11MpNxk83DqvoQjxFpu0Z918wXVrVdZtFBFO/XthIkANdrsaRPxQdxd32L
         NZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754423864; x=1755028664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsxTPw5w3dvOw6Du0TNqYhfP8nKYvG4y7TuULGIfs2w=;
        b=UgE0Vk9X93Uduu6lgADz/hu75RdifL4KKeb7U8t3UziYsW+wvPAsaMrlXy+ayU8l9m
         iVLpM8oSi7O8A8owcJKg14M7SnoOym2G4M0PdYi7Vmsf7mPGjKqnafsM3/r6EED32vB0
         ScHNFT9PBhT8AvXinglfQ1SjYyJhcKifx1tDPjeqJxIIAdSqJsmJhn+3N1qelGkAzjYN
         yR6QhNHDKczl1D2xbkAGOlOhY173E3PLHij6gIhDA1ZQM8etsBaDMDXVTQ0kFR7Jddcd
         2rHWX43UauxRJ11gf5COUrErQA19MBZpbkBcmsvsh2OdR1rq3I23jkvb/etQ+5iju72W
         6fbA==
X-Forwarded-Encrypted: i=1; AJvYcCUohumEHdp82pzJI794NPB98J15xrcsGW9AC5gwhnzRnch+s0eXsHsCiuLCYe3QDP7lEopsgljb5i1dDKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHstS5ih9TdmM/uuUuVG44HFLa4HycktxgGcQRXPq65GCEOQfd
	JEDyE4xRTFDeIQYYrW3PE2rRqU7DrS58KN5HDhQe+0jpZ4bHQVPVqWq3GU2j8qMHQ7o/pbIRD5t
	c2UpoWTEPOH4KAKWiWKnlpoA9Zf1AJk2evkjdAYQJ
X-Gm-Gg: ASbGnctbVFZtkNQykgBK6aP5wlKxR5Gcj6PE4yPvAxZ3chVPyecdtSJ9S6xAJgrGwtO
	0zDJeacUFRkCuz0w0Zl38UhLK1AoygqVB8gXoI7Dqy93TpB+jvOK/n9GZ8GyBxsGjvtaOR4he7O
	+yWnlVZJeae7bYq8LYMDHe5vv48ADrjYpvRy2jOic0CnSjsoKlqDeoBLaHdURx7MXgksOGVDGVK
	muVoN8=
X-Google-Smtp-Source: AGHT+IHKu8z9XhICdXETPTLsS+z0RRZ62+RDpW21sm8v0pPvwaiLLnpAF+0jPbMODlNzNNx8b8mybw2geegLclSoToQ=
X-Received: by 2002:a17:90b:53c3:b0:315:9624:37db with SMTP id
 98e67ed59e1d1-32166853c96mr228245a91.3.1754423864335; Tue, 05 Aug 2025
 12:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718203734.347091-2-thorsten.blum@linux.dev> <CAHC9VhSa_9cWiLfOUNiLPUa7PyECF-2hqzHZikYHj6QeYGMqEw@mail.gmail.com>
In-Reply-To: <CAHC9VhSa_9cWiLfOUNiLPUa7PyECF-2hqzHZikYHj6QeYGMqEw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Aug 2025 15:57:31 -0400
X-Gm-Features: Ac12FXxf9GFYvD_gIJTvIFf5uHVEOE2KFf8JM43Ns-i9kOgsOlIelGwqX7VSTXc
Message-ID: <CAHC9VhS87wfk9j9_yzUNP-NaKOBL-YctvBLx_O4OQS2WVQ-OCw@mail.gmail.com>
Subject: Re: [PATCH] audit: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Eric Paris <eparis@redhat.com>, linux-hardening@vger.kernel.org, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Jul 18, 2025 at 4:38=E2=80=AFPM Thorsten Blum <thorsten.blum@linu=
x.dev> wrote:
> >
> > strcpy() is deprecated; use strscpy() instead.
> >
> > Link: https://github.com/KSPP/linux/issues/88
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  kernel/audit_tree.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
>
> This looks fine to me, but as we are at -rc6 I'm going to hold off on
> merging this until after the upcoming merge window.

Merged into audit/dev-staging for testing, audit/dev will happen after
merge window closes.

--=20
paul-moore.com

