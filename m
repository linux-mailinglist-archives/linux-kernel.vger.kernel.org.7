Return-Path: <linux-kernel+bounces-757147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C64AAB1BE4C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 03:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7077F18A6324
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48CF17B425;
	Wed,  6 Aug 2025 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF156oAT"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C52428373;
	Wed,  6 Aug 2025 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754443688; cv=none; b=GxF5bMr0Ys77+U/8Y0ZK+OzS7DLb5ZfnwxMYHgJo4JO2CEAeL1HQw+Prxnls6ZxdrDsZbDxQp6pdFFpsFl3+nkZZ2o+Tv3vpfT5APBqHjm2GAguPq/FkkcMbjINeEYjDcp43CsCKwbBg32rWcov64p6nX7pQ1JrlLtYsOgEB2Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754443688; c=relaxed/simple;
	bh=75UGmKi63vWlWvs53JfRNJALeLut97pl4NpjDjkn6hM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDkQWMCEKxTZ9hucW2CejEZMun75ymVfQPAgzcLJWsawPjZIArBdOXJGs4uBT6S2NTMD+1d92qXH3rMPfblcJNeUcQN0PBS4dzuGCAonPQ93ckVPTSxu7EB/+eqLycyekrHjlmuhgoH4abFTdFI1Ou1WsGHW3HM2BA7FwtHfYic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF156oAT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af90fd52147so931956966b.3;
        Tue, 05 Aug 2025 18:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754443685; x=1755048485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F174FEcKIx5bp+8tkyGPW+DIhLOLfIgidyWuudlk20Y=;
        b=ZF156oATLKiB0DPkl4j9Kv2jRdZ9bUCijq0ZblBApnHsrUhY3rqu1CdD9XCwhbe7im
         towAHfDc0SGwbu+plJ0FdKLnnR6KVxSoySA71tZUGnCWyj4SnwmjkmZCtGDRE4sPBtFQ
         G6Oonos3SgRoZPAh6/GAcas3xaHt8jy6jLwrkFOAqAtRVnK39nPg6+QlaU+4fGhoWoeV
         z2Xoy6QOBnnQ+H0aOvaFHOAx+/iks/SBXwSnw7cPi7Np4WOeydc1oXgnc13iKy8o9bdH
         xBCZl1vB/oOGK7yikE0ablDuw4ANY8sQ3wbVQsCLgst+5Z7XsqTUfSuck30ywStkfzXE
         MQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754443685; x=1755048485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F174FEcKIx5bp+8tkyGPW+DIhLOLfIgidyWuudlk20Y=;
        b=c9XhpsqRVD25PyqI6xMBVMHH61HjQWEocc+zE0g2X1D782WmXHadQu7nMmKOUwKEFL
         /Lo2ERumCuXNOPpRX6QnWNXwMEgyuTAO4VvOa7WerHSu58wN+6LfU7GaT915EWUpHuor
         ljgmbCluP7H2q2D5tsRMHOvU9z8/iSENcKIwnC6edHSDTE70WZdLhV5AC9j4DxHMwWDi
         X2LIFOhjUWwkvOGMn4ySTVmhWuzlhD15X8WTqX5qsD3ErbVYhoS9P1tKUbArJmP9URo2
         hw3TBNTuxDawiUbI7E/eR/Ka4yPJEl7SZs0DzJiI6yi4uNDPBoPqQ/FhMV2OiQA+Z/U5
         ZU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKTup4ZxwL/MDfhPWZVDs3yq1Qf/e3bEBTSzBX52IBux07Vtzo0YShfw18T1SuglrO8C2xEKYWeBRW56i4@vger.kernel.org, AJvYcCWBrze7suKAPpXfpjEXYe6JfrLf2Ju1AgzrB0kA646Y22/AnzYCV/KarIHPBaIU6J4zXgr0PFw0DLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg6IUISNU0/Nd9EA4E0aS4K+Rcu5oMBwiI7IekKRV324bzP5I0
	VTzWiBAGYZSXmf9douR7R+a/ZDS3xG1pJRk05JOa4baIh/X/X0+c15AZuo+nisGOCuQJ0F0LIXH
	IvLBOD3mGellpYFN+s0u/421Fsw/8Oms=
X-Gm-Gg: ASbGnct9xxW7HSIci+Cf+BczjdzXrKJmXjJQ6X6ctWukw1+UaJhUunwoVsrhrlEXMw/
	bN1y4ZcSdNrOKUX5KeH1RU0tyH6lqwdvw0ShiqW4xiOnuu/WsXMzESJJUbPLIYfEMGfsTAV2+60
	w3hd96j8Ix8w4VuTDupUY4XorYNA04L7qONNuhrE99rXVJjno+zWvdgMCkZhPMIQAECPCOkvQAD
	nGM5wTpVfb6NM7UmLaoEETVtEEg4kNQASoRH5YNeA==
X-Google-Smtp-Source: AGHT+IEtxmGoVXyQi9biUweIxyKxBVbBBTXXXrLHkql4H2KhjN85v5kEqkNbiWpW4Q+t3I4jyPYF5sb+cMzt7HA9eSA=
X-Received: by 2002:a17:906:6a14:b0:ae9:c2b9:7eba with SMTP id
 a640c23a62f3a-af992aab7a3mr52454566b.24.1754443684401; Tue, 05 Aug 2025
 18:28:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805162022.4920-1-bijan311@gmail.com> <20250806004003.52864-1-sj@kernel.org>
In-Reply-To: <20250806004003.52864-1-sj@kernel.org>
From: Bijan Tabatabai <bijan311@gmail.com>
Date: Tue, 5 Aug 2025 20:27:52 -0500
X-Gm-Features: Ac12FXxqXWKYvb2iP2635uUmCnKs4Ru4zZPjGe2tc8MxztU1iI9ZJV3Enr-80ws
Message-ID: <CAMvvPS6hfCRh1fQh5zU5_quswPFVp0zWyS9N-Zikc0K-nSZd_g@mail.gmail.com>
Subject: Re: [PATCH 0/5] mm/damon/sysfs: Add commands useful for using
 migration dests
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net, 
	Bijan Tabatabai <bijantabatab@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi SJ,


On Tue, Aug 5, 2025 at 7:40=E2=80=AFPM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Bijan,
>
> Subjects of patches usually be converted into lowercase when be merged in=
to mm
> tree.  I'd suggest using lowercase even in patches stage, if those aim to=
 be
> merged into mm tree.

Noted, thanks.

[...]
> > The commit_schemes_dests command, similar to the existing
> > commit_schemes_quota_goals, is used to commit only the dests fields of
> > schemes. This has a couple of benefits:
> > 1) It is more efficient than recommitting all the DAMON data.
> > 2) Doing a full commit resets the aggregation and ops_update intervals.=
 If
> > a user sends the full commit command frequently (relatively to those
> > intervals) the aggregation and ops_update events will be prevented from
> > triggering. Having a separate commit command side steps this problem.
>
> I agree the commit command of DAMON sysfs interface is inefficient, and c=
ould
> make the infinite intervals delay problem.  But, I didn't expect there co=
uld be
> use cases that use commit feature frequently enough to make the inefficie=
ncy
> and the intervals delay be real problems.  Could you please let me know m=
ore
> details about your use case and how severe problem DAMON is causing?

In my use case, I am trying to optimize the interleave ratio of
applications to maximize their performance without prior knowledge of
their behavior. To do this, we take the steps of updating the ratio,
observing how the system reacts to the change in ratio, and update the
ratio again accordingly. Because we want to approach the ideal
interleave ratio quickly, we update the weights frequently, motivating
the commit_schemes_dests. Similarly, we want to observe how the system
reacts to the change only after the change has been applied,
motivating wait_for_schemes_apply.

The consequences are not very severe. The problem can be worked around
by either updating less frequently, at the cost of converging slower,
or decreasing the maximum aggregation period, which from what I
understand may affect the access monitoring behavior.

> Depending on the real problem, I'm wondering if optimizing commit command=
 can
> be a solution.  For example, skipping the update of next_aggregation_sis =
and
> next_ops_update_sis when the intervals are not changed might be able to s=
olve
> the intervals delay problem.

This would work for my use case. Another option might be to have a
more general commit_schemes command, which may be useful to other use
cases. I'll defer to your judgement on which would be better.

> >
> > The wait_for_schemes_apply command causes the calling thread to wait un=
til
> > all schemes have been applied. It does this by calling damos_walk() wit=
h a
> > NULL walk_fn. This can be useful, for example, if a user wants to know =
when
> > new scheme parameters they've committed have been applied. Another use =
case
> > could be if a user wants to record the system state every time a scheme=
 is
> > applied for debuging purposes.
> >
> > The functionality of wait_for_schemes_apply can be achieved with the
> > existing update_schemes_tried_bytes and update_schemes_tried_regions
> > commands. However, having a separate command avoids extra work and make=
s
> > user intent clearer when used in scripts.
>
> I agree extra works are always better to be avoided.  But is the overhead=
 large
> enough to be a real problem for your use case?  I also agree it could mak=
e the
> user script cleaner, but adding a kernel feature only for user scripts
> readabilities sounds like too much, since the user script could have its =
own
> abstract layers for its readability.

Totally fair. I will drop wait_for_apply_schemes in any future versions.

> Also, even if the new command is implemented, since the DAMOS schemes con=
tinue
> running, the system status will keep changing.  If you cannot do the reco=
rding
> of the system state in a restricted time, the recorded information might =
not be
> that reliable.  So I'm not sure if you really need this strict waiting in=
 this
> way.

Fair. That was not something I was personally using the command for,
just another possible use case I thought of. Regardless of the
usefulness of that, the existing commands using damos_walk would work
well enough.

> Could you please share more details about what you want to do with the ne=
w
> command, and how much problem you are seeing?  I'm particularly curious w=
hat
> system state you want to record, and why you need to wait the exact time
> interval.

I mentioned this above, but I am using this to wait for new migration
weights to be applied before monitoring how the change affects
applications, but again, this can be done with existing commands.

Thanks for your response,
Bijan

