Return-Path: <linux-kernel+bounces-820676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB907B7D9DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010A8175446
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A155023D281;
	Wed, 17 Sep 2025 12:28:16 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669A2337E90
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112096; cv=none; b=DRlbG2btNYNZ8pSgM0mmq8nKipVuufl7xPBrCku9zBP5MwwVvALsH16PqR/ABOkyU1InknYquiK8HZe6rQUBMTlrIF0odvlRIdt1F33GCfbB7Z1S5vKhcda9y+iPGTW2sB6sriNMMX7dfwa4YaIeaRQkurh3Um2QvSXu0LUqYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112096; c=relaxed/simple;
	bh=p0eLd5FnxaTnLyJGUpKveSeYoTasHRMKbTQN6xHgLyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/+LA/0jQj+Mm6e8WfdpmqHnPxmCRC5cD+u58gmEXiU0xAX3FDAhaic9h4l4yqDWbvQdTIBZ3vGxpQgb+IyrPTCDLTyyiM5JahH/1GhaQlFH7bFhLTJwR6o5lEOdpwM7Oopj63UyVRWuZ73rz5bZnailY8Qj9be4pa9EsKdiZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso5268336f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758112092; x=1758716892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qD2fpIrArmTyZxxLn48nFl6F/9cW6IoNw/VXQ+AiGyg=;
        b=Nz3kikGTStOHegXPDt2Mp0dUgHtx541xz2xcbXLV2Lo6QsLEUvSbbDQvmxgLHo3sk/
         DbhvBG0nYjRxe79quJlMOZKcjZU3yzQczw97uGb1fzjz+vBeKeQFzmCJhlWMFWN8tZcN
         r1eaPsJ1S8s36m7cmIiYmQNHmB4BYvClYSHAj+xB6E1fwfViu5N91F8HeLRgE8kyS0wY
         3H0M1Fj5BsEO8tGq2egiLIgzJ0LASRKw6ATTTNTZsEpImY9ig/hqNML1Gy6LmOxc8qnQ
         YsblnFkSii4f0sRIbHKZrKZG7mJhSOszmZ33px/e+vK4HJRoWt7OlmjIf9GfxBqDUlJU
         T1ug==
X-Forwarded-Encrypted: i=1; AJvYcCWcMp78gq/HHIO8kgaUImQLiUuzG/JsAIpoiH7DxVCC0+rI4x3MYLTAYWJ9zKPClbXF4zIF4sTl3gnYkYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkoLEfEu3q/KovzZMxP6LFHDdyhKu/4s2Rrm6WPnco+QV+5XPM
	dGV7nRsj7U1+I9YRdwGNL56eJp46mCHs/9eyKK8B52BeAOd2IeEJ6RLQ
X-Gm-Gg: ASbGncu7fnaC4z+vEr1J9TW0c2SZzaCrKdh0sdElznFrTVnxdppdE6o2enHn5p8dnDh
	cWjyiTgn3eDNqosF786jq8hjgv9+vBZE6d/0cDK5KEpS4uO20y+ZicdZ/4Vl01M6dXCZtKR0qwA
	P+Jf1AmJeyvDgZ2nsGAZEtQ2bJw6hX6HD2Anj5e3MUNdVlkONaNzEPIFRdM26ehUcYQwZkgjP42
	HkM4leXoeGMyBn0gunP94X1W6VaXi1WnpyzjAcOBqPSIMdizZ6TFXuioLG/rLLGxMkMApcvDtvE
	XtVwoFw63RBmIdpb9WSNz7QE3H/Gm2qyPPDDkKEcDjab3e/MFdUhuggbkQp75pDZvj2O1Zx+e03
	9KYi2CgGs
X-Google-Smtp-Source: AGHT+IEhRdB7nBids5w22yMAJVOTFKi7URkF3KNMkIzMofyDJUedOPZhjL9ZUsgPqYsxBt2TT+mIxw==
X-Received: by 2002:a05:6000:2313:b0:3ea:6680:8fa3 with SMTP id ffacd0b85a97d-3ecdfa35214mr1949003f8f.42.1758112091433;
        Wed, 17 Sep 2025 05:28:11 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e911188fb9sm16275658f8f.28.2025.09.17.05.28.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Sep 2025 05:28:10 -0700 (PDT)
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
Subject: [PATCH v2 1/1] selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled
Date: Wed, 17 Sep 2025 20:27:50 +0800
Message-ID: <20250917122750.36608-1-lance.yang@linux.dev>
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

Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
v1 -> v2:
 - Rename softdirty_is_supported() to softdirty_supported() (per David)
 - Drop aarch64 specific handling (per David)
 - https://lore.kernel.org/lkml/20250917055913.49759-1-lance.yang@linux.dev

 tools/testing/selftests/mm/madv_populate.c | 21 ++-------------------
 tools/testing/selftests/mm/soft-dirty.c    |  5 ++++-
 tools/testing/selftests/mm/vm_util.c       | 19 +++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h       |  1 +
 4 files changed, 26 insertions(+), 20 deletions(-)

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
index 56e9bd541edd..ac41d10454a5 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -449,6 +449,25 @@ bool check_vmflag_pfnmap(void *addr)
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
+	if (check_vmflag(addr, "sd"))
+		supported = true;
+
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


