Return-Path: <linux-kernel+bounces-734742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B76B085AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB7C1655FD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF3121A44C;
	Thu, 17 Jul 2025 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="Ulg6Kocm"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9F218AAB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735492; cv=none; b=fLKSSdqx4dew7Sc1+HY2P3bqkkMIps+sVXxi0w1PHJL7mHzs1NNx6wWkbkKRwHeokoKAN6vXLLSYY2+2IISp1DsYJryb+WInSSPrdOxos7d/Zpg03glSpSUnvCCiLxd9kjBCz3RVkb7Ev9fEsiZ6IujXGGHTc65I3FW12DtiZBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735492; c=relaxed/simple;
	bh=GS8FKUFJnXN4vb3m8ja3wGK0qiCPE38bwfUfDE5aU6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=selMvYaOLwgK2lFrvBJ7jdvdkrfVpTHq281hEeAZkgD8er2r531qT8/+m67y41BROZ8VdC1f2PpHzELpNNmfJ34u8yygWaTdvFpTnf8Y58zlGOc60NXW9WMYNbvCpEDWrppQAtOfoiNUgUebSL98bpMYNYWjMIxD0KJzMejMUx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=Ulg6Kocm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7426c44e014so646836b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752735489; x=1753340289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QwaJ6+SV8dLr3sbsgOJRijgIEa6kBPmB3FaWrqGQmI=;
        b=Ulg6Kocmnw3etoxSdBHXpEbVJgV1zanWAK9DP1/a79e2hY28cNdJfdT6xsOVxHrLak
         c3ZyxiTtuprGmSUoBYjY9oCjjwjiaUVfaYwi379OgV6vy2ufG+AcUnI7u67BcHs7ymTl
         bfkTFKw6uxoRIfJ7UrAO6XChwuah4CoQoc1drVZ02csVCwfl6wrnax+2gEcOaHrSR7SP
         8e1FBLVO4RSUWm79KoSftIawgjbLVH93V0lUph4VGNGy+uDY2PSVsPNRry0dfvVcqopu
         mLmUgSKTNVHeF8DFxpfemkbMeg5LA4wT0F0hieWGRjOngfL01N2iaM5MF2Ez7PaxVQhG
         C1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752735489; x=1753340289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QwaJ6+SV8dLr3sbsgOJRijgIEa6kBPmB3FaWrqGQmI=;
        b=efHuBvoUgegB736JWlULLrfw402L9bNlsEfK/hG9t0sMXwhPAGZMs7Avlr1ydv6aze
         OEEeF2CJcAMnP6sU0VurqMmyf5+GLPXx9ZMfOGhck1RdRWhnVAssWv4ZaiwrKAjiMe5T
         XzKku+SnoP00JQlk0Eii6GGmJpiv3vKgdh0TTH9Mmf537oGBuFpRGq1Qx0MU9S0eGnpx
         gbE87+tzl8CpumHLsWRCbHi1rfPN2eL8P5MwudgC4AfTgxMcW6AExQJJUSg1MCR83z71
         g2uyMXghBkxT+vhsqemdh4cqNfYVde+c2NxjtuoK4q7YIZU43jPBJbcpKANstbrsdg+T
         FTeA==
X-Forwarded-Encrypted: i=1; AJvYcCUoQm377XQ9sbRQFraL6Wl8A1yCfdZO6VmfNRn1i50hw24BK/g1mCPGZGCpi/ezhYcmJcqgtzhudbtvWQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq4p4bcG4EnINlJP1vQ0sbAeAWBD0z/gezvWHCQXxMsWc8u+4u
	04tqUwIhYMOjZ9sa5MwUY0j9UqT5y+raJLGyoc3iqUstt5WmtR9vWC/yT8+b8Be92VA=
X-Gm-Gg: ASbGncuytoh28FlPrcSZdqUKT0wjY8GBgK54gBvLJ0gYttGI7Wc0BRf8Ql+KMfFOoxZ
	lg3D0nZJMSHgU57vauIFO2HPiAvtkMKScvkTxC3NGZzXDZlJaG0nFa1QgXRbm/rx5OtQ61Adbv2
	rdvP/GhUsVFoKEzUaxVPTv7KLYmQ8yKaR8lmHlKIwTPR6NeVb8HgNGu3enXZfozqBd9koMNS3m1
	3kqsQpPKnkF/TwI1qjQ9xhdhwnCYeYsJo2CscVYD5y4Iq/VuRY5UOsU11vx7R7EkKkDCck8cMOf
	qF92xJ24w6TYQm40Ksn1sjAAaMoCUnFP6xAB7HNK0nEIuwVtkgJaOuMstiATN2n/l28xsXy8n20
	YI70YB+owM/MGrUryh3rfwfZc2W0f+igWubxNb43rrHGMHX66cSzh3Q==
X-Google-Smtp-Source: AGHT+IEseKIfJqtbOw8gzUyfRbVBbKBWLtecuTXecrmR5KxL8XgEfMZkeKCbA0k+p/mbsZdrQYExAA==
X-Received: by 2002:a05:6a00:1707:b0:742:a82b:abeb with SMTP id d2e1a72fcca58-756e7acf5e2mr8654099b3a.2.1752735488782;
        Wed, 16 Jul 2025 23:58:08 -0700 (PDT)
Received: from mystery-machine.brighamcampbell.com ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4bc51sm15157293b3a.116.2025.07.16.23.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:58:08 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
To: dianders@chromium.org,
	tejasvipin76@gmail.com,
	diogo.ivo@tecnico.ulisboa.pt,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH v3 0/4] drm: Fix bug in panel driver, update MIPI support macros
Date: Thu, 17 Jul 2025 00:57:52 -0600
Message-ID: <20250717065757.246122-1-me@brighamcampbell.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes the unintuitive mipi_dsi_generic_write_seq() macro
and related mipi_dsi_generic_write_chatty() method from the drm
subsystem. This is in accordance with a TODO item from Douglas Anderson
in the drm subsystem documentation. Tejas Vipin (among others) has
largely spearheaded this effort up until now, converting MIPI panel
drivers one at a time.

The second patch of the series removes the last remaining references to
mipi_dsi_generic_write_seq() in the jdi-lpm102a188a driver and updates
the driver to use the undeprecated _multi variants of MIPI functions. It
fixes a bug in the driver's unprepare function and cleans up duplicated
code using the new mipi_dsi_dual macro introduced in the first patch.

changes to v3:
 - Define new mipi_dsi_dual macro in drm_mipi_dsi.h to reduce code
   duplication.
 - Fix bug in lpm102a188a panel driver's unprepare function which causes
   it to return a nonsensical value.
 - Make lpm102a188a panel driver's unprepare function send "display off"
   and "enter sleep mode" commands to both serial interfaces regardless
   of whether an error occurred when sending the last command.

changes to v2:
 - Remove all usages of deprecated MIPI functions from jdi-lpm102a188a
   driver instead of just mipi_dsi_generic_write_seq().
 - Update TODO item in drm documentation instead of removing it
   entirely.

Brigham Campbell (4):
  drm: Create mipi_dsi_dual macro
  drm/panel: jdi-lpm102a188a: Fix bug and clean up driver
  drm: Remove unused MIPI write seq and chatty functions
  drm: docs: Update task from drm TODO list

 Documentation/gpu/todo.rst                    |  22 +--
 drivers/gpu/drm/drm_mipi_dsi.c                |  34 +---
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c | 187 ++++++------------
 include/drm/drm_mipi_dsi.h                    |  46 ++---
 4 files changed, 92 insertions(+), 197 deletions(-)

v2: https://lore.kernel.org/all/20250708073901.90027-1-me@brighamcampbell.com/
v1: https://lore.kernel.org/all/20250707075659.75810-1-me@brighamcampbell.com/

base-commit: 667efb341917bde19f5d7517b65defcdaed67c9e
-- 
2.49.0


