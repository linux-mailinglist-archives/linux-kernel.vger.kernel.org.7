Return-Path: <linux-kernel+bounces-799142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A84B427A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA38217515B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4FC31A57A;
	Wed,  3 Sep 2025 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BR95he7m"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553A01F0995
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 17:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756919323; cv=none; b=tR+ff6a4wnQVV4Sff8pQibdUEBSGREJau82yenooW9/IcGd4zzNc6R52RYUItEQPY8eEPQH8E8m5DgTW8+c/Cp7PgeWwUxNGzbTwpAdnO9x72ju4UXDRBQQ5g4fESfObUomqQYeVBRNhbKLdKmp+w2zxJjUW0Ay2nXmh002KUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756919323; c=relaxed/simple;
	bh=5U5MsohvcC62twkalTXypIiszYOdRUJeTHKjyqx9fXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7V8jH3nLbhAqL+A3tio262Bsvgil0xvKMQcpxIGWDQqO3Pp5DYN1hleC24TZK8tq7Qcmk/IRZiCQAKinK0sCJSgudqJx8e2ZR519Apm5UMwy/ag9+ERWDtIvwJqiNtYF3VCQ7DpGD3wKAug29Aa5f164WkdDJUZftfMXIHYtzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BR95he7m; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-61cfbb21fd1so522a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 10:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756919320; x=1757524120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FshQjGscW6AK7gc0lIFS3uvoLvZ0MarkksP9A4ElGU=;
        b=BR95he7mdgnC0SDZ3CibB5yMjclS2prKGeYWngx293PZ0H9FzBcAfPn0Zztuz3zV6j
         8WxkOOcd1F+zSLM+n2T1qKog1J+p4V8A56e4FRnHqkbRslli3JfTXfpyOkrxCtaB/JqV
         5oR/cs2kZ8bA7usp8ODfdxzpBZAOmZa5WV4TaIHde+7ogfjeN82/eQSlRLbz1mqZTW8v
         jGxA5iy9rStncLadwIFXqbyiPqnhq6sQu8RSylmqqQU3YTvNPqDNdf1sM0DDU+jn9Yiz
         79N9JhUvlfCE+YChFtQJGWZY0ouKwJ8/hgwkgZinVGJZaxdBn0+WcHCMKW9dodBXx9wj
         jwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756919320; x=1757524120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FshQjGscW6AK7gc0lIFS3uvoLvZ0MarkksP9A4ElGU=;
        b=NtAsPf77JQsV22QYbJo0AVvW+PDJCVKK/JRlkGn9jTVHgUlBEuDtLxVtvPCVGi7nqY
         iB/PtV8tOEnpVUIuAqP3wTZAU+4egwxas07byC5zwPmguB2QP/N2upWLGVE/U1FT+AC8
         BGbNDgKhKWB70sPUghtUKE9PEEoB2L1JHWvYU99O6kC4Admo5Aoca/em7bk35QWutmM9
         9yIIt1MtofKUtTY3VyFEOS2mbhLk7RZtHAMjMwQZ4GnI00TbgT1azN0/uT04vDQc9A5Y
         y9MYaD70HYB7AP+CpfVc1jEVa/9OY9iTwnKS1kQzJnMM0fDwdapHCFN3pkKBdm4k5U7J
         00FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXxlqPcKC7QjT8Ib5c/KpU1bcWqUs5qd6X/ntdPyIT0UHCn58ivuPjo93zLAaCr8604+4H0gxDtYVZaqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2/OmWTUJ6hJvjk+7HRJoBeDz2Z1O36HuM4I382rJxhZ/IpJv
	r7TCx5asOiKf9Yz+mpTm02kf7wJsbjUixns5XYbHMTpkX0azc0GJgYfEPPwtmTNCCUCkgfYp5+9
	zi9FQ0BN5hNVrco16PKrAgUuBat49qNCvADTjhFa0
X-Gm-Gg: ASbGncuaj+aw2JyLIYbRLfWU5MY7cNmzKkDtn2Uq/b0c/F0fLgp60PnLhwF6KdLgY/i
	Q6aLiTPfZ3lModiv/tiIF1GQ/x3rJqAPqJ7ckEbFVFD65ekZtIGWEewxzczT3xujSJjQp9tXhBu
	JAHu94QOBkmsgzS+lVoRbrUdlHqAWSX1akJyTYkfCEfO+DtGlPIqqXqKiUMNXfony+6b8R7ijxM
	NwYOMKZ5kF6FrFe0TYEtX3v7vxdD+9YXqwy/q3k2MPn31za9R8Zwc7xT+0=
X-Google-Smtp-Source: AGHT+IHxfEfw62Su+HKG4JBWo3W0aBGajU1Xh1NsFulFe/66SMuM8pHjRvYAAFDyII21IadxnUuyNeeJi6HBZV8G06Y=
X-Received: by 2002:a05:6402:a0d4:b0:61c:d709:ce04 with SMTP id
 4fb4d7f45d1cf-61d21f8f882mr468669a12.7.1756919319452; Wed, 03 Sep 2025
 10:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1756897825.git.pyyjason@gmail.com> <4ed91296e0c595d945a38458f7a8d9611b0c1e52.1756897825.git.pyyjason@gmail.com>
 <087C9FD8-BEDD-4CF8-82DB-E3B909FEE321@nvidia.com>
In-Reply-To: <087C9FD8-BEDD-4CF8-82DB-E3B909FEE321@nvidia.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 3 Sep 2025 10:08:26 -0700
X-Gm-Features: Ac12FXw1gYyhedLLejRbTL6Jpooa3X-CPGeMAti8LxEga1BIvj3YabGnl81tV6U
Message-ID: <CAJuCfpEUBFk6uHieHdsXoRFV+WxEgqW7LOvz1wKfrU=uKm-Uzw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm/show_mem: Add trylock while printing alloc info
To: Zi Yan <ziy@nvidia.com>
Cc: Yueyang Pan <pyyjason@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vishal Moola <vishal.moola@gmail.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Usama Arif <usamaarif642@gmail.com>, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 9:30=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 3 Sep 2025, at 7:16, Yueyang Pan wrote:
>
> > In production, show_mem() can be called concurrently from two
> > different entities, for example one from oom_kill_process()
> > another from __alloc_pages_slowpath from another kthread. This
> > patch adds a spinlock and invokes trylock before printing out the
> > kernel alloc info in show_mem(). This way two alloc info won't
> > interleave with each other, which then makes parsing easier.
> >
> > Signed-off-by: Yueyang Pan <pyyjason@gmail.com>
> > ---
> >  mm/show_mem.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
>
> Acked-by: Zi Yan <ziy@nvidia.com>

Acked-by: Suren Baghdasaryan <surenb@google.com>


>
> Best Regards,
> Yan, Zi

