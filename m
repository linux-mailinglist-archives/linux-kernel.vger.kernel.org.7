Return-Path: <linux-kernel+bounces-758394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DACE4B1CE69
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C7B93B001F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7E3226CE5;
	Wed,  6 Aug 2025 21:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArNiiRcR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771E224AF1;
	Wed,  6 Aug 2025 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515743; cv=none; b=symznTTLAaAr9eYDr4r6Mio1NalV4r32bYbA0zIs3RoByFuLKfASLZizRpxU942Tp+wLNEX17zNMCA74G0RH55w7Mu7WO41kY6Id8GBlka/TBqjT3LpSyu8gYwEIFk8hjClhUXNufO571Tgtm6YrFP8LmIBon6VKmJ6WdYD/0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515743; c=relaxed/simple;
	bh=Fq/MOI2IKGG/4kPRJlehFii6lGQAeZnINeDyXd2WKs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UYtJVLlae1yGy+zUZhzKxlJEgDc/U3/FSyJQ8nsqpo1NZ6+vImKPu0E8SBFshWQK4fpfFsHb58S3+AICTpb8I2IfDZLOyyPojGfiYGekqU4+mqwY9mtwvTUJRd/nIxIOHRcEcKeHrOXHBMwTdEQG4Ima9e6l/sHqwurgPvk/SWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArNiiRcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7E9C4CEE7;
	Wed,  6 Aug 2025 21:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754515742;
	bh=Fq/MOI2IKGG/4kPRJlehFii6lGQAeZnINeDyXd2WKs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ArNiiRcRKorpVO7z+DunHSF3hxUwxK1EDgvBb0KT5vuGoa2JxHw4Hiaw1jIzkcn/o
	 l6F0dgqDxDXC2uQcXCFC5MnqwdeR0xzuzO3rfzI7SkQ8sGhRG2wfo5Z+wHuMMbeM1J
	 zimEjSX1KoMR5gu8jqbdNa2KZ9HmhDXHDusk5BiYoRJR728drUcex1rGiViuqjqo4J
	 E5it6p4zZSmW86oUo7idBi9RYF8w3U1h1o0tZHAWPRS2VNCTPiZ3Ay1iAnJ1X/VTj3
	 sJ8XQMWzQqOQ3JNlpQlSI5Ef7XrlYwRmV9P53J6AtenIBJlpMCv3a0a4IeM9rbT2B+
	 0DV5Mmst4abnw==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>
Subject: Re: [RFC PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Wed,  6 Aug 2025 14:28:59 -0700
Message-Id: <20250806212859.51259-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <055a8a69-731d-43b8-887e-54d8718877cb@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 6 Aug 2025 22:14:39 +0200 David Hildenbrand <david@redhat.com> wrote:

> On 05.08.25 18:56, Nhat Pham wrote:
> > On Tue, Aug 5, 2025 at 3:47 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 05.08.25 02:29, SeongJae Park wrote:
> >>> When zswap writeback is enabled and it fails compressing a given page,
> >>> the page is swapped out to the backing swap device.  This behavior
> >>> breaks the zswap's writeback LRU order, and hence users can experience
> >>> unexpected latency spikes.  If the page is compressed without failure,
> >>> but results in a size of PAGE_SIZE, the LRU order is kept, but the
> >>> decompression overhead for loading the page back on the later access is
> >>> unnecessary.
> >>>
> >>> Keep the LRU order and optimize unnecessary decompression overheads in
> >>> the cases, by storing the original content in zpool as-is.
> >>
> >> Does this have any effect on the movability of the given page? IOW, does
> >> page migration etc. still work when we store an ordinary page of an
> >> shmem/anon folio here?
> > 
> > Good question. This depends on the backend allocator of zswap, but the
> > only backend allocator remaining (zsmalloc) does implement page
> > migration.
> 
> Right, but migration of these pages works completely different than 
> folio migration.
> 
> But I think the part I was missing: we are still performing a copy to 
> another page, it's just that we don't perform any compression.
> 
> So I guess *breaking* movability of folios is not a concern.
> 
> But yeah, whether these "as is" pages are movable or not is a good 
> question as well -- in particular when zsmalloc supports page migration 
> and the "as is" pages would not.

Maybe I'm missing some of your points.  But there is no difference for "as is"
pages.

Before this patch, zswap asks zpool (backed by zsmalloc) to allocate memoy and
store the content of the page in the "compressed" form, if the content was able
to be compressed.  After that, the original page becomes same to any pages
that swapped out.

After this patch, if the content was unable to be compressed, the content is
saved "as is" _in_ the zpool, in a way same to those "compressible" case,
except the content is not changed.  After the saving is done, the original page
becomes same to any pages that swapped out.

Zsmalloc will support migration of pages that backing the internal contents,
regardless of whether those are compressed or saved "as is".  From perspectives
other than that of zsmalloc, hence, I think no difference is introduced by this
patch.

Again, I'm not sure if I'm really understanding your points.  If so, please let
me know.


Thanks,
SJ

[...]

