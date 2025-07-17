Return-Path: <linux-kernel+bounces-735128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C710B08B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FD6F585AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F0E2D94BC;
	Thu, 17 Jul 2025 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tox3PrHp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D412D9ED3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749185; cv=none; b=kK8XAZb7HXnR0GDuW1lLOf28P9UdcdIVHn32hJkKzkMgFojjvHKpfrN1tg7gFL6WMbk2hXg6qTTUV83rF2QHgYQiZoMVkxltlPznlqXTsL4oRdNXx1Y+uU7VxkTo0F7mIp2/jXPdgO95UXrMyq3TxPAzCutqZr+JVmGVc9Ksbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749185; c=relaxed/simple;
	bh=DkXyeHIa2nF3AOICnuR48ynTr+TBeqyOhPxZL4J6QaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NqjOlmNDCS2VMr8+8AfgB7YLN9Wy+X42y5dIZx/6cLoJU5BVQoyC6UOxTxakW+ralqLh15uJ7S8fteqky3VQkEF29jPJerSxeFbAxHiExTWg68Whx4dHGNqk+cxoTQ1W/dnyfczYji/LP7U//ElD6OV95yUzOKB9sAYCfb+kdEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tox3PrHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70513C4CEF0;
	Thu, 17 Jul 2025 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752749185;
	bh=DkXyeHIa2nF3AOICnuR48ynTr+TBeqyOhPxZL4J6QaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tox3PrHpqhMu4xO+ihUu6MVqf01Sb8Xh3Et3hs89aTklPc3ulrOULXRavXbCqZ/p1
	 6RXdYxCi2isSjHKE3hdICYxsIW4769UOwpBCdLkZHXKRkXL9BvQiQMjfr0zJEw9F9x
	 NJ9vBGiF6p2WFedui28zaJa5VisB4fUHvrRGI8Ld2TCw9/OLAg/9QrhHV5C0pZsZ2r
	 Qz6Lb31ICdq/YJXnAj8/cE3QcQW/P0W1hcygFXWAfWm3hw6ug+LiWm5aIP5VCVA23I
	 cZdhFjk2C+snEYl8nSPiQ5++JdMLl69cJj/JZWwSLbak50C8e4+vBflQ1X4WW+GrRC
	 z+Ka3ZoQBRNbw==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: Re: [PATCH V2] arm64/mm: Drop redundant addr increment in set_huge_pte_at()
Date: Thu, 17 Jul 2025 11:46:15 +0100
Message-Id: <175274693707.736549.5663594233250106618.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250716035432.293682-1-anshuman.khandual@arm.com>
References: <20250716035432.293682-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 04:54:32 +0100, Anshuman Khandual wrote:
> The 'addr' need not be incremented in the loop because that is not going to
> be used subsequently.
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Drop redundant addr increment in set_huge_pte_at()
      https://git.kernel.org/arm64/c/aa46e18836c0

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

