Return-Path: <linux-kernel+bounces-724004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13FBAFED6D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D1867BFFE0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1B22DE217;
	Wed,  9 Jul 2025 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWtUhVeu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB15F1DFE1;
	Wed,  9 Jul 2025 15:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074189; cv=none; b=lcmVbGcD5lYArbktVSfG2DnlAYFknSUv+Ctq8QeDtydrd3YHghZK51j1Pp1I//UmKmwkNpw6QoN1p6mHzOJWiohN86YQIlInFt9/a8ois72wlXOQ7nhmG+aBGqegY6J+84WxGr74l+ozUT1gv9AzZhmJrZtMGLih/zSsxq/NFew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074189; c=relaxed/simple;
	bh=J5hfZmumX9KtMbE7muXtxOV4HLWEtKxJo5EnOpBp8uA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KW614qe2gz/8ofvVU2lUdCDvmiIG/Z/kYw3l7h48EXdsKpuOFRvTpKY2wTkZJj+Hq5udEmuXxuJDlvDMFBk2RTCI7oNDi65nW3p2A0JGYPdwfjOcstdVriHyxzUj/fxwoNSZSQwatFybaA2Re53oETEY+POKBX1LqIrw0CanntA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWtUhVeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327FDC4CEEF;
	Wed,  9 Jul 2025 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752074188;
	bh=J5hfZmumX9KtMbE7muXtxOV4HLWEtKxJo5EnOpBp8uA=;
	h=From:To:Cc:Subject:Date:From;
	b=RWtUhVeu2X5PkidsChJmze4/U/Uk4MqV7X8p3GSnkyNVVaFApWfvI6eT50fZetVSJ
	 12myGis11lBzWbxA2gWjBZPM8arIGYUm6/nWmEkADbNI0wngcXHr8/UZ9/C+9lNUO/
	 +JSCUBlPNlSSW8OMUV8UXlH7VaV1dsxYrg5YOgxKlhr9swUJGY679LuQiKvRNF7tp0
	 BVmjqqFbGOuvlX4xqxTFyBFaI5oFw/KmWJ6DMphPYMKhDAxu39CKjZPk8vCZellHD4
	 HV15MrjOfaSmIKr4DHy1wd69YSZEXtoLza8ku0B4dRji4XLZPUzrrTK6iZ1WvjqFhr
	 RNWgt+FWjsOXQ==
From: Arnd Bergmann <arnd@kernel.org>
To: "David E. Box" <david.e.box@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/intel/pmt: fix format string in unit test
Date: Wed,  9 Jul 2025 17:16:19 +0200
Message-Id: <20250709151624.1229088-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Another warning about incorrect format strings shows up in the unit test

In file included from include/kunit/assert.h:13,
                 from include/kunit/test.h:12,
                 from drivers/platform/x86/intel/pmt/discovery-kunit.c:9:
drivers/platform/x86/intel/pmt/discovery-kunit.c: In function 'validate_pmt_regions':
include/linux/kern_levels.h:5:25: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]

Fixes: b9707d46a959 ("platform/x86/intel/pmt: KUNIT test for PMT Enhanced Discovery API")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/intel/pmt/discovery-kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
 
-- 
2.39.5


