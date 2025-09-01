Return-Path: <linux-kernel+bounces-794113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C41B3DD04
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9656D3B534B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7E82FF152;
	Mon,  1 Sep 2025 08:50:33 +0000 (UTC)
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD2821D3F5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756716633; cv=none; b=LNNn2InATsKcnfUMzqjC9fpMyXEPWgQDTADHhWrgLV5MvkTknBP8wI/C9peCH+sXvmu7Q/A/kl4pTaxvxLiS209x47RgZj3jKmZGuWRKSC2/Gbzbo9HBRHqIj7Bh8EaRXJ/rl8IcXWUqoO/AN0mQ+bQbqZmC6BH41/sS/yTMUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756716633; c=relaxed/simple;
	bh=opTgY6AevhpKYfy4jKxjdJj6OF1b2Vc37uBGTwVjzaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUInLNLfB0CyMoGqHpjIrWyt3jG1mFCOISw3w4wPHBkMBtTJ7NTXfFKLsQXagCs44N+/4sV1BVPOxUpy22W9kEPIAdAO5l97avHabmb1K4vZ4QEX7C/CQGAfTTZ9GuAu+QwmwdN6GnQUEQi+hbaerLs8+TcAZ+h4blViMFIiQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201610.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202509011649167765;
        Mon, 01 Sep 2025 16:49:16 +0800
Received: from localhost.localdomain.com (10.94.9.187) by
 jtjnmail201610.home.langchao.com (10.100.2.10) with Microsoft SMTP Server id
 15.1.2507.57; Mon, 1 Sep 2025 16:49:14 +0800
From: chuguangqing <chuguangqing@inspur.com>
To: Koby Elbaz <koby.elbaz@intel.com>, Konstantin Sinyuk
	<konstantin.sinyuk@intel.com>, Oded Gabbay <ogabbay@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	chuguangqing <chuguangqing@inspur.com>
Subject: [PATCH 1/1] accel/habanalabs: fix typo in comment
Date: Mon, 1 Sep 2025 16:47:42 +0800
Message-ID: <20250901084742.1935-2-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250901084742.1935-1-chuguangqing@inspur.com>
References: <20250901084742.1935-1-chuguangqing@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 20259011649167e168e19e6c266f69f95587056e1d8f6
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The word "properties" was misspelled as "properites".

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
---
 drivers/accel/habanalabs/common/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 6f27ce4fa01b..f7b9e07233d4 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -1068,7 +1068,7 @@ struct hl_encaps_signals_mgr {
  * @kernel_address: holds the queue's kernel virtual address.
  * @bus_address: holds the queue's DMA address.
  * @pq_dram_address: hold the dram address when the PQ is allocated, used when dram_bd is true in
- *                   queue properites.
+ *                   queue properties.
  * @pi: holds the queue's pi value.
  * @ci: holds the queue's ci value, AS CALCULATED BY THE DRIVER (not real ci).
  * @hw_queue_id: the id of the H/W queue.
-- 
2.43.5


