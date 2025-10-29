Return-Path: <linux-kernel+bounces-876957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A5BC1CDA2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6402918864C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576B3357A32;
	Wed, 29 Oct 2025 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzoijitg"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8EE280A5B
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 18:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764230; cv=none; b=o1LrMcxDWJ+LDhvfKAapp8BGxnhbabsQ/vLoXT228qLOPcPYKkKiEmsR6RjF3Nv5UexBRX15ju47i9aYM0NgJYQFxyRmiAQCNSx5wEJr4barYTR+x6PsFwsIzeUr5TL+Bitrfly8iamEryvW+oHHT0Rmcoj+f2uehqTLo8jN1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764230; c=relaxed/simple;
	bh=N5uoT83WJTfm5gzsownYquCbU4GphqfZlzXe3F9xqDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfq63d0cL8De1fJIZ81nRoxCdp27m2DLCI8xgtB+dHBHqmgWmin9o0TqAIxJF+TQGVM6tcXxc7rYF/QVAVVIl0gU2w4A/WLWE2hiJ+h1Lhw0vgytMVOn1GkyS7YFWxvv3nGrz1WrlGTiYYfQsVEKYJIzM2/0vbcEM2IQEa+lBOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hzoijitg; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-557c75fe551so171941e0c.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761764228; x=1762369028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5uoT83WJTfm5gzsownYquCbU4GphqfZlzXe3F9xqDc=;
        b=hzoijitg6PMYsOCtGKGDK+VcZvhOEyLgtgHo1dHOOPPZ6NgrwS+anfUxLoe4qFyaP1
         Vz3Q51UIFNOxR1MRZxLIRSMo6ojlKLKaxtQZ0z3WlVISwQuxGG5zrcMbGDdsj/4NDWUn
         IQ2Z/lPqq5M8rrlPKXEPlfd826GNIikAlNnZNEfRzEPZXYhX3ubc9ls0BAqgWg4Ueh2c
         XdIIGIeK2dMtLaSMJMCJdhqoB7DguWLrGaLL8uxXqaWwgrObEf04axdgC8WU0psuhmJG
         Q5vhqY3JtVmwqhxVBYNpG3cxDawRPn6GqkupXfgi9ZjiYCxHf6zpfu53PD0chqqn2ckX
         ECBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761764228; x=1762369028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5uoT83WJTfm5gzsownYquCbU4GphqfZlzXe3F9xqDc=;
        b=lfN/0hshom8+OojElAd0axQJlAmyYmfTUZiLB3A2AQNcncdTu9fVw7hcfBALnUOjkT
         JBR4t5JZiaQi2A3bRM0u8EldoOYB/HUxZNTV3/O5/amFxc57HCPJlGyazjwbPakcKwDF
         fkfS4xZyGFtYjoY5dSOXkcRwYZUaiRzm2X5vTrh5A9Qg17pY9XQlXnqwcpli6dOY7NTR
         QEgxR9D8lOD4nDcsYrK1gfR9PsDUMBF32m11XaPvHX11nqs8RELMLwI8DDUGckqOi2k0
         gudW5BrD8tFpQsZsKA7PpE8HAuumaOEt3tBeaV1TtXoDFIibhB2sXzQvKwRsGdTSFiQV
         Ym9g==
X-Forwarded-Encrypted: i=1; AJvYcCUhwqWOsIFP/1k9pnvYvkT4V6qBGPd/3i1Ju3PCngz1+QT2TAp/HFWD/haL3urL184hqVhWD7BiZqyBiyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmOPqTxKjp9B/ph5USmSsPLRBmHm2ob1r03Bqs3Zndcc5EWCO0
	u+TA29iFEqFupsz3lGFQA076bFZsSmK90hn6y5iv44hUKVVJeH73+7a1oR+w+MN47QIgrIacDEM
	YKixhtebjotpO1BxARpD+RLH0QabmVRsOLYJGyh14
X-Gm-Gg: ASbGnctWqRUvndsU6c/uQpZhZKwWWmCkBZpFu0uMtClZajBkih+NqTjKKwzZR4SK8rl
	lH/N7+bwLIEM1oNIM4Nw44JYEXH8VP4V+S/OjH8HNkAvIk7NflqT8UMSekDrbTa2c1XE0p9+dpH
	DyOFla8rtP+R03ULneuhxKk1K1YoBdjOsLP4dq6+0AqZpbNQvljj+QvWpnUFFV6/MLIjUwnmruY
	HCBa5BdZI2cgHI+Lvlc6F8COHyd6dCPdp7/WoaJfJQ9p1j4OvxhlffJr+lWew==
X-Google-Smtp-Source: AGHT+IEPmi8VDHy2k+OGe7IUmOdVu5T3QthsbK7rKDmp7fakDdkyTf0zP+6oR9ZoFCjEa8/OlwdJ/HnHFX8NVg4ByG0=
X-Received: by 2002:a05:6102:ccf:b0:534:cfe0:f85b with SMTP id
 ada2fe7eead31-5dba1f81df7mr155285137.20.1761764227751; Wed, 29 Oct 2025
 11:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028080348.2177469-1-blakejones@google.com>
 <20251028112901.GL3245006@noisy.programming.kicks-ass.net>
 <CAP_z_Cj_hVicedOGUCnXNVDXp_dWbG4az5J_w_g0xTMCTuuUrA@mail.gmail.com> <20251029091437.GE988547@noisy.programming.kicks-ass.net>
In-Reply-To: <20251029091437.GE988547@noisy.programming.kicks-ass.net>
From: Blake Jones <blakejones@google.com>
Date: Wed, 29 Oct 2025 11:56:56 -0700
X-Gm-Features: AWmQ_blXF3TivxBf6kc0dxtUlKdSOdy_iGizgpvVOgb2K3MuDUPbwnWZFXyPCtQ
Message-ID: <CAP_z_CiLDymFxijLK2Wv5UsydbOx1SoM6V6hYCgFckLs6HtBFQ@mail.gmail.com>
Subject: Re: [PATCH v3] sched: reorder some fields in struct rq
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Madadi Vineeth Reddy <vineethr@linux.ibm.com>, 
	Josh Don <joshdon@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:14=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> Most places that take rq->lock also update rq->clock. So I was wondering
> if it made sense to put them together. I don't have numbers either.

Makes sense. I think I'll leave it out of this patch since I don't
have numbers for it, but it's an compelling enough idea that I might
try to get some numbers and come back with a followup.

> > The line that I've moved it to has your queue_mask, so that's probably =
not
> > the best place. How about if I move it to the end of the structure, nex=
t to
> > cfsb_csd and cfsb_csd_list, since those don't seem to get used very oft=
en?
>
> Works for me.

Great.

> > Well, this is by far one of the hottest kernel data structures we see a=
t
> > Google, and it's not an obvious thing for a security vuln to target. So=
 I'd
> > be quite happy to add __no_randomize_layout; if you agree, I'll add it.
>
> Lets make it so.

Done.

I've made these changes and fleshed out the comment at the top of the
structure a bit more, and I sent the result out as v4:
https://lore.kernel.org/lkml/20251029185458.3040228-1-blakejones@google.com=
/T/#u

Thanks.

Blake

