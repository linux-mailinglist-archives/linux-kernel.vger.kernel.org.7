Return-Path: <linux-kernel+bounces-763209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A4EB21234
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C46665206CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E37C2E3382;
	Mon, 11 Aug 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioJ2Tcv8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5522E2EE8;
	Mon, 11 Aug 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928796; cv=none; b=iphJ88kc4hxCDm4zHdW4UeFVwfFbgRIcvbXfmhe4UpjOK3ctTyiGReTQdbnb+P59eaCf2kC1bStopfT4kiL5lU99uXgI/c4SCfj2BkwvLl797yMX1N3mBsxpwKnlIiR3B2X6mIdXgSRJTq6bAwSd6icIOh7uo+n11nCGswAEcjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928796; c=relaxed/simple;
	bh=BngNvQtxxPHzANuXTDA6edjPk7rZAtFM5WdYLG3It70=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dBTzoY5EVN9FrWnC+9waNPzpCP/x1+L/H7/DcopsyIho8YEU8iQH+iE6qpHLtJ97g3VF3TLeJkwVy8bk1v8Xp/2fk460eMdpWcWjVCXehZrPKTdZACwZ14vIHob5XuO9BGsb2UTgR+zTaGVCXwa6ozawESyE85lJJw7/iHSl4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioJ2Tcv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2204DC4CEF4;
	Mon, 11 Aug 2025 16:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754928796;
	bh=BngNvQtxxPHzANuXTDA6edjPk7rZAtFM5WdYLG3It70=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ioJ2Tcv8wWPTyFSIevlLFL6UcLgrJOsPkqcx90GEbJjcylOHEcTIqgWkXP/wHNuPx
	 ZDSKYKOUwqpc2rBFQclBqU36v1jyXMfc6o+98W+PnyZt1XusW3qIpn5KnbaSYOgwRC
	 mLwLbhbHeAxm5XUDR91v+6cNgHHigGE6T0pMXQD7IoCua0iTq7LFPy6fpA8Ipt3BkC
	 TtIv6k7iSG7X7l4tmmp1awhaScM09CaW63XAy0Yu1zdyLJjX9QyOyQXOaB658w/Tgb
	 JU7IqM3rl7vONjcQCPKwS+OH1ryswxNc/H5QBk53iy66xpsEAegJdrf0C4TcP/ANIZ
	 6/CYGVvI5UFBg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199D8CA0ED1;
	Mon, 11 Aug 2025 16:13:16 +0000 (UTC)
From: Gregory Fuchedgi via B4 Relay <devnull+gfuchedgi.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] hwmon: (tps23861) add class restrictions and
 semi-auto mode support
Date: Mon, 11 Aug 2025 09:13:14 -0700
Message-Id: <20250811-hwmon-tps23861-add-class-restrictions-v2-0-ebd122ec5e3b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJoWmmgC/03NywrDIBBA0V8JrjvBBzG2q/5H6UJ0okKMxbEPC
 Pn3Sldd3s25OyOsCYldhp1VfCVKZeshTwNz0W4BIfneTHI5ccMNxHcuG7QHSWW0AOs9uNUSQUV
 qNbnWAQKjHCrHpTdmYt16VFzS5/e53XsvtWRosaL912cpJq7mUZiz0FqDgLA8XUQf0jVkm9bRl
 cyO4wt5ZQr0tgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754928795; l=1529;
 i=gfuchedgi@gmail.com; s=20250811; h=from:subject:message-id;
 bh=BngNvQtxxPHzANuXTDA6edjPk7rZAtFM5WdYLG3It70=;
 b=A72Hmv6jDYqCbccWDuiRCxTupDmvpCXwUE2eoETQvNLrJQNL5w6+BIGbMk+WNvBkYuVhDX720
 cNF2R9o2EbaD5qiS0viNzdjDD0LmUssBk2/F8wmBY4GRJ1ATYsevy8X
X-Developer-Key: i=gfuchedgi@gmail.com; a=ed25519;
 pk=J3o48+1a2mUIebH8K4S3SPuR5bmamUvjlsf8onoIccA=
X-Endpoint-Received: by B4 Relay for gfuchedgi@gmail.com/20250811 with
 auth_id=484
X-Original-From: Gregory Fuchedgi <gfuchedgi@gmail.com>
Reply-To: gfuchedgi@gmail.com

This patch series introduces per-port device tree configuration with poe class
restrictions. Also adds optional reset/shutdown gpios.

Tested with hw poe tester:
 - Auto mode tested with no per-port DT settings as well as explicit port DT
   class=4. Tested that no IRQ is required in this case.
 - Semi-Auto mode with class restricted to 0, 1, 2 or 3. IRQ required.
 - Tested current cut-offs in Semi-Auto mode.
 - On/off by default setting tested for both Auto and Semi-Auto modes.
 - Tested fully disabling the ports in DT.
 - Tested with both reset and shutdown gpios defined, as well as with reset
   only, as well as with neither reset nor shutdown.

V1->V2:
 - code cleanup
 - split bindings into separate patch
 - use patternProperties
 - use labels instead of DT node names
 - add few comments for clarity

Signed-off-by: Gregory Fuchedgi <gfuchedgi@gmail.com>
---
Gregory Fuchedgi (2):
      hwmon: (tps23861) add class restrictions and semi-auto mode support
      dt-bindings: hwmon: update TI TPS23861 bindings with per-port schema

 .../devicetree/bindings/hwmon/ti,tps23861.yaml     |  86 +++++++
 Documentation/hwmon/tps23861.rst                   |   6 +-
 drivers/hwmon/tps23861.c                           | 249 ++++++++++++++++++++-
 3 files changed, 335 insertions(+), 6 deletions(-)
---
base-commit: b1549501188cc9eba732c25b033df7a53ccc341f
change-id: 20250808-hwmon-tps23861-add-class-restrictions-83ce3c02d885

Best regards,
-- 
Gregory Fuchedgi <gfuchedgi@gmail.com>



