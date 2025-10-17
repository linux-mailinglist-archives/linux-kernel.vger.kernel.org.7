Return-Path: <linux-kernel+bounces-857335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 096ECBE6911
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0654B624422
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0D230F7F9;
	Fri, 17 Oct 2025 06:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8f+KnU/"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684C330E0EC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681448; cv=none; b=OiXubL6gcB610DSVDzZdD9P8N0ZFSIY8GiDD7VH/KnxIi/4HmnBTqvKu/u6DHK/ya5LnLWXaRZ4Dhsb8LNicoUbbMaEdQmx4A+x8lAHJ3cbALsWIlfK8xM8TnNtCi4wPlbai9na3EMP2xVw+vmfamaQUJNrntxkVb6M46Mxu6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681448; c=relaxed/simple;
	bh=T8u+Ml55+qwIbig4DN7RlHYBf0qyK8VRu5BOjZlWgsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kNX0Tw4Q94Jvm7XJVVmRLAZ1Xo6/P6CqWLf5hMbo28lKTytybuPcBLNULEPWJ6pwwacBiCU/SujHagko/0O2OqKQfQTv+rnzUVmslGGEOIJxOpcqDM9+lWFX4/Wd+HhWYscbcvTAqba3jMEwHuiBohrOEOi7LRdxVvwm88HQlPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h8f+KnU/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-27eceb38eb1so17777895ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 23:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760681447; x=1761286247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWguY1LIvlZhe7LRkQwjcGn5XsNbYEwGR54WSIWyzPM=;
        b=h8f+KnU/qbSrHjMMeLNemml/mvqYwSqhhjlWPZJAjMuE0xVEN1f+e+Hfw/IdWdiRRZ
         +gy+rBDoRPmIb0wM2KJbNwsrwxyBirXH5q3p6ti7vzGZh80RuXWTLZVHI9w+H3jnmh5j
         Ok4yG662IeZ1dtg6D9h9FPt13mPSkbBY6AZzAMhoxk7kaI8oLOKXqYdfc7qHghndg+J0
         6vqYy95+ddHnGS6eYC+75R8fdjvA3JZpNFsySnR6PjJigLYRaDtifE02eMe4dCUBo2t3
         kHE8xzzbzl7tfAqzdZj6Uw+rhHK4qsz3c9wCUiSlAD/+hGSQ2ZTOlVi+iMTq4Xcy2I+A
         a3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760681447; x=1761286247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWguY1LIvlZhe7LRkQwjcGn5XsNbYEwGR54WSIWyzPM=;
        b=OETP9bAd/LwFhBQFIpjLovF6nhNho0z01UqJv+NL2T8volLyhcCsI5pJY/WIYTDEl7
         FatmBpiaEANOQk22T6LpwzpNb4Y9Ar6NNJ3eTG3gV2szOHi9T/IpqP3JDMxsu9NBSIi5
         jlACUwnU8I8lzi47t5wpY6xG0sZZPf0WtvHznxsnHf0QhnAQkMYHe5mQ2fECw/+wPBun
         M9ezGdlWACrOb9mWSQeza7y0oXQMEILjMu2HPj2Rc5z23JE5h6GvUxanVddUd0FSCaMR
         eRcJ8BXfLurgPWvSd2950IIW+Qx4s5iHLLJYaFCb1Ya9HuqaxLmF70D6H8iGHZbNaD3J
         819w==
X-Forwarded-Encrypted: i=1; AJvYcCVoIAgfY35VhSUPDFAoVoxGeKg/ZLIvGmToU7ehZKn8NR3gQXCogZuuALl2AJRtKa+UMzJaNLphvOAuIHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoGH0Wy/M2LAHwElrTYkK3MOlA+HGN03PmwaIeJNNKgQSUh9xS
	miyVImLYNzMSE1aj0I9dk6DK8d/i4BnqrosgtFTqKu0i8u5dlVlr/QU6+kuVtJZvN8+yPg==
X-Gm-Gg: ASbGncsIaX2/x58EVPKi7HJ7IvXEwTjf61OVuGkgY8j89Pb73etLYrJ8d5BTiDQM97O
	hjQAA7G8gIM8uA2DD+yXAZUArWcnNN3fbLjXtTV70CLa/lk55yEc5I8dbW9ZMZVuj+5b94Jf71Q
	3ji5tMRi72m4vQE1cqxz0uSoELnaRq8fYkmcVXqiwJQuB2Ksrl9r6+3cLjz89bztWlggdhvBvDW
	4ZTLCeez65UN5X+CP/LM4xSpJqdxxoSS9WnPeBrdMiE3tgMsnTgb1tsA4d2g3r7YykQF53CMG38
	lKhgHCqGiM3ocYllW5+mP4X/0ddGk3xFRZ65tKB5mF9LAwNv8BawwdWd4ppvVQ/Za0Hl3FmsiVj
	8nKjqtRjIKoQvRMKRGMDA3TBkJapUeK1/0hDtH3f15nypTMRZ6puj8ctko5NcJreqEHdn+MH6U0
	PslZGNedDWTGiKQ2Lk1A==
X-Google-Smtp-Source: AGHT+IEROJ+/juvtMdqHps0kqBfRNcV92IZtPB3YXFiFn9l93YwMk6VoR62L85/PTG/tOTEYXhQKmQ==
X-Received: by 2002:a17:902:d544:b0:261:6d61:f28d with SMTP id d9443c01a7336-290cc9bf243mr31500725ad.50.1760681446593;
        Thu, 16 Oct 2025 23:10:46 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909938759dsm51315475ad.49.2025.10.16.23.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 23:10:46 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v14 0/4] net: dsa: yt921x: Add support for Motorcomm YT921x
Date: Fri, 17 Oct 2025 14:08:52 +0800
Message-ID: <20251017060859.326450-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motorcomm YT921x is a series of ethernet switches developed by Shanghai
Motorcomm Electronic Technology, including:

  - YT9215S / YT9215RB / YT9215SC: 5 GbE phys
  - YT9213NB / YT9214NB: 2 GbE phys
  - YT9218N / YT9218MB: 8 GbE phys

and up to 2 serdes interfaces.

This patch adds basic support for a working DSA switch.

v13: https://lore.kernel.org/r/20251014033551.200692-1-mmyangfl@gmail.com
  - add MAINTAINERS entry
  - remove wrong memory barrier
  - suggested code style changes
v12: https://lore.kernel.org/r/20250926135057.2323738-1-mmyangfl@gmail.com
  - do not introduce PHY_INTERFACE_MODE_REVSGMII for the moment
v11: https://lore.kernel.org/r/20250922131148.1917856-1-mmyangfl@gmail.com
  - make MIB_DESC cleaner
  - use disable_delayed_work at teardown
v10: https://lore.kernel.org/r/20250919094234.1491638-1-mmyangfl@gmail.com
  - fix warnings related to PHY_INTERFACE_MODE_REVSGMII
v9: https://lore.kernel.org/r/20250913044404.63641-1-mmyangfl@gmail.com
  - add PHY_INTERFACE_MODE_REVSGMII
  - remove mdio_verify()
  - remove uncessary fdb flush opeartions
  - rework mib reading
  - set port pvid by port_set_pvid()
v8: https://lore.kernel.org/r/20250912024620.4032846-1-mmyangfl@gmail.com
  - rework register polling
  - rework mib reading
  - other suggested code style changes
v7: https://lore.kernel.org/r/20250905181728.3169479-1-mmyangfl@gmail.com
  - simplify locking scheme
v6: https://lore.kernel.org/r/20250824005116.2434998-1-mmyangfl@gmail.com
  - handle unforwarded packets in tag driver
  - move register and struct definitions to header file
  - rework register abstraction and implement a driver lock
  - implement *_stats and use a periodic work to fetch MIB
  - remove EEPROM dump
  - remove sysfs attr and other debug leftovers
  - remove ds->user_mii_bus assignment
  - run selftests and fix any errors found
v5: https://lore.kernel.org/r/20250820075420.1601068-1-mmyangfl@gmail.com
  - use enum for reg in dt binding
  - fix phylink_mac_ops in the driver
  - fix coding style
v4: https://lore.kernel.org/r/20250818162445.1317670-1-mmyangfl@gmail.com
  - remove switchid from dt binding
  - remove hsr from tag driver
  - use ratelimited log in tag driver
v3: https://lore.kernel.org/r/20250816052323.360788-1-mmyangfl@gmail.com
  - fix words and warnings in dt binding
  - remove unnecessary dev_warn_ratelimited and u64_from_u32
  - remove lag and mst
  - check for mdio results and fix a unlocked write in conduit_state_change
v2: https://lore.kernel.org/r/20250814065032.3766988-1-mmyangfl@gmail.com
  - fix words in dt binding
  - add support for lag and mst
v1: https://lore.kernel.org/r/20250808173808.273774-1-mmyangfl@gmail.com
  - fix coding style
  - add dt binding
  - add support for fdb, vlan and bridge

David Yang (4):
  dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
  net: dsa: tag_yt921x: add support for Motorcomm YT921x tags
  net: dsa: yt921x: Add support for Motorcomm YT921x
  MAINTAINERS: add entry for Motorcomm YT921x ethernet switch driver

 .../bindings/net/dsa/motorcomm,yt921x.yaml    |  167 +
 MAINTAINERS                                   |    8 +
 drivers/net/dsa/Kconfig                       |    7 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/yt921x.c                      | 2891 +++++++++++++++++
 drivers/net/dsa/yt921x.h                      |  504 +++
 include/net/dsa.h                             |    2 +
 include/uapi/linux/if_ether.h                 |    1 +
 net/dsa/Kconfig                               |    6 +
 net/dsa/Makefile                              |    1 +
 net/dsa/tag_yt921x.c                          |  141 +
 11 files changed, 3729 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
 create mode 100644 drivers/net/dsa/yt921x.c
 create mode 100644 drivers/net/dsa/yt921x.h
 create mode 100644 net/dsa/tag_yt921x.c

--
2.51.0


