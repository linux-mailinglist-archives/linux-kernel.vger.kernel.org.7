Return-Path: <linux-kernel+bounces-806738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C314B49B28
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664571BC230C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3D42DAFDA;
	Mon,  8 Sep 2025 20:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jg/+o7q9"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78C41C863B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757364170; cv=none; b=YX+G0Qz7guaeadKou4ZhK2EuEj2Ed3l39qId1dC40izJd3oe0ZY+PYGkm07+XLVKREzbnZbn8lPSgzzIh2zyAJbDiPDrzKnvkGLWg/OcngyxEiw915CEVb0lMw/Msh6jqXq16x3rkskRoXOcmlZwI6XEtYIqyIUMtbA7vdQJmH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757364170; c=relaxed/simple;
	bh=ed96sy/6LOck+wUhbL7YfzNYa8GastaiVEYRq6cpaiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lILsUQwtvNDXgDbveXN6qr49BuHrqRFm/S+3WgmDwbh99zpNRgeDrLCCdeQLp1By+x9lyVuoVdOJl8H7Fc7l/8nTPPUa2lr2fDz+r0VRaRGKwWunEPsNf9K0UZVZEOKYjmUE3o38UQLWid/Sv9huFNd2tc1Ras9rAEhBsZjvnyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jg/+o7q9; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757364166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jD6ByExhZVwQlGpLHFGQjP44ok8RQvvCqWB7DPZxKZ8=;
	b=jg/+o7q9dj/+8g+9xTe/qdOqGgLHCUcmMv5/6CNKBrTiX2j8yuA1no+qEOhGceuPG9+1q1
	5DMxdPdExMhbky7lRx/X07zWWx0/rSc0JA+Dr6L/RWOOG/SGrMdsnHnrl8/BCyr3/DXyPi
	iShxSJDuQ4DEIONvkTi7Zldnc6bnUTA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Coccinelle: pm_runtime: Fix typo in report message
Date: Mon,  8 Sep 2025 22:42:23 +0200
Message-ID: <20250908204225.476116-2-thorsten.blum@linux.dev>
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


