Return-Path: <linux-kernel+bounces-756436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C6AB1B3EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4510D4E24D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C052230997;
	Tue,  5 Aug 2025 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e/qC8sot"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042BD10A1F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754398876; cv=none; b=q+6jW8hflINDbnGXfcd+Lt4rfx+0VnNgGKCAvVOxtKbp7wfaaxCWxkZyYmPXPTIAYNSU/Ba+6H3yWCBLOZqlaqCb1uFqWni39KyDLV54bdtiU+qzLDaK9l9fKyfTYXxuluRRExvqXulPv86b73RL2tCKFch4KkkBLZNPbKFCIKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754398876; c=relaxed/simple;
	bh=jCINSY02b3VcKaYR8JyLD/p2mOf2EtH7q4vBP76L8iU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XFeEJW/Jh0O7X7J4SIn74VzePjqk9S2EFc+ati6g1k93XRb33OtLF3jWti9rOyFgTHns5UR9VQUp/4HrhhuRuw+SjY9hIfOaqwZnlOO3PXYQ1Gu2gMAbVTENIR5pjzCHmEZppmzsqWZ0gPLKN5ch/lSUegEKwwsrIVkZr7bkwvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e/qC8sot; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af96fba3b37so349320166b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1754398872; x=1755003672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fjxzM+Wf4qtRYVaNCOW0++JtZ+DW7avxmv36rBvNzbg=;
        b=e/qC8sotlWxt8Yomkrc2xTX22jmwuOR0yuA1+BTSnJSaFOOClzh3Yxz30eltZ2G3FL
         h62xCSMRbm5mFdIIbF8QWZvozy024OrBGwYOcv9MAfiq1iW2++HVUFAPGjH+GYrolIj/
         H2fv4caUKxzR/EPrH5cA49ArFupPCjKILs0ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754398872; x=1755003672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fjxzM+Wf4qtRYVaNCOW0++JtZ+DW7avxmv36rBvNzbg=;
        b=Ri1e+7is2tULtn1YVq6z5xBYSZb+UA4d2vgE4K2z21O+qhKsyRl7pijwfOIOiQMTQe
         9aSto7ix8MQ4qMbiPe9wdnsPGgdutCoamcEIteQDfaTNDEfmm5owtDIhW00SabxlJOkW
         TsiScLs43da4HYvgZM3vEfem0Merfuod4LK3rQ9B9zh2O7DM2TUOKz0ZdagHHeLeeXBE
         MyAymoH4dQcKrDV9hluMLpdgxeu2YDqj1s2sf2WDnFJ3i1g5YUun9JIsmTo0+tRZCggP
         YK11MWtcCNmQ7M7Chipq/BE+BmjfoD8f6l6h0MiwsvbuQle+o3gI+Y0mvX1Yvb3AHjU4
         M3sA==
X-Forwarded-Encrypted: i=1; AJvYcCW1KZAu81DnSnmMLjh1TOed1mSlPCUrlDzy1kBVnSXpseAmf2Pk7GAkbpvD5qu0aL8/rG7MQF9AOh6vF+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOXgahU2pxhrF+1NavtBYgeoF8wJaBUL5y2yGGkRVP+ZfAJjB
	iJHfqaLRIEvIBFm03I7iM1YJY1a1IXuYv3OYj9jc1C7ihYSHO72Gm82mKa4MOUJH2hZE65eJEnc
	EXOEZWnYO0Q==
X-Gm-Gg: ASbGncsexs0ZRur5fsCP0iSTVjTj2/In4ga8lWmfUnJtw594TYt46yRzr9cnPvJ/B2L
	xWc/3Ax2FcNq1aTMMg19NYVFDVawSZ8k33fHmTfg4ynuDMVqoaJucJhHCqyKka9gipvagl3Og3D
	lcrCUS3NiKbiQprG/N3x/0c2LgxWvwF420PoxiEMJbNKee//6jMGg642TmevFSR/EOG2TPZNf8+
	lVt561EkHvR46OauDbn9yRa2JRcgAozDfIxKvNYYyLurLL05yMW5TVXX+8CvzyXNjStdZP6FJET
	CZjxGKN5wnWPkXi9tbv8D7R3e3sIlxGB4/ssGzBp4RW2Aif/6A03zLDTHCa60XTUXAVoPfwmE9g
	nJzQCA6G3R9z3F462ns53zu/Au3RQaJmsDYjtAjQHaRJwft6Jt1DK4dTICVt6OqTFIFnQiU72
X-Google-Smtp-Source: AGHT+IHDsPizzp6RYQEwtk+nR/E2lyIa6BmHLS+TJEyZdusSG/rpPqO/ERxrYjrsumioEmgDvU44sQ==
X-Received: by 2002:a17:906:7312:b0:af6:361e:664d with SMTP id a640c23a62f3a-af93ffcf84fmr1412484466b.7.1754398871579;
        Tue, 05 Aug 2025 06:01:11 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23fd00sm899438166b.122.2025.08.05.06.01.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 06:01:10 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso9547880a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:01:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWt9d6oY+ok0N6oY1avVxQl0e4DbKfkxgQoQ1OK2I3CgG7RNHrq4/GGG7bx6e/q9lTqgF7rBfFZ1ChHRLg=@vger.kernel.org
X-Received: by 2002:a05:6402:35c9:b0:615:9fe5:f9b4 with SMTP id
 4fb4d7f45d1cf-615e6f51419mr10235333a12.20.1754398870074; Tue, 05 Aug 2025
 06:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804162201.66d196ad.alex.williamson@redhat.com>
 <CAHk-=whhYRMS7Xc9k_JBdrGvp++JLmU0T2xXEgn046hWrj7q8Q@mail.gmail.com>
 <20250804185306.6b048e7c.alex.williamson@redhat.com> <0a2e8593-47c6-4a17-b7b0-d4cb718b8f88@redhat.com>
In-Reply-To: <0a2e8593-47c6-4a17-b7b0-d4cb718b8f88@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 5 Aug 2025 16:00:53 +0300
X-Gmail-Original-Message-ID: <CAHk-=wiCYfNp4AJLBORU-c7ZyRBUp66W2-Et6cdQ4REx-GyQ_A@mail.gmail.com>
X-Gm-Features: Ac12FXxoX_CjIAKtjLryo0sCU8BxLl8OrhQv0TcPGjBq_s03leh63xL_WcFm2cw
Message-ID: <CAHk-=wiCYfNp4AJLBORU-c7ZyRBUp66W2-Et6cdQ4REx-GyQ_A@mail.gmail.com>
Subject: Re: [GIT PULL] VFIO updates for v6.17-rc1
To: David Hildenbrand <david@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lizhe.67@bytedance.com" <lizhe.67@bytedance.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Aug 2025 at 10:47, David Hildenbrand <david@redhat.com> wrote:
>
> The concern is rather false positives, meaning, you want consecutive
> PFNs (just like within a folio), but -- because the stars aligned --
> you get consecutive "struct page" that do not translate to consecutive PFNs.

So I don't think that can happen with a valid 'struct page', because
if the 'struct page's are in different sections, they will have been
allocated separately too.

So you can't have two consecutive 'struct page' things without them
being consecutive pages.

But by all means, if you want to make sure, just compare the page
sections. But converting them to a PFN and then converting back is
just crazy.

IOW, the logic would literally be something like (this assumes there
is always at least *one* page):

        struct page *page = *pages++;
        int section = page_to_section(page);

        for (size_t nr = 1; nr < nr_pages; nr++) {
                if (*pages++ != ++page)
                        break;
                if (page_to_section(page) != section)
                        break;
        }
        return nr;

and yes, I think we only define page_to_section() for
SECTION_IN_PAGE_FLAGS, but we should fix that and just have a

  #define page_to_section(pg) 0

for the other cases, and the compiler will happily optimize away the
"oh, it's always zero" case.

So something like that should actually generate reasonable code. It
*really* shouldn't try to generate a pfn (or, like that horror that I
didn't pull did, then go *back* from pfn to page)

That 'nth_page()' thing is just crazy garbage.

And even when fixed to not be garbage, I'm not convinced this needs to
be in <linux/mm.h>.

              Linus

PS. No - I didn't test the above trivial loop. It may be trivial, but
it may be buggy. Think of it as "something like this" rather than
"this is tested and does the right thing"

