Return-Path: <linux-kernel+bounces-896742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33422C511A3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9282534B445
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023A22F3610;
	Wed, 12 Nov 2025 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDomxgu2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590202D8387;
	Wed, 12 Nov 2025 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936083; cv=none; b=dGK3NTDiw0TZdt15ookFPMLv2smL4fGZxzTo1jKlcV7VonHtJzBVjHwd05U4pIQHXj13Swfm+OaveKOnvDnpPUc7Cj2UzG2UYIlQFEkop2JOp0TxRAzL68spVddSh9KAAU6/yBUu8J608yQWg6DjMhMIZX9TOv3oEyPNPyzmr0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936083; c=relaxed/simple;
	bh=p4w+vM6/iOPDhOCp8mVBRwAOSAeG6yreM0uhSXh/QFU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KUbO/MAuPXNZ6VUAZRmnVgs98l8rYlr3eOS81I9d1EF5bq/hC7D4f5U7FojpgLPu93EEnYAC8FX+zwIzaFYEIxR1O/5a6wi3Jcl7isQxaCC7qiHdOqpcsQjOBl7DZS4innzqJ+WOZ/MiCziaGQKqhuvdVo4RtEbKpiH0cEPvftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDomxgu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B166C19424;
	Wed, 12 Nov 2025 08:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762936083;
	bh=p4w+vM6/iOPDhOCp8mVBRwAOSAeG6yreM0uhSXh/QFU=;
	h=Date:From:To:Cc:Subject:From;
	b=aDomxgu21p164qU7p2lqduN55NOjoFfKFYBW2Z0lv9jqX95WQgonDBMVdHK2Vi1Dj
	 lkmGr5fyFM2+AtGuh81pYQfP9gyLQ9YY5tMJbjJvaATos4qX1aD5fjGliajOMgv1j+
	 95ND5DAAF2YRQzhgBxQVfAq+R1JA8TwAaaG8j6GN1iJgkDMVKvyRasz3TACaAEU1id
	 1HA84zGHVbnD3PRU7GJSMtZkW6hp+gbzsHyJmRxdFMxkStaL4akYbpbpXS+1W4fbKN
	 Z99mS34UzUWHeyGC/FwxN/FnTPW7YK9oR7O7cFx4017iqAP4npoCm7WhnJZT2oxnAs
	 JYVtW5XiR3cPg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vJ6Cw-000000005pI-0b9j;
	Wed, 12 Nov 2025 09:28:02 +0100
Date: Wed, 12 Nov 2025 09:28:02 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB serial device ids for 6.18-rc6
Message-ID: <aRRFEgF2SJGb9uhe@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.18-rc6

for you to fetch changes up to 523bf0a59e674b52e4b5607a2aba655fbfa20ff2:

  USB: serial: option: add support for Rolling RW101R-GL (2025-11-10 12:33:36 +0100)

----------------------------------------------------------------
USB serial devices ids for 6.18-rc6

Here are some more modem and ftdi device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Oleksandr Suvorov (1):
      USB: serial: ftdi_sio: add support for u-blox EVK-M101

Vanillan Wang (1):
      USB: serial: option: add support for Rolling RW101R-GL

 drivers/usb/serial/ftdi_sio.c     |  1 +
 drivers/usb/serial/ftdi_sio_ids.h |  1 +
 drivers/usb/serial/option.c       | 10 ++++++++--
 3 files changed, 10 insertions(+), 2 deletions(-)

