Return-Path: <linux-kernel+bounces-815558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1242B56826
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C9218911EB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 11:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6E22475CF;
	Sun, 14 Sep 2025 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B6c33VgV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE721DE2B4;
	Sun, 14 Sep 2025 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757850891; cv=none; b=QW9FqlYhdRGJNs6+UQCQORwJd4uCSHqhIfMNvp11qHXnU7sGMHqBh5ARkP7FCQaVY9ybNx10CLJAO+5B8YlaGWCAOEDGtfuzHGP07+GTfxi6yL7E8/HPXaturZLdio5TyAKj8vCBcsAYAx0kPhuajlmshlMY1w283BC3c/XKM1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757850891; c=relaxed/simple;
	bh=GOXPOqzQuRntabt4eueE99lOc9bd94jNtNwxBGOe7dU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nbgOWhtoM3MMUGbHcyaHYX9q6d6Y6sIUAuzNQRmypRugyVjDYKwnrFek9nm6IsFt/eeiL6VSFPt+ZrNws3ZOasIT2M7+4Jdz5Sl3pSRXDib0pb70D1uHdXtTRtReAKqHiB+m95QtHo/YArvNpFpGwLKNo3kD0utzmH5cKd6T55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B6c33VgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C7AC4CEF0;
	Sun, 14 Sep 2025 11:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757850890;
	bh=GOXPOqzQuRntabt4eueE99lOc9bd94jNtNwxBGOe7dU=;
	h=Date:From:To:Cc:Subject:From;
	b=B6c33VgVq8Jbqo1guaWrHbfz4BvMQ99KuJ5f3u+q1M5GJgJb1wEsCuNkLFc6OIb6o
	 ituH6FoENfXifZw9C1PIXMXbOQARQbdDcdDKFyghMSgWsIlBOzeGKZbPE06t0ou42c
	 0HzPR/fudD51TULbmIS72/ovtQ729iF6ZxkhHvxg=
Date: Sun, 14 Sep 2025 13:54:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.17-rc6
Message-ID: <aMatBsRj8kbv4VoO@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.17-rc6

for you to fetch changes up to 9dfec4a51df9cf0dcc23cb4ac6fc314bf9e999d0:

  USB: core: remove the move buf action (2025-09-12 13:41:55 +0200)

----------------------------------------------------------------
USB fixes for 6.17-rc6

Here are some small USB driver fixes and new device ids for 6.17-rc6.
Included in here are:
  - new usb-serial driver device ids
  - dummy-hcd locking bugfix for rt-enabled systems (which is crazy, but
    people have odd testing requirements at times...)
  - xhci driver bugfixes for reported issues
  - typec driver bugfix
  - midi2 gadget driver bugfixes
  - usb core sysfs file regression fix from -rc1

All of these, except for the last usb sysfs file fix, have been in
linux-next with no reported issues.  The sysfs fix was added to the tree
on Friday, and is "obviously correct" and should not have any problems
either, it just didn't have any time for linux-next to pick up (0-day
had no problems with it.)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: gadget: dummy-hcd: Fix locking bug in RT-enabled kernels

Edward Adam Davis (1):
      USB: core: remove the move buf action

Fabio Porcedda (2):
      USB: serial: option: add Telit Cinterion FN990A w/audio compositions
      USB: serial: option: add Telit Cinterion LE910C4-WWX new compositions

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-6.17-rc6' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Mathias Nyman (3):
      xhci: dbc: decouple endpoint allocation from initialization
      xhci: dbc: Fix full DbC transfer ring after several reconnects
      xhci: fix memory leak regression when freeing xhci vdev devices depth first

RD Babiera (1):
      usb: typec: tcpm: properly deliver cable vdms to altmode drivers

Takashi Iwai (2):
      usb: gadget: midi2: Fix missing UMP group attributes initialization
      usb: gadget: midi2: Fix MIDI2 IN EP max packet size

 drivers/usb/core/driver.c             |  4 +-
 drivers/usb/gadget/function/f_midi2.c | 11 +++-
 drivers/usb/gadget/udc/dummy_hcd.c    |  8 +--
 drivers/usb/host/xhci-dbgcap.c        | 94 +++++++++++++++++++++++++----------
 drivers/usb/host/xhci-mem.c           |  2 +-
 drivers/usb/serial/option.c           | 17 +++++++
 drivers/usb/typec/tcpm/tcpm.c         | 12 +++--
 7 files changed, 108 insertions(+), 40 deletions(-)

