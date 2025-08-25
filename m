Return-Path: <linux-kernel+bounces-785500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980DFB34BAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA7317A51B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25BF2882BC;
	Mon, 25 Aug 2025 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lc0FrvJ/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025D269811
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153499; cv=none; b=Id76JF+XOZL+qwwbITs9elb8aNTbmt4rM9GBjrMUGCpx0Iuj4QdaQ92O5Abm2H252gLOVwvOOCNjggPzNHtSbpqmwfBTuJsxl04fcYpZTu8XTUzaXHG9xqyJvjw0tNlOMU2KhLrdCYtzJW9d8OtGSgT/1rg0Suj1Re0wXLkYHg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153499; c=relaxed/simple;
	bh=TwYl2TvCIy48swZ7zK8/jHh0n86S2CO1fq2+UukgUt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXjNijH0cat/kcGAY989/CK+gHNON776cXKvL1hyGPvkaXq9Y92pm6G6k/PTfLc2y9Pcn3v2ht993fwGBG41CrjZcpswkBG2/ZDfT9puOCVvaImsM0GWoEhig5jEg9OTyIrEE+2pAG/Aji/ygdtOuOVhFwp12bK4XKlsw6uFi5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lc0FrvJ/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24611734e50so10635ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 13:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756153497; x=1756758297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1TfikVf308PpMc/N4oFUO7YJyv5s2vYCUTzb6GKZu4Y=;
        b=lc0FrvJ/vqKAb3Z0eUhHljR3jPlUNVK9bBsm/sXUbMaPx1qsj/hiZE1qotC9/OWu1v
         D05eCzulX4OkCKQV8hq20zAsCPGZpjVrqcAtPJ66GCtG4N/5r/zZc29JkfmOvuWOS596
         JYybVwDFbRYt3jkqIeu73mYKsnYOitIdZVnG20lzjj88i7nYSaRwMxoT4Pho5LYTl0cY
         j1RTueVXK0f02z0Fgze8B+FRfrXVhBLzP0auWr+fuBqVOxmCaSBqA/xgXGeySEqRCXm1
         K09qa6/6P+24rkZO320tPX7yFgsVFnVuIRigt/y4n86NzADiE9bAJRjCco+v79nVCqaN
         nGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756153497; x=1756758297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TfikVf308PpMc/N4oFUO7YJyv5s2vYCUTzb6GKZu4Y=;
        b=n/onuv/D/X5BzNqjY6o/gpALrtg5DlhTsAy0tAYmV1PmUMFf7ZIMjHq+/cSolxedkZ
         x7OQ0AV8GNDkDyd0oTptNCbBfSPIY8opEqQAdCiAUMu1c/ueY55GmKAeUEXg/FnFdoIV
         P2uW+U+5Sn3nQbZgA8ucuUaQEEbihjGX4O32tbZmMewu8Dzcmp8c/zzjxszJ7YnxqmdX
         /Qop9F9dUVC0KsUnYsVnMOE4v7lyHsL0FbAoF07TYOIHfP06GxHLSpf4nIsLkR/zltym
         /Vgd4mPkigUoRqRF2PNpOEx3Yshtfbls8kUKNT5chDI5a9vls5X2WoHb+XEuzvHtOUZ4
         NC+w==
X-Forwarded-Encrypted: i=1; AJvYcCWkP0K9hQCSBrjV2dQdxCte0hyYi9FmWF9BOa5H1kDqxQIEzD3UYl+0c8+YWvkjD+FIm06lfcZVxn3eC7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvfONaO9NT2rL+4nfMHIuVhn0wFgVqP+PF/W0Mt1oDfE1bl+Sd
	3oQRTwAL1QC4AMETRlwvHacvu86/By5xZny+h+eYLvXriUqDSzj0xbLT0kJuajYwMw==
X-Gm-Gg: ASbGnctpIt9CWepUwT3Qz+ZBTfJIUYjbCJjVNjBA8MPFsvTU4Yk2Yl49aWlAz9b40H5
	9TAbxwbJiASFXhiHCdxVp1MbE07P1wJ9ffndsymhYqjBORzZa6fkrxtOlPP/qKsPtJ11hgWOJkR
	c5v64SHbKbDd0hVpsMVP5YHVfso47L/eiZVAFZmiGFDAW7yq2uPo45vWB7WHeMcFLDZ6jF0Fzo1
	k95psTBb8cIyZ56OzXQfRuctZuXIsvKx6lkkkjgZsoZ6VjYPXk+ibz7Oed6exJF9TFHVnAfdV3j
	HZemiidf8tFth68fEc/JPH0qTOCg0c1uaF+WUFK89rKxBuU5V7Bm9ojN3A3a7DRR5Eblj1cx8gh
	wQCkCAetM9Swj5iQVCFC2CdF7JRWuqhwW37MShgq1BdT2RwQm+ImAxfkYi2i6rfy1fw==
X-Google-Smtp-Source: AGHT+IGQ5/hCMHchSsFnb3B2EoIzXCwumUMSb2V9r+lfxehHdhY4OJowTiyyCbq9JSIqIYs9+lk/nA==
X-Received: by 2002:a17:902:e848:b0:240:2bd3:861 with SMTP id d9443c01a7336-2485bd5ad0bmr905585ad.10.1756153496733;
        Mon, 25 Aug 2025 13:24:56 -0700 (PDT)
Received: from google.com (78.237.185.35.bc.googleusercontent.com. [35.185.237.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a662dsm76493105ad.49.2025.08.25.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:24:56 -0700 (PDT)
Date: Mon, 25 Aug 2025 20:24:52 +0000
From: Prashant Malani <pmalani@google.com>
To: Beata Michalska <beata.michalska@arm.com>
Cc: Yang Shi <yang@os.amperecomputing.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ionela Voinescu <Ionela.Voinescu@arm.com>
Subject: Re: [PATCH] cpufreq: CPPC: Increase delay between perf counter reads
Message-ID: <aKzGlD7ZDIS4XMsF@google.com>
References: <20250730220812.53098-1-pmalani@google.com>
 <8252b1e6-5d13-4f26-8aa3-30e841639e10@os.amperecomputing.com>
 <CAFivqmKZcipdc1P1b7jkNTBAV-WE4bSeW8z=eHHmtHBxuErZiQ@mail.gmail.com>
 <aKRDxhirzwEPxaqd@arm.com>
 <CAFivqm+vzkbDEadJEF2So9ZWcRyVT_-Yc+8VWWwsgGW+KD4sNw@mail.gmail.com>
 <aKY0xuegI1S4X2uW@arm.com>
 <CAFivqm+Xi9FYtzPmT0QkAUxC2Kx_AkrH2NuQE_sVnJVuo48ypA@mail.gmail.com>
 <aKx4nZWsRPTXK942@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKx4nZWsRPTXK942@arm.com>

On Aug 25 16:52, Beata Michalska wrote:
> On Wed, Aug 20, 2025 at 02:25:16PM -0700, Prashant Malani wrote:
> > Hi Beata,
> > 
> > On Wed, 20 Aug 2025 at 13:49, Beata Michalska <beata.michalska@arm.com> wrote:
> > >
> > > Kinda working on that one.
> > 
> > OK. I'm eager to see what the solution is!
> > 
> > > >
> > > > Outside of that, I can't think of another mitigation beyond adding delay to make
> > > > the time deltas not matter so much.
> > > I'm not entirely sure what 'so much' means in this context.
> > > How one would quantify whether the added delay is actually mitigating the issue?
> > >
> > 
> > I alluded to it in the commit description, but here is the my basic
> > numerical analysis:
> > The effective timestamps for the 4 readings right now are:
> > Timestamp t0: del0
> > Timestamp t0 + m: ref0
> > (Time delay X us)
> > Timestamp t1: del1
> > Timestamp t1 + n: ref1
> > 
> > Timestamp t1 = t0 + m + X
> > 
> > The perf calculation is:
> > Per = del1 - del0 / ref1 - ref0
> >       = Del_counter_diff_over_time(t1 - t0) /
> > ref_counter_diff_over_time(t1 + n - (t0 + m))
> >       = Del_counter_diff_over time(t0 + m + X - t0) /
> > ref_counter_diff_over_time((t0 + m + X + n - t0 - m)
> >       = Del_counter_diff_over_time(m + X) / ref_counter_diff_over_time(n + X)
> > 
> > If X >> (m,n) this becomes:
> >       = Del_counter_diff_over_time(X) / ref_counter_diff_over_time(X)
> > which is what the actual calculation is supposed to be.
> > 
> > if X ~ (m, N) (which is what the case is right now), the calculation
> > becomes erratic.
> This is still bound by 'm' and 'n' values, as the difference between those will
> determine the error factor (with given, fixed X). If m != n, one counter delta
> is stretched more than the other, so the perf ratio no longer represents the
> same time interval. And that will vary between platforms/workloads leading to
> over/under-reporting.

What you are saying holds when m,n ~ X. But if X >> m,n, the X component
dominates. On most platforms, m and n are typically 1-2 us.
If X is anything >= 100us, it dominates the m,n component, making both
time intervals practically the same, i.e

(100 + 1) / (100 + 2) = 101 / 102 = 0.9901 ~ 1.00

> > 
> > There have been other observations on this topic [1], that suggest
> > that even 100us
> > improves the error rate significantly from what it is with 2us.
> > 
> > BR,
> Which is exactly why I've mentioned this approach is not really recommended,
> being bound to rather specific setup. There have been similar proposals in the
> past, all with different values of the delay which should illustrate how fragile
> solution (if any) that is.

The reports/occurences point to the fact that the current value doesn't work.

Another way of putting it is, why is 2us considered the "right"
value?

This patch was never meant to be an ideal solution, but it's better than what
is there at present. Currently, the `policy->cur` is completely unusable on CPPC,
and is cropping up in other locations in the cpufreq driver core [1]
while also breaking a userfacing ABI i.e scaling_setspeed.

I realize you're working on a solution, so if that is O(weeks) away, it
makes sense to wait; otherwise it would seem logical to mitigate the
error (it can always be reverted once the "better" solution is in
place).

Ultimately it's your call, but I'm not convinced with rationale provided
thus far.

Best regards,

-Prashant

[1] https://lore.kernel.org/linux-pm/20250823001937.2765316-1-pmalani@google.com/T/#t

