Return-Path: <linux-kernel+bounces-891747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE8EC43608
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F05B4E23DF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054B427FD76;
	Sat,  8 Nov 2025 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YrwdFD6/"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9E1DF72C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643599; cv=none; b=cEiwBSI8bEMOPTFLpd+ed/wogyDBLRL67AozcQxWMeWq+1KO8pvxA4Q1e1+xf7h6GRbueEIiE5tVuZTSLhyJqf/os2DGi8evIrVGatdgTnxFAMJwU9+biM1p3IoMbCKUaCRiNJoMF1o4udmMDDdWU4xcByqekclmBDY/mmBTdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643599; c=relaxed/simple;
	bh=mktvsbnCgQB7SIyVywpazCEAaoTh++8TaCODy4U/W4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4JHNem3LIKlEArmHB+71/+RYdbKyT/auQ3701N14tYfgyFy5RNSpj2Oo9dDbB3yfxJ14h2g4tw0XzEgMhRgF0G0M7T8f4HHyu0lYnW2cjcC8OR5jyLUn6l/QrT/LpjlvrMx8aeSmG5GEbjJxz2F1CngmIae/JeuA4+CILq4xn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YrwdFD6/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640f4b6836bso3383975a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643595; x=1763248395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibTL9LFMoaISY8GQE81Db1c/RUt2bsWCzKF7aX8X54Q=;
        b=YrwdFD6/qKHTg4gnVS1bpz7IsDR2iJ2lhqOMz4GhWMirYMRGLmYDrgkseXccCHCndF
         d/CSpsm8kOoNwhHXOPuS0CgpmIbjPARKJ0ZDFu3F8Ggb5c0UI6oOPBj18iDT7zk9berG
         q2VUdk6lw9EuxSUEtWdCGM4Q7bLyoGsXCSLiDsmJhUcM5iOpltkK5fgAPvKpUi/BAFvo
         0HVaMvBq+4SkrEID1hE6tlmSNwgXJK7X3V1zVxK/NWOkEcyGgcJX10Fyg05yqHKqrXHm
         ZbLiHZjOKwT1Ezg5gHl+po5ARXT1SoCW1+jGrSgIExNOBQqqUXncIuqrhVUXXBGOP4M+
         MAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643595; x=1763248395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibTL9LFMoaISY8GQE81Db1c/RUt2bsWCzKF7aX8X54Q=;
        b=XHWDOYtv8c1miWt3t1K/25yaq4aACUcELQpykm6fcB+FNziXq1mLi6F6wYDb86mVNE
         9b87q7nQJU6i8ZcOKXDtzd1CWgDkNDSao9qKnlTLIEFkJ4cRnBcGxPm1OiHLbxNTWo0O
         GItIv0rzSJGXHmRfXqWC8HHmQ6PiX7o7Nhfk2DHI4S66GlTDSCijbpCx9gfZGOCMw+IA
         9cNukwdq8Qa23mLK01SB9AgCKMlzhxDejmD78/HOp3JInqGwTVDE41NfBlLzZT9Nox1+
         qzhD0j3T9e+nG7u4wCRc6GJwwrOGhGanLlbES7jVzcl6JZX1mYcUvgTAj7TGPV4L7NrW
         wLYA==
X-Forwarded-Encrypted: i=1; AJvYcCUrKPryVaTpVFVHmif1hU7foquBo1U4o8RWvnis6W7F9aI7NQfuMbgtdOAxA2PAaC5ZoCmQjZsNH+HN76U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpyHDe2Xxq2r9WJra06gsYEmoBNUU+HRblZPs6EkEG54pYd1t7
	2Fw6VqXrOFmimqNW0aFyk60Qv/WvvyWr28naVJxd06GUUmIHlc0fyEEDuK4fbw==
X-Gm-Gg: ASbGncuWAoibg+B0reRKsX1GfdUBGxmzyZltVJN8Kl3DT+HeqMxfnmEOKjfOWlQWZu/
	CPUmYp49k7U6eYG+RkP6aKAIhuSkYuylreDMU22Ez0ADE7Ec1vXdwZ7h1UBUwuPm9GGqpIRsa0/
	+wb5n6FADN4xesOmhr8lM+8QR6eFsZZWSAq71HHBknHa87FpK9X6usmRbnAsDEljWz1OVOgq7HJ
	PLHqL2IeWJaZxZjIvFP8VSFFTOFbyQCuBBWrpSglrdaRDJ26/MbxGs5RAh9p2erjom9WfUId3eG
	I/IeBFPyzqOuFvS8QHIo+HnvJlFrZZlORueQWkBO5SjekAJbdnRZX6YdMmQbTeO0RyqncwtmLyo
	cTaxUkHtpCHuOl+s4aw5Byy+wai/CSYsWTTel+D0zlwowWu9UuBZJ0F8G9CioG9Mk/PBod0RfJ+
	Zpn5nYE1rtavFDLnR/uaTjl1+iMvFlVrAmM4sDxUZCeC3srV7xZNyoXrgEapTEKsIdb5Q+wXCpp
	yv2Db56a+A57iYzUl60yLVhWzummYX4lUCO3GmmfmI=
X-Google-Smtp-Source: AGHT+IHojjSOYkU74h70pOz5Juc0qTwy5Qm9aBj39UgCLbnQKLDh8bnfGClMfrPjx5Lm9oFsJdZQ9g==
X-Received: by 2002:a05:6402:40d1:b0:640:bc0b:887d with SMTP id 4fb4d7f45d1cf-6415dc03146mr2946757a12.2.1762643594925;
        Sat, 08 Nov 2025 15:13:14 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:13 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 0/7] mmc: meson-mx-sdio: Various driver improvements
Date: Sun,  9 Nov 2025 00:12:46 +0100
Message-ID: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains patches to improve / simplify the code of the
meson-mx-sdio driver by:
- using regmap for simplifying register access (patch 1)
- switching to modern clock functions/helpers (patches 2, 3) and
  make the clock code not interfere when switching to
  devm_mmc_alloc_host() (patch 3)
- making use of the devm_mmc_alloc_host (patch 4)
- using modern dev_err_probe() for better error handling (patch 5)
- indentation fix (patch 6)
- ignoring disabled mmc-slot device-tree nodes to allow describing
  all slots in device-tree, even though the driver only uses the
  first enabled slot (patch 7)


Binbin Zhou (1):
  mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper

Martin Blumenstingl (6):
  mmc: meson-mx-sdio: Switch to regmap for register access
  mmc: meson-mx-sdio: Use devm_clk_get_enabled()
  mmc: meson-mx-sdio: Refactor internal clock initialization
  mmc: meson-mx-sdio: Use dev_err_probe() where appropriate
  mmc: meson-mx-sdio: Fix indentation in meson_mx_mmc_irq_thread()
  mmc: meson-mx-sdio: Ignore disabled "mmc-slot" child-nodes

 drivers/mmc/host/Kconfig         |   1 +
 drivers/mmc/host/meson-mx-sdio.c | 339 +++++++++++++++----------------
 2 files changed, 170 insertions(+), 170 deletions(-)

-- 
2.51.2


