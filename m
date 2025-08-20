Return-Path: <linux-kernel+bounces-778634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E36B2E84B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707351CC2223
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC162D4816;
	Wed, 20 Aug 2025 22:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBjyg0Qa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1725C2652A4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 22:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730023; cv=none; b=cnhDYW+hIxDy/JQ5pwBXKUzBhbnDKbuQazqmIOCl9XYEnd7n76MyINxExzkTd1bYwGQpRDydhD5Z2n1vm0iMK4W0XeI4+59NXS04xUs4NrND1WtHQskVDliXVLsAfpKzwNvQTC8ZCaA+k6T9d1vKYNkgRd2WuX5jLCM6GvbgcDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730023; c=relaxed/simple;
	bh=JYAqFozgqm8DSkeK9/y9X/fQKyqyYyCZdbwnzw/DShQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t5fwv1GjiGyT4cxnXpMo5SwiG3yitEUSFwIzLeeN0Aw3zxGO1mUW6WLQIFhP3ar5WXYYTcItxkMprnO3rehy6+VJ+ZLIsBGR/iVcTATFbfCUfM9kdTgl4Pmm5xfIt+PjDD3bGC85JCj5v1B1U80yxl9xoFkpgMiYROzyAiTlAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBjyg0Qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646A5C4CEE7;
	Wed, 20 Aug 2025 22:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755730022;
	bh=JYAqFozgqm8DSkeK9/y9X/fQKyqyYyCZdbwnzw/DShQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBjyg0QaMLODFKrWIxK8jt4BilAkTDYlHHT2ZCphU/ZRw6tO7Yl3yv5aH9/0NfIj7
	 HFIgjXEq10jntLjReJ8P7mZalS1N8xQM+zEvzGDPN+RptWiAOlYjJq4cD7Tg39rrse
	 vdDNj50iY6jJak5T/htNp9lU0xRsP12IwDYKgv2r5rsgRBEbMm8P2siQgy6zE+8Row
	 C4O8+8qJ7H1E+ITBF2r0jMwtyBWp8DaZrLiLVKHqWgkK63I+hBv6VYCcGOB6Y+Ixjm
	 HSeoLr79uYsJPhAuDV+xv0zlQMIvMmJTV5cMz17ACT8Pk5NIG/flgkZSqu5J/1QjGh
	 mHMjBWr4lPZtg==
From: SeongJae Park <sj@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	chengming.zhou@linux.dev,
	herbert@gondor.apana.org.au,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zswap: reduce the size of the compression buffer to a single page
Date: Wed, 20 Aug 2025 15:46:59 -0700
Message-Id: <20250820224659.88528-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250820181547.3794167-1-nphamcs@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 Aug 2025 11:15:47 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> Reduce the compression buffer size from 2 * PAGE_SIZE to only one page,
> as the compression output (in the success case) should not exceed the
> length of the input.
> 
> In the past, Chengming tried to reduce the compression buffer size, but
> ran into issues with the LZO algorithm (see [2]). Herbert Xu reported
> that the issue has been fixed (see [3]). Now we should have the
> guarantee that compressors' output should not exceed one page in the
> success case, and the algorithm will just report failure otherwise.
> 
> With this patch, we save one page per cpu (per compression algorithm).
> 
> [1]: https://lore.kernel.org/linux-mm/20231213-zswap-dstmem-v4-1-f228b059dd89@bytedance.com/

This is not mentioned anywhere.  Probably you added this as a reference for the
past work from Chengming?

> [2]: https://lore.kernel.org/lkml/0000000000000b05cd060d6b5511@google.com/
> [3]: https://lore.kernel.org/linux-mm/aKUmyl5gUFCdXGn-@gondor.apana.org.au/
> 
> Co-developed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: SeongJae Park <sj@kernel.org>

[...]


Thanks,
SJ

