Return-Path: <linux-kernel+bounces-885059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F15C6C31E21
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 319074ECD25
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A98A2DECCB;
	Tue,  4 Nov 2025 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohdV8tr1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D292417D1
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762270550; cv=none; b=uhfTGjjWKCBhWZdQ5HOeWg2ElcQMJX5PuBYtDMPQELaI9CtSJxGt+48fQ0koiD1pbjaUsvO0oYxEwlfsRT25EzKbySz8E3oEsLaTR90eAMsT5ml1flOoyyOhqvcpTx4mSXcERsGX9MrN67VxTfkI3R7KWvOV1xEGFvddYMC9MJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762270550; c=relaxed/simple;
	bh=UJVHyVAmxeVU6ynyP17+9c8X4Lrehhp/Ztd9XamCYzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPc0YJBPQJD1JVQvBRTRbZIHWfDiNt6PkzBSwszmNXu6C+orKWUJEdAvi8tJl1I9zAgqDcnDH/xOqL4eRy0VI4joiNrl1LQteIyDzvlrpMInHlp0tM+BZozYjEveJ+0tDJp5fPCjQouXP+CCrUVd3uyEKzs5CPl61x/ayzoUYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohdV8tr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2397AC4CEF7;
	Tue,  4 Nov 2025 15:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762270550;
	bh=UJVHyVAmxeVU6ynyP17+9c8X4Lrehhp/Ztd9XamCYzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ohdV8tr1tABFtQCNJAbED3LnH0x1xomD01q/IQSjfHYXuVdHV+kI1TfSdhCsz1OjZ
	 +FhtOV4MyenzZyYrOTyOQUHRwTr+78I7S5peTa+SEnnQbwoxbRvNHPSPQ+9Bjh/EZf
	 LzmnA3YKUxXHUNeuLrWTlSS4J7264oAy6kXHyl7UZZ7ZEQEiUSeqwU3myXQtboeUOJ
	 bH0p6D29uN83tsngpAbY/gNDiZUkV168ffRXJhdLSg3fTqYahMXmFmjrc0OYxB838P
	 Ifii+JvfiyxlYirAqLu/3KFnW9QiMLXlSRLYuAU4H12KSyp/zNWH74oMgeG3J3ys14
	 vj0ZQB9umK5RQ==
Date: Tue, 4 Nov 2025 15:35:46 +0000
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, ryan.roberts@arm.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop cpu_set_[default|idmap]_tcr_t0sz()
Message-ID: <aQodUrkaA4fE2fI1@willie-the-truck>
References: <20251015021024.366722-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015021024.366722-1-anshuman.khandual@arm.com>

On Wed, Oct 15, 2025 at 03:10:24AM +0100, Anshuman Khandual wrote:
> These TCR_El1 helpers don't have any other callers. Drop these redundant
> indirections completely thus making this code more compact and readable.
> No functional change.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/mmu_context.h | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

