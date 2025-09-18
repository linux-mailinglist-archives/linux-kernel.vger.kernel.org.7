Return-Path: <linux-kernel+bounces-823220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD6EB85CBA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 405804E238E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05175314D39;
	Thu, 18 Sep 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZQV5awpy"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8252930CB40
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210768; cv=none; b=emMjF4erSJM9R7KF3PGkxI9QJy9Zs6UoB4pbYWewpcLekkibOgpwyoiShJyvB6/YgShFarDztR4UXJiFZSj4sQdUK64ooV1C3LHNxgl/UFP9CiMSg+v2YzgNgSHQ0kWaLy6RIh/k1Sx0lcpFuEWtoz+IIvP+dkN3g3aoF6b0c7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210768; c=relaxed/simple;
	bh=XEbVT5cHI/ZnCfuYl88356BThxY6qeHy1joKNaxu4iE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=koJOLU8BFet55EDMg4V9I9jTWXbwImWrLRLk2xFTUXVdYydqyCNRRKbbw0XNgXZ2epYLsCfuzKo7IXKY8yOUzyauvNeB9EVJUxr3L11Vhn3+LucGc6rSZSrTsqitX1McSZFcRX8xBVMm31mHeGAIf+s2CCRnYkcwKPoevVAkaEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ZQV5awpy; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7322da8so197323866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758210764; x=1758815564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAYxgB8lIv1DHNu4xD8U3kG1jVIbjN/0r1y6HPZ0wc4=;
        b=ZQV5awpychRztLaM28B//NRni3sBVO0CZHnvdb5eCqu/8ok4slX9R8bCmSekCJMp5C
         Vyfi49ackacPUutjM21YsZgir3x063OJ4ZQM2eizO1ENtXDl05e9NSuPjYFjEZUxVJnr
         cLDg4PxdH8BOwYfESx+sSDIlLDhhgU8uPZsks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210764; x=1758815564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAYxgB8lIv1DHNu4xD8U3kG1jVIbjN/0r1y6HPZ0wc4=;
        b=bU1+mCqpsagBZhj9CF+b0I/vTANbI7YXbRqe8sqXphf12gVBen2itbRES0MyK6xBSX
         ldKRuoyc8sF9phEWBQUl22rzCJ6K31TlV+wxQqOPYP2ccoturQ90NggYpwRYhaHyfH9T
         vGVNfBG7NTYErzU6IZUsqmrSWQJkjGmrIhyx6LSnIRoeRdmm+POUmxQkiyDW6bM3lLyS
         erZSKaNc+YQY/pYBiefOW3NNEsd3drsZMN5L90FS7uoT8tvr8fB310A2DhURWqXyHaR4
         TVtR4u1aPdeJ209AefE7V75D0EmpPJ5fRc3PL/hNei0ul0e3wkrIFiQIs6+EYnYILWsT
         z2Yg==
X-Gm-Message-State: AOJu0YzRgIOhD2bP7wnGSKyiseeMPHVLczB2ZxeRygBW0tGBZ+uWxkPI
	CCum+TQuwghJBUSeno6pIqifEKHHTn1KId1nkkueyQzAtP0CMwrpLdYbyOkAgVsivFVag2k0zHu
	QwFdW
X-Gm-Gg: ASbGnctQ9j78vdZ0sZx0bnuOWvhsl0DvmgO7eW5lmMa+BqyoSGcVfwPoiLqixHRa5Nq
	VmNlzjk2YIO6iwmObezl43/tigNPWqByw//92n1f4+o+3ISu9L6o/BEg/ko82Z3zHnTyi0Auak7
	IMowOdgvtT59Bjv86JldmqRzfKzNyj2PmoNzozMmGfInpV2qTGVEMrhDr4CqWZfJVR1Zvq/As0E
	7eIa1lwo8tUGY8TD8/nYyQJPhXE4wF0CvcTLa2C7KaWDfTGcLDAJo9dodwFBVF6nIhK8OTNtm/k
	H6oPxXZtBnCG+cpLveCyuGS6mYt/Ykdyjq7+24GgrsRXuwP/EFqZ3CMSN/YUtJoJrNhqvn89hFL
	wtvP9p1iKS7s0+2iSnm/m85anz/A2X5z+Qh6HbFyphCp6SXGTX/KIlu7axkj9OiyG2CNFjd6kA3
	wlphib8MyT0euZvlDxS5xHi1qicVx5irK7ZRVUPRB1TsEKkPoQM/CP5w9lWC4y2PPv06/N4rOJM
	CAlBxm/wCA=
X-Google-Smtp-Source: AGHT+IGEnllZKc46D2GPpX8tp6qlYesswGm+zRYFM4v7XWzLwEmIplTDvSQ6hbelWc77fsdE9AoPPA==
X-Received: by 2002:a17:906:d145:b0:b1d:285d:185d with SMTP id a640c23a62f3a-b1d285d2b12mr512201366b.0.1758210763485;
        Thu, 18 Sep 2025 08:52:43 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b23a1227bacsm60449766b.41.2025.09.18.08.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 08:52:43 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Javier Carrasco <javier.carrasco@wolfvision.net>,
	Jeff LaBundy <jeff@labundy.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Michael Trimarchi <michael@amarulasolutions.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
Subject: [PATCH v5 0/6] Input: imx6ul_tsc - set glitch threshold by dts property
Date: Thu, 18 Sep 2025 17:52:28 +0200
Message-ID: <20250918155240.2536852-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The series allows setting the glitch threshold for the detected signal
from a DTS property instead of a hardcoded value.
In addition, I applied a patch that replaces opencoded masking and
shifting, with BIT(), GENMASK(), FIELD_GET() and FIELD_PREP() macros.

I didn’t remove patches:
 - 2/6 Input: imx6ul_tsc - use BIT, FIELD_{GET,PREP} and GENMASK macros
 - 1/6 Input: imx6ul_tsc - fix typo in register name
even though they were accepted, to avoid generating conflicts detected
by the kernel test robot.

Changes in v5:
- I didn’t remove patches:
   - 2/6 Input: imx6ul_tsc - use BIT, FIELD_{GET,PREP} and GENMASK macros
   - 1/6 Input: imx6ul_tsc - fix typo in register name
  even though they were accepted, to avoid generating conflicts detected
  by the kernel test robot.

Changes in v4:
- Adjust property description fsl,imx6ul-tsc.yaml following the
  suggestions of Conor Dooley and Frank Li.

Changes in v3:
- Remove the final part of the description that refers to
  implementation details in fsl,imx6ul-tsc.yaml.

Changes in v2:
- Replace patch ("dt-bindings: input: touchscreen: fsl,imx6ul-tsc: add
  fsl,glitch-threshold") with ("dt-bindings: touchscreen: add
  touchscreen-glitch-threshold-ns property"), making the previous property
  general by moving it to touchscreen.yaml.
- Rework "Input: imx6ul_tsc - set glitch threshold by DTS property" patch
  to match changes made to the DTS property.
- Move "Input: imx6ul_tsc - use BIT, FIELD_{GET,PREP} and GENMASK macros"
  patch right after the patch fixing the typo.

Dario Binacchi (5):
  Input: imx6ul_tsc - use BIT, FIELD_{GET,PREP} and GENMASK macros
  dt-bindings: touchscreen: add touchscreen-glitch-threshold-ns property
  dt-bindings: touchscreen: fsl,imx6ul-tsc: support glitch thresold
  ARM: dts: imx6ull-engicam-microgea-bmm: set touchscreen glitch
    threshold
  Input: imx6ul_tsc - set glitch threshold by DTS property

Michael Trimarchi (1):
  Input: imx6ul_tsc - fix typo in register name

 .../input/touchscreen/fsl,imx6ul-tsc.yaml     |  14 ++
 .../input/touchscreen/touchscreen.yaml        |   4 +
 .../nxp/imx/imx6ull-engicam-microgea-bmm.dts  |   1 +
 drivers/input/touchscreen/imx6ul_tsc.c        | 122 +++++++++++-------
 4 files changed, 97 insertions(+), 44 deletions(-)

-- 
2.43.0

base-commit: 8b789f2b7602a818e7c7488c74414fae21392b63
branch: tsc_de_glitch

