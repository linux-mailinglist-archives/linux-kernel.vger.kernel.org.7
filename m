Return-Path: <linux-kernel+bounces-743401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A516AB0FE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 02:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EBCF7A3DD3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 00:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7045C56B81;
	Thu, 24 Jul 2025 00:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW+1P+Hs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258522097
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 00:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753317702; cv=none; b=fE8I14ht4LUYQknpEMJxN124n9iYtiNh8XjFfzwM0wcNn9WswzwGqRF1Ky54IFnqjxkRONbA6sGE6dRAl3xznD+rHyt3rephdTVEB57HNaz9oSCM01PQz4QX2yndNCq1uEAUIgLm4xvE6aZFX1XZ2h+P0FMmXI1H84cLVmndCbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753317702; c=relaxed/simple;
	bh=KMxs7psGGosQjH9QdtBMuoUtdhJLQWMZ/LGiAx+f+i4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Is43JYX4Ol1KUsZyPw0vBY/RYX2/sGZ+hYDZXsI+fbX4/N8+pwz6BxIDiEcJvulwmhFdWy0eiWv1ZYXLJjzwQ1bJU3S6v7J5NQdlwv/s261tIRgHc1IiXjnr71wXuR4XX5CFmLqk1pkFevVNn45BqQM1lgTDEncwdsuQF6uibJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW+1P+Hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD7AC4CEF6;
	Thu, 24 Jul 2025 00:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753317702;
	bh=KMxs7psGGosQjH9QdtBMuoUtdhJLQWMZ/LGiAx+f+i4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=TW+1P+Hs4SzU5kUKi3shw3k2gtO8rx1qos/IFLFfWcHUJwpvzcjrLb0cHXSEvPTS9
	 EmNmWyCvgQZ+nVzwZRYRw4KbbYlGPHKMUGXeRqHnH8bSpimq/ndgNUZKNdl1aPpodf
	 RGi32E78pPcX7hqZh0mz88NWDk5MXpCmI5hXy3hkpL2o8BnkR0ZIU+OyrHLiyAPJww
	 lo3qEdvpmPcYg7gA+7HIS020raSy0C+e2xHuvZW4HJNkOsUJO8+/6qfyJ1PIV936Ca
	 4kf55/CdOkig+pfUmVbGbnzSSLuL//zJVZ4wIoLMu2aJ10ABe0q6PfYVOKTDX3mXo2
	 nACYNl5Sr8AMA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uek1o-00000000WZg-20bc;
	Wed, 23 Jul 2025 20:41:44 -0400
Message-ID: <20250724004144.331778474@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 20:41:28 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Colin Ian King <colin.i.king@gmail.com>
Subject: [for-next][PATCH 2/2] ring-buffer: make the const read-only type static
References: <20250724004126.185765796@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Colin Ian King <colin.i.king@gmail.com>

Don't populate the read-only 'type' on the stack at run time,
instead make it static.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250714160858.1234719-1-colin.i.king@gmail.com
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 903d9db75e12..5176e0270f07 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4216,7 +4216,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_unlock_commit);
 
 static const char *show_irq_str(int bits)
 {
-	const char *type[] = {
+	static const char * type[] = {
 		".",	// 0
 		"s",	// 1
 		"h",	// 2
-- 
2.47.2



