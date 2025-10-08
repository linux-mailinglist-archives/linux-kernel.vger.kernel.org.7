Return-Path: <linux-kernel+bounces-845983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C109BC6A19
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 23:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 921904EDAB0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6032857E9;
	Wed,  8 Oct 2025 21:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deAB8ii2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAEB63B9
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957399; cv=none; b=vCpnA06N/BSHX2Pvfxc9kjzIazGTisMd10oCBONrNBapu1+T8Z/i8JIPMpFCaSGx7FErcMkWzUs/HLkuOE83xUkrZuEzL4bPe4AX4FDz+A1+fVKcwdT2iVzPYm/8QeSv1hMrd29xoslKChviq31U+4S30opNf9OKaoXWpd7avtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957399; c=relaxed/simple;
	bh=G/ITfw+9WPz98y9dzMSfigjUmz7jNHGjpEelggGzz7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otdVS85WcoliQnTgUKl2WtipPqpzLv/JSaiHFMTu3G9vZbWMTRNamMdwvRxqpfJdd3WAJ8Rrr+3r2q4PYvNF8UKJZsjxC85fX2Zxp+nT3MzdflPl0ZGhelNqqFC1k5TQyQCu3iUFEFfrCHaop30w2fnDhP9ie4vhRMoUNoP+684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deAB8ii2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73728C4CEFF
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759957398;
	bh=G/ITfw+9WPz98y9dzMSfigjUmz7jNHGjpEelggGzz7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=deAB8ii2WyATx8rqBfOHToLSdCw0Q/ID7bW40yw6V6AVoUka+AQtzQ1ywzqNYxeTP
	 OZjhZguPrFVj9r5ZpzU1RjBZJ6Jy9HbIKCVWR2dpNX8tCTACBQU2+H+aPdYSNiWeMT
	 1JTTGlHKCuIekhqQo/dO5vR6Q/ssZcOIQ4jYizKMyNKV1oIK42QGthKQrVax2lORbc
	 frmt4ac1Giy9I8YZGXoNuzyfY03PV4Ez1ShgSm7fPvI9za40QCS82b1xh4d9kr/hjK
	 6FEr+B1gOBIXDuGNhTTYnW3jOfT40dNk2VI1uuOomvmdU469rzEEQ9A58Ma0Q2G5EV
	 LZM0+0NetIFng==
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63470a6f339so367564d50.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:03:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOXzjH4d1QUULh+u3jWgDLOjV21ccGCT6b8SkXKzBqo46TIOU3oYa8J1KCY+XybCYKbVAMBGkMiEzXrs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ2eT2oL81OMWfenNgQFrPWxAhrqnPnTtD+8W8io1AK/n0/Clv
	DWL20redpIuGzlTwsZBr62ht0ajBkmW8TKL5X42FgFpJRNblC8hCzGV8Kf7vRBiHGRe4Ua4099h
	H9U/ECnlo7MMYV3c6SDRXwoKuF3dqnung6lLvVs/KhA==
X-Google-Smtp-Source: AGHT+IFK1Omp+xmPcKgCpqNFfD5Y+SC+MQkE+F3li4un1zZc175jgUQ1tcQjQ2L4pr2ww0RkuCdLQIaf4qCjRjFoUDo=
X-Received: by 2002:a05:690c:9a0e:b0:724:bb55:27c6 with SMTP id
 00721157ae682-780e170c20dmr95905737b3.53.1759957397779; Wed, 08 Oct 2025
 14:03:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-swap-clean-after-swap-table-p1-v1-0-74860ef8ba74@tencent.com>
 <20251007-swap-clean-after-swap-table-p1-v1-4-74860ef8ba74@tencent.com>
In-Reply-To: <20251007-swap-clean-after-swap-table-p1-v1-4-74860ef8ba74@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 8 Oct 2025 14:03:07 -0700
X-Gmail-Original-Message-ID: <CACePvbXTG3qN64D-zu4-N6126ZNFCKqvMuUhrxW=aXnCkrOb_A@mail.gmail.com>
X-Gm-Features: AS18NWA4mAHlhE6n5l04RrJTU4ZEExbIpnlqnzbJgZU42WD6IdARt2KezhZIUco
Message-ID: <CACePvbXTG3qN64D-zu4-N6126ZNFCKqvMuUhrxW=aXnCkrOb_A@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/migrate, swap: drop usage of folio_index
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Ying Huang <ying.huang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the cleanup.

Agree with the other fix suggested by Nhat regarding swap cache vs page cac=
he.

On Mon, Oct 6, 2025 at 1:03=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> From: Kairui Song <kasong@tencent.com>
>
> This helper was used when swap cache was mixed with swap cache. Now they
> are completely separate from each other, access to the swap cache is all
> wrapped by the swap_cache_* helpers, which expect the folio's swap entry
> as a parameter.
>
> This helper is no longer used, remove the last redundant user and drop it=
.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/migrate.c |  4 ++--
>  mm/swap.h    | 21 ---------------------

Nice.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

