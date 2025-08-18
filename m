Return-Path: <linux-kernel+bounces-772813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE5B297C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D1B3A16B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108B3262FD8;
	Mon, 18 Aug 2025 04:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="L7yecv++"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CC026158B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490276; cv=none; b=WNAtEt5P0ALH4ptSLnOZVlch4Wx6T1jP9XWue8Dly3qrpS4wVmvp+KWC9JDa6SRjVjtrCxkY/hfRhO8NZPISwGd0LTGPevUtD1MbKK6baaxPim7/3SsomFR2mrKNAoK3gc1CvIi9jZzC3Fp8okcZet4YEUJ9R/J+1TzYDJoNl/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490276; c=relaxed/simple;
	bh=dNnAUr+2trSDmCnQ7YgS/ZuDyO2yPRTU4DJLikPf2R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xy99iygjGjRXTe0wrEyR11Sz7WIbKG29vCLL5ZY4qbxsKDiHwIBj6Rhp83vSwRVpPykU1hnB2Xcc9bunY9c5QYZTeI4tzfiuzSM4BJWd4E7YPPf9zgKrS6IVaGkbhRsXLXfi9u1rB3FRXeYn4MOkSTyEDtwTtM6il/gqhxsbZKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=L7yecv++; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e4f2e4c40so1308605b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 21:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490274; x=1756095074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+ejybDVQT/aGz6Lcll3wkVRKaiK+174ISdzaVIOfkE=;
        b=L7yecv++YfTdiQH3LP8sXJz/zFgqIUvFc3RdS+eMbyZXCedJnF/iQFTlcKlAYwckxx
         CHUHCiwOYtO2cBlRIQle7Yt+7hoPtJnaVnanl+cd50qn/YOjve7upvXbJ/sMR+fRJ+HI
         tT7UqT2HCRtvewhktbRzGHvMHUk/F0o/oDGL1nP5vJqE3eiF4yKxfk935Jj5PxvZMofa
         wgztZwZ5A/R5WsoyHjL7n2DQrKchQGCCCRMBduQtNxKR6xf9nw50U+wo0w4gDnONTg0a
         eqAo7fAic2YcFG/SO0YYHEKpLJuZFWpTvwfr7fnhgmkTE6qx+3LW4t1NEtpSvI3JYQ9a
         vH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490274; x=1756095074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+ejybDVQT/aGz6Lcll3wkVRKaiK+174ISdzaVIOfkE=;
        b=NqlfETfqzYjCXwz5vWTtjPL1L+mNd7+Ea9PTt7c0ALuHSE9nSBblVhX5sGpPAuDP5O
         fu50srOFIECnM+pyY/KUfWnmhjtQRJBAhlYlZsDgvg6QlO7qr7iSmjArbiMw+OJnZwIW
         0xvYKQo3GsddpbEJuNfhhrkmK8lPodZy5s3mj8il9/1rlWyf3FcRdHl5cP/6nXQAlDTi
         Lnz1FAtd48QBjCqhViqNFYYwaiqbnCH2YdBzwXviYaB1vcwDDJCCkZBW0QLC0lQxhie0
         9P6e+EWL3Pvd9DoCsVmXO6DUbScdGKlrORjoSO5wk5/NDaFzRZ8gULpUjJerPbsXpJeZ
         umBw==
X-Forwarded-Encrypted: i=1; AJvYcCWyzO5tIDC5fEMcl4QgMXY4XpFswJna/fTk3GkSI0PLBTlyR8BpdSSXhuiA9QHsEFpViyxPDyNpZ26BGrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCScy/I0fVwpr7zct9pzIhZFfTzl0Y1oRjCf7kfL9bBV9RqcG
	iC4dGt5GLP0t8m0Jyk6gJxGla0W2gLmpMS4d+vb+w7G60Iln3G5L7Progj+WJjSIJUo=
X-Gm-Gg: ASbGncucnPlgLb2/WUwiZGVh5sf0fIL/FcukWNm5fPTYov3mUiymF+ZTOxxNxeX56Hu
	i1niHuXNN/LYF/KoyZ8XT22MrqWX3tJY4wHrEHt0OVk7QJ3ay5qDEzHAHq3+9CnQINZSRm11v9s
	nduxGJiMcfXE6pKIIJYlpp6fhz2IJtQ4TwWj8KhSO6W+6Rj3YZnwOerZgxuQlGsYacw5OEWuckU
	muWu6xodezKTMH7l14mNVMAl7yuctTbm/HowopYsgK7HqTVUR8P6vzFr9F/8oa1lwTppipuPb8R
	bX4Qfljpjnrjie3SghWRuprW0l/QswGT9v0ge0pMjnxz/J8d/np6B8RoQlU09RiItBtbYPfdGWE
	gTzmjypCAihPL3UEkEHOdenkag0msc/fYnQlqoFcoOcCE6g/z+LeluQ==
X-Google-Smtp-Source: AGHT+IEUmCBJqt58NVIHDPHHca9PR8O5TrOG4aqKnEqH28bGTGwWCZIcGW0W6/qShoAW7F8CGp1xoA==
X-Received: by 2002:a05:6a20:9183:b0:23d:9dd0:b2ce with SMTP id adf61e73a8af0-240d2f668bfmr14194804637.44.1755490273971;
        Sun, 17 Aug 2025 21:11:13 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:11:13 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v10 08/24] dt-bindings: clock: Add RPMI clock service message proxy bindings
Date: Mon, 18 Aug 2025 09:39:04 +0530
Message-ID: <20250818040920.272664-9-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818040920.272664-1-apatel@ventanamicro.com>
References: <20250818040920.272664-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the RPMI clock service group based
message proxy implemented by the SBI implementation (machine mode
firmware or hypervisor).

The RPMI clock service group is defined by the RISC-V platform
management interface (RPMI) specification.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../bindings/clock/riscv,rpmi-mpxy-clock.yaml | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml b/Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
new file mode 100644
index 000000000000..76f2a1b3d30d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/riscv,rpmi-mpxy-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V RPMI clock service group based message proxy
+
+maintainers:
+  - Anup Patel <anup@brainfault.org>
+
+description: |
+  The RISC-V Platform Management Interface (RPMI) [1] defines a
+  messaging protocol which is modular and extensible. The supervisor
+  software can send/receive RPMI messages via SBI MPXY extension [2]
+  or some dedicated supervisor-mode RPMI transport.
+
+  The RPMI specification [1] defines clock service group for accessing
+  system clocks managed by a platform microcontroller. The SBI implementation
+  (machine mode firmware or hypervisor) can implement an SBI MPXY channel
+  to allow RPMI clock service group access to the supervisor software.
+
+  ===========================================
+  References
+  ===========================================
+
+  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-rpmi/releases
+
+  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
+      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
+
+properties:
+  compatible:
+    description:
+      Intended for use by the SBI implementation.
+    const: riscv,rpmi-mpxy-clock
+
+  mboxes:
+    maxItems: 1
+    description:
+      Mailbox channel of the underlying RPMI transport.
+
+  riscv,sbi-mpxy-channel-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The SBI MPXY channel id to be used for providing RPMI access to
+      the supervisor software.
+
+required:
+  - compatible
+  - mboxes
+  - riscv,sbi-mpxy-channel-id
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-service {
+        compatible = "riscv,rpmi-mpxy-clock";
+        mboxes = <&rpmi_shmem_mbox 0x8>;
+        riscv,sbi-mpxy-channel-id = <0x1000>;
+    };
+...
-- 
2.43.0


