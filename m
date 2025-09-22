Return-Path: <linux-kernel+bounces-827281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10E8B9158F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0177176396
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693CC30E0C3;
	Mon, 22 Sep 2025 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQXzfxqE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774530C603
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546903; cv=none; b=hwUHyby2r5fa5cvaUF8scUwuXuelCnVo7rx6oHdPL9bMH1tSjCszgS3ckjtsvoE1u3qiSSKISXjAfGQdY9cuRkG9oXb2UicqtzqnHb9SNnMD2WBOQmnozYdosB1vKhWfJ4HOUMMRmpiQ2vSh5YnSXYP2wyitFMl4Jrquba5NxNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546903; c=relaxed/simple;
	bh=qjcfXLp3AdjFsxFqfhoPlQvU2ruch20geThD74U3Oxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAR3cAUAK+TcZRSFtt08Xb4A1+EA7tQcPwCdYbAAL5HVzwkAu6PD8g7Wni3LZZo8FD8ODLziYOMPJtLKuk3l3ZUO8O49LvdrgWHbLEJdV4OA8Yzu7zLZ/MoUI5YthFNKhz9iclD9BhhKiNrLFNfuW/4TnjJZXIYiFG4CJ00WW1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQXzfxqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28763C4CEF7;
	Mon, 22 Sep 2025 13:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758546903;
	bh=qjcfXLp3AdjFsxFqfhoPlQvU2ruch20geThD74U3Oxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQXzfxqEBkXsvV/5O9r23tMytKaOJxHZ9tJbVyrTZa6N5VhughdZFdPTfLTeQR2Vs
	 mXhVeMM69afE1M9rFlpV/6JZ0b1zGkkwNSkka2Zbeb1JBh+uht96wXvy9XHO40BtRO
	 /6H0yOn1KngO7a5PTnPJxFw9eo5z7n2Zx7XEHZITNi8uxBOaivePpwP5cO49JGFmQ2
	 NemIirxWtiqPKZ1qmkQQvSte2vlGwdMHhex887ZISrpRc6BIaIP1WIX4PEe6y4GJTX
	 9VYUZCwr6nTKjvbz1iwhCs/c35Xxni1B14bN+9DkEPjwHAzxe2hzKDiTYAZZVz6viY
	 v+7UUtRFx/aUA==
From: Will Deacon <will@kernel.org>
To: catalin.marinas@arm.com,
	Dev Jain <dev.jain@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	anshuman.khandual@arm.com,
	quic_zhenhuah@quicinc.com,
	ryan.roberts@arm.com,
	kevin.brodsky@arm.com,
	yangyicong@hisilicon.com,
	joey.gouly@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	david@redhat.com,
	mark.rutland@arm.com,
	urezki@gmail.com,
	jthoughton@google.com
Subject: Re: [PATCH v6] arm64: Enable vmalloc-huge with ptdump
Date: Mon, 22 Sep 2025 14:14:46 +0100
Message-Id: <175853832495.3123711.10100627692023962115.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922064126.63016-1-dev.jain@arm.com>
References: <20250922064126.63016-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Sep 2025 12:11:26 +0530, Dev Jain wrote:
> Our goal is to move towards enabling vmalloc-huge by default on arm64 so
> as to reduce TLB pressure. Therefore, we need a way to analyze the portion
> of block mappings in vmalloc space we can get on a production system; this
> can be done through ptdump, but currently we disable vmalloc-huge if
> CONFIG_PTDUMP_DEBUGFS is on. The reason is that lazy freeing of kernel
> pagetables via vmap_try_huge_pxd() may race with ptdump, so ptdump
> may dereference a bogus address.
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: Enable vmalloc-huge with ptdump
      https://git.kernel.org/arm64/c/fa93b45fd397

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

