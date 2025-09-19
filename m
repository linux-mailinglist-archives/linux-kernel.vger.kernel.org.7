Return-Path: <linux-kernel+bounces-824219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F47B886B3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95CB31C866A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606972F7AA1;
	Fri, 19 Sep 2025 08:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="IoBTP1iA"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186AC1FBEB9
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270570; cv=none; b=EZxI2GMPBu8KqZVkrau+FXeDDvqAgUY8K1Ksy7Q9xtAynr2jl0G12sD20qN+x3n4M83G/Zf6jujIoq+jA9AZn5nIkzVcsjO5EPcuaKMTCaT6dfhtGAHeD/DOeVuZHo5f7s5SB0V0F288WAIjoBzmnd51JWm4GvTbKOh7CwcWNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270570; c=relaxed/simple;
	bh=5GZQAzsBDxmBoNDVxpMz9GYzaZl8SmM/riDG9Ea6u6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9fZTX/q/5FBzBTC40s8RRIGgDUMz2itNhj4HA5Rxm+jy+OHpetHR1VrZRYzpOvuNU0URpvlK36i6rDdVjOS427D66FSOz0kBa5D6FT7r9l8ty9lRc/ZJRLm68FMV4TjWEs1uUAuwkZbLTBa7oDd9m0O4w2b9CesWy/bkMBkxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=IoBTP1iA; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee12807d97so1360718f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758270567; x=1758875367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+b+SS9EcCBpWrJSOsjaxJ+vMRqJ6poQmZkbdSM8xRQ=;
        b=IoBTP1iAZOMUpE++BvJgAFpzWI3TeqV6rCK2CMYkdmHN8e9978L8/wUGQVmdyJxpvA
         YV80apV6BdhI/uofL1hs6XlHW2HnDDcTCDx1wf+7YPj6h+uKRNBRxdQyE4gna5gm3ec5
         zhlqpALUJsXDxaMyVVD5Y3ADBWb6Mp8oB3Pkdt9hSqk4xnvJOJ8gzqQAUSh7LghwsSxK
         oIOtCuGMhKAqq2mT7jXb85d+Ju5shl52wobATtWy/f8M/nZqu62GhRVPgDFzJ6wQ8jeF
         UCs1EdFU7BiInCJjE9pwxjrENWHZGb5zWyh52RZnk/WV5bi3l4ECmHGb+DBZHFgKKz8+
         eEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270567; x=1758875367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+b+SS9EcCBpWrJSOsjaxJ+vMRqJ6poQmZkbdSM8xRQ=;
        b=YmVLQIfmUpQ6zM8wtc+iS4oGvFHhkWUlbk+psTD25L/L/BJWj+ziwA5NBBLogQkUab
         S4WGFVG7glJvudVCJAoS47529BeuJxl+/U/De676cujz+WV6jVBQr5TB6tTzXMbi6CJR
         igkcuhI+NC0ZvRrY8YpGg4lnH7Dfe7M2oCJ4wCcMN6V0GhnrGXYS8RtIFT/UkpvC2dZb
         ywElIwY7aBhr0nMzv1lDpaf0G/2ElVMrp/v+p1gWOLVVMKBPalTX6b3gVSk3truAzpOJ
         fu6HanjBUg2PPJVQ+3m92JnvwisnIcUcIfbO4pWGr6UITyinjoCV0lAVPbV2nRb2YCdS
         9WbA==
X-Forwarded-Encrypted: i=1; AJvYcCVzxB3GYgyfju9+LPXON+67mCmf36mU3da2O8F6BkyOjCfdlxCTysRjwO8Ihk9zvlNr2jP45ndB+PT9dQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YybJwCspfq5AnbyCSTv9c85SEylczC6H4/orR+McQWwEcBF/ado
	qRxHiNgIohJVNucy6zUKdZWC3hCKBZZO0oaEjs/wSV1G8CGEbdhWrTNfUA6R7RG/mwf9Q41j0sf
	qQHeiI/M=
X-Gm-Gg: ASbGncuLHnr21f8Tk0qaN9E9TR7UOkpCgs6kB2XWtykvCMHPreRYLziNdznr10Z6DAQ
	uuVBeDNuXSEeiHsa/t5oDebtx/BwpOBwyYEZoB9AGQnXjFsihfxoO/ZiTfQgPFXLEEbCCbrh5Lx
	zzHvlkK3zxxFt9C51gJ7wj1N4KtcgXgaUNdK3E5UN3VDpTxdgvXbtHEO+U47uMIp5k9buLoYSGb
	JtKRAjHBbcU8dXs+SvuhaiP+p4qY3FKM9u8FGF7gd9RbRBOL4TmBMShwu5LYZkVdQtR0miSVmDV
	L0VlGcuQ8yaQWSezdgzbZM1dwulV1z4OwKbp6zOOR7/vVYPEewHPcJST3PcrvYhXPOLP8uWIe9o
	QEthZNtnVyNMfLQXkrrNlZQtJAjn4MKAXX+rFK+U/I9E8c5ItVqAc7U0rEZA=
X-Google-Smtp-Source: AGHT+IGr6/NZ65WWph91+bm6NKBVnrRuG5VH7akG1kGp6hji/8XJIT/htWHf6blvAVKGFcC3VsZm/A==
X-Received: by 2002:a05:6000:178a:b0:3e9:d54:19a0 with SMTP id ffacd0b85a97d-3ee87f90c16mr1595319f8f.57.1758270567304;
        Fri, 19 Sep 2025 01:29:27 -0700 (PDT)
Received: from fedora (cpe-109-60-83-189.zg3.cable.xnet.hr. [109.60.83.189])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3ee0740841dsm6771286f8f.23.2025.09.19.01.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 01:29:26 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	steen.hegelund@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com
Cc: luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/2] dt-bindings: reset: microchip: Add LAN969x support
Date: Fri, 19 Sep 2025 10:28:38 +0200
Message-ID: <20250919082919.19864-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x also uses the Microchip reset driver, it reuses the LAN966x
support so use a fallback compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Use a fallback compatible

 .../devicetree/bindings/reset/microchip,rst.yaml      | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
index f2da0693b05a..12a3b04fc8ed 100644
--- a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
+++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
@@ -20,9 +20,14 @@ properties:
     pattern: "^reset-controller@[0-9a-f]+$"
 
   compatible:
-    enum:
-      - microchip,sparx5-switch-reset
-      - microchip,lan966x-switch-reset
+    oneOf:
+      - enum:
+        - microchip,sparx5-switch-reset
+        - microchip,lan966x-switch-reset
+      - items:
+        - enum:
+          - microchip,lan9691-switch-reset
+        - const: microchip,lan966x-switch-reset
 
   reg:
     items:
-- 
2.51.0


