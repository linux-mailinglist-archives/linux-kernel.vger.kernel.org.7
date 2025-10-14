Return-Path: <linux-kernel+bounces-851738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9645CBD7297
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84E0F4EFD03
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8F73054C7;
	Tue, 14 Oct 2025 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b4L22p3a"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33170307AEC;
	Tue, 14 Oct 2025 03:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411706; cv=none; b=FJ8DXwrL/hLua/PsUOJLeYlVE22Mfj+a3D/M/R4HRPEqTny42vEYalbV4YRXwrS2Tl2lRSvMURBVrfmIpu/OKsvuFIuXZ2SEikT3msBUuruH/3O9Z2YXpi6Ry39pd0Bcw30M7rUU/HlNtFbvxwdrDKR6ruwM5JJbKOd2MPnk9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411706; c=relaxed/simple;
	bh=JEwYEiTF+lrV+WrYB82xOF+okUr2wYSqJC8XxFxiDBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XXhRCwEzOMh31Y8QES1b3HhpJJik3Y7TpJNpkZfGFwOLI5zo/uGZ2bRrRUWJmQui5YiAvwUhNDTnnBWW4vOc/cB8zOPNmGn09w06V6vXsmSa0xHs3spsFw/o7MV1N78EBsMYoyP2zIWrsWuY8JHzCP9CDayo8ZL9tHtcK48+cJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b4L22p3a; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760411704; x=1791947704;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JEwYEiTF+lrV+WrYB82xOF+okUr2wYSqJC8XxFxiDBo=;
  b=b4L22p3aGhU/7WVpSIBbKUyAjUOFlj4PUcivDTmaF61tGQ4phvtN7j7e
   Z7e64u/TBli4BhTqqLH+o2/PD9E9uaDCO63w0R00wvTo3zSVix1ZpHrzD
   oKIN6XxvEHFV+5eK9Y9CfO0hjC2/RD6Clcz7V+TrccDmFJkUnTlIszCN0
   OPI56uPuEsYZaktnqIbSpt7Nh8/8b1xZcwU2DoEIhTRlSsa8V5N0C6+1v
   JbDhN3l37mEp7fbeNFmHUzwvBb3lduHgXXKKBH3xV2ocFaO1ry6vcLv3t
   v43H0p951IVdKR59SxGdMPBG14f/ykbM8/6fsr4P2E7eGb70JhdyylM74
   A==;
X-CSE-ConnectionGUID: /igm9wfYSca8xYqi+qnt5Q==
X-CSE-MsgGUID: 5DHOkE++TLiJL40raNKHww==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62662056"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="62662056"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:03 -0700
X-CSE-ConnectionGUID: 79xk/1D9QAGIVLVrYRGt5A==
X-CSE-MsgGUID: ieNVOFFRRuON/T6NvJEDVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; 
   d="scan'208";a="182198536"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 20:15:01 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 0/7] ASoC/soundwire: add fake BPT frame to align Intel DMA buffer size
Date: Tue, 14 Oct 2025 11:14:43 +0800
Message-ID: <20251014031450.3781789-1-yung-chuan.liao@linux.intel.com>
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


