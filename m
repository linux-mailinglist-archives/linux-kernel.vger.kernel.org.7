Return-Path: <linux-kernel+bounces-810309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22968B5189B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09A9C4E3673
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AE1321F38;
	Wed, 10 Sep 2025 13:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RX3VqmJa"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA82321F3B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512763; cv=none; b=lUgv1l2iOA80lygjn8aXRFrlfyYMOp3hIEdd9EEt9xwouVeUrUnLCPiOkGPY5hyIqLaHDNfrrcIe4ctnyzWbgOMyDqvBIj5pwRnOOSuKPwRb32drwl1p12FE5GxTtsKtlhHNv2/YCuvMqe83+STcLm94eEwqxnhqiILzViJ1SYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512763; c=relaxed/simple;
	bh=AWJAwvgvveAZl1A50d2qJ+nKO1wYxvt7+BQ4m1FIVUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3ZB5DKjMKHkMXQcxgDBupw5JAwXKFslh9Q7dXKKC8noukAWFlM3+6XKHu7D71t1ys9L1DIiaTESot3Sg/VUJA491gREDUjWM5FpwLT4F5ByxP6NDi1Qyxybq2dEVDOQ5EA0Vc2txTnm59DLC/f0srdCq1Cb6O80Q2tnW5QDE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=RX3VqmJa; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7ae31caso1133680766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757512759; x=1758117559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3o5U5m9O7nE0eZDTkvDCuOBdIrzGojz2eY5IrxD0WOo=;
        b=RX3VqmJa2b8O97kue4xrkVpuhLeNv4D9ml/AFe2APfEmDOQdSkzAZhdTPcCa6RJGIB
         HC0IsQAPjVWcysCb1nCZeQQ0i/GMIGXvoV+DpkgF+jRop6gF4N4eQ32MSt53eBzHQbCv
         39rzGJsWFL4P5SF/M2b3IEbnwvLqK2ECrRuXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512759; x=1758117559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3o5U5m9O7nE0eZDTkvDCuOBdIrzGojz2eY5IrxD0WOo=;
        b=uqN7rtLzgeccLqIqF3HFdRfTlGntGLfE1IRZg6Bo9FENTji/HF4Dpz46sKccJCrsx8
         HQZxMIvj7jUPER1E8xNl5aeKGY+z/k/jdfiELfBV4mKARRvOYgvdYLpdf14HUykVQX4C
         hLxgqLe54huXXdFY4RXPqaIMsYYobn9c+oz9brk6B25geme9HGdglzuL/6NZX2dm0LUl
         0CeqQlFe6r7TH1CwsdJTPNVSKf7hQVTNZMd26y9eUgL3rZ++vrB8Q57RB8asEY4OCDm8
         lSwPORVg0e3Uml1WK2F2OOZZR/7dcR+zrJb3GKlZ5XqZ5vvvglDVsAKFWcUcTTKJnals
         iDpA==
X-Gm-Message-State: AOJu0YzeMhqGgpCzMU0ks52rsUZRcMU+tDLq+TS0/h+v/21IbP2yvyR+
	xqEpCDtAePr9PckDHOeesdzHQkW676jBQ6wBJBLxvuSuPuC1ZCwaxo9l8OdmEJuFc4D+W9UIpo6
	OfCYT
X-Gm-Gg: ASbGncv1VGjKvsP+rYK3cqUw9SacVtCIpXZAxSjztEaCz33pyMNN82X763YenXP3W5c
	9XCEmSrigcIsIK6s6PDlWhgRw1Wa/IT0t+aS6ZoqYvZwAtXtMkw2+e4SDprbs+UaeqpkdKnf0L2
	ZdDmABLlEcoH1Md9DXxMbHuhGhvSLy66Tm9hphzlJzVW5IAfWk3BalIQqoupXtnK0zr85FMBzMl
	1fGw91B6ae1hHjV8tpo9TGymkCZJHFQg1HS74VQB1H15u4S8hHo8stMVuiKk9glmR8J+9fBzXcQ
	8FExy5R/ePqJzZ+2Hddph+ZHjtMIjncXvB1w91DB3uc82ga9DatgYRMjQCdGY+1w1J9JQRJ9EwA
	8bkFs/S1rSDGGsnZSRvE6Q6IxwQn0rqOA2P4cC5pTVEW4emrA7Fq5QH4FrJpwJOJHCERuHHvQ6v
	Z/eCh+JLsELS13f2ROdNnGugQoMw1Kpf0Xao0ArZxAV7nwVwB1jzj7+iCnjQFQjpZJXoKSc2ulR
	qE=
X-Google-Smtp-Source: AGHT+IEM5i1cMh4aLi1EphlUfiAbqmiYBmZm0lNR7FL1Faw8bxW5JsLRVOWS0WjIXeABAYnQD9GwCQ==
X-Received: by 2002:a17:907:3ea2:b0:b04:1b90:8d7a with SMTP id a640c23a62f3a-b04b1463381mr1739025766b.27.1757512759136;
        Wed, 10 Sep 2025 06:59:19 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07833a4e37sm172523066b.76.2025.09.10.06.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:59:18 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
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
Subject: [RESEND PATCH 0/4] Input: imx6ul_tsc - set glitch threshold by dts property
Date: Wed, 10 Sep 2025 15:58:34 +0200
Message-ID: <20250910135916.3939502-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series allows setting the glitch threshold for the detected signal
from a DTS property instead of a hardcoded value.
In addition, I applied a patch that replaces opencoded masking and
shifting, with BIT(), GENMASK(), FIELD_GET() and FIELD_PREP() macros.


Dario Binacchi (3):
  dt-bindings: input: touchscreen: fsl,imx6ul-tsc: add
    fsl,glitch-threshold
  Input: imx6ul_tsc - set glitch threshold by DTS property
  Input: imx6ul_tsc - use BIT, FIELD_{GET,PREP} and GENMASK macros

Michael Trimarchi (1):
  Input: imx6ul_tsc - fix typo in register name

 .../input/touchscreen/fsl,imx6ul-tsc.yaml     |  18 +++
 drivers/input/touchscreen/imx6ul_tsc.c        | 112 +++++++++++-------
 2 files changed, 86 insertions(+), 44 deletions(-)

-- 
2.43.0

base-commit: 9dd1835ecda5b96ac88c166f4a87386f3e727bd9
branch: tsc_de_glitch

