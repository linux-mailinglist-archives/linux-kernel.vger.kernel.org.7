Return-Path: <linux-kernel+bounces-856518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F340BE45F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B13C1359F50
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68978350D53;
	Thu, 16 Oct 2025 15:55:04 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F3350D57
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630104; cv=none; b=jIaIJE5HQomJV+L6iru4z1KgJFmg+Hiv5nbWb6u9etJkYC575JqKEe2YQMcG35d73I1YrR/cSS3awZ9iaJz1hB9gQgJ3ZCT/kGuTs2K0O57ou8BOs2OKMCLZPFIYxFeP1JGF0wEXkC0gEPy2iRGEf+Brq07qG8OiAb57W66R7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630104; c=relaxed/simple;
	bh=ZrEg05StViIMUxZNoRD8lecZvPht+fpmrytBwILDMjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AnVHTVhzDeb1qfRjItQWB5SruH4kxgkugk5UOL5MdlDelDkSFYkfM/FmEyaF/IcjWGgqqzNQi17OptC/JxZZH7TICmMvGW451XoQqQ0klM5GJRoMstz2e75Xjt2RRQNBvxA7D2QYNU0ByH4aqsH8Ozw70QlFY1SxL6OBe9tITvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from x415ea.. (unknown [49.214.10.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id EB2C0315FB;
	Thu, 16 Oct 2025 23:45:30 +0800 (CST)
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
Subject: [PATCH v3 0/1] arm64: ptrace: fix hw_break_set() to set addr and ctrl together
Date: Thu, 16 Oct 2025 23:44:00 +0800
Message-ID: <20251016154401.35799-1-b10902118@ntu.edu.tw>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827014113.5852-1-b10902118@ntu.edu.tw>
References: <20250827014113.5852-1-b10902118@ntu.edu.tw>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After revisiting my patches a few weeks later, I have some additional
thoughts:

  1. Keep arm32 ptrace as it. Legacy APIs only need critical bug fix.
  2. For arm64 ptrace, the patch is not only a fix for 32-bit tracee
     but also a refactor that removes partially set state, making logic
	 clearer and preventing similar bugs.

The patch can be tested with the code in my previous mail:
https://lore.kernel.org/all/0fd573cc044584f00976c410955ed486@ntu.edu.tw/
---

Changes in v3:
- Remove patches for arm32 and compat ptrace
- Rewrite commit message
- Reformat the arg of the added function

Changes in v2:
- Fix username

Bill Tsui (1):
  arm64: ptrace: fix hw_break_set() to set addr and ctrl together

 arch/arm64/kernel/ptrace.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

-- 
2.51.0


