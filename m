Return-Path: <linux-kernel+bounces-870883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4EDC0BE61
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DED83BD210
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B112D94BE;
	Mon, 27 Oct 2025 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhN0Udah"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29CA2D979B
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 06:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545179; cv=none; b=HOdiKfgK+HT+Sa39HKZb7JZjCq7/I15rKMT/oTkUY0+WbG5iUrLMSCYLD+GG7qCTzDw2NgMTSmvgwtKghXUq7FijzRL8Fj3igvSlf4K4EPviuQ+IrYpd3/ExbpKSdU1EZlSdUP/h1ymg9OoyGbi8Y1eeKkXxGpYQpGNFmaoEsL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545179; c=relaxed/simple;
	bh=NkM5OOy0ytkuYdLV31rIkddcp0KAU5XfIo38O7mQLp0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JYb05t7DOUoI0SDd+Yxq0JfM6r43XILXspFuiz8QyVrZxCSC+UtvBGFUu3x7aHKDuTcB2qQ68YB2b6jcTrekeFxLw4z/0Y4+61yAkMeld+HD9FTOXkCJg7o3fZygR+eyRtIXI/Z6g7RVHheKZrt8AEfs+BsAIt9NX+iAIbDcJH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhN0Udah; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-292322d10feso35579055ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 23:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761545177; x=1762149977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awSfWJCX4NOY9wrF+e8kbd/fw7N/jjAHRA0gUFKf03w=;
        b=UhN0UdahpzrrAPhmvLivbhqb5qh3PL+X//OdV8ST4M+LYgORcTORh3+5sbxuafLuR5
         hLx4HuMWwkC5AltIB1R4B/tIkBCeiqoIA6oNmPpmi1BO2z4BlXwLwH/iwMN6JysbSdcf
         RdopUzLcfdKRBh0YuZNxzTInMFK+eVq+vWwszZ9EmbsPK/lq6NlVe7EG1HS8CcQ9bj5y
         zSR6XfHRSX80+eq81WVhrHJCLiYIOLdsmlsPij69C0MLg7lPS1t+hF8ajmujC936JB1A
         hJfc9pU7ldtLzrFlX/poKU8JLTJTfzFP8eyAGkFSNsYltLOhHbML8alI3sJhxAbhTBrQ
         Ydew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761545177; x=1762149977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awSfWJCX4NOY9wrF+e8kbd/fw7N/jjAHRA0gUFKf03w=;
        b=llekmi/7NEhzolWBVmhcMlH9HxrKHxVoHpbamPVI8Yz/mGG90UaGraTMyG2skEhXBF
         dKbQfe+n39C0WajLlealHG6zuE1Cff3UnuGa58PbIghAhi0ubS688mkyU/NYtt7h+o3U
         byzZX6hN8TuBHZRtBCRV2xUOwnb7r6sIm+IWtx/KJE4bVmUxNz8dodwO2+sQ/5AtliZz
         lmyNoz39FaTJgFGliulOYxiqr+wWMrdOS3on3GEKVHHwzQKdi5KOXtcf6s0lJdRYnNod
         FdWsaetK6R0c6Sn4oYSM6o/4cmlvx36Z2DtB6pVQ8NvSN06MfgmQZb+w4NPPLm0cOm7x
         3A5g==
X-Forwarded-Encrypted: i=1; AJvYcCXe0COf4gtBNfpXDaP+rYbQp6q9tCLnRbHan1/GpxrB0sd0P8BjCdylW7uj+fwUV47WiBkOzC+6qEJuUAg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytqzl0l8TjErchXFbqy58WR3OvZXwMjShvgYUcvoxvLIPC6OgP
	T151tdA9ZnlduRb0bBHFNJGYHBHPQomCyVMcrKjuGQKinQuLIH085hSQ
X-Gm-Gg: ASbGncsn5kPc+FuprIVTCL1bgLuq5qVtwsNgxVT8h/q2cSZx1B2JWVfgbfkwtnhBmGQ
	8xpKplaTvjZEavuiChhDMHi9rx/EQWrFPedn4o2ogX+yVUoCP/eAKOnv4dTBMzW6PxrzF2tjyXI
	AdK/XDzzENHnIqFVkhh/i5O/5GeSxlGFhpmsJ0an0jb3MYpK2RsAvwEBoft1RHaL+UPDwLoFBPI
	d9JDSLRUC1KZbaJmahy1KK0mGplk+Vgx6FvD0RBz3AUyygZ9nzYVmpXo1x0kWgrNbnecqeQJSC6
	F/8q2axz6D+9LW56gj5T3eQysyWJR9/2XtT5GQRt1vaKbHFFbi2DNnerwVx5ZkfLseFLuGVlEGl
	7ujVlQe49D5xi7s5fmwq8OelmHzeJ6krD0MXnYo2thnw8loYmnmS4Vy9gskkjdxhJBWO3v7+Tys
	O1H54HsAFbCqDaZvqwZUJcOg==
X-Google-Smtp-Source: AGHT+IGGfNR3pDzrLXsRHQ0DtnR/zCDD6PytEF/eEQoukh39nKst0A1lb0nK6x8BAecxfbckIr0K+g==
X-Received: by 2002:a17:902:ce81:b0:294:8c99:f318 with SMTP id d9443c01a7336-2948c99f5d2mr159955775ad.3.1761545176998;
        Sun, 26 Oct 2025 23:06:16 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498e495e8sm67837735ad.110.2025.10.26.23.06.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 23:06:16 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] slimbus: ngd: Fix reference count leak in qcom_slim_ngd_notify_slaves
Date: Mon, 27 Oct 2025 14:06:01 +0800
Message-Id: <20251027060601.33228-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function qcom_slim_ngd_notify_slaves() calls of_slim_get_device() which
internally uses device_find_child() to obtain a device reference.
According to the device_find_child() documentation,
the caller must drop the reference with put_device() after use.

Found via static analysis and this is similar to commit 4e65bda8273c
("ASoC: wcd934x: fix error handling in wcd934x_codec_parse_data()")

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 4fb66986cc22..cd40ab839c54 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1241,6 +1241,7 @@ static void qcom_slim_ngd_notify_slaves(struct qcom_slim_ngd_ctrl *ctrl)
 
 		if (slim_get_logical_addr(sbdev))
 			dev_err(ctrl->dev, "Failed to get logical address\n");
+		put_device(&sbdev->dev);
 	}
 }
 
-- 
2.39.5 (Apple Git-154)


