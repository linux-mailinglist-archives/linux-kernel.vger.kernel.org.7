Return-Path: <linux-kernel+bounces-783634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA62B32FF5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 14:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97D28189E62F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FC72D73A8;
	Sun, 24 Aug 2025 12:50:04 +0000 (UTC)
Received: from smtps.ntu.edu.tw (smtps.ntu.edu.tw [140.112.2.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3B293B4C
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.112.2.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756039803; cv=none; b=ED8GO5510v6Vi6Xoo4uPisLsH93+4bBO3ETvODyQsS/GoDiQJl+JhaQfUKB6v0zb1RI5jZfPatjf0pTv00lTqid7oUOqWsjCHqjTzyqVBK1LfijfumT+RaXl+na4PZMyQAr7kWNQsg34FOIzGKFhzs8npL5ULMQQOoiXEbez8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756039803; c=relaxed/simple;
	bh=h0/wJULaW/Ik1ZM7lLV0UQRljFZf6q6EY6KkrZ/oeEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kR/iUZ1x4nTBmUmW5B/Oak9Vch/y73NVDNcil+rdPPMKS9PY1dlb17ubW4/IOcSTIcJmX3mKOjqYUPIdM1iaWR2pVDNXWoSwU1NUeANlCMJw9TdQOfhVXNKHESnq1KqIU0oBHrQTNEyZgrnctjUvpkFyxNlLF4AS6DqTOKNQMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw; spf=pass smtp.mailfrom=ntu.edu.tw; arc=none smtp.client-ip=140.112.2.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ntu.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ntu.edu.tw
Received: from x415ea.vlan11.wl120.cc.ntu.edu.tw (ip24-218.wifi.cc.ntu.edu.tw [140.112.24.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtps.ntu.edu.tw (Postfix) with ESMTPSA id 5BDC82E656;
	Sun, 24 Aug 2025 20:43:47 +0800 (CST)
From: b10902118 <b10902118@ntu.edu.tw>
To: oleg@redhat.com,
	linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	b10902118 <b10902118@ntu.edu.tw>
Subject: [PATCH 0/3] ARM/arm64: ptrace: fix unaligned hardware breakpoint validation for 32bit
Date: Sun, 24 Aug 2025 20:43:14 +0800
Message-Id: <20250824124317.390795-1-b10902118@ntu.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTRACE_SETREGSET and PTRACE_SETHBPREGS fail when setting a hardware
breakpoint on a non-4-byte aligned address with a valid length to
a 32-bit tracee. The length should be valid as long as the range
started from the address is within one aligned 4 bytes.


The Cause:

The kernel modifies a breakpoint's addr and ctrl separately, but
each modification comes with validation, so the first validation
sees the user-provided addr and old ctrl (and vice versa for
PTRACE_SETHBPREGS). This combination can be invalid if the address
is unaligned and the control's length is too long (ex: the 4-byte
default).

The kernel only checks the alignment for 32-bit tracees, so this only
happens to them.


The Fix:

1. Fix PTRACE_SETREGSET by modifying addr and ctrl together.

2. Mitigate PTRACE_SETHBPREGS by minimizing default length.

   This cannot be fixed without removing or relaxing the alignment
   check because partially modified breakpoints are unavoidable for
   PTRACE_SETHBPREGS, which receives either addr or ctrl per call.


b10902118 (3):
  arm64: ptrace: fix hw_break_set() by setting addr and ctrl together
  arm64: ptrace: minimize default bp_len for hw breakpoints to pass
    check
  ARM: ptrace: minimize default bp_len for hw breakpoints to pass check

 arch/arm/kernel/ptrace.c   | 16 ++++++++++++-
 arch/arm64/kernel/ptrace.c | 49 ++++++++++++++++++++++++++++++++------
 2 files changed, 57 insertions(+), 8 deletions(-)

-- 
2.50.1


