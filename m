Return-Path: <linux-kernel+bounces-834037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDFBBA3A5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FAEF561A84
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571A32DFA27;
	Fri, 26 Sep 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVixiPpB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BDD18C02E;
	Fri, 26 Sep 2025 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758890343; cv=none; b=ADw/Ejqd0bV8AXvY8qBaIOpBIM/MIIKblS5rx4ggAbYmQKKXrWWEa0DRJ2KEWh5kg7ygXhmHeUaRvg9aYMSxnPQ534j/Gt6Ugw2XS97cTrgYgCHVyFopccpObbDosP+FCf5KcutRuUBX9zN6X600bb3EK15ohwqe7ucRSIb/xao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758890343; c=relaxed/simple;
	bh=0MvAdeRu8ksGrr28htzwNweMx63CR1lOx7DQzKb5P80=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=gNLpQNeQG9jTkfL44TpDfvdfnEdDnYk+AYA2RRT5ztBGOATzIIqhy/A7h9LY2Lo+1z3CFgSIsFyFIYZT2oONhziMWHrCDMkW4p2AhLz/Xs3w8sPCVDJbI+oYN+T65Rqmq7L4hp+ZpMTKqiR6D12k28Rd3DtWThV8bcuIqja27uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVixiPpB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758890342; x=1790426342;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0MvAdeRu8ksGrr28htzwNweMx63CR1lOx7DQzKb5P80=;
  b=TVixiPpBQdMpl32jLd7meETWh0eNgeup2GrbBYt5M22eh5ATvA83XLNR
   /WYV/uRpLTCtXS2g93TSNkW7LMEyNjEDmZZU6Qlya6oweEf+YkVmgQdbI
   bMOKLKjiQAPQOz0aPOPq7wh5kfOOUEfPwmLh4+gjpV/LUgFQo1oX7c2jl
   MGhI7KFKAz8CYjaV2nQCUINMG7w2wYBZtBSw7rY5Auo30hKHPwj8TQ8hC
   wehRqRBlM8U5HT4L53B6diNSvAJh9foo6MkixdYJLRq30PNY4dzLm6buV
   yDVq7IVPLSV2o6Rr5+LpHOlutiNkORHpM9ZOM9NzhdswBuF8cnzSHEgM3
   A==;
X-CSE-ConnectionGUID: YRKvgAPpQ2uvvEJxT0/+lQ==
X-CSE-MsgGUID: PiIcberCQEyTxxpBI3TwvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61272552"
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="61272552"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 05:39:01 -0700
X-CSE-ConnectionGUID: liQcRqzsQj6fIBQGZy0Iig==
X-CSE-MsgGUID: 9nGPIktPT7K/gDH7Red4hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,295,1751266800"; 
   d="scan'208";a="182006816"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.23])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2025 05:38:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, Andy Shevchenko <andy@kernel.org>
Date: Fri, 26 Sep 2025 15:35:52 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.17-5
Message-ID: <pdx86-pr-20250926153552-300446329@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.17.

Fixes and New HW Supoort

- amd/pmc: Use 8042 quirk for Stellaris Slim Gen6 AMD

- dell: Set USTT mode according to BIOS after reboot

- dell-lis3lv02d: Add Latitude E6530

- lg-laptop: Fix setting the fan mode

Regards, i.


The following changes since commit 225d1ee0f5ba3218d1814d36564fdb5f37b50474:

  platform/x86: asus-wmi: Re-add extra keys to ignore_key_wlan quirk (2025-09-16 11:30:39 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-5

for you to fetch changes up to 3ed17349f18774c24505b0c21dfbd3cc4f126518:

  platform/x86: lg-laptop: Fix WMAB call in fan_mode_store() (2025-09-25 12:21:43 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.17-5

Fixes and New HW Supoort

- amd/pmc: Use 8042 quirk for Stellaris Slim Gen6 AMD

- dell: Set USTT mode according to BIOS after reboot

- dell-lis3lv02d: Add Latitude E6530

- lg-laptop: Fix setting the fan mode

The following is an automated shortlog grouped by driver:

amd/pmc:
 -  Add Stellaris Slim Gen6 AMD to spurious 8042 quirks list

dell-lis3lv02d:
 -  Add Latitude E6530

dell:
 -  Set USTT mode according to BIOS after reboot

lg-laptop:
 -  Fix WMAB call in fan_mode_store()

----------------------------------------------------------------
Christoffer Sandberg (1):
      platform/x86/amd/pmc: Add Stellaris Slim Gen6 AMD to spurious 8042 quirks list

Daniel Lee (1):
      platform/x86: lg-laptop: Fix WMAB call in fan_mode_store()

Nickolay Goppen (1):
      platform/x86: dell-lis3lv02d: Add Latitude E6530

Shyam Sundar S K (1):
      platform/x86/dell: Set USTT mode according to BIOS after reboot

 Documentation/admin-guide/laptops/lg-laptop.rst |  4 +--
 drivers/platform/x86/amd/pmc/pmc-quirks.c       |  7 +++++
 drivers/platform/x86/dell/dell-lis3lv02d.c      |  1 +
 drivers/platform/x86/dell/dell-pc.c             |  9 +++++++
 drivers/platform/x86/lg-laptop.c                | 34 ++++++++++---------------
 5 files changed, 33 insertions(+), 22 deletions(-)

