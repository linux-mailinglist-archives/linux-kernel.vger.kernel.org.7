Return-Path: <linux-kernel+bounces-831219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03ABCB9BF5D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 22:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4693338147F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3138328968;
	Wed, 24 Sep 2025 20:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="aMp3CbI8"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD78F328963
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 20:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745705; cv=none; b=gOuj/ILiOuK+EwNWPcQjZ+DM5FXS7kyRITAF0Wba9hzzReTdbDl3SQGLvwUNKOKAEHjqUFOMsTZMQcnLtoWCT4LMGKNZeNSokO446/iixla9hapgq44BloUYvJwn0GAlaMkj9WN6DGFsW7OYFn2+0Z36LWr9FoXQ1SGFudLn8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745705; c=relaxed/simple;
	bh=UmucYTRu+BE/Lztu3PCNMMuVHUkjtu+v3sIYViVwO6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QdOHCtPLlPWlFr1tGmZvA3d5tLh+o//VsFuuLn6OKVNUyeufcjFyxA8T6bppes5zVBbEuv6iLAnpLYvisL3D/WUm8PMD9yYO2T3rVnyKrhY8QCai2f8WsdQLT+R3udDK/++BULPiarbdVu0alJ12Hn6SbAv2ZW25PVk9upweTpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=aMp3CbI8; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54dd647edcso208488a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758745702; x=1759350502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NddK7zUtx29kLKxWc4QfF7l6cZPcdstc1x330fld4jc=;
        b=aMp3CbI8anc46oQcLNdHmnlJulQZ7TO1IlJFEvlA4awVuOttLpym1kboUKycPJc25/
         Vzuj9bN/Q/9wicXmFEdLxxb3IdniOHQvGYIObeSqcaiXA3BzL5JVVXqGxeZF7W7cSJZS
         8FFeBkt5TDPM0AbJJbropMx7kRvY8x8AVgYkD8+ObjDKobEUbeEzWAJ36AcbE6HGciHT
         L3ArTuyK2lZ1GhEVKMLWCCU8CFuAIvrI0Fopw6h8fzX91/UJYRi3FGowRvXcCZtepSde
         wLlHeJWkWboiI92z/SZxp6ViPOUH8syDNaI0Z01DtVk8CEVLhu+/vvPXNE4p3fogNMer
         qH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758745702; x=1759350502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NddK7zUtx29kLKxWc4QfF7l6cZPcdstc1x330fld4jc=;
        b=bCK4eD29VUBhTVLWH3n6zkvWW6Cf4rejKrMdrDvNtnFZJ17gmqf69Q0Y6hCDMZay7K
         4vGH3AmB4q5m88tiJ2ahQGo4hDZ+NtMel4hkYtbuDO8yR73HYiLxrbcayauFfxLaptL6
         taCmGzFTXXnikq7HuzsaejTK82Zhyg7c2t8o0u0qkEfKNOK1OxCq8E1+W5me+lIMW88w
         d7V/IQsF+l8bGwFq4zEeyFWs3WMqLiprhC83ijIdZtrtSUMyh+XoVyDHjShDR2W0L3/0
         Z90ctWK92CyAcohGq768MxcWSxyb+gc/jICA8G3YlJn5GK6sY5BDmVl+VmpV8/8OZ/bW
         uhuA==
X-Forwarded-Encrypted: i=1; AJvYcCXGojWPNUxkL9vZH2wbN6uLlNnMB03zduXZepPzrZW7Bm+B9GY0jgQ7gvlXgswr11VGI1kajPSwTkWiw8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPsOcKNx9a2wF9e25lrABU4JImYc+DCwMH6gxvpxDR9n0PaE+j
	Fip/aymnmzd1XXhqv2vcKbXIjXY8qNEDKkHmmgT3ruACroLGhHRRduqiGifWxmM1sIM=
X-Gm-Gg: ASbGncvi6+Og1XqpRMNNzlhSAxa5unBH3gFdGsTcfnf79TK8lTXv2jxGJDSRIY1MGJT
	udlhJqvuMmglLbREdH4wTkjk88mZyUZxMXIvvbaL9KiSSAXVYoa7yOPSEsMMSkGx1SrgOVhtXUX
	2RzpzAvISjXXQYQH/FIfcKYuzewbQU6D19ykESnZSK3YxVD1RO/oNCnhQmdVEH49OJJTrze/P9V
	dvTEzImVKxg5VL5u9VmQxXjx5YjsNfVlbUlEX0Kow/9rNP7JWp+tQNBDYbaTBrLhs2BYF1SfC2E
	bUN68OrG8pXeFK9iSbctBiYNi6fsGKjbPWDSfEq97bV/KZK6pk/p3pG68jubirfToj1UxCbOCTN
	CWfXsT53bKA0RwauBj5S/a/SA5GtBKoq9XHwHQgxBeuw=
X-Google-Smtp-Source: AGHT+IHJVzX2g1UA3upwAb/j5hdf3l0TKF508erqEeVTVoaUhMLw8VEbhNWZxcVuu6I5gB/pfVVtnw==
X-Received: by 2002:a17:903:185:b0:267:a55a:8684 with SMTP id d9443c01a7336-27ed49c770fmr12390275ad.2.1758745702113;
        Wed, 24 Sep 2025 13:28:22 -0700 (PDT)
Received: from fedora (d-zg1-232.globalnet.hr. [213.149.36.246])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3341bdbdc9csm3229737a91.18.2025.09.24.13.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 13:28:21 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.machon@microchip.com,
	claudiu.beznea@tuxon.dev
Cc: luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] clk: lan966x: remove unused dt-bindings include
Date: Wed, 24 Sep 2025 22:27:15 +0200
Message-ID: <20250924202810.1641883-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for LAN969x support, all instances referring to defines in
the LAN966x specific header were dropped, so its safe to drop its inclusion
in the driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/clk/clk-lan966x.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clk/clk-lan966x.c b/drivers/clk/clk-lan966x.c
index 16e0405fe28b..3c7a48c616bb 100644
--- a/drivers/clk/clk-lan966x.c
+++ b/drivers/clk/clk-lan966x.c
@@ -16,8 +16,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <dt-bindings/clock/microchip,lan966x.h>
-
 #define GCK_ENA         BIT(0)
 #define GCK_SRC_SEL     GENMASK(9, 8)
 #define GCK_PRESCALER   GENMASK(23, 16)
-- 
2.51.0


