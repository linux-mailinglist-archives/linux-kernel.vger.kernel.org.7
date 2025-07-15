Return-Path: <linux-kernel+bounces-731454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D132B054A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 10:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CE2189C7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECC6275B07;
	Tue, 15 Jul 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X5fVcOIv"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FF0275AE9
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567596; cv=none; b=uKhyiVIAcbSRsFEEvshzCC4S9MBJCONmpSp46t+ePn1esRrogXl+0Da367joPM+cLfMhbJyFxbZgBm1sgXrSEvCvYdtnY+R86N+MIEpl4LpCVrMytbaBI+4xvqeESHRj9XO8AJqT1+pucdpXtw+D6WQ3U+TVa5pMbWMKHWO25kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567596; c=relaxed/simple;
	bh=3TZO4356pJmTK/ucycFfV4RA+RP9ThUPXqXUz1dGC+E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=em+5OInztstT6hnTsXKe7w6fcQtn22wQj+zZa4pph6AUXU8jXENoXD8OPL0lUIoJEPrInv0TEOmyh0O5HgbXh9eTZugVF+rZL/QMi+ZAioJZG6WlgWQrCd1dtBxtQXDdiYHc87HgSjYrRlnH0ey3SZOjWc93/vthuSjYVNE9Zl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X5fVcOIv; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso3198023f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752567593; x=1753172393; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oifvOYfRTiHrrZd9oFt2xJWefhV12VLQj3WNflmH33c=;
        b=X5fVcOIvDaqNzb+zhFBr6jUqEK14Ozb8TQBSDs2cQeXq41q5A6uhxJhpj4OzggpmWb
         6k2cTdkth3I6/s+bU65+zY/6dIHn8OR8vWHV1NgJQUraiijL3N5u2kI99tef49TKmJnY
         ho6wcOsrL5PHT4eWAjP0da9gZk0NdxLTDfOeuxnakaLdcoW/q5gNWnYcU7xkxa0dK4zi
         THIn8X5xFORIwNd5zUBLPBoXP7I5H3nG0mAkWFbV0EIOHxMBCNmcPDZdECvYpSeojSuZ
         TmkqE02D08OaQx/sToBKHftSN98sOB6F27Zv1tPDCl2Bf44Shly43zTypc1iczl72s/0
         TQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752567593; x=1753172393;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oifvOYfRTiHrrZd9oFt2xJWefhV12VLQj3WNflmH33c=;
        b=bnF78MB+Cq43fGUrzBpw7JF0qZKl9LRzzdIDCwliuh4SjeLyklhZR679s1ZOT8yHJz
         Py4/GIl+BzM4S0hd/UQM2IADgeHGWTKaDBq/zUV8ETTLgzzG3DRf+wPi4idvyR5KHVAJ
         t10JWD8CD2ON2CTqzlh3SCPuFdJ3EtQewcrf+d/uN19O6HJC+GlAvM151JGbgR9EQEA+
         srbBE8J1vm9cBkzNqstbjce/NsZHKiw+Ghx8Ph904rwO1knqWUXjQd9nKTXdd28I0WI7
         SQfaa1BOabr6ODKB4DCt3ROA2VrhceDEImHbF3S/0jrOZZ9oGm4ZCz+U1i7JxXQff0Vs
         lJaw==
X-Forwarded-Encrypted: i=1; AJvYcCV2aj1hBC6Oizu0dqUyBwwT6aq5yBboy90gSMhckxfRH3/mgdNHz0JxsQLlaMyHcLANGyV4JfWSzJZbvwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGvat2Oopo5fWRpRCnnj+plcrIhA7UqECLIMIBwU31+ZQbwAKD
	nu81dvc/xGylFt6/eMx/G7zPAISejPRqagZjT0xdBoTEWhk6UuT/M+zU0+dp8qpSK4/Q8w6fZi0
	bEdAPHLA=
X-Gm-Gg: ASbGncvW2fmr399EWSps5LT7od1QztPL/DZ4bdSKqEF+gDya+dY2EtKGJSEimyvJ8yC
	wN7vCIyxpDl8mfZQYMVXcG7QU+edC62aqeyxdoBqFevruqb0wwhe2IVYhheS1ZLYMmeJOTlh6ln
	UFr1DmoA7WXVSmIHr9J+BY/rAQLjYPoDFh+wYvcCQoMzwPmzvTZSdObi0aIo7m/LQ14/5atVp2v
	eUkpAgwCerj6Hcs21N9R9iTkBxsRKIIX03gYTtR/6HT+Nvxz81XZsEnQtfbUcJ5do6EE87Hu6en
	/L6yCrfdE7rzN/HLnaYKAZUyg8XzvktlQlk94ADtXTfBdT9hIl0H9Gc8QEVMhLF/yJ+bmmw4I+H
	wSlLb9MF6Ew6+pN1FkkDXeaV0CmU=
X-Google-Smtp-Source: AGHT+IHotH4B9LlGDmCSIXwZpmAXmPsr5VXRdVlhQbnK16OE/92hwFpeN5bfSobrsX8y6fGRDkzn/w==
X-Received: by 2002:adf:9c84:0:b0:3a5:1f2:68f3 with SMTP id ffacd0b85a97d-3b5f18d2e76mr11705226f8f.46.1752567592784;
        Tue, 15 Jul 2025 01:19:52 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5631:db97:f06d:3c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1de0sm14334589f8f.24.2025.07.15.01.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 01:19:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 0/2] gpio: use new GPIO line value setter callbacks in
 remaining drivers
Date: Tue, 15 Jul 2025 10:19:43 +0200
Message-Id: <20250715-gpiochip-set-rv-gpio-remaining-v2-0-072b4cf06330@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB8PdmgC/4XNQQ6CMBCF4auQrh1Tiq3gynsYFkiHMom2zZQ0G
 sLdrSSuXX5v8b9VJGTCJC7VKhgzJQq+QB0qMc6Ddwhki4WSSsuzbMBFCuNMERIuwHk3MD4H8uQ
 dmFHrk7UNGqNEiUTGiV77wa0vniktgd/7X66/6y/d/UvnGiTc207LyXSmbu31QX7gcAzsRL9t2
 wfib4pUzQAAAA==
X-Change-ID: 20250703-gpiochip-set-rv-gpio-remaining-6c554dd3e662
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=3TZO4356pJmTK/ucycFfV4RA+RP9ThUPXqXUz1dGC+E=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBodg8kKYpZCKS3QiG/e1wcc0k1zptSwkpbzJN06
 58eo+07AsWJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaHYPJAAKCRARpy6gFHHX
 cocrEADUjMTvlwIFqUuWqBqoKCvGYmokDqIRdoxHpL/kMPh17nSrL1zk7mbVhpGcwss7nXzEGu3
 +5r6z2AtzUKhgBkNz7HVIWs9bgsmbv8wSTxpwU83E7wkEqt+jdxS1Q9dSzjtvsI1FwbWLn0zWnR
 ig0aMQ415toX+PR4rtxGx2t9UaelpITlFbeQRgyp4UOWa5c8EuZrCYsJ3mfYKWnso9bATKiFz0u
 IpEvXSTSQ8gWJFV5r+sQQTXWwZlfQceEd3ZLVhSp30YYZWRc/CRiDWK7eQ7tHKP5RulqgxYXWXQ
 9nGem0BptR2tCxdC9Ev+vA5f6zgk/ZNSTiLxcyTJvvgreD8TxnIMA8Mr6Qd4u4GGTGYCmZbpqoQ
 ANPq0/ZVS/Xao3AUmhFicnzybVn2NMATiuMWiyY0/k19zu2UKKeVW9pxSf+SgDr5W446yBYVZcB
 IQslMQiDO9n2imSLLkatQcFo26PoXfCN9m7O1I05IcNM+GAGUcM/RJLfh7XpIUYe+m4CSGhaSdb
 54PPgFuuVW6YIju879DvSnCFwbXiUwLVJJpQLWAEH8hcJ2I9qsPBGUcK7J+xFeKFsEYErGoEgwu
 UnoFLXtasMKGCeZiJf+XQoefwFzE4QMRUtlgUF/lvEhSxMaCBYpNv15Re8VMO08HRlzhfW7Mt+b
 upx4Y/xm2v4FRSw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

Commit 98ce1eb1fd87e ("gpiolib: introduce gpio_chip setters that return
values") added new line setter callbacks to struct gpio_chip. They allow
to indicate failures to callers. We're in the process of converting all
GPIO controllers to using them before removing the old ones. This series
converts the remaining GPIO drivers.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Changes in v2:
- Drop applied patches from the series
- Use regmap_assign_bits() in gpio-wcove
- Link to v1: https://lore.kernel.org/r/20250709-gpiochip-set-rv-gpio-remaining-v1-0-b8950f69618d@linaro.org

---
Bartosz Golaszewski (2):
      gpio: wcove: use regmap_assign_bits() in .set()
      gpio: wcove: use new GPIO line value setter callbacks

 drivers/gpio/gpio-wcove.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)
---
base-commit: 58ba80c4740212c29a1cf9b48f588e60a7612209
change-id: 20250703-gpiochip-set-rv-gpio-remaining-6c554dd3e662

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


