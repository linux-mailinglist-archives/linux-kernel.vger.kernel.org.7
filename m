Return-Path: <linux-kernel+bounces-817167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A765B57EB8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA2D167FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9EB31CA6B;
	Mon, 15 Sep 2025 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9cpByho"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17C731B806
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946014; cv=none; b=IKE0vq8lOD3uFeeYsjGxZm/F7IWDK6RDhKMWfgCa1DjNmhMDIWZQFxYoPJl1dQwUHi7KkKNo1mGRw+E8iKfqufu59LttyfMo2K/Obm8dca+ZW/y0YAwXTRMyGvZiUzQkTyiTobz0ftxGrhOgFz7DxSweH59S/Ofb4Gw/KQ3DZs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946014; c=relaxed/simple;
	bh=5uF2i1fMfFFk57weo06ZCL9ZwMoWY3wP4AjoMRcCSok=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s+rdBtHaKpHwV0eheWwFnkaTOlxSq2TNeP+UyjWLpce9z+iEb+deWY8UaKauyQ6dE9ekkq8lxak3DclG55WkR+ha4fgdj57IVFjm2Ue9N3I1JCeGOuK9LkTRE5Jw4Y7yiV846f8O8BIpr1/GfmuAJd1ar5ToAs+01xhOIiWba3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9cpByho; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso3436774f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757946010; x=1758550810; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zz7W2fHAKP9RNn810rrDm+4wFWDgNdWgturEviUI9n4=;
        b=m9cpByhopjrv4OHjUI0MPSN0QxEhocyBYnzGVX/k6n3wbL1jw8RFFrPZ2ScHzEXIi9
         2fQQPZKaRNqU/Yh6ZEL8M+IrYQSQHt1WYOCzIqZCBBEqp2ezgTt0+TJ1mCkgp2cUO9TF
         0jkn1nxsKqC5Yq9iOPLxc9fQXOLsCC2IYAPoefCqYFQzurG6jFOQ3z4tXYsuwoDjGTU7
         VZrRsZ7O/Rsb/w5Gxy2P6l+h8FPbwpKZjnWMFP5+Hx0Xw0eYzMXPAfXvM+8VqNERGXz2
         Gn4NlSuiYoa5TAGWcbYL4NrBqZWpDb7syN9iDm503/v9EYMlz64DSyKEt5+cexe+y0pU
         6uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757946010; x=1758550810;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zz7W2fHAKP9RNn810rrDm+4wFWDgNdWgturEviUI9n4=;
        b=PGxxV8ZOV6cC5S0Gd2SbRHZukVTzs02kR9q8rc07mfu4WeyHPWBSf3/P7TWDDe75es
         6cGWYYRAni7B9X+b8l3fKulmHcCb/XXbu95BQS1jUL2p/ESGWT/bK1IqUWGVq+6ojleK
         h2SgVPD2+EGyvJQ68ziA4yAdzOR/+eCwes2OIK/UNwX6bm59lxJzjBcQRi/XT/jiKTrN
         oOmN7NfuVcYZfq8EM9Op2oI/9g9g1n374cGeS2BKDwOTEt99OhUbr87uVZY9CujG+bc/
         kLUsEc8rz8ZVfB8Uflj6Ae7m1M8AYn6zNh9nvXBqQ4H4X8sQPRqz6cxQmaqlmLNtafJT
         E2xA==
X-Forwarded-Encrypted: i=1; AJvYcCX6IIi3VHBYCZmoL7hswyQPaL69oMOzhgzcGYBYw7BsdD6WK8+bZkWQUQhgWKsDVKaQK26uM9hVJ/vUvK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2WfKenv6MHWdqG9scelb41yF1KsKzNf5v/VfQV+uxMnM62eRK
	DBVshwJFOfKCQKRhBEIdYQRHudiLv+NdP+Q0diOKfrZIr2pmOv8sAVvZyv+fG4pglz8=
X-Gm-Gg: ASbGnct5Gi2PF2MULxhCht+OoIgwJQ+7d2yaODfVAwF4m7ejIMFXJNrsPPuFd9jFgcd
	C3k/sTYqL1GuLbbxYDAAOYe9JB9XzMUuejq4kHZoadu0hY4XfyTwnlLn7WoNt4uNIS87HLTo5x7
	kf+7fuqRgQko1nBzn88nXUyboEdHniC3eprmBsyIn54pMKGtU0tRPHw/ACWw7X06Q78ZuxtF2CC
	65tUoUkPh7sIbRemc3McugmCk5Ns1AyUX1Q/vJCAy3/FcQCb09/A37/U7pCNXfKTJDw+0e19sTM
	jS1bE5/nhg2pLxGVPM+ej/gEchUEbfzKemFzvM4jcmBwscNELg8W8+c5TDPIvWTX2WKPO13Wn3s
	l3waPB4uCW/3QbAWT+UD96SMRwiAqx/xDYME=
X-Google-Smtp-Source: AGHT+IFSmQbTHF0YuHd9ONdZ3tdtKlFavLsHSPy1D//fCR+da9/Whp3rM1z+WJgImZ6na8pnBA1Zvw==
X-Received: by 2002:a05:6000:4006:b0:3eb:bbd9:9c08 with SMTP id ffacd0b85a97d-3ebbbd9a3bbmr1863216f8f.46.1757946010074;
        Mon, 15 Sep 2025 07:20:10 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:41:eee1:5042:e713:2e9a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm11801928f8f.27.2025.09.15.07.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:20:09 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH v5 0/2] Input: add Himax HX852x(ES) touchscreen driver
Date: Mon, 15 Sep 2025 16:19:55 +0200
Message-Id: <20250915-hx852x-v5-0-b938182f1056@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIwgyGgC/2XOTQ7CIBCG4asY1mKYGSjgynsYF/2ZWhLTGmqaG
 tO7S2usGpcf4XnhIXqOgXux3zxE5CH0oWvTMNuNKJu8PbMMVdoCFZJykMlmdAZHSdqrCq0lQhT
 p8jVyHcYldDyl3YT+1sX70h1gPn0lPNA7MYBU0pfARV0byrg4nDk23aXatXwTc2TAL0hqhZhga
 RyC17ZANP+QVggK9QopwRxc+jrlDtj/Q/2GGhR8XtQJWs5yVGCtJ/cLp2l6AkC8BUVJAQAA
X-Change-ID: 20230816-hx852x-3490d2773322
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 Jeff LaBundy <jeff@labundy.com>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Add DT schema and driver for the Himax HX852x(ES) touch panel
controller, with support for multi-touch and capacitive touch keys.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v5:
- Annual resend, any feedback would be much appreciated!
- There were no replies last year and the initial submission was 2 years ago.
- No changes, just rebased to latest input/next.
- Link to v4: https://lore.kernel.org/r/20241010-hx852x-v4-0-7e6a20177938@gerhold.net

Changes in v4:
- Fix asm/unaligned.h -> linux/unaligned.h include renamed in
  commit 5f60d5f6bbc1 ("move asm/unaligned.h to linux/unaligned.h")
- Slightly increase delay after reset to fix init issues on some devices
- Link to v3: https://lore.kernel.org/r/20231024-hx852x-v3-0-a1890d3a81e9@gerhold.net

Changes in v3:
- Fix device_property_count_u32() error handling (Jeff)
- Properly handle errors in hx852x_suspend (Jeff)
- Simplify error handling in hx852x_read_config() (Jeff)
- Close i2c_msg array with trailing comma (Jeff)
- Clean up error handling in hx852x_power_off()
- Link to v2: https://lore.kernel.org/r/20230930-hx852x-v2-0-c5821947b225@gerhold.net

Changes in v2:
- dt-bindings: Swap required:/additionalProperties: (Krzysztof)
- Use dev_err_ratelimited() for error in IRQ thread (Christophe)
- Use dev_err_probe() consistently (Christophe)
- Improve error handling of hx852x_power_off()/hx852x_stop() (Jeff)
- Add linux/of.h and linux/mod_devicetable.h include (Jeff)
- Fix %d -> %u in some format strings (Jeff)
- Fix other small comments from Jeff
- Link to v1: https://lore.kernel.org/r/20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net

---
Stephan Gerhold (2):
      dt-bindings: input: touchscreen: document Himax HX852x(ES)
      Input: add Himax HX852x(ES) touchscreen driver

 .../bindings/input/touchscreen/himax,hx852es.yaml  |  81 ++++
 MAINTAINERS                                        |   7 +
 drivers/input/touchscreen/Kconfig                  |  10 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/himax_hx852x.c           | 500 +++++++++++++++++++++
 5 files changed, 599 insertions(+)
---
base-commit: d5ad57fc428c1e44335d25c822eb89645f425f32
change-id: 20230816-hx852x-3490d2773322

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


