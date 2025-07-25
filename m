Return-Path: <linux-kernel+bounces-745911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0245B12059
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3354B58613A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1EA2264DB;
	Fri, 25 Jul 2025 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EJeLKvDC"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE51A841C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455075; cv=none; b=sGzTlQCgptbFnciuZBiYM7yURfgiOscu7SB6rmjZFu4Jv+fW/DxUhlTjtOejHVb/JCCciRFzfPv10w7ObVOxqi6KqXiH9ouSxxcICTMfcisXtJvWLpD5QeKMQqAVmphdkUlws0Yd2/HDm3KMlo3KaYwX+s5VEIUifNE3O56LNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455075; c=relaxed/simple;
	bh=jSEGE6o5lJmJ9p46dqsi8XVAGmdKCF9JeoxaI40mPys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKIbt6YScMnVmtsdd8ZPUXL+pysdWiHpdLl/bumiSJmTTY3gpdjMe0uoxIeLC8njjjz0BlZ1Pi0XrGEhQkpiWO7ij4XNuZqbFaRNfoMd5AUs8DAXZGyvTRL11X48NtqntiPqMjMUbDwvPbhrmUCYij4e+/4iRZ3tUzYjxepuvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EJeLKvDC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60b86fc4b47so8898a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753455072; x=1754059872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/nE+IEcqT09EYKsaI5wJz1uG4N+ePEQMWFP+OoeT0g=;
        b=EJeLKvDCNBeNWFt5/8RODSYMNkTTGXqS2obk2iyF1eMeacZMa97Pjan32wSSg4Lemz
         0InRt5gMzXt/30CABI0ycKeWXmuN/jFmiS7PHtlhu4RQrRlhSIFN9SFMFf5iLX1Ula8e
         GqELtM+0VYNjx+SZ7DuX8KndDlMQx+FoVhTlBuds8IUPy56OG+Swu9JUskB0clyPX8zQ
         yG6RF2bhgEbevUAbCvSb0Rd+0boEq/r++iMOvwwxcuOuacic5NhP4J59QcJkRXkRlkn4
         u056DxK78g8cIdrYkz6q1Cjvn1jXIDLNQthbvVL+FGxDf/eg1sqntrvq5748WxSwzC+n
         kLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753455072; x=1754059872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/nE+IEcqT09EYKsaI5wJz1uG4N+ePEQMWFP+OoeT0g=;
        b=Lf9o90U3ejHnhJBd/ghFagjIqwqeVjNOny09TCUNepGdgSLsV99fOT7Y2s0ifCC2Wj
         Mne9PZT6v8v+PxsS9yP+zI+JH8h/vpMz3Tix36OjO62OTVKryR/vbIW55Wek7JhfFNNE
         nx7daKY8GwTLDaEKujXwXfyg6Bk4EmAAMLU7KdyXgrLxZu/VemTylOLpCFASJxDUff/v
         v0l2hH1rxAJ6LjbtHudTalj8qILc3zsLYZ+xXt4ysAw0T9pWphZ3iHpRgP9AazQs2c0h
         yD+qb3q/zdpJFXvIm6LTu3Ol4X1EBZ48Ky4p2+cM9JuI81eFmOvboW2znjCdomY14MnM
         6aBw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ74baQO/gPjVXePbjTu3A+9tve7RGFtkycgcqt1W5LqLZzimoxuDT5qLi1FCucx4I0UjL8fucHuMRziQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpEe+Px1lLNvmiPBd4KYezG0OzdOZsdAQmLoYwPqpOZ4cR98yQ
	0LRkewFuXWrtnfwjyMv82E1jizC64SZThfJTiSWqNO8C1/WaF36fgAZ3d2JlEFmhDKTzzdXRZjU
	ugngiu/2yBHv4rgVmTmuYIEdoKrBpiHN2JG2EAe8F
X-Gm-Gg: ASbGncv/qTG54IYwPf6Pq2+t/D9IC6nhcPrV9GVzugQh9qs4kod2T/bFuTcsZPGQtpK
	9RXuqv8Y/QtzPelq/SWzh+yueZP1JyRy+GhtdFtvHiirsqDjGXT8YryEGG+5pQ/MLJe7syjIk/v
	cwC0ATKWt2CZE0kYVbVfatLPpq1Mskig4ki9HtDbGy9LiAN6tgdXtpFdPqAyHnae4XevquZw8gC
	bczvCEwbt5Piqc6BlkQrJ/5sfDV+LvuA6Y=
X-Google-Smtp-Source: AGHT+IG1lwvRSpePK7y9eGYHxc9sTcfI3irMgXKR8bXMAVsFm8kAOC/of7gPaugNlGLD5gqriMXtX79x6wEI3XifrGs=
X-Received: by 2002:a05:6402:324f:b0:612:bec2:cf22 with SMTP id
 4fb4d7f45d1cf-614e7adb2b2mr113055a12.4.1753455071506; Fri, 25 Jul 2025
 07:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724-anonvma-uaf-debug-v1-1-29989ddc4e2a@google.com>
 <c3f04c75-a73b-48bb-b56e-7b18e57c2382@lucifer.local> <CAG48ez31aVnoBiMMjUczbmThWnRGmod4yppgMVqf2Nu5-hjU2g@mail.gmail.com>
 <50502c3b-903f-4018-b796-4a158f939593@lucifer.local> <3a2810ed-74b5-4822-b3e1-bcaa97eec264@lucifer.local>
In-Reply-To: <3a2810ed-74b5-4822-b3e1-bcaa97eec264@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Fri, 25 Jul 2025 16:50:34 +0200
X-Gm-Features: Ac12FXwno1Ye3Nj_ec3vwDkaWvQchsGEoLeSywsEebU12zoS1CIUQw1WpbRG1Nk
Message-ID: <CAG48ez1Weu==SNUZF4EZVxUe8KhG0vXnUHzHFwmuJ3mTezRHJQ@mail.gmail.com>
Subject: Re: [PATCH] mm/rmap: Add anon_vma lifetime debug check
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 4:11=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> I went checking for this but was blind obviously since didn't find, Vlast=
a
> asked off-list about why anon_vma's are allocated SLAB_TYPESAFE_BY_RCU.
>
> I notice as well folio_get_anon_vma() is _tricky_:
>
> /*
>  * Getting a lock on a stable anon_vma from a page off the LRU is tricky!
>  *
>  * Since there is no serialization what so ever against folio_remove_rmap=
_*()
>  * the best this function can do is return a refcount increased anon_vma
>  * that might have been relevant to this page.
>  *
>  * The page might have been remapped to a different anon_vma or the anon_=
vma
>  * returned may already be freed (and even reused).
>  *
>  * In case it was remapped to a different anon_vma, the new anon_vma will=
 be a
>  * child of the old anon_vma, and the anon_vma lifetime rules will theref=
ore
>  * ensure that any anon_vma obtained from the page will still be valid fo=
r as
>  * long as we observe page_mapped() [ hence all those page_mapped() tests=
 ].
>  *
>  * All users of this function must be very careful when walking the anon_=
vma
>  * chain and verify that the page in question is indeed mapped in it
>  * [ something equivalent to page_mapped_in_vma() ].
>  *
>  * Since anon_vma's slab is SLAB_TYPESAFE_BY_RCU and we know from
>  * folio_remove_rmap_*() that the anon_vma pointer from page->mapping is =
valid
>  * if there is a mapcount, we can dereference the anon_vma after observin=
g
>  * those.
>
> ^--- this seems particularly pertinent...

Yep! This was also how that anon_vma bug a few years ago
(https://project-zero.issues.chromium.org/42451486) turned into UAF -
it allowed you to have a folio still mapped into userspace while its
anon_vma was already gone.

