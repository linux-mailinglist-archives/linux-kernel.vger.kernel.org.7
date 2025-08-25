Return-Path: <linux-kernel+bounces-783919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B7AB33436
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 04:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F299020315A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 02:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5346235041;
	Mon, 25 Aug 2025 02:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RQMicdhS"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE81CEAB2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 02:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756090629; cv=none; b=c1IHQini+UW2zs9VP6ug59y7Yx15276cfwg5XlNQNwxcmSPTozXyRzIk9KIpDwgLXnxaM+kYk4n35DQOvi0YaTN3R8DvBBc8rwU1lQksr2RfQ1My9dHOrh9g8hJjWyNg+LR0jZeCoxCoDoE/Lkl6ldtUOg60smQqA65/7mpgGks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756090629; c=relaxed/simple;
	bh=sWtz293OE9gB9N7nNIRvDMxDhE6lkzjEHk8Qi/o9CaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIDbyi1s9ODy8ymNnM5h9Vvw+00Zktl8HDzUZw+0CyN/5V5SsRj3cAdWKonKBmoad6K1W2PTsAoKjC0BQOnC6RCJZrLWd9PKgt6+ot4fjDCTVkyMhv83iwEyMEaMjFRBZPkLTLtJrcb1mmTufgec6/lDmKflTcK0BF4EIjgravM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RQMicdhS; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756090623; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=7MAm6Z3riqm4IE81SV3duGhwX7ltTmUSPeAsxYMHI/M=;
	b=RQMicdhSY+9kP89v+5aNWH67mvJl3n3RkflfGvKYMQL18AdPaEpYp8hsgP5wtVEZq5QjisE6o/MRYlHiw0eKGNFZEMjhu6Dvw1DP0kGFVu0ArHo2PXqT3e5ZuScLQxAmdT1udTe8uCyknw82rGxz/SdZfLx11/FGRptvsuGZQBA=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WmPuXGT_1756090622 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 10:57:03 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
Cc: Askar Safin <safinaskar@zohomail.com>,
	paulmck@kernel.org,
	john.ogness@linutronix.de,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v2 1/4] lib/sys_info: handle sys_info_mask==0 case
Date: Mon, 25 Aug 2025 10:56:58 +0800
Message-Id: <20250825025701.81921-2-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825025701.81921-1-feng.tang@linux.alibaba.com>
References: <20250825025701.81921-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is a normal case that bitmask parameter is 0, so pre-initialize the
names[] to null string to cover this case.

Also remove the superfluous "+1" in names[sizeof(sys_info_avail) + 1],
which is needed for 'strlen()', but not for 'sizeof()'.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 lib/sys_info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 5bf503fd7ec1..496f9151c9b6 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -55,7 +55,7 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 					  void *buffer, size_t *lenp,
 					  loff_t *ppos)
 {
-	char names[sizeof(sys_info_avail) + 1];
+	char names[sizeof(sys_info_avail)];
 	struct ctl_table table;
 	unsigned long *si_bits_global;
 
@@ -81,6 +81,7 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 		char *delim = "";
 		int i, len = 0;
 
+		names[0] = '\0';
 		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
 			if (*si_bits_global & si_names[i].bit) {
 				len += scnprintf(names + len, sizeof(names) - len,
-- 
2.39.5 (Apple Git-154)


