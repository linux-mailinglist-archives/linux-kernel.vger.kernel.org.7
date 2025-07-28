Return-Path: <linux-kernel+bounces-747828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5932CB138D5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3733B1692BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7FB255240;
	Mon, 28 Jul 2025 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="czFtDkeW"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D02472B5
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753698044; cv=none; b=nuI5VAcfPS4Ai9VTUdX52+UD3LLCQQom4ZVu6ayfwcV1lXnCdjLi/ZTRWb+H7M9seqy0bBF1m6x6GD5YUOLe4/oEB5Ttcl6Xt1k5Atjf08BNGKMpn3WYK2siwCtfALdae5ga/rFbocx9Nz41YPuVUA2rB6avSAfAgRPPXmjTE6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753698044; c=relaxed/simple;
	bh=pyV7Aetn6gZ7xXS5CT0vvgHUaHHSEVxQJE3ZgGcCT+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNRjk+LrSNOLM8XsttpRmAQyqk5CHM+mGmTud4lckg32EAgjlaczUNBswoa8oEVxPcL0QtCEPUf+VNgE1JBL1GOcjurGNAOPIC/yA1XRKjwewN5jSbcUe5ngffcpvjA7azQ1hp61FSQ9qOBg+Nnrq4LCOnamrkVNT9JyrWWol8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=czFtDkeW; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4561ca74829so45200875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753698040; x=1754302840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=219O2xVBqIOUMv3jLy61uyg7qpqwuip52JZjqaIWS2o=;
        b=czFtDkeW0kusrKZ0fw9jTdFMD0EZomZEs1AhjCn3bARDO6U1pWYX8wv5aGBCxxwxXY
         Ku/JfUylywWVd6VG7QVu/8+A3EmRLorsS9RRhouH8//1L+VmWmj2EqYTEq+ryjZlaKv/
         1Nl8FSnfC1uNxrItHGD2we7+td/IrGC/geg9hfgeBih8jqOe6ZXogn3ZU+Dj2xJ99nu8
         +8XR8hhVUU581fe6uWjJbal3du2z17ZHGTH2lG+hWrvQKMka24x0j55pESkXbDC2XvOE
         4Z0lFdx00qtKZYmrBn/rKws/OxVLYa4fjvK40EdAmyA5adY7gmhPeFIpRDfOn8CX7Lk0
         Hv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753698040; x=1754302840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=219O2xVBqIOUMv3jLy61uyg7qpqwuip52JZjqaIWS2o=;
        b=AHeBOqyPSsymNHjAaNuNZ+kbrqVKZLyeZKA1wkwiJaMn/gcKkTGkfBz4ERXFacTltA
         j5FDkUjJULugqr89HTU9GQvzrcsdus5iABWvHdk9UEPqVm3IIf2LJSRS/rB1ccdC5YiK
         bj8rMywvNH7/C6W4aOF10vKIK87fQy+MHqIIJp87oL8Lck0sktJGWnlgZ4TENMRgqJcO
         RXs3Ju9sJs4k3u9L6+jrLi3a754sT8RNKnie8jyJiipiTfDohhFHBeTeLabpodxVKtYc
         HvaB8AQXNFCyXoP/Gy4TpI1Ti0dzyynwTjPLfb2u9Enq+8whvMy9L277bulnOYYZ6ygT
         4lcw==
X-Forwarded-Encrypted: i=1; AJvYcCWc4Ndl3QAzXh8QY3SscEIHAD1I7ryFioHNW29uq820Ju+YDfrrsQqY5dCRzh+ZbDieUkB7rABYNrJUAsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyPr1zprUZuLMlDGBSQx75v0zw7Pmj4Y5FrospjtINLiDSgree
	LlrV6n1YMlJYWdj9Eu6efuCti0yZW8SfOOudD5pVEVsYwW9tc+lN4cQvYxMxQorxKI8=
X-Gm-Gg: ASbGncsoXaY8R1LG+HxqrDCimXnzDVyFUMUr0nI00FjgvLB12MqZI1Bb7oAte7CfNWr
	gROPWnSe3W++LOU3blNx/0Yol5vtAEibDdktT6kDLYvKV0PVPOb0WhrwJlRNWIhXT8EfS7BNJe8
	IcpvpsTHozvoRZMyxDVY7sNZ/cffdntT5J9hojun21HtbiVjObc3N4VYDXMKMy+GonQcLpboL8m
	MgA3oL+CDYy6eQOqnt2RMaYAD/qKI56GDkXMi293IbdbYMhFwh/hctEqdiPhr0okubFT+t6oK/o
	ZtLU50MLSjsrnrWEnRHRRpLvuwCT79yjn0VRtivMBOMftfwbwUQbryb8t4dRreXeHagmtbbvnX6
	SL8XzjyLZaTI9EEZpO2qLzA==
X-Google-Smtp-Source: AGHT+IGj5AJyBcYgln1fm6c5zt4uON5qzfUaZeojAc6NG/CRXcwFlI2+uLjZU/QAvrqAIKFbe1ew0w==
X-Received: by 2002:a05:600c:a010:b0:456:1e5a:8880 with SMTP id 5b1f17b1804b1-4587631a095mr75658865e9.13.1753698039894;
        Mon, 28 Jul 2025 03:20:39 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:53d4:51a:4d68:dac1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705378f4sm154610875e9.2.2025.07.28.03.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 03:20:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] power sequencing updates for v6.17-rc1
Date: Mon, 28 Jul 2025 12:20:30 +0200
Message-ID: <20250728102030.44816-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of updates for the power sequencing
subsystem for v6.17-rc1. We have one new driver and a small set of
improvements as well as a fix to power sequence unit naming.

Thanks,
Bartosz

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-updates-for-v6.17-rc1

for you to fetch changes up to 07d59dec6795428983a840de85aa02febaf7e01b:

  power: sequencing: qcom-wcn: fix bluetooth-wifi copypasta for WCN6855 (2025-06-30 09:07:57 +0200)

----------------------------------------------------------------
power sequencing updates for v6.17-rc1

New drivers:
- add a power sequencing driver for the T-HEAD TH1520 GPU

Power sequencing core improvements:
- allow to compile the pwrseq drivers with COMPILE_TEST=y in order to
  improve the build-test coverage
- add named defines for the possible return values of the .match()
  callback and use it in the existing drivers instead of magic values

Fixes:
- Fix the name of the bluetooth-enable unit for WCN6855

----------------------------------------------------------------
Bartosz Golaszewski (5):
      power: sequencing: thead-gpu: add missing header
      power: sequencing: extend build coverage with COMPILE_TEST=y
      power: sequencing: add defines for return values of the match() callback
      power: sequencing: qcom-wcn: use new defines for match() return values
      power: sequencing: thead-gpu: use new defines for match() return values

Konrad Dybcio (1):
      power: sequencing: qcom-wcn: fix bluetooth-wifi copypasta for WCN6855

Michal Wilczynski (1):
      power: sequencing: Add T-HEAD TH1520 GPU power sequencer driver

 MAINTAINERS                                 |   1 +
 drivers/power/sequencing/Kconfig            |  10 +-
 drivers/power/sequencing/Makefile           |   1 +
 drivers/power/sequencing/core.c             |   6 +-
 drivers/power/sequencing/pwrseq-qcom-wcn.c  |  10 +-
 drivers/power/sequencing/pwrseq-thead-gpu.c | 249 ++++++++++++++++++++++++++++
 include/linux/pwrseq/provider.h             |   3 +
 7 files changed, 271 insertions(+), 9 deletions(-)
 create mode 100644 drivers/power/sequencing/pwrseq-thead-gpu.c

