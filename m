Return-Path: <linux-kernel+bounces-768390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A19B2609E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A46851CC214F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C5B2D321F;
	Thu, 14 Aug 2025 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShgqzQ75"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0B2E7BD3;
	Thu, 14 Aug 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162783; cv=none; b=fzO67sQf5NmwMIck7opRAoH2bIOkG0hQ9RskyY8NT4MBxc1mpt5P/awpjvcprUrUz3/JL+rATHaek8OWUscyEgHZ+Synp8MZy7hOdo23m+K4MBL0S1azfhvYh4PfGYyGC6a2M9+VVwtUbj9BDMOuYUj63cxNtuaYjSjgpApupaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162783; c=relaxed/simple;
	bh=Y30KNXbgJ12KC38CWWbM6Y8iAA7KjcgOZLUX49FTcvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5X6w3zhWJLYrkmv8qGUbXXZE1XgIhVugw0GlE8TfMfGo2neYNOpCuaKbg0JKpNc0Nea+FYU6lyEfxZIon+sV/TbZwCFKswWiS9n8zfmBvzDeY6aeXw/rxe/6o5wb2D53e68GLV8u5gmvFsd4wLYRwP3rGv8M0QJi+dcf1x2cxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShgqzQ75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CABC4CEF1;
	Thu, 14 Aug 2025 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755162783;
	bh=Y30KNXbgJ12KC38CWWbM6Y8iAA7KjcgOZLUX49FTcvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ShgqzQ75YETRAvwAr0f4KpCiv9jPSMK2UaxmT/2G5vo22PQLPjc3c3KtZyqy/O83Q
	 WLNAV37JkCZeqY60EWSfjnrKjGFF54Wj47U6eFwQcIWJ6PvXI6Ymf2tbm+DsDie/mK
	 sp+B5VB9PLLF9kbQaM8y9AoYc3J8LkC1QmLBHic8Z2QRhpQiYGt8F7tjU0R3pw+kXP
	 nyXtNPbkKotmFSgZ2c03WKg4WhcJ/WTlp45TIs0taa1KS2n3SWXioEJiASodm4z/Jv
	 Z15kPHLKMMjVf/uNAhBLJnBht+C4vNXbmC0VZZMf0IfoQeDPQuGyEZS0kkWq1q3boo
	 1DHzuKkQlm2dA==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: bleung@chromium.org
Cc: tzungbi@kernel.org,
	dawidn@google.com,
	chrome-platform@lists.linux.dev,
	akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] lib: Add ref_proxy module
Date: Thu, 14 Aug 2025 09:10:18 +0000
Message-ID: <20250814091020.1302888-2-tzungbi@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
In-Reply-To: <20250814091020.1302888-1-tzungbi@kernel.org>
References: <20250814091020.1302888-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some resources can be removed asynchronously, for example, resources
provided by a hot-pluggable device like USB.  When holding a reference
to such a resource, it's possible for the resource to be removed and
its memory freed, leading to use-after-free errors on subsequent access.

Introduce the ref_proxy library to establish weak references to such
resources.  It allows a resource consumer to safely attempt to access a
resource that might be freed at any time by the resource provider.

The implementation uses a provider/consumer model built on Sleepable
RCU (SRCU) to guarantee safe memory access:

 - A resource provider allocates a struct ref_proxy_provider and
   initializes it with a pointer to the resource.

 - A resource consumer that wants to access the resource allocates a
   struct ref_proxy handle which holds a reference to the provider.

 - To access the resource, the consumer uses ref_proxy_get().  This
   function enters an SRCU read-side critical section and returns the
   pointer to the resource.  If the provider has already freed the
   resource, it returns NULL.  After use, the consumer calls
   ref_proxy_put() to exit the SRCU critical section.  The
   REF_PROXY_GET() is a convenient helper for doing that.

 - When the provider needs to remove the resource, it calls
   ref_proxy_provider_free().  This function sets the internal resource
   pointer to NULL and then calls synchronize_srcu() to wait for all
   current readers to finish before the resource can be completely torn
   down.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 include/linux/ref_proxy.h |  37 ++++++++
 lib/Kconfig               |   3 +
 lib/Makefile              |   1 +
 lib/ref_proxy.c           | 184 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 225 insertions(+)
 create mode 100644 include/linux/ref_proxy.h
 create mode 100644 lib/ref_proxy.c

diff --git a/include/linux/ref_proxy.h b/include/linux/ref_proxy.h
new file mode 100644
index 000000000000..16ff29169272
--- /dev/null
+++ b/include/linux/ref_proxy.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_REF_PROXY_H
+#define __LINUX_REF_PROXY_H
+
+#include <linux/cleanup.h>
+
+struct device;
+struct ref_proxy;
+struct ref_proxy_provider;
+
+struct ref_proxy_provider *ref_proxy_provider_alloc(void *ref);
+void ref_proxy_provider_free(struct ref_proxy_provider *rpp);
+struct ref_proxy_provider *devm_ref_proxy_provider_alloc(struct device *dev,
+							 void *ref);
+
+struct ref_proxy *ref_proxy_alloc(struct ref_proxy_provider *rpp);
+void ref_proxy_free(struct ref_proxy *proxy);
+void __rcu *ref_proxy_get(struct ref_proxy *proxy);
+void ref_proxy_put(struct ref_proxy *proxy);
+
+DEFINE_FREE(ref_proxy, struct ref_proxy *, if (_T) ref_proxy_put(_T))
+
+#define _REF_PROXY_GET(_proxy, _name, _label, _ref) \
+	for (struct ref_proxy *_name __free(ref_proxy) = _proxy;	\
+	     (_ref = ref_proxy_get(_name)) || true; ({ goto _label; }))	\
+		if (0) {						\
+_label:									\
+			break;						\
+		} else
+
+#define REF_PROXY_GET(_proxy, _ref)					\
+	_REF_PROXY_GET(_proxy, __UNIQUE_ID(proxy_name),			\
+		       __UNIQUE_ID(label), _ref)
+
+#endif /* __LINUX_REF_PROXY_H */
+
diff --git a/lib/Kconfig b/lib/Kconfig
index c483951b624f..18237a766606 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -583,6 +583,9 @@ config STACKDEPOT_MAX_FRAMES
 	default 64
 	depends on STACKDEPOT
 
+config REF_PROXY
+	bool
+
 config REF_TRACKER
 	bool
 	depends on STACKTRACE_SUPPORT
diff --git a/lib/Makefile b/lib/Makefile
index 392ff808c9b9..e8ad6f67cee9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -258,6 +258,7 @@ KASAN_SANITIZE_stackdepot.o := n
 KMSAN_SANITIZE_stackdepot.o := n
 KCOV_INSTRUMENT_stackdepot.o := n
 
+obj-$(CONFIG_REF_PROXY) += ref_proxy.o
 obj-$(CONFIG_REF_TRACKER) += ref_tracker.o
 
 libfdt_files = fdt.o fdt_ro.o fdt_wip.o fdt_rw.o fdt_sw.o fdt_strerror.o \
diff --git a/lib/ref_proxy.c b/lib/ref_proxy.c
new file mode 100644
index 000000000000..49940bea651c
--- /dev/null
+++ b/lib/ref_proxy.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/device.h>
+#include <linux/kref.h>
+#include <linux/ref_proxy.h>
+#include <linux/slab.h>
+#include <linux/srcu.h>
+
+/**
+ * struct ref_proxy_provider - A handle for resource provider.
+ * @srcu: The SRCU to protect the resource.
+ * @ref:  The pointer of resource.  It can point to anything.
+ * @kref: The refcount for this handle.
+ */
+struct ref_proxy_provider {
+	struct srcu_struct srcu;
+	void __rcu *ref;
+	struct kref kref;
+};
+
+/**
+ * struct ref_proxy - A handle for resource consumer.
+ * @rpp: The pointer of resource provider.
+ * @idx: The index for the RCU critical section.
+ */
+struct ref_proxy {
+	struct ref_proxy_provider *rpp;
+	int idx;
+};
+
+/**
+ * ref_proxy_provider_alloc() - Allocate struct ref_proxy_provider.
+ * @ref: The pointer of resource.
+ *
+ * This holds an initial refcount to the struct.
+ *
+ * Return: The pointer of struct ref_proxy_provider.  NULL on errors.
+ */
+struct ref_proxy_provider *ref_proxy_provider_alloc(void *ref)
+{
+	struct ref_proxy_provider *rpp;
+
+	rpp = kzalloc(sizeof(*rpp), GFP_KERNEL);
+	if (!rpp)
+		return NULL;
+
+	init_srcu_struct(&rpp->srcu);
+	rcu_assign_pointer(rpp->ref, ref);
+	synchronize_srcu(&rpp->srcu);
+	kref_init(&rpp->kref);
+
+	return rpp;
+}
+EXPORT_SYMBOL(ref_proxy_provider_alloc);
+
+static void ref_proxy_provider_release(struct kref *kref)
+{
+	struct ref_proxy_provider *rpp = container_of(kref,
+			struct ref_proxy_provider, kref);
+
+	cleanup_srcu_struct(&rpp->srcu);
+	kfree(rpp);
+}
+
+/**
+ * ref_proxy_provider_free() - Free struct ref_proxy_provider.
+ * @rpp: The pointer of resource provider.
+ *
+ * This sets the resource `(struct ref_proxy_provider *)->ref` to NULL to
+ * indicate the resource has gone.
+ *
+ * This drops the refcount to the resource provider.  If it is the final
+ * reference, ref_proxy_provider_release() will be called to free the struct.
+ */
+void ref_proxy_provider_free(struct ref_proxy_provider *rpp)
+{
+	rcu_assign_pointer(rpp->ref, NULL);
+	synchronize_srcu(&rpp->srcu);
+	kref_put(&rpp->kref, ref_proxy_provider_release);
+}
+EXPORT_SYMBOL(ref_proxy_provider_free);
+
+static void devm_ref_proxy_provider_free(void *data)
+{
+	struct ref_proxy_provider *rpp = data;
+
+	ref_proxy_provider_free(rpp);
+}
+
+/**
+ * devm_ref_proxy_provider_alloc() - Dev-managed ref_proxy_provider_alloc().
+ * @dev: The device.
+ * @ref: The pointer of resource.
+ *
+ * This holds an initial refcount to the struct.
+ *
+ * Return: The pointer of struct ref_proxy_provider.  NULL on errors.
+ */
+struct ref_proxy_provider *devm_ref_proxy_provider_alloc(struct device *dev,
+							 void *ref)
+{
+	struct ref_proxy_provider *rpp;
+
+	rpp = ref_proxy_provider_alloc(ref);
+	if (rpp)
+		if (devm_add_action_or_reset(dev, devm_ref_proxy_provider_free,
+					     rpp))
+			return NULL;
+
+	return rpp;
+}
+EXPORT_SYMBOL(devm_ref_proxy_provider_alloc);
+
+/**
+ * ref_proxy_alloc() - Allocate struct ref_proxy_provider.
+ * @rpp: The pointer of resource provider.
+ *
+ * This holds a refcount to the resource provider.
+ *
+ * Return: The pointer of struct ref_proxy_provider.  NULL on errors.
+ */
+struct ref_proxy *ref_proxy_alloc(struct ref_proxy_provider *rpp)
+{
+	struct ref_proxy *proxy;
+
+	proxy = kzalloc(sizeof(*proxy), GFP_KERNEL);
+	if (!proxy)
+		return NULL;
+
+	proxy->rpp = rpp;
+	kref_get(&rpp->kref);
+
+	return proxy;
+}
+EXPORT_SYMBOL(ref_proxy_alloc);
+
+/**
+ * ref_proxy_free() - Free struct ref_proxy.
+ * @proxy: The pointer of struct ref_proxy.
+ *
+ * This drops a refcount to the resource provider.  If it is the final
+ * reference, ref_proxy_provider_release() will be called to free the struct.
+ */
+void ref_proxy_free(struct ref_proxy *proxy)
+{
+	struct ref_proxy_provider *rpp = proxy->rpp;
+
+	kref_put(&rpp->kref, ref_proxy_provider_release);
+	kfree(proxy);
+}
+EXPORT_SYMBOL(ref_proxy_free);
+
+/**
+ * ref_proxy_get() - Get the resource.
+ * @proxy: The pointer of struct ref_proxy.
+ *
+ * This tries to de-reference to the resource and enters a RCU critical
+ * section.
+ *
+ * Return: The pointer to the resource.  NULL if the resource has gone.
+ */
+void __rcu *ref_proxy_get(struct ref_proxy *proxy)
+{
+	struct ref_proxy_provider *rpp = proxy->rpp;
+
+	proxy->idx = srcu_read_lock(&rpp->srcu);
+	return rcu_dereference(rpp->ref);
+}
+EXPORT_SYMBOL(ref_proxy_get);
+
+/**
+ * ref_proxy_put() - Put the resource.
+ * @proxy: The pointer of struct ref_proxy.
+ *
+ * Call this function to indicate the resource is no longer used.  It exits
+ * the RCU critical section.
+ */
+void ref_proxy_put(struct ref_proxy *proxy)
+{
+	struct ref_proxy_provider *rpp = proxy->rpp;
+
+	srcu_read_unlock(&rpp->srcu, proxy->idx);
+}
+EXPORT_SYMBOL(ref_proxy_put);
-- 
2.51.0.rc1.163.g2494970778-goog


