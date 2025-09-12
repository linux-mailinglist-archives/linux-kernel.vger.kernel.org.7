Return-Path: <linux-kernel+bounces-814162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C3AB55019
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30F4F17F84C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAE13081B8;
	Fri, 12 Sep 2025 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YD8HcLgv"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA30414EC62
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685296; cv=none; b=UV79G08XUqXaI4E1OXlAWXZRFotl62zIe+b/V+uVnYOO7+tM+95fKUdjm25WzbRVO1malek56zOCq41tLsZk5FjLRoehLCfeS1Z7bvzB4eOjGRqOsHmElR8R9yZAUYA6xsHM/lx/mI3+x3rhBc4hrgSDhwRh0dJTsmbpeuW6Rzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685296; c=relaxed/simple;
	bh=+R3H1ZTHIpjD/7gpvZo0O5OPpiEvSR7fzcYJIZTMjmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FcUBjybB8U8V3NjwhTxabaz83oghGzjMjvMLJMBE6nvSdpPDto9r6S4/LDpOy9ht4GLA06bAjVd5eepihsOZLBhjx80wDKnG4c/oU64owHiKisyVBQazwVFIEtUkcuvtqiq1CUiuWTPcE821uLdCIGTYKKPVX47+1sEui2LxEhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YD8HcLgv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3e35d87f961so243254f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757685292; x=1758290092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3tTGGzjAuGZXQWRu05vrCKimfXwg8uSaYFn3EC8TDkU=;
        b=YD8HcLgvZ0NyJ+QUG1IF7uHyU/W1myDKoVCCBx81zT8Y9ZXfvvQM9tGAEBu8d0NiTb
         Rr+c/xAUU8Ut7tnsHaNq+WSNvCDi0qLjePDPUUIAQONa+11AGBuB+opMl1w6t9Lnm2m6
         hUVDu+KxlEkyohIkkrxiIlCHZ0SWFIm2AKeU2xskdv6roKPZGCcpixxKjFjRL+UNTxwP
         leiE9Zjq3ZlT8zDX8PFRq560WY4CwwFwLUwZJVVf43AChYg9Mn2zvYAG4NYB3MfzrtcE
         +sRfeGiutLwhKZfpfkEwP0glvGZjOx4I+e2nAVIlF1nmPoVcp+Ns8e7pKnYN+INQJAZC
         BylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757685292; x=1758290092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3tTGGzjAuGZXQWRu05vrCKimfXwg8uSaYFn3EC8TDkU=;
        b=YfBezgzT3MdEk8+eTt45e+//EAxFfw626Ce5pVUo/g1fUe0JK2tv/Sg/9jFwd3ZjSG
         FdfzC4YqRQeFETEqlVv6+j7bR71LbGfJL29kfkfT6wfT8+DkOnUUYVgY2cPCjNVt+8hf
         wAMaTjUEsMskASIpoAUnUnN3Fqd9hyMf3zitQsl/+VBpz+f6gfMhqEtl21paDCmoLh4D
         CbtDIxcVfhWFsJ2v83JVDFnuuewsvH8jUcBeoyRY+E++JQITbJsfWVkaoWJdn9c/y0Nm
         1d99pAXBPu/KOkOu+CtvwAsHGUJ/co5UKr7tQ4G9NvYARTWYlOWILg653u2Z21QvtkaS
         Ytgg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ3TIRF2+iANXN9eCkddWZUaiix3aqZzJfCqmCKCE79/eJrrRnObhpkK7J18+VmGZ78qzql3IeqZ6jWz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16+xSYhPYZt+HjH9Upj/FzRisyaQ0mg1WL9jHWsoBMSBazPcy
	ayfzKUCD6ExPgfkMWxp46lL9UCJicwYy8g1ZuEsMh8WrRLWT0lPfaBC2gu5IeS7gwqM=
X-Gm-Gg: ASbGncvhVwcl/U04vCjQ2hh7ALrhKYCYSMxHyAW52+kfvzepM0QFzQOmp4s3dn2o9G+
	3a2Opk0xz/t0AuxSpqpK8yxquj2C2FR0B2XCVuPfkV56yl/0aY7EqmCVMiQXlLcrEtssd+mskdO
	ls6yGqFmAUc0dF5pbRhsyOUVCOrgR7HCR6hL7KevOVce1Z4kLBgnCekzno1AsXcM5nA6uSVyy3V
	f8yD7m5DS20Pa1bf433UTgobBjusz3mXu1q3Se+9HZLbet3qP/SlR4fAYyfsmR6UtcFtScSDDq0
	s0oUuFGlKUgTuc+T5iquSCPNwJKFS2jPdHoK1/GfqJ9Ewp+4F4BYGwa3/gGzN7C3llTG6tgfpQ2
	11VNbxPRwvgYRepk7zIxHcdO9cRolxgXLUPk78Om2GjI3
X-Google-Smtp-Source: AGHT+IHa2d6N+I2Uzmdt0WNUESJkvL2LyjiN5VutHgQP0qs3PTN9Sv+qvKSGg2es7vfBpKw/dNOTtQ==
X-Received: by 2002:a05:6000:230c:b0:3dc:1473:1a8d with SMTP id ffacd0b85a97d-3e76553700amr1475966f8f.0.1757685291885;
        Fri, 12 Sep 2025 06:54:51 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd329sm6749615f8f.31.2025.09.12.06.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 06:54:51 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	soc@lists.linux.dev
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] samsung: drivers for v6.18
Date: Fri, 12 Sep 2025 15:54:48 +0200
Message-ID: <20250912135448.203678-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=+R3H1ZTHIpjD/7gpvZo0O5OPpiEvSR7fzcYJIZTMjmk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoxCYo+Pv5PhFkoqL+D2aJfApilJiP0CroSyKj8
 yHoC5S2/9KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMQmKAAKCRDBN2bmhouD
 119+D/wNTh8XCX0eJ1D+00tjKjvAUyIG70Ce8hwuspf2+Y/ZmUzzUZi3xCB2ExpCgMZ1SEHF0bS
 LJmEYKHjPexn37YqQs/O7V84sqOYJoCisxXUk5Gp9JM0SzUJ6yqZ9M4KoeJuq4PVd4x0cCl2DDv
 oFV+r6qKgwWyh/EVqokjUXqABdJhpGz9M2Wn1sSWRF5n3gujv3K/Sx1TGsbZgvbXxQWIQ58CxrS
 m/Tey1RNtLzTnrkorRlHcxbEDYt5fojnUgci4ebJIlG7c08f6N7vW+D+LTJYHK/FPy603PsxjwS
 XMmGu9EzyvflPL0r9IZfExuXIl+cv0FZ/ZWgHcnC8HGYwGOVG1ryDfcfRLo4GBcvx8vUGjBYFzL
 TU59zS2BkyaxpD6Cqh0Y6vTQdBb1eMjknAhDzouj27ZEETVsl637qEXAsFns6XigH6VVhJ4Nxfv
 FKTYKG6wNttNaCrQMdChdPHCJGrJhGwZ5gWFmeg9YoubQfFiqFLHASrdVyOSW0Jeu4OaZXO2NM1
 LHVnFaiNFHCP0JicZ51wIUqzoZCIUzVQwapxAfZaTrzhOurAdWWSSQQlJcijQTd42DZHnWaB2jN
 ZTImPN0hxyAK5KV3rExKxZoyfMhdIbnw73yrMA8atLu/Fg2x9IQLgmljorXpmViDqRq3698QMod iaNGtFLV2DD+xAQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Hi,

Samsung SoC driver sfor v6.18. This should be my last Samsung pull for this
merge window.

Best regards,
Krzysztof


The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.18

for you to fetch changes up to 1da4cbefed4a2e69ebad81fc9b356cd9b807f380:

  firmware: exynos-acpm: fix PMIC returned errno (2025-09-11 11:27:05 +0200)

----------------------------------------------------------------
Samsung SoC drivers for v6.18

1. Google GS101:
   Enable CPU Idle, which needs programming C2 idle hints
   via ACPM firmware (Alive Clock and Power Manager).  The patch
   introducing this depends on 'local-timer-stop' Devicetree property,
   which was merged in v6.17.

   Fix handling error codes in ACPM firmware driver when talking to
   PMIC.

2. Exynos2200: Add dedicated compatible for serial engines (USI).

----------------------------------------------------------------
Ivaylo Ivanov (1):
      dt-bindings: soc: samsung: usi: add samsung,exynos2200-usi compatible

Peter Griffin (1):
      soc: samsung: exynos-pmu: Enable CPU Idle for gs101

Tudor Ambarus (1):
      firmware: exynos-acpm: fix PMIC returned errno

 .../bindings/soc/samsung/exynos-usi.yaml           |   1 +
 drivers/firmware/samsung/exynos-acpm-pmic.c        |  25 +-
 drivers/soc/samsung/exynos-pmu.c                   | 276 +++++++++++++++++++--
 3 files changed, 275 insertions(+), 27 deletions(-)

