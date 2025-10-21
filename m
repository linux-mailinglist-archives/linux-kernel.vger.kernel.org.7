Return-Path: <linux-kernel+bounces-863351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4CBF7A10
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E22E43ADC8C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B594347FDF;
	Tue, 21 Oct 2025 16:19:17 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E7C355057
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063557; cv=none; b=JHAlpozOL0EoJQbyinuUHn7dU8F8nddQDmYkVN9dHtduPhhiHEYoUlVVJ6K0RhjZ5IWe7chk54O9LEOiDix39vtxYg9R9i3yViJDF8hPrmtMdBBG8wt+k4fRsvdrvFOoVSdPIDBfQy9Y/78iL9Ak/ehgCqfyj2G6dRLdmaI0Q1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063557; c=relaxed/simple;
	bh=UDNWHkwnkk0/5BxOtPR+pLT5fttdSAiuHNbv6Sri4To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEZPY5F4rfIieEU+/Ou8ElqfhO2HYohO84qVQotmXggguNFdL9gSqT+TMsQthPZL2Cc8Qh9H9sa9JbeXTMN99ZvFqO/GmmRYqiWp9UdLdLLciKih9Eb3v2En5PyAC/qWy9xNpFvrQND3UP0FIcRUeHpl6l5v8Eu9nqFj3GmaNwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B22C4CEF7;
	Tue, 21 Oct 2025 16:19:14 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Huang Ying <ying.huang@linux.alibaba.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64, mm: avoid always making PTE dirty in pte_mkwrite()
Date: Tue, 21 Oct 2025 17:19:05 +0100
Message-ID: <176106354573.3697793.9595844737584948515.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015023712.46598-1-ying.huang@linux.alibaba.com>
References: <20251015023712.46598-1-ying.huang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 15 Oct 2025 10:37:12 +0800, Huang Ying wrote:
> Current pte_mkwrite_novma() makes PTE dirty unconditionally.  This may
> mark some pages that are never written dirty wrongly.  For example,
> do_swap_page() may map the exclusive pages with writable and clean PTEs
> if the VMA is writable and the page fault is for read access.
> However, current pte_mkwrite_novma() implementation always dirties the
> PTE.  This may cause unnecessary disk writing if the pages are
> never written before being reclaimed.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64, mm: avoid always making PTE dirty in pte_mkwrite()
      https://git.kernel.org/arm64/c/143937ca51cc

-- 
Catalin


