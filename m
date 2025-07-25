Return-Path: <linux-kernel+bounces-746350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B672B125A9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CDC3B408B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2222690D5;
	Fri, 25 Jul 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfYo3tgb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BE625FA2C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475661; cv=none; b=oyBpNfuPYf++798BEAQj5rig8SLAHX8uRP/H9vnVPt9hCl07rZrkbG2d6uzV7Kn1SlbIaFc71tW1TyHZzU+OeNAcj+9dQhRLUF3Xma5Gm8S8rVLOFcZF7zSz5U8b39BTwM6eWxUynA3QRnH8wlwKP6BZj3yxTchHjRTopP43O04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475661; c=relaxed/simple;
	bh=mnMaRWRSouXLjic4p7/eniTlbsyexL3Z/zySAdm/g5s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sa7e0h7im3fGfrk/eMLJn14b0EFkrtHFfJlx+tE25TXh8QKJDnCGNgjHnLQ8nUQKz4N85xeoENDWJZXt++W6IDI2yAW3r1AlqDmU5Uy+jemySW43mKS2kDQZU3dieCL+GRz1FRJnHpN79tj3DvYK7phEWOXgCao/AQ1HlLJTuio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfYo3tgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CB0C4CEF4;
	Fri, 25 Jul 2025 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475661;
	bh=mnMaRWRSouXLjic4p7/eniTlbsyexL3Z/zySAdm/g5s=;
	h=Date:From:To:Cc:Subject:References:From;
	b=AfYo3tgbxnXkr3TV56fiSPcC/igsfZNKzB0vEc8152d9DtzNXIuV1yf9at7W8HXYF
	 K+Sh3dbdyjTH6rG40VN9yaSV6ehigcGoJ53glNed2pnIoK3pk3sVT4lf2dKBSeM5mr
	 N1iXrTt44B1PH359O5t7nV5eq2hPB4F4CYgak3Z7Yfo2i57fmKF/rR5tI3SiAN9hdJ
	 GSCYW6y9RAV3xl2EdJTxz7EPfSphoSB81p07FnWf8Vyj9F6n/C8/cXg3knxZkEig6n
	 sMpCisJj9wLJ84ntrDIPa0zG9L/XuI2mtKloG11NV5FBYg0fLqtpjRtNaSX5ik0+RD
	 Ckey/G+s5bJFw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7b-00000001QmM-2bpB;
	Fri, 25 Jul 2025 16:34:27 -0400
Message-ID: <20250725203427.471623294@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:18 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 21/25] rv: Remove unused field in struct rv_monitor_def
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

rv_monitor_def::task_monitor is not used. Delete it.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/502d94f2696435690a2b1fdbe80a9e56c96fcabf.1753378331.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/rv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 98fca0a1adbc..873364094402 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -41,7 +41,6 @@ struct rv_monitor_def {
 	struct rv_reactor_def	*rdef;
 	bool			reacting;
 #endif
-	bool			task_monitor;
 };
 
 struct dentry *get_monitors_root(void);
-- 
2.47.2



