Return-Path: <linux-kernel+bounces-801612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39735B44793
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600C2A4783F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2F32820D5;
	Thu,  4 Sep 2025 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKwADUHL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CD9283FE0;
	Thu,  4 Sep 2025 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757018512; cv=none; b=IqUvfkifgPaZxicCbiAFnxmfv+H+QmGePh9ugNeXal1ch7Jqu/DHwHMQdqZGiYaOYHYpHcNrCX/tAvjvEWDYSoQCVxZa8G4nYjA+9g3wTCWoqDT6LCspE9GtNVpxSrO8KPsY8u+yv+J3gLOj9bQS34LrYnySvnVYXHj3n58miaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757018512; c=relaxed/simple;
	bh=cpIiOlznt8sZKfQDmwpFVIZ0b/IXFuqamad14tuawyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p0WI2Kmb5XOen7qhuSgBcv1mfnXX8qmLIAFAmWPbHomePkgTzgAG9LHCmJoUwyCTpw4bBT17aKybX1N5T+n+Y/2S50KcmI8C7HAAbZtUjszuPfiTJAygOXclGX6o/e272MztxhgzSTgsufspeqZ/BDarYD7O7Y3uljIPRNHeeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKwADUHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CA06C4CEF0;
	Thu,  4 Sep 2025 20:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757018512;
	bh=cpIiOlznt8sZKfQDmwpFVIZ0b/IXFuqamad14tuawyQ=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=sKwADUHLo3ks9friZqtdLMkmO2KiOGoMGDaEe4LIUtx9wmrlG4stt8+rnZhUZriyd
	 KgJjgTRqW03EOlkle82OmL6O6FmskNIYZVfExH+1TfJ4MwUx8qia0t4O+tt1RHr6yS
	 OqCWD7zkGpMYSJT21xFz0qEFJbdcONI76Re5e8BxGfs0asSIHH/7SLIVo+TVrI1p0U
	 Q6RHuyLUrv4beI03rah/RyI+B9nJVWacVLRjdnukl+dSnqR+0Jw73r9IBk/JMqq/zL
	 o3/2iaIgVfFGWTLvrMAsZCLNljYlmKEOJl6WeYc51lUgLKJU97gQJ4n258RpmQcV+u
	 zH7HslZBMFssA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A78CA1002;
	Thu,  4 Sep 2025 20:41:52 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 04 Sep 2025 22:41:44 +0200
Subject: [PATCH v2] dt-bindings: extcon: linux,extcon-usb-gpio: GPIO must
 be provided
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-yaml-extcon-usb-gpio-v2-1-a5c4afa496c3@ixit.cz>
X-B4-Tracking: v=1; b=H4sIAIf5uWgC/4WNQQ6CMBBFr0Jm7ZgypFVceQ/DgtYRJlFK2kpAw
 t2tXMD81fvJf3+FyEE4wqVYIfAkUfyQgQ4FuL4dOka5ZwZSpFVFNS7t64k8J+cHfEeL3SgeSZf
 WGE1E5xPk6Rj4IfOuvTWZe4nJh2V/mcpf+0c4lZhTK1Mb1lWr7FVmSUf3gWbbti8mkUwKtgAAA
 A==
X-Change-ID: 20250329-yaml-extcon-usb-gpio-251b66522287
To: MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=38o5l+Gd5d4+Zkxmiu4BB0zsyw4fWa9j1Br5WQIrDCY=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBoufmPMszQV/vhPettuncRzuRf3JM93viHJZSlO
 o6rS08QHdyJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaLn5jwAKCRBgAj/E00kg
 ct8MD/sEYLadRUK+M64Y8KLwkwKTy+Cw9A8/l5d/rXwyGH+cMl5XxV66eS6NPBPHHjXlhIxFfVX
 uw4gYIfxETbo8A+SvddLtij4awSMqKnj9S/7R0VmwtMSyPlKjp7gxZL5a160E02PVXHykLeHFiA
 My0jE/FHguyArG+RVy9lZAw3K6o8mYpe89v1aRJb5vNUYnw5DTgPPHMgk2jv7H1e9vj4WDqSK3B
 y+98ZNzuheG4RCx4k1bbkCVXYHs5gepo5J5UYXZJpYTK5mOKBnkXioIscdm8lXPNALAKThpMtan
 MfcKNylmdcEu9kh6sNcNpGmfGL0o+uE1S+aiS7SXuEr2Cm9A/zBWg9ahEE0QVdPR7tRzTxf8f0e
 zCWmmG5CEfzqUPdF7dT8qHzAPi4b5NuXvxtXcMGqv8YJLBiN5BOkqw2vEkQxdNz5OGUt2ZdKP0U
 s2+ptBOz4ulFhU21vznXRE14GPiEmGPYBpDtmjhjw6r2PV7n5Vs9MFKLxP3xKApkiWeXxRWZ1Jk
 FWbloHF2NR1e7oSyPTteBwpRwJJ0v+AyP+cjKSfmU7u0A4sKMIO5BqrF9IMkJlDej3bfwnGadJ+
 oawdsy12rsiKa2vH6Yb/VKxTRw7ZDCgx4tlrDpQPL/jXM4CQTI8++EDFFBQ4N0c75IB+X7mwcDr
 /3Zt8iIocpxv7yQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

Without providing either ID or VBUS GPIO the driver is not able to operate.
Original text binding says:
  "Either one of id-gpio or vbus-gpio must be present."

Fixes: 79a31ce03f41 ("dt-bindings: extcon: convert extcon-usb-gpio.txt to yaml format")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
Changes in v2:
- Rebased and added Conor A-b.
- Link to v1: https://lore.kernel.org/r/20250329-yaml-extcon-usb-gpio-v1-1-190696e53a0b@ixit.cz
---
 Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml b/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
index 8856107bdd33b8654812ab9c97e85e23dc2ef75a..8f29d333602b95fe5ccd8464aa64e2d1f0c1c781 100644
--- a/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
+++ b/Documentation/devicetree/bindings/extcon/linux,extcon-usb-gpio.yaml
@@ -25,6 +25,12 @@ properties:
 required:
   - compatible
 
+anyOf:
+  - required:
+      - id-gpios
+  - required:
+      - vbus-gpios
+
 additionalProperties: false
 
 examples:

---
base-commit: 4ac65880ebca1b68495bd8704263b26c050ac010
change-id: 20250329-yaml-extcon-usb-gpio-251b66522287

Best regards,
-- 
David Heidelberg <david@ixit.cz>



