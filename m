Return-Path: <linux-kernel+bounces-761310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D854B1F850
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 06:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83C916F122
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 04:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D701DDC33;
	Sun, 10 Aug 2025 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=bzb.us header.i=@bzb.us header.b="qcXffIXK"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ED41C32FF
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754799990; cv=none; b=ItsUoyhjkq5Ao3B1poxUwhBN8+ppwU+cgjZcyetgAGdAw6PP4fL0ej2dS191dR4eLE88K3LhJfBNst7RGnCzWZVnTfSfYp0LW4lKV3X6M1Yq0wU+piw1la87/GEdjls0t3/lAWBXYUApBAaKOV6Ep2EXm1QMIbiAUGh/0BnU6vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754799990; c=relaxed/simple;
	bh=3LA7Ng8TSAok0xn7Or4v3/cIxwxUR2bJOPI5C0jqJ8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLZHGR/0X+4uqFHIO9dWUUpC68wW/4flBaCBME3kcmBVZuQkNeYViNCEkDaRe6MI4yK9D8VOOEghTgvjnVT5H4kcjAF6q0PwNx5CulywhEEXRb3dhw/XrVbKphUI6EIzBmmLFtLcN3Ab9f27g0m8N2eaXka7mevjEH2STTen/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzb.us; spf=pass smtp.mailfrom=bzb.us; dkim=temperror (0-bit key) header.d=bzb.us header.i=@bzb.us header.b=qcXffIXK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bzb.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bzb.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so1945013f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 21:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bzb.us; s=google; t=1754799987; x=1755404787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jGDWjyjBJhM9wQiN647/+Zgk2ZcgExRH6T8Wpd9Bgpc=;
        b=qcXffIXKMwe4Oekt9Lsoni+iGyYyZ+BJjUYpyvzSyqlQ+4CxvC0IIpwIZ8Euys5yBP
         W+uZvJiwKWgTEdQ3Vvje8bd2E8JtTakhhDQOpUm6ZrTTxzHwR0p0GXnwKsQS4rtdrujl
         e+ISb2oz3izMufBLx0dyIiqgNGZsnezzTtGiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754799987; x=1755404787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGDWjyjBJhM9wQiN647/+Zgk2ZcgExRH6T8Wpd9Bgpc=;
        b=QngJjj95Tgc3b1eG9ZvyxHxVabeR6Qpb/7In9wV3zrtiAPmycB+0FH1mA1FtqhOAo3
         PsBD7ttLhSuWsbXldh6te5yUKTWo9J1xFbXZkD2dAPeF+1AsZcUISuN4Py4Ai19D15PV
         gv/LrKP9Ep1yfhucGP5QdURndkR74ngfJwZJnQDLAFJmPwNNnSxjUJ0txY1xJ4kzq0/f
         gnmjh6ln/pQYn4W9KhvNRGNvh6g3ZMh+VVdE9PWCleyEiKS9n0G0z48Jk30Hz4WZ/j0q
         PIJk/m+9M2uWKgg7VYcHxrZ7zG8tNm8buvXLccF38rfFSqKRgSi2OxWDOzTHsnReNNf9
         B92Q==
X-Forwarded-Encrypted: i=1; AJvYcCWg7Qb3Mha71iGQ9aOnXpxd0WO6cSz0Y6hV4a5J+6XsatSEjV2WFh8O66GJASeQDdkJOJeLSgZXV/P5tOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqGUhqBASS2aT4TdLXnsgoR9Y2OVTT4fn6g4kWbn+YpjDlpcDA
	Qzk999ksJhYce74+5Bu3RYoMDJoMcFIbMjejjuj2nbZ1lSq52QDI/QAV6YsQbNM1NqthvmGx1lF
	ejcVHbKUfe5hkk7cWu4ubkqrGRI+LnS4Bk1kJl4XCIToUOwgklni/DJy6hIU=
X-Gm-Gg: ASbGncvaHLZWg1OpG0EWNa5+dNCvSpBFtMTKm77WrJPRuXOa1PttfL2YdvILiwDRtdw
	G0/OB0puyscs0YrcH4EbqVNdResnUpA7lSPTD8LjUd9QG5WiqpE8aOrRth2LHcdDqigATtQB9cb
	Ctm+uuiaTErENTc7tIaf6KsKPwTaRPXOBg54kab+wQc3nE5RzukDHkoh9fbgyKu6TFcLk+lExZa
	DQlB7Ozgfnb2TKKJFu5AA==
X-Google-Smtp-Source: AGHT+IECf34QYnq+qFyTTyTWU55ortyPh0/KIn0nb0Ad3XIWD9baxVYxuJTHnMeGk+9I72vtgX6Q7R96n7/N89C3SXs=
X-Received: by 2002:a05:6000:40de:b0:3a0:b84d:60cc with SMTP id
 ffacd0b85a97d-3b900929b68mr7176106f8f.2.1754799987023; Sat, 09 Aug 2025
 21:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de> <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf> <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <20250809192156.GA1411279@fedora> <2z3wpodivsysxhxmkk452pa4zrwxsu5jk64iqazwdzkh3rmg5y@xxtklrrebip2>
 <20250810022436.GA966107@mit.edu> <k6e6f3evjptze7ifjmrz2g5vhm4mdsrgm7dqo7jdatkde5pfvi@3oiymjvy6f3e>
 <aJgaiFS3aAEEd78W@lappy> <2e47wkookxa2w6l2hv4qt2776jrjw5lyukul27nqhyqp5fsyq2@5mvbmay7qn2g>
In-Reply-To: <2e47wkookxa2w6l2hv4qt2776jrjw5lyukul27nqhyqp5fsyq2@5mvbmay7qn2g>
From: "Gerald B. Cox" <gbcox@bzb.us>
Date: Sat, 9 Aug 2025 21:26:16 -0700
X-Gm-Features: Ac12FXx95iRXPofV89p1jKM4bxRaBM3h5-G_I79CiowbJtQgdkM_Z2ChodqsGgc
Message-ID: <CACLvpcxmnXFmgfwGCyUJe1chz5vLkxbg3=NzayYOKWi4efHrqQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.17
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Josef Bacik <josef@toxicpanda.com>, 
	Aquinas Admin <admin@aquinas.su>, =?UTF-8?Q?Malte_Schr=C3=B6der?= <malte.schroeder@tnxip.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	"Carl E. Thompson" <list-bcachefs@carlthompson.net>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Please excuse, sending this again because I forgot to put in plain text mod=
e.

Been watching this thread unfold. There are valid concerns, sure=E2=80=94bu=
t
I=E2=80=99d caution folks against mistaking frustration for hostility.

Kent=E2=80=99s been carrying a heavy load with bcachefs, and it shows. Solo
stewardship at this scale isn=E2=80=99t just technical=E2=80=94it=E2=80=99s=
 psychological.
When someone=E2=80=99s under pressure and feels attacked, responses get sha=
rp.
That=E2=80=99s not ideal, but it=E2=80=99s not malicious either.

If we=E2=80=99re serious about maintaining a healthy kernel community, we n=
eed
to be better at recognizing when someone=E2=80=99s burning out=E2=80=94and =
not make it
worse. The CoC isn=E2=80=99t just there to call out bad behavior; it=E2=80=
=99s
supposed to guide us toward empathy and restraint.

Kent, if you=E2=80=99re reading this: it=E2=80=99s clear you=E2=80=99re rea=
cting to what feels
like a pile-on. That=E2=80=99s understandable. But at this point, stepping
back might serve you better than continuing to reply. Let the code
speak. Let others weigh in. You=E2=80=99ve done the hard part=E2=80=94now g=
ive it
room.

And really, this whole thread feels beneath what the kernel community
should be. If there=E2=80=99s a serious question about bcachefs=E2=80=99s f=
uture, it
ought to be a quiet, direct conversation between Kent and Linus=E2=80=94not=
 a
public spectacle. We=E2=80=99ve seen how these things go, and it rarely end=
s
well unless someone redirects the tone.

On Sat, Aug 9, 2025 at 9:13=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Sun, Aug 10, 2025 at 12:05:28AM -0400, Sasha Levin wrote:
> > On Sat, Aug 09, 2025 at 11:17:44PM -0400, Kent Overstreet wrote:
> > > On Sat, Aug 09, 2025 at 10:24:36PM -0400, Theodore Ts'o wrote:
> > > > And how did you respond?  By criticizing another file system, and
> > > > talking about how wonderful you believe bcachefs to be, all of whic=
h
> > > > is beside the point.  In fact, you once again demonstrated exactly =
why
> > > > a very large number of kernel deevlopers have decided you are
> > > > extremely toxic, and have been clamoring that your code be ejected
> > > > from the kernel.  Not because of the code, but because your behavio=
r.
> > >
> > > I would dearly love to have not opened that up, but "let's now delete
> > > bcachefs from the kernel" opened up that discussion, because our firs=
t
> > > priority has to be doing right by users - and a decision like that
> > > should absolutely be discussed publicly, well in advance, with all
> > > technical arguments put forth.
> >
> > Kent,
> >
> > You say our first priority has to be doing right by users, and I agree =
-
> > but doing right by users means maintaining a healthy, functioning
> > development community. A toxic community that drives away contributors
> > fails its users far more severely than the absence of any single
> > filesystem ever could.
> >
> > Look at this thread again. Really look at it. Neither Ted nor Josef
> > raised a single technical argument against bcachefs. They didn't
> > criticize your code, your design decisions, or your engineering. Josef
> > explicitly praised your technical work. Ted has repeatedly shown respec=
t
> > for your code.  The discussions about potentially dropping bcachefs
> > aren't happening because it's technically inferior to ext4, xfs, or
> > btrfs. They're happening because your personal interactions are
> > undermining the health of the community that maintains all of these
> > filesystems.
> >
> > > "Work as service to others" is something I think worth thinking about=
.
> > > We're not supposed to be in this for ourselves; I don't write code to
> > > stroke my own ego, I do it to be useful.
> >
> > Service to others includes maintaining professional relationships with
> > your colleagues. It includes building rather than tearing down. It
> > includes recognizing that a healthy community serves users better in th=
e
> > long run than any individual contribution, no matter how technically
> > excellent.
> >
> > The kernel has thrived for over 30 years not just because of technical
> > excellence, but because it has (mostly) maintained a collaborative
> > environment where developers can work together despite disagreements.
> > That collaborative environment IS doing right by users.
> >
> > No filesystem is worth destroying that.
>
> Then can we please drop all this madness?
>
> I do hereby solomnly swear that I will refrain from critizing btrfs ever
> again, or any other code anywhere in the kernel (if that is the wish) -
> as long as Linus stops trying to dictate on patches internal to
> fs/bcachefs/.
>
> If it affects the rest of the kernel, that's fair game; I just want to
> be able to get work done.
>

