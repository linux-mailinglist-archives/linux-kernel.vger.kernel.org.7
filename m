Return-Path: <linux-kernel+bounces-787528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D10BB37784
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF521B64104
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7C21E7C2E;
	Wed, 27 Aug 2025 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GL2QpJq9"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AFA1C5F1B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 02:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756260445; cv=none; b=mBr2FSkCSNqum1zpAgJlF+PxHB+UqdiyVRvBNlsbh61NFXwFN30K1FzVr1lO+OC3yuKf9JsSCp3vAh5Bt06MVujtVt+nG3Mb1aZGe0IinWkcyGpV31snxJrJVKuSwwXeRN+FTzPROOpj2JKhip7U5wlNIcx/T91+Dp1cCGHb3TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756260445; c=relaxed/simple;
	bh=o1iBRenskZYXw/LogpEwmbVORqSVbHS4S2uEOxtc2nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=b88iHbA6Vgd8sHkAbEsIYFBFayd2jPcUPIC67tWqcQd4gUZ+UwqR+59GhH8sEaQmZGQxg60EQd06RvPH2OsBDuFmItapV3Fz1zUTI3Tcrezk0YEFyflFXhJiVNdBHzhKR633E/cscZ+o43nMP3191EDbOWouUnnIJW3bEK+lxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GL2QpJq9; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b2f497c230so15291cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 19:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756260442; x=1756865242; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWX1UVSegYtqh42uuyT4sZDPXoT9oomNFyTW1xLHoJI=;
        b=GL2QpJq9OuZ/ZoBQdHXDjCW/px0TTfNey/ih6DVt9JorpsoUr3D6Q4FYYxaG+dDSZ1
         EMi6UqiMFFXMdCBjpVL2M5Cmi9fBuo/LJE7y5pLPCZTO5cTq2+hmaSEWxJEgXTQZs8rN
         4SgDxgWun1xQgre0say4qXMYmJW4ArloJVpTe1HWcxfZmThgpwemYjyGXjHMoeNIRNyz
         paZCvq5fEKYuLgTFX7MZGQT58EI3nr7x7MmSXIc92EREuwwYSgwnxPQfdAs+iuuir4Sb
         oG22/kVfXdVO3oGhQugXlxHGTYdpFLxmjZycvz+VaeLNqenQsPSBjSG88wQipxtWQp4t
         h0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756260442; x=1756865242;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWX1UVSegYtqh42uuyT4sZDPXoT9oomNFyTW1xLHoJI=;
        b=Skv051HIzuwSVrWNPNAJpxjh2ARq3unQwTiRCDRamMRL8Bm24VgpuhcYFtrtWsOQP4
         QBAlXjduNRJQGEhryrDVlF2RKbU7rExr3ItfoP4Bk2caSix+lRTCezAp9o3IvZbidMo5
         GbzdHjmMtEelj9+qur7dYD0BU08gFOPaWsbTCi3BBk3R5xSNHvs0GXvMSYyxe3SC1U47
         t8kWAtImr7YUA/cIJHd29rqN2nLXxZ6gxFRVybne5WskWj4ivrXh5Ru81yOLlSJCOW8+
         DluPDcqFmWdI6NZkKAymG1oAfRFGnuJ+pz4/gEHG+uiyCcZeh+sOpR3zIsn5jd4DvqJ/
         TjWw==
X-Forwarded-Encrypted: i=1; AJvYcCWwl0Pxe+GtrhG5EtwvKj9AiyEf9MvfT75dnEqw772Rj7ET+nYdNXufyJi6isQ+6iSS+4NTAoNfrIb0tIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhAep5bBEfU6ibplHt3OmqVBkigThY1xxm/mPoO82kn1OozfhK
	NgDartpJrFyPNGr3cvqWwXCsq57YVDP/gWcWfQa4jN8MYZUrzvVUnIjZjzYPN1f4vTQ5ED54VxF
	Q0yGrAkCeGYPswmIXTNovuWZQiK3Ho/CZYlprbpFx
X-Gm-Gg: ASbGncuJ4muP7B30VEirCX05Mqv1fhHIqjsoglZS/2XFHg3pZ8QcmpgAuIsFKQnWvTl
	Og7a+69YMTn6ecuft7jSH7Jq19rGUYa8nWKiUTKTWP1UuwOKz3vbD4bGH3cH2WRqNndc8PS5DzX
	eH9svfbswpWv06xX5tFmk3XtC4xuRYbSLXtjwkzzAYNh4+ofqJXJEj6KucuOYYu4ZEqKBwMLBvx
	9MjamwNYGHF
X-Google-Smtp-Source: AGHT+IFRogYzpdvS27VPQDT5BDVWZvTYES2bLTvixxXlJL96BhN7ryYeZ5qbgFBB2ozo2W0txPoOEgVSyoAgjFH5kAk=
X-Received: by 2002:a05:622a:4d97:b0:4b2:ecb6:e6dd with SMTP id
 d75a77b69052e-4b2ecb6edecmr4306431cf.1.1756260441328; Tue, 26 Aug 2025
 19:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250723-slub-percpu-caches-v5-12-b792cd830f5d@suse.cz> <CAJuCfpFKjKAAyXgW_SFBXEp9N55txYdayw2h+=cSLO7wLvO2Pw@mail.gmail.com>
 <nhw4odptloo5dzmawss4q3mg7b5mtcfcs2z4flnqpduws7tlfj@hy75m647kp5z>
In-Reply-To: <nhw4odptloo5dzmawss4q3mg7b5mtcfcs2z4flnqpduws7tlfj@hy75m647kp5z>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Aug 2025 19:07:10 -0700
X-Gm-Features: Ac12FXyqChrZHz3YR-zpLBKUsTqUb5c1nq9CXpqMMwcgYfcr33pd3dv9X5JM3cY
Message-ID: <CAJuCfpE8+u73+COnB=SHmjJKHYJncLgdt8VMGCXR3JDDZ0+s0w@mail.gmail.com>
Subject: Re: [PATCH v5 12/14] maple_tree: Sheaf conversion
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rcu@vger.kernel.org, maple-tree@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 7:22=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [250822 16:18]:
> > On Wed, Jul 23, 2025 at 6:35=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz=
> wrote:
> > >
> > > From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > >
> > > Use sheaves instead of bulk allocations.  This should speed up the
> > > allocations and the return path of unused allocations.
> >
> > Nice cleanup!
> >
> > >
> > > Remove push/pop of nodes from maple state.
> > > Remove unnecessary testing
> > > ifdef out other testing that probably will be deleted
> >
> > Should we simply remove them if they are unused?
>
> Yes, I think it's time to drop them.
>
> >
> > > Fix testcase for testing race
> > > Move some testing around in the same commit.
> >
> > Would it be possible to separate test changes from kernel changes into
> > another patch? Kernel part looks good to me but I don't know enough
> > about these tests to vote on that.
>
> Yes.  I'll do that.
>
> I'll drop testing first then the feature so that testing will continue
> to pass on bisection.
>
> I will also stop moving tests around in this change.
>
> >
> > >
> > > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > >  include/linux/maple_tree.h       |   6 +-
> > >  lib/maple_tree.c                 | 331 ++++----------------
> > >  lib/test_maple_tree.c            |   8 +
> > >  tools/testing/radix-tree/maple.c | 632 +++++++----------------------=
----------
> > >  tools/testing/shared/linux.c     |   8 +-
> > >  5 files changed, 185 insertions(+), 800 deletions(-)
>
> ...
>
> I didn't see any changes in the code block, but please let me know if I
> missed them.

I was referring to the changes in include/linux/maple_tree.h and
lib/maple_tree.c as kernel changes and the rest as test changes.

>
>
> Thanks,
> Liam

