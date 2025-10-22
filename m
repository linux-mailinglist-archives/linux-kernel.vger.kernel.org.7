Return-Path: <linux-kernel+bounces-864782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EABBFB88D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E3D14F048E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE53328B50;
	Wed, 22 Oct 2025 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCjDfkdy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00619D074;
	Wed, 22 Oct 2025 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131112; cv=none; b=hDcIyfa8h0ClprzyVYKv/kHrwTDWKmlX57qzOCVV8igeOo8A2noTt8a45wPJHLXjQFfpKQ2cXPxMOMcc7p5e3NsBqkt2yzQ4kX2Jx+xvTlAgPoT0Iotv8GTz3PnhzoN0Ux3S4INWg4aWolO17I8ELoKkdZigQ/PGogBfUG8SRsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131112; c=relaxed/simple;
	bh=osJGDS37NazLmjN0e6+Zu9bkiQjkOAcBm/73aoNH/iA=;
	h=From:To:Cc:Date:Subject:Message-ID:MIME-Version:Content-Type; b=nSi2zuLjXbcEb9+cVNbpokg3Na73SANUVrw3DKoRLescixqxvQPOCRjg/kqepQmpekskX8t5iNH64nM2RNlItzIlCaz6WxPJ1BdvIzr3cIdhIe5/W7ht+k7BegOQuV8KPpZizSqmJ+c91TUw+MFV9VSQk+t3cdf4xg1ivg0gA9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCjDfkdy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761131111; x=1792667111;
  h=from:to:cc:date:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=osJGDS37NazLmjN0e6+Zu9bkiQjkOAcBm/73aoNH/iA=;
  b=hCjDfkdytGypOAeAx+aRdNmMteUPYI2qgLACeUqyphs56LDRqHLU9uZG
   BbxeOKzuys4L6D61+sAefUmZCuDo90H9p2J2F1Z6eRvi0AUV9x74qQNc2
   55VM4cH6qu7bw7FvHnqYnp9L47vouGBebb4dR259ciAOZnhMZiPT9m6nQ
   4LxX2kO7NOGT/D56PI+oUA9SpIGEMV+1WvV7V8cKazOdcD50Sx9R/LD6j
   0HGHomO1HH7E7bmLNcWknpIPcEvqoPOISaHcs5RgVFbFgKyRep9FZNB+8
   /P+G6zvNWAXkZqYcRQ5dGNq01q6CgnXFzJWtMrZs3p6/ExlKGLx6Vovg0
   g==;
X-CSE-ConnectionGUID: 3r8a6+afQnGx5UOJGOunSw==
X-CSE-MsgGUID: RdUgsiIOSkiAzo783yijVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73879463"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="73879463"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 04:05:09 -0700
X-CSE-ConnectionGUID: KbyYTW4fRwyWB2Ywo1bl4g==
X-CSE-MsgGUID: +HuE0kZFRdaeDr9iRCCCiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="183013092"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 04:05:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, Andy Shevchenko <andy@kernel.org>
Date: Wed, 22 Oct 2025 14:03:49 +0300
Subject: [GIT PULL] platform-drivers-x86 for v6.18-2
Message-ID: <pdx86-pr-20251022140349-2206824358@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Here is a platform-drivers-x86 fixes PR for v6.18.

Fixes and New HW Support

- alienware-wmi-wmax:

  - Fix NULL pointer dereference in sleep handlers

  - Add AWCC support to Dell G15 5530

- mellanox: mlxbf-pmc: add sysfs_attr_init() to count_clock init

Regards, i.


The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.18-2

for you to fetch changes up to 34cbd6e07fddf36e186c8bf26a456fb7f50af44e:

  platform/x86: alienware-wmi-wmax: Add AWCC support to Dell G15 5530 (2025-10-15 11:22:35 +0300)

----------------------------------------------------------------
platform-drivers-x86 for v6.18-2

Fixes and New HW Support

- alienware-wmi-wmax:

  - Fix NULL pointer dereference in sleep handlers

  - Add AWCC support to Dell G15 5530

- mellanox: mlxbf-pmc: add sysfs_attr_init() to count_clock init

The following is an automated shortlog grouped by driver:

alienware-wmi-wmax:
 -  Add AWCC support to Dell G15 5530
 -  Fix NULL pointer dereference in sleep handlers

MAINTAINERS:
 -  add Denis Benato as maintainer for asus notebooks

mlxbf-pmc:
 -  add sysfs_attr_init() to count_clock init

----------------------------------------------------------------
David Thompson (1):
      platform/mellanox: mlxbf-pmc: add sysfs_attr_init() to count_clock init

Denis Benato (1):
      MAINTAINERS: add Denis Benato as maintainer for asus notebooks

Kurt Borja (1):
      platform/x86: alienware-wmi-wmax: Fix NULL pointer dereference in sleep handlers

tr1x_em (1):
      platform/x86: alienware-wmi-wmax: Add AWCC support to Dell G15 5530

 MAINTAINERS                                    |  1 +
 drivers/platform/mellanox/mlxbf-pmc.c          |  1 +
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 12 ++++++++++--
 3 files changed, 12 insertions(+), 2 deletions(-)

