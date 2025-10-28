Return-Path: <linux-kernel+bounces-873370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4C7C13C92
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6109C3B753F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3642830146F;
	Tue, 28 Oct 2025 09:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bnk1hMxP"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAB829ACD1
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643351; cv=none; b=rRe8Nn3WCllJDosBzNWz5ranHlj4VYLhIqQUEKrvtNk3U+9s2IGnYe2G9iqzKLe7iA54rM4I7XkDd7GZYbvlZzoQeM7KfWF5/u1nRiVTTBDMh2kAcVjUyP87CQ6N68zqMGYMufkyRGbe6qQmjt0nIR5YAavl0HO4VdHh1Myq1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643351; c=relaxed/simple;
	bh=R+wFbRH8+5hnaBVtC0tbh4Cq5Xw/tKS5WxUE9yvqlX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VhHLHUwVlrs2ox05N409OwKJw3cauvxzWofpUpjSHAP5s548wgkB6kJSnOZQYcAHunxTOYKQQi7S1MPAgHxGA9Jn01mc9k7mr1rq01Ufc5Iu3T12kwboGX8rUgpDxNURQzg4ITfJlr7pVklnA3VKSRSMwc1/a9Wvggd/4s2Zm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bnk1hMxP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47118259fd8so43300435e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761643348; x=1762248148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8/ajMaAZHsmNftCRY3dTAxu5sXZqeX7gjwGITMB/lcA=;
        b=Bnk1hMxPrtgk9OeNLJjQgG6U/DhzLanDfYurXHkoyGWA4SmRzkSxMN21g6EsqIKlY9
         Sz+HQhmWSLbUDFFGuvl23DCz4To/3RNIutR8dowYv+o7mp9z4/RZB6JkopB7RaAWd3r2
         6Ce5itf9HtH8g2HnR6McG2r+4vI9u93jjZwBXjzTWy6yz8HeI4XKIzKTiw8R+RAqWW7p
         0xNRs9rAqedP9ebBNk2h9avVkImsRXS5tlrzxUbmbBi0HPgw/Cn+GMG9t+GfGkPqWofS
         2ffAMzrNcYqe7pJYoVdRaqmv65ODbfOBJWdb5FVUjnqP7xt0xYaLxFCOCbVmcq8KQQ+i
         +kdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761643348; x=1762248148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/ajMaAZHsmNftCRY3dTAxu5sXZqeX7gjwGITMB/lcA=;
        b=rZCPxJMCnoDDE0rqpH1u5xn9WFvgPDafRF38R/NI/cINODvINFAD2xIAy3T8mHQo77
         b1oX5h80MXj1H2C183GvrQaLXAPs6NwvXtUsY5aBBeOjanMbkPGg6mJ4uMesUZdfHRUi
         B3N9c01SUWxQU3X5fHDFjdCHL38gzEpnsp5W16S36Xs7Yo80xDey7i7FBYk2pA6bjxV0
         x58BlS0rZaslb+5YjfUnJ/hH3aY4a73wPyEZDSGbQlN7sFiTG8DBoKnoCtv+7GndYdjV
         1ZtQ7k0/T93cDHhx0lFl+oyCGJy/d7J5PuMfXpDN98rQwR/NCfloROkVRsqG7FGQOTuI
         ynWA==
X-Forwarded-Encrypted: i=1; AJvYcCXzgfVkWAmC1RFkDi+HjPMKu7y4xPAN71jc3AG/DsIX5rJ8NdI/6DEuph1yI0uRACxBzcKdsfouQx4VeLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxnzEikJIxpWYRA924oGkRnAsLqbE69T9QuF8nihFB5sPiStCY
	+zYHSr91LdEE3PmKJ9uWeHJmGzmm/2zxGcxUyWdrZwMGiANK5cNJxyNq
X-Gm-Gg: ASbGncu2o8yrsxkJx1EEP74HGWvm/LMINekYXEGcnSXzWXsCTCi9luoCpzD5yzxLacw
	Xh39E2fkfpQ0t6jNy1mcASF8InK1ZNQNxnYDyVQqsTgEAs1P1bAXhZdjl9DpfHvvzlpeqvXRM69
	fBiYL+AYkB1DyrB5kndo1NX359We5HQlmw+vG8XF8MuXBcKuh14k08scmIgjImPbrVCtodkcJZL
	CW/ZjKFwM8iYen+WkIqobLjxu2P9nNxSHuT0kxZgUjjw5w8E33RISZxtVjkltJ9Nkx/0cZCSYfa
	Etl3gXQpJPOPG0fPqLoJ9xzbe0MocUhZbYksAWoLhvXGuSBF6fmazOI8Dw52yiosj27uPLHTx41
	mPNfBqr3iimOM7eS6gD1cRdnWKO/3qmEjddSoAXFlMAHRmgoUjjm35UUdNYhNoANPjFo=
X-Google-Smtp-Source: AGHT+IEPdT6/6UarQf1IlNikxH1wAf27KbmBRaKKvq0yRjb3e4DQIQ5NuvT9CjVOR1W2NXEEMUyxKw==
X-Received: by 2002:a05:600c:1911:b0:471:734:53c3 with SMTP id 5b1f17b1804b1-47717e3233dmr18078085e9.24.1761643347963;
        Tue, 28 Oct 2025 02:22:27 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b22sm19162525f8f.9.2025.10.28.02.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:22:27 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Hans de Goede <hansg@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dongcheng Yan <dongcheng.yan@intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Heimir Thor Sverrisson <heimir.sverrisson@gmail.com>
Cc: linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2 RESEND] media: i2c: add Sony IMX111 CMOS camera sensor driver
Date: Tue, 28 Oct 2025 11:21:58 +0200
Message-ID: <20251028092200.7003-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver for Sony IMX111 CMOS sensor found in LG Optimus 4X and Vu
smartphones.

---
Changes in v2:
- added nvmem-consumer and dropped eeprom
- switched to unevaluatedProperties
- dropped flash-leds, lens-focus, orientation and rotation since they are
  inherited from video-interface-devices by unevaluatedProperties
- dropped assigned-clock* props
- improved code style
- adjusted colorspace definitions
---

Svyatoslav Ryhel (2):
  dt-bindings: media: i2c: document Sony IMX111 CMOS sensor
  media: i2c: add Sony IMX111 CMOS camera sensor driver

 .../bindings/media/i2c/sony,imx111.yaml       |  112 ++
 drivers/media/i2c/Kconfig                     |   10 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/imx111.c                    | 1614 +++++++++++++++++
 4 files changed, 1737 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx111.yaml
 create mode 100644 drivers/media/i2c/imx111.c

-- 
2.48.1


