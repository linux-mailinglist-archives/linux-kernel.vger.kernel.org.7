Return-Path: <linux-kernel+bounces-654944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E65ABCEC8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 07:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CC58A1ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 May 2025 05:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557A9254AEF;
	Tue, 20 May 2025 05:51:13 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126CA94F
	for <linux-kernel@vger.kernel.org>; Tue, 20 May 2025 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747720273; cv=none; b=gZQUH2+9+a+LW2BSAY2wvAdikyWbz8q3JnL481KrDNm739CafeAKYagQIgn1A/gUu/WnipJq7vakAOWtJszbItyec8eq9LrwkR/+5WRawd0oVaXmmvFczxC9tVTKslERBwWpemNmUM20M1AKQvtNI4hc/YGkmn3TLtXMU1+8jzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747720273; c=relaxed/simple;
	bh=RrxvwzauZcMA3zTGwuom96Mb5M5Z5xzApTxLGUx2cZ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DWC+Ubt9vBLUba+CtrUWNQOHn2zzCHoCSCIHBHnQxmZ0GCaSEyu7DKXfLpIkAsIWuFfdSITw59uUhItrBm/X0VVAETFCwUvoiZ0xajOpdQbD1WIoBfCnz/XEACbBw8V79egi+bF43KS22A8mb04rw1ZjiI9JrIhG+smAQis0VV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 54K5ohV8078797;
	Tue, 20 May 2025 13:50:43 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4b1k9w0Bh2z2PBF7F;
	Tue, 20 May 2025 13:48:20 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Tue, 20 May 2025 13:50:40 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <song@kernel.org>, <jolsa@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>, <rostedt@goodmis.org>, <ast@kernel.org>,
        <mhiramat@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <xuewen.yan94@gmail.com>,
        <di.shen@unisoc.com>
Subject: [PATCH] Revert "bpf: remove unnecessary rcu_read_{lock,unlock}() in multi-uprobe attach logic"
Date: Tue, 20 May 2025 13:49:43 +0800
Message-ID: <20250520054943.5002-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 54K5ohV8078797

From: Di Shen <di.shen@unisoc.com>

This reverts commit 4a8f635a60540888dab3804992e86410360339c8.

Althought get_pid_task() internally already calls rcu_read_lock() and
rcu_read_unlock(), the find_vpid() was not.

The documentation for find_vpid() clearly states:

  "Must be called with the tasklist_lock or rcu_read_lock() held."

Add proper rcu_read_lock/unlock() to protect the find_vpid().

Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Di Shen <di.shen@unisoc.com>
---
 kernel/trace/bpf_trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 187dc37d61d4..0c4b6af10601 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3417,7 +3417,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	}
 
 	if (pid) {
+		rcu_read_lock();
 		task = get_pid_task(find_vpid(pid), PIDTYPE_TGID);
+		rcu_read_unlock();
 		if (!task) {
 			err = -ESRCH;
 			goto error_path_put;
-- 
2.25.1


