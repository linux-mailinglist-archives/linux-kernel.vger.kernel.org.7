Return-Path: <linux-kernel+bounces-764127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9575BB21E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 130DB62686D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FACA1474CC;
	Tue, 12 Aug 2025 06:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lGkQBUpd"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732094315A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 06:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980358; cv=none; b=ZJ+M/bOgmewId6rzG9mX9MMOWoi6lC92vgrP+CbPutDacCvSgwlL6GBbETsn0ZwRe1ESeRFWUuov2SeMtQOBpgYwOJm/qLnWUk8SqxUATDM7O/GLPe3eTWmSkXobG7OMHU/qpYJ6/BKasfMU8YsjNkF4R5BYUqqF9fZ4PEEeej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980358; c=relaxed/simple;
	bh=19MZZE+mtCCFUSlM4kyJs42djof52x9s/qHDexe1dtc=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ur077pG8h9xRSSHS19JBRNJ9tkTGxKsF6UNx9YtUlFu8E5dBZqkrNxQ9OMMXqKQzZRCZ0E460XO3BQeyaHSkxuMYPLM7mWmlMmGL+n2sa+zIOAbChDCs0+elVT+OqQ5UggbN2K1R1gUsFyzEcXhlmdpYE9AQ956En7QOKyoQrxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lGkQBUpd; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76aea119891so5880909b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 23:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754980355; x=1755585155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e2EbEqlDXIPuEkSIhf625qIlzs3WVIMHmlWMM9SUkVA=;
        b=lGkQBUpdmQaSEpQO4XOqTxzyrm2lEXAUGaQptys5XN9PGTiKs40/C5KrALgqdniZcj
         rQizMlB5T9Nsw5eD3HiTRcwGfv0oxr8/+R2a3s2zPR9Wk1wwy7qbw21pqSyFyfToQNMb
         rcMrDZfKAFUdWJN+OZ66FNH7hOH/+yw2fKiiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754980355; x=1755585155;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2EbEqlDXIPuEkSIhf625qIlzs3WVIMHmlWMM9SUkVA=;
        b=OjVCCCxy4Ww2mM6GqvwkTdo0z6AZrOoObeF6NrHuJCYMIEfw8p/xZSbrZfj2YQQn51
         7TbC8nvswNOCnX7Qt47F79M1+QWAMGHP+/uYTdyVnudOf3tP8D1HlMkj3q65CuC+LDx6
         UdcHF9bnERjBBozAJVsz59ZQHX1ZOqTPJkR3c+DI2ZROMeCNiyj9pgPuT8elBI0t2Y/V
         gETV8UkHPBNl6/uxw0gsH7TAmhgRujBppf09f65oa3auo+2fz7PaK+4/YOZDNJZ9CQkV
         QzkqrHAUqZxdj+qF2TDFa0Gh1gfltAI6+7Z57f8cNJF5T9kGlUlZbHnSbQ3lssOjTPHe
         Cxog==
X-Forwarded-Encrypted: i=1; AJvYcCWbSyW8Q4vnZ+t0S0IAxetxhjbsSh+mL7Pb6Wnhm9P/G4WcX1pO2e39sVKeCTHmvet9Tv8ZuDhXUvcxE7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZMeIC/UZP8MFm6TQmvJcc4VWiLWxLZVxM6RYJ/qgN11/Ryoy
	rw8htxo5UA5Jm1i+rekqrXotC7HmWzfEqxTSttIw34RH2iDKylQNVCIdt3K1Qo8UWw==
X-Gm-Gg: ASbGncsBc969nzoTglI8PZoX7B5/elEqhQseZYr56vAuP3M/FQ3m/ODI8GmVuMSXVZs
	st4FC5oju85snO1ie5AslMrAX1wZnOrppz+RSPhUWdjbPXGrJE9hXLOHHR7IrQl0kL3vGjcUhHx
	5AuGCx08buQNhCXElt0fcJP+0THjp+oJAXnuhzRSEy9TSbKz3KFlGxxZ6ys17lQxu4txbcbEgah
	NkJdBVZG6dKQdn5zee3FKBRZNoyTbKRDXOd0OgCQCUkg7p0dlFH9AOU84ZCtrh0agBmD2NSL9f5
	DwDIjlzLlr7Di2OnQd3zPsTLh/Ga4RqnOIEb6n/IzYDVD3U0UDrcUrXHu6d+y8Y6CGL4kRxpow7
	Tik9GgRmyJUNAMQDGaft4sbNSMBvV8DB5QQpnqv9e
X-Google-Smtp-Source: AGHT+IFhTFwxRSv8E2GLDX/po2ou7d5z6m3Vj1K82MSazLrjmlphpMDTRRPJFvKoS8p3fmF9jHXehw==
X-Received: by 2002:a17:902:d4c4:b0:23f:9718:85f5 with SMTP id d9443c01a7336-242fc38a2efmr36482365ad.15.1754980354691;
        Mon, 11 Aug 2025 23:32:34 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:f81e:7c91:8fbf:672a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976cbdsm291456165ad.75.2025.08.11.23.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 23:32:34 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Chia-I Wu <olvaffe@gmail.com>
In-Reply-To: <20250610235825.3113075-1-olvaffe@gmail.com>
References: <20250610235825.3113075-1-olvaffe@gmail.com>
Subject: Re: [PATCH] drm/bridge: it6505: select REGMAP_I2C
Message-Id: <175498035196.3219801.9473521709226149034.b4-ty@chromium.org>
Date: Tue, 12 Aug 2025 14:32:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 10 Jun 2025 16:58:25 -0700, Chia-I Wu wrote:
> Fix
> 
>   aarch64-linux-gnu-ld: drivers/gpu/drm/bridge/ite-it6505.o: in function `it6505_i2c_probe':
>   ite-it6505.c:(.text+0x754): undefined reference to `__devm_regmap_init_i2c'
> 
> 

Applied, thanks!

[1/1] drm/bridge: it6505: select REGMAP_I2C
      commit: 21b137f651cf9d981e22d2c60a2a8105f50a6361

Best regards,
-- 
Chen-Yu Tsai <wenst@chromium.org>


