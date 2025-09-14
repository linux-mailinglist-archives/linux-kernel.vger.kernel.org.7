Return-Path: <linux-kernel+bounces-815751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0CDB56AC5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD733B79AD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8B2D9EC5;
	Sun, 14 Sep 2025 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="aYG61GA9"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3801A9FB5
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757870179; cv=none; b=uP7jbfbYzuYfkNGEeszWUT1yy0j2lyC6ejHYACZttZ6faq0DPxFS5TBPUQrKrKhdvMXSMKahDu01DMtH7r6S9lSlZfGbRWnJ+ERtwKZzKdx4WTV55IssCGgYSu7kzA08gFBcDoyJp9P8w4KnhNw7bPxg0ON5kaTLf0FDUs8lar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757870179; c=relaxed/simple;
	bh=nftBCL6M74z8HHTn4ctuVWkq8xVvp0KWzD6g/yIisLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EosNxFzM6PICkLgkKLTtMdRDqHE2bKVpcFShBo90l6diPjGVuYrEl2qdyiF0ta0neFMxhSFVxdnS+28wZ4GJfCz1WVb6PLv08ZGuOJBitDlP6i2gXOmwrXuA78Cpk8x57l+bjTFIZyxWLHMI170aRnhkf8hPjzAqFRsQAcOueWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=aYG61GA9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-624fdf51b44so4116790a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757870176; x=1758474976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0BZMewSeCcTTiC1gUbhDF3UKkouTbS+YRMuO2NhSHUs=;
        b=aYG61GA9jSF96772jvHJL5h1+/73vwV5/VfeWiFpC+4jPSsJ0ZkiF2ixfJ5mVZA7BW
         iLF7BTmWLVLrhmpU/Odjakpcdw8nI17P3qpESWPWd9M+ICjMVholkokMLz3r9EWHfY8y
         HbKd6VCyCrDgG4QQ9DlYpsOUePoUbGvXoZ2dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757870176; x=1758474976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0BZMewSeCcTTiC1gUbhDF3UKkouTbS+YRMuO2NhSHUs=;
        b=eJThSBQd/mfh7VZqD72hcexRcN2zSJU9SK+7P2VsccZJj0//SifSN+P0pFkJWN5gQ4
         8/3LVvOE4O48SZGwa65e4ZVGpzWhPVOyWeVbtSY/0VqIi1jKid+8NZgnRaxFK52pEhGJ
         nX/oQcUQgm+fNkdZc2YzG6yRRS3TNg8xHu5SGakwnRqYrsTXoopwnXdhJZRUMQUnWqQ5
         VzH7PZvaJDMZyrEfFCXa7NT3cnaHnB30Y+in4InuhjT/VIMng7DvAeVQz/15Qw0nb8is
         6Vgt96hRe7s/zJYbt3IJ7QuIKm4kMEcgxMD8L80pnIqgISKSD5kxBKKUaGXFdYmgt+5A
         RRHA==
X-Gm-Message-State: AOJu0YzCpEQzqE+1uJVNVCcLJw42g17wdpskIeWPPvEqDLzruxZ/vDpz
	uXGKQggBnE6vYMETFFV8KkjCGbusMo7bC+6ZTGKE175sb7RGzfPrclDG3GlXQSBRm3hYkdJ+3p8
	o8Hdu
X-Gm-Gg: ASbGncsYo0Oyl3x1++sI/esjxZT44UlFyqyzQbE++iFMmsCBf58+u3/z5hrGLRvn1AE
	vkQ9Esp2Zq/LH2gVKoWl+sJ45GNrQDARwCTTVz2aq+LCkIa8OryeGZFs8DjrRX8K6RXhcHxrO9M
	UzC7z8+5PVWsZ+8Ws9ZBNjn363O2l+cezxrb0Q9Krixoe9TZP5R2rBfHGZ9YveS3yCj5LlSX7ro
	vqPcaKVZxu4SwUNITU28AANZkKpWUUFzl93sHCoH+WLJdDcFN03pY8VfUIQ/h2jPNhgHN042Cld
	8pU/v57o+5ucAkztJHNoECrPRjp7pMoNourgS8sKWxEsVHMERDzzS+AqJv63kWcbRi0KyBmD74Y
	M4TaON/YY/G+I7xoUpvyE0uEjT0cHiP6xBfqchJEmG9YunK9gSBP2SOR8JU/jHLLrmAd6bboFlj
	VR2AIT8GE/LwKF2uXPX3vcOX/vKkQq3V6KkT9Ij+Jf92I6RzccdiRIW04TDdlPx0YbQKCxNcMok
	CA=
X-Google-Smtp-Source: AGHT+IFNtfhow60LKf3kFnxnyjXUZ4Oc4lyoGvrn1vqt8LXeEwCDevETYH1mO/LwuhCnJBRIxMl4VA==
X-Received: by 2002:a17:907:1b08:b0:b04:5b0a:5850 with SMTP id a640c23a62f3a-b07c35fb999mr990822466b.40.1757870175496;
        Sun, 14 Sep 2025 10:16:15 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e76dsm776980466b.102.2025.09.14.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 10:16:14 -0700 (PDT)
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
Subject: [PATCH v2 0/6] Input: imx6ul_tsc - set glitch threshold by dts property
Date: Sun, 14 Sep 2025 19:15:57 +0200
Message-ID: <20250914171608.1050401-1-dario.binacchi@amarulasolutions.com>
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

 .../input/touchscreen/fsl,imx6ul-tsc.yaml     |  15 +++
 .../input/touchscreen/touchscreen.yaml        |   4 +
 .../nxp/imx/imx6ull-engicam-microgea-bmm.dts  |   1 +
 drivers/input/touchscreen/imx6ul_tsc.c        | 122 +++++++++++-------
 4 files changed, 98 insertions(+), 44 deletions(-)

-- 
2.43.0

base-commit: df86f912b45c20e236060321c85fe35437e9325d
branch: tsc_de_glitch

