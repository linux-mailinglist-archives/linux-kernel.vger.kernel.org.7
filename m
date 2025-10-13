Return-Path: <linux-kernel+bounces-850576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A9EBD3351
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938853C6F36
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED5C306B14;
	Mon, 13 Oct 2025 13:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uiBM0sns"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E234BA4D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760362057; cv=none; b=rYnpYV0/xhnLMJvmghBmozTjyZEqDfSrop381oB40frGv94w8qHnEVIgLcATfIuaJQEt++3C/Uygc7Ffbyeml7Z7OQdg6Yntf2mBujAHJlBubaRtebBXlgJP8v1IYSuftWPhJKvFNO4fgzGTbeP944twXAFzm2RWPuQ5Ooebcfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760362057; c=relaxed/simple;
	bh=XRiNYief/IEvSm/SxnJ3REEILG4WjhTmot/8iaoEjG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dlAiVlrEsjVc5KcFxVuvpVc9G3DqKQMS3yX39EcIq12Jv2h7i386ycH2aUzEmhuHpaJnaMmZwM1KrzBnvxnfuWg+wS1lGsHoFSp0ujkqucPULSdM26RdfXyZLTtcL70tlwgwsA9qtj9AqsuShgUJ7aWdKMUdjPZBt2dGAgbsDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uiBM0sns; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760362053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=azrrm5X17by/tgEO5KTP64W2twBn0KTK7kQ1jsx7wZM=;
	b=uiBM0sns61V5tVIBHUadYVxtVzrxxA63MLsei/1o5w44eW/FRCFIsrsshCgcZHc8CB5/JW
	6kbMmMZ7BV78C42Z7HY7X7ewcWy8PoMUpteJ50P7RCgeCJw914frzyEsMZIRpigKLeOeHH
	6j25EfYa04rqc00aHaYEREbryVOePEs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] init: Replace simple_strtoul with kstrtoul to improve lpj_setup
Date: Mon, 13 Oct 2025 15:27:06 +0200
Message-ID: <20251013132708.31923-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace simple_strtoul() with the recommended kstrtoul() for parsing the
'lpj=' boot parameter.

Check the return value of kstrtoul() and reject invalid values. This
adds error handling while preserving existing behavior for valid values,
and removes use of the deprecated simple_strtoul() helper.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 init/calibrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/calibrate.c b/init/calibrate.c
index f3831272f113..09c2e6102110 100644
--- a/init/calibrate.c
+++ b/init/calibrate.c
@@ -14,10 +14,10 @@
 
 unsigned long lpj_fine;
 unsigned long preset_lpj;
+
 static int __init lpj_setup(char *str)
 {
-	preset_lpj = simple_strtoul(str,NULL,0);
-	return 1;
+	return kstrtoul(str, 0, &preset_lpj) == 0;
 }
 
 __setup("lpj=", lpj_setup);
-- 
2.51.0


