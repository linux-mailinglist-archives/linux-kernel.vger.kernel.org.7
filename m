Return-Path: <linux-kernel+bounces-746423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE45B12689
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77B6166C06
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AA225B66A;
	Fri, 25 Jul 2025 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FODV2Qq/"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEFF23184F;
	Fri, 25 Jul 2025 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481303; cv=none; b=BRPyRsmlQ/ITCB5iwq6/LJQ/uV8Nd2jY2jasq1PqEN0jIpeBwtYAYn5dKGJcU9nQwX9zR5HW4dTvA9FXjl902GCFfujLGdCd9gQzimAByijQPcCN/nVX0OEkIRRRyJHsnl5ak6UdFSg1Y8QfAoRTMuxyHhgYx8Im9T/HHv1pHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481303; c=relaxed/simple;
	bh=wniqcJNs+rZHqdZfzfuKr7r+ki/XKaYmgho/3jw6fSw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ppv9D049LdutqPg9AA7rjsU76Mj/4Clp+Lm/KtR7R2q7SNeUelQb/MEWSrGzDvbsG+NZ9b/beh8M+FOe5vAp0UaP20IT0Wf9BuIeMiaTGsguusXEHMj0/NOQ/BfpP2SMo63jJpSdv8nXXwe/36zMIFTrHc1xG2ZyFrUnxVw2tlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FODV2Qq/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753481298;
	bh=wniqcJNs+rZHqdZfzfuKr7r+ki/XKaYmgho/3jw6fSw=;
	h=From:Subject:Date:To:Cc:From;
	b=FODV2Qq/0hUpF9XxYjFFbakmS8soIvQg+Xe7Css6p87PMQFanxs0DiRQW7AJFQHAO
	 TlsFsk93Sw5h/0SDw14sBFlVHdcn7Jx0kgO/J9WjTr1EuYtxh9r9zjL+DIBdyeQ/vS
	 LdsFDNCHhU1NoONVUu6e9NFiYyIRWr9coLVTTHJro6HQ6DKLDVm0ctbAj6MS5/YYqC
	 osNHwleVBrtxY3pq+CgoKcNGjkvaxc/4YeELDNmt8A+WaA4lG8tajt8fj+I7rcTzuE
	 N5hv+uXOlo768Gh03JyPd7fGXXcY3N4wIlLd2O3NPQ6K+acnsdn912BwRJSEGpB6pW
	 ZLdS0l9q82yvA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 64DBB17E0B8C;
	Sat, 26 Jul 2025 00:08:18 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 00/18] USB/IP VHCI suspend fix and driver cleanup
Date: Sat, 26 Jul 2025 01:08:02 +0300
Message-Id: <20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEMAhGgC/22NQQrCMBBFr1Jm7cgkGEpdeQ/pop1EM1CTktSgl
 N7dWHDn8j3476+QXRKX4dyskFyRLDFU0IcG2A/h7lBsZdCkDbXqhMWzoGeL+ZlnFyze5IWtHQ1
 rw4Y6C3U6J1f1nr32lb3kJab3/lLU1/6C7f9gUUioRyJiS6Yz+sJxmoYxpuHI8QH9tm0fOTYJ5
 LwAAAA=
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
virtually attached devices do not enter suspend.  Note this is currently
limited to the client side (vhci_hcd) only, since the server side
(usbip_host) doesn't implement system suspend prevention.

Additionally, during the investigation I noticed and fixed a bunch of
coding style issues, hence the subsequent patches contain all the
changes needed to make checkpatch happy for the entire driver.

IMPORTANT:

Please note commit aa7a9275ab81 ("PM: sleep: Suspend async parents after
suspending children") from v6.16-rc1 introduced a regression which
breaks the suspend cancellation and hangs the system.

A fix [1] has been already provided, which also landed soon after in
v6.16-rc7 under commit ebd6884167ea ("PM: sleep: Update power.completion
for all devices on errors").

[1] https://lore.kernel.org/all/6191258.lOV4Wx5bFT@rjwysocki.net/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Updated cover letter to indicate the PM core fix has landed in
  v6.16-rc7
- Also made it clear that the patch fixing up suspend prevention only
  applies to the client side (vhci_hcd), since the server side
  (usbip_host) doesn't implement this functionality
- Documented the usage of dev_pm_syscore_device() in vhci_urb_enqueue()
- Reworked most of the cleanup patches according to the feedback
  received from Greg
- Link to v1: https://lore.kernel.org/r/20250717-vhci-hcd-suspend-fix-v1-0-2b000cd05952@collabora.com

---
Cristian Ciocaltea (18):
      usb: vhci-hcd: Prevent suspending virtually attached devices
      usb: vhci-hcd: Ensure lines do not end with '('
      usb: vhci-hcd: Consistently use the braces
      usb: vhci-hcd: Avoid unnecessary use of braces
      usb: vhci-hcd: Consistently use blank lines
      usb: vhci-hcd: Drop spaces after casts
      usb: vhci-hcd: Add spaces around operators
      usb: vhci-hcd: Drop unnecessary parentheses
      usb: vhci-hcd: Fix open parenthesis alignment
      usb: vhci-hcd: Simplify NULL comparison
      usb: vhci-hcd: Simplify kzalloc usage
      usb: vhci-hcd: Use the paranthesized form of sizeof
      usb: vhci-hcd: Fix block comments
      usb: vhci-hcd: Remove ftrace-like logging
      usb: vhci-hcd: Consistently use __func__
      usb: vhci-hcd: Do not split quoted strings
      usb: vhci-hcd: Switch to dev_err_probe() in probe path
      usb: vhci-hcd: Replace pr_*() with dev_*() logging

 drivers/usb/usbip/vhci_hcd.c | 274 +++++++++++++++++++++++--------------------
 1 file changed, 146 insertions(+), 128 deletions(-)
---
base-commit: 024e09e444bd2b06aee9d1f3fe7b313c7a2df1bb
change-id: 20250714-vhci-hcd-suspend-fix-7db5c25c509d


