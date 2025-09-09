Return-Path: <linux-kernel+bounces-807861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D598B4AA7C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386841640B7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6BA2D9ECF;
	Tue,  9 Sep 2025 10:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ebe/oAfY"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E473307ADA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413482; cv=none; b=H1bXcO1GbkjJ+t90/q5z2Thj3xvUlvzZMw33MXAZDOTxoU9WWU6lvqguMRt8h7OrxuhVHKVTnGiJcXXRDaBj/uqPC9F171tFtJr9p4GhOwOVgBEiVaU5PyUsE+o3rq/ANaTyKP4Z/IB5hOxUOAYxSgNZgRKdeUwp4xJHxLHdKos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413482; c=relaxed/simple;
	bh=rvPHXqEY5dz7k/8fFAR3K9ITwPsQt4nSsuTGsFo+WfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qoJk/prHA41x818O9zUW7xEtiolnQkM0jnNl8tpUTGTfekGH7rF18b6vR7hbVkCvy+acg7uPajis82zFwaxCImyepdQyhO4wb/xp8HuBCSikd8ZbwswJLT1L3rBdd3HjMKmU05Khl+BWmTsQipAnI6LNEPWh/yEGL15mYw8h8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ebe/oAfY; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f720ffe34so7049079e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757413478; x=1758018278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGAlRpykk4cGfc/EkJVYQzW8Hpd+7/LR38hLx9s5w8s=;
        b=ebe/oAfYYG//CmRfMU2LOlOpafIyJGxPZIUK3GmJsgmyNlCQ2OdL8ORN3FWPp+Z9j6
         jF0hG5afZoF85K7KZSi2jpqsuB3R/TToxjUjSsQwTNM+5PSJxl924IXgDKyKGDo8Q5pp
         GMdMb01gju6ejrlUoOww7rn/78YD08EiUSQcnG84C9q/T34Zfp0w1x16ddmzR9exCxyL
         k7Aid47RLgvNZVnpnr1YNTa+RYG1d/aZ/tSPhD/JGXTo5R4j/eRmDp6/BC7Z3PbuP/Tp
         Puk7pizRGTJndXqs9PoRZoVjljvwfkM3LUHibeIX5o9NzO9nrwsxIO1UzIChDW4obASf
         CTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413478; x=1758018278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RGAlRpykk4cGfc/EkJVYQzW8Hpd+7/LR38hLx9s5w8s=;
        b=e6eZUvK2l7NCbEsHvlrbwOikJVu3Hu7ZklLnKsL5GrvW9ZFRyDuk2xm4tNsu6/qeFO
         M+u3U846LV6pRqwwKAJkgQylg7J4yaPQLxCQjuQehXHOgJIQznq9KxHU9jrWSXp83LAL
         7EBlw9cxC9O9MwTpkdWHVIkt5a1qvSklXS1KhyLsVxkN24llDDFjzS+HxRSUdlmPdDXE
         cUQJPDeOWwmEGP+ESSSHPY+nHccNBAIU5TxSSaQ3J1n5rnl2xpsHfTWvsnOsP523T09G
         Ku5yJlYgGweENXxU0w9j2Uwd8xB1Lhdhy0tqvfHerYxSpk20OUr5QcxekmDG17b8A+Wy
         PvUw==
X-Gm-Message-State: AOJu0Yxb5NtcKraYde/RAttyvweOZqazJk7puw6Gi6pXmH9s+1JhfCId
	1Ccrb3gfvz2EDBSHevNS3LMtL/Kut7RkZEyuW18uctVIZQtq12UJ3t/mYzu8xQo1nf8KvPGUgDU
	+J3qFHtFZU/StQtzTHfJowyEOGoCmwZycw6KfbuCZLQ==
X-Gm-Gg: ASbGncunaZHS7QF45vVkUXdiLKBgIG9OrKT66VR3D8FIxm/tROQQKlYRCDzG9tBwcbm
	mpZYfxgNjq+kuyISx6rYc+0oYC9TmkWGamfbqOFMgjO0ChFMCdm0261H4o9wVDad9/laiNdDLyE
	kLlY3b5nJJ3IQa4A3vZcZPl23k1zeCtWfVe55YIuU4mwXYvQugKHjPN2FmNXd0VHMkpkAaemd/8
	yWVpSxy4tqe0FEY4wZZuNJDdtMp43hMzwBqhOyf
X-Google-Smtp-Source: AGHT+IHheVK/2xt8tglGhIBdTf7j12nw/P5uqJjV3LpiuGiQaAvqnuMpskHQ3hBfVBvVAh2rzbtyU9jEuUuHC5ZjRZg=
X-Received: by 2002:a05:6512:1545:10b0:569:766:944e with SMTP id
 2adb3069b0e04-56907669771mr449824e87.8.1757413478145; Tue, 09 Sep 2025
 03:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090857.108240-1-marco.crivellari@suse.com>
 <20250905090857.108240-3-marco.crivellari@suse.com> <912c038e-b03d-432d-be24-54c0f90193fd-agordeev@linux.ibm.com>
In-Reply-To: <912c038e-b03d-432d-be24-54c0f90193fd-agordeev@linux.ibm.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 12:24:27 +0200
X-Gm-Features: Ac12FXxGAtt56FkytPNkO1riyrHt-Bq4O8GOYiiN2EFSKCsbudpEACK-wt8DQvc
Message-ID: <CAAofZF6ei2cKKHhsxO1EFAb4HMvJBpnkLc7cwqWbL3p0QdfZOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] s390: replace use of system_wq with system_percpu_wq
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 1:44=E2=80=AFPM Alexander Gordeev <agordeev@linux.ib=
m.com> wrote:
>
> On Fri, Sep 05, 2025 at 11:08:57AM +0200, Marco Crivellari wrote:
>
> Hi Marco,
>
> > Currently if a user enqueue a work item using schedule_delayed_work() t=
he
> > used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> > WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies t=
o
> > schedule_work() that is using system_wq and queue_work(), that makes us=
e
> > again of WORK_CPU_UNBOUND.
> >
> > This lack of consistentcy cannot be addressed without refactoring the A=
PI.
> >
> > system_wq is a per-CPU worqueue, yet nothing in its name tells about th=
at
> > CPU affinity constraint, which is very often not required by users. Mak=
e
> > it clear by adding a system_percpu_wq.
>
> This paragraph is not exactly correct. You switch from system_wq to
> system_percpu_wq - which are two different queues with the same
> characteristics:
>
>         system_wq =3D alloc_workqueue("events", 0, 0);
>         system_percpu_wq =3D alloc_workqueue("events", 0, 0);

Hi Alexander,

Yes, system_percpu_wq will be in future the replacement of system_wq.

> > queue_work() / queue_delayed_work() mod_delayed_work() will now use the
> > new per-cpu wq: whether the user still stick on the old name a warn wil=
l
> > be printed along a wq redirect to the new one.
> >
> > This patch add the new system_percpu_wq except for mm, fs and net
> > subsystem, whom are handled in separated patches.
>
> I do not see this patch does anything like that.
>

I'm sorry for the confusion, I forgot to update the log after the
previous change.
There are not, indeed, the changes you mentioned.

Thanks!
--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

