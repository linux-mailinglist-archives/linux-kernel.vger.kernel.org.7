Return-Path: <linux-kernel+bounces-844709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6850BBC28EC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 578604F2F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F34228CBC;
	Tue,  7 Oct 2025 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEhjVh0Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0C515B971
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759866799; cv=none; b=jQzgJJ3rVuCNrcxIwnr0fISrMeF7Iz28mfU6EtK/w7MS8Ct/DtAGWrTHliUvIovk+PDEij5r0ZaniOIVKKY1anR+ce/affzpjeWj3aAKe6lnq4o3nyMCLGNt0jcRA6VS6WQqUtwEtPBX56LdfiYSr1XkCi+Pn9XJt+SG+9KwjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759866799; c=relaxed/simple;
	bh=TlsTiDVO/Guhxne2Ydgp1Bn723sJW0361/Ifv3FYjss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jsFeuEDzxOGVuzPUJcaReDp24fo/7CzgPvLFHLvFfknY17F+4YMRO/uZSMeurLXg6LXN2BwfBzCGs/h7gv7orR3oAmugJSUc4AXaCGRA3edA7S+SXjSphe8cd+n9CSmoZk2hSuX/E3SVnSa1nF0J8sWUh1fN8Rzk6WsF3qVPo+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEhjVh0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4331DC4CEF1;
	Tue,  7 Oct 2025 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759866797;
	bh=TlsTiDVO/Guhxne2Ydgp1Bn723sJW0361/Ifv3FYjss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cEhjVh0YsbpLOi8WHiyuxtBPjRZMoSs7xhsLwEzgcVJOxtgto2NDAtauq7manHzU4
	 8/QMXrRPlg5vkVy43RD4dhqHRiSRMzCSLCEDhz4S3u32kb73sT7nd4Eb/T+ASgQJ0a
	 WhvXokVvXBiGfC82rsKidkxXK9L34WxcoJ43o0wWCHtUKss9va2mNR3JKlv+sidtzQ
	 05sb8QH8oRUxCgOffc5Tzh4E5Udszp8VUOgftw5ccrwz3nRFKNHbL8YoipiFCnhSCs
	 HDeIyHXjB1eoYEM+ZG+lVdp/k58Iadhz70nmj7ubBO9qGTMEmcfnvY3Hp0asehlAsg
	 ub6XD9tx/C3PQ==
From: SeongJae Park <sj@kernel.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] mm: skip folio_activate() for mlocked folios
Date: Tue,  7 Oct 2025 12:53:13 -0700
Message-Id: <20251007195313.7336-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <aOPDRmk2Zd20qxfk@shell.ilvokhin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 6 Oct 2025 13:25:26 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:

> __mlock_folio() does not move folio to unevicable LRU, when
> folio_activate() removes folio from LRU.

A trivial opinion.  So the user-visible issue is the incorrect meminfo, right?

I read your changelog below saying you changed this message from v1 to frame on
unevictable LRU rather than stat accounting, and I think that's nice to
understand the detail.  But I think further describing the resulting
user-visible issue can be helpful at better understanding the motivation of
this nice patch.

> 
> To prevent this case also check for folio_test_mlocked() in
> folio_mark_accessed(). If folio is not yet marked as unevictable, but
> already marked as mlocked, then skip folio_activate() call to allow
> __mlock_folio() to make all necessary updates. It should be safe to skip
> folio_activate() here, because mlocked folio should end up in
> unevictable LRU eventually anyway.
> 
> To observe the problem mmap() and mlock() big file and check Unevictable
> and Mlocked values from /proc/meminfo. On freshly booted system without
> any other mlocked memory we expect them to match or be quite close.
> 
> See below for more detailed reproduction steps. Source code of stat.c is
> available at [1].
> 
>   $ head -c 8G < /dev/urandom > /tmp/random.bin
> 
>   $ cc -pedantic -Wall -std=c99 stat.c -O3 -o /tmp/stat
>   $ /tmp/stat
>   Unevictable:     8389668 kB
>   Mlocked:         8389700 kB
> 
>   Need to run binary twice. Problem does not reproduce on the first run,
>   but always reproduces on the second run.
> 
>   $ /tmp/stat
>   Unevictable:     5374676 kB
>   Mlocked:         8389332 kB
> 
> [1]: https://gist.github.com/ilvokhin/e50c3d2ff5d9f70dcbb378c6695386dd
> 
> Co-developed-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Acked-by: Usama Arif <usamaarif642@gmail.com>

Because this is a fix of a user-visible issue, I'm wondering if this deserves
Fixes: and Cc: stable@.

Anyway my comments are only trivial ones, and I think the change is good.

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
> Changes in v2:
>   - Rephrase commit message: frame it in terms of unevicable LRU, not stat
>     accounting.

Yet another trivial and personal opinion.  Adding a link to the previous
version could be helpful for reviewers like me.

Thanks,
SJ

[...]

