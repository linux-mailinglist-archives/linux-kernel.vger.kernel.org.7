Return-Path: <linux-kernel+bounces-865134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D11BFC4CB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F60B581FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB4434C9B0;
	Wed, 22 Oct 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NUV8QiKp"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C934B19A
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140486; cv=none; b=k94qFfIIR8FJ8hfy0iIxTbOKcIYBz5/sVs8kHEKKWc75Mb4RMmevJjH8WrOcYnlQayWVJXmmmOqGabNJCfyahiDPM+ZRgyaO5nsHD3XaASD8Z0IIXVxCemT/w1+qP54oqEcdyxmgAwM15D2ue+oLBlfnOBWXqvJCbINW5wzK4JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140486; c=relaxed/simple;
	bh=Wl1fhQY1rGkK0sqqeQ919W8Y5zt1r+WQd1ilNvMu78k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHmT/IPCx/H9a2Jrtnjse3jvpLUoOQjA6sUqDYScYhNWkpxrprxiCcLpkB83TkN6hrHh66pZpo7/XvOEPKSlu6OCplwI68i6euIuLrqqtyO0+tx0HRDSOGpbHom5wGKg6mbWkrV9Dk3KU8I1Vt/Q4IxY3/+jyJj/6uATWJnipho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NUV8QiKp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so2341498f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761140483; x=1761745283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fka4GOWd2iYzDb7Bo8GvMcm+GI6H6Wo/3syX0K5IZL4=;
        b=NUV8QiKpOtbAQ0bzcabcLV6DlEW/38wt48oLA9hAY1ayRwRhQghzxaRVNXwyeNdON4
         gGLx6cTmuZ1d+L9RNRS0HkUdi78x8888kwH/z8TE//YB4q6zPVgpuz8k+ekS2gSYqDCg
         Gxch3osEbxX6KB3Nigq9fwSdyVR7fwE8x7QIw2fCw5h/VJJE9ni4Thw2Z85S2OttCFjB
         nm9fHC+4UB76B9ZVPBr6kizfNNu87E6fBZSyouEVeKAns/4qEwnaBA+SRFPPqaPQnA9u
         JTFLsxmqfk7T3LH64OGwg9gdszrV7lXtHzur56FtgSKSISEhHCffOWqGeI4liB34dtAO
         qg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140483; x=1761745283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fka4GOWd2iYzDb7Bo8GvMcm+GI6H6Wo/3syX0K5IZL4=;
        b=cOld/1Q6oTltU4KaIvqCbPZd5AkVlqZ9B/uJhzyOjGAYRBYec7JmYia8kNPhO6kCba
         k8noN2DSd99a+meZNg7nR5cLeRrBsVJyTb+gO7dZJv6xLQi69K+pAMTitylu05LGsBDX
         7EVAOVLQ8BxFvjZ1ainADcqlh7JQTq4W4nKzmzqULGnH3/Fknr+MB4SDzDfS1czgP3A0
         857omW3U96aDga4aXLCTW3S5Hv4/lwMSMnUKXzO4W53qMmE7b/5qkuAlAg/uog0uHWtF
         y3SmDNLa79g8qeu8aSb+27iXrpJEXJCyEVNvvdkrKhR0HcRJjBZRiP44hjOrVghBW6gZ
         IuJA==
X-Forwarded-Encrypted: i=1; AJvYcCWHzDGUZzE/Z3ga5jMDavDDTO+WgaF9ZtAun1UFXJNEm4SG8X1dPVonqV3X/wVaPDM7/i5tXJgm7T8WzHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg0apzdCBQVsZAC+M5+7UDt74kh++QBbp/3l/BlNsjpo3ZQ7TL
	5ue3iY7lrM1rHpsmnJMpSCh4fgaadg0kMmxhedPph3WsuirZZZbcOdiEwQUI4RhNYe8=
X-Gm-Gg: ASbGncsK/WKAva26d3acBuXtYuC3o/OvEmncdtvkfB7vz89ivcNz7YfLVMyV2raLwvq
	lKB5U/WickWwbDnMPnpF6HDiEqs5kKprfKKi8cewL37J4/K/QkAOXBbcRxnjEPEW6i1Fssw0sXo
	NANJUZOLXyJiWvg06yRscE0sFchIJAxIHe+SU21J6naDd00/IYHd4VSlSAK2cAigSqhjAUWFGNv
	zt0pyNvoUCZceVuVAHYvl14zuIaC96C9D3BDF6rIafDX1d6e7IhtNXufIHgttAsOCjMtUv3x2Jq
	NC6p5b/3U5gcCxrtBx0Jw5AtnhUHzvJdCGSBpY9DkaQpXCmCz3EgA07/5TEfKQGiga1J/Zl17F0
	cND1+ufKy31uZpvqrAjVPYZ7DqIxkVp91VNOxQxTteOhhmjCH/RuySSfCLZEp1n1exJ2Ab7k/pG
	91UPNzzg==
X-Google-Smtp-Source: AGHT+IFtGxupvrrz0hEyPkQmR4lio3If/UgF1vzWJPCwH83IGY2c2Ss0pfjXFwLXK63D78jhlQy8rA==
X-Received: by 2002:a05:6000:2884:b0:428:3f70:4b3 with SMTP id ffacd0b85a97d-4283f7007b9mr10981225f8f.59.1761140483451;
        Wed, 22 Oct 2025 06:41:23 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm24863066f8f.36.2025.10.22.06.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:41:21 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:41:05 +0200
Subject: [PATCH v2 6/9] reset: order includes alphabetically in
 reset/core.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-reset-gpios-swnodes-v2-6-69088530291b@linaro.org>
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
In-Reply-To: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=5npitvf0JoMP1eHJw/QnxV2d5U00sUQL86r2ZKFzddU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+N7zY2qos47RUa57cJk9XHOVpyhKy3o6I02yJ
 GbC3D581tGJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPje8wAKCRARpy6gFHHX
 cjIpEACPoNgcXFMZIb0kvxXvdKY4SoRGAPldi97mlODq1eEuXwycrzwrttSfai2AmUL6CjWDRSp
 GV/GEG7ibAvQUl6c8cnILE2zS12LA3ooGFhIBherTTe1Acx+JDnsMCJHNxdzFUWiWfxYAkFee4G
 qo0gJLv7iv5ezTuoYNyXlh0/PeKa6uqmmj1rLHmS+a9ZXyW/tjaNPZMmEY6SpeXjIWfxgw/dX75
 05ubxROI0yIsMjUp1O/BbYzFux/CPvLEXzfSdlxiEK85+Fw4xtsKVNfYxi3QBBs5lvGkg/OCHbh
 YXbjorgDSp37ROMyPDboqwj1JlgzYIfOZjBLTZusE9ZCp6D91Wn8K2kBKbI/IRVxev1wAjDC+xQ
 nKSDwl7Vf+MjEbRSu/zoFonzq24CcQrEbzfJUmoRD4jCVA+pgMnYzjhzFrvaBsBh1DeK7qTvfcD
 sJl1+zluX8rWMQDaYhbcD+s6qbaUxq0bZPjRbUEl8GitTlAHWkeDovPFaTXa7U/qTJ+L79WJqc9
 FdD/Ix2bizs3AnKLJbkrC600gvBil5Dosh7t7/mb//FE5oHJRACQ0HQgXPfkFAmSbsr9G8B/gE1
 cwRLIb2p7JARNhsuBjhyl8nrYNxXj4JtL4FBztjKV8OkT/sP6iKVidJtK71KEFkSu3m8+rINnCD
 m2RKYnOkKVSxo2Q==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability and easier maintenance order the includes
alphabetically.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/reset/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 22f67fc77ae531c6efba3ce92cc73a2d57397762..5a696e2dbcc224a633e2b321da53b7bc699cb5f3 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -4,19 +4,20 @@
  *
  * Copyright 2013 Philipp Zabel, Pengutronix
  */
+
+#include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/kref.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/idr.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/reset-controller.h>

-- 
2.48.1


