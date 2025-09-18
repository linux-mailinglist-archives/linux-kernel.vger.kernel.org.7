Return-Path: <linux-kernel+bounces-823305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D15B86156
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 18:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D2F57C7072
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE28B317701;
	Thu, 18 Sep 2025 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvbzvZYN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9BE262FDD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758213826; cv=none; b=fuaBjgJx2jl8ceKcmbteOdZtkMzOHcfNOKDg84pDwUukHOdJle03ZJuKpdbhyXuJ0zlZo48HoK8zhHFbiLhTd0688+9GNoflpEmk+Pm1WYVM8fSjqFJBokgvwodIe5W5/AvLEnjawMfup0tdnnonrXNva1WGNd3hjks05ZmTjj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758213826; c=relaxed/simple;
	bh=53e840m3n/a/k8+36ELCSNVhMPXJKux/vYQJuLq6rIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AtJ7PzVAcuP4MXT7ZfVr/Dwzpl2dIx2MU/2ZXHkYijUXakUkktWISGns0MPbXxbhqS88LezFaukuP11K5Wla/vo6l28sBPv2rrLedEBntf3vdmmRl8lw06zhWOxj2Uf7aNJQ2g86+dSoMWKvqwEJIAeotvpITfMN7qD9chPCeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvbzvZYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614DFC4CEE7;
	Thu, 18 Sep 2025 16:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758213825;
	bh=53e840m3n/a/k8+36ELCSNVhMPXJKux/vYQJuLq6rIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lvbzvZYNqbo5dVsKqEPtCOifuWE+6YUGR5bO+mXIiwQbXCZu5Pj8w3oQBfmZsIZmK
	 DgGZ5T7s5qikDeWSgJ5J20ymqdy+n0nL9wqkVhJJ4ieJCF6ovXii9V1VGgwTtWHPR4
	 znRp+IdXAvbvpNi7is2T+K21JE08cLYVzoUMXH9bl8Rr8FzXyGk8qx1P6T985oci35
	 q0kX7fEzFTMdA/A/6XjUsmNVO+ZJ6n2JhPrm03GaevDXTqeRXS4W/Rg7+ndkF9pc70
	 DMWYtFi6f2A8v7hVgvoT9Dm4zp630JQOrgu12WgI5rWzC0WWrttpU3SOhqLAEB3wxH
	 SdIK8I2tlCEjg==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yicong Yang <yangyicong@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com,
	linuxarm@huawei.com,
	yangyicong@hisilicon.com,
	wangyushan12@huawei.com,
	hejunhao3@h-partners.com
Subject: Re: [PATCH v6 0/3] drivers/perf: hisi: Add support for HiSilicon NOC and MN PMU driver
Date: Thu, 18 Sep 2025 17:43:12 +0100
Message-Id: <175820367089.3477070.15258053757814970418.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814091622.23269-1-yangyicong@huawei.com>
References: <20250814091622.23269-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 14 Aug 2025 17:16:19 +0800, Yicong Yang wrote:
> Add support for two new Uncore PMUs to monitor the events of the system bus
> (by NoC PMU) and the DVM operations (by MN PMU).
> 
> Change since v5:
> - Rebase on 6.17-rc1 and update the maintainer entry
> Link: https://lore.kernel.org/linux-arm-kernel/20250717121727.61057-1-yangyicong@huawei.com/
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/3] drivers/perf: hisi: Add support for HiSilicon NoC PMU
      https://git.kernel.org/will/c/e31c0eb10388
[2/3] drivers/perf: hisi: Add support for HiSilicon MN PMU driver
      https://git.kernel.org/will/c/2257798498b3
[3/3] MAINTAINERS: Remove myself from HiSilicon PMU maintainers
      https://git.kernel.org/will/c/542342d27122

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

