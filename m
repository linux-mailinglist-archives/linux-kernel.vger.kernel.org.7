Return-Path: <linux-kernel+bounces-845631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B470BC58F8
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3061619E3746
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199022F2602;
	Wed,  8 Oct 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RdHWSsWt"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB00287505
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936978; cv=none; b=KOiOvx1S99asLhIff9wwiinw4H8fHPjzJ861bh/9xXHEfBU4fop/M1tt7aVEVc3QyEHBXsNXFjlBlUX5ByhfqCiXWxr0dXmTZx3Vi2JMVDeArk88Y0KfwvVLOizAWL+4hOZdbilOcaKHrD0qGs0Q/FJPcJB6IZrSA5aFdHHDuy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936978; c=relaxed/simple;
	bh=2siM9yREqhk1evwBBV05rvjedon6J208mF1lxh+zAWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToRhopvNU/d6vxZjXHnVX4Bao1DbqyJSVCogRhYLIcFJTPLKN5o+yWU96GpFWUd10m4hQrSVXMjDd+Z4wZQ7AnQvDOs0IzZ7fXJPLmU9V1rz6LL8HZf8xCE9r6gyYutzpMxQwzGQPXjFb33NPU1ubsvaT7FwB2ZboALD1aFM3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RdHWSsWt; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so1246155566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759936975; x=1760541775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u8IL1MJVZcL+yeXHblmq6i6BaDGI2XMDGXwWjrVz72g=;
        b=RdHWSsWtcUl3GCRzqjOMvlcnMd8OsFhEz0QnpHvBv4qfuAox8SppXksx/Qc3QEchPu
         2NE2HPM88Pb6Na3iDya8bsWyj1juGEZpVsSO0xNNkQ2fu6jSaOMNeqJjHs+fgXWED9tE
         ANIWfbHByTVhBblhBoeuw7w87EHv4/qLJWS8Sw3O0SzFNr7ZlUDqx4cYTlkNgzPbyVIS
         h1WeqWV6+YnfCEyqap5aXx0GGCWsv+eopCa+DoNZ300pYbtwj+CxYb0fVSS8kBwrKveH
         Tq6sKNFTEnyBZliM27xPgpnEg1sMNWo4CmYc9zORqmQTrB5IcBkGLniygYH4Dqaz/ZXF
         1Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759936975; x=1760541775;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8IL1MJVZcL+yeXHblmq6i6BaDGI2XMDGXwWjrVz72g=;
        b=T41QWhnWtkNFsxsAOHNidKOA40+rMs5tNsqVdotcLgkql4UthiZNA2oYK9FI1VTUfB
         JSrSsgAGMAfXJJ0pXHCtW/Y/ZG3h/ZsYlk4WyFIUm1cdtIF0sCGAJeGcuExzw64sTIkR
         c4nJmzKTxw4XE1K3czGkwmphmIcWxU5EvWV7qg/UWbPpycl+zUOIjHEr2ffr+8Wah/zN
         eENG6I8O4xjD54nMQ6/kNUgrFYgTXUScdADga9KIX1MeQnO+3R2Z3QHrYaXQf72+NkdN
         px9NsCp7QPpjZ1yNvFnaOm+uQzbJ46b5MaowQHtJmc3d0GKweDZpDBJjGdHrJ5l5XO34
         gXgg==
X-Forwarded-Encrypted: i=1; AJvYcCW3Av3mjNeDYY5Zh9ndEHBi1+Q5jizf6iPI4z9lp2arxctryaoUh9lwEPbJsIQfVkcEYhR+1p+I9gCFXuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBMUtiakMJ3aKhUki103v3rbmBCI04rTD8JgpgLVQPfyvbF+gW
	xFPPcGzJsp5PlB+RIsIumzPuM9niE15aYfa2AVm9QXGXdPofuLk07gcwWosW5cAKOpjyBSmW344
	ZhCDo1PqTMhRD7uzemg8T4Ibc826iSV7+o3/yrgzP9zAIpB/35JpiI78=
X-Gm-Gg: ASbGnctOgFF7vIeFfaJNnyIgUBySxsDeMoRJewiS9x9mArZvd6pBeJ2n8gUUyixsJGY
	xSl1ptxe0q5+FXmFWkxiQiIELB1dGjrbakER5FX+u56JINZvgMgCk7mOadSzCkMXtFcjHBT68L6
	DEi+kOudFb3zdgiyc/PYPE3mxiD97l3Y0ec1fzxQhhHDckXlo734iKqgWdAPwSQnHUOz5Djvsqj
	u7G9Xv7hsAtiIDDD6sGHxFbAdVNQ06/PncLlOF69KfvLfcNSE3iU0k3ngy/89bY
X-Google-Smtp-Source: AGHT+IEv9slRsfR5X3TXspH/uXKr0CnvgtVOqHiGOTJdOEngGu5NvMTv0CV3ST5SsNBcsjOejLZBA905vSFz/HXp7oo=
X-Received: by 2002:a17:907:9404:b0:b07:c1df:875 with SMTP id
 a640c23a62f3a-b50acc2f5camr471007566b.56.1759936975069; Wed, 08 Oct 2025
 08:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006104652.630431579@infradead.org> <20251006105453.648473106@infradead.org>
 <CAKfTPtCC3QF5DBn0u2zpYgaCWcoP2nXcvyKMf-aGomoH08NPbA@mail.gmail.com> <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
In-Reply-To: <20251008135830.GW4067720@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 8 Oct 2025 17:22:42 +0200
X-Gm-Features: AS18NWCMZ89A2Uc8OjuCKIj0t-GYofpct9xdmPVvK_SHfZZWp3n4tWEOwjGeIvE
Message-ID: <CAKfTPtDG9Fz8o1TVPe3w2eNA+Smhmq2utSA_c6X4GJJgt_dAJA@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de, 
	Joel Fernandes <joelagnelf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 15:58, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 08, 2025 at 03:16:58PM +0200, Vincent Guittot wrote:
>
> > > +static struct task_struct *
> > > +fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
> > >  {
> > > -       return pick_next_task_fair(rq, prev, NULL);
> >
> > The special case of a NULL rf pointer is used to skip
> > sched_balance_newidle() at the end of pick_next_task_fair() in the
> > pick_next_task() slo path when prev_balance has already it. This means
> > that it will be called twice if prev is not a fair task.
>
> Oh right. I suppose we can simply remove balance_fair.

That was the option that I also had in mind but this will change from
current behavior and I'm afraid that sched_ext people will complain.
Currently, if prev is sched_ext, we don't call higher class.balance()
which includes the fair class balance_fair->sched_balance_newidle.  If
we now always call sched_balance_newidle() at the end
pick_next_task_fair(), we will try to pull a fair task at each
schedule between sched_ext tasks

>
> > While reviewing this series, I also noticed an older issue that we
> > have with check pelt lost idle time [1]
> > [1] https://lore.kernel.org/all/20251008131214.3759798-1-vincent.guittot@linaro.org/
>
> Let me go have a look.

