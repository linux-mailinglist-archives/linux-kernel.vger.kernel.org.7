Return-Path: <linux-kernel+bounces-869914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B146C08FBC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0831B2507B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1972B2F83BC;
	Sat, 25 Oct 2025 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyvv87EK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7219D28DC4;
	Sat, 25 Oct 2025 11:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761393433; cv=none; b=Z8HhBdvQUSLf1OEvJdvacE479hgykuVolF32ynjO8r3Lx9DfMd97nDKnJEfkKZoddRdBa4ikA2kpBLZGg+euGxtVUKfW6g8fox9g/ojHgXwgR7e7NNZ4jygElMbpO+p6jeYt2ZQSaoSTkhYKAzq65CrKtMCxjimg2Fbz+2wB5X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761393433; c=relaxed/simple;
	bh=acZil86bgni5OvDHz+CEz39kC5OjvGokA4XlCwNJDIc=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:Mime-Version; b=iW2VjlOVls6GHpo8iqQjxuPZuUK9tiwaMjEaWohi8SCM56uFvfI7USvSroKQOkIRhy0/0QzP4VF2UW5+dY7B3cuGGUd8hNq38WLdj16Q6MsZXe3gPYLJcT6luzCRZOV/bC/yY+FXRYcnPjQ2KbjaivFUhj5F+xtkj0Ff/uloMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyvv87EK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD70FC4CEF5;
	Sat, 25 Oct 2025 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761393430;
	bh=acZil86bgni5OvDHz+CEz39kC5OjvGokA4XlCwNJDIc=;
	h=Date:Subject:Cc:To:From:From;
	b=dyvv87EKHMUO2NURgqvrgRK/rMahlZHJx+oLTQ8xjXEKGF40xWBZIwk4KujIPzoar
	 NETM9Lw4Oz+Gc5UerEv6vUrAmPh4XL9Ir5QKKXzXQ5VPyOwoFT6jv777cVsmhNzC/n
	 wBVDCehOqNfilD4I1xbjnCEtPZg3lShRwhBwK4ulPwQE1Ul3IMuy0KIdFm7NwXZRTB
	 JGJkQpJoTi9l4gmUCUgZwze4OUBWlGwX8UJrYuyxsj9w3JiUYxD0FY7HTZdbsSXtaS
	 EUbMw0KMcCNQ5bZA31xPGUrQaXCBHJS6n3oRFgZ+hU6OJJgy0G3h5wrHKkaJ0WPUdj
	 3lXEuRsUp6QEg==
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Oct 2025 13:57:06 +0200
Message-Id: <DDRDUX7T9JLZ.NO8N2TZOIWFO@kernel.org>
Subject: [GIT PULL] Driver core fixes for 6.18-rc3
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Saravana Kannan" <saravanak@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1

Hi Linus,

Please pull these driver-core fixes.

All commits have been in linux-next for a couple rounds; no conflicts expec=
ted.

- Danilo

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787=
:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git=
 tags/driver-core-6.18-rc3

for you to fetch changes up to 2eead19334516c8e9927c11b448fbe512b1f18a1:

  arch_topology: Fix incorrect error check in topology_parse_cpu_capacity()=
 (2025-10-22 08:06:28 +0200)

----------------------------------------------------------------
Driver core fixes for 6.18-rc3

  - In Device::parent(), do not make any assumptions on the device
    context of the parent device.

  - Check visibility before changing ownership of a sysfs attribute
    group.

  - In topology_parse_cpu_capacity(), replace an incorrect usage of
    PTR_ERR_OR_ZERO() with IS_ERR_OR_NULL().

  - In devcoredump, fix a circular locking dependency between
    struct devcd_entry::mutex and kernfs.

  - Do not warn about a pending fw_devlink sync state.

----------------------------------------------------------------
Danilo Krummrich (1):
      rust: device: fix device context of Device::parent()

Fernando Fernandez Mancera (1):
      sysfs: check visibility before changing group attribute ownership

Kaushlendra Kumar (1):
      arch_topology: Fix incorrect error check in topology_parse_cpu_capaci=
ty()

Maarten Lankhorst (1):
      devcoredump: Fix circular locking dependency with devcd->mutex.

Ulf Hansson (1):
      driver core: fw_devlink: Don't warn about sync_state() pending

 drivers/base/arch_topology.c |   2 +-
 drivers/base/core.c          |   2 +-
 drivers/base/devcoredump.c   | 136 +++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++++++++++++---------------------------------------=
---------
 fs/sysfs/group.c             |  26 +++++++++++++++++++-----
 rust/kernel/auxiliary.rs     |   8 +-------
 rust/kernel/device.rs        |   4 ++--
 6 files changed, 109 insertions(+), 69 deletions(-)

