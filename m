Return-Path: <linux-kernel+bounces-893494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7048C4788D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC43518937AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE932550BA;
	Mon, 10 Nov 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El4VTfY9"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AF23D7DE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788352; cv=none; b=SAdnagsQhNlKL7yJGUiqXf25oFkx8Ow2Hdi4xexpiybB720nTyVwcUi/0nmJu6co5XpmIXvrVs6lzcsqURakH36gYs1QeB5VTKXRi0qXNr815mdELNLlafVw2iNEuu+Y+L/B5lvkO2XZxiFK35V/SPr6GgCGpS9t2X98dlRA8M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788352; c=relaxed/simple;
	bh=55cmDK/DB9d7aWyV3KRW+2aWkZsi317dmr5DmE6lvzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sR4vhH/p6LKT5VApMD3+P5QnS6Vim+3CGMEyUHXSz5vLPPR85pXtTm58ASKkZNVttWS41xIxXRwTdLz4qIiC2U448FAwZFXHN6BiR9QOIs+mg0FbwV9208/qLmcqyswnsVS/YoqoeoPh78NJF70kKLM6ZucRhR9lisXmHO3mY+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El4VTfY9; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-375eff817a3so30213881fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762788348; x=1763393148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y7AbbQjoW2c7ZR6ncveQ52gAnz6KIPcgn2CEQordzs=;
        b=El4VTfY9jnI4I4m+jLt5IZRt5W0PMDjX2ohDPFhbjpYofJyXeKhlEWguQ5T2/hXwzH
         u5kXnqRZKBdVFZdit62N4SHK2LqX/jpFL0gHaJ9qoC8zaszh2FTp8AgDujO/H2gg5wgt
         esk+mnuNSI6P8OjvTgzwcOuJrtSWneZoQWWNl9WIqj0Er8ciRmCxdNFwC8DR7YtPJWu5
         1U4+Ybh9tUKakkdIULGZKUqxxs5dv4NASkzGsC5qYeysE1g/+wsYis90zREsG8dLb6s7
         UTtDumqbJxSmEHqou+A6idHLOftjhcReZ3HlcY7OPWGyb5UMuKjMnqKwe/mlsKmReuxi
         JmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788348; x=1763393148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y7AbbQjoW2c7ZR6ncveQ52gAnz6KIPcgn2CEQordzs=;
        b=paiGAp+1+x5guv8qxyeGv2rmOTDmuTp9EKa98r32573OxH63VhQhesF9umIudClGz7
         BjXzEodA3a/MmuxZn8JqUpDh6ZblKwyUy9krKwY80U5TSukRwFurVXUEAPujCO8qHCxU
         Jodux4gfemR0BkxkMm/6/fGpU04PeXkbFl/S8+HPZErBa5yt4H71RCJR9/S0Yi6uz4+H
         Ywm6/CQ703IRIhQ23RGpTysby9Wnbe/cY5rM79rAfX/QoEtC93VuczV5fGI4n+s3oJkM
         rI5hiWMngPJshuLfk74it6/wSnuoFKf6qTwzGLZ9y2hYRSKJgTSRFl6ls7ACryhYrf+0
         5+VQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8NDAUm51zNwPraTjOqrWVYOeoNeZp/DTUyh5mGQZF+wiRjp+5i6AVxuxm+ciizLI88SYJfXbY9dALbcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjB4zdnRTW6x85MkOrNBvChIYfSu6LMozvaz0WhnmLjBzd1Na4
	8z58Vv5CcBOrOgeSe/HAUCTZkRedJC9VY6Ue7+JzdwsdpqyZdtPVf7Rf
X-Gm-Gg: ASbGnctmU9GeSjzSzbNQDg2m0FCCP6+7S8Pq0aMZPmtYdCZciPYt3FawKF8Lss5QvZv
	ubWsJIHKPvskJisgXnxQEuOfVX1eyUJqQti4d0EoqhlWq8aEE3x1FnPIIHEq4S3yQDFziFeMgg6
	cbJiPWxsPfwdDIfoGZpY7CR4mgwL22924FEQonplHUjb6IOsM+1S3he1wUJ5x71oCn088pDTkJm
	Ab9a62vMd5eTLWXXK+aLmHXKZKMHqqRyBtjn7ujAEKWMFTlD8/+9zpc7T1MuH+tYKfwRthsGjtT
	nWfsewpsqv5scDACfDJCiqPnRunlhuTnskiA5ver9nwxxuzcR6NiBlvE7W9DEQ2Y30LTx7OnX34
	6VQZCOAgQCZ3Z0SCpFIrvtN6J1ZPtbAihekqjsuq9Fm9f9BCXv+ZEAH6hawANAAYwsBq2Skfkxf
	j3sqQIxHD/cYWybzfnsg4Q2L/klQivqqS7Itq1V6RzYdPGUq4urecDohTVhqxf7z1ghwA1aA==
X-Google-Smtp-Source: AGHT+IFZ8Hdn9bIBL2aLClDGCYweA+vbXjTWrk0GlGrm/tskYdFblhNV3v9npKdqEcfWPsY9ou6LMg==
X-Received: by 2002:a05:6512:3d04:b0:594:27fb:e80f with SMTP id 2adb3069b0e04-5945f1c258fmr2134855e87.37.1762788347931;
        Mon, 10 Nov 2025 07:25:47 -0800 (PST)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013a36sm4059381e87.14.2025.11.10.07.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:25:47 -0800 (PST)
From: Alexandr Sapozhnikov <alsp705@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10] gpiolib: acpi: handle overflow check in acpi_gpio_adr_space_handler()
Date: Mon, 10 Nov 2025 18:25:44 +0300
Message-ID: <20251110152545.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added an overflow check when setting a bit, since the function will not work 
correctly if there is an overflow.

Found by Linux Verification Center (linuxtesting.org) with svace.

Fixes: dc62b56a68d3 ("gpio / ACPI: use *_cansleep version of gpiod_get/set APIs")
Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/gpio/gpiolib-acpi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 834a12f3219e..dfb421bff979 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1069,6 +1069,11 @@ acpi_gpio_adr_space_handler(u32 function, acpi_physical_address address,
 
 		mutex_unlock(&achip->conn_lock);
 
+		if (i < 0 || i > 64) {
+			status=-EINVAL;
+			goto out;
+		}
+
 		if (function == ACPI_WRITE)
 			gpiod_set_raw_value_cansleep(desc,
 						     !!((1 << i) & *value));
-- 
2.51.0


