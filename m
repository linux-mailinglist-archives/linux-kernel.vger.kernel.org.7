Return-Path: <linux-kernel+bounces-751568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31CEB16AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AC73A8866
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2661FAC54;
	Thu, 31 Jul 2025 03:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TaH9o1Su"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3DD1CAA4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753933772; cv=none; b=B4EuN0ivyOWwofSi4JDEJuZlkImigTP/Lj9FZt6HZA6MSryI9PSXaHdrDCTM9/BJqriRtW03YIyu1F77pYB5fW/WWnolk4gPvJ9JYYGAf46WvS51Gh/BJp9OX35xwNq2w61a/yTyrqnUvVJZkV0K5Q8/q7EEJWiOXoreia0NFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753933772; c=relaxed/simple;
	bh=fhawINARRJygDq0po3THoPnjgxj7yf1fdKxoQSioVSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svJD51rHSaV86R8CVjtSD8xU313K9dQ6mXPpRPbF4dJSdFlzAG8xdqCKxVVh8LqS/FiDCzPfj/Se/JcSo0xuWVbRKFu4H21cfWbQhwWYG9rw6AiHRJf1Rc4JPgzhY4PGIGY4obskkOiw0GNno31tU6i8srp+6SEJNTY+XzvqBE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TaH9o1Su; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ae9c2754a00so109066366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753933769; x=1754538569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O4eEVtAEJDb2ctLJ++Vqx913Dg03dcfMbig7xRZPFfM=;
        b=TaH9o1SuM9FZc9hvVC4ib/VwYz1BzscM4i7X3lng9tZnJUvT3mZHZ5kxqVBFLsK4JG
         KGSzbh3YFm2adQIzkviGgDhuW9CSHHEwZhG6ym5BNNCVD+uO9+8UVUNo9a3N8k9OMVpb
         yXzAKcthkWpUOklhdoKrP2qhACuK6tvyKS2d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753933769; x=1754538569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4eEVtAEJDb2ctLJ++Vqx913Dg03dcfMbig7xRZPFfM=;
        b=PEKWs0/lbeAL4jVGkrJFb0AGdfyCdCxmT7l69afEIn0PshZsmdhyeCyiVldMjXe/ch
         96Kx7TrBVA3eb+w18PuNphHNtPfc0Jan3wsOia4OZYvklXR/HHl5Z2dolOIyt/jzRCfc
         O/z61rsmiaCfuE2VVkMl//7In2KxYuQq+/Nk6r6FAsF13bUWXGD08sgSGwexE/X71GTr
         /r7n6lNeB4wYnh+rG9r65g3V/DpJdEOa70W1Bpzd2Gkee1/jjBLqcbe9SmDbrUfcaFoa
         peudsdUEOuIA4YgdfivByWmlAvVNrhJv9FegFOkLvcED0J5i0yScPCba1CCn8Y2BVwWu
         1E6A==
X-Forwarded-Encrypted: i=1; AJvYcCX9PVb+ENDoqG50R/9tGWmFo6dINreqScqptmXvLZG1CEe+c6LjwZw3IwLZrAuBi3jETgzw1ynjlTg0CgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU0yr/Xwj+OxIDSufwMg1oFdkbubzBXO0hId0kEbAX0DK3bUTE
	6uJcEdnHYBYRru8xLSQEMt0xrCO+/zm2HF1sq6IxKlIzgTDItO+g4nT+E5yMiQKe5dxD7cbgwWa
	3sIukdRc=
X-Gm-Gg: ASbGncvO0me63FnMpLt4KrZUdsJQzeiErTchGfzE8w/p6rqK6/0aO7RQZ8XKX9IeAkO
	V3HwKIcETf6BqMBx56afnamsn7SbA7blJnuhDuYnCtqW8vaf6oY21dlcfUGK/uaQ6XaqbKR5qvI
	+oO9QhlnDLeCOfmvSdk371bxG/6JNYmDwgWYfgoPjhCjlD/7HONkEg/xadgSWadvR3XYRMarZ+D
	ukKSoE2xWk09ALwTx+9HKDueqeG4lrD6yH0/nFabCBguo6IUyQxq7jPunxBpwwEjUo/+R2nmrFR
	wEodFSBnk6e7ELmKU39EYEjYxU3X40pz73R8l1Yan56N3hvv7mP1IY60g0mknUChh17EQiNBqk1
	ba8BdulhgI7Fao/MxSINOqFXHbevoDz495JA6sLJSIyf8x4TPDCHor/dDIqKpfLWlqK3jLQ+T
X-Google-Smtp-Source: AGHT+IGu1dL8VfdXqRhczcsYUUeQqNjT7qEhX0PyF4/iIWrQZevL0DrIIkFhr3z3X1wGLxrEIbo56Q==
X-Received: by 2002:a17:907:94c4:b0:ade:4121:8d52 with SMTP id a640c23a62f3a-af8fd728dbfmr708992666b.16.1753933768706;
        Wed, 30 Jul 2025 20:49:28 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e82fbsm40216366b.88.2025.07.30.20.49.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 20:49:28 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61589705b08so956659a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:49:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfnYX0UICadxPQppEtbC7RO0G9vA7MYEwD213/vD8V3bm2DyjRqMwNUBHZcMo0gZ3B1bGIkKXq3r2WNn0=@vger.kernel.org
X-Received: by 2002:a05:6402:234c:b0:615:aa8e:a19c with SMTP id
 4fb4d7f45d1cf-615aa8ea47bmr1012635a12.32.1753933767648; Wed, 30 Jul 2025
 20:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com> <CAPM=9twG7By95nYrkoyLtAT5YPV9WdMUgVPwjuZ9kiZFuse+Fg@mail.gmail.com>
In-Reply-To: <CAPM=9twG7By95nYrkoyLtAT5YPV9WdMUgVPwjuZ9kiZFuse+Fg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 20:49:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCQ5fYwt0X3mzD8zXK=pzWNYeFEUX=H6n4TWdjkOXbDw@mail.gmail.com>
X-Gm-Features: Ac12FXynvzq3d8ZVSwaZILoYPT2AjueV5j_-TkKoD5yqQDDlVrC4n1M2fNlJ904
Message-ID: <CAHk-=whCQ5fYwt0X3mzD8zXK=pzWNYeFEUX=H6n4TWdjkOXbDw@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Dave Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 20:39, Dave Airlie <airlied@gmail.com> wrote:
> >
> > But I do think that the drm people are doing actively wrong things
> > with the random cherry-picks back and forth: they cause these
> > conflicts, and I *really* think you should look at maybe using stable
> > fixes branches instead.
> >
> > Would that require more care and cleaner trees? Yes. And that's kind
> > of the point. You are being messy, and it's affecting the quality of
> > the end result.
>
> I'm not sure how to parse, stable fixes branch, do you mean stable as
> in a special branch for stable tree? or a fixes tree we don't rebase
> every rc?

I mean as in "don't cherry-pick fixes between trees".

Create a separate fixes branch that is *stable* and that is *shared*
between the trees.\

> Currently all the base (drm, intel, xe, amdgpu) fixes branches are
> stable, we backmerge into them after rc1, and very occasionally
> afterwards if a backmerge from rc5/6 is needed.

Not at all.

What you do ihas absolutely *nothing* to do with stable fixes branches.

You do random development in the main branch, and then when you make a
fix, you just do that in the main branch, and do a cherry-pick into
some other random branch.

Search for "cherry picked from commit" in your logs. There were *92*
duplicate patches that were randomly cherry-picked from on ebranch to
another.

That is *NOT* a "shared fixes branch". That's just throwing patches aroung.

And that is literally what is causing all the conflicts - you have
those duplicate commits in multiple branches, and then you do other
random development around them.

> We should only cherry-pick one direction,

That's nonsensical. There is no such thing as "cherry-pick one direction".

Direction doesn't matter at all. A cherry-pick is a cherry-pick.

It doesn't make one whit of difference whether you cherry-pick
backwards or forwards, rightside up or upside down, or while sitting
in a tree singing the national anthem.

The end result is the exact same thing. You have two different commits
in two different branches, and then you have unrelated changes around
them in those branches.

               Linus

