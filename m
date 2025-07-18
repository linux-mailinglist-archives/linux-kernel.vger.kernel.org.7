Return-Path: <linux-kernel+bounces-736604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A59B09F39
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C23DA85760
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE757298CCD;
	Fri, 18 Jul 2025 09:20:53 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0197298989
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830453; cv=none; b=gh6WnMFObDqRQYmpaJosvtjx4pP+ALX+mDxQKzhXztKLHOHoB4N+Zb+6olzSV0W6kTZvHCif3mhqjBOfuOJqzZ+hqy7Jk0oxdfsR6X9cWA+Qoi7lehwduaBBs5cpZtOb5+XAfMaDEwuMsb4HkzBYLG5WEuX00cOBTgtU8YOVdVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830453; c=relaxed/simple;
	bh=EPJ/Ik5dby8310QIWD+Pi1wNolDY/hdjXWo0z86oWCQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PGzNc9dynsOQhJTEuDBz6BTs0vb7HAueJwIJgDCPJfM6Cp4g3peigMdD8klHC4PCQYvFTrTIMTEUqhqSxhYA2SGnNHS3vI/YKXjl5u3i43fS0xCtGjbrv0O3c9KTwzbNvEz8tVAwFZzDQLVrOXMB2w75/zTSP5iBQcfvFLfGp48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bk43N4KsJz2FbR9;
	Fri, 18 Jul 2025 17:18:40 +0800 (CST)
Received: from kwepemk100005.china.huawei.com (unknown [7.202.194.53])
	by mail.maildlp.com (Postfix) with ESMTPS id 026CD1A0188;
	Fri, 18 Jul 2025 17:20:47 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemk100005.china.huawei.com
 (7.202.194.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Jul
 2025 17:20:46 +0800
From: Liu Chao <liuchao173@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<hewenliang4@huawei.com>
Subject: [PATCH] x86/fpu: remove unnecessary curfps null pointer check
Date: Fri, 18 Jul 2025 17:20:20 +0800
Message-ID: <20250718092020.1619436-1-liuchao173@huawei.com>
X-Mailer: git-send-email 2.23.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100005.china.huawei.com (7.202.194.53)

curfps has been dereferenced before check and cann't be NULL.

Signed-off-by: Liu Chao <liuchao173@huawei.com>
---
 arch/x86/kernel/fpu/xstate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index cded076469fa..0e299af49ac9 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1501,7 +1501,7 @@ static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
 	fpregs_unlock();
 
 	/* Only free valloc'ed state */
-	if (curfps && curfps->is_valloc)
+	if (curfps->is_valloc)
 		vfree(curfps);
 
 	return 0;
-- 
2.23.0


