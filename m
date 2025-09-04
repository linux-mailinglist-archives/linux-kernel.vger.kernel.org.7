Return-Path: <linux-kernel+bounces-801383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7956B44470
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3EF18936B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8100311C33;
	Thu,  4 Sep 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApzKavDW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5222A4FE;
	Thu,  4 Sep 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757007243; cv=none; b=Hxse5FsV2mDXTUMgJPvLXjSmQ7oX5kXOLbX85CKn3ZolQ80ctwlrCrhWCQfVkxXMWgXA4bxMYN9SjggEqf3PqQYETw2R3yOKm5lgYgSsYdZIpZ3tik403zpMXQc6hpXqszLnIWtcgQ1uawm91AfFa97Ew90nBYHfc+4+uA7/olE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757007243; c=relaxed/simple;
	bh=Q8u5AE9BcSw1w6JnJ4OUyiCoWbJlKGuQEsgoN4gZJBo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nerNeWm5Mvqi5i/xDTvPxeD3OMXAFJKO7s2S3jF4yut6BuakdEEyJLHf+EVtSp2B15LJl/FUaDmDa3K6SgJHmC8ewqZPNZfv2mEDj1lJAbnkp1nlHfJNmb2LNtAOvbjlcqBBH17KzFdtedE3DI9cSQr5HmyH9yDAdsAlCNqIJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApzKavDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8618C4CEF0;
	Thu,  4 Sep 2025 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757007242;
	bh=Q8u5AE9BcSw1w6JnJ4OUyiCoWbJlKGuQEsgoN4gZJBo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ApzKavDWHKZ/xbTK398gWw3N4dKS4CMoCpPpd/vJekhVzBsEde5IyOV8N5yvLMV21
	 64/XpB83K4iMIUbr3lMc8gEOEXkLLpHk+DpW2ALvYqPBsmIMHwxVeUmuj6BYpGKraM
	 8APeDtYrExOkhILm022u9QYoDqGuoJCJdgAXxChXWjZe6xseyhgUG7ulV6+UCeG1US
	 G7OBaC3TLhWKkNltS7npxUtDcPwM52GuQe0+sEwZeYE8vMzcxfcXw/leBXlgNps/5q
	 7Hr3QhwIE/AJvIDZ5KnOCrj/9ZWoZ5I64Gdw+iwvsUOk+Y9P8dxtkMvDlBec9mLQi6
	 u7iNU+5aEBt9Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05D6CA1012;
	Thu,  4 Sep 2025 17:34:02 +0000 (UTC)
From: Gregory Fuchedgi via B4 Relay <devnull+gfuchedgi.gmail.com@kernel.org>
Subject: [PATCH v3 0/2] hwmon: (tps23861) add class restrictions and
 semi-auto mode support
Date: Thu, 04 Sep 2025 10:33:43 -0700
Message-Id: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHjNuWgC/43OMY7CMBCF4asg1wyyx0owVHuPFYWxJ/FIJEYeb
 xaEcvc1aAtKyr/53nsoocIk6rh5qEILC+e5hd1uVEh+Hgk4tlaosdNOO0i/U56hXgWt6w34GCF
 cvAgUklo41AYIOBvIBo3RuU4161po4Ntr5/vUeih5gpoK+Xd9j6bTdr8z7mD6vgcD4/ATEsWRv
 8bJ82UX8vTkEkvN5f56veAT/SeM+fDggqCBztEgUujInt8GTuu6/gH4PEB4GQEAAA==
X-Change-ID: 20250808-hwmon-tps23861-add-class-restrictions-83ce3c02d885
To: Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Gregory Fuchedgi <gfuchedgi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757007242; l=1732;
 i=gfuchedgi@gmail.com; s=20250811; h=from:subject:message-id;
 bh=Q8u5AE9BcSw1w6JnJ4OUyiCoWbJlKGuQEsgoN4gZJBo=;
 b=VJ4sy7voS76B6MrrmBM9jkJElOp580d8nGAQMFNlkcJoFVup8atDGUKqpjGfVByJaGo5a7t+Y
 NBWW8fstcO3DNgiZnuorfYNwHoEQk2gYfg+tbnIVho+elIBHOM988qV
X-Developer-Key: i=gfuchedgi@gmail.com; a=ed25519;
 pk=J3o48+1a2mUIebH8K4S3SPuR5bmamUvjlsf8onoIccA=
X-Endpoint-Received: by B4 Relay for gfuchedgi@gmail.com/20250811 with
 auth_id=484
X-Original-From: Gregory Fuchedgi <gfuchedgi@gmail.com>
Reply-To: gfuchedgi@gmail.com

This patch series introduces per-port device tree configuration with poe
class restrictions. Also adds optional reset/shutdown gpios.

Tested with hw poe tester:
 - Auto mode tested with no per-port DT settings as well as explicit port
   DT ti,class=4. Tested that no IRQ is required in this case.
 - Semi-Auto mode with class restricted to 0, 1, 2 or 3. IRQ required.
 - Tested current cut-offs in Semi-Auto mode.
 - On/off by default setting tested for both Auto and Semi-Auto modes.
 - Tested fully disabling the ports in DT.
 - Tested with both reset and ti,ports-shutdown gpios defined, as well as
   with reset only, as well as with neither reset nor shutdown.

Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
---
Changes in v3:
 - cleaned up dt bindings in response to v2 review
 - Link to v2: https://lore.kernel.org/r/20250811-hwmon-tps23861-add-class-restrictions-v2-0-ebd122ec5e3b@gmail.com

Changes in v2:
 - code cleanup
 - split bindings into separate patch
 - use patternProperties
 - use labels instead of DT node names
 - add few comments for clarity

---
Gregory Fuchedgi (2):
      dt-bindings: hwmon: update TI TPS23861 with per-port schema
      hwmon: (tps23861) add class restrictions and semi-auto mode support

 .../devicetree/bindings/hwmon/ti,tps23861.yaml     |  93 +++++++-
 Documentation/hwmon/tps23861.rst                   |   6 +-
 drivers/hwmon/tps23861.c                           | 249 ++++++++++++++++++++-
 3 files changed, 341 insertions(+), 7 deletions(-)
---
base-commit: 3db46a82d467bd23d9ebc473d872a865785299d8
change-id: 20250808-hwmon-tps23861-add-class-restrictions-83ce3c02d885

Best regards,
-- 
Gregory Fuchedgi <gfuchedgi@gmail.com>



