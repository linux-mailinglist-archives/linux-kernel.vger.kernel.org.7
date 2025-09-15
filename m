Return-Path: <linux-kernel+bounces-817415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 312CBB581EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA10B17DDB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01929265CA2;
	Mon, 15 Sep 2025 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nl2TW7nI"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3924DCE9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953374; cv=none; b=b8FSHCy/qvNM9dV3PlO08tldbEUknYL+CyayRZKGx/jbrR+WSSwb3k2e18jvCJaJ2p4a4V+OKlBZ59xE+ZvFPQufL1i4okwo/ROQyuhaP+lCgcSdtLtKJp+Iggxy126XSVylmM81b79GUlv5TZ6ZopyLX0EX0Wi44j/zR+gzK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953374; c=relaxed/simple;
	bh=ckALgmS9JU4cyB+fW+6jYbccuY9CRtj5qXaUIM5eQS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tUzlI4Nad/XuWYu6kfeJNC7XMPtlkY7JlZEH0b6CqFchwVFrKphDRjGj9J77nsZv72/syhSBFdPLx6js15X6cIWu6wy+MmDGrlcDcnwNCc7FfNTeHumAlVMJmVvogzQxBxzXfD0IHkoPb5U/xxobycPhkS8DENBoRx57GRTg7t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nl2TW7nI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e43b0f038so974601a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757953372; x=1758558172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckALgmS9JU4cyB+fW+6jYbccuY9CRtj5qXaUIM5eQS0=;
        b=Nl2TW7nIHPm5aguwqvxS1aD3566baaLYAejy4zk8RvMckCmksUcqJgIs7VZc3nZZu8
         GaB8QAZvVr0n2gOPgTmGSwnvkbpLb/A7myl3LNRfny9htmpSu1rQUvYZfwW5M56Xl2XZ
         foIJBLnn6mPd2f77YUzirvV4pAnyNFaIg5SE3Hmb6Gx+Z5dQdLBEm5rNC6G8XhLmIbxR
         e1HNevo/m8f8svl1bCnEYzmNnG6tpX9RIydncpe2VEkHBDFm1wIzV3k7HBFE7ZjpEJHN
         cbWPUfDfOYVN40k0SlYa7Er5m1U2eM7pG9OdAdLvpXp84Jw2yiQ0S7lG133lULDn4xKO
         6gfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953372; x=1758558172;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ckALgmS9JU4cyB+fW+6jYbccuY9CRtj5qXaUIM5eQS0=;
        b=dHWWSy9RCFd0+SOCraTCqfn3SQ6WhS1uDiofC4CuAG7JRn+rPZO2unNhRdpo+blJOT
         7q+40bYTFCMabg1ExnDv8REc3tIDHxiUHEZb0JHp7+CYLya9VidTn2nKhZUaC4RnWlt9
         +ufJgB5OU/2ytxZv0SJZr3xCyDj30gEmbnuCu16U2GrV1KJMgbi1z9d7qXDfhlzdGHW2
         U4tKwJ/xzOASR2K0rKsZqWe68F1GXxDzOBBHgL+C+EwZ/5Laj08M86A10bmZ0l8wSP6a
         qwHaVSf7UyBZ3Twz83jtWtTKHsHiQYlu+Qq7VdSOhTa8pTPMxkhf362ywykq1zM9rKpt
         j5mg==
X-Forwarded-Encrypted: i=1; AJvYcCUkwsfUOgWmQvT2TaXs1y/vVMwLct1xMwBZMJzaappub2NYG5TXec/dUCgGx1XFDCBEJqSgEb5z1iHPdv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZELqBsNW0ht8K6EMNmX4n3LqtAlvpAhTAzfjeTYKGsmides1
	kMnciFtUjQPbtqyNJXt2TgdGebI4V9CruVxo6+kNLDQhmJaszmJSq7Y8r7FnUzD5lbu5VA35xJZ
	0j2LuvA==
X-Google-Smtp-Source: AGHT+IFIKggxQ6LG8cRpNraYYyVtBUxnQDaC6/BZN4rVOPFXmkRI64p0YHer2xSH/vJbTDmNw1+WQAufXNg=
X-Received: from pjbst15.prod.google.com ([2002:a17:90b:1fcf:b0:327:b430:11ad])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d8a:b0:32e:7270:94aa
 with SMTP id 98e67ed59e1d1-32e72709635mr3542385a91.19.1757953372157; Mon, 15
 Sep 2025 09:22:52 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:22:50 -0700
In-Reply-To: <4iceeja4kbnb4cir26kme6z6wabnnyu6trc2qo7ye7po65wemr@i2tyg7cfq54x>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAHk-=wh5AyuvEhNY9a57v-vwyr7EkPVRUKMPwj92yF_K0dJHVg@mail.gmail.com>
 <ef8479be-8bac-42c5-bac6-5a5841959b45@kernel.org> <4iceeja4kbnb4cir26kme6z6wabnnyu6trc2qo7ye7po65wemr@i2tyg7cfq54x>
Message-ID: <aMg9WjipgDtgVPIR@google.com>
Subject: Re: Commit Links [was: Linux 6.17-rc5]
From: Sean Christopherson <seanjc@google.com>
To: "Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=" <u.kleine-koenig@baylibre.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025, Uwe Kleine-K=C3=B6nig wrote:
> Hello Linus,
>=20
> On Fri, Sep 12, 2025 at 08:24:06AM +0200, Jiri Slaby wrote:
> > On 08. 09. 25, 0:25, Linus Torvalds wrote:
> > > So please: don't add useless information to commits in general, but i=
n
> > > _particular_ don't add "Link:" tags that only point back to the
> > > original submission email. Yes, we have tooling that does it
> > > automatically, but tooling should not be used to increase the human
> > > burden. Tooling should _help_, not hurt.
> >=20
> > I disagree. In a bug-reporter role, I use these Links pointing to the
> > patches every time. So unless there is a way (I did not find one), they=
 are
> > very useful.
> >=20
> > My use case is (mostly) dig out the thread/patch (grep Link, and b4 or
> > https://lore.kernel.org/all -> raw) and reply to it as it causes some i=
ssue.
> >=20
> > In a backporter role, I use the Links to look at the thread to see the
> > _whole_ patchset instead of guess work from the linear commit log.
>=20
> +1, after a bisection I typically lookup the thread, too, to have my
> regression report in the right thread. IMHO this is really useful
> because the next person hitting the same problem (maybe?) finds my
> report easily. So for me the Link trailer is useful, too.

I described several other scenarios where the source/submitted link is usef=
ul
last time this came up[*], along with the same proposal to have a dedicated
trailer so that people that don't want to risk exploring what might be a de=
ad
end can more easily ignore that specific link.

[*] https://lore.kernel.org/all/Z-2XVMOJXUjVYXV0@google.com

> > > Make the links be something *useful*. Make them point to the report
> > > for the bug that was the cause of the commit. Make them point to the
> > > discussion that explains the impetus for the commit. But do *not*
> > > mindlessly just use tooling to create a link that doesn't add anythin=
g
> > > that isn't already right there in the commit.
> > >=20
> > > I realize that people think the link makes the commit look more "real=
"
> > > or whatever. And I've heard people claim that discussion happens late=
r
> > > in the thread that the link points to. Neither of those are actually
> > > true. When bugs happen, people don't go to the original emailed patch
> > > to talk about them. Much of the time the reporter can't even tell
> > > which patch caused it - and if they did bisect it, we already have th=
e
> > > information - there's no value add in going back to the original
> > > emailed patch.
>=20
> The true fact is probably that *most* people don't go back to the email
> thread to reply there (either because the breaking commit isn't known
> yet or they just start a new thread). Yes, the few who do can probably
> easily lookup the thread on lore, but clicking on a link is easier (and
> makes sure you find the version of the patch that was applied and not
> an earlier version). (Or a later version that the maintainer failed to
> notice before applying an earlier version.)
>=20
> > > So if a link doesn't have any extra relevant information in it, just
> > > don't add it at all in some misguided hope that tomorrow it will be
> > > useful.
> > >=20
> > > Make "Link:" tags be something to celebrate, not something to curse
> > > because they are worthless and waste peoples time.
>=20
> What will you do if a question arises on a commit without a Link:
> trailer? I guess you will lookup the shortlog on lore?
> If the Link trailer was skipped because there is no relevant discussion
> in the thread that resulted in application of the patch, you will still
> look at it, just taking more time to eventually find it. So while I
> agree this is a dead end with and without Link: most of the time, not
> adding the Link: doesn't prevent you exploring that dead end, but only
> results in more effort to find it.

