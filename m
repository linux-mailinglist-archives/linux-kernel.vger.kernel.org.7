Return-Path: <linux-kernel+bounces-849895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D24BABD1349
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2107618913E3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C874D279795;
	Mon, 13 Oct 2025 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="j2kwChOm"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9922EB878
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760321938; cv=none; b=G/mX+HuGFLdiurnfuCl/Kgxbte+maodUYd6GlGG0C7+M/OglXAEbJPzYzQ/m5BKvtHh3WK03MJOZQVLjWshGt+KgpeqAzxgXmZkKr4JrfGP+aSpBfjaIFx4iUbmXhan4HfwAS/VX/mWuCFjyf/TkOXWu+TcO3QajJCLgvpUzEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760321938; c=relaxed/simple;
	bh=W4xweIrbECfob98OPYlu9Gvtn4f/o5y8Ii1sZNxUMMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKSp5e2poD37cnABLTB+CEkKz/MeRp73wtMJ1ojkgAiqjJ15CT16KPq8VNQeZ1nKyrJLFqU+/hedT6KebFCXzBHISjXU3k8iG738ujd0At65c+NYYMXTT5lTbe4hIrcjHDOmCqAbZ50ycKqSV8cy1f4SbN2cI13Y9m5JscvxVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=j2kwChOm; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760321933; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zoAUUn3bBmorrWCF+Kq+jcKJMJh3OyLAIbSpHP6CdMA=;
	b=j2kwChOmwkqXwLixaNFC6jXWTeWbbygMSuyGPwKwZhv98CFUbCyw/Gnsy9TNHuhH4luUFOGFJSWpSgn3W8uv3t72jFgvJec3hRR6/p7l4ZmGwMN7YGlA0n4TFsTU6n5uXFY1iKPFXOhAi/tS03d2EJsGsJhEx9EMeobe8MPRC8o=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WpzmIqu_1760321916 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Oct 2025 10:18:52 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: graf@amazon.com
Cc: rppt@kernel.org,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] liveupdate: kho: remove unneeded semicolon
Date: Mon, 13 Oct 2025 10:18:36 +0800
Message-ID: <20251013021836.944898-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

./kernel/liveupdate/kexec_handover.c:1155:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=26158
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/liveupdate/kexec_handover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 5da21f1510cc..c87d00c40c82 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1152,7 +1152,7 @@ static int __kho_finalize(void)
 		err |= fdt_begin_node(root, fdt->name);
 		err |= fdt_property(root, PROP_SUB_FDT, &phys, sizeof(phys));
 		err |= fdt_end_node(root);
-	};
+	}
 	mutex_unlock(&kho_out.fdts_lock);
 
 	err |= fdt_end_node(root);
-- 
2.43.5


