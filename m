Return-Path: <linux-kernel+bounces-861446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A5DBF2C11
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D164D4669D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B4E23E342;
	Mon, 20 Oct 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QxIn9JYZ"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F0833290F
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981864; cv=none; b=V21Oz5KyP7cZrPBySgbbtQCu5dR4hYWI0qLOsdt/Bfze2CQEquRCNVGiv1K4+uOp63J7pZEj/iXQTGtiTohYXL1MXFtLtrlUpq3j39qgUwIsAPNVpnvCjVaqKPH5swNT6GDCONqHt5TihEjB0Ghfsih04o0w8JfP/0PNooGc9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981864; c=relaxed/simple;
	bh=FiHGmwdBwVR/sRz6y0ycYrb9d7slvFW+tg3Xp4afyXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qnEVQUjdbrplACdtLNlJb2ZU2UKaXRgO+qMlIW2br7V09jhZI7xynE2hynQtaAJ9WOmfR7gdH7g7V7bRZfdh2Ut8A9gLl33szcUt4PYyRPwCSANsd1TYq0eiDYxcpre7ouSVg7VIYhWvtztch/DcGJmiK/trHkNtIP7eb+abHPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QxIn9JYZ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760981860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4rVSGBCtSy89lZttTJhMvxUpt4m7QbtSAFqB7k1HQE=;
	b=QxIn9JYZ+lKJcKSBvvTsP/8fM4YAJ7JUDEZVk5D/6ME/tRzVM2k9cMQDaJm+hb1QbzugtB
	N22CbomleL4QnQxv3g4yaX1XAiYTuF0xlzaq+sqTFbiAY6PqrbE0pChZGr8XKZFxy+QbBw
	ycHjne9PXjmEcDcPg4Njiz/lZ3P9CCE=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <pierre.gondois@arm.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 07/10] cacheinfo: Initialize variables in fetch_cache_info()
Date: Tue, 21 Oct 2025 01:36:21 +0800
Message-Id: <20251020173624.20228-8-wen.yang@linux.dev>
In-Reply-To: <20251020173624.20228-1-wen.yang@linux.dev>
References: <20251020173624.20228-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Pierre Gondois <pierre.gondois@arm.com>

[ Upstream commit ecaef469920fd6d2c7687f19081946f47684a423 ]

Set potentially uninitialized variables to 0. This is particularly
relevant when CONFIG_ACPI_PPTT is not set.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/all/202301052307.JYt1GWaJ-lkp@intel.com/
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/all/Y86iruJPuwNN7rZw@kili/
Fixes: 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20230124154053.355376-2-pierre.gondois@arm.com
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 drivers/base/cacheinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index cd943d06d074..26ae36f2ff58 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -440,7 +440,7 @@ int allocate_cache_info(int cpu)
 int fetch_cache_info(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci;
-	unsigned int levels, split_levels;
+	unsigned int levels = 0, split_levels = 0;
 	int ret;
 
 	if (acpi_disabled) {
-- 
2.25.1


