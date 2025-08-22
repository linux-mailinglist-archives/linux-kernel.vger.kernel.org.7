Return-Path: <linux-kernel+bounces-782560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 893D6B32208
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4186880F0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDAF2BE024;
	Fri, 22 Aug 2025 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M84mlTVS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119B31A9FB9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886151; cv=none; b=qy0Thurhac2myHHshc+MD8iX6tUG9+Qz375D+C2yJ5ezOY9TnWDtP2Glmoi4OP2hZ3ZT5qdffnyZv6RNkWtzPh5A2rIPXPpJBAtWUbZumbNgwBUKIj318/TF4eBVtJNgIqU27qGExB6eI5LfIgMMm6XeZDqDaw59mKGruS4haXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886151; c=relaxed/simple;
	bh=/KBehcOkQXHDLRfsTeU4RhnSx3MBciIavYS4DUgCdFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WFFmreno5uVCGh3Z7I7rwWUDjDgwfw08XclTeWRsGOe+f9E5/hreWpMLXQeNpiONum68lykwVL4oM49hSfXEfpdNfn831NwmwtSmWIV1qUx/oa4/A5fQYtH7oPP4hL2WZMRh8AsHi60+OySOfUIhwTR0dF0GH7zipAtAVtyAHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M84mlTVS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BD6C4CEED;
	Fri, 22 Aug 2025 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755886150;
	bh=/KBehcOkQXHDLRfsTeU4RhnSx3MBciIavYS4DUgCdFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M84mlTVSHJL9PpRAPTCrEoz6cimQc+Q8j8Xt8tOAEJcw24XKTwe7/h129KFpxNdrL
	 n6iAK7sMGMQ0QidfaTEK7Ek33iO5kBEEBNuXfdoaBG8CceMQ46KQhX6KqjUsnge+pj
	 WOSH88zo7WFoC1ZC0vlyNmjcBYJg2lP1iB6Ph3ELzhkOM1cSrHDBYB4vl6VERlrSEx
	 Zli4Mn4QTVj5Ge0VwqvnYH8ml/qbUKFFLyrxdLt5VkawwGQ6wHA7f8anbc8oBwVFWm
	 sEYkqGac+PG+NLhkVr0rwiyiW19GPCWy2hCLgkpf06hyz6emgjZa1dOcYyB205yxic
	 e1hCkf5hhveMQ==
From: SeongJae Park <sj@kernel.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove is_migrate_highatomic()
Date: Fri, 22 Aug 2025 11:09:06 -0700
Message-Id: <20250822180906.48005-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821-is-migrate-highatomic-v1-1-ddb6e5d7c566@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 13:29:47 +0000 Brendan Jackman <jackmanb@google.com> wrote:

> There are 3 potential reasons for is_migrate_*() helpers:
> 
> 1. They represent higher-level attributes of migratetypes, like
>    is_migrate_movable()
> 
> 2. They are ifdef'd, like is_migrate_isolate().
> 
> 3. For consistency with an is_migrate_*_page() helper, also like
>    is_migrate_isolate().
> 
> It looks like is_migrate_highatomic() was for case 3, but that was
> removed in commit e0932b6c1f94 ("mm: page_alloc: consolidate free page
> accounting").
> 
> So remove the indirection and go back to a simple comparison.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

