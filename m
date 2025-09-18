Return-Path: <linux-kernel+bounces-823621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0E2B87054
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 23:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84E57BCED1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DADC2F744C;
	Thu, 18 Sep 2025 21:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdoP1WsY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E682F39D7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229825; cv=none; b=C+cFYkRfHue9K4TCHL+3wbw4RKaR1eybusKbBj3jXSEPvsmv5BPMH+oiBwUGB6TTIs1a3ooKoSG8P1AH3tHLTidM++GOAxyVW6/xONssf1e7pxqGyEjAjAElHzLfYu3h3wnRwaEvDwr5lOpST8M5/31Ywq6WMHwTw0S9zN2cJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229825; c=relaxed/simple;
	bh=jKkcmf3MDfbgYuwWGn6u6Q37sQo63v9wUZb8rTdwbcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lE9W1qoQ9wHDQaXp1ly2FNcssbvrF8xNFy1B9q6rx3IaVtQ3NKYQq6pU5X8xQurpO9kugVVHtK7mSB7ZFVno3XdSBLL+yXc9oalzkBMTH90tx+NSvme74EHdtvZw6NODjlssoMrBKKWMgZbgCKQ+suCrXW/XTjnBhEH2T7TKH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdoP1WsY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8B7C4CEE7;
	Thu, 18 Sep 2025 21:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758229825;
	bh=jKkcmf3MDfbgYuwWGn6u6Q37sQo63v9wUZb8rTdwbcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdoP1WsYZzMmLUBAA/L36XxB9IEcVc4Z3/ChXrxWDhNsJZJzU3SIc6TS2LkVInryU
	 tVochwRrdRZdIIdxdorpyqRVl+mGLXr55YDmTdu95nHE/JWnwHuxD+/fVTdWmvhm2i
	 6LDGQnf6YW+KYWmnCOFrMmX3GvFaPoTYiFMkhDRmYJ5Ozf+V44WmhS24veu9DGogg7
	 UK14SwgRtDoiHI8l/XXxGjxXg/JvpNDz6zCXDE5S/s93DO+Sw0bsAbP/nSEjlkwS/+
	 Ccmvj9xhlgLfoch+tRE/ZqhgwmP39qNFB/c2K8tAJB5QkzUaekiVd5CNy9Gldhfi92
	 qsolnw97+XVpg==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ardb@kernel.org,
	dev.jain@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org,
	Yang Shi <yang@os.amperecomputing.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v8 0/5] arm64: support FEAT_BBM level 2 and large block mapping when rodata=full
Date: Thu, 18 Sep 2025 22:10:08 +0100
Message-Id: <175822779944.710258.10028837182267037801.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250917190323.3828347-1-yang@os.amperecomputing.com>
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 17 Sep 2025 12:02:06 -0700, Yang Shi wrote:
> On systems with BBML2_NOABORT support, it causes the linear map to be mapped
> with large blocks, even when rodata=full, and leads to some nice performance
> improvements.
> 
> Ryan tested v7 on an AmpereOne system (a VM with 12G RAM) in all 3 possible
> modes by hacking the BBML2 feature detection code:
> 
> [...]

Applied patches 1 and 3 to arm64 (for-next/mm), thanks!

[1/5] arm64: Enable permission change on arm64 kernel block mappings
      https://git.kernel.org/arm64/c/a660194dd101
[3/5] arm64: mm: support large block mapping when rodata=full
      https://git.kernel.org/arm64/c/a166563e7ec3

I also picked up the BBML allow-list addition (second patch) on
for-next/cpufeature.

The fourth patch ("arm64: mm: split linear mapping if BBML2 unsupported
on secondary CPUs") has some really horrible conflicts. These are partly
due to some of the type cleanups on for-next/mm but I think mainly due
to Kevin's kpti rework that landed after -rc1.

So I think the best bet might be to leave that one for next time, if
that's ok?

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

