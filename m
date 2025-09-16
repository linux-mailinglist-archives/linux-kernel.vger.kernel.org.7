Return-Path: <linux-kernel+bounces-819620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72A0B5A3B4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EEA3ADE48
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765682E7162;
	Tue, 16 Sep 2025 21:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKIC000t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D475F31BCB6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758057243; cv=none; b=ghEKcge5YT0VX/bx6ml4e6ylbZcnSxk/JmNtrK+5z40JTZ+NXRPNpKRGLb8Bkede/SVRZpQENQ+N3pW9f7URJQgq2usrvnoCyeMpAIIDRbTiQzk7qYw5E8V2Vrzn9iYZJSFB/RImn8sP3gLfLISWV9+k4erxNVSkLJ+uGycioxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758057243; c=relaxed/simple;
	bh=K6QIVOKKiauyeGJ2OmH64VPm/LdUrqJZS2Q1LLOKYHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hN7KreyUo6Sr2GjstUcRReOqRxkfRgZKpHt2Il7TbUVLGL0Pl7brlG/xEDlDy+zOhyZanhNBmErE6uGK+h0/sNBtpU/wHSlLUe/KGo7UHQPhzBnGgVErWmSwDpMUMVocemr2BIGdJec3LghuHuLzKJosxcpUpe61ZPosWdU759w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKIC000t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896B2C4CEF0;
	Tue, 16 Sep 2025 21:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758057243;
	bh=K6QIVOKKiauyeGJ2OmH64VPm/LdUrqJZS2Q1LLOKYHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKIC000t9zgbfhZj7Haafps3nC5ZbOvaN3gQFKr5R6Lqd4RbzZdb0HrvCHDmNoLyw
	 o+G7sO56655SUxyyNL2VSezKtC7ciWy4oRTH7dBx5h4RDKdAME76WmsuKmapPMMeZd
	 wjdCff6DPZm+d2CqZ6jzF0Vib3No5DcS7YmxijnzkmTXWAI+HWlpEAvSY3/j3XGU0r
	 x9uFoJ7I5zsPSz+dCEjHU5bqKBl8YJsIiErG8VLnbXeF6f5wuToFav2iTlnxsO1C+Z
	 WlRfTaDd1gM7/h/2KbW+g3rt7b1XK17FhckOIw5GfaGMTehrRtpyXjMnYAMRY+OuvV
	 qpZaxU8I97xpg==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Sam Edwards <cfsworks@gmail.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: Re: [PATCH v2 0/3] Type correctness cleanup for ARM64 MMU initialization
Date: Tue, 16 Sep 2025 22:13:48 +0100
Message-Id: <175805162005.266431.9349963404486851031.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250904005209.1494370-1-CFSworks@gmail.com>
References: <20250904005209.1494370-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 03 Sep 2025 17:52:06 -0700, Sam Edwards wrote:
> This is a small series of type correctness and readability improvements for
> ARM64's MMU initialization code. When I first encountered this code, the heavy
> use of u64 to represent both virtual and physical addresses made it difficult
> to understand where the demarcations were. I made most of the changes in this
> series while troubleshooting a different problem (fixed in a separate patch) to
> make that boundary a little clearer. I am submitting it now in the hopes that
> this will improve maintainability and readability for others.
> 
> [...]

I must confess, I don't personally see a huge amount of value from these
changes. However, I've probably just got used to things and so if this
would've helped you understand the code when you first came across it
recently then I think it's worth having.

Applied to arm64 (for-next/mm), thanks!

[1/3] arm64: mm: Cast start/end markers to char *, not u64
      https://git.kernel.org/arm64/c/030b3ffbdac7
[2/3] arm64: mm: Make map_fdt() return mapped pointer
      https://git.kernel.org/arm64/c/c56aa9a67a08
[3/3] arm64: mm: Represent physical memory with phys_addr_t and resource_size_t
      https://git.kernel.org/arm64/c/b868fff5b10b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

