Return-Path: <linux-kernel+bounces-872043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13063C0F207
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0E71898283
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8667930CD9D;
	Mon, 27 Oct 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h53lYP0r"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A38130B518
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580275; cv=none; b=mNAQM6cjIxiRQ23rluF1y6zZPRglqChVj7KZB/9o8WTzWvozC+u6EGPTcehiFe8L+1L7U/m/lS9YJNI47HGvhyGypqOZ7WecknA4q/k5Ndpvg0DK85rQ52gr6DLZrk2/6YOIPMchFuXpEArqTqSZUpieEtu4gAEiPD87uP0rwUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580275; c=relaxed/simple;
	bh=Td6PjAe6oZGWpKeVHOgaPYgxhjJM0vHRuXn7TA1UKwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyGY20bZ7uXFP/pPIHd4gIGnLHHkRIo0ez2JjQHR2/Ze7abnM9VVf0av3EJ6YS3JgXcVyECn6HCbstM/nyJCVlE9qcQNkRqOU3oUIuU18805RTm9VVRbfld58qjU7Bu6ru+0YT3d7iqlDVIWvTGPiLJnBNnS50F0seB96upEC90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h53lYP0r; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso1045104366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761580271; x=1762185071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz5OAU8C9T/9dkzlT3ECgLDp03ETYSkJWqABI4th3fM=;
        b=h53lYP0rNGiBH0moKeHCPBApiQTakOzE8iLhc2zPDrFuzvKZHRi6eHQt9grrp0+/4L
         KEXejVWwYVxQgGjbZFSNNZ55KBkN7xnpEmmb6MG3liSZRfZ0IoFjmKz/pueCUEhLFrv9
         2HDgSAZyxFiYgeHjg5Mufft/u3p4oNYWBPy9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580271; x=1762185071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fz5OAU8C9T/9dkzlT3ECgLDp03ETYSkJWqABI4th3fM=;
        b=Q+VU+oW9SHe4LfYh3OKL8Veo7fZqBJYzfEqAuu3XMNzztq3mRiNczqfBPJCeSoZMnO
         RkBlhncnOO91Ag/5rt1dHDmagGwoRJkBqfBA4xzFTAt+U3nCUaKha+XhBmeYcOV0uMJg
         Ao0826FPjTdrMB2v57ekmWsImKM6tqI8lp7vyy9UMTaRFky+sCYzY5wrj2weT/thPJsr
         MHPnku+STXz04D2TkqeXy3fVnIFMMa26r6Pj8wHrjSAm9DhG4wHWfn0jDKjUS0XwwzgN
         FUUiMoUuqlj3sUfW1PblXWjVau04A/YkrgbBdNOhx42duhsiP/eFxoJePQwYwozpW8ou
         V1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWieJfmZV4Zk+C24JEQIeH+Dm/npgoZI65YNuzEX9e2fmOu9eXL4xHAcBxd9vIwVmv00A4W7rSksjkQIsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuSe1N7XSmG1oHItwDVMdXUulyjIdJG6Rhmtw09/gHgqhlMfc+
	p51AzlZ18AU4+nq20I8/CogRUq8lLq3SQjw5bYZBKTfVcHELstU/kz5NGuP7S8i2eExSmQMmlgx
	VogcOGG0=
X-Gm-Gg: ASbGncua40DggmSSSJUDwkcVYZC9Z/mMagZUHIRcCOvqOI4aLM0n+suxjcjTKlYpZ1N
	WbNy9HCO3IWf6tq0LvBVlBpCK4geVK+fKMM1aH7Ly0gOb1Mp9xJcyBE+bXxdYX/hfkqc53Jtlbt
	AHm1qKKSsxFTEmlvq/lS6YLpacyAGuFoDLA1jpJgwZ7Afqdvri4LzsshudKwpt7tlv+u2kqDu2c
	oimFAiSnMHkJg/qmjbWf6Lwyc3UUZ8ww9NlxeG7BB+RHNy/z8FfIesh5+ur8eDRS3+xceiwfCRy
	tfDB03G9iI3ZgnMazgQA9tuR5cOmwUYUTXjaBOl/ilygQweBHVUSZ744+PriZcVkW0Xb44Fmudy
	XrMRHvXN8RvYpu0qL55qa6GKRLc2WibXr8FhmTLx59gKhHq8SuoEzweGMXvaRzRBxyd4cFdcZjy
	BjAqbAceWQkmQKVd9O6teh9Ikq3GJzFwrPoRp0p/YQnuAXSKg0OXoUGb8Ubzvw
X-Google-Smtp-Source: AGHT+IG2cXgHQ2toSKHM7XaSC0bnYTl0KfoHzdW9qSQGmuf36FnUpdOCcrXOn8kZ7tddhChRzWGv+w==
X-Received: by 2002:a17:907:2d0a:b0:b6d:3fc9:e60c with SMTP id a640c23a62f3a-b6dba4886ccmr42451866b.20.1761580271339;
        Mon, 27 Oct 2025 08:51:11 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853077e8sm798363666b.14.2025.10.27.08.51.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:51:10 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63e12a55270so7032948a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:51:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlHxFb/zxdMdi75BVt0YpBizQ3pyIgWYugU9tKb+186pU6xdTFgEVg+Cbb1jDknjhnfThsInrLq3oysoI=@vger.kernel.org
X-Received: by 2002:a05:6402:5208:b0:63c:45da:2878 with SMTP id
 4fb4d7f45d1cf-63ed8262ceemr407724a12.25.1761580269751; Mon, 27 Oct 2025
 08:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
 <CAHbLzkpx7iv40Tt+CDpbSsOupkGXKcix0wfiF6cVGrLFe0dvRQ@mail.gmail.com> <b8e56515-3903-068c-e4bd-fc0ca5c30d94@google.com>
In-Reply-To: <b8e56515-3903-068c-e4bd-fc0ca5c30d94@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 08:50:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWmTpQwz5FZ_=At_Tw+Nm_5Fcy-9is_jXCMo9T0mshZQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmga7yjIxTmcYa49QdMzCJ_rjqDZmpAlOCSXqWKYw9598-EirU5Tn5Et44
Message-ID: <CAHk-=wiWmTpQwz5FZ_=At_Tw+Nm_5Fcy-9is_jXCMo9T0mshZQ@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Hugh Dickins <hughd@google.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Yang Shi <shy828301@gmail.com>, Dave Chinner <david@fromorbit.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 03:49, Hugh Dickins <hughd@google.com> wrote:
>
> This makes a fundamental change to speculative page cache assumptions.

Yes, but I'm a bit surprised by people who find that scary.

The page cache does *much* more scary things elsewhere, particularly
the whole folio_try_get() dance (in filemap_get_entry() and other
places).

I suspect you ignore that just because it's been that way forever, so
you're comfortable with it.

I'd argue that that is much *much* more subtle because it means that
somebody may be incrementing the page count of a page that has already
been re-allocated by somebody else.

Talk about cognitive load: that code makes you think that "hey, the
tryget means that if it has been released, we don't get a ref to it",
because that's how many of our *other* speculative RCU accesses do in
fact work.

But that's not how the page cache works, exactly because freeing isn't
actually RCU-delayed.

So while the code visually follows the exact same pattern as some
other "look up speculatively under RCU, skip if it's not there any
more", it actually does exactly the same thing as the "copy data under
RCU, then check later if it was ok". Except it does "increment
refcount under RCU, then check later if it was actually valid".

That said, I wonder if we might not consider making page cache freeing
be RCU-delayed. This has come up before (exactly *because* of that
"folio_try_get()").

Because while I am pretty sure that filemap_get_entry() is fine (and a
number of other core users), I'm not convinced that some of the other
users of folio_try_get() are necessarily aware of just how subtle that
thing is.

Anyway, I'm certainly not going to push that patch very hard.

But I do think that a "3x performance improvement on a case that is
known to be an issue for at least one real-world customer"  shouldn't
be called "a niche case". I've seen *way* more niche than that.

(I do think RCU-freeing folios would potentially be an interesting
thing to look into, but I don't think the patch under discussion is
necessarily the reason to do so).

               Linus

