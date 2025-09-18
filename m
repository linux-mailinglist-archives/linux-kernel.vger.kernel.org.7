Return-Path: <linux-kernel+bounces-822836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1D9B84C48
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E8BE4A4E07
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF6D2FB62B;
	Thu, 18 Sep 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYEetT12"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013E1E231E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201432; cv=none; b=SIflhvPttwORbPmH01vsR1nzRqaJmguxKMlSr7hOZJuV+IPye+PbKAMvcmrtIYKuRZLpa7wQoYv8HX5McAbSFxkF1fcMm2Q/8CMUE22YVMLXAQIDHXfQsM7gRW/e3K+LaB6+tSZDRXGw7A+O+MqbZeW/rO1fnbw5O3/N2II2Ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201432; c=relaxed/simple;
	bh=VX4s2nGIy0qlhgbtFaRQWAxeR548nrV8nzp8x99o1Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TsrNWeTP/nnR7bEPRmzHu2rIxIVPtfd9GMSAm0Ijxdybu9qQA0nSo4XYcQpL/E883HmJ+zidqBJKKyl7dO0EQVkAa7eZYsSvn2XfkhwlhfQD9saPsIkA6af9g5DtaiIFGrnk3IeBb7nhasxfWpO+jl2OeDcEhFRRz7EFvBy7YVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYEetT12; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758201430; x=1789737430;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VX4s2nGIy0qlhgbtFaRQWAxeR548nrV8nzp8x99o1Qc=;
  b=RYEetT12KwPsG43+kxurr6M8aj9V9kpLNeVHxY7EN/HxdKcBOaPXC/XU
   KtRHtKFuiaG7UaTdTvYXfTu8NaVRHeplPzD82ktMF3G/1Y6fy3aKeIPMF
   DoJe/j+M05uSFc5bk/7BnnE4S0wajzOCR+vbAJht3Bmo0PIfSM4adFFgQ
   wKUzIjuwmhPV0F+gKr21vrnwM3c/78P1bIu7VX6L2LukcukCseA8zy93r
   a50eGiqf8h+hhHvFHuaAMIww4mgP6kd7L0fVIR+XOd+Vwx7JRohoMZ3Z5
   jLm0BpJplY4kcCjEZwf7S4HsthKRRh24quLFimCbgQc1Fqinkx6ZWK2Kn
   g==;
X-CSE-ConnectionGUID: XVyDjkVsQaaEjhoEtrhGmA==
X-CSE-MsgGUID: ZKrrqrzMS+eQeMpYGVia1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="77970683"
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="77970683"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:17:10 -0700
X-CSE-ConnectionGUID: TSLAcijeQIu6rNG0v4QnLw==
X-CSE-MsgGUID: +HZHTogPSiqHmKK5C04FTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,275,1751266800"; 
   d="scan'208";a="174648773"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 06:17:08 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Reuven Abliyev <reuven.abliyev@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [char-misc-next 0/5] mei: connect to card in D3cold
Date: Thu, 18 Sep 2025 16:04:30 +0300
Message-ID: <20250918130435.3327400-1-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When discrete graphic card enters D3cold th CSC engine is powered down.

On wakeup from the D3cold full HECI link reset is required.
The driver should detect that firmware requests link reset and initiate
the link reset flow.

In the usual flow the connect IOCTL will trigger the wake from D3cold
and corresponding link reset.
The MEI driver invalidates all open handles on link reset including the
one that triggered the wake rendering this connection unusable.
To break this loop make connect detect that it is interrupted by link
reset and retry connect attempt after reset was completed.

Alexander Usyskin (5):
  mei: me: trigger link reset if hw ready is unexpected
  mei: make a local copy of client uuid in connect
  mei: retry connect if interrupted by link reset
  mei: bus: demote error on connect
  mei: gsc: demote unexpected reset print

 drivers/misc/mei/bus.c     |  2 +-
 drivers/misc/mei/hw-me.c   | 59 +++++++++++---------------------------
 drivers/misc/mei/hw.h      |  2 ++
 drivers/misc/mei/init.c    | 21 ++------------
 drivers/misc/mei/main.c    | 43 +++++++++++++++++++++------
 drivers/misc/mei/mei_dev.h | 12 ++++----
 6 files changed, 62 insertions(+), 77 deletions(-)

-- 
2.43.0


