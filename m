Return-Path: <linux-kernel+bounces-801061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F299B43F40
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD0554460C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56932F6587;
	Thu,  4 Sep 2025 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="N+rP+DfZ"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F3305043
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996729; cv=none; b=b/JIEmF6PQz6J1S8M9VuGsvtwrCGYBx6p9Mfy5nRNam07AkhFZlQeryUtvmJC/XWe0sZQit0ImH1a/UVAI859+3lj10wMx5bCsNn9m8KRbWlW6ReRWw6Nm8gqYCEiINmz/FOLEz+QvvaofJhN6tqaawWprbZCTAF8QEvRwIB1Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996729; c=relaxed/simple;
	bh=XP39k1oOF1x1pNPvzm2AmYTRAncscIavPUpOD7pfq6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzE/O0W06Kkgr1UvGpHhBMsQaDeqhBcJrYMVeTAUnvVO+IrUxqyL9TrUquG9Z/XbVuKDZXX2IyfZlyXysHP4MvwKvWjBfNo3DMGjvY8nnA5PPgj2+SE/apINNtCEntSPY8SKoTMOKbMRSIGnhvfVlLWZpOYni5AZ9bXP6mMcPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=N+rP+DfZ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b3d3f6360cso12494751cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756996724; x=1757601524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sORYZrryBx3X+ZB/P+ONJ1uScfOCSDSJIiEl+3c24kE=;
        b=N+rP+DfZhv0Dan8qbanyT3RrUYDBphsVWPsMJtJ+iicb9bhct5V+txGzxt/NfmBpUa
         umv250Kd6B1c9pcXfcBsQ/WKdCbzCjYkO5yZSyM4L0jctRotOQZIHqaGo07f3lV4RsO8
         jvGVxTCRkWwKB+83KUWPQ60sineoY03C6HKEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996724; x=1757601524;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sORYZrryBx3X+ZB/P+ONJ1uScfOCSDSJIiEl+3c24kE=;
        b=OCWdx0ZbRiLoX/9FFHfLwAyYM+6FVcbmxY83EStIF32/5Tmqmj9wQ907qr1D8K0zID
         HJkqeIt8MqHKFcQwSvgYNGRs+9nEi4bu1jknv4ucJfeAZ/JzW0HmaTQUydmQUWoYj36F
         W65a4qpJrDYX62DHAY10D9kYOE49VFdo/dSvhJYFbd1Ow1JsUysyxsR1v5KwoKSiK28e
         tSJ3oaslFKAQ6iW1k5fIJD2gdpzqnV/j/hsbx/5kqZP33g2Zfvq2De4ICk8UQcSndqIS
         6J9M1qO4nXDCmDkbgYK01vgWRgGQe2uMDrGzgkY3uY4veFgn3tF5e3gHSFcjmF9kW+Sa
         RSfA==
X-Forwarded-Encrypted: i=1; AJvYcCUmH8r0mVDeu2OHyLEacDk7KcRHRjygce9QthoIa1L55kLAlOEB1R6BqA/tFf1IxOZaz7QcSoEoyc6dnf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRDExdXupnfK6wYB5OmX2O+GrVMHP14hX7Zw3SA6smYqEtKaZL
	yXBQ5b0UoVb/L8Ga5hqaQRD4e3ZvxNEGEcuyWPMlS5ar9ybyTM1FMSfpm+iQbXkiNXstamVDF1v
	wIxlpypuN0Gv6WxhDBhbZiuWf/1ifs+I7B4/M1iXYpQ==
X-Gm-Gg: ASbGncsTsqNl3xeGZ1+hFWmIBGTmyYxYDtKgIy0V5GnnGx9EIr5Oej3AAp5yVHx19He
	PQmM3Qkjzb9zWzHvJVSEu0nCCseND1rdZhlqdCPTx6vtpH6FrVwvretrXwVKqzZOp+wJnExBpOn
	qehWHMND8XtW/u7TOoe49XTnywx2x/FtcxBEdGrl/L62wz0f1HOb9aOy+2sOgd1oUG/AquWkxmH
	xfBRbRaesrVHx+gWx2f3ykg8ZVwJb++g4P4MWOApjyJWn4K+7q7
X-Google-Smtp-Source: AGHT+IH+iqp6nL0b1T6mhc+yoMdRxhuFY9y32p5XWmMDd4VFjp06eMd/Dww4jVhx3Z6Pd2rRHB+kTcMKsEeZWM2DecY=
X-Received: by 2002:a05:622a:1dc7:b0:4b4:9429:cde with SMTP id
 d75a77b69052e-4b494291702mr57042491cf.29.1756996723834; Thu, 04 Sep 2025
 07:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828162951.60437-1-luis@igalia.com> <20250828162951.60437-3-luis@igalia.com>
 <CAJfpegtmmxNozcevgP335nyZui3OAYBkvt-OqA7ei+WTNopbrg@mail.gmail.com> <87tt1il334.fsf@wotan.olymp>
In-Reply-To: <87tt1il334.fsf@wotan.olymp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 16:38:32 +0200
X-Gm-Features: Ac12FXzZ-2wxsKUJIUDzjsjhjGtjgDnG7zuajNPjeJmgBcv3guSXid3pHorQzTQ
Message-ID: <CAJfpegsyrSPxLK=nVLDSPWq0dyvoMr+s0K-Lep1BvqX1wpZphA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/2] fuse: new work queue to invalidate dentries
 from old epochs
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 16:11, Luis Henriques <luis@igalia.com> wrote:
>
> On Thu, Sep 04 2025, Miklos Szeredi wrote:
>
> > On Thu, 28 Aug 2025 at 18:30, Luis Henriques <luis@igalia.com> wrote:
> >>
> >> With the infrastructure introduced to periodically invalidate expired
> >> dentries, it is now possible to add an extra work queue to invalidate
> >> dentries when an epoch is incremented.  This work queue will only be
> >> triggered when the 'inval_wq' parameter is set.
> >>
> >> Signed-off-by: Luis Henriques <luis@igalia.com>
> >> ---
> >>  fs/fuse/dev.c    |  7 ++++---
> >>  fs/fuse/dir.c    | 34 ++++++++++++++++++++++++++++++++++
> >>  fs/fuse/fuse_i.h |  4 ++++
> >>  fs/fuse/inode.c  | 41 ++++++++++++++++++++++-------------------
> >>  4 files changed, 64 insertions(+), 22 deletions(-)
> >>
> >> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> >> index e80cd8f2c049..48c5c01c3e5b 100644
> >> --- a/fs/fuse/dev.c
> >> +++ b/fs/fuse/dev.c
> >> @@ -2033,13 +2033,14 @@ static int fuse_notify_resend(struct fuse_conn *fc)
> >>
> >>  /*
> >>   * Increments the fuse connection epoch.  This will result of dentries from
> >> - * previous epochs to be invalidated.
> >> - *
> >> - * XXX optimization: add call to shrink_dcache_sb()?
> >
> > I guess it wouldn't hurt.   Definitely simpler, so I'd opt for this.
>
> So, your suggesting to have the work queue simply calling this instead of
> walking through the dentries?  (Or even *not* having a work queue at all?)

I think doing in in a work queue is useful, since walking the tree
might take a significant amount of time.

Not having to do the walk manually is definitely a simplification.
It might throw out dentries that got looked up since the last epoch,
but it's probably not a big loss in terms of performance.

Thanks,
Miklos

