Return-Path: <linux-kernel+bounces-826947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6907DB8FB42
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E6F18A012F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A15283C97;
	Mon, 22 Sep 2025 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGMt2wVD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04A224D6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758532296; cv=none; b=NpYuwj9BMvpnvwr/E91/0N9qkYa8oFcLQbQqJ9wlQetoiJnlG14AFVzoziTY7Ky7xAs19yS/cUTIbD8qR3mVmwJ0X6aWkUJtIqgHcnPbtq4wJX+Hg2I+0+Wm7tL/tUBBJWtuSebE0myurWctmR8EW2RHC3VhDV3NJUSJLZhl3b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758532296; c=relaxed/simple;
	bh=i1GGuij/9urYoNsBCRpJGaO3S3MaE1uGvq+3WQ8JQmc=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=KupfpIh1KZ8YxTJvromI+Xxag48bKVgYRpj06m2oW9hz5f15zWu0PFWJ4fEsmYl7UW5Jfea4zfdyCFYUyDt4HDIfqknyOTVdsbtws3S4I4jr788z0+0SZ6Dkr5UHovd4/FI4GbqQtpH5bPJQ4Oz3klBXMUfrsd0CZIfBnkUwMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGMt2wVD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0630C4CEF0;
	Mon, 22 Sep 2025 09:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758532296;
	bh=i1GGuij/9urYoNsBCRpJGaO3S3MaE1uGvq+3WQ8JQmc=;
	h=Date:From:To:cc:Subject:From;
	b=GGMt2wVDLPkDy08oTYCZ7kSbqjB1ssUXoQOP7CnZmwirgVUuzf1NgHEsCLf/iHq1d
	 sgYOOoaaQPzGK3B/qnviLvGrcPBurAASqNM6AugrykYi6uspJoUtL/bxhDhExG+XhT
	 AjWMTfnCI82DDSmGknk5j4UcHWXMIEAJNCtPk/oPfo893kWGZ2cL2ugDiPP+ABTBq1
	 UL+XDdVvn2lGH9HxqH5O3xP4inQK+1jcDlZVHJOw5LhjohE3McMQKgjYA0nNzFl4gP
	 jfM4a5HDGtuRYSi3JDGcJx1tHMXsZ7Uzsb0hRdo68PCmGSDwq3EYvqDYvpFGifC8qB
	 xV2kLGXmUWRFg==
Date: Mon, 22 Sep 2025 11:11:33 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes for 6.17-final
Message-ID: <7rq81spn-on10-rn3p-03so-825s85486ps1@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-li=
nus-2025092201

to receive fixes that should still land in 6.17-final. Namely:

=3D=3D=3D=3D=3D
- work data memory corruption fix in amd_sfh (Basavaraj Natikar)
- fix for regression in cp2112 where setting a GPIO value would always
  fail (S=E9bastien Szymanski)
- fix for regression in hid-lenovo causing driver to fail on non-ACPI
  systems (Janne Grunau)
- a couple device ID additions and tiny device-specific quirks
=3D=3D=3D=3D=3D

Thanks.

----------------------------------------------------------------
Amit Chaudhari (1):
      HID: asus: add support for missing PX series fn keys

Basavaraj Natikar (1):
      HID: amd_sfh: Add sync across amd sfh work functions

Janne Grunau (1):
      HID: lenovo: Use KEY_PERFORMANCE instead of ACPI's platform_profile

S=E9bastien Szymanski (1):
      HID: cp2112: fix setter callbacks return value

Xinpeng Sun (2):
      HID: intel-thc-hid: intel-quicki2c: Add WCL Device IDs
      HID: intel-thc-hid: intel-quickspi: Add WCL Device IDs

 drivers/hid/Kconfig                                     |  2 --
 drivers/hid/amd-sfh-hid/amd_sfh_client.c                | 12 ++++++++++--
 drivers/hid/amd-sfh-hid/amd_sfh_common.h                |  3 +++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c                  |  4 ++++
 drivers/hid/hid-asus.c                                  |  3 +++
 drivers/hid/hid-cp2112.c                                | 10 +++++-----
 drivers/hid/hid-lenovo.c                                |  4 +---
 drivers/hid/intel-thc-hid/intel-quicki2c/pci-quicki2c.c |  2 ++
 drivers/hid/intel-thc-hid/intel-quicki2c/quicki2c-dev.h |  2 ++
 drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c |  2 ++
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-dev.h |  2 ++
 11 files changed, 34 insertions(+), 12 deletions(-)

--=20
Jiri Kosina
SUSE Labs


