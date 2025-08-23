Return-Path: <linux-kernel+bounces-783024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55941B3288D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FF85A8739
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DED25C6F9;
	Sat, 23 Aug 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO/M8lPy"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BF02522B1
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953021; cv=none; b=aMS/jBwqPcA7RKd7roNx5MoQK6vP/2xa6r/mC/c6cQx30QUewZ+nXeiwzoTQABTYQ6cnzvEleWnb1PBqjLYM5WtUciVHEFx3YIacNo6O+TW7/jdAKEwBtmyzwrI33HnR/JB3QavQPtLch3vayWyCZHwGPfEe/dUJCGfQ4YK3cxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953021; c=relaxed/simple;
	bh=YIikSvCwL4fgtKBGPzG7IRo8UVfi03Coa+9G7HcIzrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kx+mv4mSXn1EO4TcutMe9pJ9D92SiV98Q0RGaHUK4AbO2kiTmxBAMiTkD094XqNEk0Jl5RpkHWnKLA4ina8qEJ/ltPdfAM7MtawsfXW3ojfAWadz0OhJ/TNu+Xr706WCl87dw+rm4DeH/S7hOOicNmv3TVtSYEW1BSd+xbsm3Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO/M8lPy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78da8a7so448932866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953017; x=1756557817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G+w7hdy5uL013HNunk5Svr2/NlQYQi/VIxI5ZhfFEzA=;
        b=VO/M8lPyb9BXen/cZb6HA2eP0Dxh3C5evpdeBSzn9IIltxheK9Km3LlAQesVZkVEaU
         F4fyfy/t/B9beQ9/sS8BIq3QVbz3rTgVAWuXdWz4yJMhSulbL/m5IvxikA6JXEyGo8W5
         uCQrYYAi/h/1tn7EZsoGKnMNvAkxvEFa0sUN1XPNPX12lnUfFu3wXl52BOAiC/rsHR4V
         D1Qem3OE7jKzkusL+qUJB09CnxG7jHDKE8bQdnwLpSiecH2VpqYOi5TPpBUgXAKO6ljt
         4021w0LQVLcySoETK/6BZWfCiSb3ECo24lYTjmwgqHSgg4ILnw2TT4hubZ2DEyCJq6ip
         gOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953017; x=1756557817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+w7hdy5uL013HNunk5Svr2/NlQYQi/VIxI5ZhfFEzA=;
        b=LEiuJDGNZtNCJBvlIBDgVCEG2ROTcOKkO1fuA/LZmWKvD1yYLL/c4l8KBJdXJkgHzV
         +kaSVHK0LC7EhdbVqrDMzM6Vll5Y4ZsEnDKqOxM2oITHeQ4wHheid0lt7q0FwzQ+DJKL
         3MKbTAjZMTQ23uyKZJn4VD/a6RBwKt8lnAgS0eFdGQ9En5CoblnMDIkrD6oJOjKADFFT
         kVUidRk/OKC++onX/ETMYxl/h96CV1bdLTmnddd7YGCZv5cIPCY5khu95ma5LSweNmBg
         TT4KCB2sKOIepg+HOKxXtKXkRdrrqXxX63ubj46p8//iqmt7jxxseY0xJGB/BZ+Np+iA
         LHIA==
X-Forwarded-Encrypted: i=1; AJvYcCV4dAcKMGDxo80qHoh5JOAPj1/zp65BH2zzhS41ovpkpqm3qdPjDGSuiZCukG5sdvELC4Gvs/xu6YGw2/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlry2MDaI/o+hI+BD8lhwZxLmKF9OdxY7J79P96sFoQYCo3rD
	7Hvz3D1OvBP1ST9n+p/G4qBEvkabpC8e2ruc/hEBCINaH9vaItN3ZQcJ
X-Gm-Gg: ASbGncv2C80VzdZ3r1ihhVyBz/M58MXaDmYrBc/WyfDrilmyPlD2lxmTQOhLnJXCP/x
	NsKnJww43VTfj5jUbsah7jtflID1wIqeIBGKUcY1NmWIE199RVOmQ/v2xMS5lzWvTYWXAkMGNtj
	EmKL7dqSczh6m4QyXvFxOATvYI/NEa4d2m6nbsClhNL3D61Q9PtSHDSmdP1HDLjJ5J2r7N9qPIq
	SxGMhxI86S0cHqMmU6nbM1/zf14mXfqzrtS5Uk/QOEkHHOCDdmqz9jSi6ghU/NeGhMj+OC5FfE2
	U61ZjRpZ1AEywAkydhVjdh9t9HEeLeerfMOX7uNe3aJXvM5dn4g5Y5YPhOIrPaQvchqA6YC3039
	FhR6jI7TZ/x2UiyNdruozVc4eOw==
X-Google-Smtp-Source: AGHT+IHYTgKq2UJBbSR4c9S8K/8myhf1eFPtQrwBFMbW0Fh3s6SxAw6ABjkuJJBZkcnsmixJ6UZkhg==
X-Received: by 2002:a17:907:86a6:b0:af9:34d0:836f with SMTP id a640c23a62f3a-afe29446a55mr574315866b.27.1755953016672;
        Sat, 23 Aug 2025 05:43:36 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:36 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 00/14] staging: rtl8723bs: clean up efuse related code
Date: Sat, 23 Aug 2025 14:43:07 +0200
Message-ID: <20250823124321.485910-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes the boolean parameter bPseudoTest from efuse stuff
related functions. As this parameter is always set to false in the driver,
we can safely remove it. Besides improved readability and decreased code
complexity, removing the bPseudoTest parameter allowed for getting rid of
a lot of dead code. In total, this series reduced the object file size by
more than 1100 bytes on my system.

The patches have been compile-tested only due to lack of hardware.

Michael Straube (14):
  staging: rtl8723bs: remove bPseudoTest from EFUSE_ShadowMapUpdate
  staging: rtl8723bs: make Efuse_ReadAllMap static
  staging: rtl8723bs: remove bPseudoTest from Efuse_ReadAllMap
  staging: rtl8723bs: remove wrapper efuse_ReadEFuse
  staging: rtl8723bs: remove bPseudoTest from Hal_ReadEFuse
  staging: rtl8723bs: remove bPseudoTest from hal_ReadEFuse_WiFi
  staging: rtl8723bs: remove bPseudoTest from hal_ReadEFuse_BT
  staging: rtl8723bs: remove wrapper EFUSE_GetEfuseDefinition
  staging: rtl8723bs: remove bPseudoTest from Hal_GetEfuseDefinition
  staging: rtl8723bs: remove Hal_EfuseGetCurrentSize
  staging: rtl8723bs: remove bPseudoTest from hal_EfuseSwitchToBank
  staging: rtl8723bs: clean up variable initializations
  staging: rtl8723bs: remove bPseudoTest from efuse_OneByteRead
  staging: rtl8723bs: remove efuse_OneByteWrite

 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 138 +-------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 326 +++---------------
 drivers/staging/rtl8723bs/include/hal_intf.h  |   5 +-
 drivers/staging/rtl8723bs/include/rtw_efuse.h |   6 +-
 4 files changed, 62 insertions(+), 413 deletions(-)

-- 
2.51.0


