Return-Path: <linux-kernel+bounces-825490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D606B8BEFC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 06:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A6D7C5889
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5620221D590;
	Sat, 20 Sep 2025 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1scGMp+"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0821E9B35
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 04:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758341983; cv=none; b=qYuw9XHiPBAbkvCTbHnNXWLEmIePwk7BIQIsrnbkVHvz8NJXfSxK83LsOo/ya+sz6mXt0+ZRHBByQuNWoEID6xv7FTmux5GHSdYwkPseF5NCyXoxMIfgLiwa6FZ6SKsLxOKfv72wLE2oOJ8eWWpJmN669YHGZJi8RUo5A53nPeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758341983; c=relaxed/simple;
	bh=tPb8ZwTKiJD+qGUqRVTvDMnB6kbRjplfxr68r6FEXt4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P2Wp0dXdadOsoRZtwW8cYOCS+iOVVMi022Lm+qKNVDq824xetbE9Kkd9y/WCe2fVze+wi1nFftHhkp/QXt9M2ohYTRpXG8DWsSXK1pP7slvoA/hgJOaZGThuluWj366nF3d48P2mGGyGTIKQRmAm0mPz8856qN38vGd/ZgGkZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1scGMp+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so2628592b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758341981; x=1758946781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TtQtR1uGPAfF6Ic5yrjJTv73t4pCjLo/Eqk0WSj/PCU=;
        b=D1scGMp+VShd9aDLfWe6kCNtrCywJxvY1f63YI47TlWhNQYtIs//z1XY/Axr05DkrP
         mIA4zhPv/7iExmI66iZ+LLWJSOByKTfoabMyHY0VQ/ClkO7U38ptGMLVSeMrR0lArIdp
         EuY52XLMbtemNJoopYooIqu5CNo6nPJmXURvAYQlu2J8vcpFsaWzmtTaybnSIPLdS8tf
         VaLb+2oBCNrSWrLRi7Uor8lPJX3kKwl/6DAK1h8tfHnBUcqZJ7KsuS+efStaFh6Bd6I5
         0ksEk9HvjiKHQBAztzYDFue7uM2tGf7srWbWX/lUu/bbe7Nq3YK4/yK5Dtdd6Gcny7Y/
         z34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758341981; x=1758946781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtQtR1uGPAfF6Ic5yrjJTv73t4pCjLo/Eqk0WSj/PCU=;
        b=kf2CpHERKLVm+keeRXWDx9/rFqb35TDRDNFbrxg1ABWrbsdTwwzOBE15Sbe4Jcd2ER
         duZ2UGOvRBtHdT1fyElohtJYZ8oCR+I3mL+2AIijA5NMcEGaR0IqJXPCgVrrL79v5OyB
         cLJAmLyRHGtoK2FxKDBNflesn9muxBwy2K/fFyCMNpE5XhOljkXq0mrvRiFpqV9oRyAQ
         IGVAFaJRRtNpL4swPG0aSnqMyLZjhbq5YkmpqicHCgnqwABIa3N1/NQipkQ3GF/RU1bO
         lqqv7/IuM4oq9cNLd96Mq0ap1VdzwNCgk17bf19fT+NCoOjZuAaekFmFULnMt/qQyche
         SJ0w==
X-Forwarded-Encrypted: i=1; AJvYcCWKWprqqfBp3a3chFfFBYj20Jj6DnlCGlRHsxxd1wvWgmgQ5r3Rorqz7xbR6j6CyXvEFUQ8QF2ZnmCqlkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycho23BaEgcSGonmG4UZf3JDHg+O+FnNSPIQ2CKdHoInA+dSqE
	Cifsxn2m7gRONH6P2ofp8s/ssbUSE9EEzdTrHjRBVKLE5w6ypV0fQgQ8
X-Gm-Gg: ASbGnct/vXWWOy09LUtjoZeHPcV9ZHEel4blpOvcJVP6K+BcrXc+H00s48lCoYn0QbX
	r2o8kmJYxCBTXNyQVFzgzjF41u2RAcSC/JPKSptC3kQQ7VIY89/bDCCPTCaRXfSrTsGkf+FRswZ
	jltFk6ArtkE9dbUXl9Njz5b5vAI+G2r8tgw/gRZ995/O55SsmBbZVRLixqTotmHftLwU6hPS1Cz
	nISzkQCAQirHNA+61HkyigFXSEfMR2fhhWpr14ryqiaX0qmN6iv2Jk6mgqCCwCRKj1a1YFZctx6
	7MHsnwACEY/M4UuDfJlRGDOSTZf+OY7Zv1GMdKh9wwmPOtM9BPqUnvljv+3caHjaGEp/MAb43Xp
	ZNZgs+GKawfLo/Qrf3hWgcMQpJTeq57mkR4UMMjPYtz82D0MfwXmTBUAIQIUlyx+OX4Aw7mvZM7
	frhFQEsyOiLGqb4g==
X-Google-Smtp-Source: AGHT+IGUEiDuSiuGJOo8KQHJULEexVcAUHHiZasqs4cUJt9M2KVq4dwuHSlb5BHYKooThmDf3+ENQQ==
X-Received: by 2002:a05:6a20:b917:b0:247:55a7:695a with SMTP id adf61e73a8af0-292148b82e5mr5949092637.15.1758341981154;
        Fri, 19 Sep 2025 21:19:41 -0700 (PDT)
Received: from debian.domain.name ([223.185.130.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed2771d43sm9750093a91.26.2025.09.19.21.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 21:19:40 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	I Viswanath <viswanathiyyappan@gmail.com>
Subject: [PATCH] selftests: Fix Makefile to run targets even the ones in SKIP_TARGETS
Date: Sat, 20 Sep 2025 09:49:14 +0530
Message-ID: <20250920041914.7253-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the current Makefile, if the user tries something like

make TARGETS="bpf mm"

only mm is run and bpf is skipped, which is not intentional.

`bpf` and `sched_ext` are always filtered out even when TARGETS is set
explicitly due to how SKIP_TARGETS is implemented.

This default skip exists because these tests require newer LLVM/Clang
versions that may not be available on all systems.

Fix the SKIP_TARGETS logic so that bpf and sched_ext remain
skipped when TARGETS is taken from the Makefile but are included when
the user specifies them explicitly.

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
make --silent summary=1 TARGETS="bpf size" kselftest

make[3]: Entering directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/bpf'

Auto-detecting system features:
...                                    llvm: [ OFF ]

Makefile:127: tools/build/Makefile.feature: No such file or directory
make[4]: *** No rule to make target 'tools/build/Makefile.feature'.  Stop.
make[3]: *** [Makefile:344: /home/user/kernel-dev/linux-next/tools/testing/selftests/bpf/tools/sbin/bpftool] Error 2
make[3]: Leaving directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/bpf'
make[3]: Nothing to be done for 'all'.
make[3]: Entering directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/bpf'

Auto-detecting system features:
...                                    llvm: [ OFF ]

Makefile:127: tools/build/Makefile.feature: No such file or directory
make[4]: *** No rule to make target 'tools/build/Makefile.feature'.  Stop.
make[3]: *** [Makefile:344: /home/user/kernel-dev/linux-next/tools/testing/selftests/bpf/tools/sbin/bpftool] Error 2
make[3]: Leaving directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/bpf'
TAP version 13
1..1
# selftests: size: get_size
ok 1 selftests: size: get_size

make --silent summary=1 kselftest (bpf is between arm64 and breakpoints in TARGETS)

make[3]: Nothing to be done for 'all'.
make[3]: Entering directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/alsa'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/alsa'
make[3]: Entering directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/amd-pstate'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/amd-pstate'
make[3]: Entering directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/arm64'
make[3]: Leaving directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/arm64'
make[3]: Entering directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/breakpoints'
make[3]: Nothing to be done for 'all'.
make[3]: Leaving directory '/home/user/kernel-dev/linux-next/tools/testing/selftests/breakpoints'
make[3]: Nothing to be done for 'all'.

 tools/testing/selftests/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index babed7b1c2d1..c6cedb09c372 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -145,7 +145,10 @@ endif
 # User can optionally provide a TARGETS skiplist. By default we skip
 # targets using BPF since it has cutting edge build time dependencies
 # which require more effort to install.
-SKIP_TARGETS ?= bpf sched_ext
+ifeq ($(origin TARGETS), file)
+        SKIP_TARGETS ?= bpf sched_ext
+endif
+
 ifneq ($(SKIP_TARGETS),)
 	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
 	override TARGETS := $(TMP)
-- 
2.47.3


