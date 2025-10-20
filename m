Return-Path: <linux-kernel+bounces-861262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 668DABF2348
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 551DA18A39C0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE0275105;
	Mon, 20 Oct 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="bttH3Hxg"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D7274B44
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975349; cv=none; b=aUKOYNo4Qybm3NLhfE6whIqAMkkXrGlt/LyXJ6GtH9ZSjGg633nM5XFbaWaWbkimpgLDIaxPdgGwyWxQj8632FkUnih+YsvhXmY8QX2IQrlEpFaP1s8zpCd7RsWZC6P1uj8QPwVfs/4gWKpT3uqKVAV3hgquANsl1rOxjm+7JBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975349; c=relaxed/simple;
	bh=VOe7YeHPmgqFVb45V0QBaf5dPkfM9WSW0Ud6q0TRFCE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=YkQX2p8NSqUJfa0JymNAn4fPytF94w06WfhxCJkcWfW0x49O2mMQgDb+CPR6WUkPypIEyop1nl9VCZ8V7iC51ZJF1qQOXHcC2saOMlfDoQ1hADRkIpxXEeceO9ACyBXuXx/GZf6xZNhpT9Pc2W/Hg0wrMPAhkTgKDuw8QI/tAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=bttH3Hxg; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1760975034;
	bh=h13hvJEmeQORaCCWjAwRU639z0CD1vvMgt80xJncD7M=;
	h=From:To:Cc:Subject:Date;
	b=bttH3HxgB0fua+BRCEPcyoyggtHH1DHrWsQNS+WKUZNWZzXkN2UdB3V1ix0zgCSEU
	 HaYDSMdywFzCZt32NFEKeB5WpUHTwN6UuqzFFPqhx9ab8afMJx/dwUOGZExyMqMZG2
	 4/vSS6ohB/05jpFW0Ob2jFEIoBpIpPaPLBdsc7LQ=
Received: from zm.. ([2408:8340:a20:6b00:20c:29ff:fe69:94c7])
	by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
	id AF512C33; Mon, 20 Oct 2025 23:43:53 +0800
X-QQ-mid: xmsmtpt1760975033tdhzogchg
Message-ID: <tencent_C04F39CA166C38A5502D7CF206688E191307@qq.com>
X-QQ-XMAILINFO: MuOYcNghSeIL+gqpZ0UIhkab9xX8mbPqNkiEFQL68ll/hyA4or+x3ZlpPjHjV4
	 4cs1iACFmsdhs2DgDi9G5PZawYliEBKwo4/Bx6hpMrkPIRDtjyWoasqvFoDcNXl22fss8UggP7Ej
	 28a/WVDFIb/Styu2wVb7Cd0f4c7hEUEnvqMF9Bc/hsSK+1PrPBSqpA9gzH6pHYQGx9yx3/rLZzZl
	 A5Z0upHHyh8XeZxWqPqlhKD5Hzj41FzCAyoOK+XKvVAsmcxy6+VHK81VnTaafVkEF4PBJ+ywDVxh
	 HSruJqAFSFcJbLvv689QNTQaLWO176IQJMTbdhoGYIU6lyknuPhdIq+RE/B0AbR/7wT4gtK/aHNT
	 Csx3xl5Mm2tjgKW4Rmr9ty/3S3c/LfJKLemlJyq7CA4He3lqg1a52mkMiTKq8NjvA8G/A/8dCn+c
	 SXJaS4gG+J6OqlQrm9Kc7p5iTTj9Iy/VZJcIgW9QRiuhYLStZytqPZCHwvOjBl6MtMEfU8S23Zdi
	 DRJgNm8l4fntFNyaMtHoFh4tCPQ/6cGKO7bw4RvCGxZs+3XXvLUXeOTtGP6hYO1hpAiBxm//6rU3
	 IWWq+ykSKy6puhor6hs/rE0CgZKb5a6OlwuBJhPT2FbN8obT1lfENOGz7MyOXSXNGEZFQyquhDt6
	 jVVx6fQUTBnmllOsQuqlZxsnY9ZTQVkms2lCHu2AN8IvedLrTH2nlQJw2DEDI7S8IEOrEmEUEYCO
	 hMJoeZ0DQZ5+n9/sDysM4txz28QrvxJw3F9LMgLns2CQsbGFQM9oEoTp1P8AUJMMrqT+Nhb///qz
	 YUfXhnmfpVQFCI8u6IveZgK9fv7z1Ay+HrJGh5PKOCg0cXfYDb2ctcWFQqgQX6NwvmJ1D+fr86Os
	 zCd4EgDZdnpm5n7qXFhgvLegkAcNIbkhZ3xC3s7cmXQQZTBYDnMH3szhZU5KBzkDL/ri7oCT/rhP
	 CAoPXIwAYWOviTT3gsbqIas6b8JGbcksqMQ4ihe5lNkCltYvkmuNHHq+19EcY4HA8L8MFzPxhj2/
	 89LVBLITHbL/g0kNIdZH1MfHHaojIgtnahX+QQlrknkzPfo97YUKv8TFBeQHkkTvXXufuPPzIw2H
	 x5cEnqlp1NTIJueBocOp7keMwmRQ==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: zhoumin <teczm@foxmail.com>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org,
	zhoumin <teczm@foxmail.com>
Subject: [PATCH] cputime:make function static
Date: Mon, 20 Oct 2025 23:43:50 +0800
X-OQ-MSGID: <20251020154350.74033-1-teczm@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make account_system_time static.

Signed-off-by: zhoumin <teczm@foxmail.com>
---
 include/linux/kernel_stat.h | 1 -
 kernel/sched/cputime.c      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index b97ce2df376f..815400c81015 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -119,7 +119,6 @@ static inline void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
 
 extern void account_user_time(struct task_struct *, u64);
 extern void account_guest_time(struct task_struct *, u64);
-extern void account_system_time(struct task_struct *, int, u64);
 extern void account_system_index_time(struct task_struct *, u64,
 				      enum cpu_usage_stat);
 extern void account_steal_time(u64);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 6dab4854c6c0..8c74b86f74f5 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -183,7 +183,7 @@ void account_system_index_time(struct task_struct *p,
  * @hardirq_offset: the offset to subtract from hardirq_count()
  * @cputime: the CPU time spent in kernel space since the last update
  */
-void account_system_time(struct task_struct *p, int hardirq_offset, u64 cputime)
+static void account_system_time(struct task_struct *p, int hardirq_offset, u64 cputime)
 {
 	int index;
 
-- 
2.43.0


