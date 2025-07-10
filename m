Return-Path: <linux-kernel+bounces-724814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5DAAFF738
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C986B7B7D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B42C2820BF;
	Thu, 10 Jul 2025 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bhaTFRG+"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7295B27FB28
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752116405; cv=none; b=MNGVF6feklTzjfHt+GX1LW75P6QTbrpGl11zYZW5xUa4XTmGY3D8Sc/1HRBPt9JTihHHZ8n/hJjNAwEQGdxTzOP7uVCHdAwSh+OXSrytum+sT2BdvzlFbcSiXzFMg564RrjDpI4qXKb6MZINMA175QoIv1Z7WCiL9Omy/9bi9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752116405; c=relaxed/simple;
	bh=6EHdcxjVdce/toogWHoF3VxCQuE91DzrRcJAoGNb4qI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCKL8u8nyb5p0zSKJz6h7JuWxIqpW682ZkBoPFiU4kCN66vmU0XKcVmc+BspOmxKjPGnVzbB9/6dmJvlANEAivHsPa6V2Cv2zJK3TJpZvTVMz8yHVa04f8q6dj5UCacPtiHGLhxgoZxjc06Okv7TbFcj8D+6tW0nhZSk0MB4dQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bhaTFRG+; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1w
	dCQu5NBMyy8vOfJ0oOzm9oxSXXUp51sw7QzNatywU=; b=bhaTFRG+0QIOX5XFKb
	wNwsMkKI/JZM0aULUxDAWpwV7d6HSBbXF2v6l3rhfWzVXNn/wkxSRpPIT7gkTaXZ
	hkV+TJ0mI6fRULgsUEqYFpjVWOY+LJCIu4WqztHpFiJD3IB94egrCaa8HPVZUpv9
	4dd9JlXPA1jAaCkbt+PrPC4N0=
Received: from ly-pc.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDHv3Z5LG9oBnhWDw--.47287S4;
	Thu, 10 Jul 2025 10:59:14 +0800 (CST)
From: Xuanye Liu <liuqiye2025@163.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Xuanye Liu <liuqiye2025@163.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: simplify min_brk handling in brk()
Date: Thu, 10 Jul 2025 10:58:58 +0800
Message-ID: <20250710025859.926355-1-liuqiye2025@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHv3Z5LG9oBnhWDw--.47287S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw48uFy8Gr4ktryxAw15XFb_yoWfKrb_Wr
	WI9a1UK3W5ArZ8KwsFv3yqy34kC34DCw18trsFgw4avr4DXrWFgrZ5u3ykJr97ZFZ3Xr1D
	AFsxX34xJw129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUxsgUUUUUU==
X-CM-SenderInfo: 5olx1xd1hsijqv6rljoofrz/1tbiMA6GUGhvKvMspAAAs+

Set min_brk to mm->start_brk by default, and override it with
mm->end_data only when CONFIG_COMPAT_BRK is enabled and
brk_randomized is false.

This makes the logic clearer with no functional change.

Signed-off-by: Xuanye Liu <liuqiye2025@163.com>
---
 mm/mmap.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d8fa373e4ac1..7306253cc3b5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -127,18 +127,15 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 
 	origbrk = mm->brk;
 
+	min_brk = mm->start_brk;
 #ifdef CONFIG_COMPAT_BRK
 	/*
 	 * CONFIG_COMPAT_BRK can still be overridden by setting
 	 * randomize_va_space to 2, which will still cause mm->start_brk
 	 * to be arbitrarily shifted
 	 */
-	if (current->brk_randomized)
-		min_brk = mm->start_brk;
-	else
+	if (!current->brk_randomized)
 		min_brk = mm->end_data;
-#else
-	min_brk = mm->start_brk;
 #endif
 	if (brk < min_brk)
 		goto out;
-- 
2.43.0


