Return-Path: <linux-kernel+bounces-802861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A0BB457A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 398547BF7FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C833734F492;
	Fri,  5 Sep 2025 12:18:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F4B34F489
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074687; cv=none; b=uQhf5FUfFUrRzUUnHpIZBx0n2U2CkDmgGa28QmHYZLSOvsyJ3mRR+wLYPGzSfm0AG3hGXsGcCGAm9xiR72J+pzDsm81mUZ/PrMjuV6AXemNYwzoDVQzHpkXaILtV2IDjAzM8Ux+JU/QVxK4orrhuEEzHAaZ9sfzSuGLd+oqV1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074687; c=relaxed/simple;
	bh=L/C+m9ufsyaQuo766Va79VvxCnNIpyK39d30W1Odl5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=huSv9Qhnhbr/bpjbhsFTtFBylc2urajHV1i2aDKdRrke3zwTu3sMttH4gypFOnylB0HAGNdpY5TovOXDvzC+YfMqm8VOAdiFKE0qUW6x8Gm7n+BZ5zGbhCb7GstKQZ1fj7G0JVA0mNDwYeLZLgNYr0+Y/S3spKxd99qNdLRD7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4BA8153B;
	Fri,  5 Sep 2025 05:17:56 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A8C223F63F;
	Fri,  5 Sep 2025 05:18:03 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/10] coresight: Fix and improve clock usage
Date: Fri,  5 Sep 2025 13:17:53 +0100
Message-ID: <175707466024.1601998.6971273893151391969.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250731-arm_cs_fix_clock_v4-v6-0-1dfe10bb3f6f@arm.com>
References: <20250731-arm_cs_fix_clock_v4-v6-0-1dfe10bb3f6f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 31 Jul 2025 13:23:36 +0100, Leo Yan wrote:
> This series fixes and improves clock usage in the Arm CoreSight drivers.
> 
> Based on the DT binding documents, the trace clock (atclk) is defined in
> some CoreSight modules, but support is absent. In most cases, the issue
> is hidden because the atclk clock is shared by multiple CoreSight
> modules and the clock is enabled anyway by other drivers. The first
> three patches address this issue.
> 
> [...]

Applied, thanks!

[01/10] coresight: tmc: Support atclk
        https://git.kernel.org/coresight/c/cbcf4373629d
[02/10] coresight: catu: Support atclk
        https://git.kernel.org/coresight/c/d2d97e8a0700
[03/10] coresight: etm4x: Support atclk
        https://git.kernel.org/coresight/c/7787ef97c205
[04/10] coresight: Appropriately disable programming clocks
        https://git.kernel.org/coresight/c/e0e41ef8c77c
[05/10] coresight: Appropriately disable trace bus clocks
        https://git.kernel.org/coresight/c/f4eb5567107c
[06/10] coresight: Avoid enable programming clock duplicately
        https://git.kernel.org/coresight/c/7529307188a1
[07/10] coresight: Consolidate clock enabling
        https://git.kernel.org/coresight/c/3fd383a81052
[08/10] coresight: Refactor driver data allocation
        https://git.kernel.org/coresight/c/e95ed1a3434e
[09/10] coresight: Make clock sequence consistent
        https://git.kernel.org/coresight/c/8d4432949012
[10/10] coresight: Refactor runtime PM
        https://git.kernel.org/coresight/c/70104caa4f29

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

