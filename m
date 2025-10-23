Return-Path: <linux-kernel+bounces-866747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A07FC008D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D527359940
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADFB2FE597;
	Thu, 23 Oct 2025 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijc52sfu"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D802FE56F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216215; cv=none; b=czZ2w0A4I0LM6ufb4oe30KpNfvj/y9U3GQaascNWYZ3u04VGyaaIiEC5Aza1EcA1x6vrDHX+oau5EfNMGZeXc7UFiGWUFv/gd7uc/GZnHXzsgt/d4CfpOS4Nf09l16//mpdLIyN9kSHC9hkbooyv4fmeBXJgU6ocCibFdOahIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216215; c=relaxed/simple;
	bh=XZ0aa4iCUybd6QVov9sY+LCzyX4cdv1qdWS9ztcgdcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHx0BXtEjkNJO9vEfydQdIjB/2pN1dyAVML+39C5AWQKFCQW80RALiej71Mt4XPoVLX+0ZyqbQieOi1tkovVeDxaMBv458/w3EtuiY9C5heBBPhszQpvsI6fMDZ65AlvsqM2WDWYOG7HS83mfK+7rXpWMkf8aH1VkdmDj/zgf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijc52sfu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-26a0a694ea8so5067015ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761216212; x=1761821012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qYNWh7ObOQ58yx7yZwE/kCO34/ItQPE82ZLhZuHfPE=;
        b=ijc52sfurz9DvcCoSBvjQo4z14YVGiisIKM5ccSsXDT+GWY2d1ltLWtui074IiLOQV
         EebONfUrrXPJSo9genyPRxnxzBgZu5DPOeMyMirh+E0DDHTd8a+NNe3XqwH3FKVRXD2c
         SS9a/JQ5V9pcTrcOSGzNucde3/saMFRTp3UKBe+Amx+YTJZaF1F3ivDZLchNzihj1G6k
         ofVAFZgY3yQCplH19j/DuyEC4UoUGkn7eOf/hAQZoAtNlofGaINR3p76YmIkiVKLIkQB
         Z4tvX3VKs8wuZcdEl9hEBoxwB8rOr75wTdLqdY6VmOr1uFr/uIbvdhjitwyUwL+BHx3N
         v2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216212; x=1761821012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qYNWh7ObOQ58yx7yZwE/kCO34/ItQPE82ZLhZuHfPE=;
        b=FpKs32TFR8Zm5ZzpHytrgHI4QyaBzN4T5UEuGe5gW+UDO+JMPFjmLFe2N4agoJvAgu
         fhidSDZKDz+5A3Q48n4IJ7c8KIeX1dVnr4EbhwpJht+lMTSIO7MkMLrqMYtJOIff/4vE
         MRBAJORyUk0wCxswW3ToI4NPF8iSlBFv5RMcQRk3opt61xnMNLEFIEvdrc3xrn/ZxWH0
         URZEzwC1qIzs/b6zFOPgFu2J7JCpU45GzO8IQURItK2KdUmX5xc4y7Vmd7tKKP09Xlmd
         UwykXtGIC2wKPMpGXAO8hUxYEAnJcvJOMMJngGQmqVYQ0Glngt8Mi4bwMmzT+jHwMS3p
         uKgQ==
X-Gm-Message-State: AOJu0YwIla8Nl4kAn+2sd9VhuLfeXWFIDHRPux7YcQDU/1ZfXUpxC+eP
	+GmL1Jj4zRpHPssJdsyUbzR2LhYF3Ru8bfzFBPO5xJPqZr9waAAyKu++
X-Gm-Gg: ASbGnctALJ1iEZP1eMhBEWz6dtQFSzYE8KcZ/TOxWQK2zZPeXFYe3hmmyrQNFBYh0SH
	Bd5OlOIJl9/qn/SLMPzJYaM65gUgrSGIoM+ypsX199OBHwJXuLCxYPVrfOHc0jSjBwvb0ArsKMH
	JQJ2+apgUIF8eBUmwsYFs3+WyuNn5vzMWw6DCP3ksDjmxL1yCPlJTNgkbZ7wRMnk8fghBomO12P
	yF0sYfQQGEjr/RSiXVVnRAWCkD1jo6y47GUu6HXFBbREDl0VHKvHTO7pik5Kl6WswfoQoN1iG4Z
	5loqE5JL6LceP5Jxk2d+V2dBwnnI2SkniOr8Sb0aX1SX6I3jtzCeSBpA1xADT/8aN2p17ZurxC8
	c2I9yvWY7VMLqscSyi5ZIhz5qJ8mPRz0Ii0wFnUWTZ13nzg3LwkZTqYCoXVCz1shZRy+qe44+gc
	c5AfzTwxIL2CxabZsDNNI=
X-Google-Smtp-Source: AGHT+IH8b5u4HtoHpKR/2HVfpSINg790zeUEcpfE3gcodr+5+Gk0kA3xe0PaMdH6w5uN7f9EIubR3g==
X-Received: by 2002:a17:902:c942:b0:264:a34c:c6d with SMTP id d9443c01a7336-290ca121a65mr282957195ad.37.1761216211772;
        Thu, 23 Oct 2025 03:43:31 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:36b5:9454:6fa:e888])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddec426sm19240945ad.34.2025.10.23.03.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:43:31 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/2] serial: sh-sci: Sort include files alphabetically
Date: Thu, 23 Oct 2025 11:43:12 +0100
Message-ID: <20251023104313.210989-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023104313.210989-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251023104313.210989-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sort the include lines alphabetically, no impact on code behavior.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- New patch
---
 drivers/tty/serial/sh-sci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 62bb62b82cbe..125a56d47924 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -19,11 +19,11 @@
 
 #include <linux/clk.h>
 #include <linux/console.h>
-#include <linux/ctype.h>
 #include <linux/cpufreq.h>
+#include <linux/ctype.h>
 #include <linux/delay.h>
-#include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -32,8 +32,8 @@
 #include <linux/ktime.h>
 #include <linux/major.h>
 #include <linux/minmax.h>
-#include <linux/module.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -50,14 +50,14 @@
 #include <linux/tty_flip.h>
 
 #ifdef CONFIG_SUPERH
-#include <asm/sh_bios.h>
 #include <asm/platform_early.h>
+#include <asm/sh_bios.h>
 #endif
 
 #include "rsci.h"
 #include "serial_mctrl_gpio.h"
-#include "sh-sci.h"
 #include "sh-sci-common.h"
+#include "sh-sci.h"
 
 #define SCIx_IRQ_IS_MUXED(port)			\
 	((port)->irqs[SCIx_ERI_IRQ] ==	\
-- 
2.43.0


