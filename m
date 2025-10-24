Return-Path: <linux-kernel+bounces-869024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA6AC06BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 865D535C9B2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6238131352B;
	Fri, 24 Oct 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGCqHcJT"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE1C2264D6
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316631; cv=none; b=CJG8ac0dStOHKvPBEzm21zwH2R5dDF25PbwUFLMznQe5V6vOkRRhMseiXLlmi5DhAYifOEdn9lMGrWl9l8QiIe88LZJXwR8jhtMhzF5RXofiuawjvhE+Hm+Ux9EQXFvLXiUOIS0LCPZJPHQeLVMp+zF8NaOqTjTU7lj0T5oBnvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316631; c=relaxed/simple;
	bh=5bzAQm1vpD7lTerhTYq37aTukVXzrzouyw8pD23L98Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SXBNBM4/NsizCcF+eSZdOXdlQNKu8Do/4ChnhVMKsO/RnZIq7CZOfMWHmGD7vthjTt8XpI/OZ7Qz2DrscioTX00SdTradYk90DQx5S8phx33SshA/Uiysfr17vrsO97BVtwZRdiHaZ0uvIFYG/gJKyeyzUDj2p0EbxMegzelHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGCqHcJT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a2738daea2so1891635b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761316627; x=1761921427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z3plulC99H/+7ueocjB6qUXe51ScV5oNChMwjLtEQgQ=;
        b=SGCqHcJTyYG0CXfKAJ546w7XJZcym7C8Na1ke6Qybwi4UeJ9v4McgfcVa3hqidCPYt
         ZQ8cA5Dx6/W0Na7cFT77nEMNfYpCQdaWx2sDQMsJp6Pn+RUiBkrfW0uwXydmwGEkXhMq
         yL9a+tFGEA/JikU2njwiscCc0e/i8tzRtkQO0Qw7Hvb/r+r6PQYXiHTtyAzfu0As1alz
         PTy5D1XuSTAGg6Yih0VEpUx+L1DLMAPNbnkBgUOymQpthsy3McmWr0teH8qrgEiPHleR
         jBZ3KEpsQ1SzLacaVZOqeTFjd1f7Me12a13ulQoHJxOb/CtvAhoCTDdfK5yn7mlt/xOP
         XkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761316627; x=1761921427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3plulC99H/+7ueocjB6qUXe51ScV5oNChMwjLtEQgQ=;
        b=aDLCaC4UKKt/Z040EBB7JYRrNxNyOdxVvFmAXI4WsHAOPLihQd9GLcdUl9M+85Zbr4
         JdOxfHi2q28oUbh40H21WUPRCC1ftEvyR94DSJyY4F5hswbAiVLo0tXy0vqa6qRBQ4YG
         mFpICakUR/pOEN3wTVvBnc8AlNubNTwIWtUx4eRzb9lAPVqgoPw8FQGolMV/pPJcs77o
         cJl4IaKV9AY9NHKHbONKkQR/sA6wabhTt8IyAV/3CCpyQOJKf0odACcLd91TPqqa+xMa
         IPtbZzsplDak4fl2KX/CRPsVPp6/dwZpO4SnlJFh8P/y4NLrCnFdrulD4MHSI0PKFqnA
         /NGA==
X-Forwarded-Encrypted: i=1; AJvYcCX+iuEYEgLCfOCqKpsCbuM3jSf/i/dQ/jG/ZNlntP+FKus6CaovFAgGO5hDalpT7wtUz+qMeX9j9/epU/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6uQryL63KYWtsMX5gtj6F2JX671uFBRGO687lDxCA+JF6M/ol
	9eMAP8e2SClKkgNyzffzfPgM+Fdenj4pUQCRSOn79B6WL0yMu/EE6g11hCKZ7w==
X-Gm-Gg: ASbGncsQql0Iea7HOmdT3v98w1A3CASfRa3oBaYCUMyjYydWn9+j/dchgzNmoZYQb7U
	en3CUIfiieTDTqGCRmCbGOng2YAyZS0MQ7qZEXybGxp842NA3oLOGHjcmndATNnTf7bcFoMncVy
	xNPwao5lsXpDu2uJGc2NaxejQw91LjKyzFBo6B5EubhfxtK2CaL1VFgv+mAnYq5tEQW9m/wh0hq
	mf8STPz9blYYJvtfhGn9UfkZHnf0dZcR1p/5jhXl95pjt8dc3smaLldC+ReEAzSwCZKmS4X0QHL
	lP7mGWwC9A+Cri48gxqmt4FauCO+qfaulWL1R/0JFtw31NCwQdpYHs5dUPGymzIX6YXL1w58BWi
	FwGTWQHX3CNROX1hPt8ZjzGXbvK+L6O7Nvz2Ny2JNTN48Ajdjf7gW1pNQxK6vhdDImlpEevLNm7
	5sqx/5m4pYi50t7fAzuclbADFfeF14O5YKqg==
X-Google-Smtp-Source: AGHT+IEAG9dCd057H6ZgsQJv28clY3E4+KDoFKMP468zgwqODZ4ztBCcpbGHu5MvdqVczkpUggcgHQ==
X-Received: by 2002:a05:6a00:1ace:b0:781:9a6:116a with SMTP id d2e1a72fcca58-7a2208f0777mr28482023b3a.9.1761316626603;
        Fri, 24 Oct 2025 07:37:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8a0edsm6091469b3a.35.2025.10.24.07.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 07:37:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.18-rc3
Date: Fri, 24 Oct 2025 07:37:04 -0700
Message-ID: <20251024143704.1144808-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.18-rc3 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.18-rc3

Thanks,
Guenter
------

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.18-rc3

for you to fetch changes up to 8dcc66ad379ec0642fb281c45ccfd7d2d366e53f:

  hwmon: (sht3x) Fix error handling (2025-10-19 18:56:14 -0700)

----------------------------------------------------------------
hwmon fixes for v6.18-rc3

* cgbc-hwmon: Add missing NULL check after devm_kzalloc

* gpd-fan: Fix error handling

* pmbus/isl68137: Fix child node reference leak

* pmbus/max34440: Update adpm12160 coefficients to match latest FW

* sht3x: Fix error handling

----------------------------------------------------------------
Alexis Czezar Torreno (1):
      hwmon: (pmbus/max34440) Update adpm12160 coeff due to latest FW

Erick Karanja (1):
      hwmon: (pmbus/isl68137) Fix child node reference leak on early return

Guenter Roeck (1):
      hwmon: (sht3x) Fix error handling

Harshit Mogalapalli (2):
      hwmon: (gpd-fan) Fix return value when platform_get_resource() fails
      hwmon: (gpd-fan) Fix error handling in gpd_fan_probe()

Li Qiang (1):
      hwmon: (cgbc-hwmon) Add missing NULL check after devm_kzalloc()

 drivers/hwmon/cgbc-hwmon.c     |  3 +++
 drivers/hwmon/gpd-fan.c        | 10 +++++-----
 drivers/hwmon/pmbus/isl68137.c |  3 +--
 drivers/hwmon/pmbus/max34440.c | 12 ++++++------
 drivers/hwmon/sht3x.c          | 27 +++++++++++++++++----------
 5 files changed, 32 insertions(+), 23 deletions(-)

