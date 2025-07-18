Return-Path: <linux-kernel+bounces-736450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BA3B09D06
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AFC1633B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3394292B24;
	Fri, 18 Jul 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Dlz1dSUU"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590E62192E5
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825377; cv=none; b=lvUbE+hc6XSgRdETi5I2U8UWBWF5aAs/TvHrWsr0UB9vCCwbXqPC7kmhahqOMJI2TTqEy96W9wa06Bjdi4KYB0RIsXfWHn0zk4MIvSZRU+aAeYLdzj95SwCKOzJhms/qNkTReBmnZLumsOZMGlI7rB8QjCdgOut+v/0xlYAXxNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825377; c=relaxed/simple;
	bh=+qkUHJvAEilgpVRYhUfskqT1Bk/EJIdcav8BOc/v64A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQOIJi6fa0AGDtR/63JxZEVj7cxBI2Pn6K4+jCPJwAjmgsS9QngKqDbJNhfOyx2SPCwwvMTSx69UJmw0JeOoeSVYMJeSkx3csIWUR/0GQ+uxiE98DCZWI4D3SE3/Elt5ECKWJt2ukPiZFYf0M6n9ZZD4MTicQhQ2xxUkpR18X3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Dlz1dSUU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45555e3317aso10878735e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825373; x=1753430173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlC/cGH8r/vDF5PDog3srLxzz319gJBwl105Vt+1xkQ=;
        b=Dlz1dSUUMRiJPrUqW83C15ezn4w/jIi9PbhNmUl9NuzOoiyCIEOYf7EGp4KTFWI5Hn
         QCnLiA3bwt8YXuDoFQeiDuMdEfhqUWjca+kABnVrPuVFWKfU8OaYbDu3/BDTwpZ1d/Tq
         iAdEYQqlPHNUZ4/A18leT//RiLz+ROTm7lSm53wMQR2Fq0p4NvscVcchvBBfWveQoib+
         kbsU+UQMRYgc7pC9PBQsknA93nbk4YHotCXq5w8UraFOTt6xcgG9I99RJEXtLTgdyMt9
         o5LIZWtWpdNSNC9/2iVv241QlarXfBDjXl7eXRgxhKSc7K3JVh8zP9obftfEDjLZGAsK
         q6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825373; x=1753430173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlC/cGH8r/vDF5PDog3srLxzz319gJBwl105Vt+1xkQ=;
        b=hvW6anMklM1UXh5qDymuA1vic8RE0+qshlvf5YYeN8O8B6I8oe8UFsrx+eW/W9lQBL
         WF+r5bvDVDpAht7h5/+kTc5p3CUB48O/IftzMACaSs6iHGHfTMBuR3ZaF4qMY3a1AO7X
         gvCpNWXKNZNAmdd8QN+K0SOEzGmmkZF1ECSYDG1B4TnkPLsUcwWpBzzw5Cm81EikXym0
         yJvwjjEVr4kcN3WCqBjwEwTrAbauzePj2V+Bt+yQipT03o4qVb00ioVe3qbzPJyycEJU
         aIiK/KZWhIih10MAPXaQeK6fgZ1LnGnQXSAleo1IS8Pu9W7A3eLqGEglHhEFn0+CBNc5
         Xb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKQh/3flVKFgl/nyWgcoo9oAomJgdaUKzhseevdttJZ7EWR53pVMPvs0M5uMyVcyJsyrry7zOgm61e1Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw684MMV8qExjKZBaDggZaEfAavhzAPB/BRH36Kr4WQ3zV+bjH6
	wywzVoyoP3PC1NXjZbINSIJzkWN/UsXbTc88E2qk1YLa7XjAEnFaIKo2eh/QYg3XqNw=
X-Gm-Gg: ASbGnctVmiBXU4Mm5nDP7jneNo2DTgwTR2+WD3njW5Xjse0an1yk9ifeDsfmJavMrOA
	DqgKXRhTGJrZlrE655w+frYPmX5LvcUw8eWlCZDO/g/LXmMhU1IqZRXmyxbjOIuSxJ92O6qvgz/
	XdfuBg7fdhdtbOEvCpIk0gbmwIB5pYVYUmmiNgYPdeJwcEJIlnikiMRAerILg83fWv2bhU2w52e
	MhAfvPJaEpT848YOzY6V69xriNFj1w/AiYcW77sjcAP42cVNnA0Bw/feh8YYevix7kjQCD3EzFR
	E7r62E+5qXJxwbUYnrM7yw88Xf4BmxpqoRDmxWp0B1o7yR4FfbVVIh3rG7tDCP7YO0kEApYmt+f
	lxb3laAgQKqjaHzBL06W8
X-Google-Smtp-Source: AGHT+IH1H23FhlLxPI6sqqcyCjliClT5k9JiEMs2k853A3AuCQaF/Nt5CiJR08HNe0hbgbDcZi7/Vg==
X-Received: by 2002:a05:6000:2c0a:b0:3b4:9721:2b1b with SMTP id ffacd0b85a97d-3b60e4d1de9mr8619991f8f.9.1752825373425;
        Fri, 18 Jul 2025 00:56:13 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Romain Gantois <romain.gantois@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/2] misc: ti-fpc202: remove unneeded direction check
Date: Fri, 18 Jul 2025 09:55:45 +0200
Message-ID: <175282531507.45055.14440894670985365034.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250717130357.53491-1-brgl@bgdev.pl>
References: <20250717130357.53491-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 17 Jul 2025 15:03:55 +0200, Bartosz Golaszewski wrote:
> As of commit 92ac7de3175e3 ("gpiolib: don't allow setting values on input
> lines"), the GPIO core makes sure values cannot be set on input lines.
> Remove the unnecessary check.
> 
> 

Applied, thanks!

[1/2] misc: ti-fpc202: remove unneeded direction check
      https://git.kernel.org/brgl/linux/c/db7897ad60fd7d7bf471bc1c49e3d01fefadade3
[2/2] misc: ti-fpc202: use new GPIO line value setter callbacks
      https://git.kernel.org/brgl/linux/c/74896eae7e040e1b2a381efc8df0c839023dbf16

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

