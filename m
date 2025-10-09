Return-Path: <linux-kernel+bounces-847273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D4CBCA6A8
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 779E14E3B40
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC05246BD7;
	Thu,  9 Oct 2025 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QRt+3ZSM"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DC9242D84
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031954; cv=none; b=nSyon9I/g36CItsrTNsUIX5pSTaMqooEh0xlSAhgRhozwZvIWsClbJQn0/L0MlFhWA4FgTLR9hlrmzg3xs9OCZ1r8+zYSjUJ2VCxP++IaD76LFNpM4CKgj1AbnsJ85YioztGdc6b8G/Vxx2pLPXF+dYPBO3N9QSkQQiq+UjXeiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031954; c=relaxed/simple;
	bh=3nrZtSjEUdo+gvM5rjuHujG2OApFGvCEvez3yDp+qfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ap0PcfXWvB+5tiFUBpsaJNNohuCIpYeBr0zYLp49OrbyXyQz2gp33EB7Gm/neve/5S87crZSuOehKjwQd9TraIvUzSJEoVl9dgfwuyFs++5xCt0oYfpUKisyPc6V1BdsfR6XkDcFxsDnnehMu+ago12DyhGHcSm/JvWRB4rL8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QRt+3ZSM; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760031939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mf0fe+UIwSYw3cvFDgqawJqRgyD2tHm+Y7POs9z4DxM=;
	b=QRt+3ZSMs1N9xuhmzQ/aPAruimTd0J97C+SwVsUVALmSZiJ2TFupXoNmbiM6mZTC2OAK9S
	0fhYM0Myq5GtJAaGzkpvxUhFLoSPM9K8JLJwHiZsTc2mVlCdqP2kSHWop7rcIUWswBQEEo
	Dc2y4FA8bI2NF99qe1Or3aDBZupRiW4=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	zhangheng <zhangheng@kylinos.cn>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] w1: ds28e17: Replace deprecated strcpy + strcat in w1_f19_add_slave
Date: Thu,  9 Oct 2025 19:45:12 +0200
Message-ID: <20251009174519.393898-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated and using strcat() is discouraged. Replace them with
scnprintf().  No functional changes.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/w1/slaves/w1_ds28e17.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds28e17.c b/drivers/w1/slaves/w1_ds28e17.c
index 5738cbce1a37..e53bc41bde3c 100644
--- a/drivers/w1/slaves/w1_ds28e17.c
+++ b/drivers/w1/slaves/w1_ds28e17.c
@@ -719,8 +719,8 @@ static int w1_f19_add_slave(struct w1_slave *sl)
 	data->adapter.owner      = THIS_MODULE;
 	data->adapter.algo       = &w1_f19_i2c_algorithm;
 	data->adapter.algo_data  = sl;
-	strcpy(data->adapter.name, "w1-");
-	strcat(data->adapter.name, sl->name);
+	scnprintf(data->adapter.name, sizeof(data->adapter.name), "w1-%s",
+		  sl->name);
 	data->adapter.dev.parent = &sl->dev;
 	data->adapter.quirks     = &w1_f19_i2c_adapter_quirks;
 
-- 
2.51.0


