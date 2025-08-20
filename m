Return-Path: <linux-kernel+bounces-776939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1052EB2D334
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D9C2A61E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B87257ACF;
	Wed, 20 Aug 2025 04:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHcMRMXW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5847221507C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755665735; cv=none; b=jIUDoq98tiugu6CdFn2fgToU1TSVwEYilzK3wVaYmlQFgpaCGJwMCvoAzjrdYe++lTebDHQtdp5AdAYp8QmZiMDnWLoORxMAyX9hBI8RPr0mqYmkcgQvm2r91AwAHFwKLXRQx2+1Orerpm9LPrwohnl+czMCr4c4U92RL2WtG7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755665735; c=relaxed/simple;
	bh=8/ecel6coNf4uRcsoSjGxroeWHJANhH34L20ONLZsCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9XUuY3hGywQpJDv9msGAdZRqulHEYovkGnaz4yXpZhCO/ni3/uGtXpGmx2Eg950qOfjVGd5pAlVD9+/1hvx1iyM6wjL4aSbxNDcfwPkrIXBFuZMMtkfOCINzzJcgOoQIAWNohCUodMYjpXjC3+8vkKivuv94MzxrARTwk1kSsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHcMRMXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69FEC19423
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 04:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755665734;
	bh=8/ecel6coNf4uRcsoSjGxroeWHJANhH34L20ONLZsCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HHcMRMXW09/ZHyIxyuflpZFRa/kqPw11/gYcz4wcRrp5d1E6ukRIcnY/W1BOTf4Ts
	 R00ZicZxyE548miv72/wSIom/Auvros2Xcrb8smZqQ8d9wRQGQXz18FWSTavAeLN24
	 UcwI/UhOuTfpdg6MhNm4mtBjpZA4i5UN7C+5N4ljAhD/PWp5w1mBuNG4mAyClzh/fU
	 WfBgABzKtakxQGQjWdBTogrmZprn1NyYFkSMnyOG47FrZuCbomnCut+hFktcnSpYUw
	 ZBo04sgSDDzYQ7nrMthHMjq+w2mZWBSknCEwZXeVZAYc97H1OMnhXjOi6PcO5FE0UK
	 BwIh60gamPclQ==
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459fc675d11so28295e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 21:55:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpUY9KvWoe1e5YDcWrSeZ15amJ7am/RLFSR4afiwWFX0laY34rplj9xg/1uWOHETCe5QQe23OrnkjxoFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYlFLzcZaJVm+eXQyO3mXmybw/c7X3/gppCK7IybNFrqG7gSZW
	LvWJjqr/NHKMInOfKD5itmFtoTdPXexYZao4EFJsrvbkAH+ys0CQOefVqT0GzJ3hqcwKFUGThaP
	tsBB73kMPFKIavUpAxXNHvNzHSfqQmfIOXjgST0LC
X-Google-Smtp-Source: AGHT+IH024zqFBB0pYMG9UnGJoj/rOLVe3ZmOB5UPOMDvOAWoOoyAtRYfd2BCsDsJM3UbRe0N84oso0UFp3FJ7C0dAc=
X-Received: by 2002:a05:600c:46d3:b0:453:672b:5b64 with SMTP id
 5b1f17b1804b1-45b47743f88mr1123885e9.2.1755665733534; Tue, 19 Aug 2025
 21:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819193404.46680-1-sj@kernel.org> <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
 <aKUi7hvcaK0h0oMg@gondor.apana.org.au>
In-Reply-To: <aKUi7hvcaK0h0oMg@gondor.apana.org.au>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Aug 2025 21:55:22 -0700
X-Gmail-Original-Message-ID: <CAF8kJuMepN=-HPp3xqvzNxfrtHZp_2DwLp-b=rMRpsJ=mgKSJw@mail.gmail.com>
X-Gm-Features: Ac12FXwHHeNsRxjdjpScCgLpGAs7xED92MNZ42-dt7hDOrZgQ0ynOsyqaYsS7XQ
Message-ID: <CAF8kJuMepN=-HPp3xqvzNxfrtHZp_2DwLp-b=rMRpsJ=mgKSJw@mail.gmail.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Barry Song <21cnbao@gmail.com>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>, Kairui Song <kasong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 6:21=E2=80=AFPM Herbert Xu <herbert@gondor.apana.or=
g.au> wrote:
>
> On Wed, Aug 20, 2025 at 01:13:13PM +1200, Barry Song wrote:
> >
> > Let=E2=80=99s sync with Herbert: have we reached the stage where all dr=
ivers
> > reliably return -ENOSPC when dst_buf is PAGE_SIZE but the compressed
> > size would exceed it?
>
> It doesn't matter.  Software compression should never fail, and
> if it does fail due to a bug, that's not something that the user
> of the API should worry about.
>
> Hardware compression should always fall back to software compression
> in case of failure.
>
> IOW all compression errors should be treated as incompressible
> data.

In that case, you seem to suggest that the crypto library can NEVER
return an error other than the dst buffer is too small. In that case I
would suggest the crypto library remove that free form error return
code. Just return true for success compression or false on failure.

It is also strange to return a freeform error code and declare the
caller shouldn't check on it. Ideally the caller shouldn't warn or bug
on it, so it should handle the possible error other than -ENOSPC.

Chris

