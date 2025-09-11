Return-Path: <linux-kernel+bounces-811265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73497B526AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2631A179FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05C61DE2BD;
	Thu, 11 Sep 2025 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LS7IA5tc"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7431B4AEE2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558947; cv=none; b=rv91L/HTd6hTTpDBk7w/QMx3MbNNuLMQJ+Pfr11oLT2Sl7QJH4oa8Hj3lpgpJbgb+4qZovSmYG7m9t+/IuB4Ntoy3rfF0t1sOn1Ry2lvDYy5ZSwl7JToa3uNStafcTNSDLz/hVqladZJ6j6Sjc5zniKwvQR3uxhh787FW9uTY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558947; c=relaxed/simple;
	bh=muKQ5yHvUIEGcVFO4CGTi6UHB66Qkw60+GsfVH2MQtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iz/t0kxAJleGc+/G7TzEC7DR2D8N53nNCvpR+Xpw+JUh3FgMPaSLqlzvuhXL26MqUh9VIlKH7yhfSXTOpuRIv+sdK/j1GxKKGFsv1F+uWLfHkETNbapO76NuPpkk/dq0i2ScjjoE4gkowRvxyDT0ZbDLCqfVB9AwtJ5T/txrpro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LS7IA5tc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6228de28242so383962a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757558944; x=1758163744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OZoiAx3D14NUhogiseSPH9gCaOHyrKTxNV9KPmuGJk=;
        b=LS7IA5tcIf+ETMtMs5g8VbVGNL4Zc/lUFSfDQhbZpZ6ccYn+5mqm/ty9b2AFQV/kfO
         5TUemuhi+oEHkgBFlhV5iIyV1IEoIz7ueAkXDuoabsJj5eu3KJPrhcE3eIKgs47tFlDQ
         ZZv+Z3rTDAAOa2sOnW5jqhym/ma0r44fkfG1bwRzxTCi5rAi8VjwrBxFoI0o4ILEE2f4
         QL2pTtZn4u/NCi1dbin0Ak2R5xT2WscMi3ux7d6i6GfrvkOh+hgmlptetOJXVJL93/T0
         zPwJXf7TKasnQSKLLxR920Rr6WYiZhu1k7h0S2kgyuZBHGlzYXE/aTZ7dH4z1eV8pHwL
         IMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757558944; x=1758163744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OZoiAx3D14NUhogiseSPH9gCaOHyrKTxNV9KPmuGJk=;
        b=scC/0Sj/hjxZ969pAedHOIscoE9k6dkiV1TqrvzIxbO4/44E8Vxnf9YOwGUXBAKnL1
         4bbuVpwFYUIc4oZ0LYvDhxL6Way0whGH+XCEGxiypWfxo9+/ES1kteRlzGuIADNvOwMK
         Of1w7Cn6hAJk3TsGmNzwBib51kbugCM/C6CpZsV/DK3nVnVOeRtmYuoXrF/ZflJmcNwz
         T0XhMvTtZQ0UFs/uJT4OF9oeQPfAdAKHY2lE1m+vXUrwlQvSeT/+krl06OT+Fsz1dtvJ
         NCivu6H1IBRa0roYGt+lqEDK+etu5M0+MNb1DZAs36HOKeZq/U2HqYbk4DbjLxb1a9v3
         mqYA==
X-Forwarded-Encrypted: i=1; AJvYcCVe8qVEdluQ/dZMTHpICUkTlgCwvS/P/w/CGkiTJp9eQ/3Qhd6Ic1SNa1ujxjLCfrKpzyrw1nvDOMSzWcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn8wBnoQ8tIQClZYLtpmmkgK8UevmckHgt6GhRf+Pdt0dTwiRs
	pijez8N8Gdop/JGpdoxbMiarXgKEYrgx1K+2dAM62mt95iQS5AhApd9Jw8o675l1tEb9Ar2Ewat
	PrvrkBNX0nw4VtbBfhX+YPD0LPsdsWrU=
X-Gm-Gg: ASbGnctuV0psGSh2r722EMdZZ2ZX5yKBPuhdGz5BuMJSmnb8xzzsc75mE0EdJ+l+GCh
	jjLTmH5NPi1yw49xmdJ4Q+wuAsv6ocXtYtbkgVNTRKOZo6tbWiYvIk58C9mweVvyAj05S5tkpIg
	DoNc6Sj8Z8jaj2EjBPSQQF+3xSlIN2g9pL3E+vqZMQ+uMLixInpFmd3owWVKsEXm9xcJPjhPhIV
	pgrs8vgIyY=
X-Google-Smtp-Source: AGHT+IEYHmvG/jugLq7AgXA4mg/ZW7DuKWF7PgpBRp/DjnIiezoiI7BVOiKnT/2u6xwHYZ46AUuUh+pceBX2k8UFMyc=
X-Received: by 2002:a50:f605:0:b0:61c:c9f0:643b with SMTP id
 4fb4d7f45d1cf-62e7532be3bmr1184638a12.0.1757558943455; Wed, 10 Sep 2025
 19:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910160833.3464-1-ryncsn@gmail.com> <20250910160833.3464-12-ryncsn@gmail.com>
 <CABzRoyZc1zHHy5eFaO5hRY=bM36xsk3COd=r18KahmrP11tpSw@mail.gmail.com> <CABzRoyaAA3D0nfkQcBMjZ7crUckJXXpGmYfmq6ojQC+BQUigFw@mail.gmail.com>
In-Reply-To: <CABzRoyaAA3D0nfkQcBMjZ7crUckJXXpGmYfmq6ojQC+BQUigFw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 11 Sep 2025 10:48:26 +0800
X-Gm-Features: AS18NWC5UawFwugDPvNI2uWDDImGqhex1CbdEPqHScQ40krGyxpQdpVNzqIYko8
Message-ID: <CAMgjq7CtYpe4sEYaw2carqGskvchV9Z+1yn2Wa3nMP2VguV_eQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] mm, swap: use the swap table for the swap cache
 and switch API
To: Lance Yang <lance.yang@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 10:34=E2=80=AFAM Lance Yang <lance.yang@linux.dev> =
wrote:
>
> On Thu, Sep 11, 2025 at 10:27=E2=80=AFAM Lance Yang <lance.yang@linux.dev=
> wrote:
> >
> > Hi Kairui,
> >
> > I'm hitting a build error with allnoconfig:
> >
> > In file included from mm/shmem.c:44:
> > mm/swap.h: In function =E2=80=98folio_index=E2=80=99:
> > mm/swap.h:462:24: error: implicit declaration of function
> > =E2=80=98swp_offset=E2=80=99; did you mean =E2=80=98pmd_offset=E2=80=99=
?
> > [-Wimplicit-function-declaration]
> > 462 | return swp_offset(folio->swap);
> >
> > It looks like a header might be missing in mm/swap.h. Please let me kno=
w
> > if you need any more information.
>
> Confirmed that just adding #include <linux/swapops.h> into mm/swap.h fixe=
s it.
>
> diff --git a/mm/swap.h b/mm/swap.h
> index ad339547ee8c..271e8c560fcc 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -3,6 +3,7 @@
>  #define _MM_SWAP_H
>
>  #include <linux/atomic.h> /* for atomic_long_t */
> +#include <linux/swapops.h>
>  struct mempolicy;
>  struct swap_iocb;
>
> Cheers,
> Lance
>

Hi Lance,

You are testing V2 not V3 right? The build error is in V2 and I can
confirm that. But In V3 I've added "ifdef CONFIG_SWAP" for the
swp_offset usage in swap.h. I've just tested allnoconfig and it
works fine on aarch64 and x86_64.

V2: https://lore.kernel.org/linux-mm/20250905191357.78298-12-ryncsn@gmail.c=
om/

