Return-Path: <linux-kernel+bounces-737775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2E0B0B074
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1985C5622CE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BCA2877E4;
	Sat, 19 Jul 2025 14:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNaITGCX"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A66F8821;
	Sat, 19 Jul 2025 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752935352; cv=none; b=H93Vh9LYUa59zJXf99MCHjDKa2H+u3gQGVoHbElo4mo+y3Rv22KdemVSPNNTECS/bBk4YoOza9j8pYEWewEi8lXutUxRLrXc7FZVIs8iL5cEiQV7Nt0/U3wjDJLjG9WWRvnVrIKjZJrVO6JFS7aCQUxee7nQ9PTDZUNkKP3HG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752935352; c=relaxed/simple;
	bh=6AYgdo7MuR85qnSu0iVdd0i9gcXbfVGBUZmTKuCdmAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SW+HrqxZHrc1n45vRbJ8qWTdqGuoTqVsAYeT8UCwH9JppM6P9AkgHaKb9q44CTFrhGawXncsQk6tzPlL6HkIV5YGJcduNZ/OZoWgmFk7pdO0D57cgWZxdYcS2bwKoqCZmAcBfTpIp9OFzwH+hesJB+CZw/UwP6WTir5hGi0Ltac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNaITGCX; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74264d1832eso4000697b3a.0;
        Sat, 19 Jul 2025 07:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752935350; x=1753540150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jSpEnY+pfWxdP6XRYkBDpffQTichaXNz1EwGcJe7XEA=;
        b=WNaITGCXg2F5cJg/wrBjih+MSOLLfPMJKQEAJJ7jh/G5DVG5k5R57xgXb8UD7Ji33R
         uLvZwyyN0HCmtIdaSB0yvaKgRnjbFQBje/A4rNMq4ndjjb4b9buLJAwVhsBeW8IIvDyV
         7jQHogYFBh6hhi07B2LKaqxYTboQRxwWHKIrVUyLe159uoSUQtJLEe2li8GPmsqzVmk3
         i/BU1SHyEnHkjs17ezVdxxyZkUYPtuKwYJio03W1FH1ot8hMQWKy5qK0aoD/SpVqyd5t
         cBjWG0vpsxe+dOOAAi1VczcjR9PlMJNjONInc//Nhy2kkYdfnKh44AroKXrkqZrQiD1K
         6F1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752935350; x=1753540150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSpEnY+pfWxdP6XRYkBDpffQTichaXNz1EwGcJe7XEA=;
        b=W5TlXv4CxzO0MUkmRGXjK6BplgtIzPAFn8ksa4wPKfs8CQiehePGR++wsOKfLfMogV
         jgOxVkeSVZIIsoXaMIGn/n3aRee4b8I0dONCAOxUjtpuotG3OWyu+K+iST2StbyGd7vg
         L12Fdorg0hG3+252gE4RIoUFeYhTPbe7p4HO7LbpkMo9lEcY6KwymPj7H0v8Q/FmftRG
         X1DjUe6FjINvWeuR0FQ6uOrlTz9HnHjdDlSs2pcksRJiDC7pZrNiflKMmgADamDRBRf9
         bYprljOIIdo9/+vu0SCNw88xpPLD2c5w4dqG0SOvXSHvt2dhQw5hT6guXdWB7ZPXBXkM
         53uw==
X-Forwarded-Encrypted: i=1; AJvYcCX0UqNTN/2rhSgrnrI22J3yVD9ldSTKKfb0thC8e9pCCZa8Ui/CZd+mezc837vBNFj8fGWu+VSb15Tx6TI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKozROn+oi6cR2HbFUme6NMf11m5mNx3s9nPhQ7UyUeheCHDRf
	DP1tSTgBH9E3zNOnRfSlYG+94zV04CEQ4Scf0UX2QvMPjVZKcwycqV5Ath97Zg==
X-Gm-Gg: ASbGncuBUCcJbMc+/DHAWXacXS5Q3KPyhDoxgYV6lMKFyJx9VT/1E0fPi7otDes1nB2
	M+wLyFwilWqZuDW1H8fnYqUQZYIu9LegMNWwqJISH5O3g+Ya/OREOjDXpTU/ZUdPEJL/5SPDXgJ
	ym9dsliIPEtUGD/TY0CWnhRcnOzGKLUD6rku9f5JFfWb1FbWcb8qorea4Z8XZJp2kH1GN8LXJ80
	Cd7BwaNGqThHHR4V3XX4KbzycW/2v1wHC30kBmEHuP9/qA8MzAomUHZ1j5RBgtIpOUPaACiHgKo
	4ZWxB/QLo/0gn/dyDDXiTKhZu8TfPpCNCce+gG+XODzbmRoh7qH5nFXVutmAixzV3FcFb8NvWjz
	x9hOdezErgFPKFCQUz6vWmgPFFOTl0GAi8nQ=
X-Google-Smtp-Source: AGHT+IE+mTf7lFxAEWO4uO08a5NT6KmXPvqjU6UyEGaYA0dl9boP3lAJ0IUJ4fnKtWlaFaCXxMK9PA==
X-Received: by 2002:a05:6a00:2e92:b0:74c:efae:ff6b with SMTP id d2e1a72fcca58-75723585a43mr20547605b3a.7.1752935350249;
        Sat, 19 Jul 2025 07:29:10 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d41b3sm2957899b3a.54.2025.07.19.07.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 07:29:09 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] hwmon fixes for v6.16-rc7
Date: Sat, 19 Jul 2025 07:29:08 -0700
Message-ID: <20250719142908.4071985-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull hwmon fixes for Linux v6.16-rc7 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v6.16-rc7

Thanks,
Guenter
------

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v6.16-rc7

for you to fetch changes up to ce3cf7c8a17478456f502cb2facd6660e519ead3:

  hwmon: (pmbus/ucd9000) Fix error in ucd9000_gpio_set (2025-07-18 09:50:55 -0700)

----------------------------------------------------------------
hwmon fixes for v6.16-rc7

- corsair-cpro: Validate the size of the received input buffer

- ina238: Report energy in microjoules as expected by the ABI

- pmbus/ucd9000: Fixed GPIO functionality

----------------------------------------------------------------
Jonas Rebmann (1):
      hwmon: (ina238) Report energy in microjoules

Marius Zachmann (1):
      hwmon: (corsair-cpro) Validate the size of the received input buffer

Torben Nielsen (1):
      hwmon: (pmbus/ucd9000) Fix error in ucd9000_gpio_set

 Documentation/hwmon/ina238.rst | 2 +-
 drivers/hwmon/corsair-cpro.c   | 5 +++++
 drivers/hwmon/ina238.c         | 8 ++++----
 drivers/hwmon/pmbus/ucd9000.c  | 8 ++++----
 4 files changed, 14 insertions(+), 9 deletions(-)

