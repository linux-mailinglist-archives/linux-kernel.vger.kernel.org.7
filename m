Return-Path: <linux-kernel+bounces-857854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30DDBE8134
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F0E3B0792
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D127B25393B;
	Fri, 17 Oct 2025 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lws5Zyzq"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4891BC3F
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697057; cv=none; b=pmciEGoooMkQH9LYBSNdIwuhO7PbTWostyyVwxF+HkeHJSDVo2pjMGoBxwFuqa39WAlSVp5nX0XLBwTOMND9T3S2F8A1OHz7Yi8vrNo/MmSL1GcXfsYIMamyDYSgbwKdfDk1IS7hOxIeg+0bj4GwavZR60KMJV1PKhEyQF4Bzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697057; c=relaxed/simple;
	bh=ed96sy/6LOck+wUhbL7YfzNYa8GastaiVEYRq6cpaiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jFWpqVfVPwAEW35h2NVTvDmvRNp6yoHXhtto4JsV/XMHiTY6EIBexzUn5v1QKhH8acYFmvh2NH2XKHocf4GAhdTAnmGLg+5I97bnD6HpDpHEwwhAiZNIuDWRJteCm5tf8vGcmuGlq2rBjM0qErPq82gUxnFpXvSRuQl7wZcNIYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lws5Zyzq; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760697053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jD6ByExhZVwQlGpLHFGQjP44ok8RQvvCqWB7DPZxKZ8=;
	b=Lws5ZyzqAFII3Xwx+Pj9x0HSXMqWQ152JNcmntX8R8Z7dOcPurrfhYNaNWTwilv3vDKUdg
	jngMc0JQ51CGLQo1mhV7iqRye44c73r2w2p/Ummfp/ftXHUcuJRIk2jTktqQSvteBuwOhZ
	EuUIklBTTV9XrRGYJkDeZ0xTbAFWtvU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] Coccinelle: pm_runtime: Fix typo in report message
Date: Fri, 17 Oct 2025 12:30:30 +0200
Message-ID: <20251017103032.75686-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/Unecessary/Unnecessary/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 scripts/coccinelle/api/pm_runtime.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
index 2c931e748dda..e29ac3a87d96 100644
--- a/scripts/coccinelle/api/pm_runtime.cocci
+++ b/scripts/coccinelle/api/pm_runtime.cocci
@@ -110,5 +110,5 @@ p2 << r.p2;
 pm_runtime_api << r.pm_runtime_api;
 @@
 
-msg = "%s returns < 0 as error. Unecessary IS_ERR_VALUE at line %s" % (pm_runtime_api, p2[0].line)
+msg = "%s returns < 0 as error. Unnecessary IS_ERR_VALUE at line %s" % (pm_runtime_api, p2[0].line)
 coccilib.report.print_report(p1[0],msg)
-- 
2.51.0


