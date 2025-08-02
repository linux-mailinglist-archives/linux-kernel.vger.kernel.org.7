Return-Path: <linux-kernel+bounces-754211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1377B18FC8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D96175616
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D378257ACA;
	Sat,  2 Aug 2025 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="aEUHJH8b"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE524EAAA
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754162762; cv=none; b=dyw9SnqNi+uMh6nWvvMcFHCXClJ5GE4uTFSRvudP8OgDpKhDaeIoJ+styMmaQxbYoyRzdjk+xTyVa4jzxkusftfZ0Wajv+iwEOm+DPWbSuBfehPulBWdTDo6GViILW88RzXUV/UVFyqUc8vFIMO23UvIQe+YPcf/SWpta0uWgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754162762; c=relaxed/simple;
	bh=C1UaNTuACGrRkW2E3FhQG0DrBcJFu24wR9QIIxX6tno=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y8zEDJiBWuvUblm7Y6aA3f++mzGAU6G/U3hZd+oJgJv4AzQj1vpRYeJlmyW4QkvKNioT74VQO7ZgyzqgUkfcEJFUWe240X5RSTTTTLMVZQspFEN+k2T9pfe5Btjr+S9fDGytNOAUaFtt4RTD/D4tPLr7nDofvzsCkoGACFyE3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=aEUHJH8b; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31f3b54da19so2177712a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1754162760; x=1754767560; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jd8Da3JQX6Y4PSybA2tHWl8SitZx9sYR2KOlV5oLUG0=;
        b=aEUHJH8bdr1vepf01E6MoYdajck+mzYN+gw1RnDW0PRCgs2+sOn8zCZOAh7rMEh1Uq
         YA7aQkN+mu+0quP1kj7hMB9XJaD2f+Hlg95BkokMwX7EFByClJO+/qKbzyQuPOjBXfWi
         as0pktJ4+GTKRiABCZuyLMm9HjQtJRdLW6EwFLiiEjPZ1sIKXj/fqaiTeWnMEvY39B89
         6olzq42MImvc3NXcpS92FvhbxZK7Kyt68YkROn2jsbFdjbCI0zAFtCnSoMABvJKWMiSA
         erJiV2j3DRR6va7BzmLzPw+EE8iW6NLTUJLAmAO19UoVSEJB6isdYEDatXrNhfidfF7g
         Vm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754162760; x=1754767560;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jd8Da3JQX6Y4PSybA2tHWl8SitZx9sYR2KOlV5oLUG0=;
        b=gMi7NGNcUj0kkHyTIL/UdOkhiLSGGALV2CkQVlsc0YaR4r3iYLtEm2Sc2ds+7A55pg
         IcUp3reoUgNBZklzBxX8jH0r+24hncDj7bWpZyDfbmxPywxpUqWPA6jkzlDoCHObWqvE
         Olwb2woHpg5X6wYv5GhZsh2yjzKTnngaXOHH10WTepj/6hu1ji/X7Yp1+398HWUrPNnH
         N1HsC+Sr+5h40BZxX5G5C576jcpvhaeYKKbVaYqTxcWntNJjL5wYmbqkIexeRM9Xz3j1
         vqkwDioOEyC01F37n/WgM8s+ykwzpp0iyshn4VAjUO5iOKET+HUscwgRO8+M82evRBaZ
         gmxA==
X-Forwarded-Encrypted: i=1; AJvYcCVocedM2dFmKkzzg0wUkHdxf7l6n2rRJCvTid9K1Vk08paOkxPwu/Q8Hx2JkTyZ7Vgnmf5+l0Sg3lA2qhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyROOKP6lOHAbHqkldtu3gVJfcNmo4lQ0m/4IHCZ8462rs4l9HJ
	NpB8NpayfhukIvZjkG0FzGEhw/p7hBztVYL8y8FMfdnkZtKOzMV4br4Va3/REE2ldgVs4bzIMaf
	AeQHHgcE/MA==
X-Gm-Gg: ASbGncvje4vA0J9oIKCiU9pLr9SOp1x1vyQHLpFmpzhNy56RTe9ZWF1J4Fk9wBSOGwc
	DKDU+HbMYSzSxyltO2l+aqa7p0+U9JmYPm5HHRvNAQLFJdmfyewqGjkTBe2LJ0oJ2LPHzb/AhLS
	ei5jOPGsJgabAP+unQUxTai7H6ggFP0/WlE+RE3lkQuadYhUdTyXZDR8oo+jGnm+v0qKK8cxal0
	kpEz7MAk036j8jyExSpg6BUny7g9oRALW4Ty61mX5Z/FcbwNfl25WaGo1GAN3/qPpnK0JnBH6/B
	5IAj2jSO+5WTiOa1zIWbIFRnKtIyu7+ZDDMhjiXgebcE8ypqZymuaT7sNNHy067pw9dlX2QyN9I
	nN9Lz4PCQ5pbQiBITBBZyj83eO1PcpRCkcM4=
X-Google-Smtp-Source: AGHT+IHO/dHbjA7eIboeg3fI24euyvdKdfkdQISMXRwMVcyEDVOqzT7XWdU+bvEG1Xrt7oOpsscNCQ==
X-Received: by 2002:a17:90b:3947:b0:2fe:85f0:e115 with SMTP id 98e67ed59e1d1-321162dd19cmr6357739a91.26.1754162760525;
        Sat, 02 Aug 2025 12:26:00 -0700 (PDT)
Received: from mystery-machine.local ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207eba6bb8sm7887583a91.4.2025.08.02.12.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 12:25:59 -0700 (PDT)
From: Brigham Campbell <me@brighamcampbell.com>
Subject: [PATCH 0/2] accel/rocket: Fix build errors and sparse warning
Date: Sat, 02 Aug 2025 13:25:45 -0600
Message-Id: <20250802-fix-rockchip-npu-build-v1-0-fb0f0dacb3fe@brighamcampbell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADlmjmgC/x2MQQqAIBAAvxJ7bsGEyvpKdDDdcilMFCOI/p50H
 JiZBxJFpgRj9UCkixOfvkBTV2Cc9hsh28IghWyFEhJXvjGeZjeOA/qQccl8WDS6b4dFK6tFByU
 OkYr5j6f5fT8NmHveaAAAAA==
X-Change-ID: 20250802-fix-rockchip-npu-build-ca759ba8da06
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org, 
 Brigham Campbell <me@brighamcampbell.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=805; i=me@brighamcampbell.com;
 h=from:subject:message-id; bh=C1UaNTuACGrRkW2E3FhQG0DrBcJFu24wR9QIIxX6tno=;
 b=owGbwMvMwCUWLsWS0KCyxZPxtFoSQ0Zfmtv7o5uupt5bnPdMjn/f526m5kVXn/6sVQpTOp96+
 PeaOuWgjlIWBjEuBlkxRRaVW7PUL062fnQwgn8CzBxWJpAhDFycAjCRwCmMDA/UMytqO5aUsglI
 KG23b5S6fGmhnm7l78kzPFQjDRn2yzAy7CmRdzylbH1S+l3i1E0JX9tXmZ0Nfqj0aUIgp63bdLs
 4RgA=
X-Developer-Key: i=me@brighamcampbell.com; a=openpgp;
 fpr=24DA9A27D1933BE2C1580F90571A04608024B449

Fix two build errors in rockchip NPU support code which were caused by
the integration of recent changes in the drm subsystem.

Fix a sparse warning regarding an undeclared const, rocket_pm_ops.

I tested these changes by enabling DRM_ACCEL_ROCKET and recompiling with
`make C=2`.

Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
---
Brigham Campbell (2):
      accel/rocket: Fix Rockchip NPU compilation
      accel/rocket: Fix undeclared const rocket_pm_ops

 drivers/accel/rocket/rocket_drv.h | 2 ++
 drivers/accel/rocket/rocket_job.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)
---
base-commit: 01ac6e4e53b6351df42c97d217b0d2dbeef5c917
change-id: 20250802-fix-rockchip-npu-build-ca759ba8da06

Best regards,
-- 
Brigham Campbell <me@brighamcampbell.com>


