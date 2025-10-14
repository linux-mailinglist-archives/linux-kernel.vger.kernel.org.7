Return-Path: <linux-kernel+bounces-853243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1ACBDB005
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C7984F05CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B32C0278;
	Tue, 14 Oct 2025 19:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD9f64jw"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3051B2BCF5D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760469094; cv=none; b=N39lsFedkiq7BOPig897johxCSGCnezO6azKSJ7PCIl9l+h8jQE9VKjyDprOP+nxYyUcsa4EM8n0zUyK65/MWFzXhFIa3FfHJfikHxIwHNUnNXNVf6XMmSPmY8vzJ4BtohBKOvssR1Urth7O/PscHd9e1Cg942Mify0OBupBvbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760469094; c=relaxed/simple;
	bh=JoNiSlBHX0lRsNEM+X+qf5ROfd4SBePaFleHfgcatAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5iSQae5Q+KlA8VOagwVAd2UpMrazOrCmt4dFNPwtO4if1Zz1Hk5rW9paVy5ZrJPuW8Mhqprhf+4RUY4CY74ftOT6fi4T29Sng/BsvWNBa83GV0jhpMxSKiMpoKOUcig566RZRBlLmutscIqflgbsmlY2ja53g4BG+n8RAnk+SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TD9f64jw; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b55517e74e3so6365821a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760469092; x=1761073892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=St16IbHkGZRw0WWM1PwYJ2PuL1/1u5d5uZewUoKrBqc=;
        b=TD9f64jwwsmeEorCpnClT+/WvjXKc8O2j6YfZab/WgoOsNL//MKLDWg1+2bzw7WGiv
         yXTTBX5iMqYLzjRlUYnfRZOrmyBsSHwdNk3vj5zLd51wPW3OvjjXgoCi9944toudOnl4
         USOvPG05TDIve+VJVd9Ti0gI+3lQkXdtKvy0+Amz+wtv03TD5zVz9pUqQuv8aXWBgx38
         +5+XYpDuYap5Pcs503C6vZsM9GhfIIugGy/gVzbPEl0BsM48iPWdh6ccne0tP9vTmHUD
         MPTy+BJJJNY3hqijGAyP4+Q4oM0v8jwJnri9bmqYz6kUGT5Uv5iTJ+eyGwmvDOvPtYUd
         NVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760469092; x=1761073892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=St16IbHkGZRw0WWM1PwYJ2PuL1/1u5d5uZewUoKrBqc=;
        b=sxghumotxDsJ5ahNlaIWteVh00wNCio6D6deoxip5CR7bWEcJEh3/JR8w5m18SzQXY
         JFxfTVMxcaAccTl+H2ZVRctfR5dwdVNBmZnto39EKNNbMePw6UwbOcCNrcfV5qtzdWKp
         ZhNMUBI0iq9HGnbdQ4lKmPIx4J4URoY5K32mjZSggzmF3268h2YRzNNoivpDazscxGE3
         EuBrpkHitZRUkxTL7bxfjva7DI+AtCqQ1AUloKwhnRvEppuMAWR9jQ1hLAqJy2VKtDpN
         7psoUVUyy0ruwogdgaTqFkOsH/v7vQQu8CiWfgSuhaHKMOKKbH1XG7bNuo2piFJFbbTt
         wWJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2ekyTVXUcdDILwWLi6Yi32wKVvPPzEqLN5tDIz09Py46AcUa/ST+M6LF0FTRtY7lg9p1d3bfKtcNjUGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8hi4WFpakE++jprAyCK4QMBHUUQqtiyZ6niKNp1Hbf05WZ7/c
	0MsPL3m8QuAMVd0K2jpWRYLHdUv51JwT/kuw73nJXv6lFbE6KVirhGAI
X-Gm-Gg: ASbGnctJkAGQXIhwEy+TtnRfJ52SL4pE9aMvHLZReVbLB9Dl+8dmwTzcAthgz3owEGB
	rgm+ZcJeUW5jQR1rnYtzBluiJUw704dh4MT1ev8OKiLxf3f7eEF1wtDmVHJOwtyiZW8gbaqyFgr
	u2s9UjtDMQy3hiMfLkHmGQWkZX5HPT+rZNWEwgGUoujbQgpAvuGea/NtJROsq8BdLoeGdxKDuKq
	6rd2NAk1W9hSRuZZtwG0SCL6lXt5L0FAkTlAPTRFfkdNiRmnzNMA0d66OYzc7n91pNcT8POmjHO
	i5c8BfxZiPHQ/jm7NUDS6Vx5R+kjPr0pINqFwUro8Us7H2as/7BsDXuAwc6gZii1qTg0Ctu2FZH
	oYnCiipoLC5vbbQhWG8EI0YqsxXTRL6RuXMC+odKE4unJPqllumJjM8/vcun5
X-Google-Smtp-Source: AGHT+IHCjOQ38l5+wUDId9pV67uaFxJ6e4csyg6AZzHE9fI8Bkcg7dp7NE09q8EsSbM69FmMTL2HpA==
X-Received: by 2002:a17:902:f60c:b0:24e:593b:d107 with SMTP id d9443c01a7336-290273ed7aamr298836245ad.32.1760469092296;
        Tue, 14 Oct 2025 12:11:32 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:9987:bec4:a0:deaf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de658bsm172402755ad.22.2025.10.14.12.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 12:11:31 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] Add support for configuring pin properties on RZ/T2H-N2H SoCs
Date: Tue, 14 Oct 2025 20:11:19 +0100
Message-ID: <20251014191121.368475-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This patch series adds support for configuring pin properties on the
Renesas RZ/T2H-N2H SoCs. The RZ/T2H allows configuring pin properties
through the DRCTLm (I/O Buffer Function Switching) registers, including:
- Drive strength (low/middle/high/ultra high)
- Pull-up/pull-down/no-bias configuration (3 options: no pull, pull-up,
  pull-down)
- Schmitt trigger control (enable/disable)
- Slew rate control (2 options: slow/fast)

Cheers,
Prabhakar 

Lad Prabhakar (2):
  dt-bindings: pinctrl: renesas,r9a09g077: Document pin configuration
    properties
  pinctrl: renesas: rzt2h: Add pin configuration support

 .../pinctrl/renesas,r9a09g077-pinctrl.yaml    |  13 +
 drivers/pinctrl/renesas/pinctrl-rzt2h.c       | 230 ++++++++++++++++++
 2 files changed, 243 insertions(+)

-- 
2.43.0


