Return-Path: <linux-kernel+bounces-850118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD67EBD1EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E666B1898A83
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9EA2EBDC8;
	Mon, 13 Oct 2025 08:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haO72Ys6"
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2722EBB98
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342788; cv=none; b=fNcp16Uo8zJspGl75sYxnQOF50TZzYUv/09UiMmm7ocAHNI0EIQpD5s1sC4VUE1yUz7q3/GnuI/YZAUbMgLPyRqegsdVUaZsT5vHFxuBGiMeG+CSEe9tXZpmIrvhDmSrtEqYmEeXKlf9vrTWmXSntrSIdDexKghPwDO/KteuzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342788; c=relaxed/simple;
	bh=hOAOtEgXEfPvU4v1A+ZiU4lUFGwlOBRW3P5putUViRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rM4jU2PtVw7OL1T9N4ZKt/vDkJZKLGsiX84m8isxvJJ27c000IjapmPVw5WOV6EtGFjsHfaK6QNPmXvjcruO9BsakEHyGIvvR8JkXY7DqZ7UhRGPvBVD5TkgG45FLvg1RgS3cvVVbE0OKmIRiDGihTkjQBn9ixV3RSlNdp18Z58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haO72Ys6; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-28e7cd34047so30451605ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760342786; x=1760947586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJhftlCC5zOMQAdQm97nUSpZIu/xXzcsfGJG7Gx/j5A=;
        b=haO72Ys6dSz+0Nd7TXaREHi6PgGvXTJEwxzBUtQ/3KbvWmu13C/7vBGQOjC+nut+ni
         h/2fUvAiTYlvNQ64u1UXHhzVW8QoYeyc+xzX2qHj5eiv5UcMZ2PnC034HHHDTGL3JXpm
         E3cKtGDolUnoW9VwwJtvQswfR7Dkw8vPkftZR3l6CeOXVTSG8zTNIT2j9gl6+YBsc3ZL
         GUKFaU+RGnCSAJMU6Dld+bF5TbcYS3jjYz8kOZKkz8c8ZIUAnCLvjkO8562WTPMEq1Wq
         go4yxm701KJBHBeDJOjvILHC7ohXHyUMLldgsZwSEahqe/lxMLETXrutPJt62o1WMbAF
         /EFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760342786; x=1760947586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJhftlCC5zOMQAdQm97nUSpZIu/xXzcsfGJG7Gx/j5A=;
        b=Qr5a8qqRorpfTog0flSm3VqhqzWAOHHA47noolLlrnROCRSDyxeujEiRGivhwvkBSr
         3q4HLNTKC7AnCJbbfY3kiw/EULjTL7s+GNZLpeEMrj4YT73sO1OlMgHaq8k+0CJMS8xR
         nvTznEmL2VdihZH6QuS7FD0iKUSk8POBkxy+ktNgL9ANosLP8DDdeqbQgqpx5CPKVX4b
         QjO2rA9tmVj9X4J3Z4gR9bSdW1Aj5STmizImJfDS/45cPr/A4b28Ky8PlCDNGWzEvMy7
         Gjnz60We5NsuE4i1J1vHc9EnjaHVnbcqzafgfdppl2uMgUcBr1MxF+YrGzkhc632XA43
         Gr3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3MrgRlRzFE0dSJD4SxKlbVyBGdouRnGmCpN/CMWAkzvAd7LQN1tOJpyq83r5xDuT9wXYR5Al7wnxahkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Sm7rcOA6rnYOZC+bYn/ElrjpdrWm3fMIpMKXlzHCtxpmjZXz
	kH9hHD69bIISwcsBE8G8ldyVDlL1CSCOExW8VRIpPRJmiaAHOyaj1g0d
X-Gm-Gg: ASbGnctuqR63NvbVZdQcdYKTYfWFPzW65pSEwkPReU6n46YKh+DpUa9SRrqJ8J0bQ/a
	OHNHUZ4IHqIEA8kSB18WMfWPbcgo0r2gvzml+JxPM9WqLy4/A5NQBVNeU2zgcWhh9+EbqKVzvNF
	qEldQna/lqyKApLf6Kr1YD319iiNgP2Kh6T6RmV+AuYv88C1dcnbl5G7hzvLJbRvG634AL+54IP
	6kWPaYqo1A8xmhjoNV5ym7BIwwTlKidzXcNV8koiHRgigl4BEqJunhyUmBU/CGPrCrswRbOdw2L
	xI2zPKBUCsvBEKwv+x/7DgSrS3VrF6FX6NmwdhTiucDMEV15CPgA+QmYzgXUBvmNd8NdkasoxFL
	PouqUQYUuR07a/DDFg5EWOc/HpuncvwOTg00HZbqP
X-Google-Smtp-Source: AGHT+IHQ13043OGf3lzcCk9/yyoLOoTPckOlyzbHmy01yW+ikauf/ymfxMTzft2/j6RWotQ9xEd8TQ==
X-Received: by 2002:a17:902:fc4f:b0:280:fe18:8479 with SMTP id d9443c01a7336-290272e0ac5mr225467645ad.51.1760342786027;
        Mon, 13 Oct 2025 01:06:26 -0700 (PDT)
Received: from HUC.. ([202.43.239.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f070basm126638635ad.77.2025.10.13.01.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:06:25 -0700 (PDT)
From: hupu <hupu.gm@gmail.com>
To: namhyung@kernel.org,
	irogers@google.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: hupu.gm@gmail.com
Subject: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
Date: Mon, 13 Oct 2025 16:06:09 +0800
Message-ID: <20251013080609.2070555-1-hupu.gm@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When cross-compiling perf with the BPF option enabled, Clang is used
during the build process. Some environments may require additional
compiler options such as `--sysroot` or custom include paths. This patch
adds a new make variable, `EXTRA_CLANG_FLAGS`, which appends user-specified
options to `CLANG_OPTIONS` during BPF skeleton builds.

Example:

  EXTRA_CLANG_FLAGS="--sysroot=$SYSROOT"
  make perf ARCH=arm64 EXTRA_CLANG_FLAGS="$EXTRA_CLANG_FLAGS"

This enables more flexible cross-compilation setups without modifying
Makefile.perf directly.

Signed-off-by: hupu <hupu.gm@gmail.com>
---
 tools/perf/Makefile.perf | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b807ef..b0da7314a0d8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1249,6 +1249,11 @@ else
 	$(Q)cp "$(VMLINUX_H)" $@
 endif
 
+# Allow users to specify additional Clang options (e.g. --sysroot)
+# when cross-compiling BPF skeletons, enabling more flexible
+# build configurations.
+CLANG_OPTIONS += $(EXTRA_CLANG_FLAGS)
+
 $(SKEL_TMP_OUT)/%.bpf.o: $(OUTPUT)PERF-VERSION-FILE util/bpf_skel/perf_version.h | $(SKEL_TMP_OUT)
 $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
 	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
-- 
2.43.0


