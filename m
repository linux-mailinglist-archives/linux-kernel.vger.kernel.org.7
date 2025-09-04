Return-Path: <linux-kernel+bounces-801513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D364B445FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D974B1CC188C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964BF287502;
	Thu,  4 Sep 2025 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuOErrJ3"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563B270EBB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012343; cv=none; b=rtBST+bAXIlTHRQUPiSQvg/SHCBDyD2PumHJhugY9lUyavtBsnta8Hc8FRBIF8yFl3yMa7+Xbjzg6Sw4OSg8/dQEQIaqiEGoQnKggj8y8HYtNY5zlKuBiAJY1MNink7VPAgtC4Wj0K44hPiwsVyyTjBIOA6+OKfe7H8GGW9Ulag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012343; c=relaxed/simple;
	bh=uivRpA9HtbBawOeMvgjPRCQa2tnswuXo9Y09mOkTMZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pGUoVsS1U+y/IfY7e64VkvnG/XDHicW6/anDoIQlxXLlYKi9ctx0dLPBuaJTlOeOBW0LvOpAMSsidg/nfpnzvqC5iSzj+8T0Aroi23+FpjjNUEqXlM/Biy0G6MerjRBBrun0wJ2MpG08FncN2mmvYr1/76J79PBYjDEXjmqU2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TuOErrJ3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45b89147cfbso15022835e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757012338; x=1757617138; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H15AtklgMCpkPmsWguobA5odfiBnUJPbrja5Zjg/Sh8=;
        b=TuOErrJ3evnYIuhusxHIBESgFVMAuU22hDoTk68WV0+cFB8pzYSfu7+CfwVWEUUbqt
         Ze8JVRodGi8+IGdDP+/UIaTKi2ziSM6bqIjnaKGGRkQXZ4vshj1SS6R+8LjCGy34BLs+
         n5jWz4LfY4LR4U7k9qtTbFyqg+PYfDgYWBrUz6BEJBJcWI6qnZ29vpBBCjbNtkKwv865
         vappMPUb6Oo8pMln7+bky3V6q6fTecNN5vtbn4Aj2gRb7m0Zeo+6Itna+OB4oFkP43c6
         AdLiM/acKjVyIe5ntaC62HVdiqPP/qk5dJyC6ugcaufjDyBw8o6t+FK6/kMhwKnZidiJ
         enNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757012338; x=1757617138;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H15AtklgMCpkPmsWguobA5odfiBnUJPbrja5Zjg/Sh8=;
        b=guTYaaDGzf+7pgiLvjewvMPL+IcIbyG0NKsu8SuJHkfgRdGjRtOlQp6EOINX4P6dKi
         y3yN07vtwjLOVebBUk5gtATNn5MR+efaKSW6BTsBLhcyBVW+BvQjOOzSSwyJJqwoa3MX
         ycGwbqi68x9mH6CyuJ+fcPMfvBwGfc3pHb1Gx99E0/iyWE5Y0JoLmYAYdGOVUJr/jeBj
         n6iUzDNLORZQVeeTuQuV9YmiOXUhbW9l9M9XWNPNDPwOgK0jw41zfgk9S0BIbyRw2B1T
         EQPNB6DB2IiaS9Nuzc/WGJ83cWBR73HN49zPLkLHDbkhK/2TN5+T2UWLg4Oe0We/tJtV
         +iNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOXDMkat78f+OgAkFwlJxXwWvM+HTuajlVTkoghYntltftE31hGVb8Qmg8hx6efXjqiyVheh3blrd1afU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZQ7UHUUV6oIMzMlTGzRd5JofmrWAtTor0IVIspLNjo+W+ly4Z
	9JAgGbsDKnq2B2NeW7OQQ+XrKvX3oBNibt7aNYPUls7ZVbO1gJnaCVvbZlL07WJUEyHCSsGc+CM
	XJNyI
X-Gm-Gg: ASbGncse0vAOpIeJMQhFW9LmFe0s/XnEZu2SnY1s/HR3VGCeUKmm4hT7RjW41z2FKHl
	PAXnBGcrbascEtJsbZzZ2IGrfl+UbxY43b1k5WqtdA9Z9/hjLlofQDPg3Sk17KUzH6rdQA8WJl2
	oYIDThrNW727CeM3s9VKPa5YzcdBNady9O+RDkaBww0lXw2nHXqtfNK5T1wYF3vM+lZaVE04C0l
	i+bawAhNbavOc387VG9A8yzwMkOpBtyO4RCX1EWxaXzjj0gVid1vpVIQG6zig/xi7/V9rk76rxA
	cEDlaS1DZGxflCnQ5Qn088zBm0DB9OwmSx4KWzu6Ve/QanX4i/Cc3xz7osbDAcJSBRNk0Dtf/O5
	DCUILwzXZlwTbST4yUFsC1umCrnA=
X-Google-Smtp-Source: AGHT+IHv44BQzQPt0SDDcu17yZCqUyKvQjIqrXkJNrOFeUvr/3w7IzlwPeGAssGYkeSJFClhPjyO2w==
X-Received: by 2002:a05:600c:c4b8:b0:45d:d403:332a with SMTP id 5b1f17b1804b1-45dd53df7e4mr12552345e9.32.1757012338151;
        Thu, 04 Sep 2025 11:58:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45dd0aec70dsm22029535e9.0.2025.09.04.11.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 11:58:57 -0700 (PDT)
Date: Thu, 4 Sep 2025 21:58:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] pinctrl: keembay: fix double free in
 keembay_build_functions()
Message-ID: <aLnhbpfeweBI1H4N@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This kfree() was accidentally left over when we converted to devm_
and it would lead to a double free.  Delete it.

Fixes: 995bc9f4826e ("pinctrl: keembay: release allocated memory in detach path")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/pinctrl-keembay.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-keembay.c b/drivers/pinctrl/pinctrl-keembay.c
index 30122ca90cbe..3241d3ae6219 100644
--- a/drivers/pinctrl/pinctrl-keembay.c
+++ b/drivers/pinctrl/pinctrl-keembay.c
@@ -1643,10 +1643,8 @@ static int keembay_build_functions(struct keembay_pinctrl *kpc)
 	new_funcs = devm_krealloc_array(kpc->dev, keembay_funcs,
 					kpc->nfuncs, sizeof(*new_funcs),
 					GFP_KERNEL);
-	if (!new_funcs) {
-		kfree(keembay_funcs);
+	if (!new_funcs)
 		return -ENOMEM;
-	}
 
 	return keembay_add_functions(kpc, new_funcs);
 }
-- 
2.47.2


