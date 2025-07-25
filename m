Return-Path: <linux-kernel+bounces-745496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AABB11AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9283916CFF5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427AC2D0C75;
	Fri, 25 Jul 2025 09:22:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258A3253932
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753435343; cv=none; b=FX0LQ+xG1zJqymhbHCsGLqqqbCBtOn80E7WfgyJlpIjHooVakzSvCSxWtOjFiKRfn69YLXxVWYbhCuDI87/DY78rihJ4/Ixuwn3unPt9sPmXNAj0xdZFcZaHnW7f+eeha4/ZEb8TQQTxHo9uFSdNvblH3VhbM90Kp6KCkEkxOpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753435343; c=relaxed/simple;
	bh=lFf7dAF7O/GuuR6g+Ls/xCOMzdD9t4a0mYHS4kvTCEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khM1C3Loz0cFYmQSyMYEQEzJOPsZ0+rfPk+5cXVVNCPhdGVPcS5fl9gXMTDHVZ02K0/6Wtkn994DX5Hv6/5XtY+7llwt6eGdAb18LKO37Khc1jgMszm1Iy+etLc+0ZXaDOP6sLkQMvRYplyC3mcdXvDzneyEzfh3B5xQWAOr98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 694C8176C;
	Fri, 25 Jul 2025 02:22:14 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B55213F66E;
	Fri, 25 Jul 2025 02:22:19 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] coresight: Fix and improve clock usage
Date: Fri, 25 Jul 2025 10:22:11 +0100
Message-ID: <175343531849.493374.1972746372917823.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 24 Jul 2025 16:22:30 +0100, Leo Yan wrote:
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
        https://git.kernel.org/coresight/c/e96d605a66ff
[02/10] coresight: catu: Support atclk
        https://git.kernel.org/coresight/c/7eca4399060d
[03/10] coresight: etm4x: Support atclk
        https://git.kernel.org/coresight/c/14fb833b8204
[04/10] coresight: Appropriately disable programming clocks
        https://git.kernel.org/coresight/c/ce15ee28bddd
[05/10] coresight: Appropriately disable trace bus clocks
        https://git.kernel.org/coresight/c/90b0000bd501
[06/10] coresight: Avoid enable programming clock duplicately
        https://git.kernel.org/coresight/c/5c0ead76597b
[07/10] coresight: Consolidate clock enabling
        https://git.kernel.org/coresight/c/f47d7f7da638
[08/10] coresight: Refactor driver data allocation
        https://git.kernel.org/coresight/c/7471c81e60b9
[09/10] coresight: Make clock sequence consistent
        https://git.kernel.org/coresight/c/d4cf59aa905b
[10/10] coresight: Refactor runtime PM
        https://git.kernel.org/coresight/c/2b52cf338d39

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

