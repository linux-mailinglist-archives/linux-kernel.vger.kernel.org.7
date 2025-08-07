Return-Path: <linux-kernel+bounces-759404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2171DB1DD24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFF5584F7D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 18:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652361FBE80;
	Thu,  7 Aug 2025 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUG4nBJa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C817F18BBB9
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591558; cv=none; b=Nue/xXsT3CO5nz410f0I4+rl2uSzKuiH4EZL4BKS6P490eXSz6pHN5p29sv8q5NW+zjCZfpf0dT0HfDT3JOssONN6GWNxHI+gGK9lRtxMfAy1C7HRhiLM484CpLtz1YvZwqC3xAh4p/LBi+uhTLee+xCQ4csbJM4ekwpZJ84xLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591558; c=relaxed/simple;
	bh=xWH0pR9x7HbcaeApYBNbCReET9nnVMFg2R4I7UwyZsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gB36ePKhnG/3779Z51/V6QxI+Vid9ZjHzK5KLu6MxHPLJq141OJhXpoEuqxj1+PwLAYGr/n/T9nhvldv3MiQVVCGdOMpdHaVtKyopZo8Yg7uT4s2RkSj0JGsBA86uBmV/79nSyKUiUv/sqS5oTDduIi45zn1nhXBMceK6Ki8/1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUG4nBJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F38DC4CEEB;
	Thu,  7 Aug 2025 18:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754591555;
	bh=xWH0pR9x7HbcaeApYBNbCReET9nnVMFg2R4I7UwyZsY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kUG4nBJanX6vYcUxO8k4uEwTeZzlAxplWE4XTEJ8qQRlZMcYw+wtUXkJUlooRf1ij
	 ytri5u9Ex1UKD+Jo2hwScc+EvNY0uHMimsorzZejGPfXlEysMx/k9crYtIQVVhV4NM
	 ggVkipbRQfXmeAG0rIsV3s6z7148o1CZRdiza6baaTqzY2xEodOh0wkGJejKUJy/9r
	 daz40ONuhLg6KFb9CSyHsRBU8i5jbWXIrWWOg6nzYvgFHviRdXeTp5gUKhnOk8+3JG
	 +1K8cofcYSowX4+Exx/lj6nnJSXdvZGEa9oGqggrwOkKcL2H5lqRv0yPmlDSwNOms4
	 8fa1XYvZccBgg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>
Subject: Re: [PATCH] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Thu,  7 Aug 2025 11:32:33 -0700
Message-Id: <20250807183233.2055-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807181616.1895-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu,  7 Aug 2025 11:16:16 -0700 SeongJae Park <sj@kernel.org> wrote:

> Tests
> -----
> 
> I tested this patch using a simple self-written microbenchmark that is
> available at GitHub[1].  You can reproduce the test I did by executing
> run_tests.sh of the repo on your system.  Note that the repo's
> documentation is not good as of this writing, so you may need to read
> and use the code.

The test script assumes the kernel has save_incompressible_pages zswap
parameter, which dropped on this version of this patch.  To run the test script
as is, you may need to build your test kernel with a patch that introduces the
parameter back, to use the test script as is.  An example of such patch is
available[1] at my GitHub tree.

[1] https://github.com/sjp38/linux/commit/3a8122e9cb947c13878f5fab1cd2d106be3f3d2f


Thanks,
SJ

[...]

