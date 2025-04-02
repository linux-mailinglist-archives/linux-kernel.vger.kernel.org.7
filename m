Return-Path: <linux-kernel+bounces-584571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D92A788BD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 09:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39181886B66
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 07:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5919232364;
	Wed,  2 Apr 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQ2VJsyE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21051DE2B4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578100; cv=none; b=Me93OtDIUBqteM00o7gyZac5a4Ka2bjjIv7TD66b/NT84jwmKiTQIv+F16+UGlS0QdzDhQ8dldhT180dRylmbqzYga/di+Kh5kCw2LcVUMwa5UM1UduPERlO/JYRBVx7aATopr3M6AkRaeJ2j2vvCZ0XwHUXDRHYXTln1djanVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578100; c=relaxed/simple;
	bh=FOtpYeBp4zVQl3ctHjTlko2k1XohN/LrcFybr1axKz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AsB+zTWUJFuiUHs85lLMso9egOKhnifjOvZavUWH4KXt+1iqv+8XLpUksVEf/U/qc5OCSR0Xst7Q89wajl5jzSJPTDk0tdc7TwDxTzqzlOntmQjq/LE9Lf4dzUpW6J51hbMY536dM6+ntesXdH649PeA65FsJgRpGfY356jhLLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQ2VJsyE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743578094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qh1ya57MIjo5Lkmn722x+JI5fDV/4skd8xfb1oy7zXs=;
	b=eQ2VJsyEhmmqbjyJKvRKn7MXWDXPQrqFWH12HyyJ5roLbY3+PDxozHytyj9efK9ybjR2ae
	C1BmHEjRnTn7/1e7DC4PvQZziuVp9zS2uv06YLbdcwd0r//I0cTVfyVQT6Ua7YVyFZrdC8
	Ap0OgBBTIjcdTTtbCs6faAv0VhroUqc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-XcjVldcLPfmmluMdhWpxZg-1; Wed,
 02 Apr 2025 03:14:49 -0400
X-MC-Unique: XcjVldcLPfmmluMdhWpxZg-1
X-Mimecast-MFC-AGG-ID: XcjVldcLPfmmluMdhWpxZg_1743578087
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 591C11955BC9;
	Wed,  2 Apr 2025 07:14:47 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.220])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11FE3180174E;
	Wed,  2 Apr 2025 07:14:43 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] rv: Fix missing unlock on double nested monitors return path
Date: Wed,  2 Apr 2025 09:13:52 +0200
Message-ID: <20250402071351.19864-2-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

RV doesn't support nested monitors having children monitors themselves
and exits with the EINVAL code. However, it returns without unlocking
the rv_interface_lock.

Unlock the lock before returning from the initialisation function.

Fixes: cb85c660fcd4 ("rv: Add option for nested monitors and include sched")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202503310200.UBXGitB4-lkp@intel.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---

This fix is not critical since currently no nested monitor registers
nested monitors and doing so would require another review for inclusion
in the kernel code.

 kernel/trace/rv/rv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 50344aa9f7f93..968c5c3b02464 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -809,7 +809,8 @@ int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
 	if (p && rv_is_nested_monitor(p)) {
 		pr_info("Parent monitor %s is already nested, cannot nest further\n",
 			parent->name);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto out_unlock;
 	}
 
 	r = kzalloc(sizeof(struct rv_monitor_def), GFP_KERNEL);

base-commit: acc4d5ff0b61eb1715c498b6536c38c1feb7f3c1
-- 
2.49.0


