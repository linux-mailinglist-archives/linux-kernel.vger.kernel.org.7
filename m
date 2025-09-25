Return-Path: <linux-kernel+bounces-832431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C44B9F4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66C771BC0D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309FB1A5B8F;
	Thu, 25 Sep 2025 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jF6luuCb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3613C9C4;
	Thu, 25 Sep 2025 12:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803922; cv=none; b=DLJqHWna1WwTQ2+TZfx5/PJLmwKpkRgec5dHMdDOFl7Jdi283lgHXo46WI3+ASDlUl8d0XYfCPH5F499Nzqk9vKa4ZoprtNuWSSVah3Y8t2uiDjvDKA8LhtUX13C/u0PoVJhxfvMSMRM2UUEYXld7sYnpeQ1A12+l1NBM4nBW+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803922; c=relaxed/simple;
	bh=UgWv6X2vYlWUvyvVymNi+tEVYlPJ8+BozqAT4GoBRU8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C9AQ1ySO17nSsbVOyMG71oHugY8WPkBEO+2PLFfBuJ4RoQQHISmvSS38ny5HynGyffWodXIzzPo1YibsGBxUUtAF5D/Ixna+UwmtjHFuZ806s7KFBJwSHapYMCUjA/cXLx0NGp2Ir+soDP1x+qEIVVHza7BIzWmRUSDxvpRj8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jF6luuCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61186C4CEF0;
	Thu, 25 Sep 2025 12:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758803922;
	bh=UgWv6X2vYlWUvyvVymNi+tEVYlPJ8+BozqAT4GoBRU8=;
	h=Date:From:To:Cc:Subject:From;
	b=jF6luuCbdWI2e9T1mi/vF3uvHiOHdGhJSLxAc+93OZDs2xDSvJdGTUbohgCdModpT
	 IytW4QdFQUF4lKMV7Xwgsl8LI0jFT8smKsT3sd61LF4BnyqU9QLuJf86bytkKod7ml
	 uDhxeqXbksWPYL8OBBomegNp9RgYEF+4IciUkwxtW+gN8OOWJDuHrqj1YIMbuAHe5U
	 2tOT25/v3hkuoGEE/Saa9WIhiFeAz/wy68wmVpb3mI3U+/EUIYVoEcUA0w8qOOV2eB
	 HxKfUClLC7/QO4jGuUewVpEfPw0QYwzH+r6T2dTlO/ZRNJFVYXfo3vhBlXGHsWObsi
	 u12cSeCDt9vXA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v1lF5-0000000038Q-0mI1;
	Thu, 25 Sep 2025 14:38:35 +0200
Date: Thu, 25 Sep 2025 14:38:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB serial updates for 6.18-rc1
Message-ID: <aNU3y3Cs54wkdhLY@hovoldconsulting.com>
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

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.18-rc1

for you to fetch changes up to 0e0ba0ecec3d6e819e0c2348331ff99afe2eb5d5:

  USB: serial: option: add SIMCom 8230C compositions (2025-09-24 09:30:06 +0200)

----------------------------------------------------------------
USB serial updates for 6.18-rc1

Here are the USB serial updates for 6.18-rc1 consisting of some new
modem device ids and a trivial cleanup.

Everything has been in linux-next with no reported issues.

----------------------------------------------------------------
Colin Ian King (1):
      USB: serial: oti6858: remove extranenous ; after comment

Xiaowei Li (1):
      USB: serial: option: add SIMCom 8230C compositions

 drivers/usb/serial/option.c  | 6 ++++++
 drivers/usb/serial/oti6858.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

