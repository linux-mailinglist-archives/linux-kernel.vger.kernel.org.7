Return-Path: <linux-kernel+bounces-758570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63462B1D0E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 04:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708BB56386F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B82199949;
	Thu,  7 Aug 2025 02:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PxlVLXlv"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3521FC3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754533965; cv=none; b=ZlFUZTsiLy+5nbM/e4yBi0PIeHNhcH7tQPQ0X/fSA7A4MTKvsAxfikOkwden3TJmm4ncb9Il9KTJ7B5KUg+zWm4qojrR5ejWYAysUVUj8O+sk5XrU0wOVgH7CsOzP1nAQL+WUiVxqqHbiXqUEzPYRV3UvFljBxxSljLxqp44ZkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754533965; c=relaxed/simple;
	bh=ZqxmErrhtELx8YaWg8vQy1GXahB6YZhoXay79SNIA+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QNrl49fBK/6Is5GTCL9AKNFSWXB4FqID2yv2P0CO03R1qVVELmWyuuRkPzpw8KkgqWTOFoKe28p2JsS5XnXEx/fDbjXZ80ilF5g1Az8DWosBLJKzOBpxa4A/ItrExlesZdMN8xKPzkIhzQwx6KCY7fHck1yGsLC5zvaadECyHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PxlVLXlv; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754533955; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=N7DPBFQAufQxv6xrZOxkYWoWR64wqv6X35FvaO9S9Yg=;
	b=PxlVLXlvDmC7d+VOxjHKyznFkPPBw6X1IzhFLxT+G86P95R/pIFcrUhtLLZMRl6DuO8lUQIuX7WNzn1tt8G/Mw++1D0BK2shpaW0WTQN+wH+6U5r2mTwkk7xDQ0sGRB6ibF+/Mn4Ox1cPGzoxokSFtTjnVyoB7B+I8puJHrw4K4=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WlCW3XV_1754533948 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 07 Aug 2025 10:32:34 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: richard@nod.at
Cc: anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] um: Use ARRAY_SIZE for array length
Date: Thu,  7 Aug 2025 10:32:27 +0800
Message-ID: <20250807023227.2443863-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of macro ARRAY_SIZE to calculate array size minimizes
the redundant code and improves code reusability.

./arch/um/kernel/skas/stub_exe.c:196:23-24: WARNING: Use ARRAY_SIZE.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=23410
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/um/kernel/skas/stub_exe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/kernel/skas/stub_exe.c b/arch/um/kernel/skas/stub_exe.c
index cbafaa684e66..01a938a5bb4f 100644
--- a/arch/um/kernel/skas/stub_exe.c
+++ b/arch/um/kernel/skas/stub_exe.c
@@ -193,7 +193,7 @@ noinline static void real_init(void)
 			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
 		};
 		struct sock_fprog prog = {
-			.len = sizeof(filter) / sizeof(filter[0]),
+			.len = ARRAY_SIZE(filter),
 			.filter = filter,
 		};
 
-- 
2.43.5


