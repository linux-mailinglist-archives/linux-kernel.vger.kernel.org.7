Return-Path: <linux-kernel+bounces-876295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BE1C1B1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C41A5C3AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AFE283682;
	Wed, 29 Oct 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjrUJgpt"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA45526FDAC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746164; cv=none; b=TGF0VCJw6Wc2fvaRBq6hz2NN+fAGEOTTGC8JxqtlpB7S5Io47dAafoJh4tmxIKed5nTE2MaeR1G1XdQlqoxX+P2hn9RahJKQu5oUmI10J2bXsscxWbE9/3VgPwMsF6CAMgixtDk+wNvd6YCJRd5dpj3z5gNTg9/uzdWaHOHPv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746164; c=relaxed/simple;
	bh=j0EXgrYnvVA59AWsBuPviuInGMrdX8MUdYFnXuN3nj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnvwHvFI/iis75FD6vfwfWSLqYz4upw/uL0ECsVpHfHPI9jmZ5brc+725RhD3ppCzlyEbZLJP+UOuOtvlP4ivG5VF7wHJPHQXINxiWh7IL+EVc64hE3KoU0H6ms64XdlMz622bAy6qDYhCMM3wCVzt9dMftpec3fZwh+Gu22BoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjrUJgpt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b704db3686cso56063066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 06:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761746161; x=1762350961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQ5uBVedfr9KMSyQo0sT0JGcllMUFdDYdUnW2PHKUXc=;
        b=kjrUJgptY7kUXvzbzgSuOIk3nRcChEkdH9EfIq2si4HVohLV9EHM2pgC46i53SAvHy
         OwZNgmnU1SoGylK5ZhcnUj92AVbTtOdThtWwEsrxAxwMwhudrBxYCZ+zARILVq02e3K+
         NNbbsKOm7GgHTAz9gGyQ3Yjo6IbuSbg5BPqmzOlaUqRjJDhxJKEVIytlly8S3WW/fAvs
         H4aIkky0fsvLtBgu92tUcxI0aw063Ns8kqv3u43eZ9phlonJ7SYdpPhMRhjA9KUSyoeh
         C0HhmFqLnYdmBZL5V+yTLA9QohOxM4jds0Jubwoe+nVLi4Hz0T16zh/L9lSkBVGHJPRc
         M3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761746161; x=1762350961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQ5uBVedfr9KMSyQo0sT0JGcllMUFdDYdUnW2PHKUXc=;
        b=k2JbhupVQGs2Wzg50JVbhl2IrRN05N5dv7+bKbW/i/Jzw1fnFp/oWjk1SJMjO+6Q6X
         c5mpqDjiBEl8JbjC/vOuF86JTIiEqRoWJ2a5T+FULToaqviT8ysUnhlgQSTdYbsCq9Hk
         JplGfJ0NRVt6+9143Vfr6rXQcAzb04WmSHIQ70kX5u/lSaAc4X/CyucEPnE79eMcrygf
         w1APzcuONjIm/ZmVdWsGE1fi3ifUUa02f4Nsl6DBLWNaA991OXMsCoWUOF5D/kWxEsrm
         xXbfzJfsnsvaYXuVAAVU0QJqPRaQKURZEJv5jd+NPtUb2xMkhra2JHKHiOV2UfNzejyV
         Ta5A==
X-Forwarded-Encrypted: i=1; AJvYcCUoyc24W8DaLgBNiyeRPs4MWIbVdaL/0BSwgm5R2VrRPd4Mwo858/iuw7MOPvSEf2qEAqYhcV7/PlY/3V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZxrWWMmuqOyN5EIU0xGI43tqioe2EkfDFzgtbEM+yd3UPNIHn
	Wn18gy875uRW9hWlRfBxEkr59oZ5uZGzd0ELqRiotFSACi1zkrOBUj+N
X-Gm-Gg: ASbGnct+KVXfdAmsX2lyzbs6QVgrUwQKxrS5H1f/D7xWLJP9QmbPzIolTQhVnjrzofC
	atnKJLRLpt2Z9IGOgxUxCL06G8+yOyelFcUkM6Jd0haGaiIqvaInKFUPErr1UFH8ODjlPMOFshj
	c8XYhY05zgkawwD7U/HX5+pfZSJ0H45Dp/r/Y6UlCkzP63M+3r+dTlx+SyZm+ujYER0VjHHC/S8
	NCnYVaYeX+8cVakziuDRFvgxX8jLduNMI0ebOXZe8aD7ZR6c62KYe2yAPuPZEvLZSv1zjp1vzGz
	nvGABw7aXDHPTTD4me+OhdBXxp9IvU4SCJwktregEDCJizpTBAJMXihH3X7iyiH8c1y8KjiY5om
	uEuP/o4OzWH4Q68RL9I46sCSDhpxqoG+GFUTqOJx3PVyyYj1iDyXN9uKzaQR6DzlCMgUYchc7yb
	0JuCKCq24OWjQ5Yxfx1U56LfFvF1bo8g==
X-Google-Smtp-Source: AGHT+IHrghZaQi+o1U9HBM80X1LpTX8WL6sxC8J/8ai0EXsL/1XFPVew5l5qwKEGLRSKZrM0eDMeIw==
X-Received: by 2002:a17:907:96ab:b0:b6d:c44a:b698 with SMTP id a640c23a62f3a-b703d4aeeecmr296884866b.40.1761746161026;
        Wed, 29 Oct 2025 06:56:01 -0700 (PDT)
Received: from SMW024614.wbi.nxp.com ([128.77.115.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8534d99dsm1444960766b.21.2025.10.29.06.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:56:00 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v3 1/8] reset: imx8mp-audiomix: Fix bad mask values
Date: Wed, 29 Oct 2025 06:52:22 -0700
Message-ID: <20251029135229.890-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
References: <20251029135229.890-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

As per the i.MX8MP TRM, section 14.2 "AUDIO_BLK_CTRL", table 14.2.3.1.1
"memory map", the definition of the EARC control register shows that the
EARC controller software reset is controlled via bit 0, while the EARC PHY
software reset is controlled via bit 1.

This means that the current definitions of IMX8MP_AUDIOMIX_EARC_RESET_MASK
and IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK are wrong since their values would
imply that the EARC controller software reset is controlled via bit 1 and
the EARC PHY software reset is controlled via bit 2. Fix them.

Fixes: a83bc87cd30a ("reset: imx8mp-audiomix: Prepare the code for more reset bits")
Cc: stable@vger.kernel.org
Reviewed-by: Shengjiu Wang <shengjiu.wang@gmail.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index 6b357adfe646..eceb37ff5dc5 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -14,8 +14,8 @@
 #include <linux/reset-controller.h>
 
 #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
-#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(1)
-#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(2)
+#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(0)
+#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(1)
 
 #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
 #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK	BIT(5)
-- 
2.43.0


