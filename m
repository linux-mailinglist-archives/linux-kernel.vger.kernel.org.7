Return-Path: <linux-kernel+bounces-816529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE60B57502
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276D81899425
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CD82F9C2A;
	Mon, 15 Sep 2025 09:39:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E051C2F83D0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929164; cv=none; b=QmvsLf5VaOSTKE0CZS6/xRDW1ItB1QN25f5X2uPAfGpBYH5NaWMCW7ErpjQYJwb+feY4lev31JLGkkadEk/ONWYUosVbe64FnpgmYHyyY4ETzzWFYy1LMmIFf9S4e+MiMXPl6pTaYSPyRRKwulhBKFTU2P+LntnBcAEKoIpk6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929164; c=relaxed/simple;
	bh=Sdl9rJn387DrexB6J3tuq0u+aAaBh8Nnl1aBGMUZy4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBKGB5J0HvcETPogsqg6MyjVEL/bdia4tw3LxJQ9fsp46hHfWCho8lUNfiUpK7pAWJ7JoMiMygtlp6MAl6yzda8jN6eo8yY50X6TIfryvjYMYR2+2K2MWleVxRF5iYcXRSChJUow+Fc4awrWor1hVrYgv+Wh+IJ28Pd/Hv1GAQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D31D1BF7;
	Mon, 15 Sep 2025 02:39:14 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A01A3F694;
	Mon, 15 Sep 2025 02:39:21 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	kernel@oss.qualcomm.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: tnoc: add new AMBA ID to support Trace Noc V2
Date: Mon, 15 Sep 2025 10:39:05 +0100
Message-ID: <175792909826.1970499.10299309349498800279.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814-tnoc_v2-v1-1-3285e37280c9@oss.qualcomm.com>
References: <20250814-tnoc_v2-v1-1-3285e37280c9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 14 Aug 2025 02:00:13 -0700, Yuanfang Zhang wrote:
> Add the new AMBA ID 0x001f0c00 to support Trace Noc V2 instances.
> 
> 

Applied, thanks!

[1/1] coresight: tnoc: add new AMBA ID to support Trace Noc V2
      https://git.kernel.org/coresight/c/5e6ddce7a8ff

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

