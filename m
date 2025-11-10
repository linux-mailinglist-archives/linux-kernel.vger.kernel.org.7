Return-Path: <linux-kernel+bounces-892812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49608C45E44
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E611A4ED83A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A5D302144;
	Mon, 10 Nov 2025 10:17:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF522F7AAC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769828; cv=none; b=XqaxJvXw5K6LxxAtS7jy0KwaD5r7R9GpQUwqasuSPCdkppRpFpE/pq1qdTnQy0P3ILoaf1y/IQzthtCMtVCP4082/kyV+drg2Q91tPgZlfl/jeLVdY6/VcY1IhINmtG+zQPdRebiR/UUR1UZG4A5CESzBU291LqCwYtw3fHAM3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769828; c=relaxed/simple;
	bh=7+wa0Na3uuR6yJOHetga/16MlOnQUqTrcJ9pKchrYBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAaxZVmWal2udyiHA9FQmW5LpdSeLuEHXVXh9Cc1IOy4lrNF/GyqtphiFUtYrMZKU1Qm8D3eVk50dK6dpZd5dC2AWbFP5Kjezg4uZXnLfNMSSML7juzydmTH324lNjASyaUYaz6k+OrcSi4riHeUHtZI2phQ9zkkvcnohXyb8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 870C72B;
	Mon, 10 Nov 2025 02:16:57 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D100E3F66E;
	Mon, 10 Nov 2025 02:17:03 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
	Carl Worth <carl@os.amperecomputing.com>,
	Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v2 0/3] coresight: replace the void pointer with coresight_path pointer
Date: Mon, 10 Nov 2025 10:16:55 +0000
Message-ID: <176276979719.511921.7702735480657824829.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925-fix_helper_data-v2-0-edd8a07c1646@oss.qualcomm.com>
References: <20250925-fix_helper_data-v2-0-edd8a07c1646@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 25 Sep 2025 18:42:30 +0800, Jie Gan wrote:
> Patch 1:
> Fix the issue that the catu cannot correctly read the handle of the AUX
> event which is caused by the commit[1].
> 
> [1] 080ee83cc361 ("Coresight: Change functions to accept the coresight_path")
> 
> Exeception call trace:
>      tmc_etr_get_buffer+0x30/0x80 [coresight_tmc] (P)
>      catu_enable_hw+0xbc/0x3d0 [coresight_catu]
>      catu_enable+0x70/0xe0 [coresight_catu]
>      coresight_enable_path+0xb0/0x258 [coresight]
> 
> [...]

Applied, thanks!

[1/3] coresight: tmc: add the handle of the event to the path
      https://git.kernel.org/coresight/c/aaa5abcc9d44
[2/3] coresight: change helper_ops to accept coresight_path
      https://git.kernel.org/coresight/c/94baedb51dea
[3/3] coresight: change the sink_ops to accept coresight_path
      https://git.kernel.org/coresight/c/b139702a8896

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

