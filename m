Return-Path: <linux-kernel+bounces-808673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2A8B50344
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8462C4E529B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FA635CEC7;
	Tue,  9 Sep 2025 16:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="02cnPnG5"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C1835CEC3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 16:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436849; cv=none; b=Rv2o8wPadrecJX3JrI/RE/NREnIjNHBWczbp6RrqYZthCtcIof7GDFvT4WrI/eyMYrF/9o2ouRKH2o5MXGSfRpRSzps9mlTv0UTj50SE3rD6cPFHgsFi4ZKLR7fIoasVPurnV3M7kLMYfwOJdQPU+UCbhdDQFGbSa5kK6xX6BLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436849; c=relaxed/simple;
	bh=h2tBW9z9qtavE4/GQ4hxoUrDMkmeBsS59wkL6NhBrnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpsnrbDD6eK9MKkrI5UmoQDumf3Rp/TNEi9KdIF2i3m/F5MIWMFdwxbBr3fl4oucazCJwU3MlYJesL90T/q/9/3DG1l9TrFXLn7jK2jL/w+ju0RTSGbWsZVONC6rS0gtNAf7hgDPK3Yg0u9sdcPhXZ3quazbsCBbBjYoaLRUtyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=02cnPnG5; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so425a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 09:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757436846; x=1758041646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2tBW9z9qtavE4/GQ4hxoUrDMkmeBsS59wkL6NhBrnw=;
        b=02cnPnG5JHmzSOyhGYZnqqb4/5yn9bUz07e6w7jZkCDq0fOyqRUzEJVWBfK7oFMEgp
         iqzQP8qYR6oWI938UijKnHOngFnOMFIrgj2j7BDzC+RZbt6U7BUydF99VQVwr3ZraJIY
         dsCo4+ZAQWJbn/dYXEEAphG+fmw6MitBlnl9hs4BDQk9R59loD7An8YLwlLL69SNQptM
         9RTkUiGaBdQg6fbtsok4HlVmDZOe5cLPw5wdCNfcw2w/EOue3HDHAxO4me1Lav/UJurO
         UU0J2bgYlQZpdq6mFUmGWRpQTr7iZaBIgbIbtiTme2bfD6WZL8r7Xkn9wad0b/OXlSlu
         DkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436846; x=1758041646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2tBW9z9qtavE4/GQ4hxoUrDMkmeBsS59wkL6NhBrnw=;
        b=wG1m8TjX9q6KNW61xB4ElnjqR2EDM0RlLWVkr7TjL++G6N9aWY1iIUIiLWbfQ8l03I
         MCgi+wKDh7aXx00dPAF/sXh/bF6dfhbMrQL0m5gPP6eQlDttaR3zQi92/6f/gogZJIrC
         vtMKS1Itn9AdDF5619+1TgkLVuKjwvQ3EUNHA7zGLy94jVajNq1vzFG5K/3oI8+7htY2
         IleY2znFWuwRO1QdQvpA8Udr1u1ZuMZWY1SVT3wP7sEzSGmX7sAQWZEIPKmQ7+TQ5AmI
         E7vUBpZm4QIStHnqA3qtPTZ+rch3t7pKGIu2x2xzd2CplcXWgPf3doJ/dXnyccVmJsua
         szdA==
X-Forwarded-Encrypted: i=1; AJvYcCWQhbzZhUbT4Lw9EXa6yiT7qSVrqe/Wyh/HidVZ/WXOxBF2pJIhe4ddWnvSD09KlB1ct8wJyCCY1zVU6Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0cu3+5wD9JsuGZeK+MpWLoGQlpi9WtYvev3wwFBy5LjjeP1d
	TNk9osMoCqVYTLqWRGHUNjSKQitz0qorFLltHK76edNXGvu/saq+OBJhkgXYz/fE+6zqCELhVJZ
	mTh4Ytz0sRF3/++hzZ+leidfH6JWq7xo5fVTJ2kWU
X-Gm-Gg: ASbGncvEkEEnI1wQj5pV/DxBQqv8xECMejNEy8grp+4FFqqc5k5MWQ7yZ1K2c8rDxH2
	kHCpySAzSAV1PbzkZlB+ExlUQ4AwXu5sE2aMCiVxMcDeRwkdgurfeP9Jj5WPo0DF2fHZwmuaDBw
	PZ/nVJ6Ljl1Ca13sMAMKldnlsC2I3Mjq0CCocwsqDRuheCbCfwnMNyL/mj+6hnDl1zezUpEmaCd
	3FjdTzZluX2qIyaraSIhhvwKY7dH1IzfGG75OPQHcCkbqi0CV65lzc=
X-Google-Smtp-Source: AGHT+IHIuRq2aKoS3kEjqYzebKZlwD2uOrphU5fkaOYcf/p/e9onUEd1fbAZ1KbzoQawzSyO+8wUa2PQlZBj/Dw4WRI=
X-Received: by 2002:a05:6402:d60:b0:61c:d36d:218c with SMTP id
 4fb4d7f45d1cf-6234d3ee779mr244623a12.0.1757436845803; Tue, 09 Sep 2025
 09:54:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909090659.26400-1-zhongjinji@honor.com> <20250909090659.26400-2-zhongjinji@honor.com>
 <aL_wLqsy7nzP_bRF@tiehlicka> <CAJuCfpFCARoMJ8eniYdZ3hSaM_E3GvfRBV1VD1OohOfJpP87Hg@mail.gmail.com>
 <aMBZfYUN9qtcXXtL@tiehlicka>
In-Reply-To: <aMBZfYUN9qtcXXtL@tiehlicka>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 09:53:52 -0700
X-Gm-Features: AS18NWAskqfJSKzjlCIyKddbks8of4_LFzBxNZe2p1mk8JK6wEwUqIe8FiYXcFc
Message-ID: <CAJuCfpFsgTmmSGEzK6TF62TNr4d4E+Art4ghfB3dHxQYMHJ2ww@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] mm/oom_kill: Introduce thaw_oom_process() for
 thawing OOM victims
To: Michal Hocko <mhocko@suse.com>
Cc: zhongjinji <zhongjinji@honor.com>, rientjes@google.com, shakeel.butt@linux.dev, 
	akpm@linux-foundation.org, tglx@linutronix.de, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, lenb@kernel.org, rafael@kernel.org, 
	pavel@kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liulu.liu@honor.com, feng.han@honor.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 9:44=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Tue 09-09-25 09:27:54, Suren Baghdasaryan wrote:
> > On Tue, Sep 9, 2025 at 2:15=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
> > >
> > > On Tue 09-09-25 17:06:57, zhongjinji wrote:
> > > > OOM killer is a mechanism that selects and kills processes when the=
 system
> > > > runs out of memory to reclaim resources and keep the system stable.
> > > > However, the oom victim cannot terminate on its own when it is froz=
en,
> > > > because __thaw_task() only thaws one thread of the victim, while
> > > > the other threads remain in the frozen state.
> > > >
> > > > Since __thaw_task did not fully thaw the OOM victim for self-termin=
ation,
> > > > introduce thaw_oom_process() to properly thaw OOM victims.
> > >
> > > You will need s@thaw_oom_process@thaw_processes@
> >
> > Do you suggest renaming thaw_oom_process() into thaw_processes()
> > (s/thaw_oom_process/thaw_processes)? If so, I don't think that's a
> > better name considering the function sets TIF_MEMDIE flag. From that
> > perspective less generic thaw_oom_process() seems appropriate, no?
>
> Please see the discussion for the patch 2.
> TL;DR yes rename and drop TIF_MEMDIE part and update freezer to check
> tsk_is_oom_victim rather than TIF_MEMDIE.

Oh, sorry. For some reason that part of the email thread ended up as a
separate email in my mailbox and I missed it. Your suggestion there
sounds great.

>
> --
> Michal Hocko
> SUSE Labs

