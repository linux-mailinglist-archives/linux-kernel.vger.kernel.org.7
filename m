Return-Path: <linux-kernel+bounces-900095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BF3C59976
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 20:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF6DB34E286
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443462F5A1E;
	Thu, 13 Nov 2025 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRuzrKzB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BC830FF1D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763060357; cv=none; b=HegvA96s7O4IkUnoFOo6UkIwQnJwgaJ1DlJf9RGexgT2q6QRLYmAnTh844GEnjfIsrmtBh9tKySro4i3U8uGL9Nf6jN6vvGOBYnma4YZx79GtAzMEfAISKqB2CMVCFhydEC18ByMNzN74QsWuLK3mzYpnZSqCqHqpTcnX6DJtKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763060357; c=relaxed/simple;
	bh=bRo43ZXqGD3NNIoHn1ylw4FbNh/9bqm8ocau1/+g3MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPazPwZf/6EiOxvbeti3Z6r+3a/3Ex2AA8qELS0nRV192XHOSyTXRrPbnxnWicDa3l2UwPMK6ZO+BgYrKZ1oBjRUgbNKW0Z1WOP/rxwVvwISJyafTQCLUwv6ieP1q87CuN1rSEiJv7al1uyMZmj7pGzGFj0CVJdyIVPPtgtHiDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRuzrKzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21328C4CEF8;
	Thu, 13 Nov 2025 18:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763060356;
	bh=bRo43ZXqGD3NNIoHn1ylw4FbNh/9bqm8ocau1/+g3MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRuzrKzBGRvvGyf5octAUw8GZMPOADOHPj5iUgcRVkSC7YvgCvelXzadXqGZkVO+b
	 ne8eD2SEPpjPFW4m9XGy9OtNkspJGMFkL8P3K00moOM3bVYUII8vdPsBOvADnjlFHx
	 9GcOqyEKU1QYtbPbCDV9y4waZszEr/1XBfF0QQD6qRoSB6IEw7ECfc01cR5skwKjxV
	 htU9e/8Vfh3BDlZMwSefrHLzD4anwDcJtExMP4Xr+skrvgHoeezdo2bVLSHWjBhjN9
	 k8/WQLKyqQljzMP8ZLRNZuNftB1IZPt0F8lJMfsWGnZhTBfRhWnAwbpV/4PNwogVi3
	 TL5kj6AMEXssg==
From: Catalin Marinas <cmarinas@kernel.org>
To: Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Linu Cherian <linu.cherian@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Zhenhua Huang <quic_zhenhuah@quicinc.com>,
	Dev Jain <dev.jain@arm.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH v4 0/2] arm64/mm: prevent panic on -ENOMEM in arch_add_memory()
Date: Thu, 13 Nov 2025 18:59:03 +0000
Message-ID: <176306032237.2459767.15705296734744226735.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017051437.2836080-1-linu.cherian@arm.com>
References: <20251017051437.2836080-1-linu.cherian@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

On Fri, 17 Oct 2025 10:44:35 +0530, Linu Cherian wrote:
> arch_add_memory() acts as a means to hotplug memory into a system. It
> invokes __create_pgd_mapping() which further unwinds to call
> pgtable_alloc(). Initially, this path was only invoked during early boot
> and therefore it made sense to BUG_ON() in case pgtable_alloc() failed.
> Now however, we risk running into a kernel crash if we try to hotplug
> memory into a system that is already extremely tight on available
> memory. This is undesirable and hence __create_pgd_mapping() and it's
> helpers are reworked to be able to propagate the error from
> pgtable_alloc() allowing the system to fail gracefully.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/2] arm64/mm: Allow __create_pgd_mapping() to propagate pgtable_alloc() errors
      https://git.kernel.org/arm64/c/bfc184cb1ba7
[2/2] arm64/mm: Rename try_pgd_pgtable_alloc_init_mm
      https://git.kernel.org/arm64/c/1b214452b6a7

-- 
Catalin


