Return-Path: <linux-kernel+bounces-832709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A43BBA024A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F7B5E2D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B772F0699;
	Thu, 25 Sep 2025 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TEvzXx6e"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA232E284B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758812649; cv=none; b=DYtpEOwYPMoWzBHCt+r6Vc8ifcJ9QB6WmUF0RdmdK2ko7uYaG48dfVfWVxSZOeWQdCehwY6R0Qvn5CuS25JFNexVER/FNf8DknrVgxHHsg/mo1eF5dMK2oI6FLMLrLNeegLUkVtnnpugUvpXjsAkYcUXKEJEEcXuwS9zIAuvX4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758812649; c=relaxed/simple;
	bh=tDau7Z+nk2acTzxWhsEJO3psQ296tGp1GHVngSyH9O4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SkQTgaB4WdSQ2QenEixxozQQ/bFMkWkZU+dvAIuM9K/52fYklyc8+jVzPPaA6z5B5nSfEfrmkW2y/41CWPDvCgcE5xFVJoactYPXJd36v++Mb0Rn4Vnff3WXV3lRpU3xN8rZMxKgOM7B7pGfKwLycYhR0kPHCzRuMJknOJqIJ3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TEvzXx6e; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758812641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQfOvvpVeHu2haioKIlLlNw0O7AmtYvMNB5o/K0IIVw=;
	b=TEvzXx6ei1B2c2+lW41m/X5MmbR4yRgiJMJajXSQOD3eyLHfhNLjUBheaWJ4BRRgKowzCF
	6vtBucMjyQX2Wg6Okh2aoaWddHg6oh+NOENuVQ9+jXEAx8Y3kL68YL4gw7q5J1T9TZ2yeW
	P4BVhqE1ZN/ZscO/zpB7S39g2BLxpf4=
From: Sean Anderson <sean.anderson@linux.dev>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Linu Cherian <lcherian@marvell.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v5 2/3] coresight: Reorder coresight_device_release to match coresight_register
Date: Thu, 25 Sep 2025 11:03:41 -0400
Message-Id: <20250925150342.1845615-3-sean.anderson@linux.dev>
In-Reply-To: <20250925150342.1845615-1-sean.anderson@linux.dev>
References: <20250925150342.1845615-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

To make it easier to determine where to add new release actions, reorder
the actions in coresight_device_release to be the reverse of
coresight_register.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v5:
- New

 drivers/hwtracing/coresight/coresight-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 022c8384b98d..305b1773cfbe 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1046,8 +1046,8 @@ static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	fwnode_handle_put(csdev->dev.fwnode);
 	free_percpu(csdev->perf_sink_id_map.cpu_map);
+	fwnode_handle_put(csdev->dev.fwnode);
 	kfree(csdev);
 }
 
-- 
2.35.1.1320.gc452695387.dirty


