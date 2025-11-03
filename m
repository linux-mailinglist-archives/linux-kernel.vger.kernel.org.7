Return-Path: <linux-kernel+bounces-883481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B57C2D8E7
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05EB61898DC4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952A31B138;
	Mon,  3 Nov 2025 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IogQUODJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D931A559
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192965; cv=none; b=O3R4YCEwUR3Y4+Qra2OtSzSYvvti4gw9iLKan/9A2/QYRmht8ibmBpHJByYUkQQZgnSoL4nkZJrJgu08W6tyXPmv6bKuHkVZDtbYxZLs1IU+Et2x1suToGW3y2baTfwrEGWkZmMRxciQ34khDfyW5MUQgslb/Gy0lpnEBT4WRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192965; c=relaxed/simple;
	bh=XAwF/h8XdutL+ENyQyWob7z7axCXjW7g+SCPNNUBiyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqW/U/AAf+kEdV3ki8I0PRJEhq7hWvIinrXjoX4+KEE7pftfwbt7zOEkMB0d5PxuhIepwfHBwvWbghuO+I4M2bv047xrt7ozM4IXevUoj7FxB73KcaNl76JXG4jVFlqxq8kLtMWHG8v1uxg8ZrIJZCgT8D0VtQduMBfQ0BpQCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IogQUODJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD2DC4AF09;
	Mon,  3 Nov 2025 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192964;
	bh=XAwF/h8XdutL+ENyQyWob7z7axCXjW7g+SCPNNUBiyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IogQUODJjyTWMTWVWaSKOwkSJBVW67K2O34Yde/KtslQOOC/Iz4sy8KaX6kqBr7H5
	 GFb0Mcw/CkdVwmgfsioszFx5cEWJnFMulKlO4IIWvyPCxOY1jfelhxhEZQ5AP4Ct20
	 0Vgjho6r1cDd6BAXDhjF53c2kxEy94T2XEauW2MpEwvaH7ybnXWy2ukCRmB/8Xzbk8
	 Q8XlwO1XtdHF4UuXTBo9/62vnf1B1SOwpRq/JctgNqhxnH4iX4n2dIk3KVMpmHVZDY
	 fl6Itix1asg+IRwQ/C5Alq02OX92QqFS6qSZ4BEdLJGRyEcSa9MguO0nJ5vMyR8QXe
	 Rxj/Q36Ehv0Gg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kho: warn and exit when unpreserved page wasn't preserved
Date: Mon,  3 Nov 2025 19:02:32 +0100
Message-ID: <20251103180235.71409-3-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103180235.71409-1-pratyush@kernel.org>
References: <20251103180235.71409-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling __kho_unpreserve() on a pair of (pfn, end_pfn) that wasn't
preserved is a bug. Currently, if that is done, the physxa or bits can
be NULL. This results in a soft lockup since a NULL physxa or bits
results in redoing the loop without ever making any progress.

Return when physxa or bits are not found, but WARN first to loudly
indicate invalid behaviour.

Fixes: fc33e4b44b271 ("kexec: enable KHO support for memory preservation")
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_handover.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index c2bcbb10918ce..e5fd833726226 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -167,12 +167,12 @@ static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
 		const unsigned long pfn_high = pfn >> order;
 
 		physxa = xa_load(&track->orders, order);
-		if (!physxa)
-			continue;
+		if (WARN_ON_ONCE(!physxa))
+			return;
 
 		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
-		if (!bits)
-			continue;
+		if (WARN_ON_ONCE(!bits))
+			return;
 
 		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
 
-- 
2.47.3


