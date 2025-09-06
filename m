Return-Path: <linux-kernel+bounces-804049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D69B6B4692D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 07:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972045C310E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 05:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB5627A444;
	Sat,  6 Sep 2025 05:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4N2Z4Wc"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3891F4C8B;
	Sat,  6 Sep 2025 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757135458; cv=none; b=W1pusROCgyG8e+V9xRbYR2ImtrjbViQbendWeTfNAA8tPpaEczfNI1W+8BRA041hXMH8YO2bP32tbgVOk0DDX+0r3EI14C0opceM7rzjbzk1P5r8xEqJ5eZiftwHiL2B18Ul/VLGrUNHcVjkCKDHgH0j6uiU9CkV/fgf53IfIXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757135458; c=relaxed/simple;
	bh=o+FaEWcsuObUNv07NnL2n6St+0yeCtdSIOD17oMGGwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnhe5brgbB9WqK0GDa3fFNFTSVNkpuYXW/WWs88OSvGPt25M+cZgm2xilVaglb3/U8Yy7jiAnJBTD8n8VeePM391RD9PJC7DObSK5XXfdYsEOr7osvb7Cy2bYg8o3WoQlvmpVhdBchFyg+fP8TVnj+mqEjBXDyORGpSlGhBnclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4N2Z4Wc; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32b02d88d80so2441711a91.0;
        Fri, 05 Sep 2025 22:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757135457; x=1757740257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NyCEsVkz56P0H6XVc95lmqF2qsvWh4kZKhuPs1kvLI8=;
        b=c4N2Z4Wcdv0u+cFbYWWqk6gJ8OD4+6EIWe3B8k8TGiNMBICbFUXQwc1Z6IKsTpihSf
         Fbif3mAFEzTCzub30E6uxT9svr68qUosvNp86teFbRe50Xn17HpGX9DBc/oUNtFrgime
         JeiY1i72ELdESBeNkX2DvMygB8lqZW+EKwmo46SjrpSvpw4gTKDU4F221QyN/Pq5Fqta
         KYZFq8ZbGIKbogZQeOhiXMi/y2TCAp/DOEsrGLfStZpgWJOeqIg3ZrokQKobeUu7ncaB
         9SKpS1eTif4VZNfpWmzkR2pjg9z3OImxG5O2D8nKqT6mgBxz27JQTGKT6GgzRQGSxjts
         Rjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757135457; x=1757740257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyCEsVkz56P0H6XVc95lmqF2qsvWh4kZKhuPs1kvLI8=;
        b=qLS05G8pbNvTpfcHJz9VrliKcddCBDek4D+DFbQV+ZIkdyqmN7Xh1YBY0lbGtLIoBN
         AhImtb3/J2uF+5B7t+NFoo5WUUH3+IMegmOXc8pmgh7USGeRmeCuo8eBzQopXVwPkZz7
         +63BhmcmD0xuvY1QrCWq9zYbD/LYNSocPfMbuPo7WG9FNPWYfWOYu8WcCrJx0/7pS3zg
         k5Mefgn5v/CjPRTGUnjAynOXaq1wWpotH8WJqY2j+x0aotu9OVvdko7pQp9/VQQRQhx8
         4xxZ1fKAt7uwGZGiOyhb16DC+hjJQaER1H6ypr4H19XqWT8v+bHc6ZRG7aOl2A9CLJpS
         ogkw==
X-Forwarded-Encrypted: i=1; AJvYcCVevmvcCkpQk7LS8Hs7uG2eM/VmsMK18lw1wcHbDWcrsJMZ0g5j8Jc+ZA7U1VPvmcE5pBF4lYhgE8/x@vger.kernel.org, AJvYcCWCer9Z75B+Yw6i9F+F2b/W8VbE8yYX8OkyR9b3tPUDrvEAax5VqAt7XodvjHEZNngmybj2zYmDVDH2WWho@vger.kernel.org
X-Gm-Message-State: AOJu0YxC+fmGtIThcu9MytmKCI9/OvgyymMW28pTvD5n4DFY6rv3QOAx
	YUBEnR+Jq7vZOFu6cJVlZVyyODTpx2Bd81Pg2a23wjJA6kQhjyeQvjww
X-Gm-Gg: ASbGncsFHWHqvTMBPjnUxdQWCbdDHL4SiyhEEJz9Q8iTGaCsF5c4BQrEsWUSWiAhxXo
	nuYQYog2u8IS4oaaiyRY8eK6sLqXOgfnXBFa2mrkcUBGQRn9YdP2DMldghoObIOl0mQAYm2Ejvh
	cK+pHhXfpWlPF5C5p7icGbmE8GEPsEiOwoH12eLmu41IVmVcT2oKdWwR4l4HUp8448d1MGd/8SD
	Y6F0Lu+JMQkKNNu7Qj/fa+47ljQKnBzJqWTMfH/qz+1/LXayGVE22M2Aj8dlmuD37NduqcXpRqM
	MFpTVObQ6/c6XyJAB3jHRrOj/752OoU2mv2zEE2GPOzuuOgYehSKg6GuWOUkAQl+gMGE95ZESla
	UbTzW35zfNsJ2MOElsNzNLaa+hmoAlFBXdbLIVByeg9g11+1s5fBnQkxMkiMjO4q4SpFSMKpeGW
	/rKVg=
X-Google-Smtp-Source: AGHT+IEbqxIC1ZDHG+4x5cKgWayxq+KLYeeZ6CompJmDyX8L0avdWaUkIhYpZkA0+MIDHTULSuBg7w==
X-Received: by 2002:a17:90b:48cc:b0:32b:6145:fa67 with SMTP id 98e67ed59e1d1-32d43ef52fcmr1605728a91.2.1757135456725;
        Fri, 05 Sep 2025 22:10:56 -0700 (PDT)
Received: from localhost.localdomain (36-231-187-52.dynamic-ip.hinet.net. [36.231.187.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329d8ca7aa0sm13118020a91.19.2025.09.05.22.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 22:10:56 -0700 (PDT)
From: Nick Huang <sef1548@gmail.com>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: kusogame68@gmail.com,
	pumeining@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	n1136402@ntub.edu.tw,
	good@ntub.edu.tw,
	Nick Huang <sef1548@gmail.com>
Subject: [PATCH v2 0/3] dt-bindings: mfd: Fix typos in PMIC/BBNSM documentation
Date: Sat,  6 Sep 2025 13:10:37 +0800
Message-ID: <20250906051040.22944-1-sef1548@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains minor typo fixes in the Device Tree bindings
documentation for MFD nodes, including PMIC and BBNSM descriptions. These
corrections improve readability and ensure consistent documentation for
developers using these bindings.

This series builds upon and complements the previous v1 patch:
https://lore.kernel.org/all/20250902142749.13724-1-kusogame68@gmail.com/

The patches include:

1. dt-bindings: mfd: nxp,bbnsm: Fix typo in documentation
   - Corrected "Intergrates" -> "integrates" in documentation for RTC & ON/OFF control.

2. dt-bindings: mfd: rohm,bd96802-pmic: Fix typo in comment
   - Corrected "contolling" -> "controlling" in comment about SoC shutdown and PMIC control.

3. dt-bindings: mfd: rohm,bd71847-pmic: Fix typo in documentation
   - Corrected "abd" -> "and" to improve readability and avoid confusion.

All patches have been signed-off appropriately. One patch is co-developed,
and the others are authored and signed-off by Nick Huang.

These changes are purely documentation fixes and have no functional impact.


Nick Huang (3):
  dt-bindings: mfd: rohm,bd71847-pmic: Fix typo in documentation
  dt-bindings: mfd: rohm,bd96802-pmic: Fix typo in documentation
  dt-bindings: mfd: nxp,bbnsm: Fix typo in documentation

 Documentation/devicetree/bindings/mfd/nxp,bbnsm.yaml         | 2 +-
 Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml | 2 +-
 Documentation/devicetree/bindings/mfd/rohm,bd96802-pmic.yaml | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1


