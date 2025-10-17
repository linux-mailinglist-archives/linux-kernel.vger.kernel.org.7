Return-Path: <linux-kernel+bounces-858320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFBFBEA8CB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49E0940BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E5F32C93E;
	Fri, 17 Oct 2025 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EzKCTc+C"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC178332907
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715266; cv=none; b=CFInhRlfnbPsttQDIDgphCNp/n6uV43+b1jIEA+8Y4Y1bWpy075USVqQLZDy6kx334v2UYsHoqKfwjfDOAECrkljwJ6kTAaN2xfHkmdVLV15swrRayVm3NQfLjcG5RLhsNHrjtRaHF4XwO4PSy3b+0JhMvqhf10203S7Y9mL1SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715266; c=relaxed/simple;
	bh=hIH8QsiqeXv72GRmxBr/rX2xeu7w44knK028WD5AoSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1w7sL9ntXexKZYXM7wsESQJrS25RwCw8jqk0ZRJ8hEt/ixnS0pWCOPTivusKg0S9tYFtaZidhtby4lNm6AK+tr0E7ERCyxSYuyCU/voz5ABbbUmwVJUI5opiyaYzbwY7oswkOQKfpuuuqNGYZshT3TWeizjWDSQ/+hgv2Fn/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EzKCTc+C; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760715261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nJwvRv6dMoUoyTETozUE5MnUM4OdGxrB2ilGTiyql9M=;
	b=EzKCTc+CqXmcddIdxWThNfEJ4KHqzAwU0ajC8Pc6otQtY/RKiKVxyNCLfzLOyW9nYJ5N0w
	nrnhJBseClpbHZRlphvUxKPXobmZ3GPE09Z6WHYynpYJITI13BpgAik/c0oofRo09/NNQf
	jiAFHkTbGYrejNY4utnw9b0ove7djbw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Replace deprecated strcpy in cpufreq_unregister_governor
Date: Fri, 17 Oct 2025 17:33:54 +0200
Message-ID: <20251017153354.82009-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; assign the NUL terminator directly instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 852e024facc3..0d3e77cf96a7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2550,7 +2550,7 @@ void cpufreq_unregister_governor(struct cpufreq_governor *governor)
 	for_each_inactive_policy(policy) {
 		if (!strcmp(policy->last_governor, governor->name)) {
 			policy->governor = NULL;
-			strcpy(policy->last_governor, "\0");
+			policy->last_governor[0] = '\0';
 		}
 	}
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
-- 
2.51.0


