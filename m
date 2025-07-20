Return-Path: <linux-kernel+bounces-738413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5BCB0B801
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0694B1887B67
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C56F225397;
	Sun, 20 Jul 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ScqJlMR6"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2216225A37
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753040354; cv=none; b=o8pAxR2vW+TsfqQuVBwAZZ0fivDups45VQWpYRpk1uBFXSfQhW5nqsoklY355KGJ2d7UATl2Qs3/VkDabII1vNIPxRDqPmdiPgUj3hNV9lWPpFrRurs6b7gLDj/eUfi2hFvwEf68FgPPBVSpiZdzjXquutOWSyvrh1jy9+br5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753040354; c=relaxed/simple;
	bh=4NAzFP3h5a6Z6vaqs42FUh+f1ajE8aZtOY0xrnx7jQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKCFQ1kaYKOg8WgrbvF5xy3/3RrKMQn/QguWDYXBB/GtflS83aC5xlVImjCyKGz9YMyqg5SEVCf90Du8ENOORUcwL2K32UaqAuxFlQSFjNEkytrTStR8v3X2dzDM8f0RPHT0bk2Pc8BTkwD1uYbMfOiNitdE/YiQ6R58PGNE9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ScqJlMR6; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73e8cc38e80so1150404a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753040352; x=1753645152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RgyhAHdNttgB7UCXQ5eGMG7hG2NbXpPfSEfjq5gWiJg=;
        b=ScqJlMR6Q+5uJtK8YRnjvjLE4jn0wnIFDBGsaI6fuydxaNfyBUAA8FU2g611dQSbiI
         EzuWThQZlfvX+e6zB9CcQixx7g9WyW0kLsqHbQm86q5mjq8M5zvyn1c7zEPrl9p/vzvu
         LnqC6zmr+2tQSjq06mBE06p3WWF0Se+Ix1bqV1a8d2fKV4XOV8jgixScmaUVbFB/GvW9
         XB3q38fK3OjB92PCd/wm6bAyhnYMU6Nksdj/EsujrdMkONgsx2Cvqr1A+W+SZEywbFy+
         rUCrNKyRSGTEwNy5mMG3DIuU6KCPCHs0GFCKJ1DSIDvHg8gYEJHs5O1ZhxCg8BRUSjD6
         p8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753040352; x=1753645152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgyhAHdNttgB7UCXQ5eGMG7hG2NbXpPfSEfjq5gWiJg=;
        b=lBoJpxCcvqZpK07fMd6wyM6SD0l9CitZr78V/K4JX9ia2RSTvGP1qlx/LT8liYmumh
         TwdL5hqeQD0+nSvi/hOBoTqqIHUHuksOeAV8p6yH8lnLAgtZZISNUXQfcezZxp/AxadF
         nnJgF+fcxFBZtOpPbFie025hgPDNtUJIXSas1MYiy/fpcFEtfFVap9IrhKpOYvxyyumM
         DjvX/2zo+V3576hOFarfArKi1uHrF33uhTs6422r9EAhA3gwb3qU+vgc9s87nRnKgBiv
         kv3EdYRms53yRt2atp5cM+V55n35s1EuctF4Ct45NNFaU2MBksTgsRtWbsYZPA2c5dnn
         LHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzo/3S05BpziWh4qD6Ehfw3lXGdiiZs7Iu+iHDWbpyfb/esWFENfSVDaJhGLSu348J06DG/kwExOFm5JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbQOSJOChuoXITY1Bg9Wb3o6uHQnGWAsZc5fpvjlMCDjkfp27s
	ZxPOHCbdy50ems1z389MFl7FYEQm0qwSC3VwQYSWLSom2pdNk6L+d93Zn6TemM03ovU=
X-Gm-Gg: ASbGnctf9wJU05+j6CexYWLwB/JeOidP6ZXaiej9+lSGhkO8jnvtECnfdeDXK2Xv54x
	WZuFohrda/9U/thbsgc1k4sj2T2g9k8ZHaLOxkYa1RcpJSRaoie4V2ktu6Tp/6nNdUU8QZMXggs
	wo2D72sHPtO4BSwz2ol4wNQMhjtHnvE8tql5cNGs8sVs8DjXhzNvzsPRjvcAGFDmjhnXkyVnk2Z
	uvywuOpVmZdV77wl5CzTEifgx7/T/78gNh3m3RMS7gmHbJeK0MAKTsJ05rjQrTJHiJx3A22xngm
	8HjW8rWBUKrBYptGjsKAs+dYn4AbkaasXKzPs7MqAuDyj39KWZs3Y7epCko4c/GA1VqZ1ubtER7
	fz5d8ej87b9I=
X-Google-Smtp-Source: AGHT+IHy8h8fAxy3bWPzzT5SaTNbVxExyHntma33sNuNiRQHREjvH7p9NCon9z5dH6T2S3oJqW8IpQ==
X-Received: by 2002:a05:6830:6b4a:b0:73a:d3f6:8b22 with SMTP id 46e09a7af769-73e81090c46mr6599365a34.11.1753040351644;
        Sun, 20 Jul 2025 12:39:11 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-73e8354c8f1sm2296368a34.4.2025.07.20.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 12:39:11 -0700 (PDT)
Date: Sun, 20 Jul 2025 14:39:09 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 5/7] pinctrl: Delete PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS
 support
Message-ID: <bbe178af-62d9-4ac1-b089-09a7ab14d36b@sabinyo.mountain>
References: <cover.1753039612.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753039612.git.dan.carpenter@linaro.org>

The argument for PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS is supposed to
be expressed in terms of ohms.  But the pinctrl-scmi driver was
implementing it the same as PIN_CONFIG_OUTPUT and writing either a
zero or one to the pin.

The SCMI protocol doesn't have an support configuration type so just
delete this code instead of fixing it.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/pinctrl-scmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index d1f2f971cd96..fba0a3a2fc10 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -262,9 +262,6 @@ static int pinctrl_scmi_map_pinconf_type(enum pin_config_param param,
 	case PIN_CONFIG_OUTPUT_ENABLE:
 		*type = SCMI_PIN_OUTPUT_MODE;
 		break;
-	case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS:
-		*type = SCMI_PIN_OUTPUT_VALUE;
-		break;
 	case PIN_CONFIG_POWER_SOURCE:
 		*type = SCMI_PIN_POWER_SOURCE;
 		break;
-- 
2.47.2


