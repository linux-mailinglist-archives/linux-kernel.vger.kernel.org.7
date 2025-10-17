Return-Path: <linux-kernel+bounces-858330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA3DBEA428
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E477C23FA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA83F336EE2;
	Fri, 17 Oct 2025 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UhMnnZBA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185752F12C2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715492; cv=none; b=MJ+vuzZV6La6A5p0PGLgZNO2m9a+3TrEEXFk7nssIiYIYP9j+23VBrQGH//VRfPQkY7Pg4qydFD/JtR/44/zraaI9DhAqW47Zgxk66sQnnSt6NSSZ8vzKk4b+QjX0I7EA0I/hkFmfVxdxqfyz0BUccRSZLe8JT/SyXYsB2QBGS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715492; c=relaxed/simple;
	bh=HmJ5sLRF0ITiH4IIMbjAK8f8ZeHXbyY5BOXzEkq9rcc=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=mM6OlokNmdK4hiTPz3JxdqbAOhXE0gDJjQRxR7aaxa+pzKOZ76HP7vD0DdCANeMAvWCbJUKG5K297dRQ4VC3v4DXPgm7Od6Lfhro6OYnTD3rUe7BUQM5UhIQgepb0kvXhfqV/zdlTzUXnauvJJDlTCYCq5zsZ1VEbTau6MEs9TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UhMnnZBA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78449C4CEE7;
	Fri, 17 Oct 2025 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760715491;
	bh=HmJ5sLRF0ITiH4IIMbjAK8f8ZeHXbyY5BOXzEkq9rcc=;
	h=Date:From:To:cc:Subject:From;
	b=UhMnnZBA5zJnnSCXY1QTzL4TVFKLkUFNQ5pw1UcVMhQZlozJBpmSwL1/Ogak44PRC
	 OhmTbSuHpXBULzWsQKeM4F525Taqvmmh2HLGI6iJQC3/BxW/ZOY0EWkVeU1mkE2j4D
	 KHX+j8TfpT0iLxKj2Za8SS8DGiULvZ3z0CjIRj3m1mf6CA7iZmJI5ZMkQL5SL3iqfy
	 AC2pklk7g6EBaw+b0+6r8cuXuG1O0h8BW/N04b4cg0MwVUb8L3fVpb3nK7wbKc8zC6
	 XPBW9Ci44MQ8K9frNHfZuu/+4Vp41I1OwhK+I9Cxhrnm121a2EHxS7r+2ct442r648
	 RYvxiCbgxLneg==
Date: Fri, 17 Oct 2025 17:38:09 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes for 6.18
Message-ID: <q5p7s5oo-ps69-7659-69nn-48685q1694no@xreary.bet>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2025101701

to receive HID fixes for 6.18, namely:

=====
- fix for sticky fingers handling in hid-multitouch (Benjamin Tissoires)
- fix for reporting of 0 battery levels (Dmitry Torokhov)
- build fix for hid-haptic in certain configurations (Jonathan Denose)
- improved probe and avoiding spamming kernel log by hid-nintendo (Vicki 
  Pfau)
- fix for OOB in hid-cp2112 (Deepak Sharma)
- interrupt handling fix for intel-thc-hid (Even Xu)
- a couple of new device IDs and device-specific quirks
=====

Thanks!

----------------------------------------------------------------
Abhishek Tamboli (1):
      HID: intel-thc-hid: intel-quickspi: Add ARL PCI Device Id's

Benjamin Tissoires (2):
      HID: multitouch: fix sticky fingers
      selftests/hid: add tests for missing release on the Dell Synaptics

Colin Ian King (1):
      HID: hid-debug: Fix spelling mistake "Rechargable" -> "Rechargeable"

Deepak Sharma (1):
      HID: cp2112: Add parameter validation to data length

Dmitry Torokhov (1):
      HID: hid-input: only ignore 0 battery events for digitizers

Even Xu (1):
      HID: intel-thc-hid: Intel-quickspi: switch first interrupt from level to edge detection

Jonathan Denose (1):
      HID: Kconfig: Fix build error from CONFIG_HID_HAPTIC

Oleg Makarenko (1):
      HID: quirks: Add ALWAYS_POLL quirk for VRS R295 steering wheel

Stuart Hayhurst (1):
      HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL

Thadeu Lima de Souza Cascardo (1):
      HID: multitouch: fix name of Stylus input devices

Tristan Lobb (1):
      HID: quirks: avoid Cooler Master MM712 dongle wakeup bug

Vicki Pfau (3):
      HID: core: Add printk_ratelimited variants to hid_warn() etc
      HID: nintendo: Wait longer for initial probe
      HID: nintendo: Rate limit IMU compensation message

Xinpeng Sun (1):
      HID: intel-thc-hid: intel-quicki2c: Fix wrong type casting

 drivers/hid/Kconfig                                |  2 +-
 drivers/hid/hid-cp2112.c                           | 27 +++++++++--
 drivers/hid/hid-debug.c                            |  2 +-
 drivers/hid/hid-ids.h                              |  4 ++
 drivers/hid/hid-input.c                            |  5 +-
 drivers/hid/hid-logitech-hidpp.c                   | 21 +++++++++
 drivers/hid/hid-multitouch.c                       | 28 ++++++-----
 drivers/hid/hid-nintendo.c                         |  6 +--
 drivers/hid/hid-quirks.c                           |  2 +
 .../intel-thc-hid/intel-quicki2c/pci-quicki2c.c    |  2 +-
 .../intel-thc-hid/intel-quickspi/pci-quickspi.c    |  6 +++
 .../intel-thc-hid/intel-quickspi/quickspi-dev.h    |  2 +
 .../intel-quickspi/quickspi-protocol.c             |  3 +-
 include/linux/hid.h                                | 11 +++++
 .../testing/selftests/hid/tests/test_multitouch.py | 55 ++++++++++++++++++++++
 15 files changed, 151 insertions(+), 25 deletions(-)

-- 
Jiri Kosina
SUSE Labs


