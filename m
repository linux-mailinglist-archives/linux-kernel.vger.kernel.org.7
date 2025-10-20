Return-Path: <linux-kernel+bounces-860459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ADDBF02C2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891B2403745
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B122F5A3B;
	Mon, 20 Oct 2025 09:27:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB242F5A07;
	Mon, 20 Oct 2025 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760952474; cv=none; b=nXOUYeEaMfjg2eXC83lf27kH51oMRRjvddWKpEOdWl0ybhe6pDx7spMIXouzPwatCKH8Mz93T8vAXskqkZCVlKJrzW0rvqmLjesVAnMBj5+iwd2EPrQWWUAXhmyCeH07JpJo8az1U+Cc/uUMwnz6k78UpiN3TRhxXn4RI/tYEWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760952474; c=relaxed/simple;
	bh=joXj06w73n0rY+/d9F0e5Np2WtABBHUJvjrkLlwZTLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YyV5HnbUIZRycGVD/2EPpPY1tIbNiLvSchvCCh62lX6RZ/T2sOTbgo0Os1s88c6DYmFFifFDQONuL3BCoYqKb7/2JzaQn2o8vkCrUQMXF190dff3X2NjEIEjOEeJIYHmBlmESdeE5yC5RJaHCbJQVgdlD/0AE0dqLTzttRkrGyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EA601063;
	Mon, 20 Oct 2025 02:27:44 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 640493F66E;
	Mon, 20 Oct 2025 02:27:51 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: stable@vger.kernel.org
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.16-6.17 0/2] arm64: errata: Apply workarounds for Neoverse-V3AE
Date: Mon, 20 Oct 2025 10:27:37 +0100
Message-ID: <20251020092741.592431-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

This series is a backport that applies to stable kernels 6.16 and 6.17, of the
recent errata workarounds for Neoverse-V3AE, which were originally posted at:

  https://lore.kernel.org/all/20250919145832.4035534-1-ryan.roberts@arm.com/

... and were originally merged upstream in v6.18-rc1.

Thanks,
Ryan

Mark Rutland (2):
  arm64: cputype: Add Neoverse-V3AE definitions
  arm64: errata: Apply workarounds for Neoverse-V3AE

 Documentation/arch/arm64/silicon-errata.rst | 2 ++
 arch/arm64/Kconfig                          | 1 +
 arch/arm64/include/asm/cputype.h            | 2 ++
 arch/arm64/kernel/cpu_errata.c              | 1 +
 4 files changed, 6 insertions(+)

--
2.43.0


