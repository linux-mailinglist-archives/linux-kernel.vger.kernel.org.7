Return-Path: <linux-kernel+bounces-815609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81313B568F0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C96D71898208
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F39271476;
	Sun, 14 Sep 2025 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXEulGsW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9185E1922DD;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757854608; cv=none; b=Wh53u+0t3axpIKC/JnM/yBWB5xvJfVDvLssA5vFEyXAgMopIGpYu9d9Rp6ZjNT/71nXQdBS+1DYjMHrC/DsFyxLNgbZOTFzlGa6Nn6SOdQ0GfgaAoWvKWsxKjwrbSQqFyn46Z5Ltfpn/OjA/YOOpDCjG2SCg2dl671UqvfTOeN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757854608; c=relaxed/simple;
	bh=nhfs+mEuuE8OzOKQk+B9DPGOqq0cCbj6Jqm6nThYyu0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bw0RwGmElt5FxHZC58GfSDPd2ZnxmrGuMaFKAmtWNV+G149ki/NrGhr1TW3IGq5kcvE5m4NhfIzpqZfq5FjE5EUhK0uRj6785oB6IwWq5XjtuYXn/vtEaMG+aIeTS0wut9xMcbWS5+yvjZqeZ23+HjMooFKDbd0vsyHGK77jPKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXEulGsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 202DBC4CEF0;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757854608;
	bh=nhfs+mEuuE8OzOKQk+B9DPGOqq0cCbj6Jqm6nThYyu0=;
	h=From:Subject:Date:To:Cc:From;
	b=YXEulGsW23Is7++kfnodIGhBSLMgaqoGdGo2nU6MpgqZo749OGb43GdSUsHv5CmiP
	 Ojomeg5TfVXp6swxdvEYfFwHUKsNDoJ/c4548/RhwdDTtUkevchsm7nLlCTbtDncVf
	 ckt2qupVmcrLk4sNFOwLT4WzZVJEnd6arDfQD4pLbYizj+cuhs10Rz2I+poJMsx3Wl
	 mrLFwrLN5RxBqyw2GQ1GcJUr2AOm+sKAC45T+ukcfQtUqhGLXMy17IoYxDPKRHXc3o
	 /NKuz38NhZaj569Gb/R/1rhmLQaTDxBFUj2nTwF+qOuOK4R5nJ5TDCcv3qvVwDHAli
	 MRssd8zp6+W3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE9ACAC587;
	Sun, 14 Sep 2025 12:56:48 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Subject: [PATCH 00/11] Apple Silicon USB3 support - TIPD changes
Date: Sun, 14 Sep 2025 12:56:05 +0000
Message-Id: <20250914-apple-usb3-tipd-v1-0-4e99c8649024@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGW7xmgC/x3MQQqAIBBA0avErBvQTMKuEi00pxoIE60IorsnL
 d/i/wcyJaYMffVAoosz76FA1hVMqw0LIftiaESjhZEt2hg3wjM7hQdHj9qITqvOS3IaShUTzXz
 /x2F83w/4AgR6YQAAAA==
X-Change-ID: 20250914-apple-usb3-tipd-5907537d1eb5
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Sven Peter <sven@kernel.org>, stable@kernel.org, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=nhfs+mEuuE8OzOKQk+B9DPGOqq0cCbj6Jqm6nThYyu0=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8ax3aUW55adaz7+q4BDcRbvi28b+jek9dwN2m74X2lF3
 NKtWp3nOkpZGMQ4GGTFFFm277c3ffLwjeDSTZfew8xhZQIZwsDFKQATWVXC8E+PPfVNaej1N/Of
 Pt3gnOkxMbrmtEtr/JMVaxL9nuRwpP1nZLhmYZByw/eBv4r7gVopj3CHjboTQxsaZpdurloVvak
 3gg0A
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

This series contains the required TIPD changes to support USB3 on Apple
Silicon machines and also prepares DisplayPort alternate mode and
Thunderbolt/USB4 support there.

As discussed in the series combining TIPD, DWC3, PHY, and DTS changes
this series contains only the TIPD changes which are already in a pretty
decent shape.

Link to v2 of the combined series: https://lore.kernel.org/asahi/20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org/
Changes since v2 of that series:
- Added r-b tags from Heikki and Neal
- Addressed Janne's feedback:
  - Updated the tipd commit description to match the dwc3 glue driver
    approach
  - Removed a stale comment left-over from a WIP version and no longer
    required
  - Cleared cd321x->state.data after typec_set_mode is done
  - Removed spurious NULL checks for typec_mux_put and typec_unregister_altmode
  - Call cd321x_connect instead of open-coding almost the same logic
    inside cd321x_interrupt

Best,

Sven

Signed-off-by: Sven Peter <sven@kernel.org>
---
Hector Martin (4):
      usb: typec: tipd: Update partner identity when power status was updated
      usb: typec: tipd: Use read_power_status function in probe
      usb: typec: tipd: Read data status in probe and cache its value
      usb: typec: tipd: Handle mode transitions for CD321x

Sven Peter (7):
      usb: typec: tipd: Clear interrupts first
      usb: typec: tipd: Move initial irq mask to tipd_data
      usb: typec: tipd: Move switch_power_state to tipd_data
      usb: typec: tipd: Trace data status for CD321x correctly
      usb: typec: tipd: Add cd321x struct with separate size
      usb: typec: tipd: Read USB4, Thunderbolt and DisplayPort status for cd321x
      usb: typec: tipd: Register DisplayPort and Thunderbolt altmodes for cd321x

 drivers/usb/typec/tipd/core.c     | 559 ++++++++++++++++++++++++++++++++++----
 drivers/usb/typec/tipd/tps6598x.h |   5 +
 drivers/usb/typec/tipd/trace.h    |  39 +++
 3 files changed, 550 insertions(+), 53 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250914-apple-usb3-tipd-5907537d1eb5

Best regards,
-- 
Sven Peter <sven@kernel.org>



