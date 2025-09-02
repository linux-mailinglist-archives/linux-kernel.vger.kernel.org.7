Return-Path: <linux-kernel+bounces-796322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D011EB3FEF5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6592C7C8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736892FB60F;
	Tue,  2 Sep 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cntxhE1g"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159B2FABF5;
	Tue,  2 Sep 2025 11:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814219; cv=none; b=uTzHmWWq9VeJ/3feQv1oyZYAWpV1TCNzE9hkwGzimsdqibDfKtLKem4s6ByAXhVp3q2Kd8sFXSkTwr25BTBKSAm1A0dnL4H++F9fE3JoQEhu6KGFUjOAMew3mvHgPlN1UZ24dLp0WnlJLaGKJiyhiZ+Euyipan3y3cJtNKd+J2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814219; c=relaxed/simple;
	bh=q+M7pSUnssBpKVPEthWYwOr+KYHo8DmHK19Ac5wtm2Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r5pRhnP+5IiIAtAzVFYdfJB5Wnii/JRXXFckWp1BZJwomDRKLKCxYlsuunZUO66S8clc6GvLOLccCZBg5FkPvT3pX6T9YSlrezqvnMCYBKhU3s8uW1VSLRzooQe4SZWFLCmK0olwyCpi+NDuCfogcnEMmGTve4vd2DNKYvwHn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cntxhE1g; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756814216;
	bh=q+M7pSUnssBpKVPEthWYwOr+KYHo8DmHK19Ac5wtm2Y=;
	h=From:Subject:Date:To:Cc:From;
	b=cntxhE1g5KZwrMO7pr/aAUXKdFXjUwHptZw9MUU2djQjf3pwe/kD/r5ErvAxRYgJd
	 FtRgSPFwR3QEXzFDPqyQgSIahNxE7pUbesHJ9PajyLXa6ngVH4okevQXpIEeBwGKO5
	 HvQfAjkje7ZUT3i40X+vxBfGqcO16Wu3WlwVqj6d3kirpAGyuQ4mB7P2Op5/Cq4iHe
	 b+K3775khJszpcqrhzi3WNFujaYmxjvgMLOKqO7bZXs1GNSdrnrivWpF1xnWlrgO1i
	 yghHUOonboVmYvT4bXW/YgiDicpYA30JNbc2Z6BTKL2K4QRtLZovnZaYly+hQG4h8R
	 n7jqkBgkrsiHA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id D78D017E0B84;
	Tue,  2 Sep 2025 13:56:55 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH 00/17] USB/IP VHCI driver cleanup
Date: Tue, 02 Sep 2025 14:56:22 +0300
Message-Id: <20250902-vhci-hcd-cleanup-v1-0-1d46247cb234@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGbbtmgC/x3MQQqAIBBA0avErBtQy6KuEi1EpxwICyUJwrsnL
 d/i/xcSRaYEc/NCpMyJz1Ah2wasN2EnZFcNSigtJqEwe8vorUN7kAn3hZ3ojRtGKbXTULMr0sb
 Pv1zWUj7bGJUbYgAAAA==
X-Change-ID: 20250902-vhci-hcd-cleanup-304ad67115d5
To: Valentina Manea <valentina.manea.m@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel@collabora.com, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

These patches were initially part of the USB/IP VHCI suspend fix series
[1] to address a bunch of coding style issues and make checkpatch happy
for the entire driver.

As suggested by Greg, I'm sending this as a separate patch set now.

[1] https://lore.kernel.org/r/20250726-vhci-hcd-suspend-fix-v2-0-189266dfdfaa@collabora.com

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Cristian Ciocaltea (17):
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

 drivers/usb/usbip/vhci_hcd.c | 252 +++++++++++++++++++++----------------------
 1 file changed, 124 insertions(+), 128 deletions(-)
---
base-commit: 3db46a82d467bd23d9ebc473d872a865785299d8
change-id: 20250902-vhci-hcd-cleanup-304ad67115d5


