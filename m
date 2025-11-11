Return-Path: <linux-kernel+bounces-894966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1908C4C93D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75088189FC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F8625B2F4;
	Tue, 11 Nov 2025 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHBTgtD5"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA825BEE8
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852264; cv=none; b=GiFGOOh0rfl5Xe1TAFM3E19EYcVON+PgVYSlGD6zOgE0JyqLqZhBjDkSwKEPRhGjxXZ3mO5HJ292LjsNJkC2tAMqrrKZOZZ4a1Nnn6A9a/+/QmnfeXgneDJQBCmq6+rrWTympW94w1fY5UGIB0vtJE+mzyTJvS/fhQNL4m4GIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852264; c=relaxed/simple;
	bh=fUOYNNreolSQ2Ets4gWNGuLIPUyRj7lgKk+P2qLqWj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K2k/1RurSbTjVPc1ZmX4Rt9F/AjkKnmgMdd/irEwZ227SUcxqFcykMP9NvpvTOcVuVnv/GynVTOds4owowmPQ1fCLZeicQf9oB2xshjLThKiYYLabCt6T+9HGR3ZpVbl5kSmAGpNuT/pM4yQ+2iqyn7mjDIr4584tycAvOSkHeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHBTgtD5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b679450ecb6so3218843a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 01:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762852261; x=1763457061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ei4lp7raydfScBEQVjNRebdWHLQLG3vpShzDTlbzIUQ=;
        b=YHBTgtD53VWa28QoqyU/xr+HxzMXqLzPV/kT6Dfo1+nff/dI0l/wkRGU9YpdfnWRmb
         7Ya304UQDc4orCHJjGWhs6WoG+wTXGipnMX/+NoK8xcDMKr60jyV9nXQSpr9uB8m3aWz
         alJz5UfND9/sbKFJCLVO4FXBtH7I3AO7UZv51qlqHW1QG8XneytOrpY5LKzT0bmlxMBA
         SPmj+2Bvy8SsGNvAtaZFwZvuPwIIp11U3K/oly5xXPUwsOTmdD7kRyDw9nP6ow/rOXg5
         hYg3SAcpFG/Uwc6t3S3nWivEEuom3gRYGtZBa4r+VTsVSEU4EgCoHDK4yf6Y51bToVQe
         rk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762852261; x=1763457061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei4lp7raydfScBEQVjNRebdWHLQLG3vpShzDTlbzIUQ=;
        b=pUsXRNN892qq34lc/d+IctdLleuTil5ZKks9GrU3s8+yjcNcA2VZFDLHD0YVzHzrFs
         G9ThJuRg0uyYvLpQ2ZOJRfxbiLXn0tlTMEzZxLz6ztgErsTl0WtlnWfX0bb1agPYCW/E
         P0a+OoQ9tXiWv9ZyNzg/ZHRj9vbA0gEEJP3aM5y5GKNgtw9UVjCC5dJ7rjo2zWlRyiRm
         g/TCA+I2a2fAD5dBqEkDjju1BuMfINMTAgQ2YZyvqUjNpzCuAvSJEhUEQFOxJ39R4zdu
         p/Lf37JegjwQmtNrmB0mtYWquu+GiGP4dNKpvy/bQu2fVAwgeN75dc5YR600tmgVlx+C
         KYBw==
X-Forwarded-Encrypted: i=1; AJvYcCU2Ed/H9Fz8MPvR0elJbxkIU2McpdsRaIpTvauzfM3xtLVzSTYaNzv5f7IA4KagLTYzjLMRcWduayxkJsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdc7OOEvoNbTPdLiZowstKQK28f5DbfBLvASnAvCVRjI5ptI2c
	hLoLfm+OEPoPpaePGUfYWLC1DMQSDiwF0s9I28+QDpVBR4AX3YO+0veA
X-Gm-Gg: ASbGncvtLFzM3ddJQ1f0/pA6jU8teA2p+Zb5MSmk6WzAbAOy1x907WTskhHA0gRqs/P
	erQqs33Bj48c4O0qM1EHuHCPUWzImujAD7TvvDxu4YvgP3UwWAykBNugO5Y9/9PfqltVV1+f8yz
	ubmqdsCw3XNVefuYE5sbrx3I/IWlrpAlbTio1Lm5Z+Ue4jXy8sZyR80/ZhRWXWoakNQa/K1s9wZ
	gIPxMbqxb70IBRnVEQRxP9p2jfeD6GE5M3IIAoOH4rTk1oa76WHNkmU3r7S04sUM4yPIBLJSc/s
	4LTBqVfqGWaku6WevBpXaXUV9GT+1JORmyfVofZTTDEZKZrresbfz0AtV+1JDMOYqGws1thvRSJ
	lDAGXig0tdDExeTs39qoLCGMfLK63aFx/BrzipgREF2XcedVaQHO2jiWKXLZlig2XiUfN1xTdTs
	b4x5KtQ9RrvFq7GAQnYoY0rg==
X-Google-Smtp-Source: AGHT+IGOmhwf1aKWxS8ebaRXye3bUHf6DXtaZFP/uLYDWfPSSFe/z9UKAR9ho824eGYpyhhdq6AzWA==
X-Received: by 2002:a17:903:9cb:b0:298:1422:510d with SMTP id d9443c01a7336-29814225524mr93955685ad.48.1762852261420;
        Tue, 11 Nov 2025 01:11:01 -0800 (PST)
Received: from iku.. ([2401:4900:1c06:79c0:4ab7:69ea:ca5e:a64f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5cf37sm172715415ad.35.2025.11.11.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 01:11:00 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v3 0/3] net: phy: mscc: Add support for PHY LED control
Date: Tue, 11 Nov 2025 09:10:44 +0000
Message-ID: <20251111091047.831005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series adds support for controlling the PHY LEDs on the
VSC85xx family of PHYs from Microsemi (now part of Renesas).
The first two patches simplify and consolidate existing probe code
the third patch introduces the LED control functionality.
The LED control feature allows users to configure the LED behavior
based on link activity, speed, and other criteria.

v2->v3:
- Added Reviewed-by tag to patches 1/3 and 3/3.
- Grouped check_rate_magic check in patch 2/3.
- Formatted the patches with `--diff-algorithm=patience` option to
  improve readability.

v1->v2:
- Patches 1/3 and 2/3 are new.
- Added LED control support to all VSC85xx PHY variants.
- Renamed led callbacks to vsc85xx_* for consistency.
- Defaulted the LEDs on probe to the default array before parsing DT.
- Used phy_modify() in vsc85xx_led_brightness_set()
- Return value of phy_read() checked in vsc85xx_led_hw_control_get()
- Reverse Christmas tree in vsc85xx_led_hw_is_supported()
- Updated the commit message to clarify the LED combine feature behavior.

Cheers,
Prabhakar

Lad Prabhakar (3):
  net: phy: mscc: Simplify LED mode update using phy_modify()
  net: phy: mscc: Consolidate probe functions into a common helper
  net: phy: mscc: Add support for PHY LED control

 drivers/net/phy/mscc/mscc.h      |   4 +
 drivers/net/phy/mscc/mscc_main.c | 494 +++++++++++++++++++++++--------
 2 files changed, 376 insertions(+), 122 deletions(-)

-- 
2.43.0


