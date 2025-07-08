Return-Path: <linux-kernel+bounces-722544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3A2AFDBE8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68631C23FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC5723770D;
	Tue,  8 Jul 2025 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iety5ptW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74E223DF5;
	Tue,  8 Jul 2025 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752018084; cv=none; b=iIw1c0y3kpRhGee+cUyCY9OUid7ROokFCwVLGBhAu2JZkwSaVAS2QIGFssLJENziHNJhP0UWyToFnxFHuQB0M4aK18B6Rhmdj6Jh2bh/Wd7+1Epms5bcVmLY1kd+Njn42z1jDTZJABs8whjAWkI4+dkcRFA/2Q/ZJSuJGjYWEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752018084; c=relaxed/simple;
	bh=gjvuPMDAEGBM+MgPjQyQtXwPygyNMFei5YKp9m4Oods=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=I9dDaVuJ+YwSRiRYghSNA07Zbpri+di+XOHomXLHazsmcgTFIK38kirG7P7VI6u/hY8SrOKY3UnzwWgB43yLLQFv1ni3A4oQIKFOC5yAFZLQIEFUkt+Cn+j8oxU5q5D3thgf4esldB2PRWBw6yJiUlqPC2JQTWk+0NZKVhFUO4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iety5ptW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DF1C4CEED;
	Tue,  8 Jul 2025 23:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752018084;
	bh=gjvuPMDAEGBM+MgPjQyQtXwPygyNMFei5YKp9m4Oods=;
	h=From:Date:Subject:To:Cc:From;
	b=Iety5ptWAkzSP9haKVL8gXlgGrEQfau84nIpIRVrwXjR+ICCl28xTs4gdikrc6lTT
	 vr+ANlzZjf+E2wKLlXi2jWkgjyadYOHEbRMhWcM342cxZ4AlY0mr6XIbvmtde5WRti
	 WuMAfMyah8rmWfA9eQlZXeVc3Zsz6H7pMMnxNY/uij52R9WoXqSEjbFM9VRnFU4aAh
	 JNkx+sK31wMBmfQNuVFJjCKrGYOjgCJ484iDi9mXfJ5XVQTemTIxxlun/sE4U4azZd
	 ktHGUzSkY1NotVUvLjOufKbd9Fy9zalrhg1E4iXhEjzI8M1qH48FeObRk5ioT9Ei/w
	 LUsx9MuAOOMhg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 08 Jul 2025 16:41:01 -0700
Subject: [PATCH] platform/x86/intel/pmt/discovery: Fix size_t specifiers
 for 32-bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-discovery-pmt-fix-32-bit-formats-v1-1-296a5fc9c3d4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIysbWgC/x2NQQqDQAxFryJZG0hntHa8SunCaqpZ6Egi0iLev
 cHde/D4/wBjFTZoiwOUdzHJi8utLKCfumVklMEdAoWaGnrgINbnnfWH67zhR74YA77FMevcbYb
 xnmJDVZ0iJfCZVdmr6+L5Os8/L1R7VXIAAAA=
X-Change-ID: 20250708-discovery-pmt-fix-32-bit-formats-369370459309
To: "David E. Box" <david.e.box@linux.intel.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4000; i=nathan@kernel.org;
 h=from:subject:message-id; bh=gjvuPMDAEGBM+MgPjQyQtXwPygyNMFei5YKp9m4Oods=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBm5axZVyjvZHXi7/7Rk+SpJLZ2qh3ohG+zMdKS3c+gp7
 rsnInOmo5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAExk5gaG/5l7ZknGqRYtXVZ9
 Mdnpz7Lar+YKgapLpb93PFC83r/M2Ynhf0al+NVWo9bKGcsaJr28WvtHLm2HglbsLo27r5ZYdIo
 +4QEA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When building i386 allmodconfig, there are two warnings in the newly
added discovery code:

  drivers/platform/x86/intel/pmt/discovery.c: In function 'pmt_feature_get_feature_table':
  drivers/platform/x86/intel/pmt/discovery.c:427:35: error: format '%ld' expects argument of type 'long int', but argument 2 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
    427 |         if (WARN(size > res_size, "Bad table size %ld > %pa", size, &res_size))
        |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~  ~~~~
        |                                                               |
        |                                                               size_t {aka unsigned int}
  ...
  drivers/platform/x86/intel/pmt/discovery.c:427:53: note: format string is defined here
    427 |         if (WARN(size > res_size, "Bad table size %ld > %pa", size, &res_size))
        |                                                   ~~^
        |                                                     |
        |                                                     long int
        |                                                   %d

  drivers/platform/x86/intel/pmt/discovery-kunit.c: In function 'validate_pmt_regions':
  include/linux/kern_levels.h:5:25: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
  ...
  drivers/platform/x86/intel/pmt/discovery-kunit.c:35:17: note: in expansion of macro 'kunit_info'
     35 |                 kunit_info(test, "\t\taddr=%p, size=%lu, num_rmids=%u", region->addr, region->size,
        |                 ^~~~~~~~~~

size_t is 'unsigned long' for 64-bit platforms but 'unsigned int' for
32-bit platforms, so '%ld' is not correct. Use the proper size_t
specifier, '%zu', to resolve the warnings on 32-bit platforms while not
affecting 64-bit platforms.

Fixes: d9a078809356 ("platform/x86/intel/pmt: Add PMT Discovery driver")
Fixes: b9707d46a959 ("platform/x86/intel/pmt: KUNIT test for PMT Enhanced Discovery API")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/platform/x86/intel/pmt/discovery-kunit.c | 2 +-
 drivers/platform/x86/intel/pmt/discovery.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/pmt/discovery-kunit.c b/drivers/platform/x86/intel/pmt/discovery-kunit.c
index b4493fb96738..f44eb41d58f6 100644
--- a/drivers/platform/x86/intel/pmt/discovery-kunit.c
+++ b/drivers/platform/x86/intel/pmt/discovery-kunit.c
@@ -32,7 +32,7 @@ validate_pmt_regions(struct kunit *test, struct pmt_feature_group *feature_group
 		kunit_info(test, "\t\tbus=%u, device=%u, function=%u, guid=0x%x,",
 			   region->plat_info.bus_number, region->plat_info.device_number,
 			   region->plat_info.function_number, region->guid);
-		kunit_info(test, "\t\taddr=%p, size=%lu, num_rmids=%u", region->addr, region->size,
+		kunit_info(test, "\t\taddr=%p, size=%zu, num_rmids=%u", region->addr, region->size,
 			   region->num_rmids);
 
 
diff --git a/drivers/platform/x86/intel/pmt/discovery.c b/drivers/platform/x86/intel/pmt/discovery.c
index e72d43b675b4..1a680a042a98 100644
--- a/drivers/platform/x86/intel/pmt/discovery.c
+++ b/drivers/platform/x86/intel/pmt/discovery.c
@@ -424,7 +424,7 @@ pmt_feature_get_feature_table(struct pmt_features_priv *priv,
 	size = sizeof(*header) + FEAT_ATTR_SIZE(header->attr_size) +
 	       PMT_GUID_SIZE(header->num_guids);
 	res_size = resource_size(&res);
-	if (WARN(size > res_size, "Bad table size %ld > %pa", size, &res_size))
+	if (WARN(size > res_size, "Bad table size %zu > %pa", size, &res_size))
 		return -EINVAL;
 
 	/* Get the feature attributes, including capability fields */

---
base-commit: 56036d6af41a473a8129fc960a5ab3673eda13d5
change-id: 20250708-discovery-pmt-fix-32-bit-formats-369370459309

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


