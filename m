Return-Path: <linux-kernel+bounces-613659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C81A95F79
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 09:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 128653BA140
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 07:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27701EB5F0;
	Tue, 22 Apr 2025 07:31:39 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0071EB5D0
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745307099; cv=none; b=ZegX4kYYO4imhUt/LJRHzIWQazOq/IoD/pE+fBO6vbAtcvh6rv+X1vtAAqO0zLXlOWVcJPsWK0TCIG4BSIKTOqhVUo324h/9gzPk6mMSX+zr0E/eZeCrAufaw74+LHJOcLMwVfVs3sRetsc2hmUJk18UdDRB9DuakDjtFG8cdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745307099; c=relaxed/simple;
	bh=Z92ftI3Rntn9IywLuzRMKBLYhP0rlQ1dYSzFEgpk2Dg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wp6j+jRjN396NvsH5Ed/jgivrKte3zu0ZW/fAD5g2ho2neTEFYRvUhvrZAfTv+MxCL5Ae2K4o2/zn39tBizRBLkhki+CuQkmvYAyrWqHvrPoIA096/cFpARkr55ID8h9NemIBe0Jktl3O3sGLjeXfI7Tx+ysT+7tXLxB3b4j1IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowADHbDnSRQdopiEWCw--.51076S2;
	Tue, 22 Apr 2025 15:31:30 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	oseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] ocfs2: remove unnecessary NULL check before unregister_sysctl_table()
Date: Tue, 22 Apr 2025 15:30:51 +0800
Message-Id: <20250422073051.1334310-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADHbDnSRQdopiEWCw--.51076S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw18ZF4fKr1UWF1xCr1xXwb_yoW3XFcEkr
	yFya4DJryFvrZxt343XFn8Jr48C3WUCF4fZw4aqrnxG34DZas8urykZFn5Z3yDWFWUKrn3
	G3srG343Kr4q9jkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbhkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVW8CwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQVysUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

unregister_sysctl_table() checks for NULL pointers internally.
Remove unneeded NULL check here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 fs/ocfs2/stackglue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
index ddd761cf44c8..a28c127b9934 100644
--- a/fs/ocfs2/stackglue.c
+++ b/fs/ocfs2/stackglue.c
@@ -691,8 +691,7 @@ static void __exit ocfs2_stack_glue_exit(void)
 	memset(&locking_max_version, 0,
 	       sizeof(struct ocfs2_protocol_version));
 	ocfs2_sysfs_exit();
-	if (ocfs2_table_header)
-		unregister_sysctl_table(ocfs2_table_header);
+	unregister_sysctl_table(ocfs2_table_header);
 }
 
 MODULE_AUTHOR("Oracle");
-- 
2.25.1


