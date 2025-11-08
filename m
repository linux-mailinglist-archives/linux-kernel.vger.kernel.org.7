Return-Path: <linux-kernel+bounces-891579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A4C42FC0
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808781889F3D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912E2217722;
	Sat,  8 Nov 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpn239pY"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1FD194098
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762618726; cv=none; b=QcpG2Y9gb7UKgkZiuycJhN69IdYaOuIwMckviyUKEx5zr27srQEo8WhkWhqPYkQbtiTEfzK8MwbtizmQVZW8fap+59h/GX25+oBHV2C+4tJBUI+gyKHh2WvKZrEdQVnNusZWyvS4T+PqofQgRWtAkLaBKlw0ZMVPCn2JbaPnTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762618726; c=relaxed/simple;
	bh=kHu9xb/m8OnJFaZlkDBT3bgLQ5H4ttZWM1JNTx18jJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iZYM922AgqhVWMG/6cW6EitHzwZmhGf6s+eXWiH4A5+NN8V6tFHdi33lA2ZQ5oPc0xrO510Uw51jyvSVuTOWOKi3JmEbSAJAYnFv/+QPWGSDplmxr2JotuVzExIH8BhJuGFc3x4anQUpPrsuAcBrqcaGgs7LlhWsSYWsOZ35YJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpn239pY; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso1653997a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 08:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762618725; x=1763223525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vBksDJnztjGyjVxw8Yb9adtDqx05xzbEcYJxzPS4MU=;
        b=fpn239pYXOa9vag6ACQ8g8FLe5tAmuZtIDOLUE447d91G2vzz4ds/40s6eS6jI6Mvv
         U5pmIySrIXbaa0qNffFWigx2i5QjDddUNLUtsKGUXAa6rxBGUZ3Mm+kJ2x8IGFVWJ0Ho
         yWlxmhcJwvPf8PfHdWSsDlY1DOoTTQsL1kp0FM0UZRiSw4khDwlMNp/GLpFoKIZ3h4sl
         HHgr1WcJeBCjB2AYHB5r3xGTUsxp4yxhW9qOw/YQKSIQdGfDb9aurJtk842zd5pRJYj4
         Un87CRh/NVmhMPjOFVt66hx/WR/SSoh5cTYBwAkL69lHUBsZa+zKauyZEg8meBYwp5aB
         XByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762618725; x=1763223525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vBksDJnztjGyjVxw8Yb9adtDqx05xzbEcYJxzPS4MU=;
        b=ZkwH2PhGw+SCfFPuww5vmW69bqrCVysU8SkW6YTVA3jPjseUsTPaE0w8HAVyBj4hSI
         L1C9JmV2ng/1NNFPqU2sYQpuZEwGdaEOpBLCYakK501vNq38HX1N/GfiINfqjxn4XbI1
         0wTpg8QfoXjdJoV4SW+Nhp1mOVOJGfdZlfIkmwFgKCgsmd94Muu9JwLd2EkhX21bb5Wr
         gRZOYrXqq3mrybUHskfpMt6jUMKm8uNkkH+LgNvCE+Jg02dpV3imIZowdC2tuByzQoR3
         RvqV9uzy5YiE1vglkcosHvV+zrgXCdjniOY8fh6iSSBW9TVDxBX70mI/JplDOVGF041Z
         +d8g==
X-Gm-Message-State: AOJu0YwgOFTqXiBw1Odvs5bRpWGYG1mYafSrbFttDH9pDhKCbHbWIhMb
	9ERczEaVoeIFbvBa5h6XtOgbS2eD4qBRkyUbhnOz6fFBDhXkiFOX2b5U
X-Gm-Gg: ASbGnctn//YqSqbm66HllKhxT91dVaki1ulSUye0tvgUUuEG01Ylxu8OsOrFtYohteX
	WwcVjZbR4rkPh01a0rOgPKefcBLdwnyQDn6RYvxV8hb4LUK2Mk/UGQjJRNTA/XUW/6zPldZ6vgL
	X+8Ry9naBB7+u2o/fx9Ie4pihFWZUohyDhp4KgfkQHIqFY8jRpJMsp9EoSm3NVcnON2cpe/qwoW
	rAuQs6gb7xgyVwHYtl7cmZWfoGliRz8tilZuzVJbW5wwuXi3LnZ6MQVEr9+pq8NCcaR8zWJrUQa
	TGV7cOYLISZXmyBR4VkGcbWMGykK4hBqg7h6tUoqkUFaAvUOENqsOa7An3rNgcCbj4qaEiDYl3Q
	GweLEvL+uFNaf5pMvgpEBYH39ajBR3YPUhQVugRwXVFPJ2mD59hVQWBE9CMHBOC5Fz0ZM/SEZ6z
	t74oI93Ed2VVF70LHcRJDM2i841TRlOT2mK36jXIY1
X-Google-Smtp-Source: AGHT+IGLxQf5Mvke/vM2EkF6/583Zl67fDA8/F7qScezPJe1ESf4y4dMVf2DpQ3IkfNkW8uyBNV79g==
X-Received: by 2002:a17:90b:2f50:b0:340:b501:7b83 with SMTP id 98e67ed59e1d1-3436aca72a6mr3619510a91.10.1762618724753;
        Sat, 08 Nov 2025 08:18:44 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3435e25e508sm4310773a91.13.2025.11.08.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 08:18:44 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH v2] selftest/mm: fix pointer comparison in mremap_test
Date: Sat,  8 Nov 2025 21:48:29 +0530
Message-ID: <20251108161829.25105-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pointer arthemitic with 'void * addr' and 'ulong dest_alignment'
triggers following warning:

mremap_test.c:1035:31: warning: pointer comparison always evaluates to
false [-Wtautological-compare]
 1035 |                 if (addr + c.dest_alignment < addr) {
      |                                             ^

this warning is raised from clang version 20.1.8 (Fedora 20.1.8-4.fc42).

use 'void *tmp_addr' to do the pointer arthemitic.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
Changelog:
v2:
- use 'void *tmp_addr' for pointer arthemitic instead of typecasting
'addr' to 'unsigned long long' as suggested by Andrew.

v1: https://lore.kernel.org/linux-kselftest/20251106104917.39890-1-ankitkhushwaha.linux@gmail.com/
---
 tools/testing/selftests/mm/mremap_test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index a95c0663a011..308576437228 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -994,7 +994,7 @@ static void mremap_move_multi_invalid_vmas(FILE *maps_fp, unsigned long page_siz
 static long long remap_region(struct config c, unsigned int threshold_mb,
 			      char *rand_addr)
 {
-	void *addr, *src_addr, *dest_addr, *dest_preamble_addr = NULL;
+	void *addr, *tmp_addr, *src_addr, *dest_addr, *dest_preamble_addr = NULL;
 	unsigned long long t, d;
 	struct timespec t_start = {0, 0}, t_end = {0, 0};
 	long long  start_ns, end_ns, align_mask, ret, offset;
@@ -1032,7 +1032,8 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	/* Don't destroy existing mappings unless expected to overlap */
 	while (!is_remap_region_valid(addr, c.region_size) && !c.overlapping) {
 		/* Check for unsigned overflow */
-		if (addr + c.dest_alignment < addr) {
+		tmp_addr = addr + c.dest_alignment;
+		if (tmp_addr < addr) {
 			ksft_print_msg("Couldn't find a valid region to remap to\n");
 			ret = -1;
 			goto clean_up_src;
--
2.51.1


