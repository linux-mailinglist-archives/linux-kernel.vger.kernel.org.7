Return-Path: <linux-kernel+bounces-766009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B39B24136
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C611188645A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 06:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9820B2C1589;
	Wed, 13 Aug 2025 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaGErLvG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089ECCA6F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065599; cv=none; b=nVb8EKRt5TmhpIjHNa8enWich/jvNzzV/KpUaj+rlbajnCfzDq91agReawmtlrORlvsVffo5FmQPq1A4Y0UTnoUAm3R+c7JWbCtS8b/1oHiGjUkEj2VuwNRNBffcd4syJ1GygfjeGxS7D3+0fOGhp8PiCCacE6L78QG2U5V6ZWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065599; c=relaxed/simple;
	bh=W5Vfudbw3qeEII0c9j4i52O1FO47zCV2DiZIss0JO4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0RZ9LCGS4X/MGejNXDFQ3TqG48/sSQ3tbH6jZ1DsvU9VAZUdq/5bpt0vqgfwB/GVmOGyouNDwG2XNoaEiECDUvI7PhmHXXelwG8L7K/zvKaDYQ3kxfqPUWfSsibdKrHywnBemx9UIuNz6chnIc5sP95S2804q15JAuIvTvr6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaGErLvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADA5C4CEFC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 06:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755065595;
	bh=W5Vfudbw3qeEII0c9j4i52O1FO47zCV2DiZIss0JO4o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HaGErLvGaAU8iPq51GvZbOSF8bgVJTdYgNNjhQONjDVHpp6iQN/Xd/wUTuqRvdWwG
	 C5V81/RyUZ0veu6c1t4lLHx3JQgOFa6JsEAQRoSlGtJbPfD49eubq/ffu8hefxwMBO
	 Cg25lrQyWZUQ98P6ecd9UUZuyRU9rjWGGoJ8RvKHZruQGjub9xv9Fg/l3ZkEIGV/vb
	 h1NNKHmExWIpR64z4XAIku1hW23VUHHBnaNBnlq8kNLPNdZQPD8R+72C0Qx1FyjsZX
	 8B+AvtX782m9eaF/Yf3k3srQzSKX+tNjK+2yZO5YOyeeEmhtroJCJ0jA3dmxCvextQ
	 RL6PWXN+UNEWg==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-718409593b9so65171797b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 23:13:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXWxOuKZvz0b3rPSs/IvfY1MFgUeXOIvvdhNI/TmZznaiJ91Qa4T8bExwunzodXF1vraPbod9sjAJJGElI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlB4N/DPCCOGNtPh1rj5e7hDLLV5Cadql1ZfwyEPU8SGnjpWZk
	9bRXgSV0NwVZzx/sKZMkckVPFlbgbqV/fHQj0KnmjowsE+ye3x375pkqXcjM/bHE+MVGhPpibaA
	M0dNpRXP6r8bZTudJApltiiyI9TJQ1D1egoGpLP0w3w==
X-Google-Smtp-Source: AGHT+IHMJ5hrM6BYKWddcKV/9mOqGWSx0UjeiK7PsjXv12HL+iSu6pnGr7etupATkzLG1i+MPBDUdWzLk+/7HkvRlqo=
X-Received: by 2002:a05:690c:d:b0:71a:4550:8ac3 with SMTP id
 00721157ae682-71d4e54bf5amr25032997b3.22.1755065594874; Tue, 12 Aug 2025
 23:13:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-swap-scan-list-v3-0-6d73504d267b@kernel.org>
 <20250812-swap-scan-list-v3-1-6d73504d267b@kernel.org> <CAMgjq7CL1pUr25efhu+bT1PRdqw+TkAaCCsBi-1DRBfd28N4OQ@mail.gmail.com>
In-Reply-To: <CAMgjq7CL1pUr25efhu+bT1PRdqw+TkAaCCsBi-1DRBfd28N4OQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 12 Aug 2025 23:13:04 -0700
X-Gmail-Original-Message-ID: <CACePvbXQ18XYSRu4nGCokvZsh21j=oBk0_h9S+A7Zw_4Dv+S7g@mail.gmail.com>
X-Gm-Features: Ac12FXyExJGsUwe-uc3d8vHsYw8Bq_bDHUwNl1cib-OweHDW8DGc-AcFLU7hpcM
Message-ID: <CACePvbXQ18XYSRu4nGCokvZsh21j=oBk0_h9S+A7Zw_4Dv+S7g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/swapfile.c: introduce function alloc_swap_scan_list()
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 9:57=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> I've been testing on top of a locally updated version of V2 for about
> two days, and it's identical to this one. This looks great, thanks!

Thanks for the review.

I have been running the swap stress tests on kernel compile as well.
No issue so far.

Chris

