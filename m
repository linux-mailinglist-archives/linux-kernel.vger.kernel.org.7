Return-Path: <linux-kernel+bounces-780879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D4AB30A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 02:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D1B189FEDE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6A2136349;
	Fri, 22 Aug 2025 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZe7cd5b"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C623594E
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 00:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755823724; cv=none; b=nZHShs+DKxTYS4DO23VdRqnESsTQP4KooY7LiLGk77ETpCtd5TzXkcHVYnrAqiLKK99xa8Y/jczfdxFP9bYQ4ueEfhCwSK2HAqn4/KG3eCwv46uZD20O8Ba//FnyqyBnXaYQCabkx6t/1Mh+bZxsiiFZXJttnQxXXvQNRqZ1Ba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755823724; c=relaxed/simple;
	bh=IyLNz3ER9QHJAuCSeL2/f81q15LzIaZ+iGJMt6hLaqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQqIVHHJ8jJl7sxi33MHX45lPEapvYQMnYGec+Hsg7qyatOVvRNHf5SYCWBEkT3TolbHXkFWRLZyn1yYbIWZehEwdGCD9h7Fy2qRi4+BaiKWc2JTJXzIX0fsYPSEdcjF8Q2RioL2n9fJ8WpKJ71NwT7np+SlNdudcZInlMIAtM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZe7cd5b; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-53b17378b74so687798e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 17:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755823722; x=1756428522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwcJVey4yrVkW+1jJjtWZIJIiSCur0pA69hI423iRXg=;
        b=MZe7cd5b9FJ8AUEA13+2L1mGwD+lfiNw/1yXuB7qGEBZ0pJl5nWrE8iChXklz0D+24
         PC4FFfhScsTpqTzNWQEsr84MCykPMstc+AnnYwbZtkwPGhKm/veKqrKa1DxIzIa/z1B1
         /ZippzqMsXDhUfIWpNUwLsFwnv/u0dbw5EtMOszP7y4Mo5gQFUU9Tap6GCDsvPAasxxd
         3SGhz3y1/u/XzdnpLgzjnmbA+KUtMCumrjNYCk1oszanpddRSDPA65oABSXVm87oFPVW
         Mp1ROVwznDiYqZpRgWFEKPtov+qkH5yE+IibrcxyrYd+qYB5hcnGZ6pAM/MBAtNdDTxE
         huXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755823722; x=1756428522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwcJVey4yrVkW+1jJjtWZIJIiSCur0pA69hI423iRXg=;
        b=X3qkyk0IukNozxN4F1XfNj3zFhpchTnAKt1bLzJScrJpXWPAyskFglPrrgHrPQ1A9f
         /HSgaT4Ahg/BIN0TPtWkvrVjsa+bIQeVd6xjJ7MyiqAhCsNqs4rU4E+iX7FyfZIb6YLe
         9P+V8Bmjd2HP8XSn0niNorkGeiZzu/349KgHfQYT0aBlH8FdVxr4PbVDrhkfdUsyVfJz
         MPzu4XNVaN9K07uc9cbZ90f2N1qPQ+9/cqLaNiKZEUDlr6iPvWIkvCsV6jkfK2OhMpEJ
         pIO57ZZKgTRGEjwpIlTNKihzxODpHI66P6+ias9lN8g+NVC3ACcCjbtvbDXmv3DHpozh
         qW5g==
X-Forwarded-Encrypted: i=1; AJvYcCVO3CgAgoVB+gg6bRVuJ1VkXyWiUh4DnIujAtffKV5kE/bt9gUEmhfmy7Ak1v24B+tarEzwOamXt4tvE+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+B+gnW+TS7WphZ1HNKg/lVRIZoFGGnKz56+nqNsQcBkW9AzQ
	J62nVj6CoRWRsF9EIyOnRrNQdVB/DjwZVxKJVT9lM6xl8VBymr3VH+FSHFWmwYymCxC1UcLrXTO
	zqsarqibXh+4oJwFbU3RUrFQd70aKFDY=
X-Gm-Gg: ASbGncsojb+lMJf4/oPkx6W1L7Z4Ed7dtBdJ94CZoMGJcaVf6uP3ka2gJn6IXheQjDy
	A2VL9cXOvhFCPvmpXhst4NQPdoS4ywc+/9h3IViTHt0GRT4Z2yKOYg6QTRHRAhCfGKoZ2cpqXBJ
	Jb4UG6Sm97hkuLZgPklNgTDcdrGy6PUTgNps99+l4rXKlkw3WSF8OqDYVSynF0MT2nE9kCsAsiC
	uzMGbXa
X-Google-Smtp-Source: AGHT+IEJ8UV2rY3maHA7Q2JeaQyfxz3x4B6F5JbVShfI+RF8U73165NhtCdKVMvrPJGjZBGmtK++pwqP1/9/ts3xhoc=
X-Received: by 2002:a05:6122:6587:b0:539:3548:389f with SMTP id
 71dfb90a1353d-53c8a40ca61mr393737e0c.11.1755823721627; Thu, 21 Aug 2025
 17:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF8kJuM++mc5PjcN_bxjZjbByT7QpVdOqRQte=vGJnuQxSTVfw@mail.gmail.com>
 <20250821213630.1771-1-sj@kernel.org>
In-Reply-To: <20250821213630.1771-1-sj@kernel.org>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 22 Aug 2025 12:48:27 +1200
X-Gm-Features: Ac12FXy5T4X3nugaRsfZafAE6RY6-5rjjFf0YRDC1qItYPbeHGefEN8T2wRF5eI
Message-ID: <CAGsJ_4xLKVM+1LqKzbwjd0vB_OYnb2E-h-Wb_C2bBxiSdU=3WA@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: SeongJae Park <sj@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>, David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, 
	Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > >
> > > 1. remove it,
> > > 2. keep it as is, or
> > > 3. keep it, but account only -EINPROGRESS[1]
> > >
> > > If I'm not missing other options, I'm tempted to the first option (re=
move it)
> > > since it doesn't change any existing things, and we can revisit later=
.
> >
> > I am fine with 1) removing it. Maybe add a log once print error on the
> > error code if -EINPROGRESS, just to know such extreme error has been
> > triggered.
> > >
> > > Please let me know if I'm missing other options or if you have other =
preferences.
> >
> > I just don't want to hide the extreme error case but I am also fine
> > with just removing it. It is your call.
>
> Thank you for your opinion, Chris!  Unless others have different opinions=
, I
> will only remove the counter (option 1), since it is simplest and we can
> consider adding another counter or error logs on top of it.

Yes, that seems the best option=E2=80=94to remove the counter for now.

And I still need Herbert=E2=80=99s help to understand why crypto_wait_req()=
 might return
-EINPROGRESS, given the code below:

static inline int crypto_wait_req(int err, struct crypto_wait *wait)
{
    switch (err) {
    case -EINPROGRESS:
    case -EBUSY:
        wait_for_completion(&wait->completion);
        reinit_completion(&wait->completion);
        err =3D wait->err;
        break;
    }

    return err;
}

void crypto_req_done(void *data, int err)
{
    struct crypto_wait *wait =3D data;

    if (err =3D=3D -EINPROGRESS)
        return;

    wait->err =3D err;
    complete(&wait->completion);
}

Is it even possible for crypto_wait_req() to return -EINPROGRESS, since
crypto_req_done() will not call complete(&wait->completion) in that case at
all?

Thanks
Barry

