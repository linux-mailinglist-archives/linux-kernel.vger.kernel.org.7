Return-Path: <linux-kernel+bounces-751794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA564B16D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5073AA76C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D88241670;
	Thu, 31 Jul 2025 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PaMKRwVb"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED401482F5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753950619; cv=none; b=amX0JnDT9t3BBdDKGPKWBpDHieV1hcNxLbhL3cVR14M4lvr58VkkzzHiTqr3oAuqrCUbhuMD2oMWw00T1OeACT13UqYWkWFAiCCyQIiS1D4zm+Csx61dxR6OGlfX1wHnyZpR38Fqo0JkkVeWxiRTImjdXxDdfgpIRaP3puA4jg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753950619; c=relaxed/simple;
	bh=71A10EnoM8VbuBcyaW9SLsjfGE/7bzAU1p2Amlz7pOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=khnGcogqcOb1cS0f6jnnDvSIaQLFHj1VOAXo63kVOWoRIXSkW75nMb2ih7HBMLMTbdve4ZcDK0wzOfz9QPjq79yBK4kt4IM23Eve4bL+pQdZQ0lTmiFKdmSSNmxtVVJhxauLkuj/S8DiULohWT0PrTiKW5aDP+1sm1EQkQjlD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PaMKRwVb; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Qe
	26NsUXhixAI64uFV4t/uGxaqu3ZDizLlrJAbwVBog=; b=PaMKRwVbGqiNWmjkR+
	8lYA5JNbBInmpf+xoIsiNZucwQ8fnVKZwW/4ff5DXW206koeqVSqoE8uLV47IAKr
	JPwsF28hghaQ1fTUwwA9sXWcZNLREt8VVokyu5W02hR8xZ1CUcHgavgGDzVCLC0+
	5802uVLs+HxCSjqtTHSJg0b5o=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBHQ7eBKYtojcZXIw--.60600S2;
	Thu, 31 Jul 2025 16:29:55 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: andrii@kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Add missing kfunc declarations to fix build errors
Date: Thu, 31 Jul 2025 08:29:50 +0000
Message-ID: <20250731082951.439101-1-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHQ7eBKYtojcZXIw--.60600S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfJw15Cr48Kw1DAr48XF1DZFb_yoW8XFy8Wo
	Z3KF98X3W8urWxAryDAr1fJa4kuws2grWrAr4fGr98WFyjy34Y9ryxCw4xJrW2qw1rXa40
	9asxA390vFy8GFykn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU5nmRDUUUU
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgAebiGiLIjms2wAAsb

A number of BPF selftests that utilize kernel functions (kfuncs) fail
to build due to missing function prototypes. This results in compilation
errors, as implicit function declarations are treated as errors:

  error: call to undeclared function 'bpf_copy_from_user_task_str';
         ISO C99 and later do not support implicit function declarations

Unlike BPF helpers, kfuncs are not automatically available to BPF
programs and must be explicitly declared before use.

To resolve this, centralize all the necessary kfunc declarations into
the `bpf_kfuncs.h` header file. This header is then included in all the
test programs that were previously missing these declarations.

This approach also allows for the removal of redundant local `extern`
declarations from individual source files (e.g., in `irq.c`), leading
to cleaner and more maintainable code.

Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
---
 tools/testing/selftests/bpf/bpf_kfuncs.h      | 64 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_tasks.c      |  1 +
 .../bpf/progs/bpf_qdisc_fail__incompl_ops.c   |  1 +
 .../selftests/bpf/progs/bpf_qdisc_fifo.c      |  1 +
 .../selftests/bpf/progs/bpf_qdisc_fq.c        |  1 +
 .../selftests/bpf/progs/cgroup_read_xattr.c   |  1 +
 .../testing/selftests/bpf/progs/dmabuf_iter.c |  1 +
 .../selftests/bpf/progs/dynptr_success.c      |  1 +
 tools/testing/selftests/bpf/progs/irq.c       |  6 +-
 .../selftests/bpf/progs/linked_list_peek.c    |  1 +
 .../selftests/bpf/progs/rbtree_search.c       |  1 +
 .../selftests/bpf/progs/rcu_read_lock.c       |  1 +
 .../selftests/bpf/progs/read_cgroupfs_xattr.c |  1 +
 .../selftests/bpf/progs/res_spin_lock.c       |  1 +
 .../selftests/bpf/progs/res_spin_lock_fail.c  |  1 +
 .../struct_ops_refcounted_fail__tail_call.c   |  1 +
 .../selftests/bpf/progs/test_spin_lock_fail.c |  1 +
 17 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/selftests/bpf/bpf_kfuncs.h
index 8215c9b3115e..f4704b0a36a7 100644
--- a/tools/testing/selftests/bpf/bpf_kfuncs.h
+++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
@@ -2,6 +2,7 @@
 #define __BPF_KFUNCS__
 
 struct bpf_sock_addr_kern;
+struct bpf_res_spin_lock;
 
 /* Description
  *  Initializes an skb-type dynptr
@@ -42,6 +43,28 @@ extern bool bpf_dynptr_is_null(const struct bpf_dynptr *ptr) __ksym __weak;
 extern bool bpf_dynptr_is_rdonly(const struct bpf_dynptr *ptr) __ksym __weak;
 extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym __weak;
 extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct bpf_dynptr *clone__init) __ksym __weak;
+extern int bpf_dynptr_copy(struct bpf_dynptr *dst_ptr, __u32 dst_off, struct bpf_dynptr *src_ptr,
+				__u32 src_off, __u32 size) __ksym __weak;
+extern int bpf_probe_read_user_dynptr(struct bpf_dynptr *dptr, __u32 off,
+				__u32 size, const void *unsafe_ptr__ign) __ksym __weak;
+extern int bpf_probe_read_kernel_dynptr(struct bpf_dynptr *dptr, __u32 off,
+				__u32 size, const void *unsafe_ptr__ign) __ksym __weak;
+extern int bpf_probe_read_user_str_dynptr(struct bpf_dynptr *dptr, __u32 off,
+				__u32 size, const void *unsafe_ptr__ign) __ksym __weak;
+extern int bpf_probe_read_kernel_str_dynptr(struct bpf_dynptr *dptr, __u32 off,
+				__u32 size, const void *unsafe_ptr__ign) __ksym __weak;
+extern int bpf_copy_from_user_dynptr(struct bpf_dynptr *dptr, __u32 off,
+				__u32 size, const void *unsafe_ptr__ign) __ksym __weak;
+extern int bpf_copy_from_user_str_dynptr(struct bpf_dynptr *dptr, __u32 off,
+				__u32 size, const void *unsafe_ptr__ign) __ksym __weak;
+extern int bpf_copy_from_user_task_dynptr(struct bpf_dynptr *dptr, __u32 off,
+				__u32 size, const void *unsafe_ptr__ign,
+				struct task_struct *tsk) __ksym __weak;
+extern int bpf_copy_from_user_task_str_dynptr(struct bpf_dynptr *dptr, __u32 off,
+				__u32 size, const void *unsafe_ptr__ign,
+				struct task_struct *tsk) __ksym __weak;
+extern int bpf_copy_from_user_task_str(void *dst, __u32, const void *,
+				struct task_struct *, __u64) __ksym __weak;
 
 /* Description
  *  Modify the address of a AF_UNIX sockaddr.
@@ -92,4 +115,45 @@ extern int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__str,
 				const struct bpf_dynptr *value_p, int flags) __ksym __weak;
 extern int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name__str) __ksym __weak;
 
+extern void bpf_local_irq_save(unsigned long *) __ksym __weak;
+extern void bpf_local_irq_restore(unsigned long *) __ksym __weak;
+extern int bpf_copy_from_user_str(void *dst, __u32 dst__sz,
+				const void *unsafe_ptr__ign, __u64 flags) __ksym __weak;
+extern int bpf_res_spin_lock_irqsave(struct bpf_res_spin_lock *lock,
+				unsigned long *flags__irq_flag) __ksym __weak;
+extern void bpf_res_spin_unlock_irqrestore(struct bpf_res_spin_lock *lock,
+				unsigned long *flags__irq_flag) __ksym __weak;
+extern int bpf_res_spin_lock(struct bpf_res_spin_lock *lock) __ksym __weak;
+extern void bpf_res_spin_unlock(struct bpf_res_spin_lock *lock) __ksym __weak;
+
+extern struct bpf_list_node *bpf_list_front(struct bpf_list_head *head) __ksym __weak;
+extern struct bpf_list_node *bpf_list_back(struct bpf_list_head *head) __ksym __weak;
+
+struct bpf_sk_buff_ptr;
+struct sk_buff;
+struct Qdisc;
+
+extern void bpf_qdisc_skb_drop(struct sk_buff *skb,
+				    struct bpf_sk_buff_ptr *to_free_list) __ksym __weak;
+extern void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *skb) __ksym __weak;
+extern void bpf_kfree_skb(struct sk_buff *skb) __ksym __weak;
+extern __u32 bpf_skb_get_hash(struct sk_buff *) __ksym __weak;
+extern void bpf_qdisc_watchdog_schedule(struct Qdisc *sch, __u64 expire,
+		__u64 delta_ns) __ksym __weak;
+
+extern struct cgroup *bpf_cgroup_from_id(__u64 cgid) __ksym __weak;
+extern void bpf_cgroup_release(struct cgroup *cgrp) __ksym __weak;
+extern void bpf_rcu_read_lock(void) __ksym __weak;
+extern void bpf_rcu_read_unlock(void) __ksym __weak;
+extern struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level) __ksym __weak;
+
+
+extern struct bpf_rb_node *bpf_rbtree_root(struct bpf_rb_root *root) __ksym __weak;
+extern struct bpf_rb_node *bpf_rbtree_left(struct bpf_rb_root *root,
+		struct bpf_rb_node *node) __ksym __weak;
+extern struct bpf_rb_node *bpf_rbtree_right(struct bpf_rb_root *root,
+		struct bpf_rb_node *node) __ksym __weak;
+
+extern void bpf_task_release(struct task_struct *p) __ksym __weak;
+
 #endif
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
index 966ee5a7b066..63daf05366df 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
@@ -3,6 +3,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
+#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c
index f188062ed730..7f1a5a1b5dac 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fail__incompl_ops.c
@@ -3,6 +3,7 @@
 #include <vmlinux.h>
 #include "bpf_experimental.h"
 #include "bpf_qdisc_common.h"
+#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
index 1de2be3e370b..9ae41518d578 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fifo.c
@@ -3,6 +3,7 @@
 #include <vmlinux.h>
 #include "bpf_experimental.h"
 #include "bpf_qdisc_common.h"
+#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
index 1a3233a275c7..f86981bc2a09 100644
--- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
+++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
@@ -37,6 +37,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_experimental.h"
 #include "bpf_qdisc_common.h"
+#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c b/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
index 092db1d0435e..50162ca905cc 100644
--- a/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
+++ b/tools/testing/selftests/bpf/progs/cgroup_read_xattr.c
@@ -7,6 +7,7 @@
 #include <bpf/bpf_core_read.h>
 #include "bpf_experimental.h"
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/dmabuf_iter.c b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
index 13cdb11fdeb2..df0021dc54da 100644
--- a/tools/testing/selftests/bpf/progs/dmabuf_iter.c
+++ b/tools/testing/selftests/bpf/progs/dmabuf_iter.c
@@ -3,6 +3,7 @@
 #include <vmlinux.h>
 #include <bpf/bpf_core_read.h>
 #include <bpf/bpf_helpers.h>
+#include "bpf_experimental.h"
 
 /* From uapi/linux/dma-buf.h */
 #define DMA_BUF_NAME_LEN 32
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index a0391f9da2d4..95bcdf465c4b 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -8,6 +8,7 @@
 #include <bpf/bpf_tracing.h>
 #include "bpf_misc.h"
 #include "errno.h"
+#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/irq.c b/tools/testing/selftests/bpf/progs/irq.c
index 74d912b22de9..ce3b2509e6f1 100644
--- a/tools/testing/selftests/bpf/progs/irq.c
+++ b/tools/testing/selftests/bpf/progs/irq.c
@@ -4,13 +4,9 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
+#include "bpf_kfuncs.h"
 
 unsigned long global_flags;
-
-extern void bpf_local_irq_save(unsigned long *) __weak __ksym;
-extern void bpf_local_irq_restore(unsigned long *) __weak __ksym;
-extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void *unsafe_ptr__ign, u64 flags) __weak __ksym;
-
 struct bpf_res_spin_lock lockA __hidden SEC(".data.A");
 struct bpf_res_spin_lock lockB __hidden SEC(".data.B");
 
diff --git a/tools/testing/selftests/bpf/progs/linked_list_peek.c b/tools/testing/selftests/bpf/progs/linked_list_peek.c
index 264e81bfb287..00d5299eeb0a 100644
--- a/tools/testing/selftests/bpf/progs/linked_list_peek.c
+++ b/tools/testing/selftests/bpf/progs/linked_list_peek.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
+#include "bpf_kfuncs.h"
 
 struct node_data {
 	struct bpf_list_node l;
diff --git a/tools/testing/selftests/bpf/progs/rbtree_search.c b/tools/testing/selftests/bpf/progs/rbtree_search.c
index 098ef970fac1..681ea24d6877 100644
--- a/tools/testing/selftests/bpf/progs/rbtree_search.c
+++ b/tools/testing/selftests/bpf/progs/rbtree_search.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
+#include "bpf_kfuncs.h"
 
 struct node_data {
 	struct bpf_refcount ref;
diff --git a/tools/testing/selftests/bpf/progs/rcu_read_lock.c b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
index 43637ee2cdcd..386559f026dd 100644
--- a/tools/testing/selftests/bpf/progs/rcu_read_lock.c
+++ b/tools/testing/selftests/bpf/progs/rcu_read_lock.c
@@ -6,6 +6,7 @@
 #include <bpf/bpf_tracing.h>
 #include "bpf_tracing_net.h"
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c b/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c
index 855f85fc5522..0575e08ae108 100644
--- a/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c
+++ b/tools/testing/selftests/bpf/progs/read_cgroupfs_xattr.c
@@ -6,6 +6,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_core_read.h>
 #include "bpf_experimental.h"
+#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/res_spin_lock.c b/tools/testing/selftests/bpf/progs/res_spin_lock.c
index 22c4fb8b9266..8d21b7ae0a18 100644
--- a/tools/testing/selftests/bpf/progs/res_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/res_spin_lock.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 
 #define EDEADLK 35
 #define ETIMEDOUT 110
diff --git a/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
index 330682a88c16..d643ff783798 100644
--- a/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
+++ b/tools/testing/selftests/bpf/progs/res_spin_lock_fail.c
@@ -6,6 +6,7 @@
 #include <bpf/bpf_core_read.h>
 #include "bpf_misc.h"
 #include "bpf_experimental.h"
+#include "bpf_kfuncs.h"
 
 struct arr_elem {
 	struct bpf_res_spin_lock lock;
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__tail_call.c b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__tail_call.c
index 3b125025a1f2..7661658848f4 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__tail_call.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__tail_call.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include "../test_kmods/bpf_testmod.h"
 #include "bpf_misc.h"
+#include "bpf_kfuncs.h"
 
 char _license[] SEC("license") = "GPL";
 
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
index f678ee6bd7ea..aee2791ad863 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock_fail.c
@@ -3,6 +3,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_experimental.h"
+#include "bpf_kfuncs.h"
 
 struct foo {
 	struct bpf_spin_lock lock;
-- 
2.43.0


