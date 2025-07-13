Return-Path: <linux-kernel+bounces-729054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBAAB03123
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97C37AD388
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BEF278779;
	Sun, 13 Jul 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKP27u1d"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984357464;
	Sun, 13 Jul 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752413303; cv=none; b=GAGKnHobV6yrl38+8YrFfCsR7VgNZa5y1sUZnAcfyIv+GTUt8ZPs5FFXiL2UbB2oeK7kBmfXFKx1ztmaeEhZzjh7X1YytybLDrMMICZ0CymdLyjmMIKBosm4UN+oiHRMFbHYVsMckPCVURSEaDkEdK+DA3VbbrOgly4DmmmeS10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752413303; c=relaxed/simple;
	bh=1a3LShyOJLFrkGYDCOQ3bEAtoIgGE8npT434+VJo3l8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g7hueEE5eCU2tpbTG5i1TV4OrP28x7arPL0j9yHN9ljWDMShRX/JRKjzVz9UIE2upDcoXr6/KcYzmeMY5VL3BoEpQZis5xA5VgUtkdpmf6i72CeD18VgTZyNA4f9WSc2aGuFMBclzemW/88GtP4xBcsHPX2Gn3Q68RgL6u27sEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKP27u1d; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a575a988f9so1991841f8f.0;
        Sun, 13 Jul 2025 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752413299; x=1753018099; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VaDhpruGzyBKIl+96KmB7UZrakWcIwfKbPxghFfeQnw=;
        b=JKP27u1dzXp8hIih8Z+TpdKvDuO/nZBFBtkoE0OxdxGSemghyyVnf/tzjtU7lRSmFv
         mxMubh6XWL1Kt2xuDtAkrYwQQJyTFum7JrHK67VXvKxzmYZ6q72STJwi761aT8dglRTS
         7lLM3wN1+Ve/waTr3Uoqjg43dAHJy4y0zbQfkjNdaLrZ1470O+AxyzupE/VFb9q5ainO
         QIhgrpHn2d+6eAGFaVxtwOkSw/XX+CTxyyGP5uZOYmtbHrfkF4wlgUGqHGLULmgkeyqH
         5xMCBtkY57OSFLIXYh/YJsEt7kiIrywYxx1ylbsL5wKVbVWxWS9tLRC9DBupRiwoL1Kd
         +iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752413299; x=1753018099;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VaDhpruGzyBKIl+96KmB7UZrakWcIwfKbPxghFfeQnw=;
        b=nMDYr2nrlVX7jX9bzEeKqvcn/5Ka3woXE9OrQ4VljKK3KqAAjfWDpiU1VN2JDxqigM
         C/R6wLGyuFGjc19meKLBoiHaUFWAR+JE5n63yM3iM1DYCn7N2sJFP06BncZwG/i6YtOW
         VMts4bkROCykFOHNcfbiy1i/1pHLca5Clnhx88HIyKO89gE9HqcixEsSxdwad1ukOiS4
         3xjwyujsPSRUq78Use/px0uRSVyUJfbzLQVNtnlGQwEvNcQQoYbFMJmt8+lhHBe13qMR
         BRLppgRXyBORIWCy/+FCmtNp9HACTGKbZxVnxs6u4faQAOR8yPXP2pnT6n0Kiz7PU/Tm
         gZzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGvd6Ni1mLeP1LfDKD+MRvNvkqkZ7N0CPJhNs92UtIoUGEgLyW6mZX8xAHqYLA1gkxgTmipgviqzMRQPM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy53u8Gbui9ocTjvexMszOM1GzPKp9QlBNg36tdgJaIJd+MNHTm
	SJgTFwzdoP9DV4DIAsYYZwYKsqghrPED408+ceusHVmk/8JKzLsn11Li
X-Gm-Gg: ASbGncvXGKy7CXHPF7k8Ys66YU5OAo1RBE0mYf2g3vGxcp1muV3cvAtNI9NgezL53NN
	qJ/FhMH6rppSj5qFMkjtr80GqOGODwJMkodIznglJzGeGh3eNPq4dRACDAjUDv0PxCsilPEmRpe
	3IJzRZbp0iOlr2+/sFVpyYXbJUenFMPeJIuIU6cNOE8uTnaqSBvYtlg47KAHAn6S7NTdz3Wb3rg
	L/Og6upBvT2RoFiIO9l6ymZYaKo1s6h4cHiVcKT1zoARRc4YDBx7GSwrI/2WKSYJmWdOJBdAtIt
	POFIcwJ4jdU8D9xiXqSq6AYIWO0kg3ro38ZAIEWJmtP1sepqguyEujQXLKJ5gkWW9+GRgPlhL+D
	yr8VJVuIUM9EdnAnMglJqpEEftwv4fQrI
X-Google-Smtp-Source: AGHT+IEb82Sb0pRwWgTx1F6OqGVNlsLz2nBGkO/sgHqx0xurUJK84Sk0nksT2BL2PzLKJl3uGHhARA==
X-Received: by 2002:a5d:648c:0:b0:3a6:d604:a017 with SMTP id ffacd0b85a97d-3b5f1890d17mr7238434f8f.24.1752413298673;
        Sun, 13 Jul 2025 06:28:18 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8bd1741sm9917933f8f.18.2025.07.13.06.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 06:28:18 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Subject: [PATCH 0/3] STi device-tree cleanup
Date: Sun, 13 Jul 2025 15:27:27 +0200
Message-Id: <20250713-sti-rework-v1-0-6716a09e538d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD+0c2gC/03M0QrCIBTG8VcZ5zrjaNNYV71H7EKd2w61OXRYM
 Xz3bBB0+f/g+20QXSAX4VJtEFyiSH4uwQ8V2FHPg2PUlQaBQmKNnMWVWHBPH+7MIDZScn1SwkI
 5LMH19NqxW1t6pLj68N7tJL7rj1H/TBIMWceN4r3Bc1Or6zBpehytn6DNOX8A7qr4j6QAAAA=
X-Change-ID: 20250401-sti-rework-b009551a362c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Alain Volmat <avolmat@me.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1377; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=1a3LShyOJLFrkGYDCOQ3bEAtoIgGE8npT434+VJo3l8=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBoc7RppZRgvTFRUNu14QfN57tb2+/jkTn1NBfeI
 D62xzH5O7eJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaHO0aQAKCRDnIYpo1BLC
 tQdGD/9OC8WwhZlQhRcLN5Y1LTH/7AWEc5MdVm9P7PJH3xyrDcVde/8o4suEfngdigri3XKekIc
 OGBAlASxOdk8JiLDfqsHsIhxFBsu9q5XfUV8J+QdC7ukQi9sYxcx6ar721/gC4c0HcE1zL5iT/J
 3uAnXa0jQldxPK1Ql5iy4GoSKQXc0lOPOUf02QT+ceC9wcjzs5FnLGfC3cxs1S1kXFEl0rRzFDO
 dC8U/LAx8EnRC5zZGcpROfAr+/acadbLEVPX2X+YuZPQATZtBFQ+C9Wp8CyVAe+EKehjJzlh2c8
 PmrlZ7JM8Rn55UaXh+M+5bH2K/PXg7RQ4P5bJQnFae5vKNGQcb5eyuhyZhMfR+5wkBL1hvoRT9g
 iDgZitJEUs0JyO/M2KeZkTUv5GnfxUhuROrWVEyk1HIFnmSMrct8Z5k6xcALLKTlg3CoswuU4Xn
 RXK3XwbWapL+JdDazouB5AOdpGfYfMSmX7bkqvTd0zMRZ6ORD7mTAziyzRz4lIeKhiA09Ft0HN7
 KOwrhi/JzDtFMxaq1bcnJAE3s7tjNdOPzSDK4bkVSfYGdxXzorO+WK3GS1AvXuyDg0gRqSlq5kA
 lbGkrfrG8HkIA2+qRHduE0cEN7axcjSaKRvuT+UeRC0+c5BpxiSsiGQn+bjdYOoPBDHrVZAXzph
 GpVC4Leg49e983Q==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

This serie aims to cleanup and rework the STi device-tree.

STiH415/STIh416 SoCs are not supported anymore and B2120 boards are
internal boards.  Update the documentation and drop the related DT
files.

Patch [4/6] has already been sent by Alain several months ago, but got
no response [1].

[1] https://lore.kernel.org/all/20230416185939.18497-1-avolmat@me.com

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Alain Volmat (1):
      ARM: sti: removal of stih415/stih416 related entries

Raphael Gallais-Pou (2):
      dt-bindings: arm: sti: drop B2120 board support
      ARM: sti: drop B2120 board support

 Documentation/devicetree/bindings/arm/sti.yaml |   4 -
 arch/arm/boot/dts/st/Makefile                  |   2 -
 arch/arm/boot/dts/st/stih407-b2120.dts         |  27 ----
 arch/arm/boot/dts/st/stih407.dtsi              | 145 -----------------
 arch/arm/boot/dts/st/stih410-b2120.dts         |  66 --------
 arch/arm/boot/dts/st/stihxxx-b2120.dtsi        | 206 -------------------------
 arch/arm/mach-sti/Kconfig                      |  20 +--
 arch/arm/mach-sti/board-dt.c                   |   2 -
 8 files changed, 1 insertion(+), 471 deletions(-)
---
base-commit: a6cfa4c8833944f8912c1fa7f95795753f6376ea
change-id: 20250401-sti-rework-b009551a362c

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


