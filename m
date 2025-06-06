Return-Path: <linux-kernel+bounces-676066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD34AD0719
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 18:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412BA17BFFA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jun 2025 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8CC28A1F9;
	Fri,  6 Jun 2025 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KvxB4Uao"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C028A1FC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Jun 2025 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229135; cv=none; b=OU0hILY57tx+mVUjJspYePAh85XMwwmRmLpuMRQyKTqG5ApdLe7m430oeq8sumaO4rXrg8BCd7a+eo53AJUVXnIJGtMVLA/XBQ3o5red3fK+QYvMFW5PC0zWZaf4AyNCrdAJMhIcyQBTlxkQGj8vqYwI8vYXLoho0PeWmOyrVNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229135; c=relaxed/simple;
	bh=tufv0EOfIRCcGCuoeIAQzVp2+83siqI9hecekbLVrcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lMddbNeiUeXABKQHSPQjWM45iHwSJ4qcDdA2EImoDhX64OYg0SXL/3J6uOEfXwUQ+9oYbEEbWSKDoWjl3U00WIeYLqInMFeNhPfZCzPpPn3F5HSQXHByB+SCKc1lProWh43IPtpo7eYz9fIkQNyS4L0LtZL41f7UxK9AiE7lKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KvxB4Uao; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749229121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5NdfrsbIRzOD8vK2LDNBZuEFwBMyM/EzGFaa7yMA5lU=;
	b=KvxB4UaoKQG/EngKwI9mNfIlykekVYow+Qp3zffmi1L8gB7BO50YIf8DX0uU94w7AIBKSs
	ElFlOi1KES1jkQly9HWPmF/cb0UA9d0OqeC2X8BJLCKykfuhqVGgp4JaC0A9uwpitr1ptK
	2tEff5IgCyrEwYBBHVDrlMy4BWv7A24=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	qmo@kernel.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next  1/5] bpf: Add cookie to tracing bpf_link_info
Date: Sat,  7 Jun 2025 00:58:14 +0800
Message-Id: <20250606165818.3394397-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bpf_tramp_link includes cookie info, we can add it in bpf_link_info.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/uapi/linux/bpf.h       | 2 ++
 kernel/bpf/syscall.c           | 1 +
 tools/include/uapi/linux/bpf.h | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f1160ebbf52..fd4869d8cd1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6658,6 +6658,8 @@ struct bpf_link_info {
 			__u32 attach_type;
 			__u32 target_obj_id; /* prog_id for PROG_EXT, otherwise btf object id */
 			__u32 target_btf_id; /* BTF type id inside the object */
+			__u32 :32;
+			__u64 cookie;
 		} tracing;
 		struct {
 			__u64 cgroup_id;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 89d027cd7ca..4c0ac083518 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3416,6 +3416,7 @@ static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
 		container_of(link, struct bpf_tracing_link, link.link);
 
 	info->tracing.attach_type = tr_link->attach_type;
+	info->tracing.cookie = tr_link->link.cookie;
 	bpf_trampoline_unpack_key(tr_link->trampoline->key,
 				  &info->tracing.target_obj_id,
 				  &info->tracing.target_btf_id);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f1160ebbf52..fd4869d8cd1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6658,6 +6658,8 @@ struct bpf_link_info {
 			__u32 attach_type;
 			__u32 target_obj_id; /* prog_id for PROG_EXT, otherwise btf object id */
 			__u32 target_btf_id; /* BTF type id inside the object */
+			__u32 :32;
+			__u64 cookie;
 		} tracing;
 		struct {
 			__u64 cgroup_id;
-- 
2.43.0


