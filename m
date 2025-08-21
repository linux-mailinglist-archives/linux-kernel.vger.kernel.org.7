Return-Path: <linux-kernel+bounces-780281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4A8B2FFCE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3EFF7B140C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6309F2DA74A;
	Thu, 21 Aug 2025 16:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNRgbDAy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73DF277C8D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755793073; cv=none; b=g7E7v4FekYuEhSvc69DMv520B+jlJ03f0yXEeaWPHOVZwrr2dFmjdUr88jvKfhQoPW8nlkR/S7iHQKi3RvmSKWxtgQL3kRl8iOTeDyNfIbkiM1vSIOC9LimawRLVdosU9IM4BeVyn0RmdoFspa6AhJW73vTlTRM9iriPeofGPpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755793073; c=relaxed/simple;
	bh=62f4v2C5TZWy6Ea8Ev+LCACWGOLFhbSa+Hwla4aQfSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=clNLyjMdMZa/dmJw+wJXozEy7TURQ7KDzCU2nuDtQabCX5yXofnX+L/ORVWJlNuIejwsmnHQyl3oU5k4aQCw7OXDJI06KOrfJcuMqg6If5Q5kHF6yk9CwWFSSTBZKBUIin/eJwTisZ7QTw7s/GJ1oSuXVVtDVIy+suEPzv3dsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNRgbDAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AEC0C4CEEB;
	Thu, 21 Aug 2025 16:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755793073;
	bh=62f4v2C5TZWy6Ea8Ev+LCACWGOLFhbSa+Hwla4aQfSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNRgbDAyKKEZl9+zRwZ0kIv9nDBiiUGI9iztOq24T4ldF9Z2DjjelTFyu7zIriKB5
	 TQNUeYu8OEEKLXsQI1N46atx+TjxBWq6QnbIadfCaJB/5OkqSVMkwaW/rDI8xXpazE
	 OF9Ow0REARBCVYkUtWHxn3SXZSVT/+VyAyHGNdzHtwdaJ9nqB9lU83Ct+LWfXHv0Sw
	 im9et2TzfrDWZpfo6sf8Qyd+/oMfHy1zmIUTU/IRIB66iCC8ZRN1F5qcQM9Co9CW+D
	 K8j6GF4dPZ8q5LnxKgFTXS5wcAWAndnqOQn3ZcbnTV2zAQQnRAWZ1hKuadFAkgJ/VY
	 lucKDI8oCBRrg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Thu, 21 Aug 2025 09:17:50 -0700
Message-Id: <20250821161750.78192-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819193404.46680-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Aug 2025 12:34:04 -0700 SeongJae Park <sj@kernel.org> wrote:

[...]
> Knowing how many compression failures from the crypto engine happened so
> far, and how many incompressible pages are stored at the given moment
> will be useful for future investigations.  Add two new debugfs files,
> crypto_compress_fail and stored_incompressible_pages, for the two
> counts, respectively.
[...]
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 3c0fd8a13718..1f1ac043a2d9 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -42,8 +42,10 @@
>  /*********************************
>  * statistics
>  **********************************/
> -/* The number of compressed pages currently stored in zswap */
> +/* The number of pages currently stored in zswap */
>  atomic_long_t zswap_stored_pages = ATOMIC_LONG_INIT(0);
> +/* The number of incompressible pages currently stored in zswap */
> +atomic_long_t zswap_stored_incompressible_pages = ATOMIC_LONG_INIT(0);

Kernel test robot reported a sparse warning for the above line.  Andrew, could
you please add below attached fixup?


Thanks,
SJ

[...]

==== Attachment 0 (0001-mm-zswap-mark-zswap_stored_incompressible_pages-as-s.patch) ====
From 1d41d75c47a6d3ef3cbf58636faf2b4dc04616ba Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Thu, 21 Aug 2025 09:10:57 -0700
Subject: [PATCH] mm/zswap: mark zswap_stored_incompressible_pages as static

Only zswap.c uses zswap_stored_incompressible_pages, but it is not
marked as static.  This incurs a sparse warning that reported by kernel
teset robot.  Mark it as a static variable to eliminate the warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508211706.DnJPQQMn-lkp@intel.com/
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 5dd282c5b626..ee443b317ac7 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -45,7 +45,7 @@
 /* The number of pages currently stored in zswap */
 atomic_long_t zswap_stored_pages = ATOMIC_LONG_INIT(0);
 /* The number of incompressible pages currently stored in zswap */
-atomic_long_t zswap_stored_incompressible_pages = ATOMIC_LONG_INIT(0);
+static atomic_long_t zswap_stored_incompressible_pages = ATOMIC_LONG_INIT(0);
 
 /*
  * The statistics below are not protected from concurrent access for
-- 
2.39.5


