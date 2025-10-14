Return-Path: <linux-kernel+bounces-851787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF25BD7421
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBC504E7D92
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A625A2248AF;
	Tue, 14 Oct 2025 04:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR2Ozy/B"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8BE757EA
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416388; cv=none; b=TkViBjY3xC/mG12xisxgQjCYmSiYbtLuMo8rAfhrapzkfTAp83MPmosmMFSVWPCP/DFXWKqgTWeIIWMaUtIve4Ipv9HpYjq6BRPrCKVJBAHjxxsirYLbgeWcLf6qR95wQY5g68SjKBsXwM6nLuw1e+2kJtNek2daTyXaJ+GhndM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416388; c=relaxed/simple;
	bh=EYTnj0kxKNcuJVZ7pnDXHS1E3libyGhLJqc0GmRPbvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hyJXllw58P5ocChJ8k3VMi66OB5gp322PiwZfWoL+Wn6tLa5VtHdfcVJ1e38YtwUu3+01lf7ipJMO2fnXyCC9OMVo2yW82I7Xrj2pCrOzArYj+dyD+Uio49YkAoL/8kbR/YaHspXPVs5B4fC1cJpWE+KnGhaK57vABp14YrtZ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR2Ozy/B; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2698384978dso34035485ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760416385; x=1761021185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rQQ/XgHke6UIRYqJr5dnidD5VIVkKed8Gfd4008Beis=;
        b=RR2Ozy/BVgpF6vWiL6gldyv4JM1W/Dte+je3RXYTR9NsqHv87WMgdMMPT/8UW5hS6W
         8oISnSBSXaIAt8sSTFuCz2EEb4nqQkm1VrRsVMbU88X5afRdYqWK44lYsXaRddGLmFxa
         rZFxIT6dJz879LndDi11f5iL8HxqwJ2cn0253lyabH+iCT6M9/8Cht8Jm8H/gJEoUS54
         3oAgYjJTXJRlWYPRXGNbFglbLB66NDNpxTe3868Yv9LLxnKPT4isnUyscLFjHllRtjQ4
         LNrNT/E/XK0Z/tqlHsmOms+7yeiEj2d2VBQYtRntTuB5iU8v0nbqcLnV0VwX+Q4JHyqK
         oEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760416385; x=1761021185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rQQ/XgHke6UIRYqJr5dnidD5VIVkKed8Gfd4008Beis=;
        b=C5e99TNXtzsW9u2v02eccPLb4bEoa9BYHWeQl9KgM32726tKdFXWv59jrSubMbofXL
         IQo95+zpOE7RnakVnwMlyi1vUNg/uS4hbw5A5vJ8YBdmc4M3t4XC7SMt1DXKH4U5+n0n
         /Ro2kV13qShj7kJJcV8zAVh37x/gbrWJmnH9+SQz0g7ngCYxMxciJDRQO2iX043hNVup
         kzfcM0W2sGb//ut1BaJ2dkqn0VPygoJ2J1BAfUAhMNqqCJjdpwfGeTIST0qFWkyAAygy
         wqJQxHwkZ4zekw/7IXWVVi9vNSIJ/wDTIR2Y3vbZRj3fk64k/HRpP8bks38izz+cKYQy
         mdSA==
X-Gm-Message-State: AOJu0YxG8U2Yr9sVk7BO0ZkZiY5CtqNVBz5AdIShhaththEcwDsaIEZH
	MUpUWvW4zc2pM0+T0JE/y4eDff1N+OqxGyt18IKAclkVtowovSH6nAelQLbPZT1B
X-Gm-Gg: ASbGncuoQY0yqUFAigwQPkMH2Rk3PdoFxE2x1/+/eppahp+J8srb9l37VFnUN7qHTQx
	4W9JxO1BFukmbJakCZRunGqlI7alJ9QpGOoFBA787j/U/seeeWNpmzdD8G8kWs5owIz+qTYPFkN
	wz3Bsy6AQbS3l163k9VlVBBMnDUTnPVSkjhE0DdVbBe2CpTLGc01Hc0RqUk/bmkSlpU1JhNkhkk
	+0L9WS7s32przUpsYDZuKpjonbygicRrZ6PbzZzV5LN8u5RfUe9ltr2YJyZXJ4r1L3/tdmTUn7h
	hXvYC3NSSnowmh52P0vqMFPbZ7DalDHRPk+35+xN7tyAVHGhjQCorAROZ+Epvu2wJ3MbeLvT4nF
	ebCm4hgF8QvuoZ2/6K6PGkBC9yaZTsDEDa1oYsTMtIm/VlZo=
X-Google-Smtp-Source: AGHT+IH4BvUP9O6RcYyUlCrTnZYsXll8exqEGJhYncW0pXMtPsIDEpTJHqhK1/cvfPtVQ6xk8QZDLw==
X-Received: by 2002:a17:903:3c2c:b0:270:b6d5:f001 with SMTP id d9443c01a7336-2902723faa2mr269612035ad.23.1760416384821;
        Mon, 13 Oct 2025 21:33:04 -0700 (PDT)
Received: from archlinux ([177.9.216.59])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-290766cc2a1sm15962505ad.95.2025.10.13.21.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 21:33:04 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v1] mfd: max77705: support revision 0x2
Date: Tue, 14 Oct 2025 00:32:55 -0400
Message-ID: <20251014043255.176499-1-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Revision 0x2 has been tested on the r0q (Galaxy S22) board.

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 drivers/mfd/max77705.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
index e1a9bfd65856..5201a4c9c3f5 100644
--- a/drivers/mfd/max77705.c
+++ b/drivers/mfd/max77705.c
@@ -105,8 +105,8 @@ static int max77705_i2c_probe(struct i2c_client *i2c)
 		return -ENODEV;
 
 	pmic_rev = pmic_rev_value & MAX77705_REVISION_MASK;
-	if (pmic_rev != MAX77705_PASS3)
-		return dev_err_probe(dev, -ENODEV, "Rev.0x%x is not tested\n", pmic_rev);
+	if (pmic_rev == MAX77705_PASS1)
+		return dev_err_probe(dev, -ENODEV, "Rev.0x1 is not tested\n");
 
 	/* Active Discharge Enable */
 	regmap_update_bits(max77705->regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
-- 
2.51.0


