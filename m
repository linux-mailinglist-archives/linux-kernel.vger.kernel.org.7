Return-Path: <linux-kernel+bounces-614707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD2FA9708A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 17:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9A98173149
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26F428FFCD;
	Tue, 22 Apr 2025 15:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="kut5Npwf"
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch [79.135.106.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A128F951
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335392; cv=none; b=ST9QRC0j4+zu/bKAM8QeEnXZzDoITHOrYChQ0g8qSOLKGZvfAadobXE5fLBUm2hslJX3Y52iENahRklHMPCnQvsk0fMQN9ut0Cyt3LGIo2S/RQbwGMfIES1y4k/2ic8wi2v5+RUjLk8A4Yt76ch6LbLZ3tpR0Mw9+/2YeY/PH6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335392; c=relaxed/simple;
	bh=agBlO360QS5qNy/3UMg3y1FA7SFwQtiXCvg4rIouDvo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ru9gcswlIe/5eEXyrBsfb13P3ePbA/dTreEQ5FBP0U4OTszU6cH0mxwRWipxcbrEtCsdSFU8gC7wTL/ztE6+ZwQ39Y0iX9J+TPxfDujjnEpi2B0ccCjnuAcjd1ZBlq0OJJbs2OkPdpJYQboY6UL5zhrNW6v7Zo9WiQ0vmyPqHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=kut5Npwf; arc=none smtp.client-ip=79.135.106.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1745334913; x=1745594113;
	bh=ILoWC/sy2iITa4NSo18LSU+Ros/OxARhBaBtR8WnMRw=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector:List-Unsubscribe:
	 List-Unsubscribe-Post;
	b=kut5Npwf/uVvFhC7/VPTDKzQComJndJ4S3b6BQJpDnImAX6LtOIpUvG8VpvJ7pGLB
	 mqo+qnPgVPGpCeZpCbpjFVmWf9Jcxn+Itl1xEhI2Q8x4IySYRz8AjXI4rFuE1Pbhnd
	 y4CDQlthNGaeHHYtkviP6/3ir3GyF5S8Dii4a+1I87Zv7LQkQ5B0TJvB7hON+Agctw
	 1XDFpoVDIJpobx81DtGrzRYd/3LDmo0issgCPurdU0yPI7SbZWS3dBxokX53dAGkfA
	 AzlAQ3YCVfm2FUnVkxfee+EecxcUkY1XcHEWNX3JAERuB3Hp22Nxu1l4lY1KKiPhnA
	 ShSYA1Fnc2png==
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH 0/2] input: touch: goodix: Extend reset pull-up fix to DT
 platforms
Date: Tue, 22 Apr 2025 17:15:01 +0200
Message-Id: <20250422-goodix-no-reset-pull-up-v1-0-3983bb65a1bf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHWyB2gC/x3MQQqEMBAF0atIr22IrTKMVxlcBPPVBklCMoog3
 t3g8i2qLspIikxDdVHCoVmDL2jqiqbV+gWsrpjESG86EV5CcHqyD5yQ8ee4bxvvkZ2gs1/bwnw
 slTomzHq+59943w9Eu3lRaQAAAA==
X-Change-ID: 20250422-goodix-no-reset-pull-up-d2e4a9a3e07a
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745334911; l=715;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=agBlO360QS5qNy/3UMg3y1FA7SFwQtiXCvg4rIouDvo=;
 b=J2eFeZ5CJbMnKOF17nODJxt3ofiVjkIpIBWwFomqgHaInTHKG6yUDkGuuUGc9SDfsSBaa2uJi
 Z5uVNMWJVRnBo2NrObEFAujEzm+oRZ0O/ZKUyTc2KPHWehvTZfgCbKt
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

This extends the fix for platforms without external pull-up on reset pin
to device-tree platforms.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Esben Haabendal (2):
      dt-bindings: input: touchscreen: goodix: Add no-reset-pull-up property
      Input: goodix - Allow DT specification of missing reset pull-up

 .../devicetree/bindings/input/touchscreen/goodix.yaml          |  4 ++++
 drivers/input/touchscreen/goodix.c                             | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)
---
base-commit: 9c32cda43eb78f78c73aee4aa344b777714e259b
change-id: 20250422-goodix-no-reset-pull-up-d2e4a9a3e07a

Best regards,
-- 
Esben Haabendal <esben@geanix.com>


