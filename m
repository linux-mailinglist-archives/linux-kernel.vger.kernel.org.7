Return-Path: <linux-kernel+bounces-896385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6BA7C503CB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 02:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF943B322B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 01:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECC1296BD8;
	Wed, 12 Nov 2025 01:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6KYpWbI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808D25A642
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912082; cv=none; b=dPV0ZRVn397sVvBT+nmoi9fxTpDX7WHE8Q+zY0UBjjo1/UsK7QI9CH5FRI/9N2bhd7Vsu6eOwi0JSQ/EvnuF49ll4cAvzXiAlHHjoEy/8Y1ZFXPICZv770i7tnfFulnONGw6lZK7MGOX/536RFjkuSHUtyhdCHr/GxnDhspPJVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912082; c=relaxed/simple;
	bh=l89OBBRuQN/2/Z1dA51l4gZkGX3b0zGt4ZmsQETNW/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Df0Ap0OoX9kX+ujDyL3I98iMSlxUpCT2mSrQbUoZpDasEZa98YUycLJ23V46I7ZgI8xLOmkqZDmdheTaDP7RVV98rZ8rGJLLH8Y+C2KRzGqsExt/U6kgKub9cUzogg40lthZ6eCD73ZzeOIArCnxcu9DmsCgO2KInlYw8QEQ9B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6KYpWbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF49C2BCB2;
	Wed, 12 Nov 2025 01:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762912081;
	bh=l89OBBRuQN/2/Z1dA51l4gZkGX3b0zGt4ZmsQETNW/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6KYpWbIiBqm5vcfQSXUIGVJZzyFysOP0qOUCKRymJJiifLwvg9C6M9WDAJbRGqpF
	 FoEVyBxSA0eCYIzL1NNpI5Ci+x8Pz2qm7bPLHsS5iDSOd5I94rrECvCpmpjD+w5cD+
	 gtOGHkOdwFqZjbYbDyU+ALOqL42T3nJ3hS2H45TQ0fGmrO+dl7/Ok5cddWHEBSmNPm
	 gL1Cpfc5XS3sBPHCINH5NqhzcCzkv6mykk77W3B+vDhmoKM0qPP9lXx7XOTmmiS4RM
	 RJWuM63YGteGtGeycYyXxSCqLyoUX4qyQpAnM+bQce9slz566bXJz63lLlS8++nvRF
	 0YbqbTt75gLsA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2 3/3] f2fs: change default schedule timeout value
Date: Wed, 12 Nov 2025 09:47:49 +0800
Message-ID: <20251112014749.2006439-3-chao@kernel.org>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
In-Reply-To: <20251112014749.2006439-1-chao@kernel.org>
References: <20251112014749.2006439-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch changes default schedule timeout value from 20ms to 1ms,
in order to give caller more chances to check whether IO or non-IO
congestion condition has already been mitigable.

In addition, default interval of periodical discard submission is
kept to 20ms.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- no changes
 fs/f2fs/f2fs.h    | 6 ++++--
 fs/f2fs/segment.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0d0e0a01a659..74cbbd84f39b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -407,6 +407,8 @@ struct discard_entry {
 #define DEFAULT_DISCARD_GRANULARITY		16
 /* default maximum discard granularity of ordered discard, unit: block count */
 #define DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY	16
+/* default interval of periodical discard submission */
+#define DEFAULT_DISCARD_INTERVAL	(msecs_to_jiffies(20))
 
 /* max discard pend list number */
 #define MAX_PLIST_NUM		512
@@ -656,8 +658,8 @@ enum {
 
 #define DEFAULT_RETRY_IO_COUNT	8	/* maximum retry read IO or flush count */
 
-/* IO/non-IO congestion wait timeout value, default: 20ms */
-#define	DEFAULT_SCHEDULE_TIMEOUT	(msecs_to_jiffies(20))
+/* IO/non-IO congestion wait timeout value, default: 1ms */
+#define	DEFAULT_SCHEDULE_TIMEOUT	(msecs_to_jiffies(1))
 
 /* timeout value injected, default: 1000ms */
 #define DEFAULT_FAULT_TIMEOUT	(msecs_to_jiffies(1000))
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 993ec8afe2db..8375dca7ed9e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3471,7 +3471,7 @@ static unsigned int __issue_discard_cmd_range(struct f2fs_sb_info *sbi,
 			blk_finish_plug(&plug);
 			mutex_unlock(&dcc->cmd_lock);
 			trimmed += __wait_all_discard_cmd(sbi, NULL);
-			f2fs_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
+			f2fs_schedule_timeout(DEFAULT_DISCARD_INTERVAL);
 			goto next;
 		}
 skip:
-- 
2.49.0


