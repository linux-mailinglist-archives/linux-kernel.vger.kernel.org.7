Return-Path: <linux-kernel+bounces-887594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC0EC38AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 02:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5840D188E35C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 01:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE9F1E51E0;
	Thu,  6 Nov 2025 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wKQVOzwV"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97FF1E32D3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762391523; cv=none; b=MvusNFLETXQIOTflzWKVcVfWCX4+NCWZ3TOu+3H2gnCQh60lew9TuGHABPSLZTEbUDpBCkH/xPcDZcayg0qYN2Vbedz/BzFn0TJ7MIu84ayp0NqWhi8qBGOLhz5uF8k6RS5pXmb8o1RCoBqCI8CWLJ1nsexm/RgTSM/aBYbPcZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762391523; c=relaxed/simple;
	bh=9J+GQsabqWq0SzdkzjfkY0+YAySvu0mHZIJKBIsN2SA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qN40HcLXQ7wcWUQUuB3m8tpOp8km7Z1UX5R8KlARmK1hcKb0IEd4xCVvAccdlErouYYb7+70Vr27VmaFVTs4ErVijw4VNn61WbdaY/ttvo8w3n6dZwcHu1LRM7s/jI+UVmls/ZV3yWBU3dtSRAmjz2FqJ5AzS7FDz0sJUJJMGdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wKQVOzwV; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762391518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RPVVr6R6/R4uLeTWW79sJbo88M16VGLNR2YUAhLQNnQ=;
	b=wKQVOzwVi0/utG6jYyilcGaNEV8gKQ+7poZ3cd+AWZBcUYMeIlr0cppl/GVPnq8PWloN6j
	k9JAVyGRJGcpK8Srjaz6wucTcNHCpuN3df54802qkV1H9CV6dnwwH0thHq8uHO1PXqkmhQ
	uGSk2RWJPGRESTdbWTqQ0mppAb9Dv74=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuntao Wang <yuntao.wang@linux.dev>
Subject: [PATCH] of: address: Remove the incorrect and misleading comment
Date: Thu,  6 Nov 2025 09:10:35 +0800
Message-ID: <20251106011035.166356-1-yuntao.wang@linux.dev>
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


