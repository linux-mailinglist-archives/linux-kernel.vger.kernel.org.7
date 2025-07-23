Return-Path: <linux-kernel+bounces-742332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7D4B0F011
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6082B3B93C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 10:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BDE248897;
	Wed, 23 Jul 2025 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKxY8/rj"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4936328A700
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753267149; cv=none; b=szeGPtIF6Sq6WEPYFRllGywF0ZJLIq7zFzFGC1N2igwwI7AeKjW86UF7NM6sQriF28S7XHkibn4e8O/IS17ug6lyNcJvkAxOWl0SFQU1PwKR1f55B87gVwvTpReNcSUS4dekMfRXeFkC67/PSEa8XT3iinjp6xvRdun4XB9TifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753267149; c=relaxed/simple;
	bh=9WicMZ0FvlfVMTRmnsa6r0HX0R3VrCim8HjIAXHgfK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lGvqmcfJQm0NiXyxaQOaqyfjEzHEHGpZHbsdIwyVmT85Q/Xh0ONDYrBhJSwGnN6wo92dbGufnBRgDOUgNf2p3BVsZBVKKh+7v5eno1gh31np5W09ECMOLIbKNBtDyznt3yECLxI3LxTVelxnG+Ne8aFsqTxHcz2Dn5aJnJK0f00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKxY8/rj; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so10265772a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 03:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753267145; x=1753871945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J5iTEuPm8PXvAv97xyJNqssuf7uJW8wkgDFwGB5kF8I=;
        b=aKxY8/rjtR8+8K5D4WzWCfjKebpwL0U4ecg9FzszL1UADlRQubUbJfOGXmRq+Ioswh
         kxG5gPOvr8MK/A1NNZ+UZWmm7HQEpMk89rJXOkFj6GwK4ShRv5Ltl1ZwEA5yctwBbAgk
         KXhEiFb57A+AET3W20oUn8ifNeczmNJYSTc0CMGWpv1FLp0cvsGeBwAtx40SV0BLWxdJ
         m+LNsKz/v+GurNWg1Ei1qaRDwFvYKZ8giyZ5NagbQ0M5NbWKRKqxqedmlz2YUM2QjCl3
         S2iSipu6CBaH5Xd3qq+wkDLlWAXUtH9v+DHJyiicyzD1nYMFBIBqCnFlMo7SVLZag9II
         Tc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753267145; x=1753871945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5iTEuPm8PXvAv97xyJNqssuf7uJW8wkgDFwGB5kF8I=;
        b=LwR5fhvVBhQujuh2/RJARZTJOO7CMRFeml+xhhj+1CANQc/yGEsGc5DtP3zIyI/lgL
         kNGjuHk4BVilSZdKJYcR3tSYz/ZmtYdvan7nDte1q22q7VoUdkA7nPQclVzRmAyhnqnQ
         izQtdRXPK2DzaBAlvcN6cxeY3/nSTZ1+y3V5StHuxQUVOZC9ls2lQdDiaA0h+Wj/WJ4f
         SJFZmqpuEM+SbAMl59ye/rehwGC0Gq+X9xVVgvqJVrr7V9ty/Vi1JbokvjW0Eel2xlvS
         DvqBErjZmOrbvaIV/qhnqrzzzjt2UurYi+gf3opIlcUBTKVk1yIsaPuRuZfuZTleAVHT
         nvYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWESuo0oaSGwdwV/+X0VZwWE76IrlYj0qfXxg7QEL1ZYq1hJTjVrHal5JqCr5VlUaQ11HJ3b4TSM+UaAmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzMvCG8IJQMl56X1669P4aUwUri1SPY1u2aceODsCvGiKJtAFQ
	kiPJLq3RHw7ch572hVzFiPJ5T7RQzHnW3sNV3/03jpXOayYUp04OXVf9zTzAfWzg0dM=
X-Gm-Gg: ASbGnctckl8+zfVLV6rHO6qpPxRM9czYRESDsZXEVavr1PJCzxo6Y9nmqb0KKDlfpz1
	tLhJfLhmTKrTTK5SN3jvUqfU36Rd193vxdiy5imXvhQf3K42blas/kR0H/hVMviP1DoZoUdlutc
	Y3himdGxHG9E9EKQimaX6YxgPAvDGyb3yaXixhALgTuiPKKSr04ApU1JzP35Ss+rjZyQYZbTxfh
	FTagptRDD2euUy6zIXvsqlR5bpXacLYychqo/gkkCSQwcSXtS83OSZLMfrOMqbsOE/NNMH3Et5S
	my7yqoop+00Utz6bsRj5NQQFdPzVpsXMt6Jh55rG+CVTbCQifX4DV4axU4uP1RKue2dfnv6a0gL
	hZQRuuAkYy7vHAjIiiJgGhlY9SyfEnSY=
X-Google-Smtp-Source: AGHT+IE9kD3d46UGakbV9lDnsOWGYgjtTl2vVJnO3SnTKV+RHc/bdrYKZCM4+1r0ZRNOsbXZk/HelA==
X-Received: by 2002:a05:6402:5244:b0:607:f558:e328 with SMTP id 4fb4d7f45d1cf-6149b40d059mr2124453a12.5.1753267145272;
        Wed, 23 Jul 2025 03:39:05 -0700 (PDT)
Received: from hackbox.lan ([82.79.186.23])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f5cf4esm8150799a12.32.2025.07.23.03.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 03:39:04 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
To: Mike Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: imx@lists.linux.dev,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-clk@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] clk: imx: Updates for v6.17
Date: Wed, 23 Jul 2025 13:38:44 +0300
Message-Id: <20250723103844.1641282-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/clk-imx-6.17

for you to fetch changes up to c78865241ecffaff7ce5db00ed5b71c1a70c0ff1:

  MAINTAINERS: Update i.MX Clock Entry (2025-07-21 10:33:57 +0300)

----------------------------------------------------------------
i.MX clock changes for 6.17

- Document bindings for i.MX94 LVDS/Display CSR
- Fix synchronous abort in i.MX95 BLK CTL driver
- Rename LVDS and displaymix CSR BLK needed for supporting i.MX943
- Add i.MX94 LVDS/Display CSR clock to the i.MX95 BLK CTL
- Update MAINTAINERS entry to include both nxp,imx* and fsl,imx*

----------------------------------------------------------------
Laurentiu Palcu (1):
      clk: imx95-blk-ctl: Fix synchronous abort

Peng Fan (3):
      dt-bindings: clock: Add support for i.MX94 LVDS/DISPLAY CSR
      clk: imx95-blk-ctl: Add clock for i.MX94 LVDS/Display CSR
      MAINTAINERS: Update i.MX Clock Entry

Sandor Yu (1):
      clk: imx95-blk-ctl: Rename lvds and displaymix csr blk

Xiaolei Wang (1):
      clk: imx: Fix an out-of-bounds access in dispmix_csr_clk_dev_data

 .../bindings/clock/nxp,imx95-blk-ctl.yaml          |  2 +
 MAINTAINERS                                        |  4 +-
 drivers/clk/imx/clk-imx95-blk-ctl.c                | 95 +++++++++++++++++-----
 include/dt-bindings/clock/nxp,imx94-clock.h        | 13 +++
 4 files changed, 91 insertions(+), 23 deletions(-)
 create mode 100644 include/dt-bindings/clock/nxp,imx94-clock.h

