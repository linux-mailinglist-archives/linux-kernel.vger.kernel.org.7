Return-Path: <linux-kernel+bounces-864425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0359BFAC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98AB11A047B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF45305E2D;
	Wed, 22 Oct 2025 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1mVyeCK"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C2D3019A3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120170; cv=none; b=VET3qUVy7vNtA/pq9GhIkHgLYD/LzIo5DG4/2JZGAqwW/gEfA1aTw7PtRMBD3SWqKuRnGAkDQyRXCDDvrdHw9raodP/4jwEQh3JlNgP62xpPRh1Frm8VnHONvJ4N3jZXR2RchWrHCKl8/9jdeRaV+Xl4F4SOYKNvwYUuzNltLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120170; c=relaxed/simple;
	bh=rQf7cIrqXhFpdtblFtlpnVlrPiULOyK/btzySltR7Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PMzg0DtxatY0SsWfAJKm3b/yGzYiCdRx83aZipRb3p5g8r8PVZVOqHSReIBrCSHYnTNTwXlJoSC12P1m0RTrMJXjE1aRO7L0N+F2yf9i+M7AHtmz8+dw9QiLb/F4NNVWmnD4cbjqo8b/HFBVUZqUdaXLmDTDPSyLfrhO1YNdmIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1mVyeCK; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2909448641eso8022305ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120168; x=1761724968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+bk3eU07EvQuVpjQM0cAE/sVqM0p3Ty+ZMGLS++KRY=;
        b=V1mVyeCKE+Q9LEaLKeIrx72B+GuhCR9jVF/hn52WBMOjS6j+Yt7zj05DiUAuv2M+HQ
         jCJohRUmL/Yy3qItpLMwb7w5Ca/evKBh5ZprHUVSZELj5EKK7nBVnYrO0Dpf/dlTQYvE
         aix3FA+DKj83vM/LAV5njgNFN561B1XAOW4/fGU28NvbUj9UFB6aqegXTD/teeG7oPhN
         0eki1RCmJpgBdd8dKN+tDHMT8rI0oP+YgQZyrwtD7u8sibBGTaLFtDO74ht+SySDHnbl
         YWdAbO9N7oQKecjb6E7UA2xkvyW+1wMhqCoo0JokDwDNobfKT2xniYZZJ9W9W9rAlUrx
         vnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120168; x=1761724968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+bk3eU07EvQuVpjQM0cAE/sVqM0p3Ty+ZMGLS++KRY=;
        b=jyV6yVgyZFzf1+Qjbk+ngdGDF+c2jaTCbTECWkKJatBMHDF6N5XX5lvdVPvYG3SVCe
         XsPqMOXXxSABS0YvWlqH3ro0RW/FDU6Mt/nOYi+becAWmAXZdBFkn15Yq1C4GweWwviC
         ovsvd6ttlCjxtdFHjIi7owhUmXCB3I0ptUHidtBeqrm3OVk9sjLxn3LngoQx+YAeEOiu
         aoWXEFFU0JLTi2BmdF7//3wHqsqixITqnV2G70gpxmEkiLKmrcVF0xpZ2+Yd4CNTDKse
         mjn1MJJOuAPPVpoFOVSy5Hu/PYGr0QNd9/FNa2bx44iTAlmU4ywhceumKAMrM7LigODA
         3pBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTB2pAtieG6Hern5yPNSESxvFa+lEazbIB8G3xeCNjynhoDI2HgKVQBhpywaK4MzwKvC2w6rmmA1j73mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3eD1IeMAzSX57awfvhyeJLWLI69EHZJgCOpGRJ73ZB2/ONN1h
	8xVbq43oXzpBZW0KqulwFImqjLgvO8yLNCIJPdck8qV+cq8OsC/uYS8G
X-Gm-Gg: ASbGncsPPeXVnfIxWYbi0IwF8r4nr9HtuE5Hs7NpYmbm5KGNRcKYE2kGpYxjfEqy+Pz
	IdjscZ+Ikend/B6tH9TKQVQrpYGHlwm1lLA7Y4JC7I46GkTAhwlMpa02zsOTJxshzZ9a5tQC+ZK
	kf1fxIVF/TCX7fd20KjoUoDTP17vFrefnihrZKNCwqajQlCZVOr5HF7WUvyyBttIl3N0AurBjKS
	uxFS2+OLUKiI9ItWTj+JXiwOD4IFKh6khdce/Or/PKnFU97cbOsSlIBGiCnifn+dnUSay2IA2dp
	vWUbKKG/4J1k8aLT87wKuQDHi/3KJkbTowA5DdoKzOqKOPFA3PZqQrq9VjDGrsVeH9cU3a8zeTu
	sh1Xdvr5DizAn3RpeXdgOwaGdV4ec+SgZ8QQwwqnByjBVZUH/1opyY2Diw7As1FxJ+d8DcCAx3y
	zpHJ2vtZ4=
X-Google-Smtp-Source: AGHT+IHZbqWhKjaHa1YFzTTsX97Y9CCMc06jcvSVZQudwp5xfmvGDzbBnbpMm0kvVeibqCwk1ty0Xw==
X-Received: by 2002:a17:902:dacf:b0:271:fa2d:534c with SMTP id d9443c01a7336-292ffc32da1mr32740295ad.22.1761120168058;
        Wed, 22 Oct 2025 01:02:48 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:47 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 07/10] selftests/bpf: test get_func_ip for fsession
Date: Wed, 22 Oct 2025 16:01:56 +0800
Message-ID: <20251022080159.553805-8-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080159.553805-1-dongml2@chinatelecom.cn>
References: <20251022080159.553805-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the layout of the stack changed for fsession, we'd better test
bpf_get_func_ip() for it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../selftests/bpf/prog_tests/get_func_ip_test.c    |  2 ++
 .../testing/selftests/bpf/progs/get_func_ip_test.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
index c40242dfa8fb..a9078a1dbb07 100644
--- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
@@ -46,6 +46,8 @@ static void test_function_entry(void)
 	ASSERT_EQ(skel->bss->test5_result, 1, "test5_result");
 	ASSERT_EQ(skel->bss->test7_result, 1, "test7_result");
 	ASSERT_EQ(skel->bss->test8_result, 1, "test8_result");
+	ASSERT_EQ(skel->bss->test9_result1, 1, "test9_result1");
+	ASSERT_EQ(skel->bss->test9_result2, 1, "test9_result2");
 
 cleanup:
 	get_func_ip_test__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
index 2011cacdeb18..9acb79fc7537 100644
--- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
+++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
@@ -103,3 +103,17 @@ int BPF_URETPROBE(test8, int ret)
 	test8_result = (const void *) addr == (const void *) uprobe_trigger;
 	return 0;
 }
+
+__u64 test9_result1 = 0;
+__u64 test9_result2 = 0;
+SEC("fsession/bpf_fentry_test1")
+int BPF_PROG(test9, int a)
+{
+	__u64 addr = bpf_get_func_ip(ctx);
+
+	if (bpf_tracing_is_exit(ctx))
+		test9_result1 = (const void *) addr == &bpf_fentry_test1;
+	else
+		test9_result2 = (const void *) addr == &bpf_fentry_test1;
+	return 0;
+}
-- 
2.51.1.dirty


