Return-Path: <linux-kernel+bounces-837954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD02BAE1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFA53C6B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1DA30E0CD;
	Tue, 30 Sep 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nU7VlhxJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99730C0E8
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251686; cv=none; b=oZmHhHHp6F2dicCdBMiuMc939oOipJZbjgUqjrbFIekbDosqWirUrVjbTYXcMApwofq3qWm8vG1J279eaSJJxZPOFq0L1jttvfLDY5TUjftevcoZPgj+Uh/x23h+impIlxrnlDnHRDEGfHMx1V1q8DOmt92FibItgLKzrM6KBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251686; c=relaxed/simple;
	bh=qUk+6vmoI9FoeERrBRl7q29liPWfCY0ID1ORFfm7iCk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=r0s6R57P4rNtjEFiC5G77R95UKUm1ZtuwB9DGdRiYPvlPpknT8+aHLtHEl0x5K9sjIhj7xK7LQ3nj//MEpf5eh0D0yQPy5zQpkX3YLktsivc6U/Qq6pLCYdZ5t7ZrclnDkwYBmtTtPtI4K2gs47qn0LUR3fx2zMytbOXNlcjqIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nU7VlhxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A988C116D0;
	Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251686;
	bh=qUk+6vmoI9FoeERrBRl7q29liPWfCY0ID1ORFfm7iCk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=nU7VlhxJWv07BBpiR6RwkU+ZYAnqCTkf6odlDPWONV5N7r9f27F1+e01Z7+4ZGWrR
	 SRX36o5fDXO1Ad7z9GFXLtncfs9qb9JBVzx0H4n2RtSKGCdDpuwAf2DXXT4wd6HL8a
	 xYm3aveTZRFqf5Bqc44Vkb1XbLz3DtpPsv8kO5u0+aUHN4bojGZvQsNRFX79Bc4CyF
	 MsYZ46uI1MuI34KRSQbsVOe2ozd0JW26V8qZ9SHLBxm2JkaMObvgKxXFmjQ1MDhf8i
	 WC4yMPs5iw7MXJSrztUc9omT0hgvnUCpR/wxFgv6OlgUVw2oM1j+yD9TP1Sg3Ne9he
	 7gzIKgT4nzf2g==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3dkk-0000000DIJI-2ssl;
	Tue, 30 Sep 2025 13:03:02 -0400
Message-ID: <20250930170302.542931839@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 13:01:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thorsten Blum <thorsten.blum@linux.dev>
Subject: [for-next][PATCH 08/11] tracing/osnoise: Replace kmalloc() + copy_from_user() with
 memdup_user()
References: <20250930170135.285740909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Thorsten Blum <thorsten.blum@linux.dev>

Replace kmalloc() followed by copy_from_user() with memdup_user() to
improve and simplify osnoise_cpus_write().

No functional changes intended.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250905192116.554018-2-thorsten.blum@linux.dev
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 4cb464894faf..f8aa9556c695 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2322,12 +2322,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	int running, err;
 	char *buf __free(kfree) = NULL;
 
-	buf = kmalloc(count, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (copy_from_user(buf, ubuf, count))
-		return -EFAULT;
+	buf = memdup_user(ubuf, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
-- 
2.50.1



