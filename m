Return-Path: <linux-kernel+bounces-808958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB5FB506D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C771BC1328
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7806C30103D;
	Tue,  9 Sep 2025 20:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="Ow3+Zk7L"
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FB035FC19;
	Tue,  9 Sep 2025 20:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448948; cv=none; b=swYAia0m/E1W7FL4VISwJI6FtWqWKU0Cr+e8OWlLz8E5JY/M1uhRTVC5kB15w5b2e6yWOfWvjqOPcScGiIZsrTd/JQb2zAyddT4X249338LVzkkmefbftn54q1gAFIiPXv9zE8Mel2urzGx7b/FLsXoB0+qWNBpe23RvzqBIiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448948; c=relaxed/simple;
	bh=GPLuHr63xpc9t6vpltdLrLVFbKIQahiI+2XFr9M6QF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2VtZMPdP9Ly7MjIemhy9npWQE17I0gCVtrathXxgi4cISSxSGM8eo+vqWkwapiRaaqCe5HfJhcEfWg4yhiSiKL4Z1tjE5HC/u7TASJ0/MbkSf0DnXOBdA5vY2SAkECUr+umYrs045oOt26LpALd4PYktg+QyeXlWTG1peelgxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=Ow3+Zk7L; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 817A1C01A8;
	Tue, 09 Sep 2025 23:15:45 +0300 (MSK)
Received: from localhost.localdomain (172.31.115.73-vpn.dhcp.yndx.net [172.31.115.73])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id IFQqlX5GteA0-fGTTr1hW;
	Tue, 09 Sep 2025 23:15:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1757448945;
	bh=SlubtQeQpBHXlVAu20qfBqsbGkV3gCqQjvicv97NAqE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=Ow3+Zk7LzrqdqvKvZDbmFyysZMtA7DN68cVIb+B3JSmGFhVLFAPCiOp0Wj9AxagDy
	 ChCIy5Wz0HngB7CVKrHaa2WeO2/0cYVyStkQFIrSE81CIlPTYWzzUhwHU8HNNv6Ivj
	 Ib9YHJbY8VPMhFXHrGvwikRHwrHctRkIYIv49A+A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v3 5/7] kstate, test: add test module for testing kstate subsystem.
Date: Tue,  9 Sep 2025 22:14:40 +0200
Message-ID: <20250909201446.13138-6-arbn@yandex-team.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250909201446.13138-1-arbn@yandex-team.com>
References: <20250909201446.13138-1-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is simple test and playground useful kstate subsystem development.
It contains some structure with different kind of data which migrated
across kexec to the new kernel using kstate.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 MAINTAINERS               |   1 +
 include/linux/kstate.h    |   2 +
 kernel/liveupdate/Kconfig |   8 +++
 lib/Makefile              |   2 +
 lib/test_kstate.c         | 116 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+)
 create mode 100644 lib/test_kstate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cd9e49abee5..e96da6d97e75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13723,6 +13723,7 @@ M:	Andrey Ryabinin <ryabinin.a.a@gmail.com>
 S:	Maintained
 F:	include/linux/kstate.h
 F:	kernel/livupdate/kstate.c
+F:	lib/test_kstate.c
 
 KTD253 BACKLIGHT DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
diff --git a/include/linux/kstate.h b/include/linux/kstate.h
index 5a95960e5b03..0ced0da37c8f 100644
--- a/include/linux/kstate.h
+++ b/include/linux/kstate.h
@@ -95,6 +95,8 @@ struct kstate_field {
 enum kstate_ids {
 	KSTATE_FOLIO_ID = 1,
 	KSTATE_KHO_FDT_ID,
+	KSTATE_TEST_ID,
+	KSTATE_TEST_ID_V2,
 	KSTATE_LAST_ID = -1,
 };
 
diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index b6ea861006bf..af9a25bdcd6e 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -69,6 +69,14 @@ config KSTATE
 	  state, save it into the memory and restore the state after kexec
 	  in new kernel.
 
+config KSTATE_TEST
+	bool "KSTATE test code"
+	help
+	  Build a simple test/playground code that is useful for kstate
+	  subsystem development. It contains some structure with different
+	  kind of data which migrated across kexec to the new kernel
+	  using KSTATE.
+
 config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
diff --git a/lib/Makefile b/lib/Makefile
index 392ff808c9b9..46616577caf3 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -316,6 +316,8 @@ obj-$(CONFIG_PARMAN) += parman.o
 
 obj-y += group_cpus.o
 
+obj-$(CONFIG_KSTATE_TEST) += test_kstate.o
+
 # GCC library routines
 obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
 obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
diff --git a/lib/test_kstate.c b/lib/test_kstate.c
new file mode 100644
index 000000000000..70534e8c718f
--- /dev/null
+++ b/lib/test_kstate.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) "kstate test: " fmt
+#include <linux/io.h>
+#include <linux/kexec_handover.h>
+#include <linux/kstate.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+
+static unsigned long ulong_val;
+struct kstate_test_data {
+	int i;
+	unsigned long *p_ulong;
+	char s[10];
+	struct folio *folio;
+};
+
+#define KSTATE_TEST_DATA_ID 123
+
+struct kstate_description test_state_v2 = {
+	.name = "test_v2",
+	.version_id = 1,
+	.id = KSTATE_TEST_ID_V2,
+	.fields = (const struct kstate_field[]) {
+		KSTATE_BASE_TYPE(i, struct kstate_test_data, int),
+		KSTATE_END_OF_LIST()
+	},
+};
+
+struct kstate_description test_state = {
+	.name = "test",
+	.version_id = 2,
+	.id = KSTATE_TEST_ID,
+	.fields = (const struct kstate_field[]) {
+		KSTATE_BASE_TYPE(s, struct kstate_test_data, char [10]),
+		KSTATE_POINTER(p_ulong, struct kstate_test_data),
+		KSTATE_FOLIO(folio, struct kstate_test_data),
+		KSTATE_BASE_TYPE_DEPRECATED(k, u16, 1),
+		KSTATE_END_OF_LIST()
+	},
+	.subsections = (const struct kstate_description *[]){
+		&test_state_v2,
+		NULL
+	},
+};
+
+static struct kstate_test_data test_data;
+
+static int init_test_data(void)
+{
+	struct folio *folio;
+	int i;
+
+	test_data.i = 10;
+	ulong_val = 20;
+	memcpy(test_data.s, "abcdefghk", sizeof(test_data.s));
+	folio = folio_alloc(GFP_KERNEL, 0);
+	if (!folio)
+		return -ENOMEM;
+
+	for (i = 0; i < folio_size(folio)/sizeof(u32); i += 4)
+		*((u32 *)folio_address(folio) + i) = 0xdeadbeef;
+	test_data.folio = folio;
+	return 0;
+}
+
+static void validate_test_data(void)
+{
+	int i;
+
+	if (WARN_ON(test_data.i != 10))
+		return;
+	if (WARN_ON(*test_data.p_ulong != 20))
+		return;
+	if (WARN_ON(strcmp(test_data.s, "abcdefghk") != 0))
+		return;
+
+	for (i = 0; i < folio_size(test_data.folio)/4; i += 4) {
+		u32 val = *((u32 *)folio_address(test_data.folio) + i);
+
+		if (WARN_ON_ONCE(val != 0xdeadbeef))
+			return;
+	}
+}
+
+static int __init test_kstate_init(void)
+{
+	int ret = 0;
+
+	test_data.p_ulong = &ulong_val;
+
+	ret = kstate_register(&test_state, &test_data, KSTATE_TEST_DATA_ID);
+	if (ret) {
+		pr_err("register failed %d\n", ret);
+		goto out;
+	}
+
+	if (!is_kho_boot()) {
+		ret = init_test_data();
+		if (ret)
+			goto out;
+	} else {
+		pr_info("restoring data\n");
+		ret = kstate_restore(&test_state, &test_data, KSTATE_TEST_DATA_ID);
+		if (ret) {
+			pr_err("restore failed %d\n", ret);
+			goto out;
+		}
+
+	}
+
+	validate_test_data();
+
+out:
+	return ret;
+}
+late_initcall(test_kstate_init);
-- 
2.49.1


