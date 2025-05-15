Return-Path: <linux-kernel+bounces-649515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AA5AB85B3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 14:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C95599E6FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 May 2025 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F7B29ACE8;
	Thu, 15 May 2025 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puCntqTD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330E29ACF0
	for <linux-kernel@vger.kernel.org>; Thu, 15 May 2025 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747310812; cv=none; b=es9JwE8sLK/t0FtdYUKHUNsMLSeB2ULTxZc55VuvhXNGOyavWPuKyZPdBtrBpbxl/XQS82snrR9QkxHD1hdaeCuEXwBahXzrStfFQALQ1bGpTBEhQRDZd70h63K3Du+QCOIAtwfM0ZPmnuMd6cFbNZKtBvUPu1M3P5fUp0zjCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747310812; c=relaxed/simple;
	bh=mH6rXAYLLxg6om6slxhoJmUxxtp/x8k2lGBaR2l65Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrcSPmYUmF0uhVJPksRK5iXAjry8pzGZy998dJzWljxkRm9YZZppl69qo6gi7E7sPriTARnIeymsrCosUJhSb9YZcHmMP/6bppZU7KD8UclJcrXyz+Fb9jXQzXj4hEbBIEIyAMCr/YSSeTT1WqNhSYLOEZ5W7ZFPRA7zXX7C7yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puCntqTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4942C4CEE7;
	Thu, 15 May 2025 12:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747310811;
	bh=mH6rXAYLLxg6om6slxhoJmUxxtp/x8k2lGBaR2l65Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=puCntqTDnLdCo8An1dOq/7tVtRLSWasPw96sAvFK2xlqSryZGtlBq8M/EkgQtj/KD
	 xwwwz2/eynVZQ2FdndyTXd8muWileA2Dx8nuELCwnU4cN+g+kPBSCFVyF1NcIUGO97
	 ZMjRFoPTzSL+e3Eptgjq0ZnpSreUQStOKtR+E9LHy0eGIDaGUTypY2WWDlDhig+Tsf
	 wgtC9ogZ6m+/OFDUtYu0LV6gHzYfZw7SC+BasnRD6ScwWB38oLnhAQreA85qT6MZfI
	 L4Exnha0252aQPN78PF/i2oxc2ejLf+DrT7m1tcuJDzAf8VoJII1qEP1cTzmPW1Xtq
	 qKFlMiRiu25ag==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Juergen Gross <jgross@suse.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 16/32] x86/boot/e820: Remove unnecessary header inclusions
Date: Thu, 15 May 2025 14:05:32 +0200
Message-ID: <20250515120549.2820541-17-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250515120549.2820541-1-mingo@kernel.org>
References: <20250515120549.2820541-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/kernel/e820.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index bb48dcc8a8ee..806d69ca09af 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -9,13 +9,11 @@
  * quirks and other tweaks, and feeds that into the generic Linux memory
  * allocation code routines via a platform independent interface (memblock, etc.).
  */
-#include <linux/crash_dump.h>
 #include <linux/memblock.h>
 #include <linux/suspend.h>
 #include <linux/acpi.h>
 #include <linux/firmware-map.h>
 #include <linux/sort.h>
-#include <linux/memory_hotplug.h>
 
 #include <asm/e820/api.h>
 #include <asm/setup.h>
-- 
2.45.2


