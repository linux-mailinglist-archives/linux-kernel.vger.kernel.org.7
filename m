Return-Path: <linux-kernel+bounces-729083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6957FB03173
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 16:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B996A17C6C5
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 14:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48AD279335;
	Sun, 13 Jul 2025 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TILh+Iw9"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806DA22F76E;
	Sun, 13 Jul 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752416706; cv=none; b=lVjbKThKUJ9VUU3WLqSyek0huheSF2Ldl+WoXX/8E/iuD+WikOyt+ZhN3h6w+WNGcDfk/fae34g28JiNkRCIbG4YdulsKkq3FqZSL+KnWi1WBwdGJcF0xJiFjydi4Wd4ZZfF/YLVnjTVuvdz1pmAn2BelR6Wp7pUs2bDxZ98Zu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752416706; c=relaxed/simple;
	bh=ctVrSe8+tqBPZfPNjWKQjuJ1XNUtgiycE7rUXQUI7/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFNlQH+I0u5iuuXXshlTWzbUD2V6e3R5fgUFdhwkLThlCDvaYZkvhGWFm2dMzXM7Nl7JE/aPaKU8nfEr0unHlU8UYuu27tYev9bg6wnBjTW3smgBcu943y1MJM1tzLsty8n+sUO/9uULLaG4/QIo2X7lIryaMvokIy0T+VuPkJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TILh+Iw9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4530921461aso22390335e9.0;
        Sun, 13 Jul 2025 07:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752416703; x=1753021503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kEQpD8b+HNVuLM3WhWFj3Mc99doFv2oNkxwhtYpkyNA=;
        b=TILh+Iw9nLWsS+o6P1wyxlKTRrdeRCA0OZH8WA5nXw8mrJaMGWpiTWZYczOd4VNutu
         qQZCUMLVeElPfUSPNXU6aBvN5zLP7cjWr+bYCLZox7z/3cOkP54r47uLqN4nCv93oiHN
         G1fI1H4PQup0qGWchF+Meqj1p86tvwGASG150g35Fozj75aSiJmQYluOqLLscIQVF55P
         4R78l4IoMXNH1yXY5JMNbRUOG2J9USLrd69NW4j0FvplP4BXEwYMjXLg0v+HDC+l6eor
         rsCd1kLcZs2Fr34s6FdPc76SfgU2EyXvi7Qy+uRO5B8EeP45Rx4tllXgFkwCSAvzux60
         cNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752416703; x=1753021503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEQpD8b+HNVuLM3WhWFj3Mc99doFv2oNkxwhtYpkyNA=;
        b=tO+mzGxEVtjtVvTjLuzRWIQf3l/HB7gJzFCT8r3PwBMT9xSuWOd1mKK5YHcu472vMb
         T334VcQynlwFazQBiroVgQXhKYIhtzzrEyw0dqgGfq2mKVK91CbuSCzwI89OikruQzsL
         6xrjzjo6U6w3zuZlCgyMVXbQtp3s9ssNZEUttEq4bPSMyFDM/XtQVKa6rICRICvsO5S8
         vDxdjeSIUnFlAGnOZEuLGGqcupLpi93jV5PGSTecolZKsgceIScIglutiDAXE/KezeZy
         +l7dFGsDVJ3JU5JtpWYAAe/xW1iCJPksz/VsJ1VkvKjk+Ob7+n5++h3pGYdz2AYIdwbE
         1qlg==
X-Forwarded-Encrypted: i=1; AJvYcCVAGWzxIn2ectKxhDRBLcuL3FxzTWCpK1UtpzV8YjejGDOZel4D5Mn+yoULIM+7mbj/9PI3bOQ0RSSJF8TA@vger.kernel.org, AJvYcCVJnhYABab89WSLk0MiTKQ7jSrPTDUxVq8n2vWliJrqXcx4UEMjxtFMqTTo/XYLbyLAlPYwHrnIfvBv@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmcE8anKlZ6k3qqLQM+dazw8OEBEFkYJG/mgJiwzzBasK1Xcv
	ylAYVSdEmBjEBXmRLg83HBGj+HC9lV8cw6acRCHEBhqI0IUKGDbRMDLJ
X-Gm-Gg: ASbGncs2nkZZtahF70iIDnguI2dt5i7xOeUbI7sTzivgCex4RurjvEj1mo/WNBW3X5U
	TkPm/ejCxcUjSnF1xi701mzMMpvDxTs+aKP2KTzyce5+oEl1oC3J0Nwyv+brJSucR6+X37J7D44
	+q5r/WeqHizxZlf1thfGPCGfWoQk/ODPtMgi+jLSCZTxUjF7LoYotBo3zkytUg2t6fxzSL6wVGo
	gaVjnxxPnW2Kv10us1KLGEwvC+ZMFGFnbtYjgfGEczTawqN/CW6vgrbJD8L25eCv42VKa9501N2
	W9aXecpeHwA9qb0gMAVfK3+WZZ514MTEloKkCbODfDGolGHRjO12+TAFZwnauOFFLyBwhHbyUEh
	wDiekva1rM04d1d3qVxJKNw==
X-Google-Smtp-Source: AGHT+IFrp/gF77QA5ekrhLRIDgGIcIeqfrGrvFNzk/J2w71kdPsQ+3QAHabP11bj4+Q72q5OjRK7lQ==
X-Received: by 2002:a05:6000:144b:b0:3b2:ef53:5818 with SMTP id ffacd0b85a97d-3b5f351e561mr7575693f8f.5.1752416702720;
        Sun, 13 Jul 2025 07:25:02 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8e1e1a5sm9714490f8f.74.2025.07.13.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 07:25:02 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sti: rename SATA phy-names
Date: Sun, 13 Jul 2025 16:24:24 +0200
Message-ID: <20250713142424.41236-1-rgallaispou@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stick to the documentation and rename both SATA phy-names properties to
what is expected.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 arch/arm/boot/dts/st/stih407-family.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/st/stih407-family.dtsi b/arch/arm/boot/dts/st/stih407-family.dtsi
index 35a55aef7f4b..3e6a0542e3ae 100644
--- a/arch/arm/boot/dts/st/stih407-family.dtsi
+++ b/arch/arm/boot/dts/st/stih407-family.dtsi
@@ -669,7 +669,7 @@ sata0: sata@9b20000 {
 			interrupt-names = "hostc";
 
 			phys = <&phy_port0 PHY_TYPE_SATA>;
-			phy-names = "ahci_phy";
+			phy-names = "sata-phy";
 
 			resets = <&powerdown STIH407_SATA0_POWERDOWN>,
 				 <&softreset STIH407_SATA0_SOFTRESET>,
@@ -692,7 +692,7 @@ sata1: sata@9b28000 {
 			interrupt-names = "hostc";
 
 			phys = <&phy_port1 PHY_TYPE_SATA>;
-			phy-names = "ahci_phy";
+			phy-names = "sata-phy";
 
 			resets = <&powerdown STIH407_SATA1_POWERDOWN>,
 				 <&softreset STIH407_SATA1_SOFTRESET>,
-- 
2.50.1


