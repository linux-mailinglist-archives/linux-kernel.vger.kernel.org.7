Return-Path: <linux-kernel+bounces-894001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80232C4914E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4977D3AFB7A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A13D33CEAA;
	Mon, 10 Nov 2025 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skBObT0p"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5D337BBA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762802951; cv=none; b=jNV5xd8/yY0hQZcWY+mlyn3bFPUGh7v3r5BahcswhnYxMussIR/eBTYoMA+AFGVZA4aAxjdDJsd1ZyfLMW/FBZgdKKhf4ZPUBowNPfYEC5bgs9ym8+Z1z/1lCSU9gS6YkafPRdnnoTKaPnK7/um1Y5aYvkLUvurPrI54N3Y0t9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762802951; c=relaxed/simple;
	bh=yoWFkHZtj46uF0EW4nm1cAv2iisUO6p8mkGLUTNAWgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QqjyuSixi8q0fbtswQMnZkFKjQOV2kjTLatB49SKDzUYsyGiCzxkLKnH8lvrsbY9JJrF+f4uZ22hgEdVT1OSmoJ8jbhjMtNMFNY4Q3UwIQ2Kghxcnq7y1HTM/0wu3zbrcjV+o1wMpTWwDPbHQd6JP7Xo4m0mytPoDCRTNg+QGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=skBObT0p; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6419e6dab7fso1719332a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762802945; x=1763407745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeUUtxVE/l6U3rYNomhig7G5mdbpyNRzMIJHR6C88h0=;
        b=skBObT0pVZDBY1aDYJx9Cp3lvJRxVUrdZH8UoDHfPA2EbAZw/IRb4YDMGVF/BiBYKf
         aVGjv7L+cKWd1gfTaR6dlfUqMX1RRfouhJnUh6S38cajQOg+BOyDcDBrGxunUpXs5two
         3X+3If/MEzmtnyvFf35JfCULor4LRMvlOG6lQLz48/e1qL0R5GiOKtnGqK7bIqmnm+tw
         +d93iRxAte0W0qI7OWKmooZgEvOXXBdGVBVIU2dj4VIGXiiZx5/wGzxmKY8IZabaKxUq
         5+0fkAdo1Y+N+zG56HuzkiLHO6vdTTV968txIK82VQCkFMVoJDmlHyhwh17HzOkEVYUB
         mQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762802945; x=1763407745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QeUUtxVE/l6U3rYNomhig7G5mdbpyNRzMIJHR6C88h0=;
        b=XaBUgOYPM1gpk0viApe38ecs2/NbShkQR/OMnaxY5Ovi0jN7ri8o3f2ovBdCT1C0mG
         nmF/0q/WoHzmjA7dTEkO40y/lLu5JEUx1jV1QAwxuzmSWYu30kHwQI9Gkw5UKRBWWLfN
         zbG3N/TtZBh9ATWbqxYdD0rN1AWZDz3B2JSeDhG3v8qAhhZvqWfdl6hgZbw+Fj0/14BE
         FfCcmeMW78rlPkRqmySOfmuaAf37SVpF5ZfR3KqOdm9g7QGiDEb40ta0xXXBGOxbLcJt
         tbmk0W5wqn+88/rb46S4vYTERbizJ/8qkNb0YAVaH4wF56Usbu1lrF/qAAxjQwuWp402
         0TRA==
X-Forwarded-Encrypted: i=1; AJvYcCVsNsXdIcsxTB0eIp/ipG66pPaeWJwq4oBaFHRLeZVi5+GHQ4xvm/LHZ6TCev4OLw2l/Rq0xYieXMmBEdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ymSwPZFgqTrPfVuapYuYDrTcpttdyU/MgoaG9O7vLh0kR73n
	Ix+7FEZ5e6eN2KQ9GVHyLdLpKScSWHZWqjOegXeEja1X/DKYBM/U3t6AqCYHXYSYSV8=
X-Gm-Gg: ASbGnctg99ID1ObO7p2y0goQ+GHwT90bYPVFgufS0WbRlhsGhO+fYNxWOokYgP+oIIw
	kP0st8VnFr8JgW3cYrK+20zABYUuyqLqIcOIbLJFRxrEFrM0gVDi3BIfSdC6Pq7kAMc8ILLrKVI
	IHp1UNNodZkKOCpiI8lspQLp0qLNLK0hEqKPHJOkC12R/oZFUCOjKEUB+92/bYj9t9ba6cQzO43
	vLv3wcneA3GSZtByRjzs1DYq1e4RiFOeaQ144+bxUGHaty9iN961OooMIzlQgl5+pCDx/h6Nivc
	TQICi/pF7e9YfwCzdRqReAwYcounBMSyIiiIDglQg+5g4OsePHRmILrjlJBBGWDFmgGAZir5MVN
	1sV6FgeZWpyIFTJAjgfrVrgArlfjSRrGAmbC8YUx9nVbJXV0OJGyrTRDV/jZNdwjriaqf7Ob4k0
	2OYuuJXedZ46T6dKHNffiT1aHS/208OdQMknKmxSSP9oDxBfBLBGpKNy68aqcY7i3bTIW5Obs=
X-Google-Smtp-Source: AGHT+IFCwxqLkhOuR1fLThDVMMelLXW67BZ82zG7gRYpU2TMEHXfkTI5mn6Zu6XtzFQ4QrsAm2NbOA==
X-Received: by 2002:a17:907:96a6:b0:b72:614a:ab42 with SMTP id a640c23a62f3a-b72e0015fc2mr739140266b.0.1762802944631;
        Mon, 10 Nov 2025 11:29:04 -0800 (PST)
Received: from puffmais2.c.googlers.com (254.48.34.34.bc.googleusercontent.com. [34.34.48.254])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d16esm1168178166b.35.2025.11.10.11.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:29:04 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 10 Nov 2025 19:28:53 +0000
Subject: [PATCH v4 10/20] regulator: add REGULATOR_LINEAR_VRANGE macro
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-s2mpg1x-regulators-v4-10-94c9e726d4ba@linaro.org>
References: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
In-Reply-To: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

REGULATOR_LINEAR_VRANGE is similar to REGULATOR_LINEAR_RANGE, but
allows a more natural declaration of a voltage range for a regulator,
in that it expects the minimum and maximum values as voltages rather
than as selectors.

Using voltages arguably makes this macro easier to use by drivers and
code using it can become easier to read compared to
REGULATOR_LINEAR_RANGE.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
While this commit doesn't introduce any users, the upcoming s2mpg10 and
s2mpg11 drivers are using it.

v3:
- new patch
---
 include/linux/regulator/driver.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 978cf593b6624228fe1fd9c2a3e186b53ef172f8..977755db64c6dfaea7246067eab0d9a2971caa01 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -53,6 +53,11 @@ enum regulator_detection_severity {
 #define REGULATOR_LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)	\
 	LINEAR_RANGE(_min_uV, _min_sel, _max_sel, _step_uV)
 
+/* Initialize struct linear_range using voltages, not selectors */
+#define REGULATOR_LINEAR_VRANGE(_offs_uV, _min_uV, _max_uV, _step_uV)	\
+	LINEAR_RANGE(_min_uV, ((_min_uV) - (_offs_uV)) / (_step_uV),	\
+		     ((_max_uV) - (_offs_uV)) / (_step_uV), _step_uV)
+
 /**
  * struct regulator_ops - regulator operations.
  *

-- 
2.51.2.1041.gc1ab5b90ca-goog


