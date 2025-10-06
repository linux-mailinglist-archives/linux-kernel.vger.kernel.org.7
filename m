Return-Path: <linux-kernel+bounces-842677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8A6BBD462
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 09:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29EF24EAF94
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 07:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7C2258EC1;
	Mon,  6 Oct 2025 07:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUThJG9I"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F0D19D08F
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759737001; cv=none; b=iAybaDXEChPlT4L0xtOgDBxKordCtNV2Tf6oJMHk0cYH+o1rwB2C+gcSFq5/b/CQYr/DOp+C9yLCC/adKb+agR+1LXH3IN0aMj6uIi+k0UDGHcYCSj3f59JCJzgZg2PvLJ7jQXc1//TwPs9gX7l2+h23CPcCl1adxNuFtPTZT9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759737001; c=relaxed/simple;
	bh=pXS5dbkO/H2Yr4ZRPX6HKaCB2AX7eTL3ZS9U7ZkbG2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YTqrNbaPsATIaeHxrRC068iv5rK9ruilfzfL8x2wFRK1Hvai5J9RRI0sjFAnge0W8Rqji42YG3wDuJOv031DuwxZNKsBIxPorBapFHCwOV7En72CAyssLi3oUmjAceDbpRaKLSyccVpMlJa6gca/dSlL0jztpgTBPkjkrvnx23o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUThJG9I; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-58d29830058so3853892e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 00:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759736998; x=1760341798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kx4mAPmpKwCaHSWBKeBovoTZO7ReFcGeFzDJfyhWBSA=;
        b=OUThJG9Iy0KTuqEOJiX/yvNullwO/rsK3i4d1KPAYXUOCkxbAFFCeZzWm1wP4XwJ6m
         Lo0TUdfddDHnOL6OrhoPeHadghklfp8eBocey03pwt+XIcyJNH0DEITstbfA3rquoeEo
         e5IkGYTnlQ8WLIA/031Rvy3+f2+bXdVEt94AzGBctg5NBajLcTlCIZUDcobketmR5p+5
         0oFdIvccsbffvnQxV23+mGT9xhUSM3DOkRf73LwP4Ga+pbhhoD3GKErEHzLKx1/iqqbd
         vz7GQJfPdeKxdQ7qjn9mQLu3JoV5u9fEu9s3/SN/LsNWtmzXJLyolFpv+Vh0Nfwf0zf2
         X1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759736998; x=1760341798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kx4mAPmpKwCaHSWBKeBovoTZO7ReFcGeFzDJfyhWBSA=;
        b=rGaTP2KQh6HTfIuw50R6xgYTftxRIuiR4eeSPtZxJ64RXT1spnJPJ/Mc2M6L20gYXc
         iXqhcoNUjAtD6I3TQjEZNZCIyrEUm8TiNP9AUWE2kJZIp08guu1MOPQfJTpqMr17WGF8
         44IPZwhD+2rbzMisQXjIq4EIwQNGpGOmN0cMQvbRw0QtkQ4sHAG7WKMb06J840tH/Poa
         WZU8wBhw/5h/7n/114YHb1S2S4mwpi/MMDHZRmKf2cdYYGtuDOa41H7KGOUuKpFPlVMy
         FSrlmGzLAu85fcWXTe0PzcjN5kof7SeKG+o14oIAwf5ledYUqJo5z6DFzZ8o717u0wwO
         0EEA==
X-Forwarded-Encrypted: i=1; AJvYcCWCQv4dzXGlSuOZdNdTCnRLJ+3Ezkoxee7X466d3CRwXXNGlYCmYN4qTka3o8CHAD9iyLb/twPpyRBAt0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqsaXZg2MzTDCW77t116z+6hjv4yO6YieWTLstp7IQLsnWSfSK
	FlS0X8hFNgjb9r85dOPJRfyhhRmkmyhH0evtF0rsROhOCctf3d6/PjLf
X-Gm-Gg: ASbGnctnTrAP63fpv62A17gNagWoctIj83kZCDmw+uDEJh6FPbAZgEMPjPa7SjwLntL
	xGRDKv+aco7Vv9ym+nZ2ImyCMR4BO1mNKmJQny33i1jJlZ94w1S7PVLEMWyxzWstHlxhwsMhuPL
	fB82rW0Xgr1OBfGSwdZYOBxbkV0xEfbCRgPdfjwSXWfMzbFNCJmTbNfg0XmxKl7BDXfYWykEcuk
	WYDBqfQNPHkB+ArNkTLkxg4mhFg9/GPvUUeKjEMA0wMMhubit/QPSCAzaWlFrckPNy8sca2neq9
	yDSY6TtaVWU+OvCkEhsNdw2ST4WQnOm89O/YM8pASA/KtaNKo7uhe/XHnG+WKcIlQvrBkfp0lXl
	3NJu/MbQxbFmlaWWY9Q7a1PiJtUisuJ11t/E0bYu2qLKyJS1V6RijIBFTJd8dPMkCfdoiP6Rddx
	YVwpMRdN2mBHhYYKlP0gdnC5/tBP8=
X-Google-Smtp-Source: AGHT+IFi0Cs5BLY65bmuTIfA6LXsAl2lVAty1X8RjOlQSSXeuqxgWf6f4+HInY5D/ePmJSblqTZL/w==
X-Received: by 2002:a05:6512:138a:b0:57e:f60:2327 with SMTP id 2adb3069b0e04-58cbc96084fmr3386105e87.49.1759736997816;
        Mon, 06 Oct 2025 00:49:57 -0700 (PDT)
Received: from wpc.yadro.com (host-95-152-52-178.dsl.sura.ru. [95.152.52.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d21csm4817962e87.86.2025.10.06.00.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 00:49:57 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com,
	Linus Walleij <linus.walleij@linaro.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] pinctrl: mcp23s08: Reset all output latches to default at probe
Date: Mon,  6 Oct 2025 10:49:29 +0300
Message-ID: <20251006074934.27180-1-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Maksim Kiselev" <bigunclemax@gmail.com>

It appears that resetting only the direction register is not sufficient,
it's also necessary to reset the OLAT register to its default values.

Otherwise, the following situation can occur:

If a pin was configured as OUT=1 before driver probe(Ex: IODIR=1,IOLAT=1),
then after loading the MCP driver, the cache will be populated from
reg_defaults with IOLAT=0 (while the actual value in the chip is 1).
A subsequent setting OUT=0 will fail because
mcp_update_bits(mcp, MCP_OLAT, ...) calls regmap_update_bits(),
which will check that the value to be set (0) matches the cached value (0)
and thus skip writing actual value to the MCP chip.

To avoid this, the OLAT register must be explicitly reset at probe.

Fixes: 3ede3f8b4b4b ("pinctrl: mcp23s08: Reset all pins to input at probe")
Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index 78ff7930649d..23af441aa468 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -622,6 +622,11 @@ int mcp23s08_probe_one(struct mcp23s08 *mcp, struct device *dev,
 	if (ret < 0)
 		return ret;
 
+	/* Also reset all out latches to default values */
+	ret = mcp_write(mcp, MCP_OLAT, 0x0);
+	if (ret < 0)
+		return ret;
+
 	/* verify MCP_IOCON.SEQOP = 0, so sequential reads work,
 	 * and MCP_IOCON.HAEN = 1, so we work with all chips.
 	 */
-- 
2.48.1


