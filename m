Return-Path: <linux-kernel+bounces-862015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBBCBF43F7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4D318A8318
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED78225403;
	Tue, 21 Oct 2025 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5OL/Vng"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA42222B2
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761009938; cv=none; b=M1XDPRpf9WGHb/zyKh3eb231PGm1IarbHpu9LXhzVDVkf9uPC4rseMGcfV2MCz6zKgPVBjUUMNn5NnOQiPet7RRSfIzFHJyu3bAEO5bpKkUwmWAvUVdbCWbgs/ZZdSplqcEDfc4euzfh1Fit8Ss+eitg5yUYbfxSJLk0pVlON5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761009938; c=relaxed/simple;
	bh=GjsFaUJ032/OsKYpKxSWtTao9KqUX7eLpDoj4qlA8XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXRKDVIS6ep2FT5UdTgevrKh5KqXsmRSOz6EPgWGl+2+RvBw1jdE8ZB/zO2tWPgaiZFGh6CbHoYZFe2IEfBa+L4beSpSE2gdJIJZ2gC0AWvSF+QlrQPKh2YKJmNNFtOGT2eRzIb6hXK6ZVRHeyckP6kqJDsRxAXHRSHniZQitjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5OL/Vng; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b4736e043f9so840599766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761009935; x=1761614735; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BG7SoKS9/O/tcXiBlLtu/WD3ge13Fh8Ow5gh6NGHAQE=;
        b=f5OL/VngBC0bmzVws0qTjsJgWA6vkZSf5le47nZyQjfWG1mWiTuzXUh9FUnZreajYo
         yREZfF6r++YXgfP+Hfk0OhgIVBdWcdC6mA12vAKBDnb1t92gCrWdOppVK3xPDfl4Xpka
         Xci2zpcZ0rNThNs5bVAHkmnQzmKeDFnLOh/hqKoma4LvlQbYHUdek5a8uSKzTFtPC47D
         fY0Mp2P5Nv8zs+vFCVZdWijc4rihYK0M6PIixLLPrwByE/26k9Y+X9laVR4w2b8IWeym
         v80aaCWbqeZA9Z20MUk+5DA9dpZqv4bTAitLAFV3uxMQZYNNWgH73CESu7cn3BfR8FEW
         0aqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761009935; x=1761614735;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BG7SoKS9/O/tcXiBlLtu/WD3ge13Fh8Ow5gh6NGHAQE=;
        b=SYbP32SAyz2WNGgDtJJw7OJby7KWehinWORygJb3pShoYZPhCKvKiDVhem30AOTsSd
         /910aWwKPaMq5Z0jSAp/DQ/VKC8qWp4S5Mf3NWxxH/E7lFct7FARh+PTdsIbuhdpk32X
         fXmEtH24URj1rfb9Fgjvvtbn+YMVw0+JheokwFv0FDYsiejOds7pxJ5vvOH3yhUGD9VU
         fZuLObH03UMnVq36AaxzyxqJZcpupELcnyeQZQsgtwBFAaqsXXcNagdxpDaoMgG+g+xY
         uufohcGsMnMxTIbC1Vf93ukzjUTz5JAYZYhN/4yrPUm/wtDusthEXvU91HW5jL1TQscS
         By7w==
X-Forwarded-Encrypted: i=1; AJvYcCXywgX3LZ/z0b2dJCUSQoOUOL+1qz2TtLkCXKHuLrSFsRo6tLLVnrrT6Elfn6QmQcMgR9tJMiCq7+OqlNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywCaz2JSpCZIJmkzaKiHT5ZCB7CpZvvIPuNBjiRMY+N//RK37N
	LEjB8EEGZCPAWdY8CpKBy4nfdJ4jAyg5UY2TnCJ/78m3FkAeHIrNdu74
X-Gm-Gg: ASbGncvW5hDGt6H19C1DXWsu1Plj0h802zFgg/HoOROXdtIVusn/EknvbHozX7U+22i
	T0tB/oe3prSJyJMYC1LfIKtwZXJRAHFR+Bx943NWlSq751rM87JUL+O4mcIy8KwwvyKzz2r3AWn
	R7OXY/gF+8J4zjOyeqWYRAMvgqweWI+1f0yb0KoLZYDH+/0O0AhGIKNIhVKtMCrQ74UjCZNS6pT
	+kh2/1EzGP7+SYX30ypvIuImkPeHfIyKQjZTeNMbwS0QTEDrnVHZXq80acVhVaq8W/XnXVSs8ot
	S2Cd8LW7tnI8ICezQD+sbfKKwb9tJlk/5cOeNp4K9V1cvydUsMPBHYfd0qKHTp3Llzeo/EV7pX+
	jBuf6OR8r4DCCZ64duPj/zeVB4nAnwmK0u41PUZgZdGPl3xIO9aNu7WDx2ZruqtuFgnHt5B5Sm1
	g=
X-Google-Smtp-Source: AGHT+IFM31KPAYyRjDfoD/9D5Nx9v+qFBF8RhgeZUBp3l5o6040IQ9FM7n7kjf4PJLadaE5pzBK6Mg==
X-Received: by 2002:a17:906:fe09:b0:b47:de64:df1b with SMTP id a640c23a62f3a-b6473b5263fmr1916166166b.39.1761009934387;
        Mon, 20 Oct 2025 18:25:34 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83958fbsm941504666b.27.2025.10.20.18.25.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Oct 2025 18:25:33 -0700 (PDT)
Date: Tue, 21 Oct 2025 01:25:33 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
	ziy@nvidia.com, David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH v2] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
Message-ID: <20251021012533.56rdl6v76plkw4nl@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251020210816.1089910-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020210816.1089910-1-gourry@gourry.net>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Oct 20, 2025 at 05:08:16PM -0400, Gregory Price wrote:
>We presently skip regions with hugepages entirely when trying to do
>contiguous page allocation.  Instead, if hugepage migration is enabled,
>consider regions with hugepages smaller than the requested allocation.
>
>Compaction `isolate_migrate_pages_block()` already expects requests

isolate_migratepages_block() ?

>with hugepages to originate from alloc_contig, and hugetlb code also
>does a migratable check when isolating in `folio_isolate_hugetlb()`.
>
>Suggested-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Gregory Price <gourry@gourry.net>
>---
> mm/page_alloc.c | 15 +++++++++++++--
> 1 file changed, 13 insertions(+), 2 deletions(-)
>
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index 600d9e981c23..da2e65bf63e3 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -7048,8 +7048,19 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
> 		if (PageReserved(page))
> 			return false;
> 
>-		if (PageHuge(page))
>-			return false;
>+		if (PageHuge(page)) {
>+			unsigned int order;
>+
>+			if (!IS_ENABLED(CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION))
>+				return false;
>+
>+			/* Don't consider moving same size/larger pages */
>+			page = compound_head(page);
>+			order = compound_order(page);

How about using folio_large_order(page_folio(page)) ?

>+			if ((order >= MAX_PAGE_ORDER) ||
>+			    (nr_pages < (1 << order)))
>+				return false;
>+		}
> 	}
> 	return true;
> }
>-- 
>2.51.0
>

Generally LGTM

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

