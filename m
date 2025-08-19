Return-Path: <linux-kernel+bounces-774934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FA2B2B95F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EDE5565821
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B797C2690D5;
	Tue, 19 Aug 2025 06:26:33 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC28F266580
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755584793; cv=none; b=d7cjNcx85XWkc3G+mtZux+huP53kwCBUPYPcOwhPqFeRgg3/eEJw3u4GSnMl3rmQyZ3BiTL7sbeuudcj5unTQMvyjuI5kzA8SfRR8jJOokBDQ53XHeFwptJT1g5KOCr573K/Ii1RH49r3jUstKieDuDtYal6nX+aJV3zFIUGwTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755584793; c=relaxed/simple;
	bh=VufQAu/FGFL5zFCeWsFRI9oI3fWmgn2NaX9TUyRFA0k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ckfEENG5Vx22J/gAVAqW3AUbOZXiVffaq2bDELvU2V89UcZBNarPM1DQ1mrnm9LWv9pNwk2g75DjX7UVoDDByAcTPuz105BXQpGAWd8LCyTqshBINU3fyH1+9KZ9oJbu+qEkyQ6rYdaux2V3YTMrdSjequ4QSxdNHjiJk+i7y1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c5fjw2YvjzYQvH1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:26:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E728E1A018D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 14:26:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHwhIQGaRoz8C9EA--.57459S4;
	Tue, 19 Aug 2025 14:26:26 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-mm@kvack.org
Cc: hughd@google.com,
	baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org,
	jlayton@kernel.org,
	linux-kernel@vger.kernel.org,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH] tmpfs: preserve SB_I_VERSION on remount
Date: Tue, 19 Aug 2025 14:18:03 +0800
Message-Id: <20250819061803.1496443-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHwhIQGaRoz8C9EA--.57459S4
X-Coremail-Antispam: 1UD129KBjvJXoW7try8KrW8JrWxCw13ArW5Jrb_yoW8GFW8pF
	Z8C348Kr18XFyIvaykXay8W34ayrZ7CFyrKrWfu345Xa4qyw1DKrZ7KryYvFWfuFWfJr4S
	vF40k3W3CF1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWU
	AVWUtwCY1x0264kExVAvwVAq07x20xyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x07jo_M3UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAFBWii1fNJdgABsT

From: Baokun Li <libaokun1@huawei.com>

Now tmpfs enables i_version by default and tmpfs does not modify it. But
SB_I_VERSION can also be modified via sb_flags, and reconfigure_super()
always overwrites the existing flags with the latest ones. This means that
if tmpfs is remounted without specifying iversion, the default i_version
will be unexpectedly disabled.

To ensure iversion remains enabled, SB_I_VERSION is now always set for
fc->sb_flags in shmem_init_fs_context(), instead of for sb->s_flags in
shmem_fill_super().

Fixes: 36f05cab0a2c ("tmpfs: add support for an i_version counter")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 mm/shmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e2c76a30802b..eebe12ff5bc6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5081,7 +5081,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_flags |= SB_NOUSER;
 	}
 	sb->s_export_op = &shmem_export_ops;
-	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
+	sb->s_flags |= SB_NOSEC;
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	if (!ctx->encoding && ctx->strict_encoding) {
@@ -5385,6 +5385,9 @@ int shmem_init_fs_context(struct fs_context *fc)
 
 	fc->fs_private = ctx;
 	fc->ops = &shmem_fs_context_ops;
+#ifdef CONFIG_TMPFS
+	fc->sb_flags |= SB_I_VERSION;
+#endif
 	return 0;
 }
 
-- 
2.39.2


