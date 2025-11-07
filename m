Return-Path: <linux-kernel+bounces-890697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AACC40B04
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E107A565B79
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68632E6BA;
	Fri,  7 Nov 2025 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCpR6oVd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DAE32D0FD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530848; cv=none; b=HYjM8JmpzTtemlDSKiqq8xf53uMaN+OPpMmFJTzImycbKap62aD5lIl6ZhT9sqYXtnOJtWzTgO6QS91QE4ajK/Fi4Co6t5hz+wHepLQkzL0JyulVeY9+m8w9a5uFa9IQTwWLwhq7p2O2KmoNWvQXJmo/57LMEoTyvIleiEICb20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530848; c=relaxed/simple;
	bh=8V/Rlq9/emBvp82XL/vpoXH1hrY7KN0fNkz7ZVVTsiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9nYDNZkk59fTZujV1MxRKDA1e2TUxgK5anqmzSS7e3CMp5YFfYZnwCc+K8nMLKZLMNWoPs0JmM+KqIZuBIaEyalIbPx57MklMl8NqGOTExF1hdshulEqsz5rvUZZfB79LrYE+87qH1tErA2vFPDaY+vsI92poVqAunvmZNqnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCpR6oVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678FAC113D0;
	Fri,  7 Nov 2025 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762530848;
	bh=8V/Rlq9/emBvp82XL/vpoXH1hrY7KN0fNkz7ZVVTsiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GCpR6oVdx2RahJnXstUMQW7fUedg6p0LY6Nocw+1KCly83qX2zmhqp3dDy2L+bmwG
	 S5NGNcWxiPaSYI9n9L59M57ZOPFfaRs1Q3RU1zmZoHkyZQnYQUfBf3MsR+qSGLezxq
	 DyRRPXRl+OTb3DrvJ4xbqasTpszRaX0zVOLaHDdcq6GNWs8msaN5v7EcSuZNivCuUt
	 nf4BTIGA//dFo8XAi9XpqyZR+q8KxQLg+2/wv0Z4TbAfsJucqCGXSlDRNgIj6uLL3w
	 hwdlLSm/7/4uVau+w6i9sTCXLYopB2rmoUGLm0OUBI/pCYmYpCxjK06BJNViWtIGjz
	 muz7VSTVxHeiA==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	yang@os.amperecomputing.com,
	david@redhat.com,
	ardb@kernel.org,
	dev.jain@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org,
	Ryan Roberts <ryan.roberts@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Don't sleep in split_kernel_leaf_mapping() when in atomic context
Date: Fri,  7 Nov 2025 15:53:46 +0000
Message-Id: <176252659699.596695.10001449481948666856.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251106160945.3182799-1-ryan.roberts@arm.com>
References: <20251106160945.3182799-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 06 Nov 2025 16:09:40 +0000, Ryan Roberts wrote:
> This is v2 of the fix for split_kernel_leaf_mapping(). I've expanded it into 3
> patches based on feedback from v1 [1].
> 
> Once happy with the content, patch 1 is needed urgently for next -rc to fix
> regression since 6.18-rc1. The other patches could wait until 6.19, but I'd
> prefer they all go together into 6.18.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/3] arm64: mm: Don't sleep in split_kernel_leaf_mapping() when in atomic context
      https://git.kernel.org/arm64/c/ce2b3a50ad92
[2/3] arm64: mm: Optimize range_split_to_ptes()
      https://git.kernel.org/arm64/c/40a292f70147
[3/3] arm64: mm: Tidy up force_pte_mapping()
      https://git.kernel.org/arm64/c/53357f14f924

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

