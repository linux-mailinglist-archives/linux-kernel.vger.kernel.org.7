Return-Path: <linux-kernel+bounces-873110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E294EC1321F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3773ADAC8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B129C35A;
	Tue, 28 Oct 2025 06:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUN2/fHi"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4071286430
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632725; cv=none; b=UIIHUimJJwy7agkk6ntWGGORqcUqYYlEoKA6DyHRZaM//WzX5Oct9F0m/abOsii/p/iu4WGMlRTVE7rlUvuIypGxCwXPnBZMTt8jxviYtD59BTodfckKDo0gBL8hPZlnkGw1ioJ+dv8cT+y2oZ1Lu5N/YXT283Tc6myOcVi7CAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632725; c=relaxed/simple;
	bh=6yCWrSKh0Tfap3i52NTXvTHCY9J1YImnfu2v1lxtHks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GYOO1wBHvEL011Cp9MmwDUpt9ET0H0h1pygJ3Q6TVzftJoD+EETGtvOpF7gE+w35YeJyMvaJ+rlltN0FYqOIM/SVPWHXj46s7DJcsK6CtS0WHqfDodewuAJEi7C0oz8wxROtHnHKt6P8Yu82FxaSSwU8ndT5VpSeAihlgbDbbgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUN2/fHi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2698d47e776so44520775ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761632723; x=1762237523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLfGh1leNUsZjwbIktpxp1n7uZcLFRPeUCzP02QzPMk=;
        b=ZUN2/fHitejLqnYb5G6HsOGak4DENjC5Vk1CBZYFSbt6s+UxORveiPR6hEZz/vT+7W
         ZRmWMwCFO9mHpqTKXZPqjn3spgG781RIukMiADlW52saShC/cWvfy11U6wiz2pnWKy1g
         iPTw4fEdQZG4Qp8JAiFH2HnU1eEadDqSZYRXdvCbwUw+xoSlhMZBZ6NNAokBaJAmlaru
         C0uvdpa2KS9UsrM2WTFx9VyecWKznI5i2BLGR/iXSfnV0yGSALuTowZOMymmX7SeiXxg
         ZcNCQD68DiZrRmSxWvGUXtt8OpqwJhv7/UWhpDGnQWGZKH8TPi8+zaXdrSjXwJ/0ZRUT
         Rsgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761632723; x=1762237523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLfGh1leNUsZjwbIktpxp1n7uZcLFRPeUCzP02QzPMk=;
        b=Dc2LuZF/zURD0nhAz7v0/C90Cs2Yj69TpTBdTBrYVuaGrT8V/7yyl5J/XBYaYLaKfb
         W+mUMGuqIFhbBhaP0pVMQdEIkfAw4ngc1HrrRsOPOR5rRfKBCpZIh+qOvuOT9zWhjB3T
         m3Fpl5ad29iFrNNZLix1STMcyRUeaBkLq7kQLQpuoqZWkqi482ntkNVclAj8XFy0inEm
         luUbJ4ec/CqR7d0UdsNFJbPoN9yw4grolkLGSAJfjOQTGHutpc8YG96kauHymC9lZpTP
         MiFsCShrMqRJnkdV1SO01CZ9IuWeCsX5AxmjZULhQ3O3JGNNbS9RvMJAmOBGlMe7E6tI
         Zl+w==
X-Forwarded-Encrypted: i=1; AJvYcCWGPUcMfFfeKo4ctv9rsYclg8BpOGuSoO6z/HpO59FXs4jwfXwVN32CcKRvJc2oakrrMbLfLzpnCbfWPnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCCRgtTMpEMmPScNVoo2YfBJvyHll8iEetXN1gQMLhVjojuw1t
	+BP64bcGHmEGeIi1WXR7cRtrL3aMIbKJjKS5CeG1+lXo9xRAOqYS3n07
X-Gm-Gg: ASbGnctTRMIi0gWAUG5gvBXe1QjVpK4Z/8mwxl46TCv1xOP/X7BGWhI4bxPB2orngxM
	vAdcidW+iSzBmikamniVWte1YRaM++Lb8XgzxkqhiUnwIiSO5SpQkLRl1kAcXg0xEnrcdo4dB6m
	uP67o1UkvwORsExMzVyKjpPIDH9+u2gT/w8kY211XnjDZ878PDvEJLh/nHRFLi31xcnZVPUtmBl
	RGj64+bv3v8HjDu+cY+RpDUV3Db92P0uPpFg7JOa9FUbemk9p/7VwqI4rIv2ZVqh/KCl9twtxjV
	glrTuIIFVk5hJNIHOAYv57aYn/fmrJ9B6itl5zHEjECR8+x0+pbx5uaegpidrbyT18t/tWHnPJj
	s4HpJOUOIIfN2sGqXUCh0jmcHC/s1/L4uR02n/fbPf8Jy+dYWL+CtYTeez3a1NkrJp75C95jLxW
	l2KdmvKIfb+mZXI5c+El9FtWxP8zeqTXsl
X-Google-Smtp-Source: AGHT+IHSAuBgHpUbQhJC9STJdSs05Hy2t30Op7zl+T/wUnVSBrW32g8WMe3rf9WtP6Q8+DGepqzUJA==
X-Received: by 2002:a17:902:cece:b0:24b:164d:4e61 with SMTP id d9443c01a7336-294cb378c42mr33310415ad.13.1761632723109;
        Mon, 27 Oct 2025 23:25:23 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498cf3bbcsm103004975ad.15.2025.10.27.23.25.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 23:25:22 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Roger Quadros <rogerq@ti.com>,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] phy: ti: omap-usb2: Fix device node reference leak in omap_usb2_probe
Date: Tue, 28 Oct 2025 14:25:06 +0800
Message-Id: <20251028062508.69382-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In omap_usb2_probe(), of_parse_phandle() returns a device node with its
reference count incremented. The caller is responsible for releasing this
reference when the node is no longer needed.

Add of_node_put(control_node) after usage to fix the
reference leak.

Found via static analysis.

Fixes: 478b6c7436c2 ("usb: phy: omap-usb2: Don't use omap_get_control_dev()")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/phy/ti/phy-omap-usb2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 1eb252604441..660df3181e4f 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -426,6 +426,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
 		}
 
 		control_pdev = of_find_device_by_node(control_node);
+		of_node_put(control_node);
 		if (!control_pdev) {
 			dev_err(&pdev->dev, "Failed to get control device\n");
 			return -EINVAL;
-- 
2.39.5 (Apple Git-154)


