Return-Path: <linux-kernel+bounces-743351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E928B0FD8E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 01:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D803AA66B1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CB6271452;
	Wed, 23 Jul 2025 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELfECq/7"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6909272E5C;
	Wed, 23 Jul 2025 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753313423; cv=none; b=nMTVvadO08B1WyVzCCEh8kWMDrelqThUodWMed4jHdONZZ5jDxts/nZP8oBMH47NMEoSfjJ8kb8kjcSooB9nExWR648FmTUUUOmqjnEv/aRZMGc6Glo24mrsr4tVfV7m81iZs56fXjxMNVOblyFf8fKOvKIlRex2Nb+4SeElu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753313423; c=relaxed/simple;
	bh=Psz8DZ/dc8ghuutoX7r3sUFmm3ATK3gXiO8okMx+4ic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0GN70VpfsHcjYH6kZZt8yk9k4j5GBSJowCSehDSGAg45OljgSy5Pl8iRWBgKu+CFfxqtdbT6b1vSTWyeEW1HuwQU1ixcy9p8zkWOpedATbDKjf+w1VJ/I5MlcgKRAu0HJyTRQoba/Mx+hUjuPgD8gDZq004ug3hggzsCVt0Muo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELfECq/7; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234fcadde3eso4727115ad.0;
        Wed, 23 Jul 2025 16:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313420; x=1753918220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tO98iZ6qt69jUEbguy5HbBMQSIcZbgLgv2m3GdQZx/0=;
        b=ELfECq/7nGIhkZlOt8cnMisXdFro3Orl1s3A9kLwxMJXrAaqoLGoIk3vxftYfVq6EQ
         M/39JxEfZSSTB2FMIs1jIqK8unF/sV98EA+cQWaysQfNyRscvPyyv+I6os0gNoOGdqhu
         nPWdC7dW6bNh5FqPpiSw3RcrVnzekjFlZorbXRdQjLc08AimRvFVySsXwa/qq3kUie7r
         Jp/kt+CqJK1dnrgOYhb96L560q1jUMqEduK2lp/o9Ushg46mYTpKZl3PuasMwq9GHus5
         M7YIbmUzklG9fsAvVvvqrcttw9d7Mcojr05+6B9xRo94Mkxxtj4iU5tOYwgBPDJhYiKv
         tiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313420; x=1753918220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tO98iZ6qt69jUEbguy5HbBMQSIcZbgLgv2m3GdQZx/0=;
        b=QICcVTbLwjOYn6MPWuFlTqudvIooBbz1y2TE+7V46+NQ7TVAVHJx8K0iqUN/W/2Z/c
         UmGy8v6Rb/Ze4pbodthtVl6PopUS4tS/W2BZ5wrIy/ZMFfq5IuUK9dr1zcsxsVghjIui
         ukJXmGU5ETLvIpg5UuNV44DyCwCtzHaYgFuTfWzel5eIPui+9vuG1UYk2KW9V4214wT5
         rfKQZloIt9F74ILky7PwQiNz6E7Jfpig1pupum3VKfO1J32B0dhke2g6qSp382nMVOwz
         Auu0K33lu7K9UZ9B4gvL7WYeUnx0l5UUelncrSLLUBwbdj+V6AE77WCccht/kRL6BVd/
         8UTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoha+pdJ1OSXK6D5UyIBmcxNK4qj22N5cdov2nLgHx+G+A3+WrTNDp9f9phwqkHunvSdEpvgJH2/1t@vger.kernel.org, AJvYcCVaVnc7g8QZHkim1F1h7Zb+SQyeGEkbMfTSb6SqwhPvBYRPh+Wv7DwlkO6p2GE0J3LplwTdHKx9OLwBUv8D@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz6NY18mOAHFbetbWAgwU7uMxjxyhJ9vKooW1uJylMvWl3EWO4
	ogCa/anT/RReKthTlIwwlW4l+Kyvuad5wCZhNUIdbJwoxGcWcozlOmK8
X-Gm-Gg: ASbGncu6UgFaTrkzurGTRJaxFxmmjgY5PBKx6dlF7JzlJGE+ny/ZuEBrk+C3VQVQUxO
	UoIKHc2b0Za6Ix4nqj+KSWJlSCd5eB5nkJFTXKXpzoAHC6s7Q0CzJmfNvOhCRhho7gg/7aQb4D9
	zZE5kXWQu83l8inTRfYEjeLSvr/OBLLR/fN3B5ftgRaMZPY/5A6ns7gofqWi7bopmZTKsiNm4U0
	PeRvrVtrZp78Xz+Pzhd/QmMK/wo2ApmWjR2ZJjtjrzFC7D1NUxWgNa4SwXV0uqz8xSuKvwiSdjC
	JgXbteA2veroJgOge13VDI+kpb8xPqV8XcPXbXZCNQguX1LLKhdICTPU8w3Kn9vk3/YxUZBD6VE
	XrSIdWVkSmhYM6UySMcaGfDMjE56HdUpKvPE8rYxre0gwEFY4hKlzrP8T3h0DwZB767ajOTzJWv
	M=
X-Google-Smtp-Source: AGHT+IHquOPa+liQqhO69zsGDdk2cs5CLA1oks7YvYmwOswhNilXRFUh4ud2Z4J4AOjCHvVS5OHHPA==
X-Received: by 2002:a17:903:1b4d:b0:235:1706:1fe7 with SMTP id d9443c01a7336-23f9812b6c9mr72043025ad.4.1753313419923;
        Wed, 23 Jul 2025 16:30:19 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:19 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v3 00/13] ARM: dts: aspeed: Add Meta Darwin dts
Date: Wed, 23 Jul 2025 16:29:56 -0700
Message-ID: <20250723233013.142337-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

The patch series introduces the initial device tree for Meta/Facebook
Darwin AST2600 BMC.

Patches #1, #2 and #3 fixes the DTB warnings in wedge400/fuji dts and
ast2600-facebook-netbmc-common.dtsi.

Patch #4 moves eMMC entries from ast2600-facebook-netbmc-common.dtsi to
each BMC platform because eMMC was removed from future Meta Network BMC
platforms.

Patch #5 introduces new BMC flash layout with 64MB data partition.

Patches #6, #7 and #8 add "wedge400-data64-bmc" board. "wedge400-bmc"
and "wedge400-data64-bmc" are identical except BMC flash layout.

Patches #9, #10 and #11 add "fuji-data64-bmc" board. "fuji-bmc" and
"fuji-data64-bmc" are identical except BMC flash layout.

Patches #12 and #13 add Meta Darwin BMC and updates devicetree
bindings.

Tao Ren (13):
  ARM: dts: aspeed: wedge400: Fix DTB warnings
  ARM: dts: aspeed: fuji: Fix DTB warnings
  ARM: dts: aspeed: Fix DTB warnings in
    ast2600-facebook-netbmc-common.dtsi
  ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dtsi
  ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
  dt-bindings: arm: aspeed: add Facebook Wedge400-data64 board
  ARM: dts: aspeed: Add Facebook Wedge400-data64 (AST2500) BMC
  ARM: dts: aspeed: wedge400: Include wedge400-data64.dts
  dt-bindings: arm: aspeed: add Facebook Fuji-data64 board
  ARM: dts: aspeed: Add Facebook Fuji-data64 (AST2600) Board
  ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts
  dt-bindings: arm: aspeed: add Facebook Darwin board
  ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    3 +
 arch/arm/boot/dts/aspeed/Makefile             |    3 +
 .../dts/aspeed/aspeed-bmc-facebook-darwin.dts |   72 +
 .../dts/aspeed/aspeed-bmc-facebook-elbert.dts |   12 +
 .../aspeed-bmc-facebook-fuji-data64.dts       | 1264 +++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-fuji.dts   | 1245 +---------------
 .../aspeed-bmc-facebook-wedge400-data64.dts   |  376 +++++
 .../aspeed/aspeed-bmc-facebook-wedge400.dts   |  366 +----
 .../ast2600-facebook-netbmc-common.dtsi       |   22 +-
 .../facebook-bmc-flash-layout-128-data64.dtsi |   60 +
 10 files changed, 1804 insertions(+), 1619 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts
 create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi

-- 
2.47.3


