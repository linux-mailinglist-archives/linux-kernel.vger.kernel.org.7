Return-Path: <linux-kernel+bounces-838041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C65BAE4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BFF4320043
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D886D2264AB;
	Tue, 30 Sep 2025 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmccLfyO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4029D34BA42
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759256488; cv=none; b=Ai9axTMyzEQvV/BUegh5x+ZkPXFLcqw9Nv9ngVFhyiMTmjxBICDVa/QKBhqSXiEoNW/AXZErr/xJhenlPstIvEZqZPsOOCFqvsJrMneeIQ0A/M8k442kdCgOTcKDmxGovQJF/D7p6Q07VGzJJumnf127tfgogWDqt6BxVt9gy+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759256488; c=relaxed/simple;
	bh=kzIru/P5sR9WKJSccU5qPncNb7rq1RbhEqJ6aCJhWG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=huxQiSjF3OXTAAeQkrORfFdU6fAr8UhFClrBqpf+jBbwrc7DOOatU/DZRChXFtNN9C4hrxi4znqfj6LjzweJg6+kbFfDgUfTUy2NPGHypav7j0FmH74IUyHwRjqhW3wgNj2AdAqRpZnuXNjnu1xclbZQmvioQXJOZPoJTgte3xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmccLfyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFA1C4CEF0;
	Tue, 30 Sep 2025 18:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759256487;
	bh=kzIru/P5sR9WKJSccU5qPncNb7rq1RbhEqJ6aCJhWG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmccLfyOjnzmP6CGeSAGf3gKD5k1PUKdiwlEWP5nftxk0+LQvNDENjJfXztbHpqqh
	 wSp4bF5DU4vYZcOTtjWTAGGf7oruLiMCFh/2GwhNlNhH1ZJAZ947cfgEr20s5Rdnmd
	 Dz651hgXd2jcMyJYNlKkUtAXdJU9cn1DgCi8/Uj4NZMkjYcjSO82HMiGUArYO0Vcqm
	 nDbVw2fiyU/t60r4EcjllCuuK/E8y9Lg9c543XiD+dUKTOblOpOjplriHL/w2GTuTa
	 YmF24Lg6pBxxajBvg+aRIpwu4ffiQQwu5ZNzmSUC0iEiGNDlGkWi97ZXFB2qATzBlC
	 gtuarc8qI8MzQ==
From: SeongJae Park <sj@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/ptdump: Replace READ_ONCE() with standard page table accessors
Date: Tue, 30 Sep 2025 11:21:25 -0700
Message-Id: <20250930182125.45150-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250930025246.1143340-1-anshuman.khandual@arm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Sep 2025 03:52:46 +0100 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> Replace READ_ONCE() with standard page table accessors i.e pxdp_get() which
> anyways default into READ_ONCE() in cases where platform does not override.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

