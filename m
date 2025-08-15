Return-Path: <linux-kernel+bounces-771530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 677EBB28870
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A896A604C54
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 22:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DC326E6F2;
	Fri, 15 Aug 2025 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrwYwLNq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979E243370
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755297859; cv=none; b=Fh7ieT5sos6DrHhglKU2TDWQdWRtEgq4YeE74/ZYSRU0sIz9wMUVsE567lHmI/leL7P7CeeM7w5jGH0ffDRu0jwp4zDWLIOL8PiyREoxypd5A0Uim2oYoqI7s380nD89v2vCRdEUl7Bi+I7Hx5HdLhCeWHI5ut9yZoF47D4EHDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755297859; c=relaxed/simple;
	bh=9tTA6yJIOtlWQkvlonH1750YACaxZzCjwRS/RL+sSwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qLbwfsTB3wshfoU7vLQSODgeDfj4A6rDLn2tpgQIuentW4j9aidft9JcrfyaHmtfjxvh+73hqCJgPROLKZUMJ21dqnaLoxeDcsBNAdCdqjroSeyziHi1ClWv+yMcpkQZMNGDPoYtbYGZHUcdiRINKmB8rI//lVMkg+R0RR4I8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrwYwLNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38635C4CEF6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 22:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755297857;
	bh=9tTA6yJIOtlWQkvlonH1750YACaxZzCjwRS/RL+sSwo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nrwYwLNq6obtaOcAeQJETd31aF5qOwZ29gNOePVxAhtdUgXXiNzVhcmHc4mpS/g87
	 Rvu6hsVEB1lvaNE1dqFD03g2+A881LzqRMHamyutxCBfH37K24ZgFsH2CKx3IAG/DR
	 TB7Kee6zGgyFSM/vUywoPUT3VgvHjRXrpiBaV4dzj0Cba3GQYGEJ/ItUeDvjlxpr8U
	 h4qTpM2kTLbSIutNYQDN4EIlE7LqnHLFf5XUiUusx4rpfCYdR6nDWfdMPt4lspVyAg
	 BQDRv4Hv5wKQMaHfFZjpabmPKfFLGI+b1uOCnSELgvmSKj5X4QO4bXQFP9dfo5SfL3
	 EImgnizCEr6QA==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459fbca0c95so27155e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:44:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVVb5A8XBkjutvoB4yUuQtWTfdLh4fAPossQskNTXwRmNjaq9md2zRI1gtzU25QelwNSZnZeSVhjgp0FBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6EaRDvhmAgvt6b+7KShDwp+5Bb4PQkkcBZX2JRlydUrHPPRT
	5QP3mxxUtoWkK/6aAJnAcOHC11EbtqA1gP6RP2WKs6hdzrkuvwv11zFwW9wes1HDlZX1XiiipNi
	6fIS9/Jr84kcE9wUgsb9QpodJS3sAaSYQs28xhTCT
X-Google-Smtp-Source: AGHT+IH9vGzl3bcxwUyHPIGmATEV+pnZn2h8s34m7GIclnBfw/NfozgT5mRmpQ/m1SRogiZqfgbxVtuvvSH/aE4pCKQ=
X-Received: by 2002:a05:600c:1c9f:b0:458:92d5:3070 with SMTP id
 5b1f17b1804b1-45a26801babmr454725e9.6.1755297855930; Fri, 15 Aug 2025
 15:44:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812170046.56468-1-sj@kernel.org> <CAF8kJuN1BH0rqC6czj9govNOugd_5K9ijYcxbWYpEpUdQKn0-A@mail.gmail.com>
 <uo6vtumoy4txklyqy4njitf5ex4eanudncicbbzknmuowopd7v@jm4ao4qapiza> <20250813204844.GC115258@cmpxchg.org>
In-Reply-To: <20250813204844.GC115258@cmpxchg.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 15 Aug 2025 15:44:04 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNO1Ci5Y=yd4PtF9RnnNyeAa7t4e0vf3Za9g_KhLw3baw@mail.gmail.com>
X-Gm-Features: Ac12FXweB8Zkmz63VXGq4nmR_WdHvmURbsDA0P--X2Kb0f5RcNrdXJuFJF1TRNI
Message-ID: <CAF8kJuNO1Ci5Y=yd4PtF9RnnNyeAa7t4e0vf3Za9g_KhLw3baw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Takero Funaki <flintglass@gmail.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:48=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Wed, Aug 13, 2025 at 12:42:32PM -0700, Shakeel Butt wrote:
> > On Wed, Aug 13, 2025 at 10:07:18AM -0700, Chris Li wrote:
> > >
> > > If you store uncompressed data in the zpool, zpool has metadata
> > > overhead, e.g. allocating the entry->handle for uncompressed pages.
> > > If the page is not compressed, another idea is just skip the zpool,
> > > store it as a page in the zswap entry as page. We can make a union of
> > > entry->handle and entry->incompressble_page. If entry->length =3D=3D
> > > PAGE_SIZE, use entry->incompressable_page as a page.
> >
> > The main problem being solved here is to avoid the scenario where the
> > incompressible pages are being rotated in LRUs and zswapped multiple
> > times and wasting CPU on compressing incompressible pages. SJ's approac=
h
> > solves the issue but with some memory overhead (zswap entry). With your
> > suggestion and to solve the mentioned issue, we will need to change som=
e
> > core parts of reclaim (__remove_mapping()), LRU handling (swap cache
> > pages not in LRUs) and refault (putting such pages back in LRU and
> > should it handle read and write faults differently). So, the cons of
> > that approach is more complex code.
>
> What Chris is proposing would also fix that, even for configurations
> without writeback. So I'm not opposed to it.
>
> However, for deployments where writeback *is* enabled, this code is an
> improvement over the status quo. And it's not in conflict with a
> broader fix for !writeback setups, so it's not an either-or scenario.
>
> Specifically for the writeback case, the metadata overhead is not much
> of a concern: we can just write back more zswap tail to make up for
> it; the more important thing is that we can now do so in LRU order.
>
> The premise being that writing an additional cold page from zswap to
> disk to make room for a slightly inefficiently stored warm page is
> better than rejecting and sending the *warm* page to disk instead.
>
> So I agree with you Chris. But also think that's follow-up work for
> somebody who cares about the !writeback case.

Thank you and I agree with your assessment.

Chris

