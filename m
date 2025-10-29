Return-Path: <linux-kernel+bounces-876748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD80C1C7F2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB81642C42
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5207334AB05;
	Wed, 29 Oct 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iPkU9AQ6"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189F31E0EF
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755884; cv=none; b=EcpSU9ds98YxDDMAMvVirivAsR2X/oJWhOOM1j6CsQx19WbXrdFeucxTDj3DdyHclzMzWE1xcR0I+gAuo/giwBqMP5JFyJvlUUQ/Rql1qJIchMGZ7vSoXeGR7494AoHiKL6ZxoHT31jOOE1RSUnf3w7GTcxb6Hm5Zv9pUgKn+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755884; c=relaxed/simple;
	bh=mlipImmHMA+gUQirrassIMMrc6gdMm3abdf1zY6CT7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBC6+FQ3ZoKZ1BncHjamyqM57h6XbJ0BWj0RlW78iwkOlKFcc4bl0IsGTOPt5XcsTLYsIue1ESJApM2h/BkBTQ19msJHMseZq7kQHuevaB3naWh3rNq43BvZeZwiGRdbqj44o/qKvuME0dMlCb0JlNHbVYttnvmowEflQnMqaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iPkU9AQ6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c2b48c201so11741a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761755881; x=1762360681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDIJ8tol892ULVaHDJQvBrvWCdj4ospSO0ksso+IQTY=;
        b=iPkU9AQ6fYcburL7CERfBfsPkjSUL/rq6U4a1T8CULZZi0mNKFNS6VLk52ngwGB5UA
         GgH5bV6sXy+rNFS0LDbvTB+ir687axxPl5DkMS4YIunWigBCDeK/dpIA3mm2TXa3ZYUw
         ZCGpx9cpzV8SmWK1g3oXNc41gZv9OywBnEkrQDqP2pTfKyqzd5KvCscviX8KtEqHQpEF
         lPnJ/uEiD/aZG5yAznydCr9ZTPc038tUuYBn2Z4vHDWyNtdfURAOxjh7Lvc94w43yV3J
         7QZD1mM9L/xNgp/puWDRvVtXuA3gDxqGWeQz2wZsUsNrdS3zjObbx7xudIGl5/R9VkkT
         YdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755881; x=1762360681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDIJ8tol892ULVaHDJQvBrvWCdj4ospSO0ksso+IQTY=;
        b=rfQiMDHBYvmmORoe/SnIhnUM3xkrl+Ecn2DK1bfZIcQ+e+JmhSOWPmIeOrrs50zxQJ
         4VR2VITvedWAateCT69AqpoXt+69DY7bK1z572UAdOvKF1Mue7IiyrQd8quNK14JIxYp
         zXG9uDfOu7ehOP8u1bZFZ5fsr2bxCt+yXNvrlUi5RWFgi/3dSxuOntYhERvRhWRuBlzE
         4BSobOF413ABa3C9XAcxyZ62PjIJwnONdyhtQ0smgwEcSvFvx+/adGmV+XziOKK9bnQ8
         YFMGhOKQfLtVoGeAvuKUqSE1x2XpwHZdDl3HfcAB8duQWPqgKCA8VrjpTZO90ZR8wZ0s
         0Z4w==
X-Forwarded-Encrypted: i=1; AJvYcCXkYtJAJDYTXsodUg1GdUNnf0QCbTEa71t1hkxNYcWTHBcYXP57kSqsedqqnzIi0pSgDDGoxBaUuvguhqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfl954cTOshEI/QbGN8Y/eioJbK162wVGE1CPQGz714oiEjyZ
	yTGamJy6UEKMu6z1TYlldJhQRg6HfDTQOXTYkhd18cAqML2T4WJKcy/SnoZma746GSWmVNmnFXV
	sms31EivfPLqDmeTiHC+XKm5ORU/Y2kLR/A+5ChEr
X-Gm-Gg: ASbGnctHGo14m/ndPP1hI7yDo+z+Zm7qFdDei3XTAz632SiKOcDYJEinSSHRK9aOMIk
	I/frKS35o45zkxTsgsbpHeHiMAF2ctwiPcC2r6ueMvPcysY0nGJS9qf1GayHBU4zBJuLa7Umsdd
	XQkd2M0YWx9mGz3rhojRnIdR1el4lUcgtnBPZ0TVsPGuI114nQsccnfOPPSVe1cCJayx2kLgAC7
	tSnUm386pPdD+nNhh36Sa6Xu0+YzKfVuIAMteWspr/X31xz6yVCr4YkJCTWMioJmEb65Q==
X-Google-Smtp-Source: AGHT+IFfZzU2MThWZ5FgRnQl6W4DTilzVkUssFqzAnqhMoG9aNNRDttn+vvJvii8lde8hiLSpJv9QKk+lpt2Wo/wJkg=
X-Received: by 2002:aa7:d40b:0:b0:63c:2b0f:ced1 with SMTP id
 4fb4d7f45d1cf-640452ca7eemr93256a12.5.1761755880509; Wed, 29 Oct 2025
 09:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org> <20251028155318.2537122-1-kuniyu@google.com>
 <20251028161309.596beef2@kernel.org> <cd154e3c-0cac-4ead-a3d0-39dc617efa74@linux.dev>
 <CAAVpQUCYFoKhUn1MU47koeyhD6roCS0YpOFwEikKgj4Z_2M=YQ@mail.gmail.com> <9e1ccd0f-ecb6-438e-9763-5ba04bce5928@linux.dev>
In-Reply-To: <9e1ccd0f-ecb6-438e-9763-5ba04bce5928@linux.dev>
From: Tim Hostetler <thostet@google.com>
Date: Wed, 29 Oct 2025 09:37:46 -0700
X-Gm-Features: AWmQ_bmvtcCMHLAXSsrPNMniUXWYjF6o64mntG7qoIE2p1jGOb47Q3oJQkgZ4nY
Message-ID: <CAByH8UvEjnh2P5UQUuVw4G0JBkJoRLfZmmS6UbbUsA7htGqbwQ@mail.gmail.com>
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>, richardcochran@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	junjie.cao@intel.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:57=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 28.10.2025 23:54, Kuniyuki Iwashima wrote:
> > On Tue, Oct 28, 2025 at 4:45=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >>
> >> On 28.10.2025 23:13, Jakub Kicinski wrote:
> >>> On Tue, 28 Oct 2025 15:51:50 +0000 Kuniyuki Iwashima wrote:
> >>>> From: Richard Cochran <richardcochran@gmail.com>
> >>>> Date: Tue, 28 Oct 2025 07:09:41 -0700
> >>>>> On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:
> >>>>>> Syzbot reports a NULL function pointer call on arm64 when
> >>>>>> ptp_clock_gettime() falls back to ->gettime64() and the driver pro=
vides
> >>>>>> neither ->gettimex64() nor ->gettime64(). This leads to a crash in=
 the
> >>>>>> posix clock gettime path.
> >>>>>
> >>>>> Drivers must provide a gettime method.
> >>>>>
> >>>>> If they do not, then that is a bug in the driver.
> >>>>
> >>>> AFAICT, only GVE does not have gettime() and settime(), and
> >>>> Tim (CCed) was preparing a fix and mostly ready to post it.
> >>>
> >>> cc: Vadim who promised me a PTP driver test :) Let's make sure we
> >>> tickle gettime/setting in that test..
> >>
> >> Heh, call gettime/settime is easy. But in case of absence of these cal=
lbacks
> >> the kernel will crash - not sure we can gather good signal in such cas=
e?
> >
> > At least we could catch it on NIPA.
> >
> > but I suggested Tim adding WARN_ON_ONCE(!info->gettime64 &&
> > !info-> getimex64) in ptp_clock_register() so that a developer can
> > notice that even while loading a buggy module.
>
> Yeah, that looks like a solution

Yes, I was actually going to post the fix to gve today (I'll still do
that as ptp_clock_gettime() is not the only function to assume a
gettime64 or gettimex64 implementation) and shortly after posting
Kuniyuki's suggested fix to ptp_clock_register() as such:

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index ef020599b771..f2d9cf4a455e 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -325,6 +325,9 @@ struct ptp_clock *ptp_clock_register(struct
ptp_clock_info *info,
        if (info->n_alarm > PTP_MAX_ALARMS)
                return ERR_PTR(-EINVAL);

+       if (WARN_ON_ONCE(!info->gettimex64 && !info->gettime64))
+               return ERR_PTR(-EINVAL);
+
        /* Initialize a clock structure. */
        ptp =3D kzalloc(sizeof(struct ptp_clock), GFP_KERNEL);
        if (!ptp) {
--

I also have a similar patch for checking for settime64's function pointer.

But I have no objections to Junjie posting a v2 in this manner instead
of waiting for me.

