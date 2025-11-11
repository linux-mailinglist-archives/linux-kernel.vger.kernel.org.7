Return-Path: <linux-kernel+bounces-895350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C07C4D8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DF2A34EF74
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E43563FA;
	Tue, 11 Nov 2025 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji6zdWZq"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3243009F8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862464; cv=none; b=r8jhHGLWvQnIVocTYK+DpsvwcUMJq4Hg6+Rn8wvQFbyXV8WzQTcilzKa85+y4ZIRXA9eBdbGPn4tT6Xypw11lsJ0KTy7JQ2bjJqwNB+fHuKLRQeV1nkfDJNmbEq2NEUlqTle3QHX4KSrNpEiEsEMzKXMrEeBapDqViQip6JF88E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862464; c=relaxed/simple;
	bh=3kjI3dq6p7W7F9ddD6xztg6oeYg1W5dCRwLSxcSjN3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qMeS8odC21afGD+QlJ7Lf6or+ZSX9CLuBwl3nlT/bDfMwIkUZ4IzunbBKE0Zu1oTEKy6iR5I9oQ5hyV5spXYhYnLxfikVpAU2XDLjE5NhIgKPJkgJLW3uhjKkAlTg3kY+y6fiQrmAAUQhTNSPmzcLUQXVsYG8sGoteR6e6IdK1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji6zdWZq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640b0639dabso7028884a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 04:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762862461; x=1763467261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c9M3cMyzoNu29tzKfw+UGIVH7zn3E+bc2pWo8lrVlBg=;
        b=Ji6zdWZq5YyxZw+1VdsFmGJO1lkhL39oaALFjYqdbCrFprLWWfOCUhQLoON+51usn7
         6C3Vu4OjJIJ+s3OXTqzjbe4Np8MtohHUEvUgCVosCm07apowYpY1R/ktMeFB5jxQx1/K
         PxfT86D8oagoW0EJuuwAYYY3tQZtVd9aJFx7bAaid2Oua1Nr+jEgpVFfcXBbzLwDb3Fx
         HLDLZsExUJmxkmiHpGrAbRq9khBYAxJBdWwIe8G9Q51BVmeztxfNlBH/RVgzTHxtS2Ub
         Qx/Aq2sXHVfIZmtFy0P6UKQy+UzOGlb1PUQvbFz9fHqe16TNLdCPQa65Bqk2xewYlVaT
         KmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862461; x=1763467261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9M3cMyzoNu29tzKfw+UGIVH7zn3E+bc2pWo8lrVlBg=;
        b=AUJOHyVZBZ6MERvZAdertyg7EhltrL9+c3/PrR6z7NuGfcllCz01txxffMhdf/X07e
         DSXuZzRrJAczZ1rdUUisHNELE1jih4m9ZsesZiYz7pI245sshib6erTHJEhE849PY06h
         UzOm8Ml1NY/nO+GtHLxr0y6B1L9H6VthJ1cPdmxJ/NOK2qCtCu87oI3A6jM/C6KLPsZD
         gg4ggunto0bhDkUsx0ZyWoY8n5LS/OeIrBd+h++UNzkxMy2NSSesTUfL3zP6ZOkwhAJp
         BatEE5CMbGVqhBt3heklBsjbZMp0WJEBglpcsp6gl7QfmUjrSfZztNwv4Il8fUdmTiWU
         sbjg==
X-Forwarded-Encrypted: i=1; AJvYcCUpFrP7CWhuWWhqVDn6uA4c0Rn8jOj5UWnknUPSJb1WcH0JyPrS/zB83WoCYoykkKoQWpvup8PZI6fo8vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNacBV0+IjcAR6wjENfP709vN7idLXNZ/YaI7B7IdYkhcYu5wf
	f59BL7O8yqApqt4ELiBx/r/qor5gmvqFP2BXzjKBfyBh4Sp8x1KzKJnq
X-Gm-Gg: ASbGncvCbv1lK72MUvvPuBf8h9nzloLgpmCyJkLJv9ScHrlmR8AB5uWlJBVkbXMWJyB
	gpFKeILWy6ymZUrAxVeNOQ/LJM4TbONJyUKRWFD09jy5iFr8fa+eAo0hIIwRXoSwxkONLgj3VYE
	b/sQW1SvpXITjH2T7ZToY7zzqaYbch1y+Rc+RvmAaAbysBzN/NaKHeCV2h9lH9Tnb2IzB2tHdy2
	N73Yd7bPelK9kUDVBmyrAR6I/MgQlsCOCZVKoifr6YLlXOU9heGsAsG1wGR+SGh2KHO4E/k6sBy
	CGIj4OBPB3VVmf7l0wyUIasrQzaUDZOswXAd4FnJSetshQ2Zd2dMX7/CssQ3pTwVJdyJM4oYRsv
	/2F1wdoeZ0IMVXsEpOmqTU6JV6057jhLRYSNbux1vM2TTBgf5Bk3XXH+K7v2M9gD2TO202Aba23
	f3vHCgmEe4WGRhliu6ER775xzD18cNm7reWT82f7tRq8VHKZE=
X-Google-Smtp-Source: AGHT+IEv1psFTLLIn3fLR6zBNaC1O4/uKT3iU2N03Fto9nCIf6JIXdox9iEwBJ11RCWUIzocGYmgaQ==
X-Received: by 2002:a17:907:7212:b0:b72:95ff:3996 with SMTP id a640c23a62f3a-b72e02d25e1mr1281562866b.10.1762862460597;
        Tue, 11 Nov 2025 04:01:00 -0800 (PST)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf407a01sm1340707466b.22.2025.11.11.04.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:01:00 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Switch to using AIPSTZ5 on i.MX8MP
Date: Tue, 11 Nov 2025 04:00:19 -0800
Message-ID: <20251111120022.696-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

This series is a combination of the previously dropped patches from [1]
and the config-related patch from [2]. This enables the usage of AIPSTZ5
on i.MX8MP-based platforms.

[1]: https://lore.kernel.org/lkml/20250610160152.1113930-1-laurentiumihalcea111@gmail.com/
[2]: https://lore.kernel.org/lkml/20250707234628.164151-1-laurentiumihalcea111@gmail.com/

---
Changes in v3:

* enable CONFIG_IMX_AIPSTZ as module instead of built-in.
* link to v2: https://lore.kernel.org/lkml/20251104150612.1874-1-laurentiumihalcea111@gmail.com/

Changes in v2:

* squash patch 3 into patch 4.
* rewrite commit message of patch 1 to state that this driver is used
  for the IMX8MP-EVK board.
* rewrite commit message of patch 2 to (hopefully) better describe
  why we need this change.
* link to v1: https://lore.kernel.org/lkml/20250821105634.1893-1-laurentiumihalcea111@gmail.com/
---

Laurentiu Mihalcea (3):
  arm64: defconfig: enable i.MX AIPSTZ driver
  arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
  arm64: dts: imx8mp: make 'dsp' node depend on 'aips5'

 arch/arm64/boot/dts/freescale/imx8mp-aipstz.h | 33 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 16 ++++++---
 arch/arm64/configs/defconfig                  |  1 +
 3 files changed, 46 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-aipstz.h

-- 
2.43.0


