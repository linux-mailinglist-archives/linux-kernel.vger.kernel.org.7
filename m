Return-Path: <linux-kernel+bounces-741174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41F7B0E0F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7D7567C46
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC47279DBC;
	Tue, 22 Jul 2025 15:52:24 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DBC7F9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199544; cv=none; b=YfpHyQemYa17zxH0YdThv0r0QAVYNIYtdt7uNPjhD+oqnq/0sCcI/+KrAOSJiTwZzyk70fVHxMgzAOkK5aN2aSaGYzarIr6+oVQwa7IAQLf8frV0m3s+DjiVVogzrVSdJNRisMivMGRoVIWkri10jtq3r8CiFvWa8NWO8QW2Je8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199544; c=relaxed/simple;
	bh=vmLU0iRNbZ4wTBGMoFKBRnSwvpf0NEsuT7MXCmwiJB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSPi0d8z31hpVtXiQo7dvYIzTyICYsdYBHJrcBPQl1F2I7i/d7XH5JOFr0YmvyFA80n1qKIsdvCoI19E64qv1ZxaBW1DZuMzCUU0su73OkqA+NjY/2UFastfXy082vrCTAaUVb6oFgMYQnXC7zdnCJSkRMXl4ZKeWFYABk9ACYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD6451516;
	Tue, 22 Jul 2025 08:52:15 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C1203F5A1;
	Tue, 22 Jul 2025 08:52:19 -0700 (PDT)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: mike.leach@linaro.org,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	leo.yan@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] coresight: fix indentation error in cscfg_remove_owned_csdev_configs()
Date: Tue, 22 Jul 2025 16:52:11 +0100
Message-ID: <175319951714.340844.3950740374860481675.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250611103025.939020-1-yeoreum.yun@arm.com>
References: <20250611103025.939020-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 11 Jun 2025 11:30:25 +0100, Yeoreum Yun wrote:
> Fix wrong indentation in cscfg_remove_owned_csdev_configs()
> 
> 

Applied, thanks!

[1/1] coresight: fix indentation error in cscfg_remove_owned_csdev_configs()
      https://git.kernel.org/coresight/c/a80198ba650f

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>

