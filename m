Return-Path: <linux-kernel+bounces-738406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD4DB0B7F5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C201897320
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171E21D8E01;
	Sun, 20 Jul 2025 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMu/NQuR"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4C51F5F6
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753040320; cv=none; b=UXC8xFUQ1zyJZzsTcwa9JKTTMfcmICoW6kCbU6uPZpFA8yXlYrD636+6xylkOl7OkqOFmGaUtHbqbk+FSZCIdWcrHbfdverKz3Zdp7E+2M/nqaGJSnTc77Qky7ddFx14Dae0XVBtLYDVJfjaCxsjFuxDCXG1ocqNL19ut3wHa/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753040320; c=relaxed/simple;
	bh=cPk3QUDJyicVsrvKeLaXhnNw3hfUKvYreFrFy6p94ao=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c7o7Kx20lpKlCmCzIkRecKg+QZLgHjgrbH4ZtT31SLV6WyBqovkWlvk91r4g7qLTxvLMEZFo3rQTB9S4A82/mKqTaazbpUFZqbw0pE0UyiHTvfkaT0ztI1suie8lgJ5atz2mcVSvlp4Plr/Zf6zUkzffJ96QFevOBPcF3MXfk14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMu/NQuR; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-73e65c09828so2078126a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753040318; x=1753645118; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=STF4EnqDyXKLMLeHRmPBDx0M84uZz7Y9ipuUY9uInvk=;
        b=mMu/NQuR0B6rRCqOBvW0hhQAicVcTUTSi2MHh7PVP6x5Tfbj4lTjx0O8KU6vXuW9NL
         P558OLDpFxDj7Lqsypv1AeOBL6LLx5idg2C+RSZKCxAllx0iXzsw/wKdl/N5R1tGBhaI
         7SX55Xid74pMpn6IqnRhqxeQXqdaxPYiTCdbrRG8pN3JacNGDMw+qxKS/EDwI0pHxynY
         OQIXfrbV54iLzaqtLeAgUELgfjYXd10kgmH1MmalvA56PRonLmMO85M8yVda0ZIFGqHr
         GIr6/9hBic3NbeYWNU3iqOhpkQPYG7lVYL4UhcSt5Q0LbtvQI/MSqCKaxnm00IFEL6/l
         +Axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753040318; x=1753645118;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STF4EnqDyXKLMLeHRmPBDx0M84uZz7Y9ipuUY9uInvk=;
        b=PnuYhY2EHaMP7gNsjNDBx0qeKfzOliEPngSFVNQYdkW4+mwEQRiWXKWRx1TVy4vYUz
         QXIefsa/2AX8xh9ekeNOHPXz1k/cMqbOA5f8vNM5WP/hWeaSi4bg6KmPymfPfOnGandZ
         iWWwEYJ3mkmu2cOvtJKOf9GMCZDqwgac4BKbpqYI8TJ3m1De3QNU9FGWrQ68+xWOKbR5
         aPl+WEp9jkpV4aYyAr2T8e1j+c0Hy6sv8m3vWLajZAf+dy/RldCSfJ7gUPV64onSmp9R
         DltquCOSa3UFfcC8rytQSF60im+Wd+tbYnghSp2oAHWazKE1CBkiXAdX4BybVRF81Q/7
         PHVw==
X-Forwarded-Encrypted: i=1; AJvYcCWJyNO+zdaIhmd0YlEIjBr3J1YP8d/3oP73PrpN4ZvPpSVX41auqh3VUly59teqJgITBoAvYsrsgA7XvM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZeoBpiu77dz/TCVzFsBIYVK+LTpqtKtuECWRqu7duttCxB2zN
	4nOfeWSe4YIYsIjN+pX4fB5FnqCpr4blP7ogCQ7Jm7lsurAmyD3msA/eDROhkbKMooM=
X-Gm-Gg: ASbGncvreTNKwoQHbsuRNt6WzFFLRI69wIP6Yfs7k0y1FyCaNUCgrp6XJKey8HBT0P1
	jOysQMaChkq4VNuCXGuPrk16ylvpQL0MEoLzq8671/g/4RtEGGS3xYbu4mN84vMSRjnc0LBjl/F
	3TXa0NTnYqwzLiFk3CMsY4T+ts9G4mZ2aJC5AtjJ2XfFjWcdAkkcTXwXv3HVWSLlOHg4fmrWXUd
	JXeqCpJRCwuT/8jA9MScU3P/SRJDAFRFxhrKCFPd4vWxFGzFlVUJvH0BPyC5Kg5KlTUZ9D5o1Fl
	uolFd5yI7CQ9BftmBO4a8/FAWJPRhzQs8fGSURfyENWPidM9zaHdroU/uVoSq10Uco67cddTQEf
	a90dtzyTDn4VOtdNtMP3gQw==
X-Google-Smtp-Source: AGHT+IFkKgtB3ObGVLZWp4E0IcFIPQvja+e9izOMOGhmXfiPr6edCos/deJ042mUxYWb2yIkng7kUw==
X-Received: by 2002:a05:6830:8313:b0:72b:9316:d596 with SMTP id 46e09a7af769-73e751b5161mr8602757a34.3.1753040317899;
        Sun, 20 Jul 2025 12:38:37 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-615bcc8c2dbsm1341831eaf.20.2025.07.20.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 12:38:36 -0700 (PDT)
Date: Sun, 20 Jul 2025 14:38:28 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Michal Simek <michal.simek@amd.com>
Cc: arm-scmi@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH RFC v2 0/7] pinctrl-scmi: Add GPIO support
Message-ID: <cover.1753039612.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is version 2 of the RFC.  The main reason I'm sending this is because
there was a bug in the first version where it didn't calculate the offset
correctly so pins and groups weren't linked correctly.

I've also fixed a few style issues that people pointed out.

These patches are basically as ready as they can be.  The remaining thing
is to figure out the format to describe it in the device tree.  Actually
that's probably already done, somewhat because people are already using
SCMI pinctrl?

AKASHI Takahiro (1):
  pinctrl: introduce pinctrl_gpio_get_config()

Dan Carpenter (6):
  firmware: arm_scmi: move boiler plate code into the get info functions
  firmware: arm_scmi: add is_gpio() function
  pinctrl-scmi: add PIN_CONFIG_INPUT_VALUE
  pinctrl: Delete PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS support
  pinctrl-scmi: Add GPIO support
  pinctrl-scmi: remove unused struct member

 drivers/firmware/arm_scmi/pinctrl.c     | 142 +++++++++-------
 drivers/pinctrl/core.c                  |  31 ++++
 drivers/pinctrl/pinctrl-scmi.c          | 213 +++++++++++++++++++++++-
 include/linux/pinctrl/consumer.h        |   9 +
 include/linux/pinctrl/pinconf-generic.h |   3 +
 include/linux/scmi_protocol.h           |   2 +
 6 files changed, 331 insertions(+), 69 deletions(-)

-- 
2.47.2


