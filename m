Return-Path: <linux-kernel+bounces-723183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 310B1AFE41D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8398E587CCB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EAF2853E9;
	Wed,  9 Jul 2025 09:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gynvY8z2"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2179DA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053551; cv=none; b=WKHZ5lbyjs+nvVc+fodVcKVnm52z3aocVymoLfc0bE0hIYecwwo/JBGhjAuYauCPNnRL9WG9YIJY/dc8YFrvgtv8aq2zBo8UOW77Xw0N19anmqPNp4H/Qgmp3NgrDdjKHuLEJf9uEcKNk9K2LmuPFgtSTbppbrllf4ycjxESzV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053551; c=relaxed/simple;
	bh=zjH8+/U1iJ//UP35/wxHaU8FdQSVss3SagWg/XBUY8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s+pDDvBoDi3M8TSNAihy/SaJ6ug89T+DHn0YEi5pvgUkUkWbH/kZuEuPWQO2fqrDYhIHUiFYCOrJLnngfO6zaGy7Ts4QH3NTUEx1CNBNEealfjS1eOhK2/QDODZAPWzGQO+WwJk1dlPfosv+avHh/Iiriq6zWMJSD9OUCpaaDR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gynvY8z2; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ae0df6f5758so886130066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752053548; x=1752658348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0AHYyEXKZ8Ixtt9I9zB509gsctdtrgWCGCDn9OMXGSk=;
        b=gynvY8z2bAdfy1lFNBpcUIiggYGAACGEtZA4RkOSozEUPSqn9CAGsKik2GnNDrBZnc
         64dLjXSsXUlLlJRU0C2eeG4bDOzawueIYE4Rg3QYgpZVDdciPfvNsukIm2MtdnwmC4RC
         5ADleT8aEfqs8CswPOeWjrLkgtZ7VXqFdJ2Dp8VjrijZMXde1ibS3gDSa4ANibDlf7x8
         WEsibH2RTtzUw61lj6CKUc34e/7x2Vkz1HCF/3vjqfwEKDSYF4lgDKnDvdV5yWY2IhaQ
         CnQkHE+tEA5IdWyUOPrtITX5kaRbLDFjINjNVnu6kdqDdjaMZekV5IiC6o6V6VH9aHWk
         DnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752053548; x=1752658348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AHYyEXKZ8Ixtt9I9zB509gsctdtrgWCGCDn9OMXGSk=;
        b=Bk6DoRYXSP6q1VBKUggqdN/3KtFsmT4aRC5Aw4e9VwUGuZEKb+iwU0u1x2A+U8CuaZ
         u/vWkmf6BIM4Ks3yXUwDo8LRShXU8JFXYy4HHkNKA3+Jg0vNWLCntFzlcCthZPjuOFAM
         3ai8Op0ohPrM+5v6e2M2BVLDkgWO+o3nMMGAhxsZqs7anpgvtANttsDgQVCXWZcBV5xa
         H4HRoxln5oXZohu5OJMctLBOE85rcId8kpdkpbbv2pVHzBNnUUmnByvaFQcGBaRJYI9D
         Ly8dwnS/uIICKYEFpqUfw603S06gQ7krPMKyUlUqQmsZrZWmTWkVbOOYKVD83n5VV5bt
         HPWA==
X-Forwarded-Encrypted: i=1; AJvYcCXg9FtHvMmT/Ltk6RrNDGQkkHSbbQ0o2fzIWslN8IjUElg8LUOXt8yD6RlBETDJ59z/xIt1udQQ+8759vM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVzHtz3tEDzDYAj87ukaUnXZrpbEHOEEY1x08H7tn+B8avxlTM
	vMTB5x6YympxxdIq9bNX0RC7yaUsWiu1nxYQEJtaUSygAK3yudAuxgpcRjrJ4GyFbjuhfpPqMLg
	nKoQjgOFkudvzweN2OMEqOepgD0WBmK+ujq0/U/L38A==
X-Gm-Gg: ASbGncsb6n/WTYUHEdQwRd64yjg7VVUcoXTdXNm24u0hsJi/aQzWMlks3laRR3D3OzJ
	7cKe0p9Kbm0czZgMeh/ivtQsb5TE5qRa+DdGIouHZNngmHM25giNagtuGMBTd1bY1RWF+xjcyYF
	MY2URvSQA1K1ECN54+oIknepjXrKGUIuzjhK/9pen8zAH2B+s25ysGajS66/Uwlqog2QdnbrOV
X-Google-Smtp-Source: AGHT+IG8bfO/gFdlXUvaumYqPAaYmdmDzTpWjrD+uSuvQKITydKrcRFxkYtdISI/EGtotOp88qO2nXkQbsfg+mmz/Cc=
X-Received: by 2002:a17:906:730f:b0:ae0:d798:2ebd with SMTP id
 a640c23a62f3a-ae6cf73ec70mr179164966b.35.1752053547534; Wed, 09 Jul 2025
 02:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
 <20250708165630.1948751-3-vincent.guittot@linaro.org> <20250709091741.GH1613200@noisy.programming.kicks-ass.net>
In-Reply-To: <20250709091741.GH1613200@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 9 Jul 2025 11:32:16 +0200
X-Gm-Features: Ac12FXznBPqwqxWxeCICgy0VHp58ja9XbTtSByGNu6URmduiUNAvPkQ-If67HoA
Message-ID: <CAKfTPtCCWZWCft2GbCQL9Pqe9g_xi-pkCB50AQR9UEnmywqRYQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] sched/fair: Fix NO_RUN_TO_PARITY case
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	dhaval@gianis.ca, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 11:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 08, 2025 at 06:56:26PM +0200, Vincent Guittot wrote:
>
> >  static inline void set_protect_slice(struct sched_entity *se)
> >  {
> > -     se->vlag = se->deadline;
> > +     u64 quantum = se->slice;
> > +
> > +     if (!sched_feat(RUN_TO_PARITY))
> > +             quantum = min(quantum, normalized_sysctl_sched_base_slice);
> > +
> > +     if (quantum != se->slice)
> > +             se->vprot = min_vruntime(se->deadline, se->vruntime + calc_delta_fair(quantum, se));
> > +     else
> > +             se->vprot = se->deadline;
> >  }
>
> I've done s/quantum/slice/ on the whole series. In the end this thing:
>
> > +static inline bool resched_next_quantum(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>
> is gone, and *_protect_slice() has slice in the name, and its mostly
> assigned from slice named variables.
>
> Final form ends up looking like so:
>
> static inline void set_protect_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> {
>         u64 slice = normalized_sysctl_sched_base_slice;
>         u64 vprot = se->deadline;
>
>         if (sched_feat(RUN_TO_PARITY))
>                 slice = cfs_rq_min_slice(cfs_rq);
>
>         slice = min(slice, se->slice);
>         if (slice != se->slice)
>                 vprot = min_vruntime(vprot, se->vruntime + calc_delta_fair(slice, se));
>
>         se->vprot = vprot;
> }

ok, looks good to me

>
> I'll run a few compiles and then push out to queue/sched/core (and stick
> the ttwu bits in queue/sched/ttwu -- as I should've done earlier).

