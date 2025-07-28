Return-Path: <linux-kernel+bounces-747503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FCCB13493
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7A0162D56
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8613421765B;
	Mon, 28 Jul 2025 06:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Z3CUyjVO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BAB433C8
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 06:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682604; cv=none; b=Xt3j+2fWp+JH4HKTaIpawMwnT5YfdoXQ8/p562Yzmwcb1Vktc7QSOVAqomqvRBSx5iLnv0lh0IvVft+SE6UnLuZZ3KsyyLcXB7hH7gdqXRHqVPa63/efjJG+EnfTWN1HO8tpnjJsMvci1hd9MQW54d8OVFL49bZVPKn9m6JOKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682604; c=relaxed/simple;
	bh=hZugVX8jV0n5hC/gBmsNyGsEMs2lE8m+HXuAH6LDEUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drVR00p8CuuwJPJXzmTygZu+8eO875UJsuc2C5aMY2cfbSkCzhJ0DTIMcmzMkrSI7s+LtIyo2gabhMOEoaXFWrl+z6w39xFFoc5sRsUspvckXqXmxwRIC3PlJxAKpjEjLKwRpdGXK54hbUOenX3hbA3KICXPxP+mEiJmSFqgdeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Z3CUyjVO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so21849525e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 23:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753682600; x=1754287400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W97wUgdwF8oorpiPBfpToOx5VsWhkyXFJ4qbJjKhvg=;
        b=Z3CUyjVOApLt3Navc+rBYwkXi+ah6Qj+uXag/gbQyoazgTyUlZDao8oHo0VJekY5+V
         OQ3tk4qKqPf2TEHa/on6mmnTPFz4yN5zzvkBDzVwM5/lTuGvUNmgYhNjBk3Y/j451C/F
         MMAADVcQKujm6yj+atqivv7SdOhgMgfmjd7g8snBTDlnzQvHXpdVBFZ2sQh+FlDzd5P8
         6u+J3JkEegmxYNDJj5MAysvYXA4sgczllTQMAQUNMHLJt2041JqdxPbytHXU/QZ+cjfc
         f8c/ORGv/c6VuC8aMZoLH5yhMmcw8Ds27uFEgv9nWixgVhB8BHo0KlU3vXHbwIT+PVvB
         MHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682600; x=1754287400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W97wUgdwF8oorpiPBfpToOx5VsWhkyXFJ4qbJjKhvg=;
        b=Y9VxpSEreob2yzpu+y5hKic0N9Ee6N9Q/Ziac0o5zkrQljjeSjYEFttmAZrLeCK4KV
         4Rp+d1D0wsCfHLbqJPwjUxZ+ymaUQm4Tm92t4KNnoJzV5aiCOQ2r/tlLJ+V5Gxwlweec
         ElIexMxv2xqPqiHIPup6Ms3Dvpauuj4/TzfDfV9SX5nsqCzdztu/KoTtRysNa8Ig7nyk
         eVQ0UxYOGuQOwXxqvjPYYIUbVJrz9qYZUkBBWgnYUxCzWceH6LBs4b8txHMHXjvzjJcC
         41MUyjuaQTDQ8q8iaJ4Cj8+KaxbYTiS91SjWMpYvz4OF6pgSdtCNaabT1imFfja+Mgxf
         vqUA==
X-Forwarded-Encrypted: i=1; AJvYcCVXGfuhISuJbizoFTPB88sZJ8S+T8xhCR7FC7lIRSKfEUQRfFVf8lYiutevlpnjHkGaCwYbiY9G01cgiiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHFFqAMxhyaZVpn5f8N8FdRKsMkj56hEWIENtIUt1QiJgiM9rr
	uJa1zt8p56lhQJ8jj98ZhGWJ7c1Bi+FwriQgeuSbWmEUNSnbDKzVQF+qtAPzPO6F72A=
X-Gm-Gg: ASbGnctmoNMwwqwzwdWxd0lUF6yCvKSTVNxHRouyG+55vLDdLec+n74yUvOTuuUNOsx
	VxSCcbIK4ZfF/mlxFBLfsDrajSstDD6e6brHPjgTXgWy3n8C68H1/Godo5LXGlqOXU653Sri5qk
	Voc+c6TzO3zbU3MmsOj+EKh+lLw1vO4RL+6MD6Vg+hrwl0EbDgENn9jdVFuoGSkPWW1aipWiIS8
	qfQm88nQSFo/M2j6v37MrTSAsAI8aqWZPNp4ZzaYMxXzNDW6RPw93PQ7A8mEdibY1YoGKGYd0AP
	ZQFo3cU4ac8jdiYS5XXa54IhUrFVnIynYxt/0xaMBCIvAMDetzMAwSBqpgiA2OeeLxDSfGpIhyM
	0D65DzCaRnHtfe4XlaOjipA==
X-Google-Smtp-Source: AGHT+IH/drgYSj4iGpOuT+QHmeuwlHf6Vte+dqMx32xFOlQl1dtfMuHdz/m4WrGB7xqEWi3zYh2POg==
X-Received: by 2002:a05:600c:a088:b0:456:1608:c807 with SMTP id 5b1f17b1804b1-4588adc3677mr3202025e9.26.1753682600396;
        Sun, 27 Jul 2025 23:03:20 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:53d4:51a:4d68:dac1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587ac661acsm87482765e9.23.2025.07.27.23.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 23:03:19 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: alchemy: gpio: use new GPIO line value setter callbacks for the remaining chips
Date: Mon, 28 Jul 2025 08:03:18 +0200
Message-ID: <175368259509.7029.14692878909582962601.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250727082442.13182-1-brgl@bgdev.pl>
References: <20250727082442.13182-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sun, 27 Jul 2025 10:24:42 +0200, Bartosz Golaszewski wrote:
> Previous commit missed two other places that need converting, it only
> came out in tests on autobuilders now. Convert the rest of the driver.
> 
> 

Applied, thanks!

[1/1] MIPS: alchemy: gpio: use new GPIO line value setter callbacks for the remaining chips
      https://git.kernel.org/brgl/linux/c/6b94bf976f9f9e6d4a6bf3218968a506c049702e

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

