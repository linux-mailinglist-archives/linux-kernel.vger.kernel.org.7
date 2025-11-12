Return-Path: <linux-kernel+bounces-897421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F08E3C5303D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5F5D4F3EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7E333FE34;
	Wed, 12 Nov 2025 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HuZVYKhw"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345A2BEFF3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958322; cv=none; b=ekevOAr1EOIc8JSb9isym4U70N9XQQ4rd61x9UeiydfkesMTW1aCmjdgwZkrf5Yk3YCy8VeI3Tt9pY9EghHobfGJskBP05h05ZCV7VUr+/p/wLGFN3CrOBWh1HNFLJ84BaR+y78rBxYJLQPVz3F4vzMd4w6yk4jXnnYRejaOTxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958322; c=relaxed/simple;
	bh=9J+GQsabqWq0SzdkzjfkY0+YAySvu0mHZIJKBIsN2SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZgH+v3p4T57neO/oN6K6IEiXa9ira4xA19/EdYoBwwv90pGXe5R+hJG55TPlWTYVL5MfsI4EP8KpQe4brQNPToaC7iG+HP0aTUxXnGoAeETbfD1nOFuc89mUN5Ih+sZuP6h+hRoKurBlGRFqEIbRXVvnK1zhd7PQ/yHvz/XDCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HuZVYKhw; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762958319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPVVr6R6/R4uLeTWW79sJbo88M16VGLNR2YUAhLQNnQ=;
	b=HuZVYKhwVa7mIpp7GLEabQYO7zytLZA0fV/X4oxkz/gBcin8w1+09UYcqYPKQFyI2GqHOo
	83Sgf/x36JxHZarvwVTHG6WNy7tSQiFUsCeUXrtzTxev656j01RD/OY6EuYtE33g1s88UN
	9af3ZSK1WFqhJstRFB7D1UhPLpCM9as=
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
Subject: [PATCH 10/10] of/address: Remove the incorrect and misleading comment
Date: Wed, 12 Nov 2025 22:35:20 +0800
Message-ID: <20251112143520.233870-11-yuntao.wang@linux.dev>
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

The of_bus_default_match() function appears to have been copied from
of_bus_default_flags_match() with some modifications.

However, the comment was left unchanged and still describes the behavior
of of_bus_default_flags_match(), it is incorrect and misleading, remove it.

Signed-off-by: Yuntao Wang <yuntao.wang@linux.dev>
---
 drivers/of/address.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index f0f8f0dd191c..4034d798c55a 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -328,10 +328,6 @@ static int of_bus_default_flags_match(struct device_node *np)
 
 static int of_bus_default_match(struct device_node *np)
 {
-	/*
-	 * Check for presence first since of_bus_n_addr_cells() will warn when
-	 * walking parent nodes.
-	 */
 	return of_property_present(np, "#address-cells");
 }
 
-- 
2.51.0


