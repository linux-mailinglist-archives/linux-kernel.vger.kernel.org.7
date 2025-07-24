Return-Path: <linux-kernel+bounces-744036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D7B10730
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69265AC3AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FAA25B692;
	Thu, 24 Jul 2025 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o8zjl6KE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6125A340;
	Thu, 24 Jul 2025 09:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351145; cv=none; b=f9WXRI2VttsuPPf4hIZjXnUXWROLxVXcmZOD1ny6dOoSH3TwTicIUxX3DMK18CMc7of1xTQxCAUam7AYLkaGGrjMgj7ItNVEDvgsK0RR1d7Gk6Mo8uUU8pNFpFxO/FPNcslhU8gc7Q3r7b+R+75sUxMbcStqfVEVJO1gNCOXiFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351145; c=relaxed/simple;
	bh=7fFKQFGIrQlvsWOC6tbYSk6Z6H86XX2wrDEJxYDP+LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A+B/LguPYiIt/zrHTauWDhj57z47ajxi1L1HZJL2IjoX6WZk/FQQYAScbhFSZbAP+1wPRbkKH5AHFjbwLiRNrTkWa+5uz9lxzQNDqmrusURhOKx4EB7q5ChBMre3alDyAWHbs62lFUpP7nwan9kZqINky92nXPYGpVSM6XRcfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o8zjl6KE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5356C4CEED;
	Thu, 24 Jul 2025 09:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753351144;
	bh=7fFKQFGIrQlvsWOC6tbYSk6Z6H86XX2wrDEJxYDP+LQ=;
	h=Date:From:To:Cc:Subject:From;
	b=o8zjl6KEl0JCh7Esqu59ekgAgshEfKAv907IdfQ8B8683NSLq5R9whL64ZaRZ9vy5
	 TL8eX/deaBgQQMIDEHCa1KzyG73cTTfib3oQ1sgsv+YMr3vONyR3GheFNQXOgMBlAc
	 sM4XcIkDa8lp6QxVrK7d+NVZfwEesez3njbccxpK5BrTu0skr0MrtuPofEoL8V0kRl
	 VFii2MONvPNRPwviidA7ZrY3D3CcoWj0CxZYzEfRRUUg74fgEdr7Fk8Zm6WThW3XnY
	 qW1/deusJccZphkglar1f7H05eMSYAUqbu/6CCniGAPP4wiQBBP9PCdUWbKe/mNDlT
	 7yBn6nFT6LQ+A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uesj5-000000006oO-3bRc;
	Thu, 24 Jul 2025 11:58:59 +0200
Date: Thu, 24 Jul 2025 11:58:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB serial device id for 6.17-rc1
Message-ID: <aIID41gVBb1_HmxH@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 89be9a83ccf1f88522317ce02f854f30d6115c41:

  Linux 6.16-rc7 (2025-07-20 15:18:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.17-rc1-2

for you to fetch changes up to ad1244e1ce18f8c1a5ebad8074bfcf10eacb0311:

  USB: serial: option: add Foxconn T99W709 (2025-07-22 16:42:22 +0200)

----------------------------------------------------------------
USB serial device id for 6.17-rc1

Here's a new modem device id.

This has been in linux-next with no reported issues.

----------------------------------------------------------------
Slark Xiao (1):
      USB: serial: option: add Foxconn T99W709

 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

