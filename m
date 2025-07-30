Return-Path: <linux-kernel+bounces-750092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D4B1573A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 03:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1BE188EFED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2B91E833C;
	Wed, 30 Jul 2025 01:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGnvmT4F"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BC71DB34C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840387; cv=none; b=jYdjMOrR/4IGD+IYyDyZs0IKjqZgLhFkHGtN6p+mJPiZ12vMHX2ayxelz/m7/ruC//4m/6w9MnWsF/l4dQH+N1iP+1XoU4oRNNhv5kHzgP47OUmt1DqqUI56dWUprQBsPJ2kvppO0y4bxof2OPPejjREAKC9KFWGO4afCa35mpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840387; c=relaxed/simple;
	bh=9mfsWfmUsxiv7jb5H3bplGyE+CRlpRWvLjb17tNh4ZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PI4K/PGOlQOZ4RraobCqR+7msSThgKGH2AIt9DPh1ZZXHP58RpsXxH7ES8wtfufKOzAqJ7UJonEyqwS1+82Xh4I+ilvJh7nGpzHA1bRBL2FsojT1J5AVkeZY/j4Pqj0M04oFH53HNShxCIqHiEaygTColfRnhSGP5+xrmOSQD8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGnvmT4F; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e8e0f471340so3362087276.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 18:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753840385; x=1754445185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwXkEgtGYM3RCYPAf/S015/LYrl5duHz2m34ToaHnr4=;
        b=XGnvmT4FZkWNJnA+CoRcSrPJbdTvpsu7qIg5P/cXi3Gc436+eTrcGlIUo2Y2CxFFPk
         HKT2CPdPqJjvUKFLwznA+WB6Eigr/u4OQ2udiDYqnjrhybLT5fOdDrF8GOYU2FcT5sD9
         +9Y5Hssp+EDog0kHCNJQW/leQOGjcadjZGj+kWKX0k12z2+pQ/jnPtlcOi4BZOCKAais
         85LXpj40z55LhReBZkaBMoIEGzGpUI6s5lCXHJMXdjxHYPaONR5IEYBe/V4IiAvlrqUx
         YyXeN+SUFD77aRxQym9zgNLUG92UkSxC9eSLnGJw3Qs05qovF45RUNnWIlchTkz9oLI7
         Mmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753840385; x=1754445185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwXkEgtGYM3RCYPAf/S015/LYrl5duHz2m34ToaHnr4=;
        b=XMNW56eObstOtoJyuYS5+dT3gJuqrx9BDWt4p8sAyabtHsDOzNdCuaKl8r07KqbLK8
         NTK7B9hEaGwp0VyZTOdmCWhTWdYO1VxBwQtIwtDtPAj3Ru/NEy+GJGI62IqHJSIumsF4
         bt4z9nbFfLa0R84M5IQB64MrG68tBvadTgPwVHGTP6PUUeTUlcURiYukd5QmUSMqoZtq
         maCxlE7qsPRPsUrkAqMMjqn6gRXKo5+BvDOjpgpi+NvsrLcTy9DkSTVsiMwMAQ2hcXl9
         MYdt2Gn+ivX5lLDd69idnB1R2XHQyjEIl60Sc4KQScqY1zFQPEGSgNQlw+iTJcep/f4N
         4vrg==
X-Forwarded-Encrypted: i=1; AJvYcCWV16uv+eqMNUI1AZf/aOwf1LePIwkYp4htNvneTWYgMrmFJACsnpvRdWQT3YJdvOkdRL2xs5Ai/UXMEaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUcEnxI6onrOakqeNfnFGqv6aQVZl4tz8zxusQUez4IQlfsuw
	vWHm752ZsdVPJWPQM2Rix8MnGYaehcwYT2rZgTyfFhcu8VzuNsV40Q197YqfaUw3NDhQ+ZF9on/
	YT+ZfKiz/zpkbLz3C1yGWtp3aZhvho+mn6V4vwA==
X-Google-Smtp-Source: AGHT+IFMN87Pheb34MK37buANyT4ygN7EuRFMXC1Jr/7dhlCcyElEAYQTT7X5PQ8XI+jtHMXndENYbmFMJ7WOBut09j/6Q==
X-Received: from ybbgf9.prod.google.com ([2002:a05:6902:6009:b0:e8e:19a8:976a])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:1604:b0:e8e:219f:a662 with SMTP id 3f1490d57ef6-e8e315b5213mr2128772276.26.1753840384801;
 Tue, 29 Jul 2025 18:53:04 -0700 (PDT)
Date: Tue, 29 Jul 2025 18:52:43 -0700
In-Reply-To: <20250730015247.30827-1-isaacmanjarres@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730015247.30827-1-isaacmanjarres@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730015247.30827-5-isaacmanjarres@google.com>
Subject: [PATCH 6.1.y 4/4] selftests/memfd: add test for mapping write-sealed
 memfd read-only
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: lorenzo.stoakes@oracle.com, gregkh@linuxfoundation.org, 
	Shuah Khan <shuah@kernel.org>
Cc: aliceryhl@google.com, surenb@google.com, stable@vger.kernel.org, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	Jann Horn <jannh@google.com>, Julian Orth <ju.orth@gmail.com>, 
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

[ Upstream commit ea0916e01d0b0f2cce1369ac1494239a79827270 ]

Now we have reinstated the ability to map F_SEAL_WRITE mappings read-only,
assert that we are able to do this in a test to ensure that we do not
regress this again.

Link: https://lkml.kernel.org/r/a6377ec470b14c0539b4600cf8fa24bf2e4858ae.1732804776.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>
Cc: Julian Orth <ju.orth@gmail.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 94df2692e6e4..15a90db80836 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -186,6 +186,24 @@ static void *mfd_assert_mmap_shared(int fd)
 	return p;
 }
 
+static void *mfd_assert_mmap_read_shared(int fd)
+{
+	void *p;
+
+	p = mmap(NULL,
+		 mfd_def_size,
+		 PROT_READ,
+		 MAP_SHARED,
+		 fd,
+		 0);
+	if (p == MAP_FAILED) {
+		printf("mmap() failed: %m\n");
+		abort();
+	}
+
+	return p;
+}
+
 static void *mfd_assert_mmap_private(int fd)
 {
 	void *p;
@@ -802,6 +820,30 @@ static void test_seal_future_write(void)
 	close(fd);
 }
 
+static void test_seal_write_map_read_shared(void)
+{
+	int fd;
+	void *p;
+
+	printf("%s SEAL-WRITE-MAP-READ\n", memfd_str);
+
+	fd = mfd_assert_new("kern_memfd_seal_write_map_read",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	mfd_assert_add_seals(fd, F_SEAL_WRITE);
+	mfd_assert_has_seals(fd, F_SEAL_WRITE);
+
+	p = mfd_assert_mmap_read_shared(fd);
+
+	mfd_assert_read(fd);
+	mfd_assert_read_shared(fd);
+	mfd_fail_write(fd);
+
+	munmap(p, mfd_def_size);
+	close(fd);
+}
+
 /*
  * Test SEAL_SHRINK
  * Test whether SEAL_SHRINK actually prevents shrinking
@@ -1056,6 +1098,7 @@ int main(int argc, char **argv)
 
 	test_seal_write();
 	test_seal_future_write();
+	test_seal_write_map_read_shared();
 	test_seal_shrink();
 	test_seal_grow();
 	test_seal_resize();
-- 
2.50.1.552.g942d659e1b-goog


