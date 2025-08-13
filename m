Return-Path: <linux-kernel+bounces-767121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C4AB24F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C000E8871F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD6F28DB54;
	Wed, 13 Aug 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QJahM31N"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD9E28C87F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101791; cv=none; b=BbNQA+usCIZN9gOgjvG7tuADZSqgmcIoEUzeJESrxAJuTstdz5aGnfHu3lnEHYWDNUvvSZ8LHZdeqJM5bo4DQXIzURaVjUDAnohIo6jZc2Z6oz9uCwp51PPePXFV9BprgU9vt4FybizLeJOw9JJxbgX1PL4T4Qvkz+RzXmHfC1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101791; c=relaxed/simple;
	bh=Z/o3eVRAhjg3zg+YMi0jkrdoU2NRkcKKC/GZrmM+ixM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KwloW75iU75q3QHaZaeR7yfaCDdqzx/+qIeX5WTzS9Da/W2o5dc5Uw5D01aUX782r7NPUhpzt7tq06SedXBmPTfWBQQAlr6znZwaWiWjLNmocA1vQXS04tgioNrIg3ws+F0rME23p76AE20x7OOsM+FfafZzeRDG96odiDepdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QJahM31N; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=bbqsATwslvwcrZI4jH0+pTwbKStYeQzxGNHoM31ee0Q=; b=QJahM3
	1NkEZxA+fITld7X5Xljl4MerPsi/VQkyCIA4NphgNiQzdx+2iiAIn4pQGrfD03vr
	OSJWlcW7wMMwEI3T7JQHP9vCXjbgq3bPhtzHjYIBdGGysVbQGsgrLJIgl8SSk6zD
	ZRRAnbh9I5AQqG0RxSMLsGWxbyov3rcdd+0IU+yqRIXOYQepiFWtKFgECMbrDTjM
	uCroJdsKLTb04gRdD4uD1ApoUITCeFdixIRHmDivYZwlqYc1IQqmP2tTdh6AufDv
	DYp05mXq8tJ4snCG6W3SyrU8iygzpzAqoLBIVs0Qtw4eixLspI4uvhp0BN28LJ+S
	0uU0ex1tfiIEmO0Q==
Received: (qmail 695094 invoked from network); 13 Aug 2025 18:16:15 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:16:15 +0200
X-UD-Smtp-Session: l3s3148p1@2UnSeUE8ItttKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH 10/21] mmc: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:14:56 +0200
Message-ID: <20250813161517.4746-11-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/mmc/host/sdhci_am654.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index e4fc345be7e5..8a099508b939 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -95,7 +95,6 @@ static const struct regmap_config sdhci_am654_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.fast_io = true,
 };
 
 struct timing_data {
-- 
2.47.2


