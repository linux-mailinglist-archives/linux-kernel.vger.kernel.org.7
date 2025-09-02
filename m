Return-Path: <linux-kernel+bounces-797208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9563B40D5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E826C1B2325D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06AC34574E;
	Tue,  2 Sep 2025 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fx1s+z/S"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C88285C82
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 18:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756839170; cv=none; b=kjD5EgynIT7PZwe0yx5iMI6t7TXfzCU6B8Qyz+k9Dk+Fu9trmW43pfWKzFhp3mwKJYp8syOxIqEtZtZXEbUykYs+BRY/5C7SM/TcQdUH4ag0gGGh8lidvhk0ZN7olthv14h0bMPKJq9LLsmE5z1cdCKM/kCACEcm1Vwb6Zia2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756839170; c=relaxed/simple;
	bh=fr7XTb8icgTgStQB1vrTEUr1xcJEqpWSb5+Jkocg7DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqaDGYbWsjth9Ph9Sfb9ht+kG3p/f+ClWO0WZU2YL/HUyWXMv6TYEW+U26I6sYJv9fxvLqol8OyBxkL6X4J/BkN61rKdIFWDkXwbm42ugaykxluTxmvWynV/+VvwITiam67X1JfY9xVmptVj5Ht5CkPseKhoJlFpMecCUeWp8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fx1s+z/S; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32326793a85so4571332a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 11:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756839168; x=1757443968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUfEfExsv4Z4JExYVeI/bpLS60sngib6QHvkE0J/awg=;
        b=fx1s+z/SKoe+ljrmqDqR/AHrXf6b2xFMnbhbr6b9pRHIvtNxJlFc482OjB1mljjN++
         RDlBR5tdeJ5PewL1fphBxqXyXdtd+G66z5acFhjo4owUjOLgVs6Qh/890k18V+lCm5Ry
         QI5el9mmBp+MYmdgjnPSRZNgzoHFC3RscjAxKMF7GYjyCEkOK1JAlTTi8vRmTIZ5XCne
         dZCfA4c7eZW8Cyt1/Ve1I6V5jeWHuS5MAnE9DSs11hmCbkUk9vp+l0QW9lvN5abAuF1W
         32yW8DBEwEcp0SxVNotQAHcRG5fvSvDDgIsShFQJ/EJYe23vyL3fI96h8mlQvjq9xunm
         Shog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756839168; x=1757443968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUfEfExsv4Z4JExYVeI/bpLS60sngib6QHvkE0J/awg=;
        b=jZIiBgEovCMsbQaipB9rsWCQWjNjP8TdfKGxcKdfmQ4wIx7gygKD7OH5uAUPaKovxP
         av8U9ESvg99GYEtoSnd+1TRI+76yK1bfAb4xk8CXz+RpWQBhy4aYyeSGN0cZLpTMIAZE
         1+7RVeokaostXc+HZ0wMiZEnNKIPexRCucPnERAdp6RbHWe+JhzvZ2J9wx5xZ+0rxzX+
         yvma3uQVC72cfgEEmLY7QKf314EEnETfkEkF9yHlxFo16YbfFnQRHmBaTQWW7CkA8Km5
         xdtvkDzhdBhy3pUYYiG9wFqWb2mwxpSD8sHj8IsgF+CqegE3snMbiw4AebNTTqQpTYBP
         4Crg==
X-Forwarded-Encrypted: i=1; AJvYcCXk0R/x49EhDDP+0wAqWBgNcwgFds5HUXLBlePXQEImsyx5guuD+l9T7jTYrguOdANpDtG+Rmg9LJHgISE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUjXtAkr73Qc6MpZFkrgoTZTckYaJAtBcra+Dp5CNG3Zbq6K++
	xpGa18TX6S7Ghex7GjgOCjT5FqL5PHIq0/efwoaL7wGksjevsDwRAxNyQjJC1ErkHs1+98/kf7m
	Y64xV2WQt95AZ3tTUJA074S1X5OKcVuiCpUk9qzG2
X-Gm-Gg: ASbGncvUexacR700vf4/z7B1dl2orACr3e5MlOgnrZmTyGSBrqyHwfVTq27p/I5dUlY
	JhtrfylHgm0RIo1/5QVjoY2YKZdXuoUXXsgnblYCvnDqAKB6A3n4lXyRt0o8UPI3xJIUYohLU2Z
	X1de6UdrHOsVlGJa1uJdgnkzPA7Hi+9UDlcFZQrdZrfHA+ooVW0YsXZNp4RzR1A0YssGehUbTfk
	5rjpE4=
X-Google-Smtp-Source: AGHT+IGc/tElwygvDdKTlYySO7qXJLf9sHKlds8hH12yn8duF1CFLBxwB+Ce4DYuyOC7qDDzBWrnuHn3cqjkCkYBF50=
X-Received: by 2002:a17:90b:48cb:b0:323:28ac:4594 with SMTP id
 98e67ed59e1d1-32815414089mr13758791a91.5.1756839167864; Tue, 02 Sep 2025
 11:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902110049.4437-1-disclosure@aisle.com> <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
In-Reply-To: <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 2 Sep 2025 14:52:35 -0400
X-Gm-Features: Ac12FXy8XdXnZE9C0slRKpG3WzWsuHhhZo5xmbrDdxHDLPKkaXJ-L6LVm3df_zY
Message-ID: <CAHC9VhRtXzSGafaqLm_EDq=rj4BhDaOkaS0uJ89W-Scw2Zyxuw@mail.gmail.com>
Subject: Re: [PATCH] audit: fix out-of-bounds read in audit_compare_dname_path
To: Stanislav Fort <stanislav.fort@aisle.com>
Cc: audit@vger.kernel.org, torvalds@linuxfoundation.org, eparis@redhat.com, 
	security@kernel.org, linux-kernel@vger.kernel.org, 
	Stanislav Fort <disclosure@aisle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:50=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Tue, Sep 2, 2025 at 7:00=E2=80=AFAM Stanislav Fort <stanislav.fort@ais=
le.com> wrote:
> >
> > When a watch on dir=3D/ is combined with an fsnotify event for a
> > single-character name directly under / (e.g., creating /a), an
> > out-of-bounds read can occur in audit_compare_dname_path().
> >
> > The helper parent_len() returns 1 for "/". In audit_compare_dname_path(=
),
> > when parentlen equals the full path length (1), the code sets p =3D pat=
h + 1
> > and pathlen =3D 1 - 1 =3D 0. The subsequent loop then dereferences
> > p[pathlen - 1] (i.e., p[-1]), causing an out-of-bounds read.
> >
> > Fix this by adding a pathlen > 0 check to the while loop condition
> > to prevent the out-of-bounds access.
> >
> > Reported-by: Stanislav Fort <disclosure@aisle.com>
> > Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
> > Signed-off-by: Stanislav Fort <disclosure@aisle.com>

I also just noticed a disconnect on the email address.  I can leave
the Reported-by email as disclosure@, but do you mind if I convert
your Signed-off-by email to stanislav.fort@?

> > ---
> >  kernel/auditfilter.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Thanks Stanislav.  It looks like this problem was likely introduced in
> e92eebb0d611 ("audit: fix suffixed '/' filename matching"), I'll add a
> 'Fixes:' and a stable tag.
>
> I'm building a test kernel right now to test things, but did you
> verify that the path matching fixed in e92eebb0d611 still works
> correctly?
>
> > diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> > index e3f42018ed46..f7708fe2c457 100644
> > --- a/kernel/auditfilter.c
> > +++ b/kernel/auditfilter.c
> > @@ -1326,7 +1326,7 @@ int audit_compare_dname_path(const struct qstr *d=
name, const char *path, int par
> >
> >         /* handle trailing slashes */
> >         pathlen -=3D parentlen;
> > -       while (p[pathlen - 1] =3D=3D '/')
> > +       while (pathlen > 0 && p[pathlen - 1] =3D=3D '/')
> >                 pathlen--;
> >
> >         if (pathlen !=3D dlen)
> > --
> > 2.39.3 (Apple Git-146)

--=20
paul-moore.com

