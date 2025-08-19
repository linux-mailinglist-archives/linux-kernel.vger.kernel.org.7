Return-Path: <linux-kernel+bounces-775492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D837B2BFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6585C1642AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC11322A1A;
	Tue, 19 Aug 2025 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7sDmmIv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC80311941
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755601571; cv=none; b=Of7Iptr5YhXWftTTwlMIfZK5YoFHDTghQBENZRcLrbf3Ok7HE1a9FHaWj1jwhDGq+oRcwcjhJXVsMBdC628ybHvhdAJVXWh35YOsIBXfQy4vWejmoYv4nXKuhJ8fBgMZMHxvtf9gUQqBo6eM4hETCpf34rgIEtrPz8olsFokfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755601571; c=relaxed/simple;
	bh=CdX8yhhE2/AY6zrdYFD+LDAXjVc4FSrHlpLJhlpx7ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utEce6TlgBvMrFJsrIFmZ7FqR6n1xYpV0ldNXeB7yeak6ai6OpwnEnqV6U5gHyPy8CvJLq7oRA1W7srB78Yn/J32YP9b2aNzKT4wnqj3WxJDnzwTd3Fp6OUrSnl0RSYlJrQ121alGA0XYvj3MFL+FZb8UHV/oEBcVAhvwpLqBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7sDmmIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B60C4CEF1;
	Tue, 19 Aug 2025 11:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755601571;
	bh=CdX8yhhE2/AY6zrdYFD+LDAXjVc4FSrHlpLJhlpx7ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f7sDmmIvnr6ftMItWPAcWziv/RLaGmLevP2jFHNojr8JodeyItrL5yMnA8xXhfaEv
	 0PPtRFzkC8SIunSJuFnwxFtJz7WNGKXzKwzqBHpJ9tTm9PUr0nsa2tpfReN87eb4Qa
	 Vqxo+vbmv7qLiqU7SO6mpECqw5mXYJD26Ug+nFdHs3mK8IC1mwaJf3gy8O8pjfGzvY
	 0trDqVvpI7wGg8XyfUSnkN2WjzAdeV9t3hxrCl3TIj0+5mvQBTR6hCewxhkkOT7MmF
	 L9u6czq2OB2WqF5GHi+ALlamPGIuFakR5rw3qFfNb+KpfaBX4kFxCHevqBA/8UFqhT
	 pTmvAY5qA+9Lw==
From: Christian Brauner <brauner@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com
Subject: Re: [PATCH 1/1] signal: Fix memory leak for PIDFD_SELF* sentinels
Date: Tue, 19 Aug 2025 13:06:04 +0200
Message-ID: <20250819-geopolitisch-artikel-e64bc21337d6@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818134310.12273-1-adrianhuang0701@gmail.com>
References: <20250818134310.12273-1-adrianhuang0701@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=brauner@kernel.org; h=from:subject:message-id; bh=CdX8yhhE2/AY6zrdYFD+LDAXjVc4FSrHlpLJhlpx7ZE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQsiZrH1NnVUfVpevrVL58yppps8nIJCN4UGx7IxbP1g IOJYOamjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn8mcPI8HPpPSXJgn3LtpxZ UH66Ydf9b1H9X0zi9YVU3j56/ngx72RGhlvBVz7x/y5Kzp4fZlPyb8/Vyy+4t+Rp9UxkvCqmb/x RkwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 18 Aug 2025 21:43:10 +0800, Adrian Huang (Lenovo) wrote:
> Commit f08d0c3a7111 ("pidfd: add PIDFD_SELF* sentinels to refer to own
> thread/process") introduced a leak by acquiring a pid reference through
> get_task_pid(), which increments pid->count but never drops it with
> put_pid().
> 
> As a result, kmemleak reports unreferenced pid objects after running
> tools/testing/selftests/pidfd/pidfd_test, for example:
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] signal: Fix memory leak for PIDFD_SELF* sentinels
      https://git.kernel.org/vfs/vfs/c/4df38f680278

