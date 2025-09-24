Return-Path: <linux-kernel+bounces-830126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE024B98C7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DBA2E1184
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 08:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C7725A34F;
	Wed, 24 Sep 2025 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaZBnTzB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619793D544
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701832; cv=none; b=V+NgoHhB4yx0YVt0n9cmViLAPc0EoGpvAbDnGJqQTgVfmMZ9EaQTajoMvbVSXCTgfye3nUKRPxujbe1j04trNSWwH4W1RGZRkRNmWEIUDdlVIhxY1GzT3nrtkpBOjEniYr+WVjgkWgPJYS5cuYr2T4RXCasUtiWlUt6W1PJRkK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701832; c=relaxed/simple;
	bh=80TBCq2xtbZyQwcjgk75oUDRl3DELO/Ho2DPzv73C98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o1Ma3YBHHUM/98bfAf2ioxDNWyPGIEVwz0uBIclwaMwglc/+W5eUEUr0XthY0KcUEySc2zocboQXv+JTuAi3cfBcCSu3Hc6oSAkvOKSVz9KHCsn7I9/qe5bMuAIqQNLI/XgdZr4cs1/rZJyJph80+efjLv2e6wOm7Qx5wII9vOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaZBnTzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57D5C4CEE7;
	Wed, 24 Sep 2025 08:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758701831;
	bh=80TBCq2xtbZyQwcjgk75oUDRl3DELO/Ho2DPzv73C98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UaZBnTzBosxoU0mr/La3OpGYNa7BmjoxfFelqB9/C7od+Q7f1WnTp9pU+r0kV+A+A
	 WmFNXsaJD+IiNidYvB0jCdtBVqlmDdgLsRyS1/R41XUGtR5ZGtg7Lk/Gv1lgQVZuYK
	 tTl4ax5VkEu2QqTrUjBdxQdiUbAUa2ONQXffNQsn/poQjL/+JEoQUiSg3MoPX4LKMI
	 Bsf1F3tBuKNRtWvGbjCfZDHcp7G1jfp+y3s9s8nHb46uYDswwzFb6u2Y60DPcUjnGF
	 GEgXkjndciK1Zgni08SrT8MZG+MWtgZUPCFPE3RFfmOOh5o/+Yc9pebjZWWveC8LKn
	 +LbxcbUXjiohw==
From: SeongJae Park <sj@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v1] mm: convert folio_page() back to a macro
Date: Wed, 24 Sep 2025 01:17:09 -0700
Message-Id: <20250924081709.63722-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250923140058.2020023-1-david@redhat.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 23 Sep 2025 16:00:58 +0200 David Hildenbrand <david@redhat.com> wrote:

> In commit 73b3294b1152 ("mm: simplify folio_page() and folio_page_idx()")
> we converted folio_page() into a static inline function. However
> briefly afterwards in commit a847b17009ec ("mm: constify highmem related
> functions for improved const-correctness") we had to add some nasty
> const-away casting to make the compiler happy when checking const
> correctness.
> 
> So let's just convert it back to a simple macro so the compiler can
> check const correctness properly. There is the alternative of
> using a _Generic() similar to page_folio(), but there is not a lot of
> benefit compared to just using a simple macro.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

