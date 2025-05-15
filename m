Return-Path: <linux-kernel+bounces-648591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4291AAB7924
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 00:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8E386855B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 22:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10932236F2;
	Wed, 14 May 2025 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="Fu8gYC92"
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21F222584
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747262594; cv=none; b=SuLLNXyRy045dy+Vvd1eJzY0RzAq2X2cghtSqpuLOkAHaVcSgpQwQG80h5B3GNanvkQ9k7Ke84iPWw6oW5bXRJNAKTBN5+SY+xoJby76VLqC5x3bbVvnLjq3NGGIb4NEj4MVXEWYTR93pDho+tKm/s3ZhVQmwbfsVTsJZ/A4Xr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747262594; c=relaxed/simple;
	bh=QaLq3SL5OMyc+7AJ0LFBdLmC+RjvCwNSMZ9ekuidqGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CsEru+e2w3TYgGJ6txePggOJm1Gj9O27NWh/7KBY9mYfuMaV+D6AP+OXTTt3ZWbI8HgsmRyppz9MzQbsGfZ3PJmL+gDoBQnaK2xC13XVh8N+TLjGsKhmeYO58Uf1YO8qYZEJbEbu0pq7JDVEd/aURK4UtCE20A/fcOnrYLAYhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=Fu8gYC92; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOi-001vfF-Uv; Thu, 15 May 2025 00:16:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=YG06fwNA91GgAgl0iabbu4fCCpsHoTGuufLEYHdsOVQ=; b=Fu8gYC92Gc4FYsuJmGaB3Vwd6T
	rThnDcs+ZCtJlOcVhBbC2b/gHkYSlbQfV2lWzK6zkBSKT20rjoaM6eJ4D2b752oRCEyfzAeq1+BTk
	Akr4mOhl0Sc0S4m8D0oFqLeUx2kPfQYhn+WTnYgOe/oT4h9L3l7rESvGkD57m9huIKd8osIx8WAra
	eMq00unNsAmAmFFZO989oMwca5PZXevX+AnjAglQ1N+6LzTVUMr3k4/GNXiyWMA4uXsL9mPAQonXI
	HFOBi+dGkw7KoLOqiyx7Xnn+FiqZhdc9lT3N1Z5g2/GFYkqizWTTqEwmBTVqyyaWv5+uB2oOX0GGs
	b7Z7uN+A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uFKOi-0008AG-J3; Thu, 15 May 2025 00:16:20 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uFKOL-005bJ3-Mr; Thu, 15 May 2025 00:15:57 +0200
From: Michal Luczaj <mhal@rbox.co>
Date: Thu, 15 May 2025 00:15:26 +0200
Subject: [PATCH bpf-next v3 3/8] selftests/bpf: Add u32()/u64() to
 sockmap_helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-selftests-sockmap-redir-v3-3-a1ea723f7e7e@rbox.co>
References: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
In-Reply-To: <20250515-selftests-sockmap-redir-v3-0-a1ea723f7e7e@rbox.co>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Add integer wrappers for convenient sockmap usage.

While there, fix misaligned trailing slashes.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 .../selftests/bpf/prog_tests/sockmap_helpers.h     | 25 ++++++++++------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
index 3e5571dd578d12a6f8195bf3d25e069a1e477416..d815efac52fda9592274bb8606c8698fa4baf9c6 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
@@ -5,12 +5,15 @@
 
 #define MAX_TEST_NAME 80
 
+#define u32(v) ((u32){(v)})
+#define u64(v) ((u64){(v)})
+
 #define __always_unused	__attribute__((__unused__))
 
 #define xbpf_map_delete_elem(fd, key)                                          \
 	({                                                                     \
 		int __ret = bpf_map_delete_elem((fd), (key));                  \
-		if (__ret < 0)                                               \
+		if (__ret < 0)                                                 \
 			FAIL_ERRNO("map_delete");                              \
 		__ret;                                                         \
 	})
@@ -18,7 +21,7 @@
 #define xbpf_map_lookup_elem(fd, key, val)                                     \
 	({                                                                     \
 		int __ret = bpf_map_lookup_elem((fd), (key), (val));           \
-		if (__ret < 0)                                               \
+		if (__ret < 0)                                                 \
 			FAIL_ERRNO("map_lookup");                              \
 		__ret;                                                         \
 	})
@@ -26,7 +29,7 @@
 #define xbpf_map_update_elem(fd, key, val, flags)                              \
 	({                                                                     \
 		int __ret = bpf_map_update_elem((fd), (key), (val), (flags));  \
-		if (__ret < 0)                                               \
+		if (__ret < 0)                                                 \
 			FAIL_ERRNO("map_update");                              \
 		__ret;                                                         \
 	})
@@ -35,7 +38,7 @@
 	({                                                                     \
 		int __ret =                                                    \
 			bpf_prog_attach((prog), (target), (type), (flags));    \
-		if (__ret < 0)                                               \
+		if (__ret < 0)                                                 \
 			FAIL_ERRNO("prog_attach(" #type ")");                  \
 		__ret;                                                         \
 	})
@@ -43,7 +46,7 @@
 #define xbpf_prog_detach2(prog, target, type)                                  \
 	({                                                                     \
 		int __ret = bpf_prog_detach2((prog), (target), (type));        \
-		if (__ret < 0)                                               \
+		if (__ret < 0)                                                 \
 			FAIL_ERRNO("prog_detach2(" #type ")");                 \
 		__ret;                                                         \
 	})
@@ -66,21 +69,15 @@
 		__ret;                                                         \
 	})
 
-static inline int add_to_sockmap(int sock_mapfd, int fd1, int fd2)
+static inline int add_to_sockmap(int mapfd, int fd1, int fd2)
 {
-	u64 value;
-	u32 key;
 	int err;
 
-	key = 0;
-	value = fd1;
-	err = xbpf_map_update_elem(sock_mapfd, &key, &value, BPF_NOEXIST);
+	err = xbpf_map_update_elem(mapfd, &u32(0), &u64(fd1), BPF_NOEXIST);
 	if (err)
 		return err;
 
-	key = 1;
-	value = fd2;
-	return xbpf_map_update_elem(sock_mapfd, &key, &value, BPF_NOEXIST);
+	return xbpf_map_update_elem(mapfd, &u32(1), &u64(fd2), BPF_NOEXIST);
 }
 
 #endif // __SOCKMAP_HELPERS__

-- 
2.49.0


