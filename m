Return-Path: <linux-kernel+bounces-818131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D78DDB58D0E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCF054E2912
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC6C271440;
	Tue, 16 Sep 2025 04:48:13 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79EC2264CC;
	Tue, 16 Sep 2025 04:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998092; cv=none; b=QcO1da64JAB+vkMYVreiTTnXc1U6wsmGW1nyLVnuhXsI+SLjTqFOtK1YpWqMqT2Kw9mEdlzDhQido+Vqy7iUPQO/ScUXizB3CkC3knNYnUGTJbhIjJowwNZsIjJNJxoxSvUh+XvBLOKzYVljOhqK1hoT8+6MDdElmfeWflm6Fuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998092; c=relaxed/simple;
	bh=FikTdHbARslOMXaNtF6u+zS0UJ9mF9rwmNlsmyp2nP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJe7A+hqyFRStqXozXNYdHhKCG1u9cQD9PuZ6G68I1hi0wJy8PJcNH38PoJqClq8X56FPTBCth2E92zZ+O9fJ179sE322HWN6PDx4tUMrKb6UONtbYm/p3j+F/e4DRDXThKM4v1/0OLo2uPVLPAVXvprsZZujR/5OYc0jDgyWQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=linux.spacemit.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
X-QQ-mid: zesmtpgz8t1757998027t3daf7947
X-QQ-Originating-IP: NALeAlte21wPHxCUBj++gmWQyej3z6JOa9Gny73qSqg=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Sep 2025 12:47:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7322592050402130920
X-QQ-CSender: troy.mitchell@linux.spacemit.com
Sender: troy.mitchell@linux.spacemit.com
From: Troy Mitchell <troy.mitchell@linux.dev>
Date: Tue, 16 Sep 2025 12:46:45 +0800
Subject: [PATCH 2/3] dt-bindings: Add CTF2301 devicetree bindings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250916-ctl2301-v1-2-97e7c84f2c47@linux.dev>
References: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
In-Reply-To: <20250916-ctl2301-v1-0-97e7c84f2c47@linux.dev>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jean Delvare <jdelvare@suse.com>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Troy Mitchell <troy.mitchell@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757998019; l=1949;
 i=troy.mitchell@linux.dev; s=20250710; h=from:subject:message-id;
 bh=FikTdHbARslOMXaNtF6u+zS0UJ9mF9rwmNlsmyp2nP4=;
 b=MMks3fobJ3Pan85HomKALaTeIDffs9z6gX8VJd8OHGaZdtV6XyaYpx2lgMMTZCegIJfgMSiu1
 x2pdFiU94BSBT29FPRZJZRlISMvxqH8IJCc+4cj6wuFrH/ZXkXrqPhA
X-Developer-Key: i=troy.mitchell@linux.dev; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NnkkWlQCMz5PDVUh9XbqwAuLIuTnbIU6hXjjsmgUAKwUR11IcCKw/nfv
	5dfH5HlXSQMu1Qe9Tdsl9vR9ruCbYXU8nYj9/H4Smn9C9Q1qKyE9uEo1hqNQKx5s1StYZVk
	PLtNaaGEBzfHC+jsKLAr+zW3ChHcGBP0an3IByAUuS+ctQnAeoMXIzoxCaa9YTbIQal/6xw
	KbMOBwa2jBunaQIQuRHuLNr8Za/zyuqOkgJ3unSe16xYmKKcYfgDhgqCofyeCS+YF/nA19J
	VuFXaOR4iCS8WYXmK+eIqGuqbjHJ1QEggtjNRlRJt0HxVgdUrNO0hYXd7gRjlNuHREhxRZz
	gHswZtRVqPwrpTMgy54b1WLknvBVrbEYQ4zvkTsQjmm9qEXdVje9kNk7ddkAamxuuGSbi2U
	UlPnQit+TfVCQDJ73w+xD4HYXnubhfcwUJgsBnnPSMS2o26EcMK+LmgUPpboPxLFagH6Brn
	Nz/s0QAvXd9MgF6mXLCt7Aq5zWF8VJaQ/dFY697gjHCvU2CQmb9pD9Oi+U6DfTC1JoYhhPb
	e0ullA1N12h36qBbXSbFxPbBljTzAfhlRyroc7h9eNX7cCOJJxTt9QKJmctlEP5whYL+llm
	2P+WpND5i+OvuZ7hL5QGlHMuJNF0YiblGSBRIn1VLt2P57c4/lOXuP7+s5AkjCtFjLw0nWC
	G/PccweXRp0W7TEmd3yijayXUv9+kjwDglBAG538OtiXMJykhLOhFNZTh6D5iz9C91xHFyo
	57DFmKG/jQoW7Vh7nEb+0iBFERcPRG8mAuoUHcZKwKdglt1FtuVgswMZyPgCV08HTe5cj1s
	f2aUaL92d6NvbH+F4ZuBsAI+mhFzAqkyql0BQwHajHpVsGXc88KbXMTxo+n92s59lObQI6F
	/JZgCRb8xUerKezDk8lthdp/kvNli59SWKzi9usJ3S2MQHXHDGKQb7KvqQTZyjAsIey9BM0
	5WJE+gMgoz1jL68CCtwMegomFxGUPqfmMPy9uGX9Vn6EwgsmZPwyDzcS4mmOvNDsOI6Vl+a
	MWRk2/BP2HFqa+s4K1m6vhWd3th65HBLI7UC+3TExbVfQM8x0C1IjTG9nMM4wR45eo9+xob
	G+fwC4Rnr3gdayJc0FdUYXorUZwcefTudhoDF2ORW3IxTfzRXB8ASbXCf5C8bp58w==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Add dt-binding for the hwmon driver of Sensylink's CTF2301 chip.

Signed-off-by: Troy Mitchell <troy.mitchell@linux.dev>
---
 .../bindings/hwmon/sensylink,ctf2301.yaml          | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/sensylink,ctf2301.yaml b/Documentation/devicetree/bindings/hwmon/sensylink,ctf2301.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..fe98f5b578320bc1b43ff88f76667990821a88f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/sensylink,ctf2301.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/sensylink,ctf2301.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensylink CTF2301 system-level thermal management solution chip
+
+maintainers:
+  - Troy Mitchell <troy.mitchell@linux.dev>
+
+allOf:
+  - $ref: hwmon-common.yaml#
+
+description: |
+  The CTF2301B is an I2C/SMBus compatible device featuring:
+    - One local temperature sensor with ±0.5°C accuracy and 0.0625°C resolution.
+    - One remote temperature sensor for external diode-connected transistors, offering ±1°C accuracy and 0.125°C resolution (temperature range: -40°C to +125°C).
+    - An integrated PWM fan controller.
+    - A 1-channel fan speed monitor (TACH input) for RPM measurement.
+
+  Datasheets:
+    https://www.sensylink.com/upload/1/net.sensylink.portal/1689557281035.pdf
+
+properties:
+  compatible:
+    const:
+      - sensylink,ctf2301
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ctf2301@4c {
+            compatible = "sensylink,ctf2301";
+            reg = <0x4c>;
+        };
+    };

-- 
2.51.0


