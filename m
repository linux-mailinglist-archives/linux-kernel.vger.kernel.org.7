Return-Path: <linux-kernel+bounces-825174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A6B8B2B7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F9E31C2799B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2F9271470;
	Fri, 19 Sep 2025 20:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wchAFv1v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AA226D02
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312406; cv=none; b=G+g+OYakXMsPeZ1Tm2qvVbuU9d/h1h1Di6117IahAB+LPQ71oMTJqdnkC/nayxKBOtAKmWp5ppPNRW25MMGOA3Fhv/SnkZSN3D1eQP4FYVE4SFzdAItDIAnngJwJlTegwIzwkbCL0ffzJpBV3mhUeb/IqDd8Bd+ns9pHhvKn8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312406; c=relaxed/simple;
	bh=oU6IPcrhdCatbty9M1JygZaaWUYhUxIhORgdHeVOnGI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=epazwwNbDufdzcPigp9MfGPz/x9WSTo9SLjioSMlFbMy009l6Hpob2E58cEqC7M6ifRE7Oh17JVon2msxw2q8gsA5fyuen/Hcg6TxfJ4Lzm8/xcza2m2mMIP3Loir5XeA2YD/+WPhqXPfEaRATWGNZ2JJy8qM/oKa7OxC1mOCeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wchAFv1v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FE7C4CEF0;
	Fri, 19 Sep 2025 20:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758312405;
	bh=oU6IPcrhdCatbty9M1JygZaaWUYhUxIhORgdHeVOnGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=wchAFv1vt+vhyzhItwupGq5aAmioJFZOe/0Zmxv1rki1kUWHXg5byUVLtajCkTXqV
	 FFhvI35l7xkd5V0xk5e922SIgSo1jHmwwuZhp3BL9Kong4YYq5baiutPIMUcptEuri
	 KJMdlDmGad89OkoV8v1l5RhnXnTm0OAki1Uh29ac=
Date: Fri, 19 Sep 2025 13:06:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>, Kiryl
 Shutsemau <kirill@shutemov.name>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Brendan Jackman <jackmanb@google.com>, David
 Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH 0/4] mm/page_alloc: Batch callers of free_pcppages_bulk
Message-Id: <20250919130644.f3a4afdf0c2e51bbec59b6e0@linux-foundation.org>
In-Reply-To: <20250919195223.1560636-1-joshua.hahnjy@gmail.com>
References: <20250919195223.1560636-1-joshua.hahnjy@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Sep 2025 12:52:18 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> While testing workloads with high sustained memory pressure on large machines
> (1TB memory, 316 CPUs), we saw an unexpectedly high number of softlockups.
> Further investigation showed that the lock in free_pcppages_bulk was being held
> for a long time, even being held while 2k+ pages were being freed [1].

What problems are caused by this, apart from a warning which can
presumably be suppressed in some fashion?

> This causes starvation in other processes for both the pcp and zone locks,
> which can lead to softlockups that cause the system to stall [2].

[2] doesn't describe such stalls.

>
> ...
>
> In our fleet, we have seen that performing batched lock freeing has led to
> significantly lower rates of softlockups, while incurring relatively small
> regressions (relative to the workload and relative to the variation).

"our" == Meta?



