Return-Path: <linux-kernel+bounces-751837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9720B16E15
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 11:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F361AA7FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057FA28F520;
	Thu, 31 Jul 2025 09:02:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD34428D8E1
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952572; cv=none; b=SppcAOpCW4vpOREc7ZHPuzAPjbjMlKnPcpOcRUmNE0XWKFccGc7Dd7PK8iB2rnA6/jBjMrpyFKLhgsMhLuTv8+QCIlsRM/jx9kj/L8iX1iT9248S4EJcOP2QuZ0u4R4SU/0LmD8oHFjf90CaEXScv8VjRrMADhr1+F14q6yPOgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952572; c=relaxed/simple;
	bh=F+y61gsUMAmZYcwZ60ImnU6Lx7hjWXMO7ut87ZX0g5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hjNf+9JdyHs7hmtJNixnGOlhEFARFhbpTt+LioiY8qW7Giiw1Cya9KbnnPNKMCL+eo08UPIGIDRQl7ZKtfVHbdc8Rbgsz4PN7PHOYgBljGP1gPAk1avmnsyzTPxwZDm0qQlh+1MKvNlFuNCI4zFuprJLPA45bSlELhW8b3JkHxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4607A1D13;
	Thu, 31 Jul 2025 02:02:42 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A62AB3F66E;
	Thu, 31 Jul 2025 02:02:48 -0700 (PDT)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org
Cc: kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH] kasan: disable kasan_strings() kunit test when CONFIG_FORTIFY_SOURCE enabled
Date: Thu, 31 Jul 2025 10:02:46 +0100
Message-Id: <20250731090246.887442-1-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_FORTIFY_SOURCE is enabled, invalid access from source
triggers __fortify_panic() which kills running task.

This makes failured of kasan_strings() kunit testcase since the
kunit-try-cacth kthread running kasan_string() dies before checking the
fault.

To address this, skip kasan_strings() kunit test when
CONFIG_FORTIFY_SOURCE is enabled.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 mm/kasan/kasan_test_c.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index 5f922dd38ffa..1577d3edabb4 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -1576,6 +1576,12 @@ static void kasan_strings(struct kunit *test)
 	 */
 	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_AMD_MEM_ENCRYPT);

+	/*
+	 * Harden common str/mem functions kills the kunit-try-catch thread
+	 * before checking the fault.
+	 */
+	KASAN_TEST_NEEDS_CONFIG_OFF(test, CONFIG_FORTIFY_SOURCE);
+
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


