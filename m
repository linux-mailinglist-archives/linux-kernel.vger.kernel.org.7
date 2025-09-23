Return-Path: <linux-kernel+bounces-829124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF5B96579
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF357189C0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1EC25B69F;
	Tue, 23 Sep 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LvNmLokf"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93BC2475CF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638274; cv=none; b=H/tiOP/F1NCryF9Lh9yawJR7SdCoq4if9eFubRK1KH7RQy/1cQI2EFyJClxR389esjz7Ej9miQwFDTFxhInHtpfWgbxrS97oMSP75yy4R1NCe69AF372KaErf9yS204zNA9438E4+6IoyLPPCIDcS+bRax5dzUPeEASJng5pvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638274; c=relaxed/simple;
	bh=6I8cNrAL5aASSx+Mq693VRQEuVTbmLc4kgQcskbdlXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JpN5LDPBeWcyYCDrL63ep0EfGRdCzOIrataaHNA63VAU5SjoEhpuiEJt0FIOz+cBDYmHCaOOz2R1HOGR86Iec5PrblF2NDD1BWyjydDLzkTDlhlOFJuFOpBde9NLSjZ3WKRoQ5ZWAp352oDtBeMsh1mIFmGqZdyjROi7xppCw54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=LvNmLokf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07883a5feeso1118055666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758638270; x=1759243070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dGN9wOEKVu6Y0MkI62rSbl1+YeaRDVK+dO7uXaWW+zY=;
        b=LvNmLokfI31g8NI5TgZwt/hZeM2rgaJrnHzKofxablCCFDLK36NsDMTSxhT7TgdNoM
         sP+EIRPf6h9U+w230bVh8ze+KnNdZJALMGyur5PgIJaxxXZ4y5Pjdro3wf2vFaZ4yE72
         DFEjQqDBXEkPEaXD2c4vJEXlU0tGeqxU/7k5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638270; x=1759243070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dGN9wOEKVu6Y0MkI62rSbl1+YeaRDVK+dO7uXaWW+zY=;
        b=FevSQjWymvM4PWg+umZUDvv5EZuPlztpcBa9q1tKO4J/KYYU3EG5KEnxunTvySw6H2
         slzSuiky51zPD3LTDpvlcC1vnx33fA74IUUscofnt048TsdQF6NKUYh9ZGpvym9xYC5B
         vfETLWA88yVdh7pC6QJQUm00BSqe7IByyqD3xwBStAuImqRdk7/vrTAxoOt9LTI7u4DB
         gIFgUF9gWtCeb5LmcrQ6SNg6NJAzxK+MlUZKYSoFaK7frZxl+xDOH5RJMkl9N5ovFtm2
         0R8lEmM7fmbMLVjZqPwoBSWWYfg9+0iO+VdTXewZcue+S8lKOfokILFiESDYpTh8mnBZ
         ZJ9Q==
X-Gm-Message-State: AOJu0Yx7NkkmIoCRfHh8G81LHKTbyCKdQ5BQV13TgEPrPODUK8B18YYG
	tf3OmkQmKiUQ0yss1JaxS9Cwvfu8YW27kB2DiOkUiLuHvu0lD9qb/I9adSiGgJ0FVn0i9FZJyc5
	jpcnE
X-Gm-Gg: ASbGnctnu5uLuDbTwDvigQai31L5pSKrwL8syOA1I8fp17Cwr7KDxseH5M4p+2C57uh
	bBY/rVoT4p1Gffcrlq+df8/xnnBx678hixTflxvgLKNLI+zVmCI2So5/aCwrUa5TijulGCL9A0x
	KAxhbj4F/SZSRgniWCPY8ipxsCdGzCd0IG9igVgBm5YK4O973EEuFQD/9REz0mOnR1v38rv8Gms
	doBMrj8tpLsrjGSf4IhPXTv8kx7DqqtnHFLoP1XthUNuR+/GHON/fwvYoiaKfRPrFB8/8R+hHvf
	4fGNxB5e7HLP5i7nV1wt9i4nNOH9nZnoFiiZmWvQ48BEdvMrvDFvDgIdTOT1Z/kOS/jlEuaTOom
	pOmN+pxUJ2wxv2+x5lMnw0XMtWMiec7W7Nsqq8gQRvVdIxslx0je8waVqakH3PSQm16rGyAysTM
	EvZxn1Xr2UOiodNnpL67hxLASMF6qFgvpTksEkJf4UoiVOdxmmtnDlaK8qYvlP9MbMtniNm2KOU
	P7LMJQgg1ScKR37PVfIAQ==
X-Google-Smtp-Source: AGHT+IFwttb50sZUcwgmSz2G3CQLQR5bfVABRjQhUNlQEOt6l2vdv9KmhVHV1IgxO1W1paqY4PecbQ==
X-Received: by 2002:a17:907:2d11:b0:b04:a1a4:4bec with SMTP id a640c23a62f3a-b302bd129eamr273054866b.58.1758638269935;
        Tue, 23 Sep 2025 07:37:49 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2a2a5f6c7asm665204666b.28.2025.09.23.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:37:49 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
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
Subject: [PATCH v6 0/6] Input: imx6ul_tsc - set glitch threshold by dts property
Date: Tue, 23 Sep 2025 16:37:31 +0200
Message-ID: <20250923143746.2857292-1-dario.binacchi@amarulasolutions.com>
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

Changes in v6:
- Rename the deglitch property from touchscreen-glitch-threshold-ns to
  debounce-delay-us.

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
  dt-bindings: touchscreen: add debounce-delay-us property
  dt-bindings: touchscreen: fsl,imx6ul-tsc: support glitch thresold
  ARM: dts: imx6ull-engicam-microgea-bmm: set touchscreen glitch
    threshold
  Input: imx6ul_tsc - set glitch threshold by DTS property

Michael Trimarchi (1):
  Input: imx6ul_tsc - fix typo in register name

 .../input/touchscreen/fsl,imx6ul-tsc.yaml     |  14 ++
 .../input/touchscreen/touchscreen.yaml        |   4 +
 .../nxp/imx/imx6ull-engicam-microgea-bmm.dts  |   1 +
 drivers/input/touchscreen/imx6ul_tsc.c        | 121 +++++++++++-------
 4 files changed, 96 insertions(+), 44 deletions(-)

-- 
2.43.0

base-commit: f975f08c2e899ae2484407d7bba6bb7f8b6d9d40
branch: tsc_de_glitch

