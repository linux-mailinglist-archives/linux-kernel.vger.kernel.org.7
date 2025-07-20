Return-Path: <linux-kernel+bounces-738138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA703B0B4F3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C673A42BB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 10:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C971F3D56;
	Sun, 20 Jul 2025 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ekHW1zza"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB93112B94;
	Sun, 20 Jul 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753008357; cv=none; b=PGS059NHmZQsszp4chy8xBkcwo1CxwgTZvwAkTGbouqPuk7/VYqtISRj6JcuvegXJE6ntTBVIqFHILJnLa463lkOCtQg0az8dRzCdJUdylufwYkwuSEhNVYejQAqpT4CfKnfLmWfW0HVPUkbSm7V5sP/1pfItq4tkqB8ApoigIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753008357; c=relaxed/simple;
	bh=dLL3Ct79ZwbOQY8wCvPsyu+8Ih48jemDRpOVxJvo+gw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=knA3RIbDPtiIz3KvBJzO3/cg1Db5LexsfHuaIO/UDTR+oEHaoFzgqplSp8YAbtgc0cpOXcaEJWL5tFmGLdz42AdmGe66G3X1lXfrkhroSq1AAql/0Ogj6Fz5p+j9uTJvXuJPcbsqnD2bchsbbK3ykYFXVH4UGw2JyrD5mnwZ50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ekHW1zza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D214C4CEE7;
	Sun, 20 Jul 2025 10:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753008356;
	bh=dLL3Ct79ZwbOQY8wCvPsyu+8Ih48jemDRpOVxJvo+gw=;
	h=Date:From:To:Cc:Subject:From;
	b=ekHW1zza/aPFalicZszZfoaJb/ftFVq8OboUhuViOSLPz/nFobexSBxELDbHpBYGm
	 qoXCqIo2GkSbr463SGyLoRqchFYkOb3mrbhW4g+HjHje3OgY8g4FA0s16agtKpAJd/
	 xMJnKsyqqCwkeTqxK+Ih8kkWAcY37SH+RD3Co56Y=
Date: Sun, 20 Jul 2025 12:45:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver fixes for 6.16-rc6
Message-ID: <aHzI4aFr-UNU6dZX@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 3c2bd251d2039ce2778c35ced5ef47b3a379f5df:

  Merge tag 'usb-6.16-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2025-07-04 09:57:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.16-rc6

for you to fetch changes up to 2521106fc732b0b75fd3555c689b1ed1d29d273c:

  usb: hub: Don't try to recover devices lost during warm reset. (2025-07-16 09:48:11 +0200)

----------------------------------------------------------------
USB / Thunderbolt fixes for 6.16-rc6

Here are some USB and Thunderbolt driver fixes for reported problems for
6.16-rc6.  Included in here are:
  - Thunderbolt fixes for some much-reported issues
  - dwc2 driver fixes
  - dwc3 driver fixes
  - new usb-serial driver device ids
  - gadgetfs configfs fix
  - musb driver fix
  - USB hub driver fix

All of these have been in linux-next for a while with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alok Tiwari (1):
      thunderbolt: Fix bit masking in tb_dp_port_set_hops()

Drew Hamilton (1):
      usb: musb: fix gadget state on disconnect

Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FE910C04 (ECM) composition

Greg Kroah-Hartman (3):
      Merge tag 'thunderbolt-for-v6.16-rc4' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus
      Merge tag 'usb-serial-6.16-rc6' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus
      Merge tag 'usb-serial-6.16-rc7' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Krishna Kurapati (1):
      usb: dwc3: qcom: Don't leave BCR asserted

Mario Limonciello (1):
      thunderbolt: Fix wake on connect at runtime

Mathias Nyman (1):
      usb: hub: Don't try to recover devices lost during warm reset.

Minas Harutyunyan (1):
      usb: dwc2: gadget: Fix enter to hibernation for UTMI+ PHY

Ryan Mann (NDI) (1):
      USB: serial: ftdi_sio: add support for NDI EMGUIDE GEMINI

Slark Xiao (1):
      USB: serial: option: add Foxconn T99W640

Xinyu Liu (1):
      usb: gadget: configfs: Fix OOB read on empty string write

 drivers/thunderbolt/switch.c      | 10 +++++-----
 drivers/thunderbolt/tb.h          |  2 +-
 drivers/thunderbolt/usb4.c        | 12 +++++-------
 drivers/usb/core/hub.c            |  8 ++++++--
 drivers/usb/dwc2/gadget.c         | 40 ++++++++++++++++++++++++++-------------
 drivers/usb/dwc3/dwc3-qcom.c      |  7 ++-----
 drivers/usb/gadget/configfs.c     |  4 ++++
 drivers/usb/musb/musb_gadget.c    |  2 ++
 drivers/usb/serial/ftdi_sio.c     |  2 ++
 drivers/usb/serial/ftdi_sio_ids.h |  3 +++
 drivers/usb/serial/option.c       |  5 +++++
 11 files changed, 62 insertions(+), 33 deletions(-)

