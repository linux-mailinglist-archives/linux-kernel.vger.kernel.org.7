Return-Path: <linux-kernel+bounces-747228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C3EB13131
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 20:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8981891A21
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56203226861;
	Sun, 27 Jul 2025 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BAGtK/Mk"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A27225388
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753641079; cv=none; b=BE01FSv9ZJXg5yd6SMd6w0VgzF8pcBz6mKWtBoRuO8StDqFbLmHxS0XBidp2d33jiLg4QecpAQTR2gLI5ZUMQioX0GjFE/vgoZTgC/wqgcAWoyyAlNe1eJIDLobgCJizWgSet/DNkRevYdjebL62VP67OCJmpBSf9yLda6fRcDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753641079; c=relaxed/simple;
	bh=VZxXgmTX4xkNdH+Ek2UIA5rZJuOCQSy5Xc3zBhHKzkM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZRYVXSfTgX6D87oMiB2u5aigX3NmQorTY5IE6Pkw1p8f1OEMhb5XY0lYbvUoJ7MQeNBNMbz7JFqmQZAXcwKsfAD/oTA5VeQBMc5q8oWsxWiJjQ94N/w9d9k4dYteP1Lo/FD+huFEqqDs1cTpaWCtMd7Wy7hRqqUSg85aV56UoWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BAGtK/Mk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b38ec062983so2565228a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753641077; x=1754245877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1GJxK0KXsLx9H/XDzvQ6sbb6mZedTCYKkjtJ58DsPSc=;
        b=BAGtK/MkoRoafZ++NHKS9wdnHYpmrdF1st5VAOFpEvzoqmhvJWpK020dL3GLJIRST1
         z3s9LgATWWnK0BJb9p+/rTT34S0kMqAv/OFe/UPfpwHHlvzeJ2/tEyPS+ZsQhTaX+daJ
         DcWmQf5yB8rMS8/gS5+ExnftvwUIpjdnqBNgZG5ZeCFhJC0pJcleQ84fnT/5HWGTiOAP
         suLjkH4T/+xJh3jcy5uM5ZbAfXuIDalJ7eAKG+2QcWi7R6EkKA+S7BI5tXPjHyJccRBb
         dYqEAotZAyfytNsmGJIy63IBgxe9ulUzViNNEI9BUVAnsrSQYCWW8uiavxvw94qwXsAn
         DxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753641077; x=1754245877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1GJxK0KXsLx9H/XDzvQ6sbb6mZedTCYKkjtJ58DsPSc=;
        b=EcEcNXlSQ7wD5/NVdDZHt/2i9a9XSsKxSby5fSTjxQwfQZExNKWp6VorF3ej3zmfZn
         kITrzTDMIENPYZStTCn0Oq2LRGVL+Ixx0JmscaEyhSSSWO4YBljhJu6hT37jLI7Unw2E
         7quhXpyvyOBoRh9SHGgU50qlshfWTYYbK6L9dm41gAg6x3Nu6amronmW14S6Ayh7CRMU
         Zo209jo8CRD0L0RdoOmwN6GwbQdn9WmgeaAUfWO+LNeH1jqdDb7b/vjR7961xU/PyF5T
         8seeTz1coNTuX3G7ioqH3k0VyWmlKM1W8IBLr4QAZ3TUmOfBxCO5y7K60rTctx9/jGZS
         ULag==
X-Forwarded-Encrypted: i=1; AJvYcCX9wDaYHy9cwkgFMmW//qQfgOE2t2l8Yw8UAoHG87Su0qRHeRztVAf6fWZPbGN/Xtg8jsBud1IZsKMrCp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbe3WtQEN2zg1oXZxkj8NgWiqCmjPY+AxdC17oV4tccHPPtpR
	x5RI3aQfeSE3MJHDbACxucSBWucQ2dStkK1px/4BJt0h8b3pUj1buytf09xcAl5VOaPKF+kwg9W
	rfMlQQd/HuYl+yQ==
X-Google-Smtp-Source: AGHT+IGb92eIG/h+HjV21j+xjnGj1Dz/xo0rOm76wrt0DnmWAXxWGKp/3Ww1XR/lmmbBdyLR0dlj5qxTtLLWSQ==
X-Received: from pgac5.prod.google.com ([2002:a05:6a02:2945:b0:b39:24fb:bd64])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:6d86:b0:22c:fc43:c9f3 with SMTP id adf61e73a8af0-23d70150439mr14962401637.21.1753641076638;
 Sun, 27 Jul 2025 11:31:16 -0700 (PDT)
Date: Sun, 27 Jul 2025 18:29:06 +0000
In-Reply-To: <20250727182932.2499194-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250727182932.2499194-1-cmllamas@google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250727182932.2499194-4-cmllamas@google.com>
Subject: [PATCH v20 3/5] binder: introduce transaction reports via netlink
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Li Li <dualli@google.com>
Cc: Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>, 
	Shai Barack <shayba@google.com>, "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Li Li <dualli@google.com>

Introduce a generic netlink multicast event to report binder transaction
failures to userspace. This allows subscribers to monitor these events
and take appropriate actions, such as stopping a misbehaving application
that is spamming a service with huge amount of transactions.

The multicast event contains full details of the failed transactions,
including the sender/target PIDs, payload size and specific error code.
This interface is defined using a YAML spec, from which the UAPI and
kernel headers and source are auto-generated.

Signed-off-by: Li Li <dualli@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 Documentation/netlink/specs/binder.yaml     | 93 +++++++++++++++++++++
 MAINTAINERS                                 |  1 +
 drivers/android/Kconfig                     |  1 +
 drivers/android/Makefile                    |  2 +-
 drivers/android/binder.c                    | 85 ++++++++++++++++++-
 drivers/android/binder_netlink.c            | 31 +++++++
 drivers/android/binder_netlink.h            | 20 +++++
 include/uapi/linux/android/binder_netlink.h | 37 ++++++++
 8 files changed, 265 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/netlink/specs/binder.yaml
 create mode 100644 drivers/android/binder_netlink.c
 create mode 100644 drivers/android/binder_netlink.h
 create mode 100644 include/uapi/linux/android/binder_netlink.h

diff --git a/Documentation/netlink/specs/binder.yaml b/Documentation/netlink/specs/binder.yaml
new file mode 100644
index 000000000000..140b77a6afee
--- /dev/null
+++ b/Documentation/netlink/specs/binder.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+#
+# Copyright 2025 Google LLC
+#
+---
+name: binder
+protocol: genetlink
+uapi-header: linux/android/binder_netlink.h
+doc: Binder interface over generic netlink
+
+attribute-sets:
+  -
+    name: report
+    doc: |
+      Attributes included within a transaction failure report. The elements
+      correspond directly with the specific transaction that failed, along
+      with the error returned to the sender e.g. BR_DEAD_REPLY.
+
+    attributes:
+      -
+        name: error
+        type: u32
+        doc: The enum binder_driver_return_protocol returned to the sender.
+      -
+        name: context
+        type: string
+        doc: The binder context where the transaction occurred.
+      -
+        name: from_pid
+        type: u32
+        doc: The PID of the sender process.
+      -
+        name: from_tid
+        type: u32
+        doc: The TID of the sender thread.
+      -
+        name: to_pid
+        type: u32
+        doc: |
+          The PID of the recipient process. This attribute may not be present
+          if the target could not be determined.
+      -
+        name: to_tid
+        type: u32
+        doc: |
+          The TID of the recipient thread. This attribute may not be present
+          if the target could not be determined.
+      -
+        name: is_reply
+        type: flag
+        doc: When present, indicates the failed transaction is a reply.
+      -
+        name: flags
+        type: u32
+        doc: The bitmask of enum transaction_flags from the transaction.
+      -
+        name: code
+        type: u32
+        doc: The application-defined code from the transaction.
+      -
+        name: data_size
+        type: u32
+        doc: The transaction payload size in bytes.
+
+operations:
+  list:
+    -
+      name: report
+      doc: |
+        A multicast event sent to userspace subscribers to notify them about
+        binder transaction failures. The generated report provides the full
+        details of the specific transaction that failed. The intention is for
+        programs to monitor these events and react to the failures as needed.
+
+      attribute-set: report
+      mcgrp: report
+      event:
+        attributes:
+          - error
+          - context
+          - from_pid
+          - from_tid
+          - to_pid
+          - to_tid
+          - is_reply
+          - flags
+          - code
+          - data_size
+
+mcast-groups:
+  list:
+    -
+      name: report
diff --git a/MAINTAINERS b/MAINTAINERS
index f8c8f682edf6..df8f6b31f2f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1769,6 +1769,7 @@ M:	Suren Baghdasaryan <surenb@google.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
+F:	Documentation/netlink/specs/binder.yaml
 F:	drivers/android/
 
 ANDROID GOLDFISH PIC DRIVER
diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index 5b3b8041f827..75af3cf472c8 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -4,6 +4,7 @@ menu "Android"
 config ANDROID_BINDER_IPC
 	bool "Android Binder IPC Driver"
 	depends on MMU
+	depends on NET
 	default n
 	help
 	  Binder is used in Android for both communication between processes,
diff --git a/drivers/android/Makefile b/drivers/android/Makefile
index c5d47be0276c..f422f91e026b 100644
--- a/drivers/android/Makefile
+++ b/drivers/android/Makefile
@@ -2,5 +2,5 @@
 ccflags-y += -I$(src)			# needed for trace events
 
 obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
-obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
+obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o binder_netlink.o
 obj-$(CONFIG_ANDROID_BINDER_ALLOC_KUNIT_TEST)	+= tests/
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 95aa1fae53e2..0d37eca514f9 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -74,6 +74,7 @@
 
 #include <linux/cacheflush.h>
 
+#include "binder_netlink.h"
 #include "binder_internal.h"
 #include "binder_trace.h"
 
@@ -2993,6 +2994,67 @@ static void binder_set_txn_from_error(struct binder_transaction *t, int id,
 	binder_thread_dec_tmpref(from);
 }
 
+/**
+ * binder_netlink_report() - report a transaction failure via netlink
+ * @proc:	the binder proc sending the transaction
+ * @t:		the binder transaction that failed
+ * @data_size:	the user provided data size for the transaction
+ * @error:	enum binder_driver_return_protocol returned to sender
+ */
+static void binder_netlink_report(struct binder_proc *proc,
+				  struct binder_transaction *t,
+				  u32 data_size,
+				  u32 error)
+{
+	const char *context = proc->context->name;
+	struct sk_buff *skb;
+	void *hdr;
+
+	if (!genl_has_listeners(&binder_nl_family, &init_net,
+				BINDER_NLGRP_REPORT))
+		return;
+
+	skb = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!skb)
+		return;
+
+	hdr = genlmsg_put(skb, 0, 0, &binder_nl_family, 0, BINDER_CMD_REPORT);
+	if (!hdr)
+		goto free_skb;
+
+	if (nla_put_u32(skb, BINDER_A_REPORT_ERROR, error) ||
+	    nla_put_string(skb, BINDER_A_REPORT_CONTEXT, context) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_FROM_PID, t->from_pid) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_FROM_TID, t->from_tid))
+		goto cancel_skb;
+
+	if (t->to_proc &&
+	    nla_put_u32(skb, BINDER_A_REPORT_TO_PID, t->to_proc->pid))
+		goto cancel_skb;
+
+	if (t->to_thread &&
+	    nla_put_u32(skb, BINDER_A_REPORT_TO_TID, t->to_thread->pid))
+		goto cancel_skb;
+
+	if (t->is_reply && nla_put_flag(skb, BINDER_A_REPORT_IS_REPLY))
+		goto cancel_skb;
+
+	if (nla_put_u32(skb, BINDER_A_REPORT_FLAGS, t->flags) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_CODE, t->code) ||
+	    nla_put_u32(skb, BINDER_A_REPORT_DATA_SIZE, data_size))
+		goto cancel_skb;
+
+	genlmsg_end(skb, hdr);
+	genlmsg_multicast(&binder_nl_family, skb, 0, BINDER_NLGRP_REPORT,
+			  GFP_KERNEL);
+	return;
+
+cancel_skb:
+	genlmsg_cancel(skb, hdr);
+free_skb:
+	nlmsg_free(skb);
+}
+
 static void binder_transaction(struct binder_proc *proc,
 			       struct binder_thread *thread,
 			       struct binder_transaction_data *tr, int reply,
@@ -3679,10 +3741,13 @@ static void binder_transaction(struct binder_proc *proc,
 		return_error_line = __LINE__;
 		goto err_copy_data_failed;
 	}
-	if (t->buffer->oneway_spam_suspect)
+	if (t->buffer->oneway_spam_suspect) {
 		tcomplete->type = BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT;
-	else
+		binder_netlink_report(proc, t, tr->data_size,
+				      BR_ONEWAY_SPAM_SUSPECT);
+	} else {
 		tcomplete->type = BINDER_WORK_TRANSACTION_COMPLETE;
+	}
 
 	if (reply) {
 		binder_enqueue_thread_work(thread, tcomplete);
@@ -3730,8 +3795,11 @@ static void binder_transaction(struct binder_proc *proc,
 		 * process and is put in a pending queue, waiting for the target
 		 * process to be unfrozen.
 		 */
-		if (return_error == BR_TRANSACTION_PENDING_FROZEN)
+		if (return_error == BR_TRANSACTION_PENDING_FROZEN) {
 			tcomplete->type = BINDER_WORK_TRANSACTION_PENDING;
+			binder_netlink_report(proc, t, tr->data_size,
+					      return_error);
+		}
 		binder_enqueue_thread_work(thread, tcomplete);
 		if (return_error &&
 		    return_error != BR_TRANSACTION_PENDING_FROZEN)
@@ -3789,6 +3857,8 @@ static void binder_transaction(struct binder_proc *proc,
 		binder_dec_node(target_node, 1, 0);
 		binder_dec_node_tmpref(target_node);
 	}
+
+	binder_netlink_report(proc, t, tr->data_size, return_error);
 	kfree(t);
 	binder_stats_deleted(BINDER_STAT_TRANSACTION);
 err_alloc_t_failed:
@@ -7067,12 +7137,19 @@ static int __init binder_init(void)
 		}
 	}
 
-	ret = init_binderfs();
+	ret = genl_register_family(&binder_nl_family);
 	if (ret)
 		goto err_init_binder_device_failed;
 
+	ret = init_binderfs();
+	if (ret)
+		goto err_init_binderfs_failed;
+
 	return ret;
 
+err_init_binderfs_failed:
+	genl_unregister_family(&binder_nl_family);
+
 err_init_binder_device_failed:
 	hlist_for_each_entry_safe(device, tmp, &binder_devices, hlist) {
 		misc_deregister(&device->miscdev);
diff --git a/drivers/android/binder_netlink.c b/drivers/android/binder_netlink.c
new file mode 100644
index 000000000000..d05397a50ca6
--- /dev/null
+++ b/drivers/android/binder_netlink.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder.yaml */
+/* YNL-GEN kernel source */
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include "binder_netlink.h"
+
+#include <uapi/linux/android/binder_netlink.h>
+
+/* Ops table for binder */
+static const struct genl_split_ops binder_nl_ops[] = {
+};
+
+static const struct genl_multicast_group binder_nl_mcgrps[] = {
+	[BINDER_NLGRP_REPORT] = { "report", },
+};
+
+struct genl_family binder_nl_family __ro_after_init = {
+	.name		= BINDER_FAMILY_NAME,
+	.version	= BINDER_FAMILY_VERSION,
+	.netnsok	= true,
+	.parallel_ops	= true,
+	.module		= THIS_MODULE,
+	.split_ops	= binder_nl_ops,
+	.n_split_ops	= ARRAY_SIZE(binder_nl_ops),
+	.mcgrps		= binder_nl_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(binder_nl_mcgrps),
+};
diff --git a/drivers/android/binder_netlink.h b/drivers/android/binder_netlink.h
new file mode 100644
index 000000000000..882c7a6b537e
--- /dev/null
+++ b/drivers/android/binder_netlink.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder.yaml */
+/* YNL-GEN kernel header */
+
+#ifndef _LINUX_BINDER_GEN_H
+#define _LINUX_BINDER_GEN_H
+
+#include <net/netlink.h>
+#include <net/genetlink.h>
+
+#include <uapi/linux/android/binder_netlink.h>
+
+enum {
+	BINDER_NLGRP_REPORT,
+};
+
+extern struct genl_family binder_nl_family;
+
+#endif /* _LINUX_BINDER_GEN_H */
diff --git a/include/uapi/linux/android/binder_netlink.h b/include/uapi/linux/android/binder_netlink.h
new file mode 100644
index 000000000000..b218f96d6668
--- /dev/null
+++ b/include/uapi/linux/android/binder_netlink.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
+/* Do not edit directly, auto-generated from: */
+/*	Documentation/netlink/specs/binder.yaml */
+/* YNL-GEN uapi header */
+
+#ifndef _UAPI_LINUX_ANDROID_BINDER_NETLINK_H
+#define _UAPI_LINUX_ANDROID_BINDER_NETLINK_H
+
+#define BINDER_FAMILY_NAME	"binder"
+#define BINDER_FAMILY_VERSION	1
+
+enum {
+	BINDER_A_REPORT_ERROR = 1,
+	BINDER_A_REPORT_CONTEXT,
+	BINDER_A_REPORT_FROM_PID,
+	BINDER_A_REPORT_FROM_TID,
+	BINDER_A_REPORT_TO_PID,
+	BINDER_A_REPORT_TO_TID,
+	BINDER_A_REPORT_IS_REPLY,
+	BINDER_A_REPORT_FLAGS,
+	BINDER_A_REPORT_CODE,
+	BINDER_A_REPORT_DATA_SIZE,
+
+	__BINDER_A_REPORT_MAX,
+	BINDER_A_REPORT_MAX = (__BINDER_A_REPORT_MAX - 1)
+};
+
+enum {
+	BINDER_CMD_REPORT = 1,
+
+	__BINDER_CMD_MAX,
+	BINDER_CMD_MAX = (__BINDER_CMD_MAX - 1)
+};
+
+#define BINDER_MCGRP_REPORT	"report"
+
+#endif /* _UAPI_LINUX_ANDROID_BINDER_NETLINK_H */
-- 
2.50.1.470.g6ba607880d-goog


