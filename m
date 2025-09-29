Return-Path: <linux-kernel+bounces-835666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D4CBA7BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 03:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D091C026B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 01:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351501F463C;
	Mon, 29 Sep 2025 01:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNS/+3F7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875ED1ADC97;
	Mon, 29 Sep 2025 01:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759108100; cv=none; b=jy/fsSd68MUFUz0tzc8bPuInIOHu4No3zQG9UrxqZnMTO9AW+zc+r62acRweVxVWk/J4u34bS/MQSXNVSMoyAsyz1M7ohUyrfAFMnf5jweYMaoahGMbANYNe/NJb2ccGETCWCxF9VeilORSM43vAC8ouXoN7rrd6+u8ooVQHLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759108100; c=relaxed/simple;
	bh=OplhVpW65M19DMrYdy83m8N0SjxruXiBU3gPyP3F4SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VDfUwL69r+BUUODVhll9XdU1EXH/Fit1ij4795Ff7FCzeTV1f+BwzZSwKBfhsvDl5iWdtF0tuF4xy8X7scknLMjP+g3o76Mu/mCTW/jfH7SKQmXyGR/4B8dZ62IFAjMCBffio11Y8dBkN3HzEN0hiHOblQ0yJbSmA2Xm/bUjDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNS/+3F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03D1C2BCB9;
	Mon, 29 Sep 2025 01:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759108100;
	bh=OplhVpW65M19DMrYdy83m8N0SjxruXiBU3gPyP3F4SQ=;
	h=Date:From:To:Cc:Subject:From;
	b=NNS/+3F71M9ufV/8WRXxibeNOTOczc/9LKlzaFqn4pLuqeix+TAOqICOsvz4MTjuF
	 TvAPo5aVJShgFj5Nvhgmi5xwNWpjulu1K4X9if98U8zeAeMW9zuL3sX5pI8cQ+MvmN
	 NBFmb/mdaDsf3vYMoNUuzgZEpjBDzDm2ligtvmZP5F8aYPZemDhtFI0rAyyppV7wKp
	 sJ+JtffYcoyimFpSFKSfpFWjMmP+9PxdOvoiJFixczRifJsUkqg00rAGhVLPRotYFv
	 JQ8zv2YXjT1tpaof1rD6vhoUtSI6FPThXeGuwHRLDPd9m97OuafgjMC7EJ/vXTFQyO
	 npV+RkzhuyF7w==
Date: Mon, 29 Sep 2025 09:08:16 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: torvalds@linux-foundation.org
Cc: bleung@chromium.org, chrome-platform@lists.linux.dev,
	tzungbi@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform updates for v6.18
Message-ID: <aNncAJHyW430v7ny@tzungbi-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HvQvYKpSdWsvPskZ"
Content-Disposition: inline


--HvQvYKpSdWsvPskZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull chrome-platform updates for Linux v6.18.

Thanks,
Tzung-Bi
------

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/chrome-platform-v6.18

for you to fetch changes up to 48633acccf38d706d7b368400647bb9db9caf1ae:

  Input: cros_ec_keyb - Defer probe until parent EC device is registered (2025-09-14 11:34:41 +0800)

----------------------------------------------------------------
chrome-platform: Updates for v6.18

* New

  - Add a new API cros_ec_device_registered() for checking if the
    cros_ec_deivce is ready.

* Improvements

  - Use TRAILING_OVERLAP() to fix -Wflex-array-member-not-at-end
    warning.
  - Defer probe until parent EC device is ready in cros_ec_keyb.

* Cleanups

  - Remove redundant and simplify code in cros_ec_chardev.
  - Centralize cros_ec_device allocation and initialization to remove
    duplicate code.

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      platform/chrome: cros_ec: Avoid -Wflex-array-member-not-at-end warning

Liao Yuanhong (1):
      platform/chrome: wilco_ec: Remove redundant semicolons

Tzung-Bi Shih (7):
      platform/chrome: cros_ec_chardev: Remove redundant struct field
      platform/chrome: cros_ec_chardev: Decouple fops from struct cros_ec_dev
      platform/chrome: Centralize cros_ec_device allocation
      platform/chrome: Centralize common cros_ec_device initialization
      platform/chrome: cros_ec: Separate initialization from cros_ec_register()
      platform/chrome: cros_ec: Add a flag to track registration state
      Input: cros_ec_keyb - Defer probe until parent EC device is registered

 drivers/input/keyboard/cros_ec_keyb.c        |  6 ++
 drivers/platform/chrome/cros_ec.c            | 90 ++++++++++++++++++----------
 drivers/platform/chrome/cros_ec.h            |  3 +
 drivers/platform/chrome/cros_ec_chardev.c    | 72 ++++++++++------------
 drivers/platform/chrome/cros_ec_i2c.c        |  9 +--
 drivers/platform/chrome/cros_ec_ishtp.c      |  6 +-
 drivers/platform/chrome/cros_ec_lpc.c        |  6 +-
 drivers/platform/chrome/cros_ec_proto.c      | 15 +++++
 drivers/platform/chrome/cros_ec_rpmsg.c      |  6 +-
 drivers/platform/chrome/cros_ec_spi.c        |  7 +--
 drivers/platform/chrome/cros_ec_uart.c       |  6 +-
 drivers/platform/chrome/wilco_ec/telemetry.c |  2 +-
 include/linux/platform_data/cros_ec_proto.h  | 18 ++++--
 13 files changed, 139 insertions(+), 107 deletions(-)

--HvQvYKpSdWsvPskZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCaNnb/AAKCRArxTEGBto8
9LxnAQDsz39osPH84YTb6kowLnpu00nUeq605GARVeO0oJTJ/AEA7/1hX07gp91Y
xVuxx883MDgkT4jy0zXpyQIGY5XEvgw=
=1+2w
-----END PGP SIGNATURE-----

--HvQvYKpSdWsvPskZ--

