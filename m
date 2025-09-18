Return-Path: <linux-kernel+bounces-778590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB38AB2E7AF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE1EF189D092
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C448334377;
	Wed, 20 Aug 2025 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tPJzIadq"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9C2BE7A6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726518; cv=none; b=NrecmDYTYYJxN2Egb5phVWzRrwn28mfdV2N7R//YMpaCwQIrZtseQU6/an4FdHuHwfUrO670Fz1CIAEBvqdNnHRA0SlL9lvOSpwNA4/yHmfRFgLR8ZtQSdj3m7juIzimhlwRROyGG/d/BiMM/wyioFhAPGOI5pXEMz4YjZCkYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726518; c=relaxed/simple;
	bh=q/QeIx6onVjFe+oNDyOLR9t+BFR9BZgAJwuj2NXMEgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFHsxmSip5dRtqvmvJ3y30I9vXczFWpmOSSwDI0+0bHW/MpoWr5PW3iIMxLdB7iPJhIPHw1Iy0/wDNxcinYktnIkUvBpD4YeAefdUaCumXbxwboQToJHL8bFlSo/9T9KqbIPTZKDVA95jb4eaqhIJ7WAHWCmn+XHFXIRnrOdd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tPJzIadq; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755726514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zj8PrTi1yTrpnWppwAghhrVhgoHUOMCkGMyMIPT8YMc=;
	b=tPJzIadqtj4OI8I5+AcPZCV5VWQ+89oSVnuPbZZumrjeGurwqJva7JwqOtt0q0LAKdtqOH
	0i5CHkXa8rUS5fSHUzmIJrqkMYvv/Rz8JR+O15V40daBmju0VZ1iBFs2vNuNgB1lFcVG0a
	NERCP0Hs3LVVc7s2YTFTN90b0kh0NBs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: probes: Replace strcpy() with memcpy() in __trace_probe_log_err()
Date: Wed, 20 Aug 2025 23:47:18 +0200
Message-ID: <20250820214717.778243-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use memcpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/trace/trace_probe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 5cbdc423afeb..d3ba5869d32c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -214,7 +214,7 @@ void __trace_probe_log_err(int offset, int err_type)
 	p = command;
 	for (i = 0; i < trace_probe_log.argc; i++) {
 		len = strlen(trace_probe_log.argv[i]);
-		strcpy(p, trace_probe_log.argv[i]);
+		memcpy(p, trace_probe_log.argv[i], len);
 		p[len] = ' ';
 		p += len + 1;
 	}
-- 
2.50.1


