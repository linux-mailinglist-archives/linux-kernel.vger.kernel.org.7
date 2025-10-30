Return-Path: <linux-kernel+bounces-877651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBCEC1EAC1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3EC188E8EA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E6A334C31;
	Thu, 30 Oct 2025 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnxUwneK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A863195F0;
	Thu, 30 Oct 2025 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807823; cv=none; b=fdKElzw+5xQKL+RAFqHbA5+CRafOo15FuvVQTqz5BFRJCfIhxpZAJGp+clQ9ILnT0co8JxlBFDP/HzByID2Q/sUMNusIllXzEqQmd4hh8VC3rMxLM4gahcbXVSmgH/2nCFloZlurUU0wKdLFC5u0SLr1ICt4b8KED3JZIJ4t20g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807823; c=relaxed/simple;
	bh=JEwYEiTF+lrV+WrYB82xOF+okUr2wYSqJC8XxFxiDBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivc7uPi8KgrYZDu/XUTy4IuM/S/rXJTX9bH5dRwNX/CTO/peXjCmM3o42YmM/3j4u5k6rloI+BxELYeimNtK8rk1Mzkza9UiUijdV13BTcG6Q8Q8sUNFn9Iihx6jhwJs9UqMXQVCXL0pU3qzGlV7xENbVon2+LG+mMaAUCqjbaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnxUwneK; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761807822; x=1793343822;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JEwYEiTF+lrV+WrYB82xOF+okUr2wYSqJC8XxFxiDBo=;
  b=ZnxUwneKkYrkpRrfpYoEvwIrYx30i2O5rUm8TXiT/y+SqqCHnRRJrmOJ
   kceRTjojJeBdiypn+krtTOobIDu6ZNx8HFr5kSALsa3otX7W4/H0wmfxq
   IGLlsz5Tv6yWsEClc2qYbpsPp2JzeCXhqljMisrps2yob4Ob0VCDTS8Km
   MwD4iXEkJKl5Ve93VBCOZtmxNgSfTovjw11CzmGOawbnwbwfwmcKjLjzN
   7tOjwCEjPg19hTNLMRymy0AzX2SyfPJtRbpDZS7OYaebi5sdqbUjpvjYb
   Heq/3C3rtdEJShyI5t+Cf2OM0/MVAy+KSI86+yeuXGs4t5yU47QSHP4U1
   g==;
X-CSE-ConnectionGUID: oraT6m/kSBqLDYzILKxj5w==
X-CSE-MsgGUID: M7UhgjktQrmUVBbz+Znp8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="81359510"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="81359510"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:41 -0700
X-CSE-ConnectionGUID: xkL4niZbQbqVdjxglRaEVQ==
X-CSE-MsgGUID: D4fUBBM1RWCpo7biYUWofg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186621352"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 00:03:38 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org,
	broonie@kernel.org,
	tiwai@suse.de
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH RESEND 0/7] ASoC/soundwire: add fake BPT frame to align Intel DMA buffer size
Date: Thu, 30 Oct 2025 15:02:46 +0800
Message-ID: <20251030070253.1216871-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a constraint on Intel DMA buffer size that needs to be a
multiple of data block size. This series adds some fake BRA frames
to add some extra buffer size to meet the constraint.
The change is mainly on the soundwire tree. It would be better to go
through the soundwire tree.

Bard Liao (7):
  soundwire: cadence_master: make frame index trace more readable
  soundwire: only compute BPT stream in sdw_compute_dp0_port_params
  soundwire: cadence_master: set data_per_frame as frame capability
  soundwire: cadence: export sdw_cdns_bpt_find_bandwidth
  ASoC: SOF: Intel: export hda_sdw_bpt_get_buf_size_aligment
  soundwire: cadence_master: add fake_size parameter to
    sdw_cdns_prepare_read_dma_buffer
  soundwire: intel_ace2x: add fake frame to BRA read command

 drivers/soundwire/cadence_master.c            | 85 +++++++++++++++++--
 drivers/soundwire/cadence_master.h            |  7 +-
 .../soundwire/generic_bandwidth_allocation.c  |  3 +
 drivers/soundwire/intel_ace2x.c               | 61 +++++++++++--
 include/sound/hda-sdw-bpt.h                   |  7 ++
 sound/soc/sof/intel/hda-sdw-bpt.c             | 13 +++
 6 files changed, 161 insertions(+), 15 deletions(-)

-- 
2.43.0


