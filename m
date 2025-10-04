Return-Path: <linux-kernel+bounces-841910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9E3BB8824
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 04:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9D744EFE33
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 02:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA7B265296;
	Sat,  4 Oct 2025 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tfKVYBoa"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61727F16C
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543265; cv=none; b=G+3OALDcu04hOSZbjSiwnmgs5KB/057J969ruSpxBkqZoq5Qn37ihMoaJOHM/J4saIns/KseMCtJhsrJZL0hUN7Wd6oQEuG6n9FR7+Rr9bpZ/GFcRRZTxnCx4fnaxXkeSeMaGpsLJllJp73lwvml619Vo5qcyLB3UzZn/AYeMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543265; c=relaxed/simple;
	bh=noldGvgKb+Yt10IJJen/x+2xYWNiD0UJTzcrkPwnznE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LymgYVm3oj1VLx0aDnBIpuiwn83dQWBuxXJtKJsj+x2/uwWMNkZWPRPF5h0S/FZtPamG/+mMah2Nl7tmlKM0kg2u8Cn03DYL2NFk+StshvRnrtVQTHyhwF8jE42cGkOGkkDlQ2La1ulJVq60yo85i+yKf5SOvW3YvL0W5nV7o3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tfKVYBoa; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759543261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SkiwK9RwsroUBGOPJR5Sa12Pfd+uQhUHiLz4Go2NyKI=;
	b=tfKVYBoaQ+Oa7JJUrapRzd9r5HcZ1xLlIxSVSk7nnW0L4fywvvAdfb+9o0FwJXxskzKTCG
	tEC7Egw5alrRMOynKWbOfCQLAQVR+4TrOTmOEMsDD0Bo237l2YYD1X6PCFR7OoLfm9rZmQ
	EdihYYaB3dUl7TBjpGe3Ksbuu3OGLHQ=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 6/7] lib: Give XOR_BLOCKS, RAID6_PQ config opts names
Date: Fri,  3 Oct 2025 22:00:48 -0400
Message-ID: <20251004020049.918665-7-kent.overstreet@linux.dev>
In-Reply-To: <20251004020049.918665-1-kent.overstreet@linux.dev>
References: <20251004020049.918665-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Give these config options names so that they show up under the "Library
routes" kernel configuration menu, and can be enabled by distributions.

These are needed for bcachefs to be built out of tree.

These libraries are both for RAID5/6.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 crypto/Kconfig | 2 +-
 lib/Kconfig    | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 23bd98981ae8..da4f072abae0 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -3,7 +3,7 @@
 # Generic algorithms support
 #
 config XOR_BLOCKS
-	tristate
+	tristate "Accelerated block xor algorithm"
 
 #
 # async_tx api: hardware offloaded memory transfer/transform support
diff --git a/lib/Kconfig b/lib/Kconfig
index badcb5ca9efd..e831f4462453 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -9,7 +9,9 @@ config BINARY_PRINTF
 menu "Library routines"
 
 config RAID6_PQ
-	tristate
+	tristate "Reed-solomon RAID5/6 algorithms"
+	help
+	  Provides routines for block level reed-solomon, for RAID5/6
 
 config RAID6_PQ_BENCHMARK
 	bool "Automatically choose fastest RAID6 PQ functions"
-- 
2.51.0


