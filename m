Return-Path: <linux-kernel+bounces-825819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AF0B8CE07
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5D3173910
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977130F7F5;
	Sat, 20 Sep 2025 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3dI/wao"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A81086331
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758389858; cv=none; b=slVc8E2aUkyD6jCSee2NJGz1IG6fuvp2CWDPkPReHvhGJsqG/H9OyGhLSExbqdfWLaiyJPyZva7c1RgLsNwcJoK4yRS8Dn0h/OFytHxMLP3ZJw43T3EKNKz98jUrjDd+2UW9P0xxXxY4dF/inGC6A1sbEK0NMN56VKSc6USMY/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758389858; c=relaxed/simple;
	bh=f+nAcxABZAbrauxy1frHe6eUcCNFVf565g9JEMRH99U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j8sAI+A7J+IMGxmH8KdHkv4oCKcQUiX/u/KNtwz7QR4dVNoZdZH6H7wdYmWDJYWQ4MdOPJL9kuacvMyqyRXNuL7pR1SRh4yDcHjj3Jj/aYWnQ6ae4qLHzJZX2V8MY0fuwpN5NXb4osnE0Q+co6WI13EtpbDOER3gKkPtUDYPGQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3dI/wao; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-78393b4490cso27325966d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758389855; x=1758994655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbsx7rUmB91XIm5gWKsYjh9edIm3/1qRqxHrPjtMuIs=;
        b=E3dI/waovTG7snS3wHhf2mgQIjU8NydKx89hKxAnDEXnxCrF9OiJnTWxd62yQ9Cce+
         kCSJzxDJ7kfd3Xfqd50060SKX7J7/m3m33CnV/k+w8Xum8RFTlbyHfhJO79wDIbEqXrN
         apcl+MRWSjj/arE6GVp7J7pSJmyGqvVybx8Cg3wDZ26lym2op5cuLqp9m61cS97DXZvc
         3qMcktKoAkSC2oETu+a5nrv57D5ZqplzjJaUUHRtTHCn+GghNmTQ/AXJuDr1IkGr8A2C
         aPD6koR/PC1HSCOhpvuLwfEBdOwFGQEno4eTNmXPSjLTw1oknRkBaFJtgwzq1jzoQc+f
         gysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758389855; x=1758994655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbsx7rUmB91XIm5gWKsYjh9edIm3/1qRqxHrPjtMuIs=;
        b=OjcTtvBhSpE9pYbuWpREn0GbF9P60Xk+YwEOeW6Z4b+aYcolO/mVI6r4bfUBT2P5NW
         zb8dB5nyq/qvifpC9+yQ/Mgv4XUZBF8qPgCxsTpL1O2vIwtO88GaPVZ1t2okF+8h3Ni5
         51KMU5WJhfUINvBpOmLXyIwMLQ7abBpFD03aA5llbPIVlhJijo5/cmsUHQCklDQ8aPp6
         WBieAt3pAdZssLjYL0RFCFIYCJ15Xj7wBevTXWA5iEcX4wxjJ0mUyYys/saerzEecpCa
         AsEPYQORb75xyDJcyQIZZApArOsYU1Jaq4jh3C430oradJPOKiMp5iNKdnX7C5l7f6zY
         JeoA==
X-Forwarded-Encrypted: i=1; AJvYcCXR/jAAFaFaEwSDLNMHrJxLKUi6Sc4Kluc+L59qACkipIKpCg7VxAcf9VBDRuBdQJoysndy3vZ+gOM/DhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlIAhzksUWjN9Uf778VvFKQ3tLT3eDyhSx/phximvoghA0SyeB
	xxIGY51z+qg6tdk8YY33mvZV6UvI0LY53fpg5P1s4zWEWQ9HvBbPNv5zmVeY82CAB0Twu5/wH7O
	ooc037cXsXX6CAF0ooKR490dzTc4druI=
X-Gm-Gg: ASbGncsN1ToLokmV9bgX/hbeIux7OI1YZdgiUOclQeGM0gF15+edF8ObCj8IeDUCrn6
	xzwt8Ff+Efwohf6E4spdwYnTair9jR0jWASfJPc6piWeiAX1KNKOHenenSyyezz/xFZho1gM4Oh
	/nNr/eb47zS73rRydY4LQMAIuZQVmKea3TQlZ/+Q3xCBMb2NLMc2e9mWpr1u6AgiJcr8m4CCXCA
	g2B4YPfN17juQEQ6ZwUXN40pmzoapjR0h5tMsX9baAbpe6zp4ptN6abcVzSJ/p/324FYbyIkbO9
	+u9lMxzcwkjmq7cvuccPAqrM5IEC56f90VofDkPb4+tEpP7J4kqSF2FZous9OKDFDXo8aLU5tmv
	Prp8/88CoBXAFrAs6LBD5
X-Google-Smtp-Source: AGHT+IEGG/+DybMY0xWLcKMJ4e4xoQe1Ku4mr7qRXc/75fg96Yh4+/j5dqHLlbHCvMPSUlGVuSawtjaX2U4cHWHYVcI=
X-Received: by 2002:a05:6214:252e:b0:7b6:5b28:6324 with SMTP id
 6a1803df08f44-7b65b286515mr17533506d6.48.1758389855275; Sat, 20 Sep 2025
 10:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831123602.14037-1-pali@kernel.org> <20250831123602.14037-29-pali@kernel.org>
 <CAH2r5muoF-OKg9e=T8moEifwJ+RwmGX28nXqgECM891TufqY_Q@mail.gmail.com>
In-Reply-To: <CAH2r5muoF-OKg9e=T8moEifwJ+RwmGX28nXqgECM891TufqY_Q@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Sat, 20 Sep 2025 12:37:23 -0500
X-Gm-Features: AS18NWAJekJFB_NLhgKjRocfWNcpOd3jLrYXMXU90vSTnV4EYdBzw7k6k57ufJc
Message-ID: <CAH2r5msw5+TxRRO7Ap9eaQX2W4AbZ4bqRHs=0Kv9O1mjV6TvBw@mail.gmail.com>
Subject: Re: [PATCH 28/35] cifs: Fix smb2_unlink() to fail on directory
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	ronnie sahlberg <ronniesahlberg@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

And of the remaining patches only 2 apply (patch 33 and patch 35) on
current mainline

On Sat, Sep 20, 2025 at 12:34=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
>
> This did not merge to current mainline
>
> On Sun, Aug 31, 2025 at 7:37=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org>=
 wrote:
> >
> > unlink() should fail on the directory with ENOTDIR error code.
> > Flag CREATE_NOT_DIR handles that.
> >
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > ---
> >  fs/smb/client/smb2inode.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> > index c8b0e9b2438f..c69293fcf26c 100644
> > --- a/fs/smb/client/smb2inode.c
> > +++ b/fs/smb/client/smb2inode.c
> > @@ -1348,7 +1348,7 @@ smb2_unlink(const unsigned int xid, struct cifs_t=
con *tcon, const char *name,
> >
> >         oparms =3D CIFS_OPARMS(cifs_sb, tcon, name,
> >                              DELETE, FILE_OPEN,
> > -                            CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POIN=
T,
> > +                            CREATE_DELETE_ON_CLOSE | CREATE_NOT_DIR | =
OPEN_REPARSE_POINT,
> >                              ACL_NO_MODE);
> >         int rc =3D smb2_compound_op(xid, tcon, cifs_sb, name, &oparms,
> >                                   NULL, &(int){SMB2_OP_DELETE}, 1,
> > --
> > 2.20.1
> >
> >
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

