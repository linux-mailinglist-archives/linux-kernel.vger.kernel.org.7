Return-Path: <linux-kernel+bounces-850288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E3BD2670
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6427A3A755D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736622FF140;
	Mon, 13 Oct 2025 09:56:54 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7542FE07F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349414; cv=none; b=EqG1Go8cH0KOGAGP9OWhujCnOeogPyPm922ea9U+VMK9+Eu60Eb3YWGvY4OhKCOgC9EtiKMRgD9aGP9IjG730/HuJ3WNFEqkUsU3+Sm4FP9XDZQ574cpNM2jub22UX7/JYNiREc5rH2esQB9J1IDk/9x7YdEXp0KT6AvZNpmNQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349414; c=relaxed/simple;
	bh=Lcd30tOIJB5nURqEqHS62gmqBHYLvDLuvoLyUw03FEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=etn6PxX7WTnTXmA+5uBHjnNAkRQFJ3Jls4FQQ49VSlsERQ91xXoBt/1eZw92e8RSeA67gz3V7dfqxCM4eIGMRbEq4gIFdPY2mj8BmMmDJV3O4NjvGL3O3gNVW0iylhEljODSizEe7IqPsQ0gjPs6iqIzuYXq5eqQoMlypUm15I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.198])
	by gateway (Coremail) with SMTP id _____8Cx5tDczOxodIsVAA--.46148S3;
	Mon, 13 Oct 2025 17:56:44 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.198])
	by front1 (Coremail) with SMTP id qMiowJDxcMLMzOxoloDdAA--.63721S2;
	Mon, 13 Oct 2025 17:56:42 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] mm: Remove the BOUNCE config option
Date: Mon, 13 Oct 2025 17:56:20 +0800
Message-ID: <20251013095620.1111061-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxcMLMzOxoloDdAA--.63721S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrurW3XFy7uFy7WFyrZF1rKrX_yoWfGwb_Ga
	4v9F18G3W5ArW7C3ZI9rs5Aw4Dt3W8Wa4xK3W8tr4fX342q3Zagw17tFWrZF17Ca4DWrnx
	Z3y0vryjyryvyosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

Commit eeadd68e2a5f6bfe0bf10 ("block: remove bounce buffering support")
remove block/bounce.c but left the BOUNCE config option. Now this option
has no users, so remove it.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 mm/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 0e26f4fc8717..e47321051d76 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -695,15 +695,6 @@ config PCP_BATCH_SCALE_MAX
 config PHYS_ADDR_T_64BIT
 	def_bool 64BIT
 
-config BOUNCE
-	bool "Enable bounce buffers"
-	default y
-	depends on BLOCK && MMU && HIGHMEM
-	help
-	  Enable bounce buffers for devices that cannot access the full range of
-	  memory available to the CPU. Enabled by default when HIGHMEM is
-	  selected, but you may say n to override this.
-
 config MMU_NOTIFIER
 	bool
 	select INTERVAL_TREE
-- 
2.47.3


