Return-Path: <linux-kernel+bounces-853002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3AABDA691
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16E9A353823
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3091D301487;
	Tue, 14 Oct 2025 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy7RYE11"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FFF2C0F64
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456006; cv=none; b=P+fvbWgCskZNTvp0t1ps9tVHyOV06q8b7lTpp0KOZN+lbbaVjhyVdNtBGBe63tZarA9cjsLy/EnDZ9PcI5fzKtkvYrsZwkvWBc6xzlPaqMx4x5X8c2KzVv3KtmQcxd8n8lB97Lm822WUyLZ4BWKDZ4FvYjnrdZBG8z4DA4e0XBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456006; c=relaxed/simple;
	bh=bC1GV6kIreezKVVT4Oj9oFgXpMI9X56TUHGj+xw7qV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLNHXf6M6otwZ/isiJipVfidpSG9R0W6qUBBloIfBig0LE6bq5Jxaca21NB/YnmANUoj+Ilosz7WwSGaYI8CbMXtxz1l4yhTDclQlXhT+/j46bI41719FPL++L2GN8uog9dCXzX62Gji+cB45UuuMr9frdtZSQQ2M1i4Q7wyvDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy7RYE11; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-28832ad6f64so61556505ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760456004; x=1761060804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NOTwbs4p+L2U1fW4J3vWVmcZdnxexOHlXg5+8IeB40E=;
        b=Cy7RYE11xqevbUkst+jpjJ+H+fH+gYdUvBUn5JA5wrNx3wzbIe7uEVC4pNUd4o4eEF
         2KdKw03AzluaUcE64JHg20ZsOZhM3y7vS8dvqqX5TtF8n+UQ4YKQY7THbnOOVw+rFGXb
         a5MoS3J3Ik/uiFJkzXW3C6kz+Cbpu5n6Mkz5xes4gHQ2gsPO80XIhfQGORpeuzrZBnlp
         kgwLF3nbSY5sa23vvDk6GwBYDbkBtn64Iz2K8Tyq6dPgSzGP4vgBg6uVx+NIIQJZYI77
         gAug+Kr5NtEaAWf57oEyX35uGbVLQ4q2q9Vid6A0hzpyw32p+r7L2gqHhgQe8pkT9Wv/
         xsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760456004; x=1761060804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOTwbs4p+L2U1fW4J3vWVmcZdnxexOHlXg5+8IeB40E=;
        b=iTodtkDCD3cFx3mIcsw9n7UQHoxMKcuZZL2ILrin0hAksi/DYv17nlkpZ/kYw2Gf32
         wd2Xhsm76jjo0ppXGIkM6Ojs4Wa/ikOLfbBCqoV8+bv5/YHs7TF3FKcJVgOKdXdNhdor
         cx6z1QLQn6hXGCXfyjDuXLA5qXYokObEPknKsFGMJRNZDUXq/LTtbqLf4nLA3tfrSk6L
         7usvM6Q+V/sjL6IDwWhqRkrKOFWM8GHl0kweKHB6xRiu94XtT6R/hbrbnM0PbRsyfKqS
         +41fbIXx16LnUm8CkzuFm5GF+zNoh8edQ9Lt1qeRjhHhQLxgVONCMW/SXkmWgPqcQxr4
         4Bow==
X-Forwarded-Encrypted: i=1; AJvYcCXK+mG/INkBGV3vuRnzG9oQuTkw4Elh7PpDoM/2ig9kN3QC7RuFuMSZWsCoIKgh3QjVbgMzk8mMTynSiYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YziD4TfMljeDpqfYx8AV86cpV7gCzGTG/humu1dJd6ESU8Hju1Y
	lafRz4MK9YYW66U+w5rY7bz9kIirCyxBdHTtM+52ayn7K5rjXDD5sU3lyStD4Q==
X-Gm-Gg: ASbGncsCfMso9ar81HXuR2E2e1EFI97stqK7dx9fAihIRckSHZZ/d/BAEcs6/8ESXgy
	2Dpavh9678zwuvRCjZsfb15cmyLE5t1PKsH9+oz4B9rBO8dnW8SjvZszot+UBmRSots+FKrEHnf
	lCzxvun04codmRjRzWTKQK6wD2W1HRHD/pyAavyKvkW9fyhBQl1NpEzaPG9oAp+1kONW2Tvz31z
	sqH97XbbkqURx4sstjZwqf6sm6cry0yriBju6ZuqO+PwjSiyIyQtA7rXKp462lPw0uFeIMO7DP5
	JIX5eqZRdwFGLSxF1zOts2foAk0S5RSmm/pJigJFBooaMZo73bQ64KtSosK+BC+KqceRBdIem86
	MYSUYiq7kJSoGNJT9zR7X8euD2WHyL0qhemikJLr7z5jMC+cNHpu9keMOpImkLQtgekvFlulBaA
	==
X-Google-Smtp-Source: AGHT+IELj7XESXcNTKFyydH9ysU3D3yEIHHtBESIIuXVyNUNifJ3Hkcupco+7VjAtxuCHL7uYEOCqg==
X-Received: by 2002:a17:902:ef09:b0:27f:1c1a:ee43 with SMTP id d9443c01a7336-290272c2564mr325594625ad.29.1760456004106;
        Tue, 14 Oct 2025 08:33:24 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:6d70:c338:e681:47e3:e797])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36cb1sm166927545ad.100.2025.10.14.08.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:33:23 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: rzt2h-n2h-evk: Add VCC supply for EEPROM
Date: Tue, 14 Oct 2025 16:33:14 +0100
Message-ID: <20251014153314.177300-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The R1EX24016 EEPROM on the RZ/T2H-N2H Evaluation Kit is powered from
the 3.3V rail. Add the regulator phandle for the VCC supply to reflect
this in the device tree and avoid the fallback to the dummy regulator:

    at24 0-0050: supply vcc not found, using dummy regulator

Fixes: 0176c9e82e10 ("arm64: dts: renesas: rzt2h-n2h-evk-common: Enable EEPROM on I2C0")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index ceecf0c30072..a19b2e289aad 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -160,6 +160,7 @@ eeprom: eeprom@50 {
 		compatible = "renesas,r1ex24016", "atmel,24c16";
 		reg = <0x50>;
 		pagesize = <16>;
+		vcc-supply = <&reg_3p3v>;
 	};
 };
 
-- 
2.43.0


