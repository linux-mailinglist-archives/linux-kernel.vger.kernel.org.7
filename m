Return-Path: <linux-kernel+bounces-876019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5F4C1A732
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D8C189E34A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152A3350D5E;
	Wed, 29 Oct 2025 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NZzxv7Ks"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB44194A65
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740935; cv=none; b=r2Fd0+9QijmAkHGQy+rkJN56NJimUI+WBxlzrE95Zqy8sfKmF/aEIM25Q2HtTK4wltGwSuHXHlBaqy6ACPoXCUa1KKVjJP07RACs76r86QiRxVFzf+BfB+fnCH9iSs1LeB+vjEjoHtjvz+Of54JdkiUvDZx96H4SCMk3bEdnZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740935; c=relaxed/simple;
	bh=Qs8vhyOoCvNWF0j+x9Ihy0ZSJH5YgR3lWq9+JQ16CJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gmMaT6TCdEDuigTw3TVQtvbMTUzZs/HLlbK9Xekx2h34G3o+esozRa2eDzd8w1YfOZ41qAC8AW7FE6dp0uSKf2ayo7h+jvy5rxqE3qCIEtmj7KvpnZDtehANSUvgHeiQcf+ybRdzLhGE/9XYiXbKAF9IQ1HkrXnH1/kIQzdXm7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NZzxv7Ks; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475dd559a83so26339065e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 05:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761740932; x=1762345732; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxAcLRLFuFPkJ4GNJSGN644S0txZ4Lw8m8ySKDPzrmE=;
        b=NZzxv7Ks+XjtNx5wIB3Bs1xHyX4lvgEOipXxeNEmlE0eaEbppGFfMEuc4IkjbSS6KS
         4kuziF86TJn4Aiff+Gm0vKYZyHltIuswu16BA1+nzfpEN1XTBjUXkYirsXdpt3GCW9BY
         6YPxkkZmJsB1Ny3/goUBbJreqlI8iArT278bGo20JRPf4rA7+ZW8uJ2FCdsSSrcgNk2Z
         F3o2L8ASMjo/w5uEv65FK0ykTk2AEnGDJ6tS3OFehBTD+rrcqNczZqwnMSvYV6H9XXPo
         QduL2BXnz6/1WNvt2Wu76NWvxkVROlDT4I1WbOXhUqMKAoxwZOOMxZ3oOhWyTYZq082w
         cT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740932; x=1762345732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxAcLRLFuFPkJ4GNJSGN644S0txZ4Lw8m8ySKDPzrmE=;
        b=anQTNuUDnVGNXaTQSmn6SCjvZQJgnwH02MrP1HDdqgEK8PdbyeYuA/DGP1EkqMZzSc
         TkGCpDj7ZsS3Jn/CAjI9MPEKTp+GRVvS4Hpd+niRQadOUtwJTk2UDIN7BqgxqkZhuACE
         9Pw4ve2F2HNTZs9q3c6eckpn1Vn9GaSsIu1t7q6ZduQNtDtN3BaypMiCNGzSz+zvibkI
         B4t0ppuTPSn6ZA9JTfNqwgUdoKgUZ21K6ZuNTYGPaSJys2CLTK+yMFhxq5f2AOB/ptGd
         xXeflMdE1GfxZwbG7O6E6EGu2UMkGczAznSKDWqW62zAtZ6uCYwLUHU4p3LlWWt3Rk0b
         cCJw==
X-Forwarded-Encrypted: i=1; AJvYcCWwEDzT+cnS9bJpWm2rKxMnZoZIGXJwhDY2aK7B9DZekwdP7fnNiqOHE8V6RB53aEwzO6sKBE0FODC6D0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQS/WBrT50kJPz1G2dOaCIZDbOVk7k0nW7OiO9hBkWJBMYVr1j
	mgrI5qVrtyGo10dKsEjwXd9nf3rGZoaKlnyqyqeSjp4CvmEfbKXA76Etd2a5tZRPK0g=
X-Gm-Gg: ASbGncum61CybIYpM/ZK+XgA7TkuYBv8OMQvryapd9mehxQOYyAp+B61iVOjTF40HxY
	/Wsu8SaTrZrMB4F2In+x9gnKIueutApCSmz4Mc95l6faC2485t/er+QFaAv+6gFhktFlAh8xi2z
	CEqt+nConjfYXbJ0BqqWzYJjn+JB2XZ08kArUm2m4hI/gXOuy9g6qUp6v4OGEAB2NVx1U1NyUol
	iRMBvixWrrQ+24HS24oyBCRD2W6YVZ5gLO85b/jdPXoMnF/d5xlM8brhKrBhf6qO5ulc8f9Rk7h
	jNg735Xwev1kP0nzfgUDafLuqXF/HuHReEQ9DJFgzk+FbFB7yxGDYxloZNoV4hibXPxz5q7+11w
	Blf+Q8RC3ineAaJCL/kU9pSVpxwN6559WPoxJ06glpukHzBKrSVw+k0cpqlwjpezowCSSeBUSUv
	iN6Qv8
X-Google-Smtp-Source: AGHT+IGVSIyGHooFUNwJFOzgP02oaNQfaoSa8LUBv0H67C8L7NLZJDtS9Jjx7pnxWYORGUjGIOom5w==
X-Received: by 2002:a05:600c:474d:b0:46d:3a07:73cd with SMTP id 5b1f17b1804b1-4771e1ca0d4mr27882115e9.23.1761740931794;
        Wed, 29 Oct 2025 05:28:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3a88fdsm52775545e9.10.2025.10.29.05.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 05:28:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 13:28:36 +0100
Subject: [PATCH v3 02/10] software node: increase the reference of the
 swnode by its fwnode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-reset-gpios-swnodes-v3-2-638a4cb33201@linaro.org>
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
In-Reply-To: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
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
 bh=4MJAfoZ4MOXSK/aVI5nkAQoTezWuvKeaMoxZLush+B8=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAgh9qP5RDqvLYPjRG0kK7LDKyqTLSCgKta+GS
 Bb0AMsCovmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQIIfQAKCRARpy6gFHHX
 ckQGD/9Wr1DFAlSPL3hjFIONxOnWJ6VUG431FxgF//U0pSgA4H8G3zZFgceXMnkJqW4o3ScMRoY
 uaMVFq4opsSZpwSxT9yO0qsiajx5QASjjn+Pw8QaCJcNos+7cNIzx/5zz9UBnb5PGns5dpkqLLA
 N0pA7Hv2Ky+2A33aLtCPTOJ8UbwmGYwHiZGTg8p/CZqx6/eql1WnLE+FKxSFaHDaDll4x0vEuvL
 muHhKFO5rpTmUwdevO+ohSWt2atNyyUlTl5AazOI6iohZ+/G7NsFw/eFzKzYRceA53ejPTUCM9f
 iW4ymxHNqxnib9It2M4Mv4D9Q6zjXyhSCqY9jTAWTDNaR8Mk6dh62OA2ftBxW/tKEwECYQAsW25
 Mr0OEhtB3SvBOvPPyvKXKP+vO6k6pu2S0CC57Hf6X0BBRuZWQYqGgXAs8xdxST/EyrZ8xaQAMWl
 GYQg5IDNN3ole2frFNobuFSFnTJpJE6I/Nb74J5bkKB5m5OznDnlgLTfncVYG/xDTDoXhmtsEGM
 wlwguFgWGS1Tg6u/EpeQpmEXP5tWrUE/qWuGJcT1n+G71LimrgFJhqPTLuxaAGeKCymYfNjN/TG
 zPj1RZYS4CzdYmtL/djXlKQ7xoa7Tb8SskZmAxvJPMh+dOWrmVlnh3vCqKuxWzF9/b44wMvLGVb
 MVpSAkTAqVelzxQ==
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
index 2994efaf1d5d74c82df70e7df8bddf61ba0bfd41..b7c3926b67be72671ba4e4c442b3acca80688cf7 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -554,7 +554,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	if (!args)
 		return 0;
 
-	args->fwnode = software_node_get(refnode);
+	args->fwnode = fwnode_handle_get(refnode);
 	args->nargs = nargs;
 
 	for (i = 0; i < nargs; i++)

-- 
2.48.1


