Return-Path: <linux-kernel+bounces-851330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75947BD62B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D725A4F4E62
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A649130E849;
	Mon, 13 Oct 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfK6C81h"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF830AD06
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387660; cv=none; b=lcqqt220qnDiOKdvQbRYfSv6YcapW2HoBA4YFMXQp2q+s7byR9BevwHr0sxnGMM4G6GlNLgMT+Pf1Ptl+kN34US1AXW0ETl6jgnzXIt2EOz1lNcvPI8itlgrJhhc9OPtJP2mZmXS5190vJVgUdsN4aH1hAo+nzUMdn2ljAYymBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387660; c=relaxed/simple;
	bh=FpQkjfU4TuUbSHTPuiOa8TR8ZPo23HNXZuZYxBTIe80=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I7GBOC7S7vOOzZgs87MmtW6dBh6/sVIp86o+pgBx6Pr2m7t5HDKIo1aR/O6ydIuOYZ8zwDJArW1sjgVBUh5ekMiT/O0Gu6Vmn1bYyaaAEv7YC+thRInAJdzBbdcgb0FUHHAp8AfXWaEy2CCQVhlRAfDpkVSCrEcWqzDf9G1UAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XfK6C81h; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7900f597d08so7053565b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760387657; x=1760992457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geE3ZI6aoZMvu7ZVVGVVhjF0W7bw8fld1I5WFjkcmTg=;
        b=XfK6C81hw0EYPYh3X87wP9r82G7dDcF9zVkUI2I4JLWbPiIkUFhxFqR7GfQH1NH/B5
         Dj3Ta54TtAKrWFk/u5kcT5B1QIHohy+fp8XuJHvhxVO+udWGFAplSvtL667W7I7jzjL5
         SqcVxKNvW1yNdGHuulKg4u0uo1PH4f/8wa6wij2Oig8CgxiLUVVSAGFveiFfHseoG7+K
         A4FZgFYAMBu01DoUKOkEMmt/8a9XtVSPG+W3X63dekS2cSyautRfDfOJBTsPrUNI7mew
         bJu2U5OAShDT2aSopFN1IDuM8Zal9czdNBTZLj8QZms/aTh6iVR86O/SEWRBeUXZw5PN
         80uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760387657; x=1760992457;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=geE3ZI6aoZMvu7ZVVGVVhjF0W7bw8fld1I5WFjkcmTg=;
        b=WslDuSgVT7iNo4rT3tdjnuK1aQwVkb5xaAwYdvZPCDbvkNANBXCsnZYt/z/6WfFv36
         cy65fR80x9uXVAAJ+Y3Zk25RQs11BJ6lzgZ55cfOda6C9+7C/7poA2B2ouzpY5KDVhjl
         HqLjNIud3G48b5qNiUspTTSZylLht/Hf6h8I0sH2PcXxX4U7I0eWZR2ep0zho7UEIrwy
         folOAr7Y7aQpKH9m9HM8dbW2Fg6U4mGTl0vpybYhnagoUq7Uizk311+IuBclHxaJ/sRE
         kkZIhEViGxZQdpnizQ+PjG3IkYHvUAoTj+C8kp+PhciR0irYgBjoUykcalOdIxjdS41D
         bjow==
X-Forwarded-Encrypted: i=1; AJvYcCXpC/SnQHu7lt8SesHQ75ho7JPk1QXDeVyuDWSQbo48f8fDq5z6K7xVNBAU8xU2WC1ewDy4g+5vRbpbQE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+SE2BwGvsg+85wd907fo+vNRgylYU1RokGTt7d+XuhZQJMvY
	brp/Ia6AHaJVwesr3Bow5QlR5ulaRAHR7/OasqF7KEU8Oc1cv5Lq7B6ABf5OwEczvgiWU7Sk9/5
	JLBwXBw==
X-Google-Smtp-Source: AGHT+IHSLcx2FbFw92aCVE51awsTSRArhdzaa9CLJzwE77OrgMK6NHBiBJW/QdJrdMrrMLKc0figVP0Nh8E=
X-Received: from pjbsv7.prod.google.com ([2002:a17:90b:5387:b0:33b:51fe:1a7e])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d90:b0:2b7:e136:1f07
 with SMTP id adf61e73a8af0-32da7e23a9amr27740290637.0.1760387656845; Mon, 13
 Oct 2025 13:34:16 -0700 (PDT)
Date: Mon, 13 Oct 2025 20:33:25 +0000
In-Reply-To: <20251013203331.398517-1-jthies@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251013203331.398517-1-jthies@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251013203331.398517-2-jthies@google.com>
Subject: [PATCH v4 1/3] dt-bindings: chrome: Add cros-ec-ucsi compatibility to
 typec binding
From: Jameson Thies <jthies@google.com>
To: dmitry.baryshkov@oss.qualcomm.com, akuchynski@chromium.org, 
	abhishekpandit@chromium.org, krzk+dt@kernel.org, robh@kernel.org, 
	bleung@chromium.org, heikki.krogerus@linux.intel.com, ukaszb@chromium.org, 
	tzungbi@kernel.org
Cc: devicetree@vger.kernel.org, chrome-platform@lists.linux.dev, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jameson Thies <jthies@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chrome OS devices with discrete power delivery controllers (PDCs) allow
the host to read port status and control port behavior through a USB
Type-C Connector System Software (UCSI) interface with the embedded
controller (EC). This uses a separate interface driver than other
Chrome OS devices with a Type-C port manager in the EC FW. Those use
a host command interface supported by cros-ec-typec. Add a cros-ec-ucsi
compatibility string to the existing cros-ec-typec binding.

Additionally, update maintainer list to reflect cros-ec-ucsi and
cros-ec-typec driver maintainers.

Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/chrome/google,cros-ec-typec.yaml | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.=
yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
index 9f9816fbecbc..fd1a459879bd 100644
--- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
+++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
@@ -8,17 +8,28 @@ title: Google Chrome OS EC(Embedded Controller) Type C po=
rt driver.
=20
 maintainers:
   - Benson Leung <bleung@chromium.org>
-  - Prashant Malani <pmalani@chromium.org>
+  - Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
+  - Andrei Kuchynski <akuchynski@chromium.org>
+  - =C5=81ukasz Bartosik <ukaszb@chromium.org>
+  - Jameson Thies <jthies@google.com>
=20
 description:
   Chrome OS devices have an Embedded Controller(EC) which has access to
   Type C port state. This node is intended to allow the host to read and
-  control the Type C ports. The node for this device should be under a
-  cros-ec node like google,cros-ec-spi.
+  control the Type C ports. This binding is compatible with both the
+  cros-ec-typec and cros-ec-ucsi drivers. The cros-ec-typec driver
+  supports the host command interface used by the Chrome OS EC with a
+  built-in Type-C port manager and external Type-C Port Controller
+  (TCPC). The cros-ec-ucsi driver supports the USB Type-C Connector
+  System Software (UCSI) interface used by the Chrome OS EC when the
+  platform has a separate power delivery controller (PDC). The node for
+  this device should be under a cros-ec node like google,cros-ec-spi.
=20
 properties:
   compatible:
-    const: google,cros-ec-typec
+    enum:
+      - google,cros-ec-typec
+      - google,cros-ec-ucsi
=20
   '#address-cells':
     const: 1
--=20
2.51.0.858.gf9c4a03a3a-goog


