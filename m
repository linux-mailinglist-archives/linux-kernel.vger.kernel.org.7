Return-Path: <linux-kernel+bounces-846111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEB5BC7109
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 03:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F203E5044
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 01:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283461D5AC6;
	Thu,  9 Oct 2025 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfdQ8hrv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861441D27B6;
	Thu,  9 Oct 2025 01:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759972033; cv=none; b=cZlFjcb7xu2wzLyCb7yIokFeshrLWjhJlp96J5VEH0jS6QC3n/UOpAtFcqDgbIDGJ76ajdGzaeoZ3OqyirjghoaLJ/2RKwRq5zDxJAqIsLZy9I8Ed641yBbdqlb2wo8r+tAR9L5hjWs5HnqdtX7Zd03TdCj7Dtezu+j6cFSxCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759972033; c=relaxed/simple;
	bh=DpWnKckSi1GoUQwHCRxOqqqXjZaYsYGRGLUY44Knqm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Krwh67Fm+m1kOA4oJsU879MSaQan0ZDeTxs1e4p1oM2xwAH35V8MfrORtyjk2M13cutiJ/V21CmVuDfyHfIgeJ04t2zIJWrx1g4VOVyUFJHVOw3QkkaZFtZQjboj+IyIqhFXEkYGB/3c7uaYQcIsq5WYs5JHXF7MU1V3Yjv5dvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfdQ8hrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04D1C2BCB4;
	Thu,  9 Oct 2025 01:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759972032;
	bh=DpWnKckSi1GoUQwHCRxOqqqXjZaYsYGRGLUY44Knqm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CfdQ8hrvVK2vjG1jELAZ9XB/VzbYM3QSariwjEz75dikULWouQXl5O8qfLrk69lYK
	 TGMNoWQKrhn01+aLWkmM40QZMGmJDATejJJ9bNLDhpsjTIL9JT2JpJN0tcR3ecnHAH
	 NWiwQuw9q0dGeoCsNy7+ju0TShILGhg6y6bvv7muSrI668XhVeIDfr8vySWiG66Du6
	 lSNLqTA0dl3ow6EQUCvasO8mvbjnV3DCqQtwU+B76U6U0uAZrXqPr1Kh4NGixICnK5
	 jBaYEernq9xC8jEw37vCbJD/QrXA64IImcHpOHNtjthovQVnob32nMWDBchOEqCZZO
	 XBOUxGjH1jRDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA53A41017;
	Thu,  9 Oct 2025 01:07:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] iommu/riscv: prevent NULL deref in iova_to_phys
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <175997202124.3661959.1599667136766880381.git-patchwork-notify@kernel.org>
Date: Thu, 09 Oct 2025 01:07:01 +0000
References: <20250820072248.312-1-huangxianliang@lanxincomputing.com>
In-Reply-To: <20250820072248.312-1-huangxianliang@lanxincomputing.com>
To: XianLiang Huang <huangxianliang@lanxincomputing.com>
Cc: linux-riscv@lists.infradead.org, tjeznach@rivosinc.com,
 markus.elfring@web.de, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Joerg Roedel <joerg.roedel@amd.com>:

On Wed, 20 Aug 2025 15:22:48 +0800 you wrote:
> The riscv_iommu_pte_fetch() function returns either NULL for
> unmapped/never-mapped iova, or a valid leaf pte pointer that requires no
> further validation.
> 
> riscv_iommu_iova_to_phys() failed to handle NULL returns. Prevent null pointer
> dereference in riscv_iommu_iova_to_phys(), and remove the pte validation.
> 
> [...]

Here is the summary with links:
  - [v4] iommu/riscv: prevent NULL deref in iova_to_phys
    https://git.kernel.org/riscv/c/99d4d1a07087

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



