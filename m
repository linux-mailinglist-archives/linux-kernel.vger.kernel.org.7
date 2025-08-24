Return-Path: <linux-kernel+bounces-783546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7EFB32EDD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A45A3B4B2E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA8026A0B3;
	Sun, 24 Aug 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXTW/N1V"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01F7262E
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756029520; cv=none; b=cRILsxjmpdQ/cv+WxD4BBxPF47R3fBoNIyNQbqob3m1s3uJ5hqblus/nBs77VqzdimnxiKn81qMq8UWcnGyt9TNyfQs36Blp7XulC9xp7KqFkUi3M0EnWUgehcX7jGfyabh9syI/6ma0vM/kwfrdjhPVq1UMGogjDJm3BTj8KUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756029520; c=relaxed/simple;
	bh=cgAKorw0Fde8Au04wZTQVG5bPNHjh/gcSXzESWxQi+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QjUOiG92FS7y0lcMeBXxvq2XawafZ3C0tvvZzP2ZyYCt736LOc79JVBzIzsFskbV3LX+aSk5cZTPf4DcoBobTeDVFslcOEisC4aFoX+9F1So2YurBgXclRSxe+OeTz0aAK/+xrvzc+jDOtZoQXYn0h3DO7oHeLVCOWPD3yKdUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXTW/N1V; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7a0442bso553653266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756029517; x=1756634317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lJyJ6n0uJyKoJ3QoYGdekyUCMuS5RT+LDiwNukUwI68=;
        b=XXTW/N1VAJiQNyJmXjlaksZUXnsUi9W7fhdqYZT31JrAEZIuebb8rwv8uYK3AxRvTW
         YeOz+jhNCXco2D2yR7XV2iq7R/i8v/89jxZQt/81LxyhwMSPTp17yhzDHa61IUoQkblT
         aDKZVrpTl7XxxfQYtDGqAtl78BNlgPp9oL28MFkSwj0j4AUeuVLp3vnFSQHsWbcmv/Bg
         sdEtqaNuquu4+0FXZXiM1Twmt9fijB8CyO+oO0x0HYn69Bi2h2kR/rfrAm9CeWfg36WU
         CRVEHq+zuqFXeaSYtPc5LGQlG8cSf67w0LLvMZq38SmmMR4Pw3/UJfRRD5FX6vdbPJXx
         WVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756029517; x=1756634317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJyJ6n0uJyKoJ3QoYGdekyUCMuS5RT+LDiwNukUwI68=;
        b=uvASeXLDjDqUq2WNxAt1oBRgft0V7DqJIFYshq5FBLy5da6wypg2R0wYy6/I440x5X
         nwuXIFBpFpHbPuzgJwqJn18Q2MGDvkigGeNMMx3jtLTGvI1Pv8ejpbF9HEhChBROS5fH
         tNSYjTwg2IuUoCe0OEMuEOOxDZKGNOFSI06ddmWFOSnw2CL3xMcqekH+PstcHJJMb/HT
         HuVCeSTtNtK+Fjepjf/j14WJh9Zf1r3lvkVaHYqjX+ww6bvwMCUZSy4fAmOnKjFASmRV
         jjIIKUv5E9uMVV7R5sXdOjF0vPf0iecTLw9E807Z40VJ5t7YXAXOZ/agzk/hkcFUULZs
         XcVg==
X-Forwarded-Encrypted: i=1; AJvYcCWP7bkiQr9KPffqM+4BGnWqRgwrMamWsjvFUhMoLeiD5krk1rbeY5MqQUUZ72O/ENQwvPQ/LL8kAQhSMgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRkWD1ksUA7Hetzi9W903Dm+TqnJWl7t7ZwKjX2q2dT6eapmg
	BLpdbsCN7QIXwGTrmDhCmgbdM4mG9p751PgPsaKlx/g4f62/qT4DODoeiCfXIA==
X-Gm-Gg: ASbGncsxOOzGqUiqe85Q5U3nOx1NPDJMmoX5UJBKxU4bn2S6g8PYndAlFS3IpWawfHf
	mUn8sok9daKWFAEfCE97Jcgl+4XlHWG88/ce/zb7ud/kfSRe82riyHQ7atp7A+eryaho3QYzDpA
	0auZ8s6PDx4bP8SjZDLzGZvBuSd1ShvKOUNb/wpUpZSbHxbwJviF3CzMS/X8P4hMkbdxN13VA/X
	VRGtei2eRslis+FRFpLHu40RTfwpVVXXpCGGKFDThfcesgMlNgtGYGs5lD6ERj1qFfQauVm15T2
	Kj6qML5f3oPTnWlhPVGZr2N3Rn8BeqvI4Ta06hrBeSs33h2W4/J/ULaddmky4taGAjNANmcTfsq
	ewkeyjkr3zMx3UD7DdHV1nVCpkTthwh0ckn3G
X-Google-Smtp-Source: AGHT+IF3GTMJFxn33lICmYTNqS9u3TuML0h4Q12qPs6CV2JkSeinyxOO3rAAGORE8FzWm8zoSUhkHw==
X-Received: by 2002:a17:907:96a7:b0:af2:5229:bd74 with SMTP id a640c23a62f3a-afe2904c55amr785478166b.26.1756029517186;
        Sun, 24 Aug 2025 02:58:37 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe79fba62dsm41314766b.100.2025.08.24.02.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 02:58:36 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: rtl8723bs: more efuse cleanups
Date: Sun, 24 Aug 2025 11:58:26 +0200
Message-ID: <20250824095830.79233-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes some more efuse related dead code on top of
[PATCH 00/14] staging: rtl8723bs: clean up efuse related code

Patch 4/4 removes an empty function I stumbled upon while working
on the other patches.

All patches have been compile-tested only due to lack of hardware.

Michael Straube (4):
  staging: rtl8723bs: remove wrapper Efuse_PowerSwitch
  staging: rtl8723bs: remove bWrite from Hal_EfusePowerSwitch
  staging: rtl8723bs: remove REG_EFUSE_ACCESS_8723 and
    EFUSE_ACCESS_ON_8723
  staging: rtl8723bs: Hal_EfuseParseAntennaDiversity_8723B is empty

 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 31 +-------------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 42 ++-----------------
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  1 -
 drivers/staging/rtl8723bs/include/hal_intf.h  |  2 +-
 .../staging/rtl8723bs/include/rtl8723b_hal.h  |  2 -
 drivers/staging/rtl8723bs/include/rtw_efuse.h |  2 -
 6 files changed, 7 insertions(+), 73 deletions(-)

-- 
2.51.0


