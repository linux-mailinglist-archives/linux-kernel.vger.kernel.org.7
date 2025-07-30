Return-Path: <linux-kernel+bounces-751394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76302B16919
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4A957A7848
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53F323183F;
	Wed, 30 Jul 2025 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OPJG5JLd"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFEB19C556
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753914917; cv=none; b=jskBu0VmwqiLbIJe9pwcm2fBGxdhZg/kKpTJ7udfd/r0CtKfwl2JzAWWlyPH++gWQPWqfaKM03itZT5LSTZnUK71IeoZNNJZH8o4k2aavW5wohJux/pp7KANyVxqWPyzthX/v0pr6yoBc0SIRtf4o1aSmvNzF6PI7eVGH0erRTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753914917; c=relaxed/simple;
	bh=jfql98Qqf0shdOGsC5v2Z64OSdT/3H+5m6YBOSS0t/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsRZqdity07GEvnnEfu6ZS1Fm2yDzbQGPrWjPZAnBq6vmk/KtMfoeLZjjb9ezZDXpNjgn3m9dDOvN6SgKSq6/45sFb3OJLOpYhnRwN6LTMRFF/vfucUmwJTwt/dJANBRb28y999pgSclpOcORQIOGYubeouc4W8/DZf5Pb39BzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OPJG5JLd; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-615398dc162so395280a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753914913; x=1754519713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yms1ND+K2iHPyJhaAEq3bt/tYJep9pI9jrxC20mJJQw=;
        b=OPJG5JLdC+O13i+0NVl3TkaedRgR4TD/wD7d96aIMTgGttBrkEXslKUXLv0WDV3PWk
         9oUwZu73TY0ySJofYta2mIzh/ELuGbcPncUVFU4nwn24NLowvPwS1dUj7XCj7s2QfrVv
         +IMlWMa1jB8dmFe3qx4sgy+xoh8Z95UStzlwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753914913; x=1754519713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yms1ND+K2iHPyJhaAEq3bt/tYJep9pI9jrxC20mJJQw=;
        b=RFIjVavmbkQsNyQjXgkz4MY5pGTA9xDmwDmphS4BC/+cWHi0ITGUEGohkvanvKc77Y
         heu3FR/D0PeaRnZOT9x03NYGdgvh/eo2XYR7T4n+ic0kHBUQfYCzpA4R82wITF6Yvn4V
         wqQOm0OvzmsZGQWv4U+WjPKASIMkWzaRBaJ+8le4AeXTKfIVqqc70IWQPxZJEBM9nhS5
         BPQcHU+ub5M97F607g6VEPdI/8Vivw+mllWxZgOlhnUoPmlU8orSiB2VxB2TOFfbeeSn
         DaAXw9IbEJl597hcM/5xEuxeoDI0Hr8KUZbQJ9ds9HCw0tadkl7KnDpWIBNwNzwpNUpX
         ranQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI/KWNr8wDMakRbaDvA8wvCuNCGf8Psy8i1LnoLAjeunbrKdUr/VQ4JnPQY86Pr0XTbGNEzqvBrlGgeQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGrWwxBgXIje3IRExHr9/tANc4ZIjmYUVyJ08H807MEQLtCeJq
	4reQqRHTh/8PwQUVQUNPBV+hzNYh2dz+aCf4Ddjwdcavl+RdWfmNFywo54tOhVHgqsy2iGAcIAq
	cctq5WJs=
X-Gm-Gg: ASbGncueo+zPQTDjaxAM985Lkppjk+OG3jj4J0uJA4HJ5z7My/xC1ENCwGf0a9253AY
	aNp9g7i075kYBPPlizP8loivG1FY8JVdO1tFld5RYGqQZ1J+N894R0Bmfs7S+tMKOWMnnRrc+Pa
	2x7QscDoYejziDNEtmlddqKYVudaGIfxONnT+TKJ15JTfWmh54Z7Z+ZVK+22CpfWHB6WO6rsACJ
	uUreNNM/bY3yfdZ6i3l6Y58EdyQG1s/+HZOnv5Z0BvH7v49cjWdIbeNQOCKoFRlaXdQU+Qm/oS5
	B7+wOT336DXlLrtkSOPu2ffTev7H10duC7pXlj4o5SEzEKm5FkJJQAX0FkfqT2n0HasusjAVmhi
	8aqikiUR2rIgNH5ZlxjOXPfA/YU/2n+aIxbeuWXNPN87uJ4832K9CIx3nokkjupw8cxEWUgJr
X-Google-Smtp-Source: AGHT+IFRPLnhgjQJU9cwhCEukqhwq4kszIjhVKtQLj87a/7vUpMXguG8SnV+rj40zPjdBkRYaCoiVw==
X-Received: by 2002:a17:907:60c8:b0:ae9:8dc8:511c with SMTP id a640c23a62f3a-af8fd71460cmr558800166b.13.1753914913360;
        Wed, 30 Jul 2025 15:35:13 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0a39c4sm9700866b.43.2025.07.30.15.35.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 15:35:12 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61571192ba5so373816a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:35:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLCggijJdCGJnxrBpRYGuwattvnMzvAMIpjCBOGrD5QuceyZ96mr0ZzSZmQ0MyXmWCwEVkR+YLDal0wI0=@vger.kernel.org
X-Received: by 2002:a05:6402:2344:b0:612:7439:4190 with SMTP id
 4fb4d7f45d1cf-61586eeaec5mr5610895a12.10.1753914912312; Wed, 30 Jul 2025
 15:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726024605.GA17131@neeraj.linux> <CAHk-=wh1Cjqv08fdm3T3ZSBGN2vhMm00Ud+JjbWthK0RygMF0Q@mail.gmail.com>
 <ba898d9d-021b-40f5-9627-dce11e403fdc@paulmck-laptop>
In-Reply-To: <ba898d9d-021b-40f5-9627-dce11e403fdc@paulmck-laptop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 15:34:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWstOqx6Cbn_axAE-o=8-vcf5z_ZKDtytRw_osHLMGdA@mail.gmail.com>
X-Gm-Features: Ac12FXyWdse7MSeyh8So1MlV_rrBfw4q_ZgkpKwosCbZujeD34m-S0Vu_GNMhWQ
Message-ID: <CAHk-=wgWstOqx6Cbn_axAE-o=8-vcf5z_ZKDtytRw_osHLMGdA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.17
To: paulmck@kernel.org
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@kernel.org>, joelagnelf@nvidia.com, frederic@kernel.org, 
	boqun.feng@gmail.com, urezki@gmail.com, qiang.zhang1211@gmail.com, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, rcu@vger.kernel.org, 
	Tze-nan.Wu@mediatek.com, a.sadovnikov@ispras.ru
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 12:24, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> As it happens, I will be sending the pull request for the v6.18 merge
> window, so I will stop doing my usual octopus merges (hey, they *were*
> cool!) and instead merge each branch separately, with each merge's commit
> log giving a synopsis of the commits in the branch being merged.

Note that octopus merges aren't a no-no per se. Sometimes they make
perfect sense, particularly if there's a handful of really trivial
branches with just a commit or two each.

Then an octopus merge can be a really convenient way to avoid having
as many merges as you have "real" commits.

So don't take my comment as a "never use octopus merges".

Take it more as "octopus merges have some downsides, and making _any_
merge without an explanation for it in the commit message is bad".

The main downside of octopus merges really is just bisectability:
because even if the problem doesn't end up being the merge itself, an
octopus merge can make it fundamentally hard to do the "cut the
history in two roughly equal points for testing".

But again, that's not a problem if you have just a fairly small
handful of purely trivial commits.

So people just need to balance the "octopus merges are cool, and can
avoid pointless repeated silly small merges" with "octopus merges can
make for bisectability issues and should be avoided for anything even
halfway comples".

(Also, try *very* hard to avoid octopus merges when any conflicts
exist - even trivial ones. Octopus merges with conflict resolution
take "that's hard to follow" to a whole other level, to the point
where you really shouldn't even try).

> If you have a best-practice series of merges example in mind, could you
> please point me at it?

It's hard to give a good "typical" example, because I don't think
"typical" exists.

Sometimes a simple one-line merge message just stating "Misc fixes for
subsystem Xyz" really might be the "proper" merge message.

Because maybe that branch really had all just tiny uninteresting
fixes, and git shortlog entirely describes it all to the point that
writing anything more would just be wasting everybody's time.

Honestly, the merge messages you guys send me for *my* RCU merge are
fine - the only thing I ask for is that instead of describing the
branches with an esoteric branch name, you write them out for humans.

So having the header read "Improvements expedited RCU grace periods"
or something is just _soo_ much more understandable than
"rcu-exp.23.07.2025", wouldn't you agree?

As to the merge messages for *your* own merges, where you just put
several branches together in order to send the result to me: knowing
that there will be a more complete message in the upstream merge, I
think the main issue is to think about people who hit that merge
because they have some issue.

So again, it might be because somebody ends up hitting that merge
during bisection, or has some other reason why they are looking at
that merge in particular, rather than the "bigger picture" upstream
merge.

In other words, please write merge messages with the intended audience
in mind. They don't necessarily need to be the same kind of
full-fledged explanation that I want to explain why I'm merging (and
for people who follow the development process: people most definitely
look at the pull requests that come upstream, and it's informative to
not just me, but you find tech press etc looking at them too).

But you should at a minimum think about "what if somebody hits this
during a bisection". Give those random developers a clue about what is
going on. Don't just make it be that "Merge branch XYZ", because that
tells _outsiders_ so little.

Does that make sense as an answer?

Anyway, I'm happy to say that if you are looking for _examples_ of
merges, we have tons of them. I'm proud of the fact that I think
kernel commit messages in general are very good, and when I compare
them to other projects I feel like we tend to do a stellar job. And
I'm not just patting myself on the back, we have tons of good
examples.

So you can do a

    git log --merges

in general, and while you'll find some that just list branches, I
think most of them tend to be very good these days. Look at the
networking and bpf merges, for example (so typically Jakub and
Alexei). Or the SoC merges (Arnd), or the VFS merges (Christian
Brauner).

Or really most of them. I started looking for more names (the ones I
mentioned were people I already knew wrote good merge messages), and
really my reaction was that "most of them are great".

Good on us.

        Linus

