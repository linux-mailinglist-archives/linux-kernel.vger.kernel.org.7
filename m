Return-Path: <linux-kernel+bounces-862545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D465EBF592B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C583D4FE2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6E73126B8;
	Tue, 21 Oct 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTq34NDv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896582DF71E;
	Tue, 21 Oct 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761039852; cv=none; b=TIktILTjelur+T931KGottLS/1LBPftlnx/nkAkNKRsyBVchgbR495hInJOm0pBC6568Py6nYYHAVD1pE9MnqZZ4/kDlldqq5zQbDqFSab1OWl75BGyOS9DQtttac7SiccLCs24OX8HdYED1ybN+gtnshtv2khLV/vsdNcYtQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761039852; c=relaxed/simple;
	bh=kuFjXWGu0C0kpNpoeEspTyPHSMRnZRlc6mPZcdAAYOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tWs2Fm6wGG5btd7klkQR+9nQlwzd0xLD5sTjPlhSkVciDWApEOe7r95KNnyMlQhg9I8G32Hof7D4Epvfo0ylDpHqPCnfrd/4qzN/Nfiv/nZczK6Rfb5RpsGR2gkK4Dinm59+4ipL/URcxzjX2D5/knkgfnf2d2NRoJoOLyJmh8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTq34NDv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761039849; x=1792575849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kuFjXWGu0C0kpNpoeEspTyPHSMRnZRlc6mPZcdAAYOg=;
  b=aTq34NDv8P7rRhVep4iJoGcXSwOpvxeUVcWIPfFGvGz8rBXCDQXTIw8O
   6bhlNFkYtytqRLC3B6DAwHsbKpbwvdQOiERIYi1GMFAZjhjWKeetjuXk+
   K/m2xVgBoz0nuue1rJcZtIRerJIaUebPVCVHEbOosIh+U/6CR+ToFiCeF
   2tAmvsiy73fh/VUDU1rwMHEitM8Zo4yYr9K3nLlqc3seaD6+Xeenbx+kb
   p4pLDLKU6Iz0l4sfQiwLpbLS71Kvt7h6upyzdBD1SQCT1Y4wy2984cZ1b
   zOcq2XYn0sGb1sRZhOJad6CfcLV+W27QNfqtesHzmoVDN2GQO1NGxDimY
   w==;
X-CSE-ConnectionGUID: o2CV/WJnS7WNcUd5SCGZ3g==
X-CSE-MsgGUID: +QpwxTuKTSqullP4/qWkUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63259371"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="63259371"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 02:44:07 -0700
X-CSE-ConnectionGUID: V3izXw2KS1aGYeNSnwphKQ==
X-CSE-MsgGUID: Y+EWav+eRjaNJa3mbn1oTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="182753530"
Received: from yungchua-desk.itwn.intel.com ([10.227.8.136])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 02:44:05 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 0/3] soundwire: send multi sections in one BPT stream
Date: Tue, 21 Oct 2025 17:43:51 +0800
Message-ID: <20251021094355.132943-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we send a BRA message with a start address with continuous
registers in a BPT stream. However, a codec may need to write different
register sections shortly. It makes more sense to send different
register sections in a BPT stream and no need to close/open the BPT
stream repeatedly.

This series depends on the "ASoC/soundwire: add fake BPT frame to align
Intel DMA buffer size" series. Sending it now to get more review time.

Bard Liao (3):
  soundwire: introduce BPT section
  soundwire: pass sdw_bpt_section to cdns BPT helpers
  soundwire: intel_ace2x: handle multi BPT sections

 drivers/soundwire/bus.c            |  10 +-
 drivers/soundwire/bus.h            |  22 ++-
 drivers/soundwire/cadence_master.c | 218 +++++++++++++++++------------
 drivers/soundwire/cadence_master.h |  12 +-
 drivers/soundwire/debugfs.c        |  14 +-
 drivers/soundwire/intel_ace2x.c    |  47 +++++--
 6 files changed, 205 insertions(+), 118 deletions(-)

-- 
2.43.0


