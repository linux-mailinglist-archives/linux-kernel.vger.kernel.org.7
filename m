Return-Path: <linux-kernel+bounces-827285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFAAB915B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558E11885283
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1349C30FC1B;
	Mon, 22 Sep 2025 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwUQQPcO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CB930F547
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546916; cv=none; b=QH53lgacPCwuq12+Cjo68zUBcxI0/HHQDIs5BKYBzUv5Ge6D8oZj1mrdCiZRecmLAqRniwcwCBjlRd9AV7XHUuf8V86GJpDbaMmJ3VC7tlm7IpD3E2cDuFQYMjyzoKBIQNClmOuBJr4ltMP99UsQUYmMu6TuSVG5E5zShuFeUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546916; c=relaxed/simple;
	bh=LiqDKW6ln9kt2Zw8dlUpGxSN/0CLn3XcrFMQrC+5Rws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FeWuL2LhyoiaueZ5LNvLblP/8bnkbxr/8xYMw0CB3zCSra/vhiD9zc1mv86WotZjGeh+kbQdEps9c+x1SvINAKqZyntK+PDvGDR1Bl2yzPlP6O4wR7DZ0w/c9PaFIH8gVfiFWQq5b9dRGq10TPjSeR4mH4kNOEZR0d1IP8bGLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwUQQPcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39652C4CEF0;
	Mon, 22 Sep 2025 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758546916;
	bh=LiqDKW6ln9kt2Zw8dlUpGxSN/0CLn3XcrFMQrC+5Rws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nwUQQPcOkH1aPz6j/UFapAp0qwd6wDdo7Rz4l2YxigQacqsAbNQ47biaipWCrhfwy
	 ZqvJJ6zpurl+jsvmJyjKYlLnMklNg1Yt0lByNYqL3OA6HgrNq/+103Zi3l7WcNklDI
	 r5ntE2SR094aJxUtOciZBe7PXyOCW+sqNsJQInzROwTTipdvWnx6NAqVlUrd1r2FHm
	 LrpuTbKoqQ0D5ejuNfORv6NFq/rURfIKcEds0sNHX5oeoKq5qYGz2Uu8mvOSKuVfcn
	 xyW3aBFLsiGNu/ozxyzdxw4r/ohLt+E0x4U+8vAkzPdM5D/gJGIKaScK5KCnYt2QZa
	 GLNvFgEK2Jpbw==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yushan Wang <wangyushan12@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	robin.murphy@arm.com,
	yangyicong@huawei.com,
	Jonathan.Cameron@huawei.com,
	liuyonglong@huawei.com,
	wanghuiqiang@huawei.com,
	prime.zeng@hisilicon.com,
	hejunhao3@h-partners.com,
	linuxarm@huawei.com,
	fanghao11@huawei.com
Subject: Re: [PATCH v3 0/9] Updates of HiSilicon Uncore L3C PMU
Date: Mon, 22 Sep 2025 14:14:51 +0100
Message-Id: <175854328084.3142502.15045454616796206368.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829101427.2557899-1-wangyushan12@huawei.com>
References: <20250829101427.2557899-1-wangyushan12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 29 Aug 2025 18:14:18 +0800, Yushan Wang wrote:
> Support new version of L3C PMU, which supports extended events space
> which can be controlled in up to 2 extra address spaces with separate
> overflow interrupts.  The layout of the control/event registers are kept
> the same.  The extended events with original ones together cover the
> monitoring job of all transactions on L3C.
> 
> That's said, the driver supports finer granual statistics of L3 cache
> with separated and dedicated PMUs, and a new option `ext` to give a
> hint of to which part should perf counting command be delivered.
> 
> [...]

Applied to will (for-next/perf), thanks!

But please see my comment on patch 5 regarding the user ABI.

[1/9] drivers/perf: hisi: Relax the event ID check in the framework
      https://git.kernel.org/will/c/43de0ac332b8
[2/9] drivers/perf: hisi: Export hisi_uncore_pmu_isr()
      https://git.kernel.org/will/c/4550244b53b7
[3/9] drivers/perf: hisi: Simplify the probe process of each L3C PMU version
      https://git.kernel.org/will/c/0960e535be54
[4/9] drivers/perf: hisi: Extract the event filter check of L3C PMU
      https://git.kernel.org/will/c/2271f1634243
[5/9] drivers/perf: hisi: Extend the field of tt_core
      https://git.kernel.org/will/c/ede339ff61c6
[6/9] drivers/perf: hisi: Refactor the event configuration of L3C PMU
      https://git.kernel.org/will/c/b3abb08d6f62
[7/9] drivers/perf: hisi: Add support for L3C PMU v3
      https://git.kernel.org/will/c/475d94dfe7c6
[8/9] Documentation: hisi-pmu: Fix of minor format error
      https://git.kernel.org/will/c/272dd0e5e58d
[9/9] Documentation: hisi-pmu: Add introduction to HiSilicon V3 PMU
      https://git.kernel.org/will/c/6d2f913fda56

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

