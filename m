Return-Path: <linux-kernel+bounces-870234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93061C0A3E1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 07:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C178B3AEE6A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 06:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1227147D;
	Sun, 26 Oct 2025 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="Vj2KtX/u"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191A8747F
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 06:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761461463; cv=none; b=XTuPlj2Z0nX9t/NLMOaHu8r+yEPJlGqTuSPIMGy43wSdPzBR7p0AOcOgx7OFimHoFGLBNc+WnFrFT60/QX3Nw/7nA8OIgPrDWsDFych3nyVLBmKxQMdRJH7xrN1C9V2yfPLXyigyTdRUm4vVskvaAgGPuIlmMsX/EMTYESBXJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761461463; c=relaxed/simple;
	bh=e85NXa0sI3f3w+CETu20WN8BTa5YzlfYtevVbUSsSsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rJKQ8/DuZCCsDOZxntUDj8KA67dHLxqaUAOGc1qGL2nTTJqvd4HJDSNX3sM37ZThV5KzQwyRZJXnApFmw/3DZ72AAARIADyd40Z8r/0G4lGl94pksd6/FfPq+umCLXlavfM9hdA3SOuZ51f3cm5Y3z/CR51tL28oVIAVnNBTfBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=Vj2KtX/u; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2947d345949so29148925ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 23:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1761461460; x=1762066260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwm3y2MubzEk+9BE7WJDp/oVxvmkQrQjbNwGQzPi+1s=;
        b=Vj2KtX/u4thXrq5QECAa6wwlWAFxoOJL4e+8dQANybSDZyxF8tqut2Ll68/tq05ada
         R25Zz0uZ1+FA7DUHnbtH7iDCanDndbAuOxlJeTl/hXXUSLGDBmeMexJLoJO4Z72zVd1f
         HlLylcmKUHnESEurYB0enXyXFOZ38SVd+X0VjF8FihCAFbO44BYsUH8XKXOpOiM2pN+m
         Ej+PrIQrdn/JPnq2NXp8Bk5kYVUqx2S3mQo4YqRK5/GUw+LqZHIX24xk96caMLQPVRMF
         Ip4ie9D9bK3fz7sxQVEwhATVrwQx8WQgiZH86/1+SoOC2NW1NqX3Nyo4j6LdFJiKG5pU
         57sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761461460; x=1762066260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bwm3y2MubzEk+9BE7WJDp/oVxvmkQrQjbNwGQzPi+1s=;
        b=DFE4p8yaAMV2oQNdjgqh/8vPW9hPBHf2vUaylP7x/bOvqHTd7wutFMdhDZbn8SXSdY
         F7bwDWvAFO18J2cZH3fjnJGnpEUlXxEzhxSPT9/A4Ti8WAnwY4okaQ/NpYCp7/reIBEd
         PqkQC0+BAxmgdW5l2EnJlwHZN5/6XO7g+430oHuITBbFX7qO6BWBg5ego/7d4ILg0c4H
         wIZBysZfBL4IeohZtPrts3N4AJPFyOWi7b8R6IZB1/jsPu3XHebK8Y6oGiivWPFd4Rlh
         qugmr/kKNMN0tYaZtrkrEI0UjNfZbAmujqx4j6IZZzPPI1n61Hr7ENO8ybhGOKt6cJTT
         mtnA==
X-Forwarded-Encrypted: i=1; AJvYcCX9USR3h7SOS/J78/e6w6oFmBr8ZkEYnLpHS4fk+TeTIJwUshCisrA7CeP+z3VEug+z9NZkx9gPDGNG3+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRcC/hkSdjsfOqAot/8a1c6eOmaC7kq/9FB/KoFnVWQ/p7BtLQ
	s1EGybMRgrOLowoz+NMdhfUxBV2qjbeSljBSPca2N8rq+vTmRRpA0pSdPUqvVqgElWI=
X-Gm-Gg: ASbGncv1tHrfJALT74Xrf/pOfkHnx2eyHCky0mo04SvsoMTnJvdCrLDmZnPVB1R5HBV
	SKOcWRoYZRnPQ2WUKKA7C5FxQuOfpEI88YuQKfiBUczuz4E8NJVgOpllntz4MV22UWvPUL1qHV5
	pYLU1gnA2Sa5RZvpwkOYgclCCoBhiv/SlOC+mQeHRzgpgsuYY+Wd6xwmPg/uCR2oNYlPGuGKbkE
	22MvYG7PklQsQwQUbUZSfxL67zM7y0JjlICeEldHdehSZt1KD8F874T60gCKq8R1B4IEorn28or
	fS34P/RupP3bTtrQPAqbAR7vJjxl25HuZx6o8mFKxww8Ii152xopd5lozfW4MY/0POMw1kjte2B
	o/G1FBuiug5nFF3i5T8waDOtak1hxhiKFEqcF241/tK6sGYjBQB6i0zvAG0zROLC6nhNXbmpdj7
	JLmVgMmA==
X-Google-Smtp-Source: AGHT+IFk7R96YXUE2AFHweAhNJTfel5qnttPqZd813Q6RU73D4Bpa+BM9FjFwisJbKplCLyC3elWYg==
X-Received: by 2002:a17:902:db0b:b0:290:b53b:7459 with SMTP id d9443c01a7336-290cb65dc2amr403459295ad.56.1761461460154;
        Sat, 25 Oct 2025 23:51:00 -0700 (PDT)
Received: from z440.. ([2601:1c0:4502:2d00:640c:95e5:94c3:cc2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d4288asm43184905ad.84.2025.10.25.23.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 23:50:59 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux-hwmon@vger.kernel.org
Cc: conor+dt@kernel.org,
	corbet@lwn.net,
	david.hunter.linux@gmail.com,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 0/2] hwmon: Add TSC1641 I2C power monitor driver
Date: Sat, 25 Oct 2025 23:50:55 -0700
Message-ID: <20251026065057.627276-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022044708.314287-1-igor@reznichenko.net>
References: <20251022044708.314287-1-igor@reznichenko.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the ST Microelectronics TSC1641
I2C power monitor. The TSC1641 provides bus voltage, current, power,
and temperature measurements via the hwmon subsystem. The driver 
supports optional ALERT pin polarity configuration and exposes the
shunt resistor value and update interval via sysfs.

Tested on Raspberry Pi 3B+ with a TSC1641 evaluation board.

Changes in v2:
- Fixed devicetree binding name and formatting issues
- Alert limits are handled in a standard way
- Clamped alert limit values, constrained valid shunt values
- Cleaned up includes, fixed various style issues
- Expanded documentation

Igor Reznichenko (2):
  dt-bindings: hwmon: Add support for ST TSC1641 power monitor
  hwmon: Add TSC1641 I2C power monitor driver

 .../devicetree/bindings/hwmon/st,tsc1641.yaml |  59 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/tsc1641.rst               |  84 +++
 drivers/hwmon/Kconfig                         |  12 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/tsc1641.c                       | 703 ++++++++++++++++++
 6 files changed, 860 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
 create mode 100644 Documentation/hwmon/tsc1641.rst
 create mode 100644 drivers/hwmon/tsc1641.c

-- 
2.43.0


