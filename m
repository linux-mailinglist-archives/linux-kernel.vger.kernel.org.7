Return-Path: <linux-kernel+bounces-832131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE09B9E6B7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF89D3B318B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91AA2EC569;
	Thu, 25 Sep 2025 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afxlkyLJ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C12EC548
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792987; cv=none; b=Gg2/36TY+HA7QEsCDM08a58m2Q/HTlHHGoPQJsgh/gK9Htnme4BfD72lLGEzbLe95Z1YRB8exlYu3r8RkI8Kz9cgdvygzHSqnsMOkZ2Tc7LRGdrpvJiX1nRgN5Z4/EuHbRX1TEOMaQus15iCwKlg4zg3fCA5Z/LC+NfTF5yhqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792987; c=relaxed/simple;
	bh=rTyTIq2Gt2gZfhvU599hCfa9TalaA8vvAUh5cmEGHjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBIUKtmSelLfFQhQYHFMNTaU7njxybW4Wj9d9XF3usJt7uFshIXKtF1yGeJdlKDUYeL4y6f2ghDfRA3RNrj0K/8gp4n7WiK3hqN542RbyDj2D5MtuToe7LzgvW9ghy8yKVA39U7L/SEpfdvhkqngBQIYLTb6qozClzch9jePJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afxlkyLJ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-634515fc54eso111759a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792983; x=1759397783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5P9HAgv0spV6XAbBHSQmLkVBFZMqhz0/VJATkPbzJU=;
        b=afxlkyLJZGhjONrtPeNyiVBayHCtEHj1OlMFnjJu9Sd8Vrt5sTjjWiaePsli9FI5M4
         2uwMKsEHkyT390RkrDBx9i/xOU+s/r9uvOFi0MJz9+JJWe+IW6buBeG/BH+QbqxiiHrw
         8nGzRMoJ3pdU4vD59Q6IoaPT21Pe70Xjn7zwqBafobIDChccsDdFD03KrwHJ0q9lBYmx
         5/GCZHn8Qhri3BUDONR9hJ8Ux2+s6lpGf3iFoX4psumI5/r2iYHtfokE4bYNsp5b0dkk
         aBD00X4AXvtYq8WY3mVP+Yp2d4u+clSpeDFnyO5cI9kYFknmHbUnEPl6I4UDX41dQyOF
         yf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792983; x=1759397783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5P9HAgv0spV6XAbBHSQmLkVBFZMqhz0/VJATkPbzJU=;
        b=q70pMBeQa882GyvTyrNEE1ubaBp45BF4Ls/iszz1yViG2ff/q0YpMcY1+zeGfajvAd
         AVuLTeKhz9/vg9fG3v7GB8hMM1gHBfbb9FCMBtbYwyJIk3aHLFdonzX1dup43qh3IDRM
         2OvMADZVi5MfEwWPzky0tGea9rMT8UHPBVO5MOsIlDyeY0wpm/R/O/YjORkIeBQe8QMt
         sEv+Xa2Y+HjLqIM+sMJsw5MXhwvOK6onBT0NTKuWEMpver5UQCRLKLb8/5hNv02Y0wDo
         ddO4GQQfC2nXELVdkEPPd6TJeOt+N16PzPn/b++aCo7Hgbx5ae3HUYvpNU0Z5I34UuA2
         O6ww==
X-Forwarded-Encrypted: i=1; AJvYcCWIZvez/1Tha61yykOQ75TYJ4a+3nbkZ5iqSQo+lQx2k6Ye5LJ2QKW5JBbJ7VO5D0ycrOZRPLdzimrnd6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwveGSyr4I9c2wCH1XvlxmamHX4slKrVhapgBX3N41snjx4MxuT
	wSGlFqAi5c9dyRitdG9Iw5iZYdspwhtb642Pdi1iM+4IrBqCQVmofAAr
X-Gm-Gg: ASbGncsr4/dHJ8GED6uT1rn9NmDStZbxGbWmPLfdx/L+9iaoyGxuP72+lL0QstTBXFD
	EVX6CbxJjHDw9G/EBm2zC55My4UJIHdz1qXQ8bXeFBziBFyKcds5soYk0216KBmZ1I8wfw5fsCi
	XlWKqzemhFfxY60lzX6TzdV3x64kv2tBNpxBPwsTaLj+TrA3u8y341t2tzhkt1v4qcRMa8NSvJm
	Y7AAYbeeyLNaJEMPLgXchq93gfUXfXy/AmhmZD9uq4L+OIxotAd3C1kkW/MkcGsXCbCtUgUdqby
	3PcYS3Xv7kIX63jB49dC4mSZ9v3Cz0KZzVM+Btc4jZ4DhJDXKVdrAikc0q3gnIcb2cBj7jjLlNJ
	VtZhAwbVbSVJLREHrTUTGk+bwcPc=
X-Google-Smtp-Source: AGHT+IHcM6qkfDyv/1e8fv53As/ulPyDAGJd3thgnBDOPvu2/mrkEMoViXuKAJywV6PNSzaebMjldQ==
X-Received: by 2002:a17:907:6d11:b0:b1e:cfab:834c with SMTP id a640c23a62f3a-b34b4be4f65mr163980066b.0.1758792983194;
        Thu, 25 Sep 2025 02:36:23 -0700 (PDT)
Received: from bhk ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm941225a12.24.2025.09.25.02.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:36:22 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	linux@jordanrome.com,
	ameryhung@gmail.com,
	toke@redhat.com,
	houtao1@huawei.com,
	emil@etsalapatis.com,
	yatsenko@meta.com,
	isolodrai@meta.com,
	a.s.protopopov@gmail.com,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	vmalik@redhat.com,
	bigeasy@linutronix.de,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	mrpre@163.com,
	jakub@cloudflare.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v3 3/3] selftests/bpf: Prepare to add -Wsign-compare for bpf tests
Date: Thu, 25 Sep 2025 11:35:41 +0100
Message-ID: <20250925103559.14876-4-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-Change only variable types for correct sign comparisons

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 tools/testing/selftests/bpf/progs/test_xdp_dynptr.c          | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_loop.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_noinline.c        | 4 ++--
 tools/testing/selftests/bpf/progs/uprobe_multi.c             | 4 ++--
 .../selftests/bpf/progs/uprobe_multi_session_recursive.c     | 5 +++--
 .../selftests/bpf/progs/verifier_iterating_callbacks.c       | 2 +-
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
index 67a77944ef29..12ad0ec91021 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_dynptr.c
@@ -89,7 +89,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp, struct bpf_dynptr *xd
 	struct vip vip = {};
 	int dport;
 	__u32 csum = 0;
-	int i;
+	size_t i;
 
 	__builtin_memset(eth_buffer, 0, sizeof(eth_buffer));
 	__builtin_memset(iph_buffer_tcp, 0, sizeof(iph_buffer_tcp));
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
index 93267a68825b..e9b7bbff5c23 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
@@ -85,7 +85,7 @@ static __always_inline int handle_ipv4(struct xdp_md *xdp)
 	struct vip vip = {};
 	int dport;
 	__u32 csum = 0;
-	int i;
+	size_t i;
 
 	if (iph + 1 > data_end)
 		return XDP_DROP;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
index fad94e41cef9..85ef3c0a3e20 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
@@ -372,7 +372,7 @@ bool encap_v4(struct xdp_md *xdp, struct ctl_value *cval,
 
 	next_iph_u16 = (__u16 *) iph;
 	__pragma_loop_unroll_full
-	for (int i = 0; i < sizeof(struct iphdr) >> 1; i++)
+	for (size_t i = 0; i < sizeof(struct iphdr) >> 1; i++)
 		csum += *next_iph_u16++;
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
 	if (bpf_xdp_adjust_head(xdp, (int)sizeof(struct iphdr)))
@@ -423,7 +423,7 @@ int send_icmp_reply(void *data, void *data_end)
 	iph->check = 0;
 	next_iph_u16 = (__u16 *) iph;
 	__pragma_loop_unroll_full
-	for (int i = 0; i < sizeof(struct iphdr) >> 1; i++)
+	for (size_t i = 0; i < sizeof(struct iphdr) >> 1; i++)
 		csum += *next_iph_u16++;
 	iph->check = ~((csum & 0xffff) + (csum >> 16));
 	return swap_mac_and_send(data, data_end);
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
index 44190efcdba2..f99957773c3a 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
@@ -20,13 +20,13 @@ __u64 uretprobe_multi_func_3_result = 0;
 
 __u64 uprobe_multi_sleep_result = 0;
 
-int pid = 0;
+__u32 pid = 0;
 int child_pid = 0;
 int child_tid = 0;
 int child_pid_usdt = 0;
 int child_tid_usdt = 0;
 
-int expect_pid = 0;
+__u32 expect_pid = 0;
 bool bad_pid_seen = false;
 bool bad_pid_seen_usdt = false;
 
diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
index 8fbcd69fae22..017f1859ebe8 100644
--- a/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
+++ b/tools/testing/selftests/bpf/progs/uprobe_multi_session_recursive.c
@@ -3,6 +3,7 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <stdbool.h>
+#include <stddef.h>
 #include "bpf_kfuncs.h"
 #include "bpf_misc.h"
 
@@ -10,8 +11,8 @@ char _license[] SEC("license") = "GPL";
 
 int pid = 0;
 
-int idx_entry = 0;
-int idx_return = 0;
+size_t idx_entry = 0;
+size_t idx_return = 0;
 
 __u64 test_uprobe_cookie_entry[6];
 __u64 test_uprobe_cookie_return[3];
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 75dd922e4e9f..72f9f8c23c93 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -593,7 +593,7 @@ int loop_inside_iter_volatile_limit(const void *ctx)
 {
 	struct bpf_iter_num it;
 	int *v, sum = 0;
-	__u64 i = 0;
+	__s32 i = 0;
 
 	bpf_iter_num_new(&it, 0, ARR2_SZ);
 	while ((v = bpf_iter_num_next(&it))) {
-- 
2.51.0


