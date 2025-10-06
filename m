Return-Path: <linux-kernel+bounces-842975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31639BBE1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B084189725E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C01C2857E0;
	Mon,  6 Oct 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2TEjaxP0"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F52848A6
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759755640; cv=none; b=nSsTwedAyNsamaNO50FeujADMgqNPRdK4m/WUjmDwIqW5RaDRDtM2k7Caef/WIwxwxXIzQIOAmbS8OFnthwBzdkfRVqlKL1NmPJgvnl5k/hLOo8kBnM7itlFa+8lDiPS6TcYroRoIRYtfuojwigoPzY+uW0ojoq+qILZ9WpOFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759755640; c=relaxed/simple;
	bh=fQI/x1mfXGLwGHQU2jPShdqMN7mTN0xvuZeF3kl8J+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFerwG1+HqvNkmSKNicqpHWDgg5gOjGd76ZGyM295uL/2vXJdRbRzb9A/eyiHQcP8UP/1HmWWeKU+afc/uoqqtNFfehuanz/bdpHwgLg57Ub1sEs6S+qCStuFhWP+dKL4W3hAoFI0DBeAwKv7y0iO64DAdRLU2uJhVRnrwxdGJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2TEjaxP0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so28086475e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1759755636; x=1760360436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWNKnqg+rjVWS75Xku977zgkREPrPcBc6PcBPNb4lsk=;
        b=2TEjaxP0buZCzXIOPLHjHvGj2aO/f1dR964eIX3cfAqq0y/tKpZQtprJRRRjww6opj
         sllyxopZwc0n020VAvZluiQtZqjBR7bp3UL2aFFIwuXgxnAVuKOlJ83V7pW0YIJEGRJi
         l+xiLFDBWLQ1hhg0yvNgVoJmhiFE//smj9SSEQL5qxUc7ciy7nchuy7s4dfHihYv58nC
         wRIxIVNP8XblRKfH/Xa05qedDCsZ2eXbI4ljk++cs7jFa/2RlWAwby/PGzPCSm8CSKk3
         JwxLn+xWbGxvnVPrDSEbTfnRZN7dESuNT0Wk3y9nDwI0a4g8IGm59LKhx/RHawrC1zrG
         XvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759755636; x=1760360436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uWNKnqg+rjVWS75Xku977zgkREPrPcBc6PcBPNb4lsk=;
        b=vxLLSOEr2QNrICPEC2payCboGiCKI8uIDfbrrFFUcwjHU23bfTPdCoeQ/WHaRhnK0Z
         8o9AyjShQY4OnGeRkmGrzEYABG2wqn4m41EhjCjhxEFkhIUSuvtMpaUmTh/mvMhYke4j
         7h3zgIIK5BUggqa1bo1YdJFylR7Qx65bfaPkYB0c/A66tK8ek5kVhDHSLdwkV5iDBwbI
         klRTtb76i8YSU8k/CoTq69+5GiOFdQ/Ng8xOGMjTs/ejJ5uHamsZe94wcivSL0JkaPfd
         FUREDmN1brXFill+c9c0a8I5yCQ7WZ4f1flUSmUWrANEXaTAsVlaBWAusiS4fs4CEcJ8
         PqWg==
X-Forwarded-Encrypted: i=1; AJvYcCXOrjUt/PW8wMZBDVjA84bu7vi/mfQDr9+rPPih8SiwoaWLbfdlk0xdKmvCcZnA8CvCLlR1YNm3wSB0DUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQR/NAyA4z3QJH65+L/LuI/vCrvjf1ZtLUaH6ctwwJRvPAA0sw
	IsreoV6emNOUvzLepqxoIdG78Anf5HmkMT6KLYwpj2JSyE3kNLfQdnX0aiXS2utNRww=
X-Gm-Gg: ASbGnctOulnmdJLWmTGlY67h3NuVszK8w7dXEeOCyV1f5IsPpXDZ2CcDlhKx6xjSyfO
	nMAcIVNkrEyXUm/yWRQz4PS+uHU9FIHmZyFuV+gRnoEmjRLINrw//LS+Cn2dk4D352qHRrJQKJ+
	tieNzOPddnkwEga7cyRJr3cPwLkURC7vHI6W/0p41MDzGuS0dCaQOidrXf4eoZ7ecpYIMj1jA6B
	3ieSdZEBBBV/Cx/u/+UFx1BXsqOlPmFR7jCxAhxWiuOz4bU0GOmyzfSoDMLvY3iPJ3k3In5RtYl
	QjHDZ4kQoSF8q76i1NsjxRd0Nv7BhmEo391DIztYWf/7pR9QAbAqPHdDq5hGxQVVkwQggiLUQFQ
	fJsJcaJLnBqIJ/qIKTaWhMge3XeSw0YAFc1IdjF4Uhw==
X-Google-Smtp-Source: AGHT+IF8QYCtllO4mHewnOdNKwyg7VM7sonfF/iAif7DtVHOdnSxT2xKV7IG3D+F62nGaaXjHu14Rg==
X-Received: by 2002:a05:600c:4447:b0:46e:3dad:31ea with SMTP id 5b1f17b1804b1-46e7113ceddmr102522015e9.17.1759755636178;
        Mon, 06 Oct 2025 06:00:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:ed2b:276f:1a72:aac0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm249725965e9.5.2025.10.06.06.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 06:00:35 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 06 Oct 2025 15:00:16 +0200
Subject: [PATCH 1/9] software node: read the reference args via the fwnode
 API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-reset-gpios-swnodes-v1-1-6d3325b9af42@linaro.org>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
In-Reply-To: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=O2Bm8zK8myf8pkCc6yVByD6bQNfFHPINhpPFtP7hF18=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo471v6m7oxteEZyESdFKLOSTziNaLss3w9jkI7
 CFUp3WLu7WJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaOO9bwAKCRARpy6gFHHX
 cuYDD/9ytGdRu/CtE4of0wQOC+lY5AA6NHbxW4y00dovav8+EestNKOrbwTfXvNs8TakPPw9pf8
 UmOs/1CbTbVGY3EcLdC6OgoI1JALLGd24bWbjibom89VSr//6m02QQrAp5Z+LfaHvLmPvpizNbn
 4UMWZRgqiy/U+lZZQVigCatheQ7JxfW1BlVOergWWZByTEnzxrHzqAF9XkPbfUE7/Yx7z8+TGib
 GLs3y9t1tSz3EO12/yaJePTuFR9zXWXbcMcItgTTWZbqh2fOc0BEaoG1DPhFIyplT4prWrkuBax
 S3SBO4mh9TX0JymOXKxHkeyS0VCjdGs+S44B18z4EEfp/tiDBFoIGEBzJcQFeq8ctogQBCvBmgC
 Nb9aHZxZM/iQ0WacOk5hgeR+F7lN22T6EVBURTr+MSvLAchm62IIn5We/8SDFbE0yTqrGGQZ/LE
 wTqa8TH0aThr4XrmY0KYYwd2H7V+t82uP+S6ecYqn7Qq6qRSDzPobbx8T9W870xD3H0qKD/uYd/
 RYzbLfUF8DEkf7WkFhtCI68FrALzdeVKFloqtCOhXNmDF1IkWvMMxOSeuT0usFrJq/75lSSST4c
 uBOORRAIPyRoWVFh1wSgYAg2alqD4cULdktEOQLEHWF2as8qgqm4vaFCyH7hTB9eXOVoSTxsuAd
 IvNrQtd63c1UVag==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Once we allow software nodes to reference all kinds of firmware nodes,
the refnode here will no longer necessarily be a software node so read
its proprties going through its fwnode implementation.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/base/swnode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index be1e9e61a7bf4d1301a3e109628517cfd9214704..cc48cff54d9c3d4d257095b6cb4a7869bf657373 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -540,9 +540,8 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		return -ENOENT;
 
 	if (nargs_prop) {
-		error = property_entry_read_int_array(ref->node->properties,
-						      nargs_prop, sizeof(u32),
-						      &nargs_prop_val, 1);
+		error = fwnode_property_read_u32_array(refnode, nargs_prop,
+						       &nargs_prop_val, 1);
 		if (error)
 			return error;
 

-- 
2.48.1


