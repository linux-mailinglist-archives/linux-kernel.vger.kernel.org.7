Return-Path: <linux-kernel+bounces-748636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA20B143FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 23:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2539E18C17B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 21:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A84275AE4;
	Mon, 28 Jul 2025 21:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J6hlhVKs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA5D2528FC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753739066; cv=none; b=qtyoD9/AwSQM4IA1TUvz+Cv8kFSV4A5vxgjeyWvu29vWMFmVqs76XJQXZDqNeWlI13reUf7PxQ2Gg0Z1R5Djf2M+x3vDkfcRiHqLm8EaPrFeA06WVJTk0YrE5OcubMIVBhfU5u9FuM55MXZ8vbdfYuAMBPdfNBQpQaltte67xG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753739066; c=relaxed/simple;
	bh=e4qpRsRlxizUPvkIKw+wZTEquLyTGsFG6AbZAuYAuf8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Tm2/xJ9twBROCo+nHEdIJ95+zbcpZFPFkiwHk2XMx3RXoXgQdxOEb5rBEOa+yLThGIuOSMPpZpP1W2U+7Iko2ahKxpUBGYsjp467s+w9Ehj/OSM+5nT5JN4RD5ZJUxAzk4sy/jixX5HTJiwfz9bR86yDXMIVoCYUxbR0Bha9cU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J6hlhVKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C71C4CEE7;
	Mon, 28 Jul 2025 21:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753739066;
	bh=e4qpRsRlxizUPvkIKw+wZTEquLyTGsFG6AbZAuYAuf8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J6hlhVKstfGAVfcVCcw6+XhmyqGiw7p9N4a59jQox7nDjH/qkEppQae1cRg7vPy4n
	 q1RrqH34k6DYMG4jKgxjZLg1tJ4JOGrVtQ3V8xcjRMN20mFm03JPOSfwTtx4WsVfNI
	 i3c8G+aflc7MLDU69A6WWrv7OkJu5tu0A/ETKS2g=
Date: Mon, 28 Jul 2025 14:44:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: hughd@google.com, patryk@kowalczyk.ws, ville.syrjala@linux.intel.com,
 david@redhat.com, willy@infradead.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, christian.koenig@amd.com, ray.huang@amd.com,
 matthew.auld@intel.com, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH] mm: shmem: fix the shmem large folio allocation for the
 i915 driver
Message-Id: <20250728144424.208d58d5a95057ee7081ccd8@linux-foundation.org>
In-Reply-To: <0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com>
References: <0d734549d5ed073c80b11601da3abdd5223e1889.1753689802.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Jul 2025 16:03:53 +0800 Baolin Wang <baolin.wang@linux.alibaba.c=
om> wrote:

> After commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs"=
),
> we extend the 'huge=3D' option to allow any sized large folios for tmpfs,
> which means tmpfs will allow getting a highest order hint based on the si=
ze
> of write() and fallocate() paths, and then will try each allowable large =
order.
>=20
> However, when the i915 driver allocates shmem memory, it doesn't provide =
hint
> information about the size of the large folio to be allocated, resulting =
in
> the inability to allocate PMD-sized shmem, which in turn affects GPU perf=
ormance.
>=20
> To fix this issue, add the 'end' information for shmem_read_folio_gfp()  =
to help
> allocate PMD-sized large folios. Additionally, use the maximum allocation=
 chunk
> (via mapping_max_folio_size()) to determine the size of the large folios =
to
> allocate in the i915 driver.

What is the magnitude of the performance change?

> Fixes: acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
> Reported-by: Patryk Kowalczyk <patryk@kowalczyk.ws>
> Reported-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Tested-by: Patryk Kowalczyk <patryk@kowalczyk.ws>

This isn't a regression fix, is it?  acd7ccb284b8 adds a new feature
and we have now found a flaw in it.

Still, we could bend the rules a little bit and backport this, depends
on how significant the runtime effect is.

