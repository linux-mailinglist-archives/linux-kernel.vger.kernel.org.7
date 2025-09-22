Return-Path: <linux-kernel+bounces-827416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B416CB91B36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B483D7AF0F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4557260D;
	Mon, 22 Sep 2025 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Bsp0jTHa"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D3D1482E8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758551308; cv=none; b=Xq8Z8Ku8oNps2XorTbeAMZBJGgphL8fh0L2IpNel7mUmAb5AHaGgdTGqRsqFTfF+zb4nhEKuBhBCaua9B/2hHgQP482QJpxiQe/UiTL6idaiDf/12YZa0f0mTQoW2PmJBxcAJ+uOCXL+6F8tGlHhElEusrhcWahrjZvoPkAQAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758551308; c=relaxed/simple;
	bh=SvK7btLYRO//NEuSLQunuo6sNLbgIRPNMFVxPrxcILk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NvATL+TAMnZ+EOjoYAN2aioIweT8LsxrbUvRz+SWYIUbv4vI8gfhVfs7ARXBr/YYlJvR7OEE0h+jkfILFwY7N0pjAB4K1YZGxgiPD9WjtrSgago8XwMMe1Z/tqpyr2s4UBmB4ovuNkPZT4rWMamzyTiL/p8Wzr66aHNySsDurl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Bsp0jTHa; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ea5c1a18acfso4203829276.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758551305; x=1759156105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ix+hu5NanbKuv9VZhmjhSAP9/8kt7Tc9p5wZOTLERrA=;
        b=Bsp0jTHaxGxDMrKSTjsbYpDejdQIFz04VtbQgqxENNU/UtnTV7/CmZX3xqs+i5zUcx
         Hr+U5lWkE/gVYqezmiH8Pj08uREP5zwecu4DiYFkVSW+t0DYoloA1IxjuQn/gjycGoWh
         3EyWENvOv6zlDbrY8Wz3vsAc5kanRlPTZRLyOPYckWfzYeFNbS1ei0ut2gtS8kD18RT3
         eTYptX2YYDH9Wo2JBgKyeakKm3UVHoIDAsyo1VmUkGWoK4VrI1NPXgK+VOwUgufaxdZ2
         X9h19XEDjg1XThRRYwGixfJrg+UOXxpy/osb//IK8+BZicE2sKT6wuPLO1omCv0an3/w
         GTQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758551305; x=1759156105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ix+hu5NanbKuv9VZhmjhSAP9/8kt7Tc9p5wZOTLERrA=;
        b=Yif9I2bjYp39pFH2eQdkHT1Qst9gsRhP6zDVBWG6CH/FCEISBxbU2waW7GyBLfywsV
         xZm8q6CSOnNXB0pzuXo+rhVXIMrf7dBm+ObXyn1LoXYH1QpA8w/JwBJae63lBMUZm26R
         E0sHOMZa4uZ2CRZe89xCEnUePH1yc1CahQTkT+G/wtkJ2ZpJYamfFGQdVke5/312qFZ8
         cS6LsjY9gsGGn8OkwoEVI04j0cvwspjHC9H7OtjX3en0EMz+L2aAqiOzAIqAvAlBADV2
         S6K42GqzRC54to8xDiD0d0gsYsrYH/CvzmEO5GzmYxt/dD5H0hKHhckYx6QpMBbGj73Q
         KUVg==
X-Forwarded-Encrypted: i=1; AJvYcCXmi6e/fdwl5DVSQsHzGHA02ZgGkW1KczUvMqsF8vNNuBdH5iMtORSOrNNOXD/wB5tuEJWyV2Dlzlqs9XU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHLHxOdum+FBvJiKhkJm5/xMw3Hkeo8ZY4SMFXD5OprVWDTte
	jCM1bm5by5wh28g0chAM8hXyPkkyUceBl7SQJLOZChATHXAsmdW1Qf2B3Cxb/VwiV9U=
X-Gm-Gg: ASbGncvpJd3l0rtZWI5tcnojUnHyMUEryXd/Tdg+o/+7COfEwhxTcMsSDMTJQeayuzk
	v/kFmox1mSlbzSgplb3Mh9oKo2MQt+s/nsfya8wvW6eGs15wblSZLiFUMTjA620/ADhuylmqcVJ
	BrUYfJFdz0awTvWe4W276yhp9VQxaT+nWiJu0KxkoT/C8Zp/CU2yNayIHWkRBIn1qaHUX0MkTXz
	T1B/hgSdsdrQ6CHbJv0UfrRIuZ2BvW6cLoSGyBkq1raxbJfelfoGHXpHS+fV6BG7E+SijXmGJH2
	Kzvf7A0P0zJyV2H/y0mDyHBO9gSLgAaZQXS2/m9K4HZDDv128aSscQg9RRgDZb5DgOWtF6J6a4U
	4h69PlCnQkTIKCc+iUIDGU1RGEL9u6xIUPp8CpoMKIzWuaOF5PrFZUQ==
X-Google-Smtp-Source: AGHT+IHgHNnGSIkqfxadXFSwLUGIDeGN7fzklQfcWRZ5+8r/Qi0U+5pV4roKHuT4HCHEmzJ79dd0zA==
X-Received: by 2002:a05:6902:f84:b0:eaa:251a:a4ab with SMTP id 3f1490d57ef6-eaa251aa597mr8087710276.40.1758551304769;
        Mon, 22 Sep 2025 07:28:24 -0700 (PDT)
Received: from fedora (d-zg1-232.globalnet.hr. [213.149.36.246])
        by smtp.googlemail.com with ESMTPSA id 3f1490d57ef6-ea5ce709efdsm4163124276.1.2025.09.22.07.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 07:28:24 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	steen.hegelund@microchip.com,
	lars.povlsen@microchip.com,
	daniel.machon@microchip.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 1/2] dt-bindings: reset: microchip: Add LAN969x support
Date: Mon, 22 Sep 2025 16:27:28 +0200
Message-ID: <20250922142813.221586-1-robert.marko@sartura.hr>
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
Changes in v3:
* Fix compatible indentation

Changes in v2:
* Use a fallback compatible

 .../devicetree/bindings/reset/microchip,rst.yaml      | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/microchip,rst.yaml b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
index f2da0693b05a..e190e526f3e9 100644
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
+          - microchip,sparx5-switch-reset
+          - microchip,lan966x-switch-reset
+      - items:
+          - enum:
+              - microchip,lan9691-switch-reset
+          - const: microchip,lan966x-switch-reset
 
   reg:
     items:
-- 
2.51.0


