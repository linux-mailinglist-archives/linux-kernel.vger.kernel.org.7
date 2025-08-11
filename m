Return-Path: <linux-kernel+bounces-761718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8884DB1FDB1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 04:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91551189747C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 02:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A518121D00A;
	Mon, 11 Aug 2025 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Woj6i3r9"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953DD3594F;
	Mon, 11 Aug 2025 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754878994; cv=none; b=DfT4iwXyMNS1zHzMMs25x6s/jsLRPMultyp4sCbVppitwCtgb35LHV9qyDeXVcY4PbX7CBf7gJYTFhlaSsnKqHxT6qa2MyvSyvaOgKQ0+BgupRgemSzvsWpYCuI0YkDRz/AVHXU6nIfta43HtGX0UQhsrwO7w3xF00yqlFt6rhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754878994; c=relaxed/simple;
	bh=WpNAZ9etewp4IenrNq+BXbrThNKV4JtgYgBx5TlVm9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=emj339d4qGykl1XwJmRx+uGP21uS25b2qrdVhMx6CkSc4H/EdvMM5gDqwV/i4qDR9OnNXUCff4hgHvSmj/aWoXNCF9P6KIuGzccGNRHS8vh5TsRhnrqJ8+ighdY0VTpdfIkHHtViLp7HOtEYqho++SWxJeQ471fMNphtUeagzwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Woj6i3r9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2406fe901fcso39168245ad.3;
        Sun, 10 Aug 2025 19:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754878992; x=1755483792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=raxUPwFLTqeUIZ5BAQN4YRy0xEqUoiJRSLneIg3tpxw=;
        b=Woj6i3r94eDOljdxj8vPiIKoT+jbmVyG8gUJWKztyGXrwvCE5YSCOIFxNTpeFMT3Lv
         eokMepbxKQToGp82rjhhHXHrNa8EgLkyNosP6MSq+j2evcJEFdegwm/CM6x0TgLKYqKy
         jnlwd0W7BDy3JnOpE/qUzH+OX57e2MY/rl15jX3V65dgULmUC63nws4O1oFWKUuy1mA9
         AP06zyChY+OkS+ZRYMl5/lF3I/OKX2RCqfy8nmns4T1F21KEW8kWiHuxbgaCSU9eriYU
         8Edl7GV6qBheyPmTBKX01/xf/NrVy9+qnIPoljefopp3M3hbP2m/+6979C0W2M81mozV
         MNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754878992; x=1755483792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raxUPwFLTqeUIZ5BAQN4YRy0xEqUoiJRSLneIg3tpxw=;
        b=DjHoP17AHr0wGduFchJT3iLtpBRhZRXamlAFoxJVNrWj+idDIVg/HBmPz/7RcTq76L
         aOqdLYsLoEmamaCDFQdjdZlITUwCNt0ifNw10a+79Z9ZgXv+v9iCPQ2uWSYzeQISFaoC
         6/vIpQA2tmdP1NO6a6TKINgD0Wqtykz7gb67UDjU3v2CRqv11B8x4a7J+AYsNpk5pZtn
         /SWppgl/YZ1t7rj9qSxs0aMRHm8ut5XT1hou8Vl8DfXX9gUl3KF38rPj8v+7Pqw+1rte
         Gp14gHde69aKILylzuyeFhdbkiEOa6XkNX5RNdkZG2arvY9MhCAyr6UIeHvVMWuPFfJv
         moDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEGHqynNEMQK4vLqbR0wnHeKlZY7wxkq40p3xld5xrMJLjytHcZkuAB5wLJe4bsGtPiR4bFmdVdduM13I=@vger.kernel.org, AJvYcCUu2qWUjBHTGIu9MaxL/UDrXVNVlraRVRbQDjq0K3h6AIzcYe56EUk7xb9Fb4/GwXMOH58Bwyyj7OQjfDW7zIgSoBeNIg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1f7xb6qsfZtjgs+W2iJkYeRLwDF+hkzkbukJ8CKYvqOzzJOoI
	jgG8+NHc0CugTZ0ThMz572RVQYzGGBe59VL5Sg+UBLB1o/bDE72iArxm
X-Gm-Gg: ASbGncvfK9+TLhV14yX4fOQ1bC5Bxr+Bxh3XONBQFknjVeRqTujEqKXardaM5AHe5zr
	h+eSHLG9XOuV6oA8t/83EXAfB5pZMA06uIq5DxFumw0Eom835zDSkFBYPp+IW3Ysg0dVgNsQZ5X
	qsnDYst92Vp7CV0PH9AeBpYG1N5b8gvVUNfhgkfKQbTzNx4iqcMRdUSDYy40XHZwEc2/MWkGAuN
	i13jn/dpvdEn4oYRbCAlnClpqBSqeiEri1ve/TtQJInB2Mx6jGcjADJWImTpK0BsaDusvjsGLwu
	IXl4ZQwTZAgE9xipWrlPCIjpPNxPjSSmOmwwajqVvK00wlxS1pv+Bgppf67VqK/66lyWUpyfV+y
	Vd7cmqep8PVp73WfcWc1ky7h5CKUSv5dcco3RPKcl8b1c+NePje5H9b9o
X-Google-Smtp-Source: AGHT+IH4PwJSuqDwMfx01f9jovh7lu2q727bEvNJfz1FmP3zg8IR6S+hsvAfrmmDizH9F6Dk99YGyQ==
X-Received: by 2002:a17:902:ce82:b0:242:a4f4:6b7d with SMTP id d9443c01a7336-242c2207cb0mr129600355ad.28.1754878991599;
        Sun, 10 Aug 2025 19:23:11 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:69d7:30de:b05e:915b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422be2b3a5sm21880366a12.46.2025.08.10.19.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 19:23:11 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hans de Goede <hansg@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] x86-android-tablets: convert to use GPIO references
Date: Sun, 10 Aug 2025 19:22:46 -0700
Message-ID: <20250810-x86-andoroid-tablet-v2-0-9c7a1b3c32b2@gmail.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250810-x86-andoroid-tablet-df93908b426b
X-Mailer: b4 0.15-dev-e44bb
Content-Transfer-Encoding: 8bit

This series came about because now software nodes can be used to
describe GPIOs (via PROPERTY_ENTRY_GPIO() macros) and I would like to
eventually get rid of gpio_keys_platform_data structure.

So while I was doing the conversions from GPIO_LOOKUP() tables for
gpio_keys devices I decided to convert the rest of them as well. Maybe
some time in the future we can drop support for GPIO_LOOKUP() and rely
on device properties exclusively.

This is completely untested.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
Changes in v2:
- Reworked on top of the current linux-next
- Link to v1: https://lore.kernel.org/r/20230512001815.591817-1-dmitry.torokhov@gmail.com

---
Dmitry Torokhov (11):
      platform/x86: x86-android-tablets: convert Goodix devices to GPIO references
      platform/x86: x86-android-tablets: convert Wacom devices to GPIO references
      platform/x86: x86-android-tablets: convert HiDeep devices to GPIO references
      platform/x86: x86-android-tablets: convert Novatek devices to GPIO references
      platform/x86: x86-android-tablets: convert EDT devices to GPIO references
      platform/x86: x86-android-tablets: convert int3496 devices to GPIO references
      platform/x86: x86-android-tablets: convert wm1502 devices to GPIO references
      platform/x86: x86-android-tablets: convert HID-I2C devices to GPIO references
      platform/x86: x86-android-tablets: convert Yoga Tab2 fast charger to GPIO references
      platform/x86: x86-android-tablets: remove support for GPIO lookup tables
      platform/x86: x86-android-tablets: convert gpio_keys devices to GPIO references

 drivers/platform/x86/x86-android-tablets/asus.c    | 102 ++++----
 drivers/platform/x86/x86-android-tablets/core.c    | 109 +++++---
 drivers/platform/x86/x86-android-tablets/lenovo.c  | 279 +++++++++++---------
 drivers/platform/x86/x86-android-tablets/other.c   | 289 ++++++++++-----------
 .../x86/x86-android-tablets/shared-psy-info.c      |  20 --
 .../x86/x86-android-tablets/shared-psy-info.h      |   5 -
 .../x86/x86-android-tablets/x86-android-tablets.h  |  23 +-
 7 files changed, 436 insertions(+), 391 deletions(-)
---
base-commit: b1549501188cc9eba732c25b033df7a53ccc341f
change-id: 20250810-x86-andoroid-tablet-df93908b426b

Best regards,
--  
Dmitry


