Return-Path: <linux-kernel+bounces-774640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D47B2B574
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFFD188C17B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05446186294;
	Tue, 19 Aug 2025 00:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHVo0vBP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B48B13FEE;
	Tue, 19 Aug 2025 00:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755563971; cv=none; b=SS+SmGj9EebrQfDSI1ayOGNlzCiWkFucoFIECt48SB2Ff1J87h978RqvurbJCgiwrjeRmZfPHzVgId+xPD1M3o8gGH8gQokVtEAFApnt7B0qpbSEAJDr/CcTE+put4kimBoT4WKVP4kepkNfEDyAYs2LSezILsULwvTsqGoow+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755563971; c=relaxed/simple;
	bh=WDNszwltpLQj095+dvIPOHVClsf5ww3pSdE5uc4uTKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuhjd5jPDuN8DhQNxC/VpfMCh5Rijl3uA7mci4ETklFnjjlq+/5QqTQdcAJcLSxu+Kk1DFDfPmBRgi9DFIDPuI7XmvFjQ/i7m8X+TXp6bU7zbhqVlZNs0CizhEqgbi3NxrgB1K9qXJJQMt41G8qYvMHCQP94HXoKcbXrqW6X550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHVo0vBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270DCC4CEEB;
	Tue, 19 Aug 2025 00:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755563971;
	bh=WDNszwltpLQj095+dvIPOHVClsf5ww3pSdE5uc4uTKQ=;
	h=From:To:Cc:Subject:Date:From;
	b=mHVo0vBPeac61Oj5ZcjymRneKnu2z50JqdbsTpc8zQDETJG+ucMehJcnA+U3LQ1Aa
	 R9e1GQWbPIMk+zZEa/Vzi03beUzjmDpMwujBxQJ4+Lfb4frnqYTVgJwDupK+SYZ1v8
	 k+wAn/6R8fu/T/r4v9Cmeu5jb1bCRxICe/P8Ht+DuYLN0ONOyrp0xX3plWTAK0xC0J
	 r9iG1Es4bscsopQt5nawV9ZSEAMqgJ7ZAiViyLt7qAYJvJIehhNqlSESm8tuo15dRD
	 QK9EbKUMuQ7Pz5HFPBJlG7BIOEeUeCrfJ/AnYIDGpxucTwy9Sf0eeeVStuYOZnS3S9
	 z1VYIxoO1ZYfQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Richard Leitner <richard.leitner@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] usb: usb251xb: support usage case without I2C control
Date: Tue, 19 Aug 2025 08:22:14 +0800
Message-ID: <20250819002217.30249-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor so that register writes for configuration are only performed if
the device has a i2c_client provided and also register as a platform
driver. This allows the driver to be used to manage GPIO based control
of the device.

Since v1:
 - make the modern pm macros usage a separate patch
 - use pm_sleep_ptr instead of pm_ptr for usb251xb_plat_pm_ops, because
   this ops is for PM_SLEEP only.

Jisheng Zhang (3):
  dt-bindings: usb: usb251xb: make reg optional for no I2C ctrl use case
  usb: usb251xb: use modern PM macros
  usb: usb251xb: support usage case without I2C control

 .../devicetree/bindings/usb/usb251xb.yaml     |   1 -
 drivers/usb/misc/usb251xb.c                   | 108 +++++++++++++++---
 2 files changed, 94 insertions(+), 15 deletions(-)

-- 
2.50.0


