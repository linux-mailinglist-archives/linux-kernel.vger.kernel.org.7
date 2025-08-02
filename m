Return-Path: <linux-kernel+bounces-754186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84230B18F7E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8596A7AD570
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 16:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5E825229C;
	Sat,  2 Aug 2025 16:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBD7JYsC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C96423C8A1;
	Sat,  2 Aug 2025 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754153701; cv=none; b=UuEbpblf9LXjorW2MYuWW23GZXuRk6aQlUMPLo36bxvO6pNKbor2h25Ro9laPs/FHJrtx/vJnMpsFlR2XJXz46uf8/kZBs2N2K59DcU2OKqgPgTHU6wZ/HTROh7913PaoWFKTkE6z4x47iaSY/0Dql7QoC0o0hd6bQpmm4g1XOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754153701; c=relaxed/simple;
	bh=SEc7rHR48cU8PgjS4PgPLzAVHNEQ00U8BuoFzkBvLBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGAnlXSkt/yYQbFA5abFM58gdDqOdSAUJTyx+75LLEmGjGbvWcLiKUTHCDD2WDRquMyHqewJQ/TpxTomYfNKcuixsGf369nb5wvy7DaBn2NI+WoXcGXc1U1p1ngeSbyXzcRPXcKRHZrq9f5XOz2jiQx82hfKAp41CF2ygtyJDZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBD7JYsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47B0C4CEEF;
	Sat,  2 Aug 2025 16:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754153701;
	bh=SEc7rHR48cU8PgjS4PgPLzAVHNEQ00U8BuoFzkBvLBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBD7JYsCVJcYeeLVVTvcguO5RB332MYn1vfjnyUcdMjIS3ssYYNeIgIFuPla+rRxA
	 S3gIFA9AVENjcAsIZaajoAfLIw0xEtP5uFNAAo9TB5MO24NGzBPBTZJhc6TCHxhLqs
	 AgdRp3NPsi6sjDFbuwtvDIVFw3vkxVLT8uOtRu2etrsX8eifX2ceegDy/L9zIHAmm5
	 RxoHD90DySWrNxg1ON2U437wXmpMgfiqCr73kAjG7hqa9r7ouQ4zWM0YoipEqgjZRq
	 dINMxlRkNRHyChkHv+hkGgmnwrjsVhKlJAkHrDWLqFosSHoH3FHpsalL4cq3DeUnut
	 7ApJNGeb3UzIw==
From: SeongJae Park <sj@kernel.org>
To: Yueyang Pan <pyyjason@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v4 2/2] mm/damon/vaddr: support stat-purpose DAMOS filters
Date: Sat,  2 Aug 2025 09:54:58 -0700
Message-Id: <20250802165458.7179-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <264a4b5ea202fd73c01b349c9694d8bf9978c441.1754135312.git.pyyjason@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat,  2 Aug 2025 11:52:46 +0000 Yueyang Pan <pyyjason@gmail.com> wrote:

> This patch extends DAMOS_STAT handling of the DAMON operations
> sets for virtual address spaces for ops-level DAMOS filters.
> It leverages the walk_page_range to walk the page table and gets
> the folio from page table. The last folio scanned is stored in
> damos->last_applied to prevent double counting.
> 
> Signed-off-by: Yueyang Pan <pyyjason@gmail.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

