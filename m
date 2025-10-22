Return-Path: <linux-kernel+bounces-863974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DE1BF9A23
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 03:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AC804EE95F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 01:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE037081F;
	Wed, 22 Oct 2025 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RI29hPpj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791BB3F9D2
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761097544; cv=none; b=jhc3phvVl7DIMmKuV85OOVx4uJ/s2alMlbdbfTptWuqYsSpz/5+jj/xCjORHIcnYGy477V7kXkOwlVhlmSls/z6KKadYQppztIsn6b1xWk5TzVUEDDdxlrGxAouABjn3btFLRNq6DwPKbQ3FarejXWQWOyIfh0WrFB7UBk7sgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761097544; c=relaxed/simple;
	bh=SAtkUrqxtCKiDUuNntgintJ8H5JSzvaeVFYUddvJfQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DRSBqJC//D9CkFW4dG4d3Kg2hiUev5fDZHN8YLea9ePCZZLjWV81ywiF0t4954uMXmqw4MvTsWlGapNa05cnZ8QvsT2yQtNJRikcDkinft5UwPqMDP66VURFqhdPN94+vhhquV29pGbWECPZRWbH6V/8+22qTqakAXAKcsjLIvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RI29hPpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B3DC4CEF1;
	Wed, 22 Oct 2025 01:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761097544;
	bh=SAtkUrqxtCKiDUuNntgintJ8H5JSzvaeVFYUddvJfQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RI29hPpjC0d1KDuGdbCKvv1BRK7tOfUFuQVXRLB9v3dgIEdUa2nv+3s94h3jC1UoB
	 17YUxlsLk/SOAO540qQAwlau6ihr4+PGC5kFNqUVoWtoFhprmBmb7ZYXhyCMzcF0Ch
	 wYzabopi5+++4H/29Sf543XzUN/4e9YUXWOCXOQaNHTzzT9fbz5yoE9iIwN4qSLWOt
	 RHgzCgxa8joXmHghlnZIHwRI/HvXj8e9qadriGhrGwpWW1MHkyfdmWZ3ZRIDd4rK4i
	 1Ogq9H++HyftPkl96UsWRtCD8QUaJfbmRy09cgM4Rqk3uh/u/JGKVLpTp5cFg5zm6V
	 zxSfIsdQgWCfw==
From: SeongJae Park <sj@kernel.org>
To: William Kucharski <william.kucharski@oracle.com>
Cc: SeongJae Park <sj@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Paul Mundt <lethal@linux-sh.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove reference to destructor in comment in calculate_sizes()
Date: Tue, 21 Oct 2025 18:45:40 -0700
Message-ID: <20251022014540.129011-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251021110004.2209008-1-william.kucharski@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 21 Oct 2025 05:00:04 -0600 William Kucharski <william.kucharski@oracle.com> wrote:

> The commit that removed support for destructors from kmem_cache_alloc()
> never removed the comment regarding destructors in the explanation
> of the possible relocation of the free pointer in calculate_sizes().
> 
> Fixes: 20c2df83d25c ("mm: Remove slab destructors from kmem_cache_create().")
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

