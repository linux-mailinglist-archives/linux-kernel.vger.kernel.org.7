Return-Path: <linux-kernel+bounces-878444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EA2C209BC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6A718933A8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C569726E6F6;
	Thu, 30 Oct 2025 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBk6qmF8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B025235053;
	Thu, 30 Oct 2025 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834749; cv=none; b=mPzrCC0zNJfO3PyQ8fHaV5kqS3JkNmpqdryf5tXHYxgAjQZWp79o2wTTYUFTPcVIP7LgjEPp9YLOMbpEsu0yAFtcsgfKMK9+aSS1x7cDJlS11s4wlHGG1MlenPu03LZakFZB+k9i0Lgcxe9MuRSFp+CBxu5waKKs7ELIqS4teV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834749; c=relaxed/simple;
	bh=cjreltSEJSqHTk+3GCLPf/cZs/IRqnpfQiN9hHzpvDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oukRfpx39L+43FkmIsJrwivC85eD30v19FbYkNhtWJDm1Gr9n35l+2CUHYsZ6DfS1s2ih6PMPaXCOGBosMEIOKAHlSmzSRZLmeGo4lUm75w71rsPREfP5tu6Kzk+JNwy0Ee1XkxoOIv62+fQVq1+A56kTHQZUAHLG6CEqU8Uwbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBk6qmF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9619EC4CEF1;
	Thu, 30 Oct 2025 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761834748;
	bh=cjreltSEJSqHTk+3GCLPf/cZs/IRqnpfQiN9hHzpvDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NBk6qmF8iZEJg+NsOK3eEgkgxOcDwOqRxoIuUt0GzXQu1/XQUkUgVlzrn0hLrfoVu
	 mckAZ9s+cFfGxaxbJ1bAAJBgmKiTbRmeuRSdB8wXTBAUc7cX3LdSykrs5VnIi/r+BM
	 FrQr7oyDZ4OyL/iK8+vVgQ7h4zfAy9wttqu7be95XZDNZUPamRs7WexCOn7/3+zH6h
	 ox/b2s3MgaIsSOspUPFFWxHiFrUadpWuVyNDQo8Zd4eGAQOg1f9KSmNmhWnRdk5Foz
	 VDuH2fAjZMm3ThAZuOBQh5SVbFprlYZMpWL6SUAtfQ35pBnkn6pkADff1QwuQV5imE
	 2uMirtlf9M7Rg==
From: SeongJae Park <sj@kernel.org>
To: Quanmin Yan <yanquanmin1@huawei.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [PATCH v2 2/2] mm/damon/sysfs: change next_update_jiffies to a global variable
Date: Thu, 30 Oct 2025 07:32:20 -0700
Message-ID: <20251030143221.46859-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251030020746.967174-3-yanquanmin1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 30 Oct 2025 10:07:46 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:

> In DAMON’s damon_sysfs_repeat_call_fn(), time_before() is used to compare
> the current jiffies with next_update_jiffies to determine whether to
> update the sysfs files at this moment.
> 
> On 32-bit systems, the kernel initializes jiffies to "-5 minutes" to make
> jiffies wrap bugs appear earlier. However, this causes time_before() in
> damon_sysfs_repeat_call_fn() to unexpectedly return true during the first
> 5 minutes after boot on 32-bit systems (see [1] for more explanation,
> which fixes another jiffies-related issue before). As a result, DAMON
> does not update sysfs files during that period.
> 
> There is also an issue unrelated to the system’s word size[2]: if the
> user stops DAMON just after next_update_jiffies is updated and restarts
> it after 'refresh_ms' or a longer delay, next_update_jiffies will retain
> an older value, causing time_before() to return false and the update to
> happen earlier than expected.
> 
> Fix these issues by making next_update_jiffies a global variable and
> initializing it each time DAMON is started.
> 
> [1] https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com
> [2] https://lore.kernel.org/all/20251029013038.66625-1-sj@kernel.org/

Thank you for finding and fixing these!

> 
> Fixes: d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file internal work")
> Suggested-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

