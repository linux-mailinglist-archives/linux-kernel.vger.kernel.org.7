Return-Path: <linux-kernel+bounces-731414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0172B053EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 449523BE196
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBFD273D68;
	Tue, 15 Jul 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laY4PYTe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260564A00;
	Tue, 15 Jul 2025 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566418; cv=none; b=K6dImEAXJR36VR5LNNlDrKNsBFE3ACsfofhQFhiHMJCxqU4LW/jQDOSIOSoaLZ9VnIjWWmu+guGTHKjcQWARBOY/lL/jQVTgH4nC9jlyemdWfpvttnOcVtxM89T00E9X9sSD1zBn5I8GQGtve7+O2n7jNa3BCxmb9LdK94+bPYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566418; c=relaxed/simple;
	bh=RLjur4skiASgwOb2qC0SaNvYhSIRjuqnLKJWZPuBP8M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HDBL0zUXLC/eMIRNvYsb79I6Rs5llxi9VbwdLrAHbZGZDKTR0Cj7hFBBkyIic43AGujYMsiZl36OiYNS2QxyFMLxmlzcunag1NB7CwOiF8owCsVUKuf7bo5rBlsUMJmdgSDxKlIPH97UFOPEHy8CgzrEzrg+lUSW4i8ZQPKMXJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laY4PYTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C960C4CEF5;
	Tue, 15 Jul 2025 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752566417;
	bh=RLjur4skiASgwOb2qC0SaNvYhSIRjuqnLKJWZPuBP8M=;
	h=Date:From:To:Cc:Subject:From;
	b=laY4PYTeYnq4MbnqKmLC/9lfXA7zQcJT+PptBGLtNlpp3riRSTgG+rWdRVasAfHjl
	 KRZzc4RGRor4RWvaG7xrD0lOZF9T6ORv4xremde+wtRhHKpcRouBqAGs3cQdytbwHE
	 WPXd8Vl0/nDeAN+cmwVvxl8dLOyfPTxVzxYcTj2zMXkUHTDIXW+C2z0NeJmUWj3zpF
	 o1YGD0+/iUP8V+dcfj0ieeXG9zYAYc8FpiC7SH8ZwOTbm6c/CiE88HMazxTai89Zc6
	 B3p/oZupA0zIwFHrS7T7NSZHUgb6v9tXLTHgtXDrhziHBL1RAultl5QYURKkNrmOvv
	 0VvCWlcujmUMA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ubaaD-000000003i1-1Jx3;
	Tue, 15 Jul 2025 10:00:13 +0200
Date: Tue, 15 Jul 2025 10:00:13 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB serial device ids for 6.16-rc7
Message-ID: <aHYKjbdJJiTLzHSu@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 08f49cdb71f3759368fded4dbc9dde35a404ec2b:

  USB: serial: option: add Foxconn T99W640 (2025-06-24 10:45:43 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.16-rc7

for you to fetch changes up to 252f4ac08cd2f16ecd20e4c5e41ac2a17dd86942:

  USB: serial: option: add Telit Cinterion FE910C04 (ECM) composition (2025-07-10 16:13:51 +0200)

----------------------------------------------------------------
USB serial device ids for 6.16-rc7

Here are some more device ids for 6.16-rc7.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Fabio Porcedda (1):
      USB: serial: option: add Telit Cinterion FE910C04 (ECM) composition

Ryan Mann (NDI) (1):
      USB: serial: ftdi_sio: add support for NDI EMGUIDE GEMINI

 drivers/usb/serial/ftdi_sio.c     | 2 ++
 drivers/usb/serial/ftdi_sio_ids.h | 3 +++
 drivers/usb/serial/option.c       | 3 +++
 3 files changed, 8 insertions(+)

