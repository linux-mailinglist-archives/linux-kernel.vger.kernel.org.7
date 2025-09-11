Return-Path: <linux-kernel+bounces-812099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8854AB532EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464075A490C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 12:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02280322DC0;
	Thu, 11 Sep 2025 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8ZSTTG7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E032D238F;
	Thu, 11 Sep 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595529; cv=none; b=O+LiLfR2LXl+Mh9+zB1mxDh8WBSRpq0ZC40sAlpQGRr7FABBU+yMwKG8DFbNiHEf1+xzw6QxSoZvcitD9ufolIWO60zhT+XREDD/K71v/LmNIhlqosv/Pl++JWY3gAoLk2rm1XJdAvL9nGjAxoQq2mVmg5Tx30fdd8ssylhb3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595529; c=relaxed/simple;
	bh=HgKP3M2Ccgb2WIvb1cNpikhrRw5XFgn3Ig1dMQEk+l4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nNhTKFzr8+pMuPo+He1Y+tmOqc3hg/eZR9Nf+clZH2HPo5xLZTWKjDnOlzidLigWynENUr6nEWpfbRPf0LV8HdbEQ1267UY9rfpjh2/99w4mv1A8xMp4krZhLXpxHTNMzOy1xrn5rH0gefNTn+cpRsmkVjVF71W4Jl6LGR4QOlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8ZSTTG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E866FC4CEF0;
	Thu, 11 Sep 2025 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757595529;
	bh=HgKP3M2Ccgb2WIvb1cNpikhrRw5XFgn3Ig1dMQEk+l4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=N8ZSTTG7Y3I3idtzVF1bpUkcPFtW0erxyPWnOFJudaflL3gQ/dVjm7BXVrqACB/RY
	 drxm5XBHeF3yxo3Mq962iE1A6fLqZ3VxRzL3RpejUg1uIRWtnPDSLlCKg//pObtLRy
	 YOvJ90MdeZUhQry5HHPOd+Ob9eOKOPFS8ZUwvJXjX4PXbT1KSb89F5IeieUdAtomSz
	 IYHYcUxvI/W+eKXLWJncbK7o/8U66mL4XBSuvOpSJTH2gFFPtrEn/dIkfT36rp1a+4
	 yAo6q9Y+DgeADNOko0SYuRJPxnRpBxd5ja0ZoE6XJ7DoNTfYqdDvxfTFzblyUJaD05
	 thSThJpHOwc9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AA3CAC587;
	Thu, 11 Sep 2025 12:58:48 +0000 (UTC)
From: Alejandro Enrique via B4 Relay <devnull+alejandroe1.geotab.com@kernel.org>
Subject: [PATCH v3 0/2] Add support for safeboot pin to UBlox GNSS driver
Date: Thu, 11 Sep 2025 14:58:27 +0200
Message-Id: <20250911-ubx-safeboot-v3-0-32fe6b882a3c@geotab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHPHwmgC/3WMwQ7CIBAFf6XZsxhYRNCT/2E8AG5bDoqBSmqa/
 ru0JzXx3eYlMxNkSoEyHJsJEpWQQ7xXkJsGfG/vHbFwrQzIUXElduzpRpZtSy7GgUmtTIt1ijx
 U5ZGoDeOaO18q9yEPMb3WehHL+ydUBONMWNJaSKmk2p86ioN1Wx9vsJQKftiIPzZWmxuPKLVxx
 h++7Hme33Ss3d/nAAAA
X-Change-ID: 20250514-ubx-safeboot-3758f22225ec
To: Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alejandro Enrique <alejandroe1@geotab.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757595528; l=1418;
 i=alejandroe1@geotab.com; s=20250514; h=from:subject:message-id;
 bh=HgKP3M2Ccgb2WIvb1cNpikhrRw5XFgn3Ig1dMQEk+l4=;
 b=HPcL17RK+Ht6IPBGqReMPfYtLVhx+0zXovmOzatE7co3wMDFVmEk7fABp+sJmz2WOPp3bVrlV
 4QCcyorEcqDCeXstKvzT6dOKvi8JQore5+rCLMHr7RxjBkBow8gHQc9
X-Developer-Key: i=alejandroe1@geotab.com; a=ed25519;
 pk=xzHMPbqczL/tMsjXr26iLoHwIzLveHVnT+GIU4p1k38=
X-Endpoint-Received: by B4 Relay for alejandroe1@geotab.com/20250514 with
 auth_id=404
X-Original-From: Alejandro Enrique <alejandroe1@geotab.com>
Reply-To: alejandroe1@geotab.com

U-Blox 8/M8 and M9 chips have a pin to start it in safeboot mode, to
be used to recover from situations where the flash content has become
corrupted and needs to be restored. If this pin is asserted at power
up or reset, the receiver starts in safeboot mode and GNSS operation
is disabled.

If this pin is wired to a GPIO in the host it should be deasserted
before powering up or resetting the GNSS.

This series adds support for handling the safeboot pin when probing
the driver.

Signed-off-by: Alejandro Enrique <alejandroe1@geotab.com>
---
Changes in v3:
- Rebase on top of latest gnss-linus tree
- Link to v2: https://lore.kernel.org/r/20250522-ubx-safeboot-v2-0-08c22378b8c9@geotab.com

Changes in v2:
- Add if/then to dt binding to disallow safeboot-gpios property for neo-6m
- Link to v1: https://lore.kernel.org/r/20250514-ubx-safeboot-v1-0-1ae771335356@geotab.com

---
Alejandro Enrique (2):
      dt-bindings: gnss: u-blox: add "safeboot-gpios" binding
      gnss: ubx: add support for the safeboot gpio

 .../devicetree/bindings/gnss/u-blox,neo-6m.yaml      | 20 ++++++++++++++++----
 drivers/gnss/ubx.c                                   |  8 ++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250514-ubx-safeboot-3758f22225ec

Best regards,
-- 
Alejandro Enrique <alejandroe1@geotab.com>



