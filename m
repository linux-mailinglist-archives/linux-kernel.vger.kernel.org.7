Return-Path: <linux-kernel+bounces-790766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D678B3ACBC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 604DF4E217C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9452701DC;
	Thu, 28 Aug 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNZ4DFAE"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59082848BB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416592; cv=none; b=U60efN6TFcsDunSj9uBOFRttN1GTEQc+8aw2xDgH59RnI9Jc25Ug9fyWMJ0DPE5xUz05OHYJi9ldTwhDnYpeQoshWpwIVq+qC6yIj2eVeQTf69oKzwtaXrgx80hYk3RV30w7dhJ/2h4A3FLPQ6QAduLzrbtRc5JQlY1SaUjhJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416592; c=relaxed/simple;
	bh=a1Y9Qfe4Ntinmu3qdU/LpvLv9GNDTobrJhavD8m/SRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+GolwbCrvzXcQD1yFR6E2pefDUQ4eXQ3OXnxHsN1Hnmt/a+ru7NzUB9j4xz8EIqsje+AtKqD9cai7I1j+ulXGBqqQTEKSz4Pew3VXiWpvd3a29Q8+EAFoKsbojO0/V7TN74S6Q0Wnc+5xxvHleS8Byv4gnlyjXNJU1xjx5BhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNZ4DFAE; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b12b123e48so119721cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756416589; x=1757021389; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a1Y9Qfe4Ntinmu3qdU/LpvLv9GNDTobrJhavD8m/SRQ=;
        b=NNZ4DFAESVNWOnyl0gTJ1GCbHyKscENFJ/c57hWklzspCL/F8x48/0WMTMvBLfskjq
         zIYcYO+7g+jRmVbyFNUJbH9m5uNWUhTL4r4oGDnul0F5ZLV5NeyRlqiHmuNOUYVfVePT
         +nSx18AqQc8rcwKMwzo+xjTWkeydlow+xsEA/HkOX+0UHAOtgkzwD2I0yVvDFDKg5+Wa
         XF6rFwyLy9hnZ0+y4UJrqOHNeEjBOXrMYFF9xb/gV1YKPxn7N5hp+nhsdrBgKTJq62cX
         TmNPmgsp4riRSMHTJFXSrAqGmEcCpoXcJoXemJ2iB3s7KC7cxAW9r5AgMwa3W82xLH28
         DCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756416589; x=1757021389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1Y9Qfe4Ntinmu3qdU/LpvLv9GNDTobrJhavD8m/SRQ=;
        b=N5lzLaGy0yFtTXW/Th2w4pubpICkypjJfAy3pokqjrrIH35G2HPAPUoszQbMrIxKK8
         xuBskhJ5eCHaHOZdthACTXTrLk64uxFgUcb+oP3j3Xq2oabrXL4qZy/0IYxYVQEWF8HG
         /r3r8y7cUf6dARpyS9DIqN03Y9q1yH3lSKhiXmV12ORza31EFyxJ5QO6O73pYh4OKzjn
         1kmiWsKlkEw81RN4d1r+EN2SSt1/3yek+QF62eWZuxdXIVFu7YxtRWLGfIDiR4iQpx/K
         oUk/1sIVi8JgDmZCaW3xfWHFerY1lzj4H7aKx931Ktd0FyEGtSqEn13I7Bm6Vb/u0CoR
         7FOg==
X-Forwarded-Encrypted: i=1; AJvYcCV3wPCNdl17l4yYVhgNM4O5Rv71zqaydfWX6Cz7dESW7SUuX/dtZjj1B4T3R69gqcWlRVJhuyVYiBjbCzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHSUgilxblqOivqNKT0xxBoVVvwIQNZcp4U0ys38bpVbWeGqOT
	O73yWM6uIEPhCVWVF+N2bjCDyNk+mTDtbfRCuLbiaJV6KU1n7M3b+LcOtJDPCASkz/mmy0B1J3c
	eaL10kZ5Pi6DpMudhMU8yqwcoTZuJz13HoZ4zFZKp
X-Gm-Gg: ASbGnctorpwaCIpxJeWRo3h2Mau7pbqGYkX3fn1YjLqWAnT2rnZ9sZN12uHDaZ0P+/J
	L0U1Y7O/B6XipQwgVKdEb7s6VJa07SR5xpJMG/MrJ8uc1Jf2gmu9R4olTd3pLUif7JssQbgZwHr
	2I9UO4E+NMzHDn1A7gSPHoApVqgbKebZ2Hq4gJdCAhZAgzyjRKhOzstH9nGuFtb9BXAqtJJuB4A
	3ZqSWd7GNi2Fr78stWKlcRAMo76nN/3wu6g76uTvCtl
X-Google-Smtp-Source: AGHT+IFqkD7ft+jmAQsaqJOxgwKm4Qy2o/YaSs3yFiKSnw9xPjJPZVBKQytl3x3ukUzsLWLbu6Pj2Ju4p4ZQAl6heVA=
X-Received: by 2002:a05:622a:5cb:b0:4b3:8ee:521b with SMTP id
 d75a77b69052e-4b308ee5cb3mr3721231cf.0.1756416589198; Thu, 28 Aug 2025
 14:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730220812.53098-1-pmalani@google.com> <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
 <CAFivqmKZcipdc1P1b7jkNTBAV-WE4bSeW8z=eHHmtHBxuErZiQ@mail.gmail.com>
 <aKRDxhirzwEPxaqd@arm.com> <CAFivqm+vzkbDEadJEF2So9ZWcRyVT_-Yc+8VWWwsgGW+KD4sNw@mail.gmail.com>
 <aKY0xuegI1S4X2uW@arm.com> <CAFivqm+Xi9FYtzPmT0QkAUxC2Kx_AkrH2NuQE_sVnJVuo48ypA@mail.gmail.com>
 <aKx4nZWsRPTXK942@arm.com> <aKzGlD7ZDIS4XMsF@google.com> <aLAGQk3nOcEI0qJ2@arm.com>
In-Reply-To: <aLAGQk3nOcEI0qJ2@arm.com>
From: Prashant Malani <pmalani@google.com>
Date: Thu, 28 Aug 2025 14:29:37 -0700
X-Gm-Features: Ac12FXzF-O6zQOCkRkRzG9C45ZMqIXcRsxfuzSsPwNBmBGM430lN7FJsPUYpVhM
Message-ID: <CAFivqm+r41cRhsZWjXdOhGhTsQ3nmr50cACk27y-PLee7ZGKeA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: CPPC: Increase delay between perf counter reads
To: Beata Michalska <beata.michalska@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Ionela Voinescu <Ionela.Voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Aug 28 09:33, Beata Michalska wrote:
> On Mon, Aug 25, 2025 at 08:24:52PM +0000, Prashant Malani wrote:
> > On Aug 25 16:52, Beata Michalska wrote:
> > What you are saying holds when m,n ~ X. But if X >> m,n, the X component
> > dominates. On most platforms, m and n are typically 1-2 us.
> > If X is anything >= 100us, it dominates the m,n component, making both
> > time intervals practically the same, i.e
> >
> > (100 + 1) / (100 + 2) = 101 / 102 = 0.9901 ~ 1.00
> True but that does still influence the error - in this case that's ~1% so
> negligible. But the overall error magnitude does increase when the range
> between min and max of the possible values of m and n gets bigger.
> Question is what's the max error that can be deemed acceptable.
> And I'm pretty sure there are platforms that would require bigger X still.

I think 1-2us is the typical m,n value for most platforms looking at
past measurements in related threads here (it
might be a little less, but it's a little challenging to measure this
accurately with ftrace, since the timestamps have usec precision).

Even a 5% error would be a great improvement from the current state.

>
> >
> > > >
> > > > There have been other observations on this topic [1], that suggest
> > > > that even 100us
> > > > improves the error rate significantly from what it is with 2us.
> > > >
> > > > BR,
> > > Which is exactly why I've mentioned this approach is not really recommended,
> > > being bound to rather specific setup. There have been similar proposals in the
> > > past, all with different values of the delay which should illustrate how fragile
> > > solution (if any) that is.
> >
> > The reports/occurences point to the fact that the current value doesn't work.
> Wasn't claiming it does.
> >
> > Another way of putting it is, why is 2us considered the "right"
> > value?
> Looking at the history, the argument was pretty much the same as yours: was
> considered sufficient for most platforms [1]

Thanks for that link. It provided helpful context.

> >
> > This patch was never meant to be an ideal solution, but it's better than what
> > is there at present. Currently, the `policy->cur` is completely unusable on CPPC,
> > and is cropping up in other locations in the cpufreq driver core [1]
> > while also breaking a userfacing ABI i.e scaling_setspeed.
> >
> > I realize you're working on a solution, so if that is O(weeks) away, it
> > makes sense to wait; otherwise it would seem logical to mitigate the
> > error (it can always be reverted once the "better" solution is in
> > place).
> >
> > Ultimately it's your call, but I'm not convinced with rationale provided
> > thus far.
> Actually it is not up to me, I'm simply sharing my opinion, which is:
> we should fix the problem instead of hiding it.

I think both options can be pursued concurrently :)

> Setting that aside though - this change seems rather harmless.
>
> Aside:
> ./scripts/get_maintainer.pl --m ./drivers/cpufreq/cppc_cpufreq.c

Yes, I use this for all mailing list submissions (including this one),
so I believe the maintainers should be on this thread.

BR,

-Prashant

