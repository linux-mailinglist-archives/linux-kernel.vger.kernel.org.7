Return-Path: <linux-kernel+bounces-756856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7CBB1BA6A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09646213BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E3299A8E;
	Tue,  5 Aug 2025 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M76ruS2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119F298CDE;
	Tue,  5 Aug 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419394; cv=none; b=G1vNxvrg2zLu5k038jd7PNYOWzkkktN60emIPAVAkWbrruD1mnWbRUtAxCmuzr7rief1/ltc/yuUzUQiwhR07Wjr7k0yJxSBj+7vsf/yVzduk6ROu7+OJ5PNQFxuig9kJGH3o/A7gb2KLWN0LpZL3otNfIaZEZ/6ypONAftBHz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419394; c=relaxed/simple;
	bh=H1l3heHwC3FXt6so5O1wZBz9sD1wO//8EEGy+nE6jPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kg7I6OIR5GODsoGpOw/rfS2/SEm9c3yfUTakIENdop1+LvqRJFxZQUrU3QABjQ/IXVcZ9jrDifuS5tO060d4RQoKwxRo/ye3Wq/tssRFbfDGJiw8v2b+uwTuLrdCZC2N9XV4jrqlms/gts+ryy1h4GS31oZtAJD03kxhLdNaxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M76ruS2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51286C4CEF0;
	Tue,  5 Aug 2025 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754419393;
	bh=H1l3heHwC3FXt6so5O1wZBz9sD1wO//8EEGy+nE6jPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M76ruS2Oj3LMc4bbOQkTKXvcMRXIr4wEKI1Ifm0OkbrwecmOPiiVEt/6Fpvq1+/St
	 J4jaggh9guKOMyoHXW2qnpe7EBrV0zZdU8Fm7SrZEnAH+CH1JAU7dTzum7OsPlO7Y4
	 UJHXqWANO5lSfjARnlCC3yFS9qcvbUUo5QpHpyCoyfcqWzO4Cir77L868aC978rGdg
	 zCuxHe1rvAxjNFzMAOUNtOA37mVQ3lUM/A4vCnegwNfMe9l0ggX2RX3hfQDEkeWuQi
	 hVWw52P7lfLWKJgVjvqEVz0PBMTghMW+aNP5w9LqOZ822t0PaWkW+StjQ3ZF6XdPhN
	 h8jSguoFsyY7w==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>
Subject: Re: [RFC PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Tue,  5 Aug 2025 11:43:11 -0700
Message-Id: <20250805184311.8563-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <761a2899-6fd9-4bfe-aeaf-23bce0baa0f1@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 5 Aug 2025 12:47:36 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 05.08.25 02:29, SeongJae Park wrote:
> > When zswap writeback is enabled and it fails compressing a given page,
> > the page is swapped out to the backing swap device.  This behavior
> > breaks the zswap's writeback LRU order, and hence users can experience
> > unexpected latency spikes.  If the page is compressed without failure,
> > but results in a size of PAGE_SIZE, the LRU order is kept, but the
> > decompression overhead for loading the page back on the later access is
> > unnecessary.
> > 
> > Keep the LRU order and optimize unnecessary decompression overheads in
> > the cases, by storing the original content in zpool as-is.
> 
> Does this have any effect on the movability of the given page? IOW, does 
> page migration etc. still work when we store an ordinary page of an 
> shmem/anon folio here?

Thank you for good question.  As Nhat also replied, there is no effect on the
movability.

In more detail, the handling of the given (incompressible) page is nearly same
to compressible pages.  Zswap asks zpool to allocate memory, copy the content
of the page into new newly allocated memory, and let the page be marked as
zswapped out and hence be freed.  Only difference of incompressible pages
handling is that the content is copied into the zpool memory without
compression.  All other properties including movability are same to the case of
compressible pages, so this patch doesn't introduce movability difference.

In the previous version of this patch, I was manually allocating memory without
zpool's help, and hence other people including Nhat kindly enlightened me that
it can introduce migratability difference.  Hence this version uses zpool.

[1] https://lore.kernel.org/761a2899-6fd9-4bfe-aeaf-23bce0baa0f1@redhat.com


Thanks,
SJ

[...]

