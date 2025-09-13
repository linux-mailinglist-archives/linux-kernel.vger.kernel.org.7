Return-Path: <linux-kernel+bounces-815332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81897B562E8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 22:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E029177002
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 20:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341E225E824;
	Sat, 13 Sep 2025 20:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxCTGDvv"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5785259C92
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757794628; cv=none; b=FlmNsGs+44e1hxlqDzXOl5PPAZWOBcnQLX8ZavgUAAs6cw3UMYCtwM3eie5vKnRo0zyVDxxmEI8WlqiBGEZX9VKMRcD+38G25OQ3gdhEgFAnY+1Aq6TtOGzJ7fO5XR6rssMiun1DFx/LrcMga/TcbxV41N0f3wmks9WnIbaSXBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757794628; c=relaxed/simple;
	bh=FWdFpDZXgweIgfaXmSGMrKPTFYGwmCSWLoLB9qphSGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aN/19juLirRY5JajGkMbnX3DNjeSR06H6vpvMR1HSajbRtmHjry4/aAxXiQw6kSpSrAHJ8luDJg0EjMpaA/uQQfSOxH8tSXeB2ahc7S194pwY/brJNId0O32gZDcsJ4RR7WXgk5illxpVKXLvS+AVzS2cIxeS2QHfXUi/bdKHjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxCTGDvv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45de1084868so15593485e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 13:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757794625; x=1758399425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Koaj6pqpf5k3Jy2jPYnNq/imDVBkH5e1i3AFBAwM1v8=;
        b=JxCTGDvvJh5+cf1FVW3oQWiN2LsJOEtPGYJ5EsBoFS2r7kDzqe5Xfzjyj+fsnHrEJ1
         QUp7lXoDzayhmApFMRgU4za9/k4UNTY81NG84jcqDiGtFw7yZkON3NL2D6NQqMW1OBxM
         0UeKACHIzhFSTpLY6u3wKcr28sCVOQp2RTbgsCKRqddVLs+z7MAoisBq8ZtECxNkHDpp
         vL0+oJsyqQsza0UOjGF7bDc6brdvJBhyV4PZWMGtgyLklyJ2rcN0TMBh2UVZ11BE3ZOQ
         tAncBCWZsLuJvfXj+ZwSI2DttHnGX13ZT49jvTE5BvX/3fE1vcD1U1feu+qoZp73gwa8
         dibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757794625; x=1758399425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Koaj6pqpf5k3Jy2jPYnNq/imDVBkH5e1i3AFBAwM1v8=;
        b=SVSqpN/NGYpqr7sPuwOlOTxusc/p0t2Ehm17s3bXZjvfDPOeOv7Yp4fNimXQlgClcf
         gyYQ/6e62oqcwpA9gYbBeaXYASIlY1Xzrr0heRR89S+hcQxC/f2mZO+uo4SKoAmd9KXl
         LgaDoPF1VORFjtX+1GkhPjGLo5VmVMX1EacuiQFD21Smq+MQOYk4P82nJDZ7nLJoNIIg
         S+6zqVQVyctt5mgVJdiZ+0x2gZHdtE1u2HNpU6zT/kK+HNxuD7J3kONBcg3HBCZpH6ZP
         CSsFAsOSV3a0R0wC+fj+rnz+EHtjxudFKNzmqPqtAIxq0VwGO6eHSWaHhcg78nkWFXDp
         sHlg==
X-Forwarded-Encrypted: i=1; AJvYcCVjwqQvP23QJF6VknPJXA1Dof4TSiMHOKanTKFrHFL7jXyL3GkFdc/IMVe/2FvOuHrNs58eE1uIRYd/HiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE5cKzQGdT9u8/v2mXxFFZU4TXJN11ZMUJIAhDDp1ewSoVLd7P
	Jrni9KbTXYrvxl7y4OpV9mlJDKs8uqUvZbZlcELSbqkHo2/kZjHUGQmL
X-Gm-Gg: ASbGnctht3N9BNkahmT838hN+bkt5PUN8xrJlhz/t2rpZWXVUtBEqhPGGnwM0nQNmRy
	3XvACEeW/zpFjktz/+g/3dZ/YfzKUAAxm4I7WgLYte8YwlnlcVkwE+eSxLadtNOftoKxPGc113h
	9uFhQ1pF+NQQ6pVG7ImohfSMvaHBc1Poxgpu05320HUjgBnoB5RAXqVEpzHDOBEUPcNLO82A3R/
	6vBqnd19zLdMcV9iMdZzptoPZ0hsXsrsVGgjDHgxdBDB72NjG4MxoQmC/uIuFqHHqWXCsZLixSB
	zfn9Gu2mCLabfW8wp/aj64+tRZkRJXbCC/CCXIvHl+sjdS7yZqXcVrkS655MQtpmL6WiNQggd7a
	sjmnUo3qwEMe8KDCKO/G/CA==
X-Google-Smtp-Source: AGHT+IEXKa6xffHEzbijIqHJqGxOlxCQ+oBv/ZWdVFhhrgUOoImOvsVfpGK+TXJ+kkkvEkQl8EtTxA==
X-Received: by 2002:a05:6000:2408:b0:3b8:d360:336f with SMTP id ffacd0b85a97d-3e7658c1c6emr6975696f8f.28.1757794625150;
        Sat, 13 Sep 2025 13:17:05 -0700 (PDT)
Received: from localhost ([185.63.82.103])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e760786ceasm11628425f8f.16.2025.09.13.13.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:17:04 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liang Yang <liang.yang@amlogic.com>,
	Feng Chen <feng.chen@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>,
	linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: amlogic: Fix error checking on regmap_write call
Date: Sat, 13 Sep 2025 21:16:11 +0100
Message-ID: <20250913201612.1338217-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently a call to regmap_write is not being error checked because the
return checke is being performed on the variable ret and this variable
is not assigned the return value from the regmap_write call. Fix this
by adding in the missing assignment.

Fixes: 4670db6f32e9 ("spi: amlogic: add driver for Amlogic SPI Flash Controller")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/spi/spi-amlogic-spifc-a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spifc-a4.c b/drivers/spi/spi-amlogic-spifc-a4.c
index 4ca8e82fdc67..4338d00e56a6 100644
--- a/drivers/spi/spi-amlogic-spifc-a4.c
+++ b/drivers/spi/spi-amlogic-spifc-a4.c
@@ -420,7 +420,7 @@ static int aml_sfc_dma_buffer_setup(struct aml_sfc *sfc, void *databuf,
 		goto out_map_data;
 
 	cmd = CMD_DATA_ADDRH(sfc->daddr);
-	regmap_write(sfc->regmap_base, SFC_CMD, cmd);
+	ret = regmap_write(sfc->regmap_base, SFC_CMD, cmd);
 	if (ret)
 		goto out_map_data;
 
-- 
2.51.0


