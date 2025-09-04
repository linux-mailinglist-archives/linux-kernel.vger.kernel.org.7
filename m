Return-Path: <linux-kernel+bounces-801600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4508CB4476C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5441BC5EF5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3672D2877D8;
	Thu,  4 Sep 2025 20:36:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3572877C0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 20:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018162; cv=none; b=R/tVQdFhIvRas2HtCsKtohfjkpUdzFSLj9tN6rK9EtYKCNSQWJl+znUA9LpNRmyFv2uVe0ZxtCIJKjUMmZuGloTok+AGBoUjzwoPCfT5yEVTGKG65p7XtLYE7NcY91pvakG9U+Ali2rfiZGYsjAIMmtANwufVbIEDwin3x7QLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018162; c=relaxed/simple;
	bh=lzRHvdWxqYF+MG8ZZtuJK2UUYqW/UYOPB0Aw2/oA8aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3DrJuBEFtzNcCFgRt6x9inm2RqJIVloyw3e4q/Yjt5YN6RVGDVVW++eNIDlCj9JZfnBBixt/1FSNq3eURXlQ+9HbH3ZKsiF9PThHJ8XBwNq8YCDVrKLDn60Mf9cowSJy4CkoovJWQ57xowRGigSrr1nQninbjW+/uJ/1ZDqhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B781C4CEF4;
	Thu,  4 Sep 2025 20:35:58 +0000 (UTC)
Date: Thu, 4 Sep 2025 21:35:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: will@kernel.org, oleg@redhat.com, sstabellini@kernel.org,
	mark.rutland@arm.com, ada.coupriediaz@arm.com, mbenes@suse.cz,
	broonie@kernel.org, anshuman.khandual@arm.com, ryan.roberts@arm.com,
	chenl311@chinatelecom.cn, liaochang1@huawei.com,
	kristina.martsenko@arm.com, leitao@debian.org, ardb@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v8 0/8] arm64: entry: Convert to generic irq entry
Message-ID: <aLn4LP7olb89TdbN@arm.com>
References: <20250815030633.448613-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815030633.448613-1-ruanjinjie@huawei.com>

On Fri, Aug 15, 2025 at 11:06:25AM +0800, Jinjie Ruan wrote:
> Currently, x86, Riscv, Loongarch use the generic entry which makes
> maintainers' work easier and codes more elegant. So also convert arm64
> to use the generic entry infrastructure from kernel/entry/* by
> switching it to generic IRQ entry first, which will make PREEMPT_DYNAMIC
> and PREEMPT_LAZY use the generic entry common code and remove a lot of
> duplicate code.
> 
> Since commit a70e9f647f50 ("entry: Split generic entry into generic
> exception and syscall entry") split the generic entry into generic irq
> entry and generic syscall entry, it is time to convert arm64 to use
> the generic irq entry. And ARM64 will be completely converted to generic
> entry in the upcoming patch series.
> 
> The main convert steps are as follows:
> - Split generic entry into generic irq entry and generic syscall to
>   make the single patch more concentrated in switching to one thing.
> - Make arm64 easier to use irqentry_enter/exit().
> - Make arm64 closer to the PREEMPT_DYNAMIC code of generic entry.
> - Switch to generic irq entry.

I had a read through the patches and this first step looks fine to me.
If Ada or Mark don't spot any problems, I think the series is a
candidate for 6.18.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

