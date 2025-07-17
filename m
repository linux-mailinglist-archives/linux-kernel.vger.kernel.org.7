Return-Path: <linux-kernel+bounces-735560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014F8B090FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D91133B472A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8412F949F;
	Thu, 17 Jul 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MPkR+6pp"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9832F8C3E;
	Thu, 17 Jul 2025 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767728; cv=none; b=Kk/Y83SxCvJCwimqsO5PZ45axcpZrREUBUNP3Z/Q0ijq4THXX8lgkBnlGqFBUNbBb+zjsEfw8y+ORctdZgIj1wKAuUob0dgxjII52ICL7lPpJPPcXAXOMwj/zzylBt+GOc6jyu0sSW1yQftbLoMWgsnbI3m6vN4PjNDChZS1YUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767728; c=relaxed/simple;
	bh=tp5Gg8behGF+WptAeTwttToqto+o2D/32qb6Ch0ydj4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ucFK1EqmxSUKuhymlboSxER8v/+6InRKTd9Fr6rTBxc0AxLE7ewgvn3BD40hO5QCrbtaAzKd4ctP/N6tDBUi1CsGlnLF5x9kTv2Md6M9tXbHItfM9hb6mqLRc7OzhgAPZFBO1dXkWHC5YfgugIgtukK0hSgwPHQN2GiC1RlBBAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MPkR+6pp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752767724;
	bh=tp5Gg8behGF+WptAeTwttToqto+o2D/32qb6Ch0ydj4=;
	h=From:Subject:Date:To:Cc:From;
	b=MPkR+6ppa7r1OYxNVfHHvwIfeIIgyt2gr8tzuEf4dE3caHiVc+0mrUWbxiVY11+vM
	 /7CcwBJwBs75PuU3pXghwg5WmiB18A/yI/nh4+6M487fKkaYPFoZMNY5TEEDbtOpP4
	 MR2NtS49WghYocNxX9h29D5FjE60gPEnRl3scfx+YklhSbtC5PRcQKPsy7EKJTlIeD
	 YPiuQ2+Xx7o6t6j6ySQcdXt5z4FNEydq4AFv/iMhMUKlf+wzAkhGtYQ4TFGUXJyXfb
	 bjDQ+xRw1E9tJh9h/+mVm/E1W667eLywIlJClwExGfzmkSLA025xTKtNSLcGCzGUDh
	 qi55GMDhzecng==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 72F0117E0657;
	Thu, 17 Jul 2025 17:55:24 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 0/9] USB/IP VHCI suspend fix and driver cleanup
Date: Thu, 17 Jul 2025 18:54:49 +0300
Message-Id: <20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMkceWgC/x2MQQqAMAzAviI9W5jDIfoV8aBtdb1MWVEE8e8Oj
 wkkD5hkFYOheiDLpaZ7KtDUFVCc0yaoXBi888F1TYtXJMVIjHbaIYlx1Rs7XgL5QMH1DCU9shT
 9b8fpfT/onvsbZgAAAA==
X-Change-ID: 20250714-vhci-hcd-suspend-fix-7db5c25c509d
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Brian G. Merrell" <bgmerrell@novell.com>
Cc: kernel@collabora.com, Greg Kroah-Hartman <gregkh@suse.de>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

The USB/IP Virtual Host Controller (VHCI) platform driver is expected to
prevent entering system suspend when at least one remote device is
attached to the virtual USB root hub.

However, in some cases, the detection logic for active USB/IP
connections doesn't seem to work reliably, e.g. when all devices
attached to the virtual hub have been already suspended.  This will
normally lead to a broken suspend state, with unrecoverable resume.

The first patch of the series provides a workaround to ensure the
attached devices do not enter suspend.

Additionally, during the investigation I noticed and fixed a bunch of
coding style issues, hence the subsequent patches contain all the
changes needed to make checkpatch happy for the entire driver.

WARNING:

Please note commit aa7a9275ab81 ("PM: sleep: Suspend async parents after
suspending children") from v6.16-rc1 introduced a regression which
breaks the suspend cancellation and hangs the system.

A fix [1] has been already provided, which is expected to land in
v6.16-rc7.  The patch is currently available in next-20250717, which
this series is also based on, as commit ebd6884167ea ("PM: sleep: Update
power.completion for all devices on errors").

[1] https://lore.kernel.org/all/6191258.lOV4Wx5bFT@rjwysocki.net/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (9):
      usb: vhci-hcd: Prevent suspending virtually attached devices
      usb: vhci-hcd: Fix space, brace, alignment and line length issues
      usb: vhci-hcd: Simplify NULL comparison
      usb: vhci-hcd: Simplify kzalloc usage
      usb: vhci-hcd: Do not split quoted strings
      usb: vhci-hcd: Fix block comments
      usb: vhci-hcd: Use the paranthesized form of sizeof
      usb: vhci-hcd: Consistently use __func__
      usb: vhci-hcd: Remove ftrace-like logging

 drivers/usb/usbip/vhci_hcd.c | 184 +++++++++++++++++++++----------------------
 1 file changed, 89 insertions(+), 95 deletions(-)
---
base-commit: 024e09e444bd2b06aee9d1f3fe7b313c7a2df1bb
change-id: 20250714-vhci-hcd-suspend-fix-7db5c25c509d


