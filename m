Return-Path: <linux-kernel+bounces-869849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55796C08DB5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 10:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF3E64E7D7D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B022F5B;
	Sat, 25 Oct 2025 08:00:12 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB77299A8A
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761379211; cv=none; b=TK+0x8ozJjNbtr4R+wJIUFazwdMQiMrRZCM5TJJizNRiQ61IqIvd9tVm3DJVPAJixWSYt1L7veENkQUVgaRziUvpmXPUc+db3QM0GFXHyqxM+4DP/g+FhUSdpjq1UqbmSflUefH3daF78P3OznNUzxACkA5fLUfZHVsXfqQG7T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761379211; c=relaxed/simple;
	bh=1QkleFJf+6aQV/CqBfkr2ld0sn8Xc0AQxmwNYLrMBZQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=koGc2ITXB2OdeQ2DKmQtZrvW8GB348PXu3zDN9ePpSArzGN4auW5M/rYO7z02C1eAX67+fcwE/yNEKBklxhe1feUUXgoeEg51J3WhKGTFJubbQMLE2NFKdOG0oQ8WjTwoj7tYntisyxOezP8v/yiuw6ylx88akjo+IiPeI1RAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ctsbt15rfzYQtwd
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 15:59:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 18A3B1A167C
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:00:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.159.234])
	by APP2 (Coremail) with SMTP id Syh0CgBHnESDg_xomLEwBg--.51099S4;
	Sat, 25 Oct 2025 16:00:04 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: jbaron@akamai.com,
	jim.cromie@gmail.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	yebin@huaweicloud.com,
	yebin10@huawei.com
Subject: [PATCH] dynamic_debug: add support for print stack
Date: Sat, 25 Oct 2025 16:00:03 +0800
Message-Id: <20251025080003.312536-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHnESDg_xomLEwBg--.51099S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGw13Ww4kGrWrAFy7uFyDJrb_yoWrArWfp3
	WkWFyYq3yrJFy8Gwn7XFs8KF13uFWIkF4xGFykur4rAFyDAasYqry0gF4aqFWrXwn2kayU
	Xryqgay5Ar45CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

In practical problem diagnosis, especially during the boot phase, it is
often desirable to know the call sequence. However, currently, apart from
adding print statements and recompiling the kernel, there seems to be no
good alternative. If dynamic_debug supported printing the call stack, it
would be very helpful for diagnosing issues.
This patch add support '+d' for dump stack.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 .../admin-guide/dynamic-debug-howto.rst         |  5 +++--
 include/linux/dynamic_debug.h                   | 17 ++++++++++++++---
 lib/dynamic_debug.c                             |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 7c036590cd07..095a63892257 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -223,12 +223,13 @@ The flags are::
   f    Include the function name
   s    Include the source file name
   l    Include line number
+  d    Include call trace
 
 For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
 the ``p`` flag has meaning, other flags are ignored.
 
-Note the regexp ``^[-+=][fslmpt_]+$`` matches a flags specification.
-To clear all flags at once, use ``=_`` or ``-fslmpt``.
+Note the regexp ``^[-+=][fslmptd_]+$`` matches a flags specification.
+To clear all flags at once, use ``=_`` or ``-fslmptd``.
 
 
 Debug messages during Boot Process
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index ff44ec346162..05743900a116 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -38,11 +38,12 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
 #define _DPRINTK_FLAGS_INCL_SOURCENAME	(1<<5)
+#define _DPRINTK_FLAGS_INCL_STACK	(1<<6)
 
 #define _DPRINTK_FLAGS_INCL_ANY		\
 	(_DPRINTK_FLAGS_INCL_MODNAME | _DPRINTK_FLAGS_INCL_FUNCNAME |\
 	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
-	 _DPRINTK_FLAGS_INCL_SOURCENAME)
+	 _DPRINTK_FLAGS_INCL_SOURCENAME | _DPRINTK_FLAGS_INCL_STACK)
 
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
@@ -160,6 +161,12 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 			 const struct ib_device *ibdev,
 			 const char *fmt, ...);
 
+#define __dynamic_dump_stack(desc)				\
+{								\
+	if (desc.flags & _DPRINTK_FLAGS_INCL_STACK)		\
+		dump_stack();					\
+}
+
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg") name = {				\
@@ -220,8 +227,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  */
 #define __dynamic_func_call_cls(id, cls, fmt, func, ...) do {	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);	\
-	if (DYNAMIC_DEBUG_BRANCH(id))				\
+	if (DYNAMIC_DEBUG_BRANCH(id)) {				\
 		func(&id, ##__VA_ARGS__);			\
+		__dynamic_dump_stack(id);			\
+	}							\
 } while (0)
 #define __dynamic_func_call(id, fmt, func, ...)				\
 	__dynamic_func_call_cls(id, _DPRINTK_CLASS_DFLT, fmt,		\
@@ -229,8 +238,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define __dynamic_func_call_cls_no_desc(id, cls, fmt, func, ...) do {	\
 	DEFINE_DYNAMIC_DEBUG_METADATA_CLS(id, cls, fmt);		\
-	if (DYNAMIC_DEBUG_BRANCH(id))					\
+	if (DYNAMIC_DEBUG_BRANCH(id)) {					\
 		func(__VA_ARGS__);					\
+		__dynamic_dump_stack(id);				\
+	}								\
 } while (0)
 #define __dynamic_func_call_no_desc(id, fmt, func, ...)			\
 	__dynamic_func_call_cls_no_desc(id, _DPRINTK_CLASS_DFLT,	\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5a007952f7f2..7d7892e57a01 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -95,6 +95,7 @@ static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
 	{ _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
 	{ _DPRINTK_FLAGS_INCL_LINENO, 'l' },
 	{ _DPRINTK_FLAGS_INCL_TID, 't' },
+	{ _DPRINTK_FLAGS_INCL_STACK, 'd' },
 	{ _DPRINTK_FLAGS_NONE, '_' },
 };
 
-- 
2.34.1


