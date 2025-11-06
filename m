Return-Path: <linux-kernel+bounces-888733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BF0C3BC67
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DF8188B3BE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE16033F8C0;
	Thu,  6 Nov 2025 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="UrRof6Ut"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE7D33DEDC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439569; cv=none; b=Uvh+hNLDwrEn1hSPkRha/4J0EExKIfHhj7icbZ/RsbCaoiUDf4b2WKEtvyj6WIRTjFdWjqlk7tMOwNgLBe0TNksZPN1vdb7EGy9ShgAtBJP/ETSPqWQ8TyolFJyRhDOZEX79OhJDxnk2HjdZCQdCdZKECbKQM2YDiSDfnlaLsXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439569; c=relaxed/simple;
	bh=KzXWYFedYyI8UG+nwQx/rQYPGeNs0qKtqKI3x4qG4cI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnOzSZOPy34SGgpkYOBvRUEIPFFgck0KZOCq3KaqTXLbrw6AUV7KL5CqCh/7euWz1PflC3XyEgGNFpSNI2uvjiHQ7KxdFyXhntT3L2dxYtzMCLGyeFN3UsovN19l2mMRWy5iA72zJA5pY0dSCXu+DBec9ihKkiYvhn8sQEzvjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=UrRof6Ut; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47109187c32so4891105e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762439566; x=1763044366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMbjX960Vd0zTJ6ycxKDpuXM+QwZlwVzJthScjlDZlY=;
        b=UrRof6UtD9JtNnQqf52UYqjSQxOeSkhLQP5Hkg251nc/qsXujvw01VnhlDGFDXNzb0
         Pd8aSnGHocqzsv6KCAdigpRi01l2j+e/ahws/WVJK1Nci4bhVTeP1B1BAc7jm7k3SFZO
         eoID3/2dzReZ8SPQhnO0jxPP1LJw9kS8pUGH30fjq0csXkl0on5SG37bo18+b6uncLFK
         xI8AXlvVsFydbfAKEL4CDdgnJdU+AuWry7WZLlZ5jp+jKCudfxC3kgPoETVjTMfhCgb9
         sWLoSHi93CSoEkE3es8nT0xXAMvsEQBjR3m4Ttg8jj0sAo3KSlcht6aCzeJpYnjz8eSK
         SL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439566; x=1763044366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XMbjX960Vd0zTJ6ycxKDpuXM+QwZlwVzJthScjlDZlY=;
        b=T9aKdJ5IlGvu/L98ZjEX2xu+3LL7sJ9oojSfQX3UFBAUQSFCf8cQU0DYd26mdxclw7
         /xRtrtX/7dVvq6SKpIc2ESKx1Wr5sENBJZU0qwHfqdZHHlhtQF1Bgl+ddfWh9fTd7Nx9
         kCHkVybOw/s7yf2cNC9f5M7QWlmrrm+TTeV7yXRwC0UucRFoyKRDzY+PlvB6ZmtcwRZz
         2z9NfLnxWqWuCp5mKGuouSD5NkSyrgUuMpYG61rWssrSlnBzWm5bymcYpYD4tA+XRGyH
         1BvTWt8HEZ73JmHrAkyGDzrjmjmMA/iY3K1kEzu9QdrPkXc1SojV7y9hwWAsw3rc/TOF
         LSEg==
X-Forwarded-Encrypted: i=1; AJvYcCXZyn/O+SCIqfZL3aUSfA1/e9dSzc/liGbl3N6AiSkaY3JxlVmGrhUgvcn+8gsmD5dk+tlPTzVQvcZYv+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVZDketPrjRH2EewDIizyGlVHC/i2Z4eTj/EAnty2TzkEvcLcr
	q9EorZfZiuJAh5/Nr5P+Rwge4YeurZ/zSgfsPqa4it8JRYFgml9FViYFaHB8gAr9UwE=
X-Gm-Gg: ASbGnctvX5a6fuARrMapM7qfcSxfyIF76iynZ5kAi8oLXhE+GZp8ENStN0N02vAoMd7
	CgAYhdpxGMpOZ+4Ti3kWarIeu8MK4U05+/RoWPjhBghiWmgBcTTgzOp/5Wqs7hgVipcBzyK6I7/
	LjVdrDUAi+Mra8ub4hFHzB1CStxAlJn019gGoMWwX5OCmsM0a/m7OOOiVitg4eYVUxoBtQOu5yZ
	16RNEtNIz4bdLRy0YSoKQQPPfmerTQiRFTisK82NFVbIjTy5LHIP073S3IJz9TjdEKMGAMvdAdO
	eUIhajq1+v8SMv9rEWFXJaTnnWahBMc7sD+5pqKp+reKDECEd7uvIwkSVRQxocYiv6gyLYT3Bcx
	tcWWPdWTUEhREQk/mpWhsaQIVxNr2oxngZLgd48VjfzJbR1bC5I0haBA/ueTD/56TmRU4
X-Google-Smtp-Source: AGHT+IHXzHeV24TgPJiAXmdB1YalBGdrS6x2Psqj5D7JQbkY7NZBgxck0p46HAgXC0mlI3CMiLVKhw==
X-Received: by 2002:a05:600c:620f:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-4775cdc56fdmr56344625e9.9.1762439566449;
        Thu, 06 Nov 2025 06:32:46 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:d9de:4038:a78:acab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763de4fb5sm18871515e9.2.2025.11.06.06.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:32:44 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 06 Nov 2025 15:32:31 +0100
Subject: [PATCH v6 2/8] software node: increase the reference of the swnode
 by its fwnode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-reset-gpios-swnodes-v6-2-69aa852de9e4@linaro.org>
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
In-Reply-To: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=963;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=HX7JTQgb7mODwXNdQkxhPlBcCXEZwyahgSTpWNcaNnE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpDLGH6TeXNVOn90Zh0qIgRIRU64BenuPrkJnAG
 /JoBwdw/n6JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQyxhwAKCRARpy6gFHHX
 crbZEACGK75SMAGQxr5kK2dyn1zEjJWAM5PkanDBYBV8+ApZMT8wOERUyFBh+uKPye5lPR29ko7
 SRU2F6uTXdyN6j3jyf257r/WTnLpBhSRpwy32bbSqtjAQ9AXeznN9vv7u2SI5NCa5ACD5gbpg4n
 xPPkowjOZI4qq6wr5WTWHq6V/jIEGfctNnMKi+VIn/UnLi56wNNQho9TXYk8T4OzUwdfwPP+6su
 2lXxwiFAeQY8L+PMOgtmD1q1QgB1m7b50t3fXntkAacfUV2+bn0LIxXXWW0MTNNUxZtYori51bT
 yS6hr4StvGnj2vNBrmmSict1sMYO80n68tkbALBQaFEC9vOWZUKdgeCh8IwUXAz3OAX7fwELamH
 CkZyq+4p+RbZNim1rnKm3x0wFlN6h1dIF9gJO1DZc0uwMU3hdTLCScVK8WJ4uUTi7FtpCXoCk1u
 GOqas36H50h+p/jbjSx4V7utx2j4kHKq5lmXlFm6GyLGucDG+pePLzyrqIJtcAmcuSfcuJw9biC
 6o/vKd5Fe2BDLP4VFKuxpEuMrqYcruIcArh7Zo/9l+u0dAz5ZmKS+/l+Iw4RqovVbzh2+Fo26Kb
 6XxXcI284pVt3/QvbfLoMV/o83ulIQhVcuoSlcMIyMVf6u+ENX6tD2llB11bnpD+Obmfui+w/PJ
 HDdC0y5lvt4TRPw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference other kinds of firmware nodes,
the node in args will no longer necessarily be a software node so bump
its reference count using its fwnode interface.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
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


