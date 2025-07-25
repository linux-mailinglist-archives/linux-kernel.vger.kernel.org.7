Return-Path: <linux-kernel+bounces-746010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D2DB121E0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E7F16446B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8062EF293;
	Fri, 25 Jul 2025 16:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UOgm3+Yi"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6971C5D44
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460558; cv=none; b=tyMaKZvSPW9+pYYGngmfGuVATi5yBcyPRyvMDKv0ffwV9YO4Nw3SWJzSDboaikf/8sOjXKcYLrna6rcn907AkIJen2Ks6p/Jo/yaWMe5fQ50x/QK+X+kuj0P7YZRqwpoFMRFNqPm8wWORLxtNuH3+fS6c1/wizE3cpgZFdvvoPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460558; c=relaxed/simple;
	bh=dG8LORNMv4hLV38o9+LQvLvmF4TyNuHF6RVwSF8uMp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtRcHmfP8WwmmZ0K5GG6beW9944ydN8GDcP7BXn9Y8lww6MNZQOHOKc8Cbb6f0lg52hQn+2TM8KJVxURHblffjnh02/ezLNdIIh51jKjJtmzjsUjGEGXjtdzpk2sb6ZlnlU4mGIhE4NXKh+2sY4M1VasdM3i9lYL0zm3zUtbY/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UOgm3+Yi; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2ffaeff98bfso403337fac.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753460556; x=1754065356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dG8LORNMv4hLV38o9+LQvLvmF4TyNuHF6RVwSF8uMp8=;
        b=UOgm3+YiaSHrCuRIN6kOf1KZytBdK51zRU1QbcayHjMFbbROeLrgdXsOJPk9BTqOie
         bilCaF/8PmX2BHRc7HUaLKj1QeBFK7AEYNqfyRPf6H79B/dity7zGkCz7Dd+W6gDEdP+
         msKETxIheutfWevGI3Ve3MqmZR+OKjiaHEefw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460556; x=1754065356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dG8LORNMv4hLV38o9+LQvLvmF4TyNuHF6RVwSF8uMp8=;
        b=F9RLBCCCuMjpWJnJsmu9L2s3ebhhDLaH611RTHuteT4CgREe1SHQTIb0hIg/6BVHjJ
         Vma8cqfoIQ72GeHp2plduyo1uAMIbhqpMJypTFhVMfWHsRKqnnqnAzsfOOtBVcaePo/T
         vgIw3oVS/9kldx6CZVT65JUWdpJQbFhOxuDH1UZ0e5vtOmuQH0CjhgmS1gzeOyoUn69w
         qHVfw0gDv4ysSttJylkyD1Hks1CzK6WTD6lbioskGLnL3R8z9uE9ObiQ64WnriwwznTx
         uyflJX6Er4YVaWXU8HhPL8R/rIVRZZ7YiIni0YRGxTfgG7WWLezHt9H/3NbcTyttRYCu
         TMdg==
X-Forwarded-Encrypted: i=1; AJvYcCWNiJwhsqkE0/eaDYdBf9ALVzl5i7t0kpBSSRTT0c6HamYuNCFY227jm17Kzhk/y24GqBf1C4L5pqtNAtk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfIs1O/gQ6dZg4Ot5Jv7q992Pg7y2CPRX56dFdyEHd4WO0kxb
	IAZ+yNjwflmEHMD7WGu8lhfhoePqiy6bEo4oFCQhOz/tusp/5R01hb9IatTRHyUF0d105IoabJ6
	PR91Gn9CI7ghV1vzqaz40sHzEGwjVxSNwXJ5FTnDq
X-Gm-Gg: ASbGnct0y0ZOvQ+AYc7ixdp5+tv1nrapRYelbOph4Q61MIKJVN0aupLUFatbUoyezoz
	FQCPoMXo50zo1a2E7hwBRm0OXhs07muJjCulmEj4pf120JoejyQblgtZDQ0PhdB2e5Pun6q3g8r
	HxlbOm89jiWP5meIGuQjgomRy3upjkfamB7rwgmwBLgZg0RV9CU1lbS5lpfaQe7D/VqHAT6uz/k
	Xq9tXGfJZSRC9n5MaiabSUC/AJGZr4ZEkQswA==
X-Google-Smtp-Source: AGHT+IE+9r3hfO5zBRvfZvNR3MWRAD5H7Tw6vqB+Cze1RNE/NgXdJj+e5F7QgK/8TZwJ6pHwkdNSQnKE9BFj7S821Go=
X-Received: by 2002:a05:6870:a906:b0:2e3:8acd:d48e with SMTP id
 586e51a60fabf-307020bb42cmr539535fac.9.1753460556314; Fri, 25 Jul 2025
 09:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <CABi2SkU75e7tXcpgnLbDhqSJBWVPOvmfMh2uPsU3mUjMUhhYqw@mail.gmail.com>
 <38ed372a-4b27-498e-bb3b-f95792bbbe27@lucifer.local> <9c861191-ac9e-4d26-b2a2-1facfa45de44@redhat.com>
In-Reply-To: <9c861191-ac9e-4d26-b2a2-1facfa45de44@redhat.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 25 Jul 2025 09:22:23 -0700
X-Gm-Features: Ac12FXzA-vO48FLSIgwm34Yvy9xCrveF7N2ZBWVVo5aGocgvC73fwOsfOIwjfIY
Message-ID: <CABi2SkXLnsXzE3HUQndyAY__hZdO2QPDRrgG9+cUvTNSTMH-nw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 2:53=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> >
> >> 4. We could ask applications to switch to non-destructive madvise,
> >> like MADV_COLD or MADV_PAGEOUT. Or, another option is that we could
> >> switch the kernel to use non-destructive madvise implicitly for
> >> destructive madvise in suitable situations.
> >
> > Umm what? I don't understand your point.
> >
> >> 5. We could investigate more based on vma->anon_vma
> >
> > I have no idea what you mean by this. I am an rmap maintainer and have
> > worked extensively with anon_vma, what's the point exactly?
>
> I think, the idea would be to add an additional anon_vma check: so if
> you have a MAP_PRIVATE file mapping, you could still allow for
> MADV_DONTNEED if you are sure that there are no anon folios in there.
>
Yes. That is the theory, thanks for clarifying it for me.
This is exactly what I was trying to say in my previous response:

"We could try having destructive madvise check
vma->anon_vma and reject the call if it's true. I haven't had a chance
to test this theory yet, though."


> If there is an anon_vma, the only way to find out is actually looking at
> the page tables.
>
> To be completely precise, one would have to enlighten the zap logic to
> refuse to zap if there is any anon folio there, and bail out.
>
> --
> Cheers,
>
> David / dhildenb
>

