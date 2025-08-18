Return-Path: <linux-kernel+bounces-773572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCA8B2A1EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77A8C17A223
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C58927B345;
	Mon, 18 Aug 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wEXzxqwv"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0485820C00E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520222; cv=none; b=s11RXk4CF2DCrZOhzSn5Xl8f96DVy4CGbKfnrfDsLOUN8e5fFNlowvc/Ky8+Y+yL0aFXk0DwXqQHz4vevMPh2l6v45LoB2H8Z4YITt/DhZ3Mq/JmwBJRLoBwvIIKntwngI1tKhTwGPMYRwx8NHduVriGEwpNcp2O7mnMScaLdEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520222; c=relaxed/simple;
	bh=JlaSzZxFUUDEKFzH+GanUwNC9293wOpUa3UXPCil240=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GbfOOZpk3OMrYb2/dyVZrSLSf7oDYkXkttCD4DjXO4uFiXdRqTOJA8FFCH8MjJm1MYF7RZcM8msdNdsnD7JnjW6omofUfZzlWl9p4zR9q00DqdbG5psmf3zjeM+kXG+lDGja0cIk1FpP1p/nVCymRilg0w/fb+D/cefkcBl5ZiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wEXzxqwv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so24003635e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755520219; x=1756125019; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JnfrGseb6nwzv9RscumfuSdQYxOK2zLF1Z1VoJgRh0=;
        b=wEXzxqwvJEl6kSqhaNKimR1iGEZmAXacel+z9x/BZYjG0+5ocOUOod9TIzV7zVOtXG
         ImOuLHXK+vYwhmmLO9fEQbBzlD65CMfpVnRkLykOQRPsDOWsaWq+BwPdj/S49M2k70JM
         UktvMaT1Q2CHm7lLBjsDJ6MI/mgO5+p3o31SLwTdSpK2cf8KC5/Zg5peRGbNnG05QXg7
         jjOaXpA1Dn5UAYkgs+lOWE1mkUIVR5tTVtuHs3buf3LVCtvC9NFSO3u8YakC7SSPdre6
         esi80xaq3ZJzFXn6viJGIKAlea4YwtlSZa9pApcwQWapr+xjrqMXJU/kBtkvgGJGcBSV
         QwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520219; x=1756125019;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JnfrGseb6nwzv9RscumfuSdQYxOK2zLF1Z1VoJgRh0=;
        b=jJvdLXafR7ekC6U0GWWf9jWCqytun/Ok0AhQhCJVYGkdGbCuL/fcYZpw7PjXoBxrsi
         0hizvhCMyvIW/Atmb6Y76oY7A0k8Mtx6a1WDx9fQKjyvB0DVQc3VUhH4Z2yoBZRuHjCA
         hnk9ZfnUzPAzHd4drjDsdM9oVlOjbM4cbiGnB/Knc/cUDWGH+l5JnSakLdDj6MeyjJRB
         uRKC3QeS5pcnCo0mCRo/yMJj3uNvUs+vjdAcDhvQaavvMZolmt/AcsnKP2LjY3zu3+dt
         Z8ac/bJbIP1GF4lyXdmpHnodGqxkoB7hYxy3ru7jMGezL0rSM7FlzmX9z/xEN+fQIju/
         1TsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjaPi+rtSj6yFmGEb8Ox2L26qQ/gDP5UzjyLVTwwrntBeXHJW/6ajVggEdlOThKJSiMWDPIkaiU28iMR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn6fPLPK7TgUbX9RW3SGT+1/esPjemEcmDSboODhS77yaZwDx2
	A+gWEzp1Tcej2dFvskO3Nx/RTv2BdQUwCjVKTrbHmEMgAfpt962RNnbVgOfasg/M1uE=
X-Gm-Gg: ASbGnctNutAkL+GyXiaUsR/EfW3J7Zt5vQRk8tr8kDAODnAHII3H29IfI115y5Dxc9b
	DK5qIubjZmguhgYtRILFeD1erK3yvFDTwVqWUhTeRCSb+pJfEWt8HhchwvylRAI15M8IYuph9GK
	pBagl/qEZtr6kyVVgT1YSwFdWHtp0vs4fsS9Xf2K4Q5DLBwCKHU4YZXIqFsghorvzlgKCJ+6ADF
	rvJij+kPOTT0Wnh2pcq0S1f8luqpqVvWmLJ7L5Cjhz2kVPxrSsszIrsuRpvZw9Ghdnx6Qzxw1sO
	drVmWKAUG4m7toPRdYAI3ymiF2bn6tTnMNLopJsRXaS5S2BOjey7hHjK9EHU2ISKCTEVJeo2BPr
	HAIz5pePUL7hsObb9lel2tw8cNchZhWoWDdU5VVVMgek=
X-Google-Smtp-Source: AGHT+IHbHsTWwwaFVik9BbWGPWwZYPFU0j7xb33QVY4O0gkyyCAWkV0Jsoyi3ARB4eQMlZj+lbRkSg==
X-Received: by 2002:a05:600c:630e:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-45b3e827f65mr32714475e9.9.1755520219188;
        Mon, 18 Aug 2025 05:30:19 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb64e27843sm12680828f8f.19.2025.08.18.05.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:30:18 -0700 (PDT)
Date: Mon, 18 Aug 2025 15:30:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeff Chang <jeff_chang@richtek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH v2 next] regulator: rt5133: Fix IS_ERR() vs NULL bug in
 rt5133_validate_vendor_info()
Message-ID: <aKMc1oK-7yY4cD3K@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "priv->cdata" pointer isn't an error pointer; this should be a NULL
check instead.  Otherwise it leads to a NULL pointer dereference in the
caller, rt5133_probe().

Fixes: 714165e1c4b0 ("regulator: rt5133: Add RT5133 PMIC regulator Support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: rebase

 drivers/regulator/rt5133-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rt5133-regulator.c b/drivers/regulator/rt5133-regulator.c
index 39532618e73d..129b1f13c880 100644
--- a/drivers/regulator/rt5133-regulator.c
+++ b/drivers/regulator/rt5133-regulator.c
@@ -510,7 +510,7 @@ static int rt5133_validate_vendor_info(struct rt5133_priv *priv)
 			break;
 		}
 	}
-	if (IS_ERR(priv->cdata)) {
+	if (!priv->cdata) {
 		dev_err(priv->dev, "Failed to find regulator match version\n");
 		return -ENODEV;
 	}
-- 
2.47.2


