Return-Path: <linux-kernel+bounces-821733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E2CB82189
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF7B17C3A2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B021430DED7;
	Wed, 17 Sep 2025 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4xUEdvlz"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239DF30C118
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146684; cv=none; b=ZjlluFkHWzJg5EKIBJMjFdCRZ3TwKkL6+dAGP0SZ/LVNI3lwBo5hJg+QVGQTqdZez0nvje24wC0s4lkam5/CDMHtaUWaDX4Vdn0Dvtk9twJyAlGXTMJiN09G024AU4hRQh8Guv5KZbHSakBRe9zkEX1DBTe1ohzOg6j8qxIpgDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146684; c=relaxed/simple;
	bh=3B8ugtKg4GD1GWkRKEKHTDsKxMS02QOpYhTzseqwA9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQCGNtUR7254KDB/kpR6vPY0mrR7O3j3aoTlXwn1mmekTgU+WOY2zm5KU2KSi5tI/ITUhLJM19WjHFjy99qg2jlCQm8IOC1n5a7o6Ewe+s//ITQiGNmJmQ/3CZ4f/mNTsIoJWF9Thq59CxcYXTYg91cBkHMh3q09j76tQgNQPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4xUEdvlz; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b796ff6d45so72361cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758146682; x=1758751482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7c037OBepDtABbodeSYdc9GHv27CVVqxlwOzBg6Xtz8=;
        b=4xUEdvlzSf6WRc6y9xmXjjhtZOS7Gp/l1+6+mjGsY/WyNalC8fqnR271pfqMBsVmFZ
         3/oS3pSwXwXTLPDRsjBx3Q6dYHgF9yswMyAn7CJUcII0Tlhar43+oOME2l+xI6wa0TfL
         x+6EvMKkcapBBELPZmoMUwFSYMdpfzf9shE8vwZzXwBkeaVFuAEBEoWg2QoMfLIS3HVR
         EmI0zF38OoG1AdAjIa3nnSFzUGcJIpjQGlB0/CUucoxgB2+Z4Qk02yIvYlEmpEu76s/4
         AiK/n6SlC8xZFe+tDfTJWUUNmJ95PWdM6faUHJOMLKyZDbwSva7/ezgQDVFyJXvELJGE
         1uSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758146682; x=1758751482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7c037OBepDtABbodeSYdc9GHv27CVVqxlwOzBg6Xtz8=;
        b=qBIUuEAOQN5pzlUUE0aC9xmwNnJVsFQ6Q8C/LrmQUXPd9VswXjouqQ1xkQuHPcBR8q
         eai66ZdLfoYOxOMJsrMldjrL0xcUiatZeqSCGczbeMn0bywCYNe6O8yTI5NPdD5SF/E+
         AF3y8DhN/cd9j5JQioL5+5C69g63QDEMxymQRG4FRPiSGeTUdae4BEQS1MiJl0cSxDBW
         /rfB040K4DsUuKyvIolFv7IJSBgTkPpICm/gIz4c6ze4HmHg+1Ca7wy92nT4kV9pXnXZ
         1AEcfwemmXTTci3dgsfJ8NK7+Q6bbjIj+/bVKa2oIPkSYZqPuNTBLjcze/yNk2dY9Ke2
         2TrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB19mnleFkg7u1oNX86rP1/wuvPm9JMBNcpwe7BXzu+9sCeLIZpvyZTnkXpZs2/1kVUz1EN3ww/iKW464=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NUxKOV9dCel48xSRzj91oel3Hx2jiqU132fNUl7bYnVtj90d
	PLZ4N4SEusu/i4AKBkRHadH0+w64w1D2fiv3Oc3v/CI+kZDZvyh2VsrCCiH4cpSEpT6MNqjFKPh
	/61zkptD+Z0fuvWUB3UY2HMDSQtMi5C/AWrf2BiqA
X-Gm-Gg: ASbGncujYs2WKaXPqqIdoDUwdWizfu+h7I8mNPX/LCEjGRy2TNba5gZUatlTw7XO1xW
	Y+VSFCi1QRPL8hnLtoYzqgSv6p93mNs0J9QjCoDSOn0ICRkXn161owYUQ6xMXWmu1x9R8rC90lj
	7X1pKbtYyogpvQdd7Ab3fW2b8KXqCJytXSeD9UlFy0NAlIBb9o2PhH1lAsOs8uXXxYalRrelHif
	6wAEuGpFCEJUUy5ztCVn1Q3MNdkng==
X-Google-Smtp-Source: AGHT+IGDI6LJLfycjfeE1B/pgIh/9NIsQqEJIx7nxHWRrjhDqG/oq1RUbkZqCENyyqfCAvnUxyLWTbnk2uL801F6uvk=
X-Received: by 2002:a05:622a:8597:b0:4b7:9b7a:1cfc with SMTP id
 d75a77b69052e-4bbf022e4f3mr4682571cf.10.1758146681555; Wed, 17 Sep 2025
 15:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915195153.462039-1-fvdl@google.com> <7ia4ecs59a2b.fsf@castle.c.googlers.com>
In-Reply-To: <7ia4ecs59a2b.fsf@castle.c.googlers.com>
From: Frank van der Linden <fvdl@google.com>
Date: Wed, 17 Sep 2025 15:04:30 -0700
X-Gm-Features: AS18NWCkUN2Jz1n68DzLl5mlp3KsVWCGAZPBnGbVyd4mox136r8TgQG5palyZuI
Message-ID: <CAPTztWYp2yPsdvFfMm6bVB-juwHM11zKAEty9q+J8gy5d-8=KQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] CMA balancing
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org, david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 5:51=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Frank van der Linden <fvdl@google.com> writes:
>
> > This is an RFC on a solution to the long standing problem of OOMs
> > occuring when the kernel runs out of space for unmovable allocations
> > in the face of large amounts of CMA.
> >
> > Introduction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > When there is a large amount of CMA (e.g. with hugetlb_cma), it is
> > possible for the kernel to run out of space to get unmovable
> > allocations from. This is because it cannot use the CMA area.
> > If the issue is just that there is a large CMA area, and that
> > there isn't enough space left, that can be considered a
> > misconfigured system. However, there is a scenario in which
> > things could have been dealt with better: if the non-CMA area
> > also has movable allocations in it, and there are CMA pageblocks
> > still available.
> >
> > The current mitigation for this issue is to start using CMA
> > pageblocks for movable allocations first if the amount of
> > free CMA pageblocks is more than 50% of the total amount
> > of free memory in a zone. But that may not always work out,
> > e.g. the system could easily run in to a scenario where
> > long-lasting movable allocations are made first, which do
> > not go to CMA before the 50% mark is reached. When the
> > non-CMA area fills up, these will get in the way of the
> > kernel's unmovable allocations, and OOMs might occur.
> >
> > Even always directing movable allocations to CMA first does
> > not completely fix the issue. Take a scenario where there
> > is a large amount of CMA through hugetlb_cma. All of that
> > CMA has been taken up by 1G hugetlb pages. So, movable allocations
> > end up in the non-CMA area. Now, the number of hugetlb
> > pages in the pool is lowered, so some CMA becomes available.
> > At the same time, increased system activity leads to more unmovable
> > allocations. Since the movable allocations are still in the non-CMA
> > area, these kernel allocations might still fail.
> >
> >
> > Additionally, CMA areas are allocated at the bottom of the zone.
> > There has been some discussion on this in the past. Originally,
> > doing allocations from CMA was deemed something that was best
> > avoided. The arguments were twofold:
> >
> > 1) cma_alloc needs to be quick and should not have to migrate a
> >    lot of pages.
> > 2) migration might fail, so the fewer pages it has to migrate
> >    the better
> >
> > These arguments are why CMA is avoided (until the 50% limit is hit),
> > and why CMA areas are allocated at the bottom of a zone. But
> > compaction migrates memory from the bottom to the top of a zone.
> > That means that compaction will actually end up migrating movable
> > allocations out of CMA and in to non-CMA, making the issue of
> > OOMing for unmovable allocations worse.
> >
> > Solution: CMA balancing
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > First, this patch set makes the 50% threshold configurable, which
> > is useful in any case. vm.cma_first_limit is the percentage of
> > free CMA, as part of the total amount of free memory in a zone,
> > above which CMA will be used first for movable allocations. 0
> > is always, 100 is never.
> >
> > Then, it creates an interface that allows for moving movable
> > allocations from non-CMA to CMA. CMA areas opt in to taking part
> > in this through a flag. Also, if the flag is set for a CMA area,
> > it is allocated at the top of a zone instead of the bottom.
>
> Hm, what if we can teach the compaction code to start off the
> beginning of the zone or end of cma zone(s) depending on the
> current balance?
>
> The problem with placing the cma area at the end is that it might
> significantly decrease the success rate of cma allocations
> when it's racing with the background compaction, which is hard
> to control. At least it was clearly so in my measurements several
> years ago.

Indeed, I saw your change that moved the CMA areas to the bottom of
the zone for that reason. In my testing, I saw a slight uptick in
cma_alloc failures for HugeTLB (due to migration failures), but it
wasn't much at all. Also, our current usage scenario can deal with the
occasional failure, so it was less of a concern. I can try to re-run
some tests to see if I can gather some harder numbers on that - the
problem is of course finding a test case that gives reproducible
results.
>
>
> > Lastly, the hugetlb_cma code was modified to try to migrate
> > movable allocations from non-CMA to CMA when a hugetlb CMA
> > page is freed. Only hugetlb CMA areas opt in to CMA balancing,
> > behavior for all other CMA areas is unchanged.
> >
> > Discussion
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > This approach works when tested with a hugetlb_cma setup
> > where a large number of 1G pages is active, but the number
> > is sometimes reduced in exchange for larger non-hugetlb
> > overhead.
> >
> > Arguments against this approach:
> >
> > * It's kind of heavy-handed. Since there is no easy way to
> >   track the amount of movable allocations residing in non-CMA
> >   pageblocks, it will likely end up scanning too much memory,
> >   as it only knows the upper bound.
> > * It should be more integrated with watermark handling in the
> >   allocation slow path. Again, this would likely require
> >   tracking the number of movable allocations in non-CMA
> >   pageblocks.
>
> I think the problem is very real and the proposed approach looks
> reasonable. But I also agree that it's heavy-handed. Doesn't feel
> like "the final" solution :)
>
> I wonder if we can track the amount of free space outside of cma
> and move pages out on reaching a certain low threshold?
> And it can in theory be the part of the generic kswapd/reclaim code.

I considered this, yes. The first problem is that there is no easy way
to express the number that is "pages allocated with __GFP_MOVABLE in
non-CMA pageblocks".  You can approximate pretty well by checking if
they are on the LRU, I suppose.

If you succeed in getting that number accurately, the next issue is
defining the right threshold and when to apply them. E.g. at one point
I had a change to skip CMA pageblocks for compaction if the target
pageblock is non-CMA, and the threshold has been hit. I ended up
dropping it, since this more special-case approach was better for our
use case. But my idea at the time was to add it as a 3rd mechanism to
try harder for allocations (compaction, reclaim, CMA balancing).

It was something like:

1) Track movable allocations in non-CMA areas.
2) If the watermark for an unmovable allocation is below high, stop
migrating things (through compaction) from CMA to non-CMA, and always
start allocating from CMA first.
3) If the watermark is approaching low, don't try compaction if you
know that CMA can be balanced, but do CMA balancing instead, in
amounts that satisfy your needs

One problem here is ping-ponging of memory. If you put CMA areas at
the bottom of the zone, ompaction moves things one way, CMA balancing
the other way.

I think an approach like the above could still work, I just abandoned
it in favor of this more special-cased (and thus safer) one for our
use case.

- Frank

