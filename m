Return-Path: <linux-kernel+bounces-751514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B115B16A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13DC564FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777E121771F;
	Thu, 31 Jul 2025 02:39:52 +0000 (UTC)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DD227450
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753929592; cv=none; b=KmSBcELCXVbf+FkBXvt26EyC0/KTDq4ByyRAFlAPXUkNwQOBxE5wBoQjLtfnBiJh2KW7ODaA/VecZhAwgnaTkGtZJQb/+orD7FcJvpLMxqXFo9sOHWO2BiJWVVTCH9JNepjbt6xduBm7w4NtgNEVy/QzGOIfeII3sxBQCY55FFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753929592; c=relaxed/simple;
	bh=UPzp/q7Mz8XPWkGyCALE3/7QRVB7MCNqXo24pcKoEZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0P3YCNI/Q4eXvm0Kkvbm2+aQJ5lhAmPU4Y9ucnI2JRG5VcF8s9cJNZw2CHfpvnStcJbE1fNVLwjPyul2LDxNw+hp/on53R3sWC9g+BK2iaw8XuUO5eAUGHb/7WQnvAS7VmEJzD1UPgocng3Ga7VT9eUOJ9odVgapFozJ4GqkI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b350704f506so303898a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 19:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753929590; x=1754534390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7jN2YE5JP4mLObDIRMobwxfNHhfU6bO2oAy29bLEJ4=;
        b=iyGik+lx5Rk1+lrnLJdsxa5+KwaM53XhGDWeNnxqRAEKAKOuc1lTAnLqL/EPfco4jK
         DgNOWxhpQk6E/0J9hwnVTVfT+KaM+mKq85bGwefiFqrYNsvATo+/kpe2n/0b854T1h24
         S3+OGkye8keRrQAhag8deC3mRS6fqFNC/kdAOYon+LzUMrJMJ7ehoUNg8j4KqBgjj7d7
         /jNCc0WfjJ7abfbx3LLCSbcK3nCgJL8/yMngNuW7660jgNr69qOgsgUarSzxoqtA9pPE
         TNB2uLl5Yk/s5c/v3VkMCLqLI5eVW9gN8Hhin7dZXKdgl/a9w6iIdGoP/fABjsP4I8iI
         T3Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWcknP8oa4M0vQs4RVURZjx2HII9cH1bK/C3cuQVinNSIPub1vn8Uj6t1IK22JdLPR3GLXdUcrpATDjQ+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXX8HNrmHBGRLdE/lFTyaEYIUR2GK69D0iwYziXlAqMc6jv0Nu
	2GtSIO9LXePHMAE5rklroyGGPJgRw2w/ArVC/+SLmPgAF5FUvT0GeNTx
X-Gm-Gg: ASbGncvTemZQIJoFFps4aIbE+2hNhWErxr8RA+WcOwhDgPyGsI2Zs39txE/ChfHu6rV
	CgGniV/OuKrH6v+M9ySxZbvn9PYXqAOyZ61Wq3aZ4qIp413isN6gJlQr9q9m2knKFGlq3Xz6+1M
	R5c8qB0n3eJhLhndioyIJ1xU1nv+/TmIS9ErEKNNLA7oEYs/KtJlqmwKhP9251H9Z5xSxdnHBd/
	M8bswGAeYaa5X5kmCU4Bc8mPHppbUV4uIPJrknZs78NmhmcgptA95Hx31Xzs5rx7spSe/FJUcjm
	ZvY+G4bVPqWThBTJVMsTephs2T0KH/c0od8GH1/GTBUC4s7A8VLtHUj1Mwz0LW05YLDnWDdXhuY
	cdVBI7Xoenw==
X-Google-Smtp-Source: AGHT+IGJYoXamiSK3UMRABpBDymWLB22QGyVIj3h4J0cubndd7Ogqfor7En8zlIeuIq5sl0KMtasXg==
X-Received: by 2002:a17:903:1a67:b0:240:86b2:ae9c with SMTP id d9443c01a7336-24200acb882mr8264155ad.14.1753929589674;
        Wed, 30 Jul 2025 19:39:49 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2403:2c80:6::3075])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f0e84bsm4277315ad.51.2025.07.30.19.39.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Jul 2025 19:39:49 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: lkp@intel.com,
	akpm@linux-foundation.org
Cc: zi.li@linux.dev,
	llvm@lists.linux.dev,
	mhiramat@kernel.org,
	oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH 1/1] hung_task: fix objtool sibling call warning in watchdog()
Date: Thu, 31 Jul 2025 10:39:34 +0800
Message-ID: <20250731023934.48840-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

The kernel test robot reported an objtool warning on the loongarch
architecture with clang:

        vmlinux.o: warning: objtool: watchdog+0x418: sibling call from
callable instruction with modified stack frame

To resolve this, explicitly prevent the compiler from inlining or
performing a tail call on check_hung_uninterruptible_tasks() by marking
it with the noinline attribute. This ensures a standard function call
with a proper stack frame, satisfying objtool's validation requirements.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507301256.cZlxQ10s-lkp@intel.com/
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 kernel/hung_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 8708a1205f82..a5b5a0a2c262 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -283,7 +283,7 @@ static bool rcu_lock_break(struct task_struct *g, struct task_struct *t)
  * a really long time (120 seconds). If that happens, print out
  * a warning.
  */
-static void check_hung_uninterruptible_tasks(unsigned long timeout)
+static noinline void check_hung_uninterruptible_tasks(unsigned long timeout)
 {
 	int max_count = sysctl_hung_task_check_count;
 	unsigned long last_break = jiffies;
-- 
2.49.0


