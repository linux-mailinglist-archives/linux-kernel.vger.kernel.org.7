Return-Path: <linux-kernel+bounces-893192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 829ACC46C17
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85DC54E6724
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C22FCC01;
	Mon, 10 Nov 2025 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6YYv8sT"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193D1E2307
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779851; cv=none; b=j7rddpECtL5m0CYY90FiPYnmtH5WpdpbolSx/59gTgxbFaxqEWQ39gjpQBZp9McxabEIdDsd4R3d1KIq8/eKHON5ROp26pR+T/QEsfsAQjkmbZYGMP8r9nWBsB4sg2Kw/fXugmHdIuigXujPfTx4GJW11F4mD9IEHW6/fhzqQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779851; c=relaxed/simple;
	bh=qSml4dR6lltRLlIdFL4qJPIWCDYHLkMfeR6SRe3/EaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zsq6PGvLwyCMR0MfgKoO160H8xoWmpl4RJ7BP0v4N2ZhD+m2B13+bEpnOF23QPoNJFGea5i/XaUORjGoKLCurHieBqDVvWvJu0wUGY4TmvFBTh6O7kxtr/kMQJyCZR6r8rljpEYQh33nGbTB8wmBoKV+DW0B6riXH3Xa5tOdbuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6YYv8sT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a492d3840so29536041fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 05:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762779848; x=1763384648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tyc6bfyu3NMGAozQ9Ctuh4LDZmKtgcpPgmPqOdgLGBw=;
        b=P6YYv8sTa8Fc4D0LyTPX+T1MEmuv8ngfosGW0hu/llivlPPgEyIWYxQ7WWvV3zZ6/H
         oJD+8UszABWmY62UFeQR2u0UAar8Imtz8JJFHISRjeGq085mvrMgbnh5KmgMCsyoyVVT
         xT3hpgC/G/JaEknXtoFoHfPHoFnaTmZh/lsKtLoHvuc1rI0Ya3nJn5srVAjBs5HTqRz5
         pgZMooY2ddGI2Xf3DRrzhUP2VAqMcKNKCFYoFiTbcg2DuPWKo4JiIUjNr6+ZzIZPz72d
         WmJzouQ24kqUfYWGT4jVZIrYXIgtzUGu2I6q/LNZ93mSc7b5ZZ+JrYoVFfpVncAM4YxM
         yQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762779848; x=1763384648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tyc6bfyu3NMGAozQ9Ctuh4LDZmKtgcpPgmPqOdgLGBw=;
        b=vfpCliWlIDSGRSofiPBoARULeYVlQDJRPcbdI84mLSflBTvHG2H+/D8jtRbR9hEPVh
         k8pOBle2KhV/spgY3O6S0jTiNcAfA0Hs4AICqcZYnhxTHfAlNlYKmDdC9Bd938MBZmzK
         o+4vfk4Cdk+Zd09q4Oz06xisONEk8LsE4JdxenSH/RmgN62cW0ENkxH7sI1ZQnQ0Q513
         Wk144AbcskzL1r3cc1ImCGbkvZD8kU9aM4EJrq7Kow5DaoKZVkWBiAuYo+n+r+kUHMx0
         518vhu/MX+oahCLecaKFRXHqqu7JOBl30PQJJvwfaizcMOPqT/G1J0BdaanczXxuw/cj
         RK4g==
X-Forwarded-Encrypted: i=1; AJvYcCUr6z27kkPdOd0yl6ktwakvoWIyxt9GOQF0ZddHiKOJ2obQOaSSlsFWCb4fdXyS2DENz8WEy4os/zwYFpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+AclzdEAG5sNpWgVLF+cydZM8N0Y0gN6MBdvMI56xR4CnqT0L
	nOSkWPvTR5L7fZVPXRUcmyCUwpRoNHhqtnnWsP9fFnvP0eQs32UHN3vU6F0r59Fe/BYdMjzBhQp
	w4UpDmItn9mfeH00qer7HPSlOoKOUtd5dBEnH
X-Gm-Gg: ASbGncuoQE7CCIKE1zDN2rjObUi7msc/der39TYXY6bMRSlUAc8OTyR5bSliYRfXYo7
	K14k3vzPYi9u5z0bQBkIYSFH1ZZV1D0x7mZdSMPMK6k8UOy8VVCQVsPvmFuN5fVTDGnwQUAzkDI
	w9O/iNNsbr92r+JzmRbR3sP+QhE5J2bqNS131aQmF3Jvs8DR5U4JFuv5n0TH6ZnE8zI+L2VWLg1
	/QxWoFQQD+sswmV6acs8zCE5gaHC4bgv7dklHTFTFwlEhkwbqlOI9cvefwTbHK8B5NWuxOjyW/Y
	uW5rddt6
X-Google-Smtp-Source: AGHT+IFfptFLjKBZdFf/9r5iFPQ/UizXxNLlZGOI8ZfHNzHB4jb8cPVVdTdeeDX920MIourK5cKt+7ct4peMYMyXZwE=
X-Received: by 2002:a2e:8a96:0:b0:379:348:80e2 with SMTP id
 38308e7fff4ca-37a7b18b449mr21486651fa.9.1762779847136; Mon, 10 Nov 2025
 05:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110111253.16204-1-W_Armin@gmx.de> <CAGwozwEfSVYVWU86ibQB3Ea3sZT9HagZzhFnfkF5kEmwz1cz3A@mail.gmail.com>
In-Reply-To: <CAGwozwEfSVYVWU86ibQB3Ea3sZT9HagZzhFnfkF5kEmwz1cz3A@mail.gmail.com>
From: Antheas Kapenekakis <antheas.dk@gmail.com>
Date: Mon, 10 Nov 2025 14:03:54 +0100
X-Gm-Features: AWmQ_bkXT8T6DFe5CSK8FsrrAE2eMiXshrtUANklstA09fQrxADG21t1qBB1G2Q
Message-ID: <CAGwozwGTY0DECm2OrOwrRgbAd1CdPuMe=Fg=4oOEm5of6u5Rzw@mail.gmail.com>
Subject: Re: [PATCH 0/2] platform/x86: msi-wmi-platform: Fix autoloading
To: Armin Wolf <W_Armin@gmx.de>
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Nov 2025 at 12:31, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Mon, 10 Nov 2025 at 12:13, Armin Wolf <W_Armin@gmx.de> wrote:
> >
> > As already noted by Antheas Kapenekakis back in May, the
> > msi-wmi-platform driver fails to automatically load on MSI Claw
> > devices. Back then i suspected an issue with the device firmware,
> > however i just found out that i made a silly mistake when specifying
> > the GUID string of the driver, preventing the WMI driver core from
> > matching it to its WMI device.
>
> Can you add a closes with a link to that discussion and a reported by?
>
> > Additionally i noticed that said GUID was copied from the Windows
> > driver samples, meaning that it might be shared across different
> > vendors. Because of this we have to prevent this driver from loading
> > on non-MSI devices.
> >
> > Compile-tested only.
>
> I will try to test this in one to two days and will add a tested by.

Hi Ilpo,
did you receive this email? I was getting some bounces from your email
host last week so Im sending this from my gmail

I can test this series later today and add a Tested-by as it's only
compile tested.

Antheas

>
> Thanks,
> Antheas
>
> > Armin Wolf (2):
> >   platform/x86: msi-wmi-platform: Only load on MSI devices
> >   platform/x86: msi-wmi-platform: Fix typo in WMI GUID
> >
> >  .../wmi/driver-development-guide.rst          |  1 +
> >  drivers/platform/x86/Kconfig                  |  1 +
> >  drivers/platform/x86/msi-wmi-platform.c       | 43 ++++++++++++++++++-
> >  3 files changed, 43 insertions(+), 2 deletions(-)
> >
> > --
> > 2.39.5
> >
> >

