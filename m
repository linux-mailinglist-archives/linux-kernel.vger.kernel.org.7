Return-Path: <linux-kernel+bounces-832792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1147BA0601
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251291C22EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69AB2ECEA8;
	Thu, 25 Sep 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg88FYtn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173D22EBDD7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814331; cv=none; b=C+HinJncIwp2PFZVG2x+dXPGJHKxULYwWAy9eWKtgd3fG32HJQh0ibtmPpPX5eBeDxvMiZNWIJr1suegwN4zDiFBLvb2DOHxWAWKb7i30JPB3cSFc/lLRWLx++V2ptu8sM5L5piuqzLbevL20iOGECXioJp0cNjN+LWi+is/4tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814331; c=relaxed/simple;
	bh=cFkCFmu4D09Ng3fzdOMuwdXQRxFSrA6RQpXW6yMLdiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMQRDYXdSiTWg4/p3Ox1lNvcTk7TqozWzYthupsXyXskMi5P1Wz/HcTnD0Vo5xYruYObeGArovstbyIu5y6u+Qiun8ZCzfjM45lUF5+1AHtK208uP0U3gFMhLuNHbXx+JIlgqkXlsWl4kK+msr45Zfi90HG92DN1cRCOqJgOeME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg88FYtn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CD9C4CEF0;
	Thu, 25 Sep 2025 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758814330;
	bh=cFkCFmu4D09Ng3fzdOMuwdXQRxFSrA6RQpXW6yMLdiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wg88FYtnhP+LfoaGZxAKVUGwSoFWx2DNxG+6R24xTuJUV+1QQWBF/gFlIW1C/lkh2
	 4RM1Qf53NyG95RzQ2piqGU1COv4x/UTlPULEVMJ6tAopkBBfFHjC8VjhpLCxB/cnMB
	 48RR+yHMyuORzF/R6kEZfhNO/itr/qoBRw2vinln/2CxNEgBwH15HtCdd44H2NveyT
	 vo7GUsObVM39LBAHZU+ETL82yNcyEwQ8pieF3IV3CI+hvGiDNn4cWWvSkisNiC31nJ
	 V/mIVbtikKGTd0UEbXh0KOjfHlYVFj+x3Z8BKGLo70q40vv5SfmhjQEb+EIu5F2fgd
	 g34i0xATJ63Aw==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Kevin Brodsky <kevin.brodsky@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: Re: [PATCH v2] arm64: mm: Move KPTI helpers to mmu.c
Date: Thu, 25 Sep 2025 16:32:01 +0100
Message-Id: <175880703970.3419388.13372770098169657486.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912073908.404924-1-kevin.brodsky@arm.com>
References: <20250912073908.404924-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Sep 2025 08:39:08 +0100, Kevin Brodsky wrote:
> create_kpti_ng_temp_pgd() is currently defined (as an alias) in
> mmu.c without matching declaration in a header; instead cpufeature.c
> makes its own declaration. This is clearly not pretty, and as commit
> ceca927c86e6 ("arm64: mm: Fix CFI failure due to kpti_ng_pgd_alloc
> function signature") showed, it also makes it very easy for the
> prototypes to go out of sync.
> 
> [...]

Applied to arm64 (for-next/core), thanks!

Please check that I resolved the conflicts correctly...

[1/1] arm64: mm: Move KPTI helpers to mmu.c
      https://git.kernel.org/arm64/c/200b0d25084d

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

