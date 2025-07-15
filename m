Return-Path: <linux-kernel+bounces-732060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8A1B06185
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB015C130B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A9C1EFF96;
	Tue, 15 Jul 2025 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="X2NjWf0T"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDEE1E98E6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589795; cv=none; b=eSQVAfmY4g5AdfToU7C3p6xvJ36tquGe/LzvSdBEoxenr+kdlEknNhQUYKQvwSzk1W87Uxwf4g/mmgkHlrE5FT45FEieRUvSosZG7cO0IkGLccoYFF+j6sFzON4Yo1kOuHZffUkk/gxoQ+AgriPMzMc2RCUL9zvhWM36XlyshE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589795; c=relaxed/simple;
	bh=zWAaEL2JzeYsL13AYlJ8q46U97iP3YuD+h6PLZaJO2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r49uRVSRMhaTDUEvCLBeSv2iIODrFHG6EpokBuFpYbzqzGWsQv7CB/Q+iOrcuI/FDnbxcSixUuS6cksrk/kyThgWWQs/a/2vlobp/mc6u27ahd7cHbuvBfabODw5vUDUFRZap0kqDxGRwwZ69/mBLEj31UuXle8emqjKkiCV/2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=X2NjWf0T; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso5326410f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752589790; x=1753194590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaCO1i2HMoUVQ2obL9JJgr4t9a4dYHoNbtH4QyB3txg=;
        b=X2NjWf0TuPkNFeLgKZpPbt8dBrqQPGhnoR6Q/hsgLBiQCBQhKu1R6Zy9hFtg2Gmhkd
         9NLvKTqsFhCZSJVdCmzvsCIpjJ4/39JagA9X+nF/58pK5Goitv9NKMNECiysHA1QIfN5
         4jG5J9hMwgJuxL9RVg0ZlAwC6vgcaqWkQn7wLIvPOvuzC7eZBIAyz0y9rqQFE+C1eN4B
         3nvf3a9so/+jvPy7cZKUvrI6Hhaw2pFPDQdc+FiJwFXThNSGq87o/CF5HaA6bIsTyoY6
         O+j4BPW4KXC4MaVCFsW/XEU/Xc/OFzUYLKUhmMQ7HL85byDnAnIlwXmc49RpcZSd3+Ks
         yXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589790; x=1753194590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaCO1i2HMoUVQ2obL9JJgr4t9a4dYHoNbtH4QyB3txg=;
        b=T7cYwmDDp5CLX+3QtRTgzkpDwGODue/S1eg0/8pBvfcr3QPnkgZnE3uz0FEwwAmDJW
         DtxyRfN7Jic8aaHvAa11qXcf04hsxeNtVP+vrXbjMduJf/szvrJLp91FI1eeEObTccV8
         k95mxe71y3SzQb6aNFzI+DBqOUzpuR+I7Ze/pOXrdsXUuthBLpAq+wujtwUwAnOlBJGK
         FBIzlUwe1d2jA+CIV49SpMXsWYYMfosqiaQlBKqZqhVXrClNSe+eC3pkhRT8NCIxTJol
         F1x+6WvhA6Xf/k/iYneYunFGWm321LOs8dzfZ9epowNPOPT6YYuCI4rA3JT50N/hat8S
         qk+w==
X-Forwarded-Encrypted: i=1; AJvYcCXteZygCePhBm6K4aj0kiAkHeETlhIMxTkJeCIdLDhAcK51V3VckAOHKaraI6DaYMp81rRE4aXsYFJ6aZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJnezlofojFNMlzKFTWcgxo7vFqcHvFhEl4xnWcvWoaWzkXVNV
	FwCOSXR3NuHHZq7jT/OaSwN+QORULwWzkDphXUxpGPZX8rgmG+CjzolKUQimGqbO6qM=
X-Gm-Gg: ASbGncu3xqhKjWeY6kUFojjaTplpCmEMQjQGp4VhWnDGaeDVtCzoRkQQRPevU2kzhap
	D0dJYmXsaAgDWLSTgr2nhGzfy7maW3JBIwSa1v4KDIa5NYeZFvr/oZGNGUDsVkoCbNC9ViKgRFG
	zmmU/Kx6IBrQpnE71XqXJ+o8+p/Cbc0oIib4CiTKFWJYQAzu4wRJzi2Ru+UEF9ckcdJ3CgbxsHk
	qX172jeKKfkBJO10G82MPbtXaBwkG1B/Izd5CbjwbWSW+v6DlATS0gbS+bziQHXnYxIg5sO/tNw
	d4v2bndKgy90s8bZcCxMMvud3XwqmK1Wg9jnSzQQtg3Xg1nPUUdNhqk99R8ZQ3WQPth2+4WBZNa
	BuAxCIj8DpxLSYlZknSpdd0w=
X-Google-Smtp-Source: AGHT+IG+pbfHokdo3TaJ16zifD4swF4fUN4KhF43m51PEbV24kQ3tkZ0HUMR5PbjtEK1JA+TtM0XtA==
X-Received: by 2002:a05:6000:18a2:b0:3b6:936:976c with SMTP id ffacd0b85a97d-3b60a155f0emr2276454f8f.17.1752589790182;
        Tue, 15 Jul 2025 07:29:50 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5631:db97:f06d:3c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26f45sm15447531f8f.92.2025.07.15.07.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 07:29:49 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Hugo Villeneuve <hugo@hugovil.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpio: pca953x: use regmap_update_bits() to improve efficiency
Date: Tue, 15 Jul 2025 16:29:48 +0200
Message-ID: <175258978660.65843.2188692091974545508.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714133730.6353-1-hugo@hugovil.com>
References: <20250714133730.6353-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 09:37:30 -0400, Hugo Villeneuve wrote:
> Using regmap_update_bits() allows to reduce the number of I2C transfers
> when updating bits that haven't changed on non-volatile registers.
> 
> For example on a PCAL6416, when changing a GPIO direction from input to
> output, the number of I2C transfers can be reduced from 4 to just 1 if
> the pull resistors configuration hasn't changed and the output value
> is the same as before.
> 
> [...]

Applied, thanks!

[1/1] gpio: pca953x: use regmap_update_bits() to improve efficiency
      https://git.kernel.org/brgl/linux/c/2aa8ccab5ae67281e4d3660f8d9ee68d8b76fcef

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

