Return-Path: <linux-kernel+bounces-752543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F0FB176F1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57EEB62740B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898322472AC;
	Thu, 31 Jul 2025 20:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqFjGvTW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AE6239E91
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992643; cv=none; b=jawuBaEju4tgiM8h9ydcS/upC/Ho8l/XF1T0HV5W8NCV66WAv1zYgXkyKaq4A37DbtNOFPduWm3BuwmI11usSbDpeVAykcSJzCfwCRtj3diSUOhyJqJJQiOEGbI+19hnLhXIquIF9M/39cHlYuDZktesx/B1wTXLOvWmh37cstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992643; c=relaxed/simple;
	bh=9U2uUlJsgZQb8PnOGpghq8IKlvSCiqX1yAsveCq9xjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJ/M92cwAbdLtZIb2T7lXxu7KxrULd4iKaESEsTwz0YzH2IktNwfT9Q4REkie1If924csxfOGFORKnXBDYQggieWZPR+K2o8AaK6m2p22QaXKQuyeA8p08TpIL6rnOVkC3+P1v2CHdQnEhekyd7C8xjAUPQus2jnoDezelacVnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqFjGvTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32469C4CEEF;
	Thu, 31 Jul 2025 20:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753992642;
	bh=9U2uUlJsgZQb8PnOGpghq8IKlvSCiqX1yAsveCq9xjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FqFjGvTWoOpjS9KvsDirQk907SkyQnBTWfn3nbr+zeVZ7RmjjK+zt51CCLLOarUZR
	 QdTVu2kVsivyUJw/4Ec/Bv9yU+QPSSy77l9rnv///1HzWpe/bIVZ+DewNCYeP75Yfy
	 lu6MLpqEpmNuPnVGXO32n0cYmY5lPzTs1sHkda3sbquTFVz6Cao5RjKJIZnzU64QzD
	 oDcX4vo8Vjxg3Q/R2C3vp5jj08gQi3tbYlGEJ3ZHksTIOsb6endBQ/IjSPrwIPiOHp
	 gz3nHv7R1XhaXCqCt1clofxPVCkd6R+9iCE0kj6r32n4Ktjwlrb9BsAWgS9HZzC2v1
	 0PSSWb6D1MHVQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: pr-tracker-bot@kernel.org,
	torvalds@linux-foundation.org
Cc: airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	simona@ffwll.ch,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [git pull] drm for 6.17-rc1
Date: Thu, 31 Jul 2025 22:09:52 +0200
Message-ID: <20250731200952.307037-1-ojeda@kernel.org>
In-Reply-To: <175393147528.2597948.6255690700279027909.pr-tracker-bot@kernel.org>
References: <175393147528.2597948.6255690700279027909.pr-tracker-bot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 31 Jul 2025 03:11:15 +0000 pr-tracker-bot@kernel.org wrote:
>
> The pull request you sent on Wed, 30 Jul 2025 07:05:51 +1000:
>
> > https://gitlab.freedesktop.org/drm/kernel.git tags/drm-next-2025-07-30
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/260f6f4fda93c8485c8037865c941b42b9cba5d2

I know you are particularly busy this merge window, but if this diff
could be applied between merges at some point, it would be nice.

I put it below in the form of a patch with similar wording to another
one you did in case it saves you time.

Thanks!

Cheers,
Miguel

From: Miguel Ojeda <ojeda@kernel.org>
Date: Thu, 31 Jul 2025 21:41:37 +0200
Subject: [PATCH] gpu: nova-core: fix up formatting after merge

In the merge 260f6f4fda93 ("Merge tag 'drm-next-2025-07-30' of
https://gitlab.freedesktop.org/drm/kernel"), the formatting in the
conflict resolution doesn't match what `make rustfmt` wants to make it.

Fix it up appropriately.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 drivers/gpu/nova-core/driver.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index cb68d0bc1e63..5749bad9c285 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0

-use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sync::Arc, sizes::SZ_16M};
+use kernel::{auxiliary, bindings, c_str, device::Core, pci, prelude::*, sizes::SZ_16M, sync::Arc};

 use crate::gpu::Gpu;


base-commit: 831462ff3ec61fd2e6726b534a351a1a722bf2ab
--
2.50.1

