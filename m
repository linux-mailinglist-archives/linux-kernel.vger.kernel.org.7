Return-Path: <linux-kernel+bounces-859217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7E8BED097
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 15:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB7719A5DDB
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 13:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC862586C7;
	Sat, 18 Oct 2025 13:38:19 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A71BC3F
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760794698; cv=none; b=gErieEW4AP2dd15zNd2fZgi2J/T3vTTErOYL91WykO8Gfj/jfITN9UguR6V/4SpGBaVF5UB0XtYyTH6vM3+Ett9IE3P6k5HuS6P0AjoQFXKuMikI37nDH0tH/V/Uz7MglAALBPfe4eQaL81DH2AZ7cMVxTQHRovv0I50yfutmW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760794698; c=relaxed/simple;
	bh=sPGtwzrC1GmomyQqJeLN6Qfgm31aqalZTY0prjFQQd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvjl3seadvK/ABEkcC2ILI0yJJ4GvBhUMEOXYnTsYtlLN86A4NWuPd27bJTNApVT++/KVgFR5wvvXybZAMp6PLPl1XXG6qQcObjAUuJf89q8dA2rjH2F7a7x6zss1/6ch3qUMVj1A9slCC6KJe/W0KpQ7xHPexfr9ttt/OVBZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from x415ea.. (unknown [101.14.4.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id 038D935120;
	Sat, 18 Oct 2025 21:38:05 +0800 (CST)
From: Bill Tsui <b10902118@ntu.edu.tw>
To: oleg@redhat.com,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Bill Tsui <b10902118@ntu.edu.tw>
Subject: [PATCH v4 0/1] arm64: ptrace: fix hw_break_set() to set addr and ctrl together
Date: Sat, 18 Oct 2025 21:37:30 +0800
Message-ID: <20251018133731.42505-1-b10902118@ntu.edu.tw>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016154401.35799-1-b10902118@ntu.edu.tw>
References: <20251016154401.35799-1-b10902118@ntu.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the unused functions detected by kernel test robot.

Link: https://lore.kernel.org/all/202510181547.dI5kyPuT-lkp@intel.com/
---

Changes in v4:
- Fix build warning of unused functions by moving ptrace_hbp_set_ctrl()
  and ptrace_hbp_set_addr() under CONFIG_COMPAT and add compat_ prefix
  to the function names.

Changes in v3:
- Remove patches for arm32 and compat ptrace
- Rewrite commit message
- Reformat the arg of the added function

Changes in v2:
- Fix username

Bill Tsui (1):
  arm64: ptrace: fix hw_break_set() to set addr and ctrl together

 arch/arm64/kernel/ptrace.c | 90 ++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 32 deletions(-)

-- 
2.51.0


