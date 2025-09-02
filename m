Return-Path: <linux-kernel+bounces-795939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A64B3F9AA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCADD3AC165
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC962EA17E;
	Tue,  2 Sep 2025 09:07:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF852E9EC1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804043; cv=none; b=tTdAv7pAX0V//spNEAa+IwVM+XVZKZcX6ogl/4I1Qs4CdH48u3BBK1eaLMBb7oQVxFA7tj6PbaSs5c3HN5Qir55QEBdXkI0T+gEDcoNDsHeKcJnvDVJUbdjfXreUYiwHhVW7w6dkDPrKipmQqo2QOqp5Xxp9DLJw6Tk2DA5iPmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804043; c=relaxed/simple;
	bh=oyZj9LTmAajnVh8zv2+0ALUOAoH5+UPAaQF93+ruRJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AeIpVLgjn7UJfcue1qNfp3wpxePQPuhaNVD3EYk/mpeYPPTc37LlEFnK1F/ctbpZGpCTI9JcMv5CFcH9ucBS704ooWvtsTTIc3Q08ool3nHc9BwJx3hMIoNhHfSiGy6zlozXF31NVk1iS3qBIk7JgkpwD1kMXodbRIksG4RQwB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 333F215A1;
	Tue,  2 Sep 2025 02:07:12 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 47A313F694;
	Tue,  2 Sep 2025 02:07:19 -0700 (PDT)
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
Subject: Re: [PATCH v2] coresight-etm4x: Conditionally access register TRCEXTINSELR
Date: Tue,  2 Sep 2025 10:07:07 +0100
Message-ID: <175680388753.1463011.11768877299078508774.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812-trcextinselr_issue-v2-1-e6eb121dfcf4@oss.qualcomm.com>
References: <20250812-trcextinselr_issue-v2-1-e6eb121dfcf4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 12 Aug 2025 01:24:45 -0700, Yuanfang Zhang wrote:
> The TRCEXTINSELR is only implemented if TRCIDR5.NUMEXTINSEL > 0.
> To avoid invalid accesses, introduce a check on numextinsel
> (derived from TRCIDR5[11:9]) before reading or writing to this register.
> 
>

The patch looks good to me. May be we could expose this via sysfs, like we
do for the other fields. That can be a separate patch without the Fixes tag.

I have applied this patch to -next, thanks!

[1/1] coresight-etm4x: Conditionally access register TRCEXTINSELR
      https://git.kernel.org/coresight/c/fa71e9cb4cfa

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

