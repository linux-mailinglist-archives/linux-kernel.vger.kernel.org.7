Return-Path: <linux-kernel+bounces-807364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39674B4A36F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FE2540A13
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8301C305974;
	Tue,  9 Sep 2025 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ODs7c9Ig"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064E31F30A4
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402762; cv=none; b=COJaCefV8ShYH1WvnZGf5h3GYTywrZWm2JeGHwKTt2rrcJn3UiSy1LvmIm2j5aDHRbgWkKdBC1oPlYoIEkaH2eFjb2tDOQXXXvG1xVHOHFWnaL9uPMV4fgqscnMpGUl6cW8RaOAjrj2kAh0nGUaZsYk+dQfMCtyc+58XwvyDYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402762; c=relaxed/simple;
	bh=7inUfeL4iXoWEN8KQCUXVzIGFwKhSb19V12WXUhx85g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dg5Gl5JZHz9LGA7WOdSaXV4ugnFlSFUdARj2+FV0PjVhdEKwc6AyyIhFvBvSm7SK2/CuBPMuZ3/QX3Fj8UDa4J4RYoFATvnuGHh9cX0KEgRUp5WRsKZLG8o/3RdDn+/25xgi4Uv51pdTL0Fj4wyOuRRCaEvvszlxn/aBIdcX9Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ODs7c9Ig; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f76454f69so4958228e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757402758; x=1758007558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7inUfeL4iXoWEN8KQCUXVzIGFwKhSb19V12WXUhx85g=;
        b=ODs7c9IgYkys8UB0jUCrGrMWA6Ua/xACuwga4FX91iWx/Fsd/n1sbw2Iwj5biHHZhO
         C11+hlO1q8PTgnX8OfA0rdeLsYza1oepTcRTU6i3eMQqvqVqihpN/FLLyIOc+decyvUM
         81v+E6uZOLvvRyMFLG7xxprOzEYjt93wUra50U3z3Rt7S3F/vzQKq5i8W5dYve+6DDxl
         8S8IRXYBv8XShs2J0YA/8sUQ0UU2XzrwoHX6xp6SpOiyzDrGbqcR3lWTn0+aVgwknPUk
         hJNltnthqziXxtAIIe8nkMyTBTtp9RSzHygEvjL5oj6epzXFDEze5t1wXV0wmzSRVl+L
         6bGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757402758; x=1758007558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7inUfeL4iXoWEN8KQCUXVzIGFwKhSb19V12WXUhx85g=;
        b=J2IpC13Ot5HS7YE5NVlywbT/FPPHJL0JCv2lPHpzicA6A79PVFqxj8qGz5xgMUSDwn
         g1n6ztbaCY7bj6vLcVOmZRNxQR6vKLggv5nQ5rS0QuiJ0Y6wvd24Whzt6Xfi66K9krhC
         61+AI34VhEwShDCqJhtshKt8OsxbI5wgEhHgVh2ykseuygWM5h2dyQhb3VGDof4sGu9N
         P0tvC6dxHjMtgLBuYdKIlaxIuA0YsdnO9Ro5YB0jYJSzfhLeGBMTrZ97qbKdguB258F8
         SgLQ2O4LzUQl4aHHp8a1Xim5PWd9tbEsIht3lhy1Zqh5Qg6N1p+V2kmsrNIHx/n6ybvS
         zAxg==
X-Gm-Message-State: AOJu0Yyu+8F1AcaZeL09Z2wgPHRWygWmkB+VF7WyESmRo9yONIvfF5Ue
	EyphyUG+pz+NYPgdy5Rp6e3XtLJeLcG5TzyWSylvZeLIKPT0Zpzo0Ws9Vk5H69KFshRrPgfCBs6
	o1Tuk3NZCbbk9rjK9tFAV+22QNM/Gan0DZfAafRfpjQ==
X-Gm-Gg: ASbGncsG0jGpoodrPkYIBRmQ8J+4XHSSM0BO5l1w8gxWqszCvuSU0u1ZL57hynPhIf7
	PiBaihy+2c/xBBbXdgmLtyiweuqSedgufJBRDg2II22J8XLDpyEHt/feUN66XYcEjU2mlEROmEz
	urVvRDOL9c1d1u5eD36zSmLEqlLeOf08jT3JgStkU25GBwVWFWRCtXlCYoF4FdfExQjJwKHY7SP
	jUyhE7LxbPSEgbSKEhrbcVN/rJ2C5VxiI8CMJJ9HpzznYon6yI=
X-Google-Smtp-Source: AGHT+IEAItx5LkxY8bTTPzFu+ytmMJgwFxFU4kyv09Ue8x63R9gquD9wuNy4+Xc6/sBQ575h9u2bBPxcfvQknO5Np5A=
X-Received: by 2002:a05:6512:3347:b0:55f:727d:408c with SMTP id
 2adb3069b0e04-56261db51a5mr3072329e87.50.1757402758113; Tue, 09 Sep 2025
 00:25:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908160224.376634-1-marco.crivellari@suse.com> <CANiq72kJxwEncXVVrZoMyjXrtsJUGf+kamz0G+d2we7Fk1Vp6w@mail.gmail.com>
In-Reply-To: <CANiq72kJxwEncXVVrZoMyjXrtsJUGf+kamz0G+d2we7Fk1Vp6w@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 09:25:47 +0200
X-Gm-Features: Ac12FXx4zNW2OZlT8is3cwmhq9h30yBg847pi9uvblZgAiJ2p8d049FN04Yni2o
Message-ID: <CAAofZF5JbC0=zKMXRDSGfbLaZ7y8Ems0x-5GEVADkHJyY3BkMg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: replace use of system_unbound_wq and system_wq
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 6:32=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> If I understand correctly, these two patches are "just" following the
> C side, right?
>
> i.e. the summary below comes from that original patch series, but this
> one is just adding the `system_{dfl,percpu}_wq`s that were added on
> the C side.
>
> In other words, I would have just said that, plus a link to the patch
> series or commit that actually added the new wqs.
>
> I would do so similarly in the commit messages.

Hello Miguel,

Exactly.
I kept the same cover letter for every subsystem involved to give all
the information.

> This is not what the patches are doing? There is no replacement nor renam=
e.

Yes you're right. This is done on the C side, the rename of all the
uses; but the old wq(s) are not removed.

> > =3D=3D=3D For Maintainers =3D=3D=3D
> >
> > There are prerequisites for this series, already merged in the master b=
ranch.
> > The commits are:
> >
> > 128ea9f6ccfb6960293ae4212f4f97165e42222d ("workqueue: Add system_percpu=
_wq and
> > system_dfl_wq")
> >
> > 930c2ea566aff59e962c50b2421d5fcc3b98b8be ("workqueue: Add new WQ_PERCPU=
 flag")
>
> Why are these prerequisites if they are already merged?

I kept the old cover letter paragraph name.

Unfortunately I noticed I made some mistakes not updating the cover
letter accordingly... sorry!

Thanks!
--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

