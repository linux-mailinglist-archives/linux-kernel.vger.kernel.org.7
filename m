Return-Path: <linux-kernel+bounces-820837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23587B7F748
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A541C27ECA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA22831A7F4;
	Wed, 17 Sep 2025 13:34:00 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E434E31960E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116040; cv=none; b=JF67YDvyVF7mV/5TPK49N6S+Tkgpz7DWYx4hfP8HRJFdf4kS4gu1BFssrlzTKDecFut9C+C+fPNHP0cTxLj84n3SZIg9cvoCUiuLmtPQPyXFIuuuZn5Bgkpmk4I0uEVbDJFa+KgRCmDiGUzbiuc3yQYobTI2/SPLm39jCec/DTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116040; c=relaxed/simple;
	bh=GuO132UD6kDNK7GM80KvsDR2s46lSBmWg2yAjSMD2iA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rw9z9OKij+VPdHin+Ki8h/06K0mubg61mpyAe9BZZCMaScaGPzkPlfupJNjxlZOJXqnC3u5cuWs74E74JAn9krrLHFEPEsl75TCTe/SKG13MmTNXTo+kWRbSe3YMWxn27F6Wg7+JUs3wZeHbhIQKf8Ny1Wy8nNgY0L2FZdxOZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso59850285e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758116035; x=1758720835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PB/dLP6okMS4UB2K8/m8T0leXGzvWyq468DHfShm8FI=;
        b=sjTb2vGB6cOa4i+wEVyqQp8B2lG9a0KsJDRHSivlPxYKge7WS9LhqC2Gs+bmGEEFqK
         edLa/7Aaoz0wk1i+w1XoZINnslixwU/rCqwZnkzcTBJvdS8Xrj1DC96uhpdTFoBIgWiH
         DLr68x5Y5y4FGdRjqq5FoUwqnIK+P5bjuEjqyN9P67quPaA12VZQNlz1uoxKPHvmZyO4
         fFO8dPg8e807eaGqe4ZFerHVGS4bkHjfSVdvIh3Y/GxfUUmaDs0yzoM/nLHW0vWt/xjz
         BHZO4T73enAzenYu0VQJN8ZHHsJVFHPAV6wtiEoFwQOBHkqM30PS5VP/BIPKFhsRkbDp
         XR3w==
X-Forwarded-Encrypted: i=1; AJvYcCUkd/EWmXgTg00sDPed8p9CdAkmIbdvOPC85fwlFzM+nE9Wl7vjLDwAypRVB858iZvsH0XgIsPSJle9Gqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcqk9/TtiS13l2r3M6V+fTcneF2+Naq4MSVz5zvrCe3gsngfzA
	h54DFkDV3U5RsQuZeXzYLICiieRApHg/g75iNsbFmQmt+5yzeBgKLJid
X-Gm-Gg: ASbGnctlmfrotSuVveCvWD2EIcz8kaRbJyvQU4LqY7KbeKHPl+CpWcnuERCj/mYVNIr
	KAppeD4y5tEhSgKeW9PHElgfrb+nP4F3n5tSxE4ncC7RlH3tlHWbMsu3tJnEtnuTa+nMqzRrn4l
	zgtbAMkV74S9px41RxziTMdKQgogZaeteQyQdj/ZhzdcXqWehkYHsW6uJmY2DZuw0PRkdQWH32O
	o6zgffAMGHSTasfIP6t+JBcW1TguHQacQZeuOGTDdnIOnjfVIHx+El+mWLjWS3uohABnSST38xJ
	GPKs/qVhBARvw5U0TpIej5LNfAPC+AuEQDzKYIDziCquKuU9koIElysGmzzLJbqiGd7Ke4YRzpK
	SuFH/u5fpuGg=
X-Google-Smtp-Source: AGHT+IHct0Y/HPdTudotgDrMkhOC/Gqh0P/h5DFuXgasUmqgBiIUkvyCvRBlCVJGcbLI22/xe1VfaA==
X-Received: by 2002:a05:600c:3547:b0:45b:8039:6196 with SMTP id 5b1f17b1804b1-46201e96069mr23430525e9.4.1758116034842;
        Wed, 17 Sep 2025 06:33:54 -0700 (PDT)
Received: from localhost.localdomain ([2a09:0:1:2::30b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdd4d15ecsm3871446f8f.11.2025.09.17.06.33.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Sep 2025 06:33:54 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: shuah@kernel.org,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v3 1/1] selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled
Date: Wed, 17 Sep 2025 21:31:37 +0800
Message-ID: <20250917133137.62802-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

The madv_populate and soft-dirty kselftests currently fail on systems where
CONFIG_MEM_SOFT_DIRTY is disabled.

Introduce a new helper softdirty_supported() into vm_util.c/h to ensure
tests are properly skipped when the feature is not enabled.

Acked-by: David Hildenbrand <david@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v2 -> v3:
 - Optimize softdirty_supported() by directly assigning check_vmflag()
   result (per David)
 - Pick AB from David - thanks!
 - https://lore.kernel.org/lkml/20250917122750.36608-1-lance.yang@linux.dev

v1 -> v2:
 - Rename softdirty_is_supported() to softdirty_supported() (per David)
 - Drop aarch64 specific handling (per David)
 - https://lore.kernel.org/lkml/20250917055913.49759-1-lance.yang@linux.dev

 tools/testing/selftests/mm/madv_populate.c | 21 ++-------------------
 tools/testing/selftests/mm/soft-dirty.c    |  5 ++++-
 tools/testing/selftests/mm/vm_util.c       | 17 +++++++++++++++++
 tools/testing/selftests/mm/vm_util.h       |  1 +
 4 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index b6fabd5c27ed..d8d11bc67ddc 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -264,23 +264,6 @@ static void test_softdirty(void)
 	munmap(addr, SIZE);
 }
 
-static int system_has_softdirty(void)
-{
-	/*
-	 * There is no way to check if the kernel supports soft-dirty, other
-	 * than by writing to a page and seeing if the bit was set. But the
-	 * tests are intended to check that the bit gets set when it should, so
-	 * doing that check would turn a potentially legitimate fail into a
-	 * skip. Fortunately, we know for sure that arm64 does not support
-	 * soft-dirty. So for now, let's just use the arch as a corse guide.
-	 */
-#if defined(__aarch64__)
-	return 0;
-#else
-	return 1;
-#endif
-}
-
 int main(int argc, char **argv)
 {
 	int nr_tests = 16;
@@ -288,7 +271,7 @@ int main(int argc, char **argv)
 
 	pagesize = getpagesize();
 
-	if (system_has_softdirty())
+	if (softdirty_supported())
 		nr_tests += 5;
 
 	ksft_print_header();
@@ -300,7 +283,7 @@ int main(int argc, char **argv)
 	test_holes();
 	test_populate_read();
 	test_populate_write();
-	if (system_has_softdirty())
+	if (softdirty_supported())
 		test_softdirty();
 
 	err = ksft_get_fail_cnt();
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 8a3f2b4b2186..4ee4db3750c1 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -200,8 +200,11 @@ int main(int argc, char **argv)
 	int pagesize;
 
 	ksft_print_header();
-	ksft_set_plan(15);
 
+	if (!softdirty_supported())
+		ksft_exit_skip("soft-dirty is not support\n");
+
+	ksft_set_plan(15);
 	pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_FILE_PATH);
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 56e9bd541edd..e33cda301dad 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -449,6 +449,23 @@ bool check_vmflag_pfnmap(void *addr)
 	return check_vmflag(addr, "pf");
 }
 
+bool softdirty_supported(void)
+{
+	char *addr;
+	bool supported = false;
+	const size_t pagesize = getpagesize();
+
+	/* New mappings are expected to be marked with VM_SOFTDIRTY (sd). */
+	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (!addr)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	supported = check_vmflag(addr, "sd");
+	munmap(addr, pagesize);
+	return supported;
+}
+
 /*
  * Open an fd at /proc/$pid/maps and configure procmap_out ready for
  * PROCMAP_QUERY query. Returns 0 on success, or an error code otherwise.
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 07c4acfd84b6..26c30fdc0241 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -104,6 +104,7 @@ bool find_vma_procmap(struct procmap_fd *procmap, void *address);
 int close_procmap(struct procmap_fd *procmap);
 int write_sysfs(const char *file_path, unsigned long val);
 int read_sysfs(const char *file_path, unsigned long *val);
+bool softdirty_supported(void);
 
 static inline int open_self_procmap(struct procmap_fd *procmap_out)
 {
-- 
2.49.0


