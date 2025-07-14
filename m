Return-Path: <linux-kernel+bounces-730336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D77F8B04342
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B885618883E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151BB25F994;
	Mon, 14 Jul 2025 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idop6lnM"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521C23BF9B;
	Mon, 14 Jul 2025 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506084; cv=none; b=lVsvgKgfj1tZlMRwco0xeSvoiP/cisM9lu+Kd8Ua74E5z3bKq33gMQXDNb3vY0MFWoleFjehfnUXTF+KwlNRm+5QOCfnmYf8UZ/Tg7fKqGzGNgI99Zh6siNd+o04hbKmG0ad3YfDunJFhWtmnJsACXXWIUakjWE+9s5EHw27hs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506084; c=relaxed/simple;
	bh=Faq1HQYeYBBRhYPs/kei74Rmgh+zrtNBTqw2764xXe0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W8hSo4Iv/DEoa3umyIshqXNQKG9iGj/8JUM6L53D6fniNgr8l4JtEQT93HQ2wwy6YxIT9EW8FxyJ1/c7n1jhC+HT3J30HS/vvKmA1Q24AtJBtbRYIGX7UzZX9XEcFpRcsSJuphwjL7Uo9CyJHXJgUluxNYOHQv7FeI3yfrjQ5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idop6lnM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so778784866b.2;
        Mon, 14 Jul 2025 08:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752506081; x=1753110881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3oO7945/t9P7Yv5GgXToznrDjdBL9oYYRyLkZLH/Q9U=;
        b=idop6lnMTou0f0UMiTUmZNOmbu0WO/HriywYVcCMHKkxYJUBbcUaocK1bfNR1THJDq
         75eIxFBjznCSIYbZWNGj3ATCf56kEecwu+dknlnWB9MuPZlmRP+tGRXYHU+0jaBsP2gz
         L8vS45ALw8Tbs6diBZksGu00IB8FFcdEFRGaORO/4YBQOzxjBiCpkVNvp3KsFemaA33C
         uKz4kRvf1VPu2cv7rDYdJALKDFquxhbt/Kfj+TFFZxE74koeVcTkmz3fBLfdjywLLGaZ
         l6CqDGAuNsFJeSWt2TGSw1MD3MbyZQcwMYH9AM4a6PwDmR1pCOuyz5I2FOCEESFdUAPv
         Y7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506081; x=1753110881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3oO7945/t9P7Yv5GgXToznrDjdBL9oYYRyLkZLH/Q9U=;
        b=Z2j3wibiX3B+eSk1dnF4xesn2QttU4aIJcmdPF3uOiVJKqHyG4vv3TBWcFaL5ulze3
         znTQoRgUZ+TWQG98Q/46o1udsPI2oWG3LIPKrEXvx4kqTrD6nYWNbvDJZhAYvk778P8X
         Ydc4kVltr8fTuJcDBbUg6oNeEdPe086uetNeUbtkVZlpvnhDxTjC0iH9In8fpEai/1yV
         jr+uaPdywEypt6nWEZOU5HFASkU/lOe+dmJu+d0vGf2PxvDFXYB5DUw534FkI8Czpzyv
         cALbeWFTBmS3zINhVMuW9BwRM+eH4e89ZDkX34pOj3446OmNpkFWIC7E3vibht6WF3SW
         dqdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGTTY3vGEA6Sn9pfUdvwBAM2rlT5mgXpwb+wUESjrak5txTM66mFcyv+FoHbetHgCbh68MtYYYSyp4@vger.kernel.org, AJvYcCXDWpY04ioWWZyJ7FBaUHOv78TatvZx6enNYhuezK0Zs8e43jWtlz5UfSdmSvfYGcztFLniNvoFGnJYeDgk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3q0rpjC6vhgpl0xCvCznpxXiyllnpv4bm1GOJLtMx5bPhxhcC
	mDxbD9gijldN5fQV1+eJt88Lyg2tgo1XF7y0gsnAJNYOoz+n5CQvgnKA
X-Gm-Gg: ASbGnctYOV8LNqUme/2wwd5/8FXVjlkNtoXOFTSWaMhs9Qt86CXjK28BoNRgxnpKRlH
	+NMSG5feDI0eailALT1UK6QXl1epPtBv9ayDFfetfty23WLSa3jCJRM9y0WBm5sAIgkbaW3MFg9
	MglBPhM0UUmCXNvDMJXQhHZ0/N/3rAXL0G5IZK2d7AZrZ9AnPvdMzADzfGvtTg4pJHByqOzQvMe
	z8H2gnNdifG59aj+WbqSJ5V0kMJz2A2VXZdRKx9dSLRGfzf7Q5qglaURrhSpQo/xVTFF5eKQ/ox
	MjQdWfSb3/9zkuJcr7V79+evopr65gFPUICjKt5zby20hlda8Fg7cOiZLlcsljVPCT4Wt2eAw3x
	zhM3mECmwgQ/AolxV+wDOFObIqySnBqFj9j+6hDcB+oTBUeSO8l8klaqu
X-Google-Smtp-Source: AGHT+IEMNMeFdovEOmEthHb3M9tQaXoDWJrcRpQpeLn2iZQAxWGug2pLJleD3OWWgryplxNKxQSfuQ==
X-Received: by 2002:a17:907:60d1:b0:ae3:6cc8:e431 with SMTP id a640c23a62f3a-ae6fc162659mr1523065966b.57.1752506080769;
        Mon, 14 Jul 2025 08:14:40 -0700 (PDT)
Received: from playground.localdomain ([92.120.5.7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eec2b1sm847701266b.68.2025.07.14.08.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 08:14:40 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] arm64: dts: support the i.MX8ULP EVK9 board
Date: Mon, 14 Jul 2025 11:13:44 -0400
Message-Id: <20250714151346.7575-1-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add support for the i.MX8ULP EVK9 board by introducing a new DTS and
a new compatible string.

---
Changes in v4:
* fix ordering in the Makefile
* highlighted a few differences between the EVK and EVK9 board in the
commit message as requested by Shawn
* link to v3: https://lore.kernel.org/lkml/20250701002239.972090-1-laurentiumihalcea111@gmail.com/

Changes in v3:
* change order of the board DT compatible inside the binding.
"fsl,imx8ulp-9x9-evk" now comes before "fsl,imx8ulp-evk".
* link to v2: https://lore.kernel.org/lkml/20250627142645.134256-1-laurentiumihalcea111@gmail.com/

Changes in v2:
* introduced a new compatible string for the board.
* aligned the pin configurations to the same column.
* link to v1: https://lore.kernel.org/lkml/20250623150146.1398044-1-laurentiumihalcea111@gmail.com/
---

Laurentiu Mihalcea (2):
  dt-bindings: arm: fsl: add i.MX8ULP EVK9 board
  arm64: dts: imx: add dts for the imx8ulp evk9 board

 .../devicetree/bindings/arm/fsl.yaml          |  1 +
 arch/arm64/boot/dts/freescale/Makefile        |  1 +
 .../boot/dts/freescale/imx8ulp-9x9-evk.dts    | 69 +++++++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8ulp-9x9-evk.dts

-- 
2.34.1


