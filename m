Return-Path: <linux-kernel+bounces-882569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 868B4C2AC63
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F21C74ECA7C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1142EC576;
	Mon,  3 Nov 2025 09:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JWtpCIPI"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7382EBBB5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762162543; cv=none; b=b/4Mez58sH90Gcf1SE/6INQZzmwNKl4Fy2tf/A0rlyLInQP8b4J99M2gI2xxvVPwpbm1WO/B/FRgURqTk11hFWspeEwh9G1ygsLxxAFbw4OCXhuJNdXNOHPwaBC6VpUeLfKde8fg6jsjiFJr42ugMdK8N7cnkVpesg3sEQWhYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762162543; c=relaxed/simple;
	bh=HTd4iZaPRKiVM5g3i5e6EDps+IClJtoB1LFevsHD4CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rnspSVPW1FLAOP9dummJXKJH6VZD+Pdiglb+1nXLD17zzvzOB0sO8B71cLsPG+jozZHRrCT9ShYdn0eyQN5dv60zEMwo3X/3OHiiCwScc8AyYXcvGxlFJ9SqtpB8QZDr7slGJkJtdaXlweWqr3pmwWNeXugXmaNOayhKvXrWkwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JWtpCIPI; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso3210752f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 01:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762162540; x=1762767340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MR9/q1uejjwqNisgWS/5bEtUBR0CMunjlT9KIpTJamk=;
        b=JWtpCIPIuRvgg4Sg13FMlCyblxReTvVv2jm73Kmk/EwGjo3NZZY/+EzVhbc9cjAKkU
         nXoOP+YtehM/qX6yAY/Ci6diSaxW2gCHcuDOHqbsSiGChBW6bprtUfcXafQQ7heK66x6
         Yu0EwMo/UM57YX9IB1otdeM8MHBMotRoZYwCx55ndLXQnFpLhxh84uiMhvjsYz9C/3m7
         iFXjvKQBU8Dv/YzGaOlJ6bTucGZLHAckDeCNpczEntObRa43Lsc3mdC1vetVUIYcbNnS
         HaEnp3Bfj1GJoSZKtZr7/TXFeolVuor+mLXAK5192HeybFMuMJ6huOUm3ugeR21Ydrqp
         Pj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162540; x=1762767340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MR9/q1uejjwqNisgWS/5bEtUBR0CMunjlT9KIpTJamk=;
        b=TGSJmkutnNuu2igqlZppErfLI9uwCeS3gj2NjWjEiNYUT54GFoyCW93zYa5UuyJEyP
         q01S9B7LqBVwRW+oemfQeoDLf0QLxR/5PJlsYDUfa+V48Rqt0Cs/vZFG35WXgEzCmvb1
         Ken84qoQwmd2jsgamUi+imbVeD114xv6x1j7qrLjq0O4JQ6ZKW/401u149Pub6YZ92rO
         KDSN65u9TjIUyXg6PBOJVcLrerYfmNaTzhb+Dz0M4kXufgqMGfhvx4Lh9gI4K5NjPkjf
         DxJqIZJ7OUf2WMdZZNf7HcTIki0uHuwLzEvO9FeyxT8P8ng8eaPrBan23urF5+rG8kZ1
         8Shw==
X-Forwarded-Encrypted: i=1; AJvYcCXLQL0Ch9bGvaAQeC1185DH6Nyd6OVjYEFXzZOazQCDB9bM6tB5criaYQhh++uKQ06Q5pKa2OuYM5hKddc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGazATHz6agoirdmum2G1qgMUngNGUYZ4quJ3fkd+u2jSD1T0c
	eEzpTYzkXECpKUgLs/zkdLiJtwprCn2CHTpaXPiiySuwGwdUaO+pNxGBDLlBmM+9z+E=
X-Gm-Gg: ASbGnct5HQlErkgUfgaQYKpR3Zst0SL9IXmB/WMSUZSQIGxsaTEglB6EL4tO9kL/pJU
	tM6sGZg5Q3gv+bUlj9qx0WLm7JvEtSuJ686BjqYxITi8cHfbY6EBnLGgexnVOyE6j4k6qe0SfK1
	3TuoJiNdsh2fNqppeegumV3EndIveeKjOslgSXV3nvlsAtJuXKqiN+QNfYO+ERJaJvsgPD2X2k3
	Uj13iQRoCs/EKtxCV64McrzojDeorp+1jUsa1BSHskhKvc+xjHsO1yiOWh9q2RQ62lWG0avCXRZ
	/CnRutWuHvoDreOtmFwFhwZwQbsfzFIt6V/GcBeXoyV+6ywzQ6R5FGE+QRwPahBnmA3JqRQ8xHq
	Z5DEZeN9U0iW8+n6LCs1cjilwrl1Ozh6KAz9v7WpTprTi045j1Uy7lL3DSCAw0+CDS1gFsqW5YB
	pE5PlO
X-Google-Smtp-Source: AGHT+IHRSTk2bASAi6bSlqK3LuaAJPm8yPphUV6iZEA60aV9YtfO6Vgj8NiJ0oWGdqgc/FbytjRbkQ==
X-Received: by 2002:a05:6000:2882:b0:429:c6ba:d94e with SMTP id ffacd0b85a97d-429c6bada73mr6241828f8f.12.1762162539894;
        Mon, 03 Nov 2025 01:35:39 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:e6eb:2a19:143f:b127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac5d6sm147285675e9.8.2025.11.03.01.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:35:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 03 Nov 2025 10:35:22 +0100
Subject: [PATCH v4 02/10] software node: increase the reference of the
 swnode by its fwnode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-reset-gpios-swnodes-v4-2-6461800b6775@linaro.org>
References: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
In-Reply-To: <20251103-reset-gpios-swnodes-v4-0-6461800b6775@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=905;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=cWEXsl3g7Qga/+zqwiTnXs07zQEFM6f4IiHgGDiKRrI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpCHdk+HcXSqYzV6wtK2hDXg7D6GqjdHCZYrzNH
 mNXIIVvAOWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQh3ZAAKCRARpy6gFHHX
 ciivD/9xjHtYcd33CT4tvDonwQ66b0vfxLxMbHV/nO11V92tOAvwAjfGw/ojqixgfmPdF7Am0uQ
 Im9zZSwkQpWnJqhA7DRQ1sJMNmh8o06kZYqSCkFJHicAYFtfJ6dWQYriuT5C26OuUkFxMPi5TuH
 7Ak2d6zirsj8qZQZHY9oq2etd4D5ifDwFk6tOYNa5V6D9Rig/YC6WQ8H5nL2C8KbFmgQ/TDkwTq
 i0IpO3k7U93Qdef+NUsvbyOisc9epzhm+1QykzdTFx1rutfkuEZbgN8chSP6HKlNcUkjOkdwgG4
 FcMAAvJa2i0Hk/ulvK5PRd4xEnKpZja2+5ogMxt8+2egEtXLVfRzh4YMuRsJF2cf+Ioza9OsmOS
 6r3fwUH6/I9xBk6y+zJdfCiHYw8879CtKBYz5rEeAm8HWJx1sbOxSyZ3b6VeQPccMIM5kgcQSMo
 bxM2HJxErbnCovM1w+K7k1YavCJdDpAZS9NWOEXk6xtyc+Epw8/PgjVDrOQfBaYd3XH+u9IrsG+
 MSXxk9NjcSaWhb2ppu04meUK2XIsOapbRE1e33Ak/dGj8bmDY5DsP/M2ih9j5GHaJCkvqA15HU0
 hbnNfbr6h9tILvvJQE6b02v59X9+vID4kWCnnsGpB9I50RkIJ//+G0itWtI9z2rAy3uPjgwv9yj
 RDPiRSETNW3Z2eA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference other kinds of firmware nodes,
the node in args will no longer necessarily be a software node so bump
its reference count using its fwnode interface.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 016a6fd12864f2c81d4dfb021957f0c4efce4011..6b1ee75a908fbf272f29dbe65529ce69ce03a021 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -553,7 +553,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (!args)
 		return 0;
 
-	args->fwnode = software_node_get(refnode);
+	args->fwnode = fwnode_handle_get(refnode);
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)

-- 
2.51.0


