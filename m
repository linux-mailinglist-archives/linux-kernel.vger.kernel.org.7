Return-Path: <linux-kernel+bounces-896768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1EC512DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624463A2999
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAEB2FD66F;
	Wed, 12 Nov 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yz1jhHD3"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3002F7AC2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937323; cv=none; b=Ch50g9wIz4yTVbJRKgg/2IihJd5y7sOjQYdr4UhvHcdDQ2I3Gqva2lWruUogynZtr0lVkljaHGTlfAyEHsy5brSoSnP4CmtfPqt8PCrqUZAFmARC4bLrgvZiA0GyGnT/3+F5dv6YUERyavssD6IXjyMOPenRUvOOTGKEtwF4jrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937323; c=relaxed/simple;
	bh=RSbVXOg+8C0nJD9ShcJwOT4ddmb41onLxh0rOGHpDn0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PXEdVcIrnmFLyBOolH5T3KEDTIVK1aRKyYTcFs+HrcmlQJ0Z1tJb5HG6LxtBuLeFAKuwkibQDBeNEtA38/X+IvIAY21OZdcAY4y9ZDw1nT7hDfpgOdTjMI/6Edq+/iE+qaeiS2Xlhc0yNvEEvsm5UeE1XwZihVNPoGkDZ26U0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yz1jhHD3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b312a089fso364826f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762937319; x=1763542119; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27w63Mz9ccc5XxoJlnWhVXxnQAo1CrV0jhbhR0EbEXg=;
        b=Yz1jhHD3mV1QGbCN05wXC5G8LeobulepD5zPNm41ef6QKRVyUjZSle7ft1S+jvXYHk
         xYf/M+2F280rLx1oLr3dFeMgLxZHwz39DWRyBSo1mjjPWw3YQxG6XBS0xIYonXrmuysZ
         A8F0tTlnC98epGlIWLZ296FgyS9oAjjOBLWGVMn+pn6icooKWwqGa6uBBo1fnpdFRUiy
         UbBW2iFivuisD6hS0UxgfrOKAqjLdlsgsMItzSEos7oJPUFBRexXDNbFPGVxn3500Sgz
         1AuAwJv85K4f+RXImttEuj1jj4jOlUAK4mBIbykRyAmXRXQTZeDLZqiygd3tr41mEkbi
         OFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937319; x=1763542119;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27w63Mz9ccc5XxoJlnWhVXxnQAo1CrV0jhbhR0EbEXg=;
        b=Lgtv2A2jCfjbzHWF8WEIBDa7be1mV6wBXD17wW4jxSl3abTRy0OeeIhkjyXK9nnXCs
         SE/rd8CW94r554U7+uEu4Cx2WJlizI2J6NepUI5pE95c4FU+gbWxPxQgY1shRWVL3oGI
         ICaX2Ywxb7TgZf3Tolej6QDjyBdFL66zT3OMy8Px/qRZupLWhS24c1KFiEZ+x6KBfpqC
         9FrfoyMa/lzhOvAfCD1Dd4Wkd5eWeaXwqeEY6Ybs/7MWpC75/RuuRUVqCW0zSw3sewBp
         aoBjIWJbCqMsaho2e0RdRdHrQYN1ZN+VuOPtoqdnaQcYQxpSPfc2MlFJXyMADBKKb3gI
         C2KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJwa7xEO4DOMIvEAlbh//bS39qBbu5wEaxGW8CvDdiY4GmfWuvU8U5z+1HflEe7khOuZCw+DwbaxO1Bvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfoi2g7T4kCzeTY32AssJckqc3t9uwafTOSHENAnWc3vN6Tj1c
	m5ReimUViL83lPK4vmOBAwQ/cBlV9VW9YuDsWcvJYZkEPJNLRUbZGLkf5zyfluUlZnQ=
X-Gm-Gg: ASbGnctQcjCbVzvn0n/4ki1xj2o+vsM9+QdAC71jvOWj9flql9oyqUh7EdzQEMwgDbt
	XwcTRh69Vmg9yXu6QaTVeaRIDnIyagNuSENpcOWEU3YcH11dpFi2g0DLOdlHC+6KudhkAIdBpK7
	QQBsGLlGnq5dOH0vyHu4DUyqekiZiM5sY1+ZNgU6WV65Q7j++Rk+TziC3EJoTv7szEe0Ax69fiz
	3pblK85r/HF1czCd0lm4cQXLKv3Dd26HduogUQKYegzd3bEQxOp+7LLENcSrXkHtchPznq0/hsR
	NjwQIsdfepjSxrTjkYCdAz6L7m8X6gZJBi4nnRU0N71somW1uxjKz8ZWVJNSnJiDdaiXdIUgzAI
	1vLGUO+SZB0pWwvTRe4AuorQYVN01wMBYfgGSm6O9pfQp8NDIN7WkXsCgAYRMA/y73f30x2dnyv
	qsgqIaRDpwT3HVTauHCOTv/tCbaTERt6rwCnl74pnU7qa9OoZs00i9e/pZ
X-Google-Smtp-Source: AGHT+IF6Pkp2SBzU7BHGsBfFVqx2Oez9GDgT/TNsMjLzGrA9exqcgbd1aqea20wtto2EL68roP/Ewg==
X-Received: by 2002:a05:600c:4fc7:b0:477:4345:7c5c with SMTP id 5b1f17b1804b1-477870cdbc2mr15394965e9.38.1762937319130;
        Wed, 12 Nov 2025 00:48:39 -0800 (PST)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47789ffea1esm3732645e9.13.2025.11.12.00.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:48:38 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/4] soc: samsung: exynos-chipid: trivial updates to
 simplify code
Date: Wed, 12 Nov 2025 08:48:19 +0000
Message-Id: <20251112-chipid-trivial-v1-0-ec2dea03bd83@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANRJFGkC/x2MTQqAIBQGrxJvnZCC/V0lWpi+6oMw0ZAgunvS7
 GYx81DiCE40Vg9Fzkg4fRFZV2R34zcWcMVJNUrLgrA7Apy4IjLMIVrTWV4GJ3utqEQh8or7H07
 z+34Cm+j4YAAAAA==
X-Change-ID: 20251111-chipid-trivial-6a7ceb9d1852
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762937318; l=785;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=RSbVXOg+8C0nJD9ShcJwOT4ddmb41onLxh0rOGHpDn0=;
 b=adt7/AjQ1uwdIeYx3p54fiNoG/+DM7YPB2T8e/yk6GrwGO6jZf7hdNUYf3xy+SldOWQUGihTB
 24qLgSwTqVzAU5RuNRBK2D2sefLgH4xnZcygwFbcLgdbdZ3D4w1dytH
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Trivial patches to simplify code done while handling the GS101 chipid
support. Compile tested only.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Tudor Ambarus (4):
      soc: samsung: exynos-chipid: prepend exynos_ to a method's name
      soc: samsung: exynos-chipid: downgrade dev_info to dev_dbg for soc info
      soc: samsung: exynos-chipid: simplify with dev_err_probe
      soc: samsung: exynos-chipid: use devm action to unregister soc device

 drivers/soc/samsung/exynos-chipid.c | 43 ++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 24 deletions(-)
---
base-commit: 4b67e4c65c1e0740ac12bd0d790eb5a9d0091aaa
change-id: 20251111-chipid-trivial-6a7ceb9d1852

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


