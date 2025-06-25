Return-Path: <linux-kernel+bounces-702585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0769BAE8463
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 15:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4028173033
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F475264618;
	Wed, 25 Jun 2025 13:16:46 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA072641EA
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857406; cv=none; b=p6/nKq35osPK9MpIwDYeZFsrBYuLNuXrL1dncGPVc+0N2lzGaYag8R4AEd0CghegNkIOUGB4Mb5jl4rdCA0DqSXSzkQcyAkRr95JWi9nz3AAw4CcANFlB8TU6A/RGGdvq55W8ZY48jckFZaCx6cDdCLd4lc2oy0fzJ/hAqHANuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857406; c=relaxed/simple;
	bh=4CpkSQhruvCRcQ20qi8I7WhktLgeu8TyxZ6Xjev41mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgvYCYAL/8M6xRmNa5AzoSqbA74ritDJ3KwA8mlyeEXN264KZv5d4zoUWohdCuNzP6xL8dJW4y2UdKWPxdPubu+72jPx5CsxiMNoP9KmhH5HF354bfRVlzvnFutfWqLcsgG5e6Z5o3llCOy/OBGeNDo+goLVlBsEPUlx6ui5Fnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55PDFkYM012486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 09:15:46 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DC9672E00D5; Wed, 25 Jun 2025 09:15:45 -0400 (EDT)
Date: Wed, 25 Jun 2025 09:15:45 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com, yi1.lai@intel.com
Subject: Re: [PATCH v2 8/8] ext4: enable large folio for regular file
Message-ID: <20250625131545.GD28249@mit.edu>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-9-yi.zhang@huaweicloud.com>
 <aFuv+bNk4LyqaSNU@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFuv+bNk4LyqaSNU@ly-workstation>

It looks like this failure requires using madvise() with MADV_HWPOISON
(which requires root) and MADV_PAGEOUT, and the stack trace is in deep
in the an mm codepath:

   madvise_cold_or_pageout_pte_range+0x1cac/0x2800
      reclaim_pages+0x393/0x560
         reclaim_folio_list+0xe2/0x4c0
            shrink_folio_list+0x44f/0x3d90
                unmap_poisoned_folio+0x130/0x500
                    try_to_unmap+0x12f/0x140
                       rmap_walk+0x16b/0x1f0
		       ...

The bisected commit is the one which enables using large folios, so
while it's possible that this due to ext4 doing something not quite
right when using large folios, it's also posible that this might be a
bug in the folio/mm code paths.

Does this reproduce on other file systems, such as XFS?

     	  	       	     	  	   	- Ted

