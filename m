Return-Path: <linux-kernel+bounces-791894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC5DB3BD77
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9E93B5305
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9286132039E;
	Fri, 29 Aug 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSRHW+7H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFC9265CC0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477516; cv=none; b=B3tEIZCY+2M/ijQG4DJIV70dtVYXLWTtanbZRC+nZSME0W9F3OxKmrBHdAXKas3hFjjgRcyyzIn1zqDYAdm3JxNYnLKUsRP0oTF7UzPlKCRugxty0cQ37XbOpmwBHCCu5GAaBPsCi7ATEDMV6pE6KXX8akVj37Ws6ShWoa48QQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477516; c=relaxed/simple;
	bh=BqY4M2o9Y9cXb4ci9/pTd3V/rMgYzjSmYJsvQAtp+co=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=XKbKeLfjQgf6rsu+bwfpV3MnVzB/9LQgw4M5sFJXieF2YsLtavVypaE85aqBuS8rAuMpGZ2/PYml9K0UvzJCP5Y0gnGXRpSgbOGHYQ4dBOujUuhmIY4m6AmigsUCcKOw9K5U5V9Sb3IQqpXJHLoWUtDcyhHEq/32cL403e6up/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSRHW+7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F6EC4CEF0;
	Fri, 29 Aug 2025 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756477514;
	bh=BqY4M2o9Y9cXb4ci9/pTd3V/rMgYzjSmYJsvQAtp+co=;
	h=Date:From:To:cc:Subject:From;
	b=dSRHW+7HuzCJtSljHD6iTQhCGL0tJVIiOMAFzXPRK2bJEGHnRM5FReXJdinDbpZtT
	 PmhrJTtdF0FqaTQVrP6A2QHKCTy7/6mxZOlgqMgkKMoPPRdqsHNpClTH8kUswl+JA9
	 3GDm2Ntvd8PGYpqFJ/DURlheKPUWaclWz/OxGuGUUiji76s0QjiVUO8L69a6AY5mHn
	 sfFEuB8GiefH51WYYNlVb4Hnq97aQmNUr+uh4UAT3aQ784+K95sZH8xq/PxPQOBObx
	 1YOOO9bWlRpvrWg5HPYBFaqhr5S8X2d8FxjU/MDbQRotklukMHHW2TFy5bwJ1Fsz1Z
	 Bm2WIIHCAtdPA==
Date: Fri, 29 Aug 2025 16:25:11 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: [GIT PULL] HID fixes for 6.17
Message-ID: <2qs0qn4n-2n38-44r2-r9s2-53o18o975s05@xreary.bet>
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
nus-2025082901

to receive HID fixes for 6.17, namely:

=3D=3D=3D=3D=3D
- fixes for memory corruption in intel-thc-hid, hid-multitouch,=20
  hid-mcp2221 and hid-asus (Aaron Ma, Qasim Ijaz, Arnaud=20
  Lecomte)
- power management/resume fix for intel-ish-hid (Zhang Lixu)
- driver reinitialization fix for intel-thc-hid (Even Xu)
- ensure that battery level status is reported as soon as possible,
  which is required at least for some Android use-cases (Jos=E9 Exp=F3sito)
- quite a few new device ID additions and device-specific quirks
=3D=3D=3D=3D=3D

Thanks.

----------------------------------------------------------------
Aaron Ma (2):
      HID: intel-thc-hid: intel-quicki2c: Fix ACPI dsd ICRS/ISUB length
      HID: intel-thc-hid: intel-thc: Fix incorrect pointer arithmetic in I2=
C regs save

Antheas Kapenekakis (1):
      HID: quirks: add support for Legion Go dual dinput modes

Arnaud Lecomte (1):
      hid: fix I2C read buffer overflow in raw_event() for mcp2221

Colin Ian King (1):
      HID: Kconfig: Fix spelling mistake "enthropy" -> "entropy"

Even Xu (1):
      HID: intel-thc-hid: Intel-quicki2c: Enhance driver re-install flow

Jos=E9 Exp=F3sito (2):
      HID: input: rename hidinput_set_battery_charge_status()
      HID: input: report battery status changes immediately

Martin Hilgendorf (1):
      HID: elecom: add support for ELECOM M-DT2DRBK

Matt Coffin (1):
      HID: logitech: Add ids for G PRO 2 LIGHTSPEED

Minjong Kim (1):
      HID: hid-ntrig: fix unable to handle page fault in ntrig_report_versi=
on()

Ping Cheng (1):
      HID: wacom: Add a new Art Pen 2

Qasim Ijaz (2):
      HID: multitouch: fix slab out-of-bounds access in mt_report_fixup()
      HID: asus: fix UAF via HID_CLAIMED_INPUT validation

Zhang Lixu (1):
      HID: intel-ish-hid: Increase ISHTP resume ack timeout to 300ms

 drivers/hid/Kconfig                                |  2 +-
 drivers/hid/hid-asus.c                             |  8 +++-
 drivers/hid/hid-elecom.c                           |  2 +
 drivers/hid/hid-ids.h                              |  4 ++
 drivers/hid/hid-input-test.c                       | 10 ++---
 drivers/hid/hid-input.c                            | 51 ++++++++++--------=
----
 drivers/hid/hid-logitech-dj.c                      |  4 ++
 drivers/hid/hid-logitech-hidpp.c                   |  2 +
 drivers/hid/hid-mcp2221.c                          |  4 ++
 drivers/hid/hid-multitouch.c                       |  8 ++++
 drivers/hid/hid-ntrig.c                            |  3 ++
 drivers/hid/hid-quirks.c                           |  3 ++
 drivers/hid/intel-ish-hid/ipc/pci-ish.c            |  3 --
 drivers/hid/intel-ish-hid/ishtp-hid-client.c       |  3 ++
 drivers/hid/intel-ish-hid/ishtp/bus.c              |  3 --
 drivers/hid/intel-ish-hid/ishtp/ishtp-dev.h        |  3 ++
 .../intel-thc-hid/intel-quicki2c/pci-quicki2c.c    |  1 +
 .../intel-thc-hid/intel-quicki2c/quicki2c-dev.h    |  2 +
 .../hid/intel-thc-hid/intel-thc/intel-thc-dev.c    |  4 +-
 drivers/hid/wacom_wac.c                            |  1 +
 20 files changed, 79 insertions(+), 42 deletions(-)

--=20
Jiri Kosina
SUSE Labs


