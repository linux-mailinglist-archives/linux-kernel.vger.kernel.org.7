Return-Path: <linux-kernel+bounces-849900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C475BD1382
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C34189499E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089F242D92;
	Mon, 13 Oct 2025 02:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bMKyizjj"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96434BA2C;
	Mon, 13 Oct 2025 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760322633; cv=none; b=eBvpuGLXdN/QHOuGQsZQENZkmjZ+H+tCA+JB1Nsn7Lj9+omSG54KE222taLoj8m2gwF4B/5Tr3+yAVExCLs4iI1mJHTzQf9DyJ3LSgFDRTcUCukpvRfAyMTeScWsvRIS37EqX/fnycBQxQx9FT9Dq/C5yZrXqiLWsNet1M4yNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760322633; c=relaxed/simple;
	bh=Rz5IUeO7Od3+7XpyVOyEco2NiGqY62grdl9fusAzTjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQnd1gfslfm1pEI4BY62w9tFBC+CnqeoXF9iddFoMGL3OvzdpzQa4Gq2zC2Wf9JeoSTHVtellOFpd8pQuh2fepSWBKpOE6xF1XzKfXeiCtKE1qLGqfA6+XL8rk85/YVKyplJ4z++KYjZMp3mz4sawJF7UwWIryXxgDxWRgZiJ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bMKyizjj; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760322621; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bTrSg4+Ju1yQWCUjI2YUcMdAQWZaOX/XJAOM2fwegqo=;
	b=bMKyizjjoSS8rbfzlxFbvdoiEXajUteP+DehpNjsITkt20qiWuHTrDiR4TJQwte7IJ30tZ+IAIZx1mD9n8M9nDr8SU56M3i5o8dhfr6JgIkrZ7FGBq7bwrcRDxBH9iP5FHjE76zsTyidGSQluEA3DF5UouUqwXIPVP4ieoLaaNg=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Wpzwl4K_1760322612 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Oct 2025 10:30:21 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: James.Bottomley@HansenPartnership.com
Cc: deller@gmx.de,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] parisc: remove unneeded semicolon
Date: Mon, 13 Oct 2025 10:30:11 +0800
Message-ID: <20251013023011.955200-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./arch/parisc/kernel/perf_regs.c:30:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26159
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/parisc/kernel/perf_regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/perf_regs.c b/arch/parisc/kernel/perf_regs.c
index 68458e2f6197..10a1a5f06a18 100644
--- a/arch/parisc/kernel/perf_regs.c
+++ b/arch/parisc/kernel/perf_regs.c
@@ -27,7 +27,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 		return regs->ior;
 	case PERF_REG_PARISC_IPSW:	/* CR22 */
 		return regs->ipsw;
-	};
+	}
 	WARN_ON_ONCE((u32)idx >= PERF_REG_PARISC_MAX);
 	return 0;
 }
-- 
2.43.5


