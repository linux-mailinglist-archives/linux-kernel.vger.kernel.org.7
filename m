Return-Path: <linux-kernel+bounces-744027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642D8B1070F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F32564B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C0025743D;
	Thu, 24 Jul 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DupKGg5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A27255F26;
	Thu, 24 Jul 2025 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350886; cv=none; b=i4OU5dRMiCGCREkiH1FnAlAQEIL8/7BqgT15g+RR7OvjEVqMCrhbXiMRTftA6gqIfOFchuaw3TwYK1u+4FuFC/N/SBrlDTLSJg8FecdJaaTvgdVsAotdxdOUNAMoL3IhDJhqH3dL/4OvzdbO12F3oFVbzkB0t7OQVECPFApwYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350886; c=relaxed/simple;
	bh=ZZhIJ7ZsdoBem6Jh192Mxo9J74PphAeerlUBmWlzT+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nX7UoIyvxXuObAymdpHfA8ZpC5pWZn645rPIsEEFFxF5+sysDvNASJLIz8L40zsKP5hnJmMnJy269zWTG03iuxfqgaOEcH4uT8DVKbCben8Gi9aAmA4EqxMQWQfSEIF7w1gaTKoyk6O1uISuY1KG1xwwFaifgOlUG3VTlFof78w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DupKGg5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD360C4CEED;
	Thu, 24 Jul 2025 09:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753350885;
	bh=ZZhIJ7ZsdoBem6Jh192Mxo9J74PphAeerlUBmWlzT+s=;
	h=Date:From:To:Cc:Subject:From;
	b=DupKGg5hgnYKSrGiUWjC5IqXy09Egge2IetblRjV0rYvewcwtFJVkBB2cg1tJOgpN
	 CgZ7MGWopb+nnFhPBeLCwk7JZGGy4cJIrx1vFsGC523hqR4Ci5eviMg1Y2pfNDy7vG
	 ClpjaGN+h7h8aJTEEuLSBgWxJPusM84200GMwdcw3KZAsFXgCsCj9IHhbAGnzZ2v5R
	 y5ZfMvGQTkFrcZLILx4ZMBEImcmVwPcvqGiltYqGY+rREDlB2PsASDtQlSGA3YdD47
	 nOKOHRjhfP9+vdQejuz2GxsF72z/dxasUOG2vUWksXJBgJR/kmRwNwUvhORETnro6N
	 Xxg7VhM51T+tg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1ueseu-000000006hc-3lmg;
	Thu, 24 Jul 2025 11:54:40 +0200
Date: Thu, 24 Jul 2025 11:54:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB serial updates for 6.17-rc1
Message-ID: <aIIC4H7MzIlTH6IE@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.17-rc1

for you to fetch changes up to bdf2ab177e2fca85394fce86629f5e35aa7fa33a:

  USB: serial: cp210x: use new GPIO line value setter callbacks (2025-06-24 10:40:51 +0200)

----------------------------------------------------------------
USB serial updates for 6.17-rc1

Here are the USB serial updates for 6.17-rc1, including

 - switch to new gpiolib interface that can return errors

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Bartosz Golaszewski (2):
      USB: serial: ftdi_sio: use new GPIO line value setter callbacks
      USB: serial: cp210x: use new GPIO line value setter callbacks

 drivers/usb/serial/cp210x.c   | 10 ++++++----
 drivers/usb/serial/ftdi_sio.c | 18 ++++++++++++------
 2 files changed, 18 insertions(+), 10 deletions(-)

