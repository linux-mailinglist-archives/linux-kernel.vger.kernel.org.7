Return-Path: <linux-kernel+bounces-870245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04101C0A466
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 09:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A5BA4E4ED5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 08:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C7621D585;
	Sun, 26 Oct 2025 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbSMgmSM"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7842223DF9
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761466368; cv=none; b=LdccVWI05xGdXPDVHSMXuqFCmXkUhCd1cH0rxeRzYX8/RfYbrsO6VOqRLWCvSlKTV/YqFZqCTo4lRIc/XWSABpgWdnoiDkyjMPVCYsQpQonc3JjkU7tp6AJEP2AfDFyjyPSfUxtkE3pKCTWEIKn/llOB4CHbJs3PviQIorYqMa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761466368; c=relaxed/simple;
	bh=NxNRdz2kuz1Lcq3kjc00zlm1uiFMfJ+3oQgiIquoeWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjUu1A5bDPGQQQk5HcVaxgjrEoP0eLaI3GRMSug4xxFdDqUmHLxhqYCrCyN7t8dVRo7R6TYBjGRtjmZiZJug71La5WPe0x3S/VoAz4P0XDQrdi6hBrWGqBYqLbM57BLpWGvK3Pr7Z5ylxdFe73/2Xw6+hlK50MkJfV18K99hAf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MbSMgmSM; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33b9dc8d517so3561473a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 01:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761466365; x=1762071165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZv9rWuJDtiDJIpWUG6ZeOUE94UmXgPwVE62OaqiiqI=;
        b=MbSMgmSMMqxpBnCnQAjb/QhT/jJAwUBHLznfRwR85ti2q90+HjftoxyfU7AJ7qx+yl
         IpOQaV1vb4QM/JTuk27kpFtNS5jbgQW1xYVa/WYitjjsWERvz+sahHUOf6mpiQkBPqSA
         Ji+vh1i63K7rLN2SyfgLCbHV3wIR8YmZAnAIKhwB87v3LxtDMYDD2J4x/WFa+v3OaQmE
         1M9UIC6CyTv8Yha/CLtAIrgntpehkQezYDK7vozc+sc69fl7+KsMPFOGnuQw9FldHJ4d
         fZslJtZvD9G3gpN9W+H9EiV9ptdP1Jb6bcQ0gquSh4F/4nTB1VycWpl6rUnpg+UcgrgG
         4jNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761466365; x=1762071165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZv9rWuJDtiDJIpWUG6ZeOUE94UmXgPwVE62OaqiiqI=;
        b=FmWmJPpCjgwiixvsB5QqFuhbxyB+X43oifC4GfxZICeTTe4wPqYcSLx5lXKvf51udU
         KCUeNtzNNfj30APth2grpNM+yKfk2qFcj0kvU0FhsJaczZ8x8EcwGYmTyKaVQAU9aFt9
         Dd/nFpDdlqQ/PAK9QMRv7VI8dAvbesoDnHjDbghCuRjlUBbRCLLGTj9TRMLS/9sIfeUl
         aTQX/L3TgCScRrxhdRTesgKbY+MvJx2XRxsuP394HExac+MXjUCe3RJVhgXetRLzbDo9
         TjrneZBA/pohWhjoKqh9IWVvdkOGUiR44OFRuz69CILPPQv9cOjFCy9RMFqln9at7fGV
         yRsg==
X-Forwarded-Encrypted: i=1; AJvYcCUTVJGqHEZQr4D3NSq8T2gt0rPm+ed8QAfnDWvr9GcglIIwYn23+Zaqb6P1X2+BWdi/jaWNjL4i9P0u5Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqdbHtEgS0Cc/SJMrUdXqJS2e86xTYfSM7VX4unW2XcBMatEuW
	JcYUkKO9AJJoVN+2bJFHkxj5dExMFpuo/9QVEEyobjxfC52oQkbdmQR7
X-Gm-Gg: ASbGnctdnpT+FAFKdihA/OuwQY0tPl2V3gwoQL3YPjfY7wP9V/X2yvmjMd6J24MJmbO
	JdmCEv7ka6UX45SHbzwdM6nEUl1R74DlihhUBHh1u6bwtngxUmlZ2jP7LqtxFvTMt1hQCLA6IdL
	k/fVxIUyLlcX+xsY/wzGBxkC9BPOJchEPF+pgusX0wQxIHBMNW3S0NQW4UqaXQFJeetDn6EqWEh
	Rn9fS4095XpQynRBM3qip6HBKT9iAYqdVICsgKtbXQouMCLIVY4N6n1HqtpU8IGGipU2zLvQoKg
	rkCbBNgMB88qFIZv2DcQMiO2/D2NfD0ymrh9MMghbczGkFpb1vN4eYpAEgnFEcPtl4Ak3EpbLs5
	I2K+FdKyHAShr8c3dXEIqz+0Evzz6Nvv9zJAsagnCMvh8etgmIdQy22ozh3M1bCLc8ZiyaYnPpc
	ovwOr9hVj9X4Qd67Il2/kx639VjfGNQYMPj65jH5oiVRK4NzJ6ZLYcAybD
X-Google-Smtp-Source: AGHT+IGzPsm30Fd8AKfchIORpRn/v/MRrF3xbYiFaR1pMFQjvxS+JL0Mejj5JuhfnPngYzQEtIzCjg==
X-Received: by 2002:a17:90b:4d0b:b0:33d:a0fd:257b with SMTP id 98e67ed59e1d1-33da0fd264amr30507244a91.36.1761466365050;
        Sun, 26 Oct 2025 01:12:45 -0700 (PDT)
Received: from bliptop (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fee8014f6sm2374654a91.0.2025.10.26.01.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 01:12:44 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mario Limonciello <superm1@kernel.org>,
	Zhixin Zhang <zhangzx36@lenovo.com>,
	Mia Shao <shaohz1@lenovo.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Kurt Borja <kuurtb@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 0/3] Add extreme platform profile
Date: Sun, 26 Oct 2025 01:12:37 -0700
Message-ID: <20251026081240.997038-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new "extreme" platform profile mode and uses it for
the lenovo-wmi-gamezone driver. It also prevents bugs that are being
reported by some users by switching the current deny list to an allow
list. Currently there are no validated models, so I've removeed the
unused quirk until something is added to avoid the warning.

On some Lenovo Legion devices there is a thermal mode called extreme
that corresponds to setting ppt/spl vlaues to the maximum achievable by
the cooling solution. This correlates strongly with an overall power draw
that exceeds the DC power draw capability of the internal battery. This
mode is stubbed in multiple devices that incorrectly report the
capability as supported. Previously this mode was quirked out for known
problem models, but I've since got multiple bug reports of additional
models that cause issues. Additionally, this mode being mapped to
performance when extreme mode is detected as supported, with the actual
performance mode being set to balanced-performance, has led to some
misinformation being promulgated that performance is always a bad
setting in Linux for these devices. There is also some confusion that
the mode labeled performance in userspace, which corresponds to a red
LED in Windows, shows as purple when set using the hardware extreme mode.

I'll also note that as the hard limits are refreshed when on AC or DC by
the ACPI notifier of lenovo-wmi-other method driver, no special handling
of the battery is needed for safety limiting this mode.

Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

Derek J. Clark (3):
  acpi: platform_profile - Add Extreme profile option
  platform/x86: lenovo-wmi-gamezone Use Extreme vice
    balanced-performance
  platform/x86: lenovo-wmi-gamezone Use explicit allow list

 .../ABI/testing/sysfs-class-platform-profile  |  2 +
 .../wmi/devices/lenovo-wmi-gamezone.rst       | 18 +++----
 drivers/acpi/platform_profile.c               |  1 +
 drivers/platform/x86/lenovo/wmi-gamezone.c    | 51 ++++---------------
 include/linux/platform_profile.h              |  1 +
 5 files changed, 21 insertions(+), 52 deletions(-)

-- 
2.51.1


