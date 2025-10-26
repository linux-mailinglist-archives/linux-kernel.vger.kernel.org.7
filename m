Return-Path: <linux-kernel+bounces-870383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F89AC0A8E7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B86053AFA80
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A8B374EA;
	Sun, 26 Oct 2025 14:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="btr2RxYq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D5E1459FA
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761487230; cv=none; b=OOZM6GqJk3/J6iaZFXVkwyfzAauCtXTrGVPPEq6M/Mt15kRCRgXFHA/KtOKJvEygHH89UwU81eKJDLqV6N32EzJBqz2qVKK676UfE+lXzcmOXRvY4I/WzVzU5mm5yK+q6jX3a92rREEP+dz7iCoxc8OVdVKHQe38JXQ1gr1w1+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761487230; c=relaxed/simple;
	bh=XWwuIny+o1PbQPUaDVKtGw8LIaEPzxLiV7P+oIQRcco=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z6lauV39wHGUjM6sBqLpVNuHQCOeMCAJVoKB5YadmTmtDD9vQFN7oxt9UXNYEPjx8ZI0BcI3D+rtg+3XOG+N9FQzLpm5YAryyJQBtdxL2Ph8Q/1xG2X2USJVLlDtKIu/G5GAD+9YiRuAlIZ2Qw7NH25OgAHNLTwQBvKrDI94J78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=btr2RxYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7391CC4CEE7;
	Sun, 26 Oct 2025 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761487229;
	bh=XWwuIny+o1PbQPUaDVKtGw8LIaEPzxLiV7P+oIQRcco=;
	h=Date:From:To:Cc:Subject:From;
	b=btr2RxYqjOqvujQYiKuWSGv1SDxQc2rQWNXpq+yiz47FHJhS1oMeGYv+9aMeJ1i1Y
	 fESgL6uOsihivxZkXPIKi35Ubcfdg/zrIgLxG2XTVI598gUlQXovfQftkO0ELKflrI
	 S9nbHrKywg46ZO+fR8W41gwUcD88CucT94Bzjn0w=
Date: Sun, 26 Oct 2025 15:00:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.18-rc3
Message-ID: <aP4pevpyQLbffmcy@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.18-rc3

for you to fetch changes up to a8cc9e5fcb0e2eef21513a4fec888f5712cb8162:

  most: usb: hdm_probe: Fix calling put_device() before device initialization (2025-10-22 08:04:43 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 6.18-rc3

Here are some small char/misc/android driver fixes for 6.18-rc3 for
reported issues.  Included in here are:
  - rust binder fixes for reported issues
  - mei device id addition
  - mei driver fixes
  - comedi bugfix
  - most usb driver bugfixes
  - fastrpc memory leak fix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (2):
      mei: me: add wildcat lake P DID
      mei: txe: fix initialization order

Alice Ryhl (5):
      rust_binder: remove warning about orphan mappings
      rust_binder: freeze_notif_done should resend if wrong state
      rust_binder: don't delete FreezeListener if there are pending duplicates
      rust_binder: report freeze notification only when fully frozen
      binder: remove "invalid inc weak" check

Cosmin Tanislav (1):
      nvmem: rcar-efuse: add missing MODULE_DEVICE_TABLE

Deepanshu Kartikey (1):
      comedi: fix divide-by-zero in comedi_buf_munge()

Jean Delvare (1):
      misc: amd-sbi: Clarify that this is a BMC driver

Junhao Xie (1):
      misc: fastrpc: Fix dma_buf object leak in fastrpc_map_lookup

Kriish Sharma (1):
      binder: Fix missing kernel-doc entries in binder.c

Miguel Ojeda (1):
      rust_binder: clean `clippy::mem_replace_with_default` warning

Nathan Chancellor (1):
      mei: late_bind: Fix -Wincompatible-function-pointer-types-strict

Victoria Votokina (2):
      most: usb: Fix use-after-free in hdm_disconnect
      most: usb: hdm_probe: Fix calling put_device() before device initialization

 drivers/android/binder.c              | 38 +++++++++++---------------
 drivers/android/binder/freeze.rs      | 18 ++++++++++---
 drivers/android/binder/node.rs        |  2 +-
 drivers/android/binder/process.rs     | 50 ++++++++++++++++++++++++++---------
 drivers/android/binder/transaction.rs |  6 ++---
 drivers/comedi/comedi_buf.c           |  2 +-
 drivers/misc/amd-sbi/Kconfig          |  2 ++
 drivers/misc/fastrpc.c                |  2 ++
 drivers/misc/mei/hw-me-regs.h         |  2 ++
 drivers/misc/mei/mei_lb.c             |  3 +--
 drivers/misc/mei/pci-me.c             |  2 ++
 drivers/misc/mei/pci-txe.c            | 14 +++++-----
 drivers/most/most_usb.c               | 13 ++++-----
 drivers/nvmem/rcar-efuse.c            |  1 +
 14 files changed, 93 insertions(+), 62 deletions(-)

