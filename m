Return-Path: <linux-kernel+bounces-864111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02CBBF9F04
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888493AE23B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B2B1FBEB0;
	Wed, 22 Oct 2025 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PLYDxZ0M"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB102153ED
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107152; cv=none; b=JS1o8JNCk6sr7aAzJuRpoNLjvPfz+btSghJ1Tjh8NVhTnvbDea2Cp0q9JfBZl9M9jmas8jZUBuTULj0t0p5pVh/Q7CRWpl+gCiXq+xBTzGzVk9dQKOd9hLspwfMCCDxc0+E3tGVhfljkQ0m4fHkTMGP0chSw6USFUjlCMNYwAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107152; c=relaxed/simple;
	bh=hfRSNQb9rBE7UUr5J/K6aWGqynTuTf2c3cqKlfXvUig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSYVJZwXop8M60uCgR1kuivizxduiJsG1xME/XH68uGNxJPLeTA4h7vXTFQ20ice9zLJ0iCMab6Toa6VobbKqL3ajvqe+7sEQLXHy3UFk31us9yF9xyyFKNNH3Yw5+tYA4C6fUu01OSBFrJJwGuN+duJzOCW9SB3fizOfOU4gYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PLYDxZ0M; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1231248966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761107148; x=1761711948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UfKYMPlRA7Hil19lucydJ3Oagf4wOyjxoqA3QWKCuV8=;
        b=PLYDxZ0MIIDA3BcEQRCDkqqEoNrvpOjQZTwNcXdhZ02gfj05buWIaeXhCQTwaeQR6F
         xEYXVbxEfEc7iV8uNCiBPC6GwnIi96xb3F5+sh9uIX272ML6zw2/Nnx0z15XcYTWXyIk
         vFCrHVpATCoDRp66C6UMBVHlDi+B/3rfrJVM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107148; x=1761711948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfKYMPlRA7Hil19lucydJ3Oagf4wOyjxoqA3QWKCuV8=;
        b=GxBoXLq+swmTzFRW67OVgpReoEA3607ExX78zd63pJa9l0NNgtmK7S5JNidNSpBib2
         zLeQCfpVxINYmgkpbxKdH4aDd6bFuaAu8Hoz2RsXRXTZKg+HkTIa8ZTBUp4Wy6gopJsm
         nlPWnFfa0Q1R7zrv7fva3hO9XbHyQzSlOnWyNz8duWL8VkICm8feEng2u3SJEISELOYU
         haYvxiDRdC3SwwzLZyEgxjhLs5LA3aAt9sfejtHV5zjdn8eE8AvAIgupgD8upF7BHnYy
         7mh6kDYnOWxI1zT3xMX+z1j9Igib35mJXrwSIJ0aaLkMDSomBLirNmqY6SDn4whbEXER
         FghA==
X-Forwarded-Encrypted: i=1; AJvYcCUyV65TCWmG5ARDHquxyDrTo/yfDOUpGrYjpOCxruJ3gzi1KYARZQrX+6uihyiwrOv7xFpI3q7H+T28sZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUAhtjWzlsJ3yWM3YNpVbiF9K5LsTn5RGsqlNzWZvh1FRYVWOQ
	3yf234frkUuLPq5MPRLXcdMZsLg0xzGB4EvUPM0Fz3If5lZ5jbSkv1m+xsjDfjA8PeSFhKXEg2Y
	9cE51YIQsqQ==
X-Gm-Gg: ASbGncu/O66a8XoudnK/sgQB4GFKrLlBPQp3m/Csm333Z15MPLPZtl/qw1w7Kf5k2Sz
	s9QIkNtvUSdSibjLxV9MG4J3EHxGwEBwgwC+FMLkxL9fJhlrEACSf771Ahx1nqE4+Ckn7WXvB1D
	RNQSt7KG2xwPeROE4EiwJuxtY7UrWizPuF5gIEmgD5upKLnTPfmtAjtotDBXU91J1+EDmw3wqWz
	8VZLjKFR/e0dSJaquDkauCq6oviNRs3Ey6GKbZ3YcYiLsc/7s7AcOrc5lr+BnsPsIjEIjSB0bBH
	9FwENtOifcw85hBt7Acb/dFmlMAgaFkttBu+ag5o1kGbGw0lyzrJgBzCX0SIqBV2x9DPVjzhbTE
	0FDm+y5AzLj8auEvuEf4dxr10ma2jtHNJLzuOZt3nKBnxXDxvYrWTgNK3lCc8a+o/rZ7O4RHMjD
	qFYZ+JmPXaKqtwG2Yg/RlVb+PA0OYJy23773mMLBrNBwWbRLu9HA==
X-Google-Smtp-Source: AGHT+IFfaJ/KersTgdzD1WjvL1euG+CnyqUjjHfNE6Xor6yUGgSqvARGph6STv+72dj8Hg9HCNbv8Q==
X-Received: by 2002:a17:907:86a2:b0:b3d:9c3c:9ab6 with SMTP id a640c23a62f3a-b6473842ea5mr2142717266b.29.1761107148263;
        Tue, 21 Oct 2025 21:25:48 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da1ba1sm1241794566b.14.2025.10.21.21.25.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:25:46 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63d6ee383bdso3725380a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:25:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuz+NoCEkRh4DoggFbPpuUeVotnP2FvFmXQLgU8jwapWsS6ZeqWhD0GkKkj1rN2PN2lGQz6X84pvwY0B4=@vger.kernel.org
X-Received: by 2002:a05:6402:2113:b0:63b:f91e:60a2 with SMTP id
 4fb4d7f45d1cf-63c1f6c1fc8mr18494752a12.25.1761107146449; Tue, 21 Oct 2025
 21:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
 <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa> <aPgZthYaP7Flda0z@dread.disaster.area>
In-Reply-To: <aPgZthYaP7Flda0z@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 18:25:30 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjaR_v5Gc_SUGkiz39_hiRHb-AEChknoAu9BUrQRSznAw@mail.gmail.com>
X-Gm-Features: AS18NWB9CwG0IBKbkuN6M06jeHmD1GxcMpSycRZvl1CF5oywYvt7kYLWS-f-Gn8
Message-ID: <CAHk-=wjaR_v5Gc_SUGkiz39_hiRHb-AEChknoAu9BUrQRSznAw@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Dave Chinner <david@fromorbit.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 13:39, Dave Chinner <david@fromorbit.com> wrote:
>
> > > >   1. Locate a folio in XArray.
> > > >   2. Obtain a reference on the folio using folio_try_get().
> > > >   3. If successful, verify that the folio still belongs to
> > > >      the mapping and has not been truncated or reclaimed.
>
> What about if it has been hole-punched?

The sequence number check should take care of anything like that. Do
you have any reason to believe it doesn't?

Yes, you can get the "before or after or between" behavior, but you
can get that with perfectly regular reads that take the refcount on
the page.

Reads have never taken the page lock, and have never been serialized that way.

So the fast case changes absolutely nothing in this respect that I can see.

               Linus

