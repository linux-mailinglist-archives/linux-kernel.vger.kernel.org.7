Return-Path: <linux-kernel+bounces-770356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ABAB279F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77659607F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDD32BE63E;
	Fri, 15 Aug 2025 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rk6X/6t+"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A573220F30
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242075; cv=none; b=bGpp0drw5VDzLm6qbZr9sZ2xgycnXpS/V3txSkt4oMBg0LxVHURxp3lkZtJQgGMKosi0eMnpbgNfVqK+rYtzXtUyDpnFMKiAuarGmKqnaa18Vf0pEhzZ2UA5DOrzf0AdjnM4ny+EDXjySq/d2VFiJq4kkSPYuoi94RTZryokEuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242075; c=relaxed/simple;
	bh=ewMJk6wAAzgMUMYP/9W5KcSaZDRdd0EX+zxzJTjpK/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GsoZ2k3tKh7rGfskZm+r1X6MHO+otRKtL84yWXFKuMCE27dz79+7AcN428lLKmQo6wdojt9NDcrWLBuzb3cxBpOc2f5r3VVnhZsG3DES7GDTGynm6poPV3dZZwr9p3/nvSHaebFkD4fU8TIOcSRX3V7NhtU+MYeUIvHcs8AD/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rk6X/6t+; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755242070; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=d+Rgi9ggLE8RHIN7XYswQJ8cd0pl5zwQMXMpubqkD44=;
	b=rk6X/6t+U8Fdx8rF09QRHtP2pkzxxNg9n2M+6EgvsSi5VX+aocQ0q5C/UTTcdfl8Bg+lAQ5Y9PZW3AiF3Xnvscvv1NpRWaD35foJ/lz094aIlvH1Eq9EmBRCT06CAO0rey5kEunoukftmrLPGZZoxSpVp04hIk1NcubkLeXlw/Y=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WloF6LR_1755242069 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Aug 2025 15:14:29 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
Cc: paulmck@kernel.org,
	john.ogness@linutronix.de,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH 1/3] lib/sys_info: handle sys_info_mask==0 case
Date: Fri, 15 Aug 2025 15:14:26 +0800
Message-Id: <20250815071428.98041-2-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
References: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
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
---
 lib/sys_info.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/sys_info.c b/lib/sys_info.c
index 5bf503fd7ec1..b2df148971ba 100644
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
 
@@ -81,6 +81,9 @@ int sysctl_sys_info_handler(const struct ctl_table *ro_table, int write,
 		char *delim = "";
 		int i, len = 0;
 
+		/* *si_bits_glabl could be 0 */
+		names[0] = '\0';
+
 		for (i = 0; i < ARRAY_SIZE(si_names); i++) {
 			if (*si_bits_global & si_names[i].bit) {
 				len += scnprintf(names + len, sizeof(names) - len,
-- 
2.43.5


