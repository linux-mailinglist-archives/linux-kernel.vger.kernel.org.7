Return-Path: <linux-kernel+bounces-865368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1BDBFCE4D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65591895AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAB922FE15;
	Wed, 22 Oct 2025 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pb/nWx9N"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0251CEAB2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761147095; cv=none; b=J6WOtUEMca1DcSThJMjo6UbWoW+L6lQUzwqtd2KXcgZt8SaTf8wAY484YvtXUy4tRoJHIk+19D67M0GgH7v8wfDHgXKqyjeymSFY6o+mxKfTmSC5ayXdbHfN8g/bQFMReCP7rJlFONcTQia8jvEkbijTgpv8jTFdh9FI+xiQ314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761147095; c=relaxed/simple;
	bh=frz6LwjYFBZol9A9scWqXd5jqp7+w+RmG5raT/3fNJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWGJ1ega7FZNbgK57D5SnzlYobQj/222Rj/P+21bYh9u79ov6bkyZYODee4wzEqnnzY6ZDMTuSf39TDYx2BaYiLNrpwFYvK6VNKWWSZ5DH33eLQV4RK6Xot6X79eG6PNlIrGKBz9E7m4Y3U1LuSyOqiTj5pG2nZMDavGitTkt10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Pb/nWx9N; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c1a0d6315so12704229a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761147091; x=1761751891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7W+TKsiVoFH6YSztkZcDFcv21KuO/v7xKh45svbjJc=;
        b=Pb/nWx9NzmYYVOylcI9hncHFbIUoMQt6ROVN91EYKHlrgMlJ/Vbcq7JwCZke/aa7au
         TFTNkpoYZNE2OKkZvbjtkOhUk+0trab0YFNTCelfYvmvfuMfqFg6fDdNBaRaEAofAE8O
         Mq0DhsMUuTmqsGIaW2tsg60VbcCuTKBAOQ/SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761147091; x=1761751891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7W+TKsiVoFH6YSztkZcDFcv21KuO/v7xKh45svbjJc=;
        b=MugLt8sWiBI3pBIJ0iJiwqZNFi2/XVeVMBNSq3exgVzQpSY6ATC43c9V+uTsOv0RiA
         OBHfbNFKV7NAUR0g3bgNeWwwBMPFe8LQkqAwVm40RWMp9isyWxZpuSC5JTmoloavwvuk
         MXs0nRtr+C0kAZwfz6HKAZWZX9lRy0rlqDwBBJVS/OpB5dqHCd7QPhY9+CTwrQ5um0h5
         PGd0tvfR0QniGlhYAojmRSmuXSwQNxrX04z5dfYoHus2Wjyjfm7YzJb32p5qu1j7yb86
         qhRry2BQ1rVIYL2izA4QjB+AYymWc0DleND5Uowr0xqAcy7PlpEaiZB3PRdcfWccuMXw
         x8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUf5x8SFnu9e/ZCkViFybER6l7ure7OfDZwae30s0h8DmlwpGyPbhsA93X9ZKjV1q2JIQsPR4iL3aloPek=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLg0aUl8Fw1TnOJG8u9bTsN/NbMRdhURKepFxOvwlmYMA/FlJO
	Hrq4BAG9I59CjCReeMWNc6Sv1bAUwqdQa86rTl932ZpG4TMp8Xv2vxPB5eyPWS1sxjznWpprAk0
	Xd5/zgTQ=
X-Gm-Gg: ASbGnctjwElIviufOEdz0MlcH8L9T23XzPkEZNsfChhRiHIMHZR7SQB7ClZMKEQjsmc
	wtdUPHEFawdM5P2I7DUDFxRVJ+V7BJQsiZN3P4vmTtMP4u1lQw1LE2CfH4zkJ22i9zUJnvMMfju
	AUFj5eiZC8nfK0SKJvvlxnehKivyLgbXGBL+dap+zWPELFAo19byw/lCTqnn+HbbEVYzrQiGMOq
	rC9TCMuOGWEhMLtYkxaCb+1Nt/ToDOAqCZr1aJdozDBE+ob+3nYH9aquJpC/IiBKjUWia4GVzFT
	cW/vmMOnGNb9Vrhq1xf4wGjVuyjQGcil1Agpud+7PUqOBKR/lmLphNyqPx35H9uFfZ6P2DlNqjh
	H6Cb0X/PBdWDkTOGpHLsJIBrtxNNirCYtHQrAjI/cET4fur124oEe+sEycx5qVHfbeYc78RGPCK
	bAJjYonTH2RJgAAfe7i8D8boEzfs1j9+JpH6tdNtyfcAy+KFLHTw==
X-Google-Smtp-Source: AGHT+IEq+GBRgdLRJgzPVFFkixYSpvFh7eTe6ee8MmOyqQjHTVqaizeEhZCNvEOn4JjyihCuGG9vRg==
X-Received: by 2002:a05:6402:5255:b0:63c:343:2485 with SMTP id 4fb4d7f45d1cf-63c1f626e9fmr21404134a12.3.1761147090857;
        Wed, 22 Oct 2025 08:31:30 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48acdbdasm12230354a12.17.2025.10.22.08.31.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 08:31:29 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b40f11a1027so1394408466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:31:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGyvCP9tDwucES4/T9wkdXFNPKI987Otzc56GdTPjEWtZM1/lgjlPgzyLAB6q3L1LFMoR+x/oiHp/YWbI=@vger.kernel.org
X-Received: by 2002:a17:907:980f:b0:b3c:3c8e:189d with SMTP id
 a640c23a62f3a-b6474b37113mr2725824966b.32.1761147088921; Wed, 22 Oct 2025
 08:31:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
 <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>
 <aPgZthYaP7Flda0z@dread.disaster.area> <CAHk-=wjaR_v5Gc_SUGkiz39_hiRHb-AEChknoAu9BUrQRSznAw@mail.gmail.com>
 <aPiPG1-VDV7ZV2_F@dread.disaster.area>
In-Reply-To: <aPiPG1-VDV7ZV2_F@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Oct 2025 05:31:12 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjVOhYTtT9pjzAqXoXdinrV9+uiYfUyoQ5RFmTEvua-Jg@mail.gmail.com>
X-Gm-Features: AS18NWBLPYl4FSdSEwqLouztsANoG3qy-LQaVLkVbPvmlrLzgiJvczojC-Vgh9A
Message-ID: <CAHk-=wjVOhYTtT9pjzAqXoXdinrV9+uiYfUyoQ5RFmTEvua-Jg@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Dave Chinner <david@fromorbit.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 22:00, Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Oct 21, 2025 at 06:25:30PM -1000, Linus Torvalds wrote:
> >
> > The sequence number check should take care of anything like that. Do
> > you have any reason to believe it doesn't?
>
> Invalidation doing partial folio zeroing isn't covered by the page
> cache delete sequence number.

Correct - but neither is it covered by anything else in the *regular* read path.

So the sequence number protects against the same case that the
reference count protects against: hole punching removing the whole
page.

Partial page hole-punching will fundamentally show half-way things.

> > Yes, you can get the "before or after or between" behavior, but you
> > can get that with perfectly regular reads that take the refcount on
> > the page.
>
> Yes, and it is the "in between" behaviour that is the problem here.
>
> Hole punching (and all the other fallocate() operations) are
> supposed to be atomic w.r.t. user IO. i.e. you should see either the
> non-punched data or the punched data, never a mix of the two. A mix
> of the two is a transient data corruption event....

That "supposed" comes from documentation that has never been true and
as such is just a bedtime story.

And no, iI'd argue that it's not even documenting desirable behavior,
because that bedtime story has never been true because it's
prohibitively expensive.

In some cases the documentation may have been historically "more true"
than it is today just because the documentation was written so long
ago that people used a single lock for everything (not talking about
the Linux big kernel lock, but about old BSD model of "single inode
lock for all IO").

End result: you say it would be desirable, and that might be true in a
high-level way when you ignore other issues.

POSIX is full of these bedtime stories that depend on a simplified
version of the truth, where the simplifications means that the
documentation just approximates reality at a high level.

I think it would be much better to fix the documentation, but that's
generally out of our hands.

            Linus

