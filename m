Return-Path: <linux-kernel+bounces-824269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0424FB88894
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF1D5A0E89
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969512D7D35;
	Fri, 19 Sep 2025 09:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j3dYbaCG"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513421F790F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273588; cv=none; b=bP9cF+VDQlIMR9vfTN9xhOCtVt7P7s9Y7AntKdznDXDnJpFKSuXNoC48pw/LheZWBwuUIo05oNa/wBiwuQvp2p5Ob0S76FWh1nR1duXh8k9YYMT40AWyeKCS3fO6c9bHACEcNB/WnDielx/LBpkIzJo89+mbXKlXXUZAz1f9Bpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273588; c=relaxed/simple;
	bh=uWaAPHFGXuNVRpoNOV8NdQqH3odXMlBlmPikZ0OfNwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4uyuLFczgkY8VklqE4GZdnazucxgBgRh5kF0+OoxTCtiuqpb+pPYybCOYSsEwQm2u/vMXk2zFOxn9JTK+fwn2C81HD37awom20HDgz8QVWT0u84+LkGPQtEKYS57HrssTvGnUiduu2lOoV+kyGr/FEUEvIQbPUoI7JFs55oeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j3dYbaCG; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758273583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=faCaSfjQV/nUBWX4PLGb3evLidx3wwNG/UDcGGYNXyw=;
	b=j3dYbaCGQYuhL/Q1WjQ3xPSB1175iMBQ4JqFDDfyEmlXDK9q6bcLYGZa/wJfZGZQHpff1y
	P6d6l88TYdHSfsRscxeGvFduoeorVrd/v0xG9fBFsndOheUSMCDNQyYPkwvX4nRdtd0ZA5
	cUAVsoCYSHor80619DheRoINq3RngeI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] stm class: Remove unnecessary local variable in stm_write()
Date: Fri, 19 Sep 2025 11:19:19 +0200
Message-ID: <20250919091919.721014-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variable 'err' and the corresponding if check in stm_write()
are unnecessary. Remove them.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/hwtracing/stm/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index cdba4e875b28..f3814e4ecf23 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -602,17 +602,11 @@ static ssize_t notrace
 stm_write(struct stm_device *stm, struct stm_output *output,
 	  unsigned int chan, const char *buf, size_t count, struct stm_source_data *source)
 {
-	int err;
-
 	/* stm->pdrv is serialized against policy_mutex */
 	if (!stm->pdrv)
 		return -ENODEV;
 
-	err = stm->pdrv->write(stm->data, output, chan, buf, count, source);
-	if (err < 0)
-		return err;
-
-	return err;
+	return stm->pdrv->write(stm->data, output, chan, buf, count, source);
 }
 
 static ssize_t stm_char_write(struct file *file, const char __user *buf,
-- 
2.51.0


