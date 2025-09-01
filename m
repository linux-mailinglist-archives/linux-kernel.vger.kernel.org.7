Return-Path: <linux-kernel+bounces-794427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0D8B3E198
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762C2442F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99192253F9;
	Mon,  1 Sep 2025 11:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HtyNGc34"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2D7274B27
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726248; cv=none; b=kLoV+1A+v2KUeRfjbBH1LqURGOp+LJfcvLaytyLu8ISk1RLkdfieIPPspnNlBEzV1D6yab7PZz75kf0lDBKX98UjJV7oo9KzMFAXIWzFt6qy0G6KEEnLh1Ry830vZ3bR2X0+KDbMCMzJGE+QC4a9AMKh9xJBaodiBEJd7SMc3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726248; c=relaxed/simple;
	bh=yf12NUbJlr5zt2ZgNH1/MSY3Qsy4n7BrLp67JFo7aRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PSmFriaWcmFKsFqgpd7dAPi87G97Y2OGyP2JnAOK/dnXlhOfCT6sYn5eGBBTEoI3aDN/jWHfgdKEZ4nnO3pOx5EpOrMS6FSoUT0bNMe3EJWRdc6VtjutJsu5WBeqGEyLHjz+F3CHj4Z0e/S7fxYJ8KYRdlJTV+nsvH7Fn54A2l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HtyNGc34; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-77251d7cca6so882430b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 04:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756726246; x=1757331046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PM7ZOBxbXaYL3polB/sK+4dHFDAVqr3gYjlAgyAuBEQ=;
        b=HtyNGc34lfRkRr/tORTmeMuXXHDRBPeFaRcqPaJFjhmGRLYBehIVFIXq3stI2a3ntu
         KtEnvWO5S5smqz3q3wuP7O61fnd3Cx6DHYGw2qj+P8RVZqja7o6VNivwpUehXH4cpoRW
         zaP1hABovQyGLGRZ4P3F2b0Qzs3yrLChGSyCF4dkn3PucZWo0kpakt3GSUlYplAlpJC6
         9S1X4LXQKvAm3sI2mdwvNJb8adZzMfG49wrBy+FRyckVIztnBR8WNKmzEU5UMsWhzAll
         z+8Ca0toymNW1cI6XkGe0H0XKji/gsoRsXPNL3ZusagOqDD7ooGk6Ps9SA5plh0UeyQn
         4Ocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756726246; x=1757331046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PM7ZOBxbXaYL3polB/sK+4dHFDAVqr3gYjlAgyAuBEQ=;
        b=wCgm9LBcACu53jf5E6ABHU8REOC0m82yvM70a5t8cX8j0S05LOFoIlgXVDTI/7Pt6v
         8x5ItC7owI7A6EEWYPMHovIjnOGWbA+XWRZpfPsR3kTptssLD0YrO5qiBMxFucKwDE29
         6TkIt34+dcQM3bQOuIKtGRJpjVUdNQAN36SHBSzJ749y+UQqjugrCyI5iTQLzaEB08o2
         njl7bS2B0lHdzR3KWLlowhkavDiUwFFhNRH35RTZjzDZGLRf0Dt/nM2YWSRbFx1yfzNv
         pJbH5FLw8AbEbUBGAuppo/BN6cbtSbfQsExCF0bH3AGrPc/18QYDopCCzm+MRfJyfPEa
         uiCg==
X-Forwarded-Encrypted: i=1; AJvYcCW+J2Lz3oPhXqwln6ZMqJVb7JSOnwK+ciCwj2kn6PqaMeYY3sEepvlcY2IdlvpqP3ZvlF9NGNHAdcjiErA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqktpZKiaGCuv0RwCqVEl+f7lJ7O2eeSA9iqQvVawSBCSIsXUW
	YHTKEyZSUtGj5Z29JHSkHtAA9TIfghqSe7mnZSR1e3Ly/zmw54TpT0G+nsLpEXQPJ3E=
X-Gm-Gg: ASbGnctqtC/aAMdd9GMuYucoal1MV1xlJRovlDLSmWbr0391P3BD4KQRSnBcdaejAxA
	6mHTIsB3TLGrl375Z7gPUqEoCXYov2r8MfHCQEnD4f6sGmOLfysxYhgGSYXCE1pDl9yivLd4K5Q
	rn07X9jhjbSoXqEhVtZIBuGPf9CkrODr43lLyQN6HDh0LKq7++FTaAVZaS/sMOSr4qpUUOkNzh0
	y0swhVW0upu5q7caTsW/Riyjyr470HBZDSnipAQ6pYr1ALuAZBGh74zTWRrsMX9c8t9LDCtyVsi
	w8bHB+531Rbc5gOzIefwpl1bNp0K4GNnuA17sikS04Bod4ZpczJNiH/nfP0XEAqanFeMSTI8zPL
	HKJZaK+iTr5G344KBTb+1K2W2VyeubT89AS5sQ2n1tMkre3lWTMnJQrCzHaJN5S04kS1jz59ArS
	UE+4M8S8PgcgvZ1ujR1HXeofWd0ArVyXV6DMquPRBIpECFVoOXmHWAiV/rvLMIyLfQ
X-Google-Smtp-Source: AGHT+IHvewUVfv5QStAVuopdslXVnLmKdfTffBO/yLK1Zcu3D+UIlnEHf0YO2HWkB4oXA6WwHzKOog==
X-Received: by 2002:a05:6a21:3396:b0:243:c217:512e with SMTP id adf61e73a8af0-243d6dd1431mr10269229637.7.1756726245635;
        Mon, 01 Sep 2025 04:30:45 -0700 (PDT)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725ad1e9afsm2911441b3a.11.2025.09.01.04.30.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Sep 2025 04:30:45 -0700 (PDT)
From: Xu Lu <luxu.kernel@bytedance.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	ajones@ventanamicro.com,
	brs@rivosinc.com
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	apw@canonical.com,
	joe@perches.com,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [PATCH 2/4] dt-bindings: riscv: Add Zalasr ISA extension description
Date: Mon,  1 Sep 2025 19:30:20 +0800
Message-Id: <20250901113022.3812-3-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250901113022.3812-1-luxu.kernel@bytedance.com>
References: <20250901113022.3812-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add description for the Zalasr ISA extension

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index ede6a58ccf534..6b8c21807a2da 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -248,6 +248,11 @@ properties:
             ratified at commit e87412e621f1 ("integrate Zaamo and Zalrsc text
             (#1304)") of the unprivileged ISA specification.
 
+        - const: zalasr
+          description: |
+            The standard Zalasr extension for load-acquire/store-release as frozen
+            at commit 194f0094 ("Version 0.9 for freeze") of riscv-zalasr.
+
         - const: zawrs
           description: |
             The Zawrs extension for entering a low-power state or for trapping
-- 
2.20.1


