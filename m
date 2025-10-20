Return-Path: <linux-kernel+bounces-860451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 033E1BF0295
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CE7C4F25AF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0F82F260E;
	Mon, 20 Oct 2025 09:26:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A417A31C;
	Mon, 20 Oct 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952404; cv=none; b=hejSk2RsUBNMUNTTLccE9Od27Q21RQzjvX+lGG2UACpxoB6hS8DEUxNqb68uWwBH2j/UKp8JRfuSr83AORrGE/FWZd3R+O1mU1Is+njwcZaKqtrmrcLavEY38DDCLGJb0LJd+AJyKZZOLkG1nbdbEmCFQV6E/chp17kU/bVIqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952404; c=relaxed/simple;
	bh=lFvgZxkp/QBhWminEKSNC/4sVSZYSgKByi9DTzIKF8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7nhqvtj47FhpE2kmTeegCn7q3AYDN6mch2WLUBFCH5dsbI9yRT1rlJ4B00+964+3QwYm5iVGYKbF1lRuYK+Hex9K4UcrB7JLuIW+UzKfSp/0wUIeon9RLwYMbTXJVrd5RaIKEedhkHbDciOH591evAJQpC+RU4VM4RjDJxxFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 633741063;
	Mon, 20 Oct 2025 02:26:34 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2903A3F66E;
	Mon, 20 Oct 2025 02:26:41 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15-6.1 0/2] arm64: errata: Apply workarounds for Neoverse-V3AE
Date: Mon, 20 Oct 2025 10:26:26 +0100
Message-ID: <20251020092630.592033-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series is a backport that applies to stable kernels 5.15 and 6.1, of the
recent errata workarounds for Neoverse-V3AE, which were originally posted at:

  https://lore.kernel.org/all/20250919145832.4035534-1-ryan.roberts@arm.com/

... and were originally merged upstream in v6.18-rc1.

Thanks,
Ryan

Mark Rutland (2):
  arm64: cputype: Add Neoverse-V3AE definitions
  arm64: errata: Apply workarounds for Neoverse-V3AE

 Documentation/arm64/silicon-errata.rst | 2 ++
 arch/arm64/Kconfig                     | 1 +
 arch/arm64/include/asm/cputype.h       | 2 ++
 arch/arm64/kernel/cpu_errata.c         | 1 +
 4 files changed, 6 insertions(+)

--
2.43.0


