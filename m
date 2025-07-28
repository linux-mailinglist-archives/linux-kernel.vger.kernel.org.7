Return-Path: <linux-kernel+bounces-747533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33827B134DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD9917623E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556D522126A;
	Mon, 28 Jul 2025 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxTTLKKQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23DF214A6A;
	Mon, 28 Jul 2025 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683795; cv=none; b=PwVncVc8VNUcpZj0cKpoAg1MwVlkPZmyb8XtUnfURhxQxb2CHBtZyNXYKPybqsedmakTlCc8jXHFWzhy+hcImO4jT8DYTcxxI9j2BhXzPMZoyaLWynA+wsfWMt+WrMEQcTVeeRrL0xgUk9gQY5ckuJ41G3FKWrZyG6dVfnQ1tJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683795; c=relaxed/simple;
	bh=cP46XAmghO2hVB/W9Q6cuCXMalDEbQpa8/GY/cD7XYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BdqJsqbQPcqbxRH+/VnsLZlwlgcN1xJbnWu18CRu994zjicqnz5L9dg8RLIUDjagcaXgOwJADUjrcRtUxPCj+F9VTBlGH9WC2nTlZv3BPN9AckYpnN7eLLHPH64GLZz51T4BAWzidubRmMxedJCiXgrAIr2+0b3hnCL3hTTbNd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxTTLKKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64ED7C4CEE7;
	Mon, 28 Jul 2025 06:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753683795;
	bh=cP46XAmghO2hVB/W9Q6cuCXMalDEbQpa8/GY/cD7XYE=;
	h=Date:From:To:Cc:Subject:From;
	b=BxTTLKKQ9UUlRwJ10wL3TECCoauIxh4Px7Av1v4IALZNSPeHFmyZkAq82kuuvB/Rc
	 n7er1WXydPmv17rbcbYadeorqrid0MukWDcN5Gjn/nT4ybERvDymUQo2TSJJ3dExfb
	 qtOb+WNv1WU7N9Nlq9mxzT3fKR5c9rZyz/E6XP7Ns/Lly6fTeIUOfcOTnG3gvGoF2u
	 aQ9vkt0498egL4SIhotSr+m8UyNmI/edMJmjRvJ1fBvxylef1ULHfTlEDxYry8SrGe
	 p0shGCxJ92xmWWEjr1dO+MM532ZokEfuVPhI7wyfq1/1Pdam5NlENDbJ9QeMDBmO8g
	 HNe8b+Ggm7Gyg==
Date: Mon, 28 Jul 2025 06:23:12 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: bleung@chromium.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, tzungbi@kernel.org
Subject: [GIT PULL] chrome-platform updates for v6.17
Message-ID: <aIcXUHHgC8bm9tIn@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull chrome-platform updates for Linux v6.17.

Thanks,
Tzung-Bi
------

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-v6.17

for you to fetch changes up to cc2d5b72b13b3af2b9b4bed3d5dfd0de14414230:

  platform/chrome: Fix typo in CROS_USBPD_NOTIFY help text (2025-07-23 23:09:44 +0000)

----------------------------------------------------------------
chrome-platform: Updates for v6.17

* New

  - Support ECC in chromeos_pstore.
  - Allow to control power and data role via sysfs in cros_ec_typec.

* Improvements

  - Defer probe when the dependencies are not ready in cros_ec_typec.
  - Retry when a sensor is not ready in cros_ec_sensorhub.

* Fixes

  - Unregister the blocking notifier as well when unregistering the
    struct cros_ec_device.

* Cleanups

  - Remove redundant code and leverage more suitable helper macro in
    chromeos_laptop.
  - Fix typo.

----------------------------------------------------------------
Abhishek Pandit-Subedi (1):
      platform/chrome: cros_ec_typec: Add role swap ops

Andy Shevchenko (2):
      platform/chrome: chromeos_laptop: Remove duplicate check
      platform/chrome: chromeos_laptop: Replace open coded variant of DEFINE_RES_IRQ()

Gwendal Grignou (1):
      platform/chrome: cros_ec_sensorhub: Retries when a sensor is not ready

Keenan Salandy (1):
      platform/chrome: Fix typo in CROS_USBPD_NOTIFY help text

Naoya Tezuka (1):
      platform/chrome: chromeos_pstore: Add ecc_size module parameter

Tomasz Michalec (2):
      platform/chrome: cros_ec_typec: Defer probe on missing EC parent
      platform/chrome: cros_ec_typec: Check ec platform device pointer

Tzung-Bi Shih (1):
      platform/chrome: cros_ec: Unregister notifier in cros_ec_unregister()

 drivers/platform/chrome/Kconfig             |  2 +-
 drivers/platform/chrome/chromeos_laptop.c   |  9 ++-
 drivers/platform/chrome/chromeos_pstore.c   |  7 +++
 drivers/platform/chrome/cros_ec.c           |  3 +
 drivers/platform/chrome/cros_ec_sensorhub.c | 23 ++++++--
 drivers/platform/chrome/cros_ec_typec.c     | 91 +++++++++++++++++++++++++++--
 6 files changed, 121 insertions(+), 14 deletions(-)

