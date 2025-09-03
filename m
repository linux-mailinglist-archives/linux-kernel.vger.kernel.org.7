Return-Path: <linux-kernel+bounces-798234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68213B41AF2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 12:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210283A4E7D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E60F2D7DE1;
	Wed,  3 Sep 2025 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="eD1cM3jH"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270911D54E3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893717; cv=none; b=PxhEESTnjxMBqJbG1tACNN9hjoGac0EswN0a5eK6HsqLXHdtFahvpBlHD+fxYx3H4etRLmbknWoW7bNFE4laXOTweFuJ0C42yH6thunA1BT5FM3bHlLBaUIcp7Qmrw1KK1HyMpcOJ3/zqex98vGw2Hmt7Zh+qwtxV5V7M1EkhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893717; c=relaxed/simple;
	bh=kHulDodA6XjjDXaF8f3RTdeG+b7HsT9DN9fR8XCqMLU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ppHKlPwv+oTpVxvbrLeZ5eKinZzTK7APy/gOwUh3PSs1qIG8vJlGBmUPvec5P3A0xzRBuJ4xqmrXvrX3QAz/OHql/y5fntlmAcf8hgIEolK02EvO2HM8CtZp7c3qbjf5dz8rx1j7pkMZbyNjbdrRkUNVp/3mNPEterd4XNAM+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=eD1cM3jH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3df726ecff3so161098f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 03:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1756893712; x=1757498512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ9qYB7I/+26Ck84iyosBQZh4d5xKjRCMcgtP0AqugE=;
        b=eD1cM3jHmhyyUQHGCI0l0yLMSM15MBoT9JvOWeMLaN/2Fxks8AYctLv0eRLW2hhLyx
         pClPrVdZs5nc8fg4LxDpG6JjlbkG2ZLV6pk2QoQEC2QffzfTpqMy0Fbv8LIYlP/F0iFR
         IdiMH+v6PIwM95jRMCBVS68Xs0JpTRLV7QKuKKFNNK28lNbHG47Uey9YXDYn0CoJWkbN
         aGANAcK/Nq9LBOxOnzOvOfS5Z9RhFcx4qkPIeoA0W37CZ/MKceJ7GbsledamJLKR04JD
         D+pAX/38JX8SJkmwSvIe9k6s8GH9x2k+jVqr0fhOiyMuQ767Vt0rO4ZA8w5MYZOAbxsg
         3tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756893712; x=1757498512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJ9qYB7I/+26Ck84iyosBQZh4d5xKjRCMcgtP0AqugE=;
        b=ODKMn+Q61r5JruVfun1/NQitSASUrV6JOawGt2x7z3taUQgJyjW8c5Yej3K8klScGZ
         LH4ZISKo04r77sqiDi/zLI7AE9367icdEoktgLK8713LPofRpNstmTxS44k0MOkdpCpX
         GKCc5ezq1eMrGnZ3wK8S2Kc81JGkwTU1HcnFIFL0QnbCZAKqfWQUWgBTHPRWe6LOGYmK
         yEHzkwDn4l5Vhnv9vSOaz46/O1nME53LgKG+GausNx1e1eZLvhPqDgg/CHyrjfGGIStz
         rj2hLfB4e/GNXVpicm/tqFcBoFIs5AkjYsVRBxytmH6tC4Tx/UUYP01fMjcJF54hhuuJ
         0CFg==
X-Forwarded-Encrypted: i=1; AJvYcCWqb0BbRdUIuozRxAuueGLHP9G4sM1PXuTEA8GN8L1vtFfNTkWrMw1OFEbxLOHdIi4NAqlywTFflRYTOh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCeZUg7TU1CHR2q2DBTlihNnuKkkeIno0BT29O0iHCAr20UQus
	xSTCKeWeLuEM96wIWhwxHYXhX1/tgEBqStfZFIII9BARIzmIbyNK7GKkQwM6xbMP+d0=
X-Gm-Gg: ASbGncs70QenX4UDWmEX/BmMDW5lbx1WnJy8HCip8MEi3w3+9pui6ZFdPw392q3UHSE
	GpzGlvroYLoPjmzIFZUA9jcAHO8pbrQVczXNqeg25YNp/A2DBTtO/ClnpZ0r+ffldVyIJdEIUgR
	jVeigamAj0eSqnOHL2ejar2hOxpFZ4yyay3P5AGo74f+HPBZvaEBwTYMpS+Xn8HARRVMZVqGp2F
	+wdKj9BPPcbWNFZ/jXHHHrIOVRNPy7Ke1fDf+qv1z7iVsYYN+id1Hm6xRV67kfie0pFMInYBdhV
	080OI9rU8AynMPaXAVNYaVY8mEX9Ii0OMG/zZLRDGSk86wkXVsDFoolIfPChq1qRkdoYsq1D4uv
	VeXMzvVjjmFydp4GZDgIx8SZxLORMtK+G116vBCbymAmNl4Bi
X-Google-Smtp-Source: AGHT+IFlZq5oArcxA6dWnPr6LijEjpa+jLN9n3zA6K+uDuCGQ1hNKxqSyhK3P1G01ko5LeH0BDMpxg==
X-Received: by 2002:a05:6000:26c5:b0:3c8:29eb:732e with SMTP id ffacd0b85a97d-3d1df539ea3mr11440863f8f.59.1756893712086;
        Wed, 03 Sep 2025 03:01:52 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:7e45:593:64fd:6612])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d729a96912sm10945323f8f.8.2025.09.03.03.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 03:01:51 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: linus.walleij@linaro.org,
	dlan@gentoo.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH] pinctrl: spacemit: fix typo in PRI_TDI pin name
Date: Wed,  3 Sep 2025 12:01:04 +0200
Message-ID: <20250903100104.360637-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The datasheet lists this signal as PRI_TDI, not PRI_DTI.
Fix the pin name to match the documentation and JTAG naming
convention (TDI = Test Data In).

Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
---
 drivers/pinctrl/spacemit/pinctrl-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
index 9996b1c4a07e..a3f433b611f7 100644
--- a/drivers/pinctrl/spacemit/pinctrl-k1.c
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -847,7 +847,7 @@ static const struct pinctrl_pin_desc k1_pin_desc[] = {
 	PINCTRL_PIN(67, "GPIO_67"),
 	PINCTRL_PIN(68, "GPIO_68"),
 	PINCTRL_PIN(69, "GPIO_69"),
-	PINCTRL_PIN(70, "GPIO_70/PRI_DTI"),
+	PINCTRL_PIN(70, "GPIO_70/PRI_TDI"),
 	PINCTRL_PIN(71, "GPIO_71/PRI_TMS"),
 	PINCTRL_PIN(72, "GPIO_72/PRI_TCK"),
 	PINCTRL_PIN(73, "GPIO_73/PRI_TDO"),
-- 
2.43.0


