Return-Path: <linux-kernel+bounces-765836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B91F7B23EF3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 05:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3358563B93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3EB271441;
	Wed, 13 Aug 2025 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="SV2nulce"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F0270EBF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755055318; cv=none; b=ss2n/+4VFqwNa3g/9b834kOOVN69NDcMO5h2JJoenl0pQK/1AZxJ3oj7IjPfPJYXVP1ZnFAwPaowpRmj/XUJ5w1oApvdO9GdRbxB1ygHhF5nJv6cILAyOr3yCZc5m80NRK2ShwCLFwzkNo7S1JzPM2/pcpO7efN7BSpSRhi/hR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755055318; c=relaxed/simple;
	bh=QXvZG2q1wYALZ9ywXDBmZP2Lg7TZImln+AWgStp7op4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ov2hs6Fi7KEc0jZTtNKLO4JUwfiw/F+z+kbJoGJCS5tRlNLWKZzYPm7ZcSVwRxEVNi9THtnOCfaoEgoQJp+JAWOx7k6UOZltS7oNEMY0kEf6syvn3IiyJxHtJp9Rec6zfUyDnDCH7w7r+RAE9w4DEBrERgYwVKaT4nd0eXNPKnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=SV2nulce; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e3f449fa6fso57677645ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755055314; x=1755660114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PZh5F0QX3EknECzCmYMfb9xtWVRUzlviyKurejiq7Q4=;
        b=SV2nulcekr4iGfgGD+3qXbM6ug2yWC72pb40cukyk5eOgrIsNQjd0/gGkEhAD4Xv0+
         vumXzHbnlvPcDkYHPcpFfRps7t3ZRz+qCqD1YhT98c+lPyxHt6zEHeB6wuuTiKpiHhJT
         7h3yjcozIIgeX8inKnAyWuEv0m+eriG0aKfQyxw8VV4xYfbkxokSwlkpk+HziurupHA1
         BR11teaqM0BAS3ht8xRgjendAwue6lrW5n+JuQJL+s9fbbcBzX4YTkjQ05ergHAt582m
         NOPsF0g7FY2kfwkhYUqcxupw7M85sf6RUl54aFaP1/j+mZLoW1zkGeDJCdXRZWi00Ve9
         2KTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755055314; x=1755660114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZh5F0QX3EknECzCmYMfb9xtWVRUzlviyKurejiq7Q4=;
        b=RJhucrfQ0Ex5tmMri1V7yrTuC/2o+zOKnbljCMA3wxCt8xNWthubgU80IebLlTsgFx
         4u3E/bmxbMEnznTLoPwA1F9Iysa0vSYeTrInmcCEbchY5tpCHgXbmTysNlLuzwpBLzg8
         rGLm24JQ8hCqyLGLZmO2LBl9Lfk8tPIaYpNS0shpTGvDpMQzEup3rsKyymN5TRLIZFZW
         kJldsB19J43GMi56XRE9k0ZIn/ox7g17aUNjlSlv3x0xM2SLBR8CGGma7kQy5cVdAuM1
         +46xCIEG6azztk1mlQnVe9DIZb7XE8mA1rvoF7fv8s7hTzvZiygiRT++8Pj8bhVEGg4P
         youw==
X-Forwarded-Encrypted: i=1; AJvYcCWaVggS7QIldbfaFu09F30a8s2cEBDzL28fPBWXeMN5ojYz8vEi0xFhlGwqKXIRnBVRgVjK2mXUlzoay0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIOFWmUqpBWOfA3GZF6X7LHYwujHNSlg8EqggZTFJJx82Jqv7
	Pt+dDG8joWga9PlYWjj5phEFLIxF2Gz0A2cjpo0X+YkWGfyRvdEk96tYzBaucDHcCbg=
X-Gm-Gg: ASbGnctM9GjFoKkOSoLUwm58z1p2TJF5EUkK+HrM0D2OpiTQ6tmdH67VPxjSAIHtWrx
	xaaUHh1r4d34OeVfHp1Vb2BHH6XUcdUFcSvNxnW7skju7ZeYPHJrYuLg91S16crFDHpVD/8LP6X
	dx1KUTtYXhXHfMgHl+cIVRf7hZNbz8y3bAq4AMbOmZHsxXSm6pt/Jot1Uoz469IFieoDuiSVvfA
	mI3LZIkQfNxwH21lghxAqIU8uTuOmRRNnwQOY9slnK4hTMXWT71s/2s0tpHi+JbpbHudW8zB/sZ
	N5S2+veyWppJEBB1Whxkved6UP9fnC9Y0+Fi1zfc6HStHYnSGAHNkUnjg1oc00VUJqi7MYaUWLU
	VTNGSNanXDw+/wQqdDq43O0F5lOzrabpoHQZD94Btb7My/8Tx/zbBHxolpzHGZptO7g==
X-Google-Smtp-Source: AGHT+IEGjkB4ovYyLSKxeQ7O4Oh8jWvGVbE2gJKsffKwKHW4yl0n/kstE9uKuxUw+5W4Y4U9OyRJLQ==
X-Received: by 2002:a05:6e02:17ca:b0:3e5:4c7d:b799 with SMTP id e9e14a558f8ab-3e5674713f6mr23473385ab.13.1755055314466;
        Tue, 12 Aug 2025 20:21:54 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9cee258sm3453085173.99.2025.08.12.20.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 20:21:54 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: dlan@gentoo.org,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH] dt-bindings: serial: 8250: move a constraint
Date: Tue, 12 Aug 2025 22:21:50 -0500
Message-ID: <20250813032151.2330616-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A block that required a "spacemit,k1-uart" compatible node to
specify two clocks was placed in the wrong spot in the binding.
Conor Dooley pointed out it belongs earlier in the file, as part
of the initial "allOf".

Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
Reported-by: Conor Dooley <conor@kernel.org>
Closes: https://lore.kernel.org/lkml/20250729-reshuffle-contented-e6def76b540b@spud/
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../devicetree/bindings/serial/8250.yaml      | 46 +++++++++----------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index e46bee8d25bf0..f59c0b37e8ebb 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -48,7 +48,6 @@ allOf:
       oneOf:
         - required: [ clock-frequency ]
         - required: [ clocks ]
-
   - if:
       properties:
         compatible:
@@ -66,6 +65,28 @@ allOf:
           items:
             - const: core
             - const: bus
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - spacemit,k1-uart
+              - nxp,lpc1850-uart
+    then:
+      required:
+        - clocks
+        - clock-names
+      properties:
+        clocks:
+          minItems: 2
+        clock-names:
+          minItems: 2
+    else:
+      properties:
+        clocks:
+          maxItems: 1
+        clock-names:
+          maxItems: 1
 
 properties:
   compatible:
@@ -264,29 +285,6 @@ required:
   - reg
   - interrupts
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - spacemit,k1-uart
-          - nxp,lpc1850-uart
-then:
-  required:
-    - clocks
-    - clock-names
-  properties:
-    clocks:
-      minItems: 2
-    clock-names:
-      minItems: 2
-else:
-  properties:
-    clocks:
-      maxItems: 1
-    clock-names:
-      maxItems: 1
-
 unevaluatedProperties: false
 
 examples:

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.48.1


