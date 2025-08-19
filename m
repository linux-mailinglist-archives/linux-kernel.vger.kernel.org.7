Return-Path: <linux-kernel+bounces-774935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4015CB2B95C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B219B1BA41B7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6630F26656D;
	Tue, 19 Aug 2025 06:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhhGe7P6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584A2652A4;
	Tue, 19 Aug 2025 06:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584811; cv=none; b=BU+yQwWbT6CoZc4oFzI5L4szhLnqlnlcAnAcTQylz2ySIkIpY5lEa3JvoqL+hc0NS+OeHNuEaAygPxIEa9+Nw9VGyGad/gHWFxbA/gVtAA6mAzwvE5kXABN4z+i2qb30EJIrdz0lEJHkS00tlyP/gxb8jFGt74lFVnBYXAF1Hgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584811; c=relaxed/simple;
	bh=kicNrrCw9YqQlyRsdO1xeCQwRKp96LX5HA2F/sl3g8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4LUgKPh1xAl3Jd0t1fb/5qal+PQdfZPHeA6cIp2sdDNTEe06/3flzI7GLa0Ubp/MndJgqEAz4+XWPgyqr7E1EskQo6STT6uyc6wfx6kkRPNySq2qh0gmZO71reMg30ITA1pDgzhKU3ONhHkq16kFZYTK/jzeRWkw6XxN0bBcE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhhGe7P6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA0BC113CF;
	Tue, 19 Aug 2025 06:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755584811;
	bh=kicNrrCw9YqQlyRsdO1xeCQwRKp96LX5HA2F/sl3g8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DhhGe7P6CWp+0SNmU1X/6+oYjXC6tOXm8S2Xmzt59FjlOmo9SG/JlIZW1/wzy7BGs
	 L1XVEN4wMOEp+mwsyAJ1ljT0DqSiSKdubOSsq2zn4RSIjWIAHdMN4mRj8et3f8bPc/
	 ZHaHA0epbie4yaRa7TVPJ/HMKYbAYn+Z2vGtNGZEI3jHSzmS04ldpNkyafgCFng6dG
	 ko6fcqpCk5Qwghjv64AmrD4yZCTTnXf/v2TCHG1FPkxWrlHHMaQtJc3E00C0Roxzc/
	 cb/kXlN/CQqGYAtAxAW626r9nKnBABbzx8OWd078uLXddurSOJgH7wfdHxovYG7pS6
	 MPQobp+baz0/Q==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Quanmin Yan <yanquanmin1@huawei.com>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: Re: [RFC PATCH -next 04/16] mm/damon/paddr: support addr_unit for DAMOS_LRU_[DE]PRIO
Date: Mon, 18 Aug 2025 23:26:49 -0700
Message-Id: <20250819062649.40079-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250819061952.39429-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 23:19:52 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Quanmin,
> 
> On Wed, 13 Aug 2025 13:06:54 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
> 
> > From: SeongJae Park <sj@kernel.org>
> > 
> > Add support of addr_unit for DAMOS_LRU_PRIO and DAMOS_LRU_DEPRIO action
> > handling from the DAMOS operation implementation for the physical
> > address space.
> 
> As I suggested on another reply[1], please squash attaching patch to this one
> when you post next version of this series.
> 
> [1] https://lore.kernel.org/0001-mm-damon-paddr-set-DAMOS_PAGEOUT-stat-in-core-addres.patch

Sorry for the above wrong link.  Plese use
https://lore.kernel.org/20250813170806.6251-1-sj@kernel.org instead.

Thanks,
SJ

[...]

