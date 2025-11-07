Return-Path: <linux-kernel+bounces-891001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8B6C418D5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9A394EFDDD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF6D30B505;
	Fri,  7 Nov 2025 20:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZoyBBcBA"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002C309EF1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 20:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546370; cv=none; b=fGmHoViOFljfq40uTR9POtUDonm9iQkyZagthwFMD1ZL+H+JWQ5vXt8+tj7ddfe1df5gDxNtogM+XehYB1qIEI+Hw0aTrpjIs909fKFo7MIwaNnuCcZ86arDTfVdocZkHqfti1zxjImq3CFJhZ7/ratL+qd8S51WD9EFgf5xwTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546370; c=relaxed/simple;
	bh=q+Oljg6oRYn/wzyY6ZW+TEK32wEhmKjJz0W0fLoZnGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fkqKkH9qzjTpnEi3hidotP/PiG/CKdjD285Djzqk/sv5SBbgPwDuzolk/E78eLGhLatuz3DiwPUYkau1w2Ee79J/O2SqiKzoMknVhNG+z7l36Wr+eT2G78Coz9oJS2k9KQjsWxVDy8Hf+C8yqVcLmrWQ9tSzug1oYMxhVNJfy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZoyBBcBA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7af603c06easo1166136b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 12:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762546368; x=1763151168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmLBjJR7+9+QwX0fWKlfYtGSCTKiJyl3M6K88B8Ym2w=;
        b=ZoyBBcBAOwzb91BZqdRRLIrH1TriFrObJaJMMVxW82w37XJSy864J7U2jSbGfUrD/Y
         vQDxfPsjNj9qSlm7nAIKnD1SNQAZlu2EKUkp4O2CQLevIENPjDGazHtSYLXtVjn8rvxR
         s7zLmBy/B9SRweNU4sHDZOI9F1l3uP1J5Ic9SNNw3/uhXiccfgZz3KlMJRks2ZMmR4CQ
         Eh52G4oAWnkIMQKyQc/I5bcpbQchJpNyCsWihDN0cUGn28Jc74EJrc6HBXd+tzenZuYg
         0g6OCmm5FFkSqMgv8Ng/seP0OIxUYvIr85akMNAMV/DtP8DuIg46dQhrTurkG94MoS6n
         fFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546368; x=1763151168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmLBjJR7+9+QwX0fWKlfYtGSCTKiJyl3M6K88B8Ym2w=;
        b=i9gFJdYxaIDtjmn7hfZSly7PnT7Ek2crHhnxkILT3msgL5aJ+lgZ/04+mrouRqZ3ic
         JcFsGHcA75uioxk/+VboTStbC8zE+yOy5AiapYfgkuFU4Cui/M+zlBIZd+QV5hNlbWLy
         FQzNHBazX35HGkU+Z7yKaKLFcFXWp7U5Vdz6I8O6MIz1DIkbU9tAFS1Qf3B480dSd4pA
         vSnrMD5ji9BQiGCFU787wsOI0y0WMZPLHkmi+BedNEXTe2iAPvVHXOgTVXWNscSWWE2G
         HErvMm/QYUY2PVAuy/gmCyiI095oqxRV/STmI3fm89XivX1MTH8906ujqTBTgDo4HY1M
         jzwA==
X-Forwarded-Encrypted: i=1; AJvYcCU7EUhfPgrHuw0891Q08r/vO2ixA1u1qKappkIXgrHeE5MFIPVForgqlkT9CAxWD8MahbXyuBRYOB8eYR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKsqjGG96eAzAM5e79WTgLyAQVFRpUi3DS7ij+mootNjaSvj7W
	rSo8lRBYuGatA7ldM67vAd4+DhpidTiMoGFNu2gWdVwmq3OXEcW4a1zL
X-Gm-Gg: ASbGncvGsZNSbrbvBV5IqSvjlxmHAfsS/r812EbYXHH3oEfv33Ga4BvBZaQinvJ3JPe
	pGtDpoGlXxZ2n84ZkqlYdByQdQO7U7lw+Y3rI9MS7ucK8G0WeDylvTz1VTsYzGxJnCcjXdCzgUX
	R3CXwtmojDDWOUCp7u+1UXcgYzNDoJCwMjd3rpVuWds4dadZuQio8pb5GBPPZUphxKzU3ymKGCc
	ZDGWy7iqSfUYRad+hCHLfYGggj+t7eDgYi99qV1oXVj0ltQkbUn37AQKf1TWxAYXXmV0QMWOMqD
	Akm4nFZkmuDjhVQ4DE+OHzZTGgM/33lKkgd176Q4WoylOpPH3ILUn8xpOtpFwPKpeqCZPAGAs6d
	jlVD0LxCv99I3QcxaWu+gSnu+kNIlmez9A7hmHQ3X+YDl5BvMSOesRoQZKM2e1F5sdGzF9nJHXB
	5oYMGW+qRl79HjHUKL0X/qgg==
X-Google-Smtp-Source: AGHT+IGquAvMPEEx3nkW2d82X3WNn0DCOofSOoddPCdlJEAt8dKqkNI+ctNil0/sdM1xqx2QGMDKyA==
X-Received: by 2002:a05:6a20:72a4:b0:334:91ab:f189 with SMTP id adf61e73a8af0-3538b000317mr757236637.22.1762546368290;
        Fri, 07 Nov 2025 12:12:48 -0800 (PST)
Received: from iku.. ([2401:4900:1c07:5fe8:9724:b1da:3d06:ab48])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17784bsm3828553b3a.47.2025.11.07.12.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:12:47 -0800 (PST)
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
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2 0/3] net: phy: mscc: Add support for PHY LED control
Date: Fri,  7 Nov 2025 20:12:29 +0000
Message-ID: <20251107201232.282152-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/net/phy/mscc/mscc_main.c | 438 ++++++++++++++++++++++++-------
 2 files changed, 349 insertions(+), 93 deletions(-)

-- 
2.43.0


