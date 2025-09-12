Return-Path: <linux-kernel+bounces-813821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B857AB54B17
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6685E4E1CFD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5375B30101F;
	Fri, 12 Sep 2025 11:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyUbVphU"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA1B2F28EB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677025; cv=none; b=dUImCKFKq9UbBiMvElogCaeQqVyayOUV32sXkorp99lGx5uy+y7YAQCDNkzxnBSIEfBtYitUOJCBnCKf+P1l76ephRaQHK6KLa1rqEIJ0H3WP3flIPXJX4gxXdhASB2kEglYvZ91TK+mwPeJ0pqc74Ciynq9iX97n8ECeL4RT+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677025; c=relaxed/simple;
	bh=W/d05Ah4gZEm/6xcEdlciMhi/OilrDK1p9IjJYcMRLo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YnyHiGnPCNtrbSilDHGRxFUC2lJidu2hxA14wMZcn0igqWU22UMVURvXlKwXI1ApglSM2gPei11GPO33Z+OpZUWNWue4Pe6RvDtmfoLONqzn+EBHM/ND8BjdAMg+rooPfnZLaWP5KZsaJEbm/2R8Er43TVfOqOyu3HYGwDUiuWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyUbVphU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45de1084868so9060325e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757677021; x=1758281821; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tbnb5qYeKlx3hN1o2p4vVBHs68NjGI4FeyMjq9mKLyM=;
        b=fyUbVphUwVUmze5Vc/3hWFiAOvxhvLkhzXwzmf01l1nWYeTawF3/PyTagKYa8dbNom
         XAZyrKhsJtSDj77tZ+heZaBH3IQZni7TVr2vnmmX3rlouWyGNtLqXNLqBoYEIRLCM1da
         akObx0gAM+zJpd4mZPN3P/6EWpSjFABBgYxvAiqK7diD028/isOYgbqTSWcl27VbEmgt
         dNc6HSls3XRuUh5TnXflGGI10Fnb9cPHZUlBacClXs7RTCQwUVd5aymtyi6No0kEeFDJ
         B0y/zTzKWRAWncM4yT8CR7y6X04mY2g7pnLfKGmmwhhucrtp0GEL7ygq0+YDZ5wFPBlW
         8uHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757677021; x=1758281821;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tbnb5qYeKlx3hN1o2p4vVBHs68NjGI4FeyMjq9mKLyM=;
        b=cueNQjZiOgvlia17zDnInxjRKIdP6H2d5RA8wnt8t/a1KqhJrOOKBIYxxLrTzUrOSO
         42/kds6RCrf3plmARQPCqUWWtaZwbUP2476fsgk+RYRL9x4m/RHt1+PZTejlKh2/Sv8L
         2Nk9S7YYId0MhU9MiddPcEwHbklgbixcYFWmp+On2BepVWE9ICRuag4YT/BXVMcFOsxc
         iM/7UUboyKXm6dMURlS8R4WRu5nMliXoldSCapbvYDfm77KLs7w9ImI4qyM0QaDAFiO6
         LqlWotz4xEFUpPoilnPB94ZOkxJg22bBy9fIOYxUBiJKkcVGhzVlGtl8Zjg1q9paWmah
         7n3Q==
X-Gm-Message-State: AOJu0YywP5x2BLMof2F7C7cFJMn1aiJGWiYsJitxOADTvc3jpHf/C9yR
	CJ19/aOOt4aU1GQLAvmzbyZEWi4mMTj2BaBcG4zYq9RdyYKl1OsLhSBSI5q9FA==
X-Gm-Gg: ASbGncs/6FLWzlJDVIue27bXYK1mTOi04rP5WM341KzNRHZt3TnOju7Ksc/iAto8AEK
	P6QccUCJOGSkJ8+XDwONaptJhQjM35UtuOB/mPIf+YSp4wnPKXwNt1PxgqFYOUtS51R3FO0Ttsp
	7TaA6pzr6KsXnztZIxOdxMgXIiMzTvGcmyVxM2ZR6pziRNvHTLckUD5ibcU03LMpYIhV2yqqbwC
	OJCgo98ERl5Ss5ntaHwj2SfePVfu+VLMGpW/9+OjSYKhitPnaccJtvLy8wtMqNJKLvRQz2nZdMr
	Cbc9OmqKcmx2SvOIqjhbmiNiM/b4m3/sPf9KcIH4GOx6y62r2sE7TRp0c377V/E3ZMPlO7/Ic+T
	qG5e5cL8Cq0nEs64ebKw37nSYozzM7FxjGg==
X-Google-Smtp-Source: AGHT+IHD1EhTqy1kILkNX4aqLwbC3vOYUogeq+zQjgxWO9vkCOKW7N3eFQcOHrtSmgitSOXwjOi+4w==
X-Received: by 2002:a05:600c:4453:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45f211f2fbemr32051345e9.24.1757677020864;
        Fri, 12 Sep 2025 04:37:00 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45e015621a3sm34806145e9.0.2025.09.12.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:37:00 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Subject: [PATCH v2 0/5] STi drivers cleanup
Date: Fri, 12 Sep 2025 13:36:07 +0200
Message-Id: <20250912-master-v2-0-2c0b1b891c20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKcFxGgC/zXMQQrDIBCF4auEWdcyWoTYVe9RsrBmTAZqLBokJ
 Xj32tAyq394fDtkSkwZrt0OiQpnjksLderAzXaZSPDYGhQqjQZ7EWxeKQnttDM9Ov/AC7TxK5H
 n7YDuQ+uZ8xrT+3CL/H5/hJR/okiBQo/tyBrrlbpNwfLz7GKAodb6ARkGYeycAAAA
X-Change-ID: 20250908-master-5c5c980cfb03
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=W/d05Ah4gZEm/6xcEdlciMhi/OilrDK1p9IjJYcMRLo=;
 b=owEBbAKT/ZANAwAKAechimjUEsK1AcsmYgBoxAXLeqm8EM6Ln+ijCpBNbKP4K9a1DvPX3NsAN
 IYYCf+yf5aJAjIEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaMQFywAKCRDnIYpo1BLC
 tQGuD/dVI8gwr8NeJogDt/gJ257+fspO6NaaYkH/dEvRdGjup1CfAOfmAiu632NRwxuhcnBapPz
 /A4h/qVY5OFES7fLAtA6cBemnuD85Lgt/gKhMnkQaVNQeIrNDpCPEJnwzgs3QTQFc1FABo1PTvK
 mAfl4wTDBWmiHcuV/0/XzM9EGj8cxwOlRCugHE8ar4ff4/8On/eG8wdYbPkeqVxhZYoaXuYcsyV
 nkv2lqZTJrxK0/fKv3K+HVm6myXgv+EVUmhtxtjYPIlenUrVXP8OnfIRq/9rSXq/AeonG+A2f+V
 25LaXemjFtPFelIfrpAf9sdOZCA5z5t6JoYSLjhAaMc3UbF8Fgvi+ykgkuO6zhpeeWSAsDJ4OMg
 72FzCauHRkZ0NXwLebFweKXtbdw0UcnShdZLlAVgXUbzSEb4SlQVBD0SynMoi52zNoA8XWvR8Ow
 nEsp1c8FAjQnfQF+tJW5pwZuOl5J4OTHIhArBUHDNzbwaJUEtO4Zn3Pa5yRghrEdT8vIhXKSWPk
 u0j7RxMgLY9WJ9qBzOs//PPK9OUReku1RrHC76pQuZJ5xzMvtL23dSZgkn7Z6rXgbOQK6+/D145
 XyR/JO24SaQKWLBt7GLEoK1EPIo6QN/FaBukh6xMD1AYrwcW/3MNZaO/DpIpRjn3NqE/HQRD7VK
 OztxzeMRN/6m+
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

With B2120 board removal[1] several drivers are left unused.

Remove the following compatibles:
- st,flexgen-stih407-a0
- st,flexgen-stih407-c0
- st,flexgen-stih407-d0
- st,stih407-c8sectpfe

[1] commit dee546e1adef ("ARM: sti: drop B2120 board support")

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
Changes in v2:
- Fix Patrice's email
- Documentation:
  - Remove media admin-guide c8sectpfe description
  - Remove c8sectpfe dt-bindings header
- Driver:
  - Remove c8sectpfe media occurence in platform Makefile
- Link to v1: https://lore.kernel.org/r/20250911-master-v1-0-5d5d5ea9af22@gmail.com

---
Raphael Gallais-Pou (5):
      media: c8sectpfe: remove support of STi c8sectpfe driver
      media: include: remove c8sectpfe header
      dt-bindings: media: remove support of stih407-c8sectpfe
      clk: st: flexgen: remove unused compatible
      dt-bindings: clock: st: flexgen: remove deprecated compatibles

 .../admin-guide/media/platform-cardlist.rst        |    2 -
 .../devicetree/bindings/clock/st/st,flexgen.txt    |    3 -
 .../bindings/media/stih407-c8sectpfe.txt           |   88 --
 MAINTAINERS                                        |    1 -
 drivers/clk/st/clk-flexgen.c                       |   80 --
 drivers/media/platform/st/Makefile                 |    1 -
 drivers/media/platform/st/sti/Kconfig              |    1 -
 drivers/media/platform/st/sti/Makefile             |    1 -
 drivers/media/platform/st/sti/c8sectpfe/Kconfig    |   28 -
 drivers/media/platform/st/sti/c8sectpfe/Makefile   |   11 -
 .../platform/st/sti/c8sectpfe/c8sectpfe-common.c   |  262 -----
 .../platform/st/sti/c8sectpfe/c8sectpfe-common.h   |   60 -
 .../platform/st/sti/c8sectpfe/c8sectpfe-core.c     | 1158 --------------------
 .../platform/st/sti/c8sectpfe/c8sectpfe-core.h     |  287 -----
 .../platform/st/sti/c8sectpfe/c8sectpfe-debugfs.c  |  244 -----
 .../platform/st/sti/c8sectpfe/c8sectpfe-debugfs.h  |   23 -
 .../platform/st/sti/c8sectpfe/c8sectpfe-dvb.c      |  235 ----
 .../platform/st/sti/c8sectpfe/c8sectpfe-dvb.h      |   17 -
 include/dt-bindings/media/c8sectpfe.h              |   13 -
 19 files changed, 2515 deletions(-)
---
base-commit: 8f21d9da46702c4d6951ba60ca8a05f42870fe8f
change-id: 20250908-master-5c5c980cfb03

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>


