Return-Path: <linux-kernel+bounces-795343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E05B3F052
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 23:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20782C0786
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 21:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A64265620;
	Mon,  1 Sep 2025 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBWQ9QCP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4AC136347
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756761040; cv=none; b=lA2mmnTFKuvh48eEvR0nQAA0dVnIAHtrfLPaJqku/bmVYIcKVmiPeVi0ASclHFiRy7cpIxq3ckxpcHS4GVrTE9eBp6dKi3odVHqw/gZuNOYccLqjuTPitz2atRaeYKly4KyUm3I7NYKi0rzSlFfCaUlGo6MFz/pG3Vl6zMhHMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756761040; c=relaxed/simple;
	bh=Aj7jk6/4oeEo9ZStPm7WvMlGJlnzqQdxI6UIN11IhYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezf5qLqr4DfHV2hdXyTfJ1d3e0NKEff/G6y6lnvEOsrtVu2c47+oDJKtATeEa3URseKhSjGWbcc8o9NR4soIo5BpRF3Ao5fTy8Vpl+HtszMrHRv2YzOSZOu9xXuH+9hEC1+9cHY3YibB3bP0FbExfaBJmucmYuqpGxeybAyP9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBWQ9QCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8D0C4CEF7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 21:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756761040;
	bh=Aj7jk6/4oeEo9ZStPm7WvMlGJlnzqQdxI6UIN11IhYs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TBWQ9QCPZ+maZ2b5FHh2AWFgWmCrlbelbWiunk2PfRO6R7ZKuvyfRr94BGLJCnbH+
	 XEM4yNlDiwp6iwdVCmrQKzvgQYv4CXzDNuJjT/kVKDkNyxOmIAFlAHWMOQ3vS6FwEI
	 JoAqrcwAg229pTOKiHhkxP5aFYpqYlYY9WIgXyFztmZoexHR2Y9S1Yud62dcwW090g
	 jTAZUJvoTc/htvaFc8FE9WZ4gnZ8Kp75s3ehTKPdlsHd3WMCIcfHvZWz/lYpVYCRZx
	 WP+Ftk6hmwdURoLRTmGf1TYNyU1IxoRl4lkqvFy4VmVMVdz2Z3bAGTzIS9hELQl78n
	 wXLrRxKgtqWcA==
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e96fbf400c0so5174246276.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 14:10:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6WNeVg5g7KIW/rWyqKArWQtD+vm2P35eSTXMhc134cpWiN1MR175wplwC0OvaqmVKcbGulddS8vKeZ40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpCAH7m7sKxf3JkFKvihuPE13oEUQUmLl+MR1eRr7AY0BzERvQ
	76Z1hMw0voYuVh4iaBcEHq3NNudDr7GmFNOgdzGH+L966BqnsPB9/sBN/2VOD2kzYa+/E2PO9cr
	mEd1GrKDOJreZe3uIhRZixXwAlMK2F3C342dMbpnFFg==
X-Google-Smtp-Source: AGHT+IHa5GjFdHauSGeoAUuVa/rafYkP1Narry2RQd4f2CEtiAiD/CBeD5rg3Uep+9glwYbmx/jESTP93gIEzOR5Vrk=
X-Received: by 2002:a05:690c:f90:b0:720:130:eb0b with SMTP id
 00721157ae682-72273be179dmr125183747b3.10.1756761039556; Mon, 01 Sep 2025
 14:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822192023.13477-1-ryncsn@gmail.com> <20250822192023.13477-3-ryncsn@gmail.com>
 <CAF8kJuO0efOE-os=qi=i5jT1YWxspHYc=Ti1KN=uKgyFpWTRbA@mail.gmail.com>
 <CAMgjq7AkUc7hKrEL8cQ7jJTeXYBq7WqM55uQ_SZNNY8vJ7+ODQ@mail.gmail.com>
 <CACePvbWnsrGxUv15R4kMpc10wsBE2Bc-rapGyBYjekrqFJgJbw@mail.gmail.com> <CAMgjq7AT79NfcKtsfgOi6LQJViXOz-Xs5LOUmOiJYJS-DwQg=A@mail.gmail.com>
In-Reply-To: <CAMgjq7AT79NfcKtsfgOi6LQJViXOz-Xs5LOUmOiJYJS-DwQg=A@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 1 Sep 2025 14:10:28 -0700
X-Gmail-Original-Message-ID: <CACePvbW9J5_8uLi46r+wm8cHfZPdp6oui3oP7u2hLOEgJXRrTQ@mail.gmail.com>
X-Gm-Features: Ac12FXwitpUktG-d3BA20Y76Po2OE-S4dB_W14mBspRG9ZlRPf99xqxJUTjxkJ0
Message-ID: <CACePvbW9J5_8uLi46r+wm8cHfZPdp6oui3oP7u2hLOEgJXRrTQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm, swap: always lock and check the swap cache folio
 before use
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Barry Song <baohua@kernel.org>, 
	Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 11:18=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
> > So the missing readahead stats update behavior is the correct and
> > better behavior. I suggest you spit that out as a separate patch with
> > appropriate comments about it too. It is also easier to bisect the
> > commit if that kind of the subtle change which is considered safe
> > turns out causing a problem. Causing problem not happen very often but
> > it does happen before.
> >
>
> Hmm, after a second thought, maybe we should keep it as it is for now.
>
> I just realized moving the swap_update_readahead after folio_lock is
> more than just ensuring the folio is still valid. It will also cause
> every swapin to do a readahead update. Previously, only cache hit
> swapin will do a swap readahead update.
>
> I did some tests, and didn't see any measurable performance difference
> between putting it before / after the folio_lock. But changing it for
> no good reason seems not a good idea after all.
>
> So I think I'll keep it before the folio_lock. There is no evidence of
> which strategy is better, just keep the current behaviour.
>
> Calling swap_update_readahead even if the swap cache folio
> is already invalidated is not really harmful, the only thing it does
> that may effect the folio is the folio_test_clear_readahead call in
> it, and we have been doing for years with no problem. Calling
> swap_update_readahead for every folio might not be a good idea.

Thanks for the update. That is what I originally felt as well. It
caught me by surprise by this detour code path. I need to spend extra
time for the detour. I don't see it necessary to contribute to the
phase I goal of merging the swap table.

We can still add it later as a separate patch if we want.

Chris

