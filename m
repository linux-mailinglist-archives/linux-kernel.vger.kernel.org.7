Return-Path: <linux-kernel+bounces-822470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E053B83F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 12:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59755430B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8189B27E7FC;
	Thu, 18 Sep 2025 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3mlRpTa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB5A2773F0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758189928; cv=none; b=e4AXFFi5Vi7aHF1R3eafAHfd6gP0xd6dzvcXC8EtYXU7oThx/KiCncyGyRrfmALuAEleKtIeel5w9FaLVHrCbj9Gx+dAB+qJ/KH/X1wTr/xfxFeEyTI6+9/XJc6CCdk6VU2p6gutc58Q5zpfXW3RYOY8O3gJFvdvAaD8mqo3Tdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758189928; c=relaxed/simple;
	bh=yHZg7E3K6d2YcLik+EA4wtgpp4DJ5xBkllPVHjfBqMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ6zIx0RlXQ/zuUBDeFsPR5WoXyGxHG9fEtPju1pBR8Ma0iDxLNJaLSbEOIysJSeWXqmpgnwDVGpN9Wu9iNCKDFDfPU/5IaPjOnWtd9ahualjyv2sGdzn5fKnUvMmBKTVVWZQymqQy1aP5+dvKOeV4eVAz0M9vUPRBacK5N9Fro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3mlRpTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C08CC4CEF0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758189927;
	bh=yHZg7E3K6d2YcLik+EA4wtgpp4DJ5xBkllPVHjfBqMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A3mlRpTa7oEOUbgua0nsSo703yUbq9YO88eQ7cDMKuGM9sQs/GiY+CcaLRoeLdj7i
	 T4CHrvr19uKPHsVFjfRormVLGiuogt5c5gPXz0fUQffseoHN7j7jzvydx9L9EZeetG
	 nyoPJGklIkc/8dJ7lRNc7HyiQFTKOXVBP4bvSG/cE2nnj6jZdoP3Il8dXXeMEmVr15
	 RMXw3WEgf+NjSSUHqYOZ8CnYEzqa3llX8cQwmHja4JzVre2fuDZQ9rZ7AfPS6BZbs3
	 qamilhIJpDSXByqsFgyEP7EoB4Uu9F52UL7DtMhdPx7EBOEeHepgoSE7TPW5CdJ9rA
	 FIjVCdCHSHuFA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74542b1b2bcso741979a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 03:05:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVqxJvJ2+ZFxJB1P1y8/j42rqUVJFLSTiVfZSnUuoYISJS5wmHyHeUkv7wvkI2MjVx8RyGd0fmt3peMkSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb0plPebkM21W6xYUF+PTrChgt2DAOBlFUYB85cVocgM59xwXz
	FTxaRVUcRifAjJ6rmvvJ4gRXpvQ/RB2rbcjwQQEBDKd+G3njRULQseNJcHTGILn4WXNj8M1eXJE
	/OJm5sQB1u54nyXTKXZIYXi6H7FfeAt8=
X-Google-Smtp-Source: AGHT+IEPe+INRvhVzC1m5Sod1iKYNWcSFjc9f+McH5EIIs/1IuJG8CQVjUjpp0g11hyYud3XkLCARtsEo3f9zFkVRf0=
X-Received: by 2002:a05:6830:2b0d:b0:75a:ae3b:777a with SMTP id
 46e09a7af769-76313356781mr2903315a34.10.1758189926614; Thu, 18 Sep 2025
 03:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6191405.lOV4Wx5bFT@rafael.j.wysocki> <CAJZ5v0gEh-xoKdgAgUvnGzPV6AO51=ZagHXNCrC4BfRZk6Oydw@mail.gmail.com>
 <87h5x088mt.ffs@tglx>
In-Reply-To: <87h5x088mt.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 18 Sep 2025 12:05:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h1DgQ2xWSEXjbiwAUES4DMKL8S+B5+ed9muWTwsfeNsA@mail.gmail.com>
X-Gm-Features: AS18NWAe_B-yQRdSp9aaQCx6krlTCfTW0SQdDJGiiMl9Szo-23iKagiwZkerVDg
Message-ID: <CAJZ5v0h1DgQ2xWSEXjbiwAUES4DMKL8S+B5+ed9muWTwsfeNsA@mail.gmail.com>
Subject: Re: [PATCH v1] smp: Fix up and expand the smp_call_function_many() kerneldoc
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 10:31=E2=80=AFAM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Tue, Sep 16 2025 at 16:13, Rafael J. Wysocki wrote:
>
> > On Tue, Sep 9, 2025 at 1:44=E2=80=AFPM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >>
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> The smp_call_function_many() kerneldoc comment got out of sync with th=
e
> >> function definition (bool parameter "wait" is incorrectly described as=
 a
> >> bitmask in it), so fix it up by copying the "wait" description from th=
e
> >> smp_call_function() kerneldoc and add information regarding the handli=
ng
> >> of the local CPU to it.
> >>
> >> Fixes: 49b3bd213a9f ("smp: Fix all kernel-doc warnings")
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It's been a week and no feedback.
> >
> > Well, in the further absence of any, I'll assume no concerns and just
> > queue this up.
>
> Sorry, was distracted. No objections from my side. Did you queue it
> already?

No, I didn't.

