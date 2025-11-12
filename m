Return-Path: <linux-kernel+bounces-897411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9D9C52E59
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DA9C502B65
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9901833AD8A;
	Wed, 12 Nov 2025 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GwVtWhnu"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C423F42D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958263; cv=none; b=Bt6wjCLO6MHbvq7Ydf52E8UVUIEpZwmndv0KwrgKMo9TI6tx4Rf6kjiOTswhXM1TahHiwvcs3qYyotFr9ybN/EH31+K4oRYTSI028i9E2rUb5fRQIyBZtBI787sB+Z5BNQ18TpqeQLZ8dx5Y2m6zavOkDrhc4rMhk5RBeKbN9pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958263; c=relaxed/simple;
	bh=FnJNwjc+en5RS+JbzwPkobo8ZAzHwK/8ia5Eorc3bFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qT5Y9OkaXZPOqstqgox4KHENwhONu1+J1RBiAgwhodDnGHhD1ea7YZVamgJhGtvWQb6tr8xCR5MBDvpsWbxyQx9I3uX1EgNxFZ8fkXSsCdDEzOAoGj8RjTkvW4XqoZUvQn4ojdRycnZZJKg9rMTno1HSVVaZLToihWD2oxsQ2jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GwVtWhnu; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762958259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4cbw0txGZgveQRmvE3BdA/66SsL3EqAhAgd0O+UFaEE=;
	b=GwVtWhnuB1vnkuqa+YuRpjhRHNurmeP4s4SumezLBIyG7Iz5N72RhZbKM8EilMaRZo+Y+N
	CZGRXHZB80AfyoP2pjHcdm3jIWNw6Jjg0tUZlj3irvmPYvR0JW1ub6399ci5a9h7C4kSto
	fMVVmXPjSSrqJWLCiFxm4DqflU02ujA=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Catalin Marinas <catalin.marinas@arm.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	James Morse <james.morse@arm.com>,
	Chen Zhou <chenzhou10@huawei.com>,
	Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH 03/10] of/reserved_mem: Use dt_root_addr_size_bytes() instead of open-coding it
Date: Wed, 12 Nov 2025 22:35:13 +0800
Message-ID: <20251112143520.233870-4-yuntao.wang@linux.dev>
In-Reply-To: <20251112143520.233870-1-yuntao.wang@linux.dev>
References: <20251112143520.233870-1-yuntao.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use dt_root_addr_size_bytes() instead of open-coding it in
fdt_scan_reserved_mem_reg_nodes() to improve code maintainability.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 drivers/of/of_reserved_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 67c0ccd373c2..0e6b0e7968a9 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -230,7 +230,7 @@ static void __init __rmem_check_for_overlap(void);
  */
 void __init fdt_scan_reserved_mem_reg_nodes(void)
 {
-	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	int t_len = dt_root_addr_size_bytes();
 	const void *fdt = initial_boot_params;
 	phys_addr_t base, size;
 	const __be32 *prop;
-- 
2.51.0


