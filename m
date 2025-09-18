Return-Path: <linux-kernel+bounces-823306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A2EB86159
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E08C7AF6F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9315531A54F;
	Thu, 18 Sep 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDHkYUJx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AEA31815D;
	Thu, 18 Sep 2025 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213828; cv=none; b=KUfpOu77S57CAkHKUgUlQ8H1bA7GfyNcPK9tNeKKEZ2fYrV/EfEuJwa05sAoCgvjnszKo6lGx0sog/AoyHtrN1BNG1Z/twG5OeEGpray/MCBmW2O1HcVDIVPS8ZSiFv09h2Xil2z+NZTflyqH75Ht3God65ZLGIh1SWSO+NeIDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213828; c=relaxed/simple;
	bh=ouOmp5NqelaHAn4D3Kb4rcJp4Tm74ZDtqSiYkLb7RUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e129gAid2wxIUBYAhJ+bVaa6H+M0e7/DnXi68hLQLBP30T45GO2Z4jM9aGOW1zEe5RubdOTW4jxKVHRRZULtS5akLUTPiWkxODuoqgWSVgEq1DJaweV/KgrmtdnzuUIn7cqwvOn+ajjtY5ewnKrdqC/VUIdYTsS4JtAUOaKwPUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDHkYUJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCB9C4CEF0;
	Thu, 18 Sep 2025 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758213827;
	bh=ouOmp5NqelaHAn4D3Kb4rcJp4Tm74ZDtqSiYkLb7RUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDHkYUJx7O36GXburAillFuHJOoJTGroVvB0Ut/tO1pyEztuNWqnxQvSR6g2yIpEv
	 T10SlEAdLTVjN2OqRwew0nCy7NltOIZVJ2geStABmMlgfJwIGmETXXYwpi7IEiP4Ci
	 BhoXm3RfB/XApvAFo7vqOs0ZHxWYLFW1iHF43ErAvdxr3GzAra/XN6r7VEhHHw4WR9
	 l7yofzuUZUU/liBFjMcDroWmsh6qZSnp4mfAY+o8XAxN3l3Xh1t1L7MumeBnwtW6Td
	 Pic1gxmBgqZtqNij/HYnpXN0+urejlLL5WowOIMQ1ZVM5LzTWjUl73SxBM9niczMI5
	 JKEsSNkNAlACw==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	Xichao Zhao <zhao.xichao@vivo.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: perf: use us_to_ktime() where appropriate
Date: Thu, 18 Sep 2025 17:43:13 +0100
Message-Id: <175819970127.3463522.16008162224664814549.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250813083257.504573-1-zhao.xichao@vivo.com>
References: <20250813083257.504573-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 13 Aug 2025 16:32:57 +0800, Xichao Zhao wrote:
> The arm_ccn_pmu_poll_period_us are more suitable for using
> the us_to_ktime(). This can make the code more concise and
> enhance readability.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] drivers: perf: use us_to_ktime() where appropriate
      https://git.kernel.org/will/c/1e558fb31bec

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

