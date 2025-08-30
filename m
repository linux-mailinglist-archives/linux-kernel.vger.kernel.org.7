Return-Path: <linux-kernel+bounces-793050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF177B3CD1E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 18:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A254E207BCF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 16:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE35225A65A;
	Sat, 30 Aug 2025 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6QryqFZ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B671E502
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756571423; cv=none; b=K4KIxt1b84Q0o+5F+JqcWEoqjp+2O1qk2cWHIWocnp5JzoPJ4h1al3XxOK9fZ+xiyr7wz2mTUmyRVd27oIf2llo72TGTYVje0hvB1gHX7TxPlt68moVJYzfyRI2s7P7o8zY8GTHQ+oWuCTdWhg2QyzVlnfZv12hbB5Jk3T0oja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756571423; c=relaxed/simple;
	bh=95YJk9FJKwCZrx8HSVdXZM/8tKRvGxjoLSL85Ocdu+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqbQLwP0t0vuKhhelTWofG/Td9ITMQEZqhvNUrn1dhpIF8Nyn9xBGsI59EmxYaeifGXMhVqAcW9/DKYtP5jG8a8yizEJ916d5A4rE/Rs7xS5OCToAHM8fPp/h9y3QISyVs+GgBn96+47EuBesE/VFQAjcdr2tuFwc1eBAeDXg7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6QryqFZ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24914277174so3482635ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756571421; x=1757176221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6vQxSWpXv081OJaX5WpHyCgAtx4LnI6eb9ZG6e+nyI=;
        b=B6QryqFZz8TeFwYe4dSMWY3uwW6HekquKMrciqiaymF8ERvcxnYuIcdbp6/YXrtT7s
         aLUrjjx4DpbLp1tzHWNURBsP8VBAsKBM6WH4bv416gIYX9xUCcLCAE0RY7oKhRrwPDd8
         aSUh5CCIZzGPww1oZIhTI+4/hUNlFZ3gyYyDDGW/NckBS/pgS11ixuMx0KOxoL7SZg+P
         t6jXdER3qu4/RXVQroeXs3wAxRKDNtrI/HjVLdLBO1HfV8cnXu4P/qe3CLs3eAJ2oSDp
         W9tcKTOHZXYo4yh2bnQuVgLMEtS54EL5FjS6kLeYo+2gFFLQVpKA8sMOi4ddhhAI2QJN
         jQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756571421; x=1757176221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6vQxSWpXv081OJaX5WpHyCgAtx4LnI6eb9ZG6e+nyI=;
        b=s9XiB6+vW1WRA6W/+i0/10dRlmzvllh/qRDOze1d8K3PNssFcjDAPt+tnGI1XM5xj6
         NSvLAoChCSZ1RlAaW2Na8/8tB0BtwO1llbOE3E2DNDFyMTqUY0NqcFdSEDDp2R9jvfYC
         VO/EPwEVyJPSZofiWccCo4wl6p16h/v/4R45MKxKUWb1wqPjYm5Ifgg9ftEvyKtsLNQy
         c4B5YlBzvSPzVgYaPFxg2b/f/zbacFKIJ+iHpGdl5tsfpKaWGDQw5c/FUUhLy/SuBBg1
         V8w8I8erG7LXzn8SqCAfO/X9JKRtKnvvv7/6YDh+5TOQ+qOqLknFAVuaUgs6ND3Uzdne
         CsSw==
X-Forwarded-Encrypted: i=1; AJvYcCX6WsSXaau87XYRrCxDHWg9fOFw7ey2DdvCGxDwr/2RDWJfwtkD0ExQ6TpfvlKoz0EkVxHjBb8FSVruz2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEPSqh4KnSWw3w6wT2pnaAIzTHFXZxCb9g5VzRIty7QIG/oGVZ
	MYoFEgOsRiLNwPUsIPjfDQPoJOAYEL4g3h7WZw9FEceJwERir0lYYYkouwMau7fYwFHZhLRG3DY
	8G2ZheXX6thLa6fIXYHFABYwLFUTbPTE=
X-Gm-Gg: ASbGncvxnbB7RJzyYyuzKysP3KMhZ7NqG7dJ0tZ50x7Mr3BI7X7iJAM/pqkH5lg4f2c
	VNgd0ovapg+63JOjtcSzfiJAcIyGbkI6j0Y9ootVHVjZMmaOYEL/rTbMiXF/Q5RYP9U6LONbg4M
	UwJVTbIbsNoKT+wdaPq45pL8g3FuZFsIfxIdlxC1VM5TUnqbE0iA7w1CEgbtC7wfBCoRkkiydAl
	VF1CJSR/LmoBXAHvg==
X-Google-Smtp-Source: AGHT+IEnp0d/ox7MyiexYDelNlGYh7sEMDDp2slpUX07DsrohYDyYv1UbHQ45FvZIJGo0w2AJujwM103aJpmxC+Kyc4=
X-Received: by 2002:a17:902:f687:b0:246:b3cc:f854 with SMTP id
 d9443c01a7336-2490f6bd83dmr45834285ad.2.1756571420577; Sat, 30 Aug 2025
 09:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829171655.GBaLHgh3VOvuM1UfJg@fat_crate.local>
 <CADnq5_Oqonrth+5T-83dnFBZ67GvykkPt-9aUepJd+fUMwnupw@mail.gmail.com>
 <20250829194044.GCaLICPKJcGJRYdSfO@fat_crate.local> <20250829204840.GEaLISKGTwuScnDF8Y@fat_crate.local>
In-Reply-To: <20250829204840.GEaLISKGTwuScnDF8Y@fat_crate.local>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 30 Aug 2025 12:30:09 -0400
X-Gm-Features: Ac12FXyuwaIKIrWWofmEszUvdbPoKCSxiOPEGd_tAh18Vtmvke3NVvLJZETkRRI
Message-ID: <CADnq5_MbpYmC2PSyOr0gQk7F8mVz0-LG3dZtUZS2HhV8LTgDww@mail.gmail.com>
Subject: Re: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource
 seems too big for the bo
To: Borislav Petkov <bp@alien8.de>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 4:48=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Fri, Aug 29, 2025 at 09:40:44PM +0200, Borislav Petkov wrote:
> > On Fri, Aug 29, 2025 at 02:26:50PM -0400, Alex Deucher wrote:
> > > Have you updated mesa?  Looks like a userspace change.
> >
> > Yeah, I did a long overdue OS upgrade today:
> >
> > $ grep -i mesa /var/log/dpkg.log
>
> Btw, this thing:
>
>                                 if (p->rdev && (size + offset) > radeon_b=
o_size(reloc->robj)) {
>                                         /* force size to size of the buff=
er */
>                                         dev_warn_ratelimited(p->dev, "vbo=
 resource seems too big for the bo\n");
>                                         ib[idx+1+(i*8)+1] =3D radeon_bo_s=
ize(reloc->robj) - offset;
>                                 }
>
> is yet another example of useless flooding of dmesg.
>
> It's not like I can do anything about it except report it. And that thing
> fires every 5s or so.
>
> You could consider turning that into a _once thing and be done with it.
>
> And someone already ratelimited them:
>
> 59d76d6bc206 ("drm/radeon: ratelimit bo warnings")
>
> but it ain't enough.
>
> $ dmesg | grep "vbo resource" | wc -l
> 22393
>
> So even if I go and find which commit added it:
>
>   cb5fcbd540b4 ("drm/radeon/kms/evergreen: add initial CS parser")
>
> I'm still none the wiser. And I'm not even a normal user - I have seen ke=
rnel
> code in the past :-)
>
> Hell, I don't even know what CS is...
>
> /me goes and searches the web a bit...
>
> Aha, it could be a command submission parser or so. Still have no clue wh=
at
> this warning is telling me.
>
> Going back to searching the web...
>
> ok, so it looks like this is validating some packet3 set resource thing a=
nd
> when the resource type? is a SQ_TEX_VTX_VALID_BUFFER - perhaps a valid ve=
rtex
> buffer? Vertex buffer I understand. But texture vertex buffer?
>
> Anyway, it checks whether the vbo (vertex buffer object?) resource is
> too big for the buffer object which has gotten as some sort of a relocati=
on
> packet 3 thing...
>
> And I still have no clue what is going on. Perhaps the new MESA is sendin=
g
> wrong command types, who knows.
>
> I absolutely cannot fix it - that's for sure.
>
> And so this rambling of mine confirms my old theory that the warning and =
error
> messages we put in the kernel are not really useful. Especially to users.
>
> Because there isn't a whole lot they can do about them except reporting t=
hem
> to those who can actually do something about.
>
> I.e., those messages might as well be hashes which we can stick into a lo=
okup
> table to fish out a longer string which tells us what is going on.
>
> So I *think* you should make this a once message or *at* *least* ratelimi=
t the
> hell of it so that it appears very seldomly. The rule of thumb should be =
what
> you want this message to do?
>
> To make a user report it to you?
>
> Or something else?
>
> In any case, I am already very picky with the error messages visible to u=
sers
> in the code I'm maintaining, this'll make me be even stricter.
>
> Oh well.

Yes, I agree these should be warn_once().  If you send a patch I'll
apply it, otherwise, I'll take a look next week.  For some background,
older GPUs did not support memory protection, so the kernel driver
validates all of the command submissions (CS) from userspace to make
sure the commands would not access any memory they shouldn't.  In your
case it's a vertex buffer object (VBO) which contains vertex data for
the 3D engine on the GPU.  So newer mesa code is sending a command
submission with an invalid vbo size.  As such the kernel driver
rejects the command submission.  This may result in subtle rendering
issues as the invalid command submission does not get sent to the
hardware.  I would suggest filing a mesa bug report:
https://gitlab.freedesktop.org/mesa/mesa/-/issues/

Alex

