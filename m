Return-Path: <linux-kernel+bounces-805228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93E0B485BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B4B3A606B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C61A2EB87F;
	Mon,  8 Sep 2025 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="d3aEOygd"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906992E92B0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757317146; cv=none; b=gqUF9Pi3zUdDmJ3BIOArlO9hTEGuu37ksigS3Qh6lXZk1D0lTlYpcbZOBNjHelYr3nwih00r0ww1X0xyVuIo9wTJx7nT17iYhrJxVUrPbsrJM81EH7UVP7Oxd/RD+/BZDN6+uTYY0KCAEQfqomYPF4PxGqLL1vwDLTwL647/nO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757317146; c=relaxed/simple;
	bh=4mkikRFBIlnv519piceNvC2q0vRXXnxeCTIIkGspFak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sy0Fcg2qwZbKD28npnhUJu2PbrO7sJW+cGIX+910YepRc9n/gxKhG1w9AQzebDfk7qtF2Y6i4et10zk4yzA2210s4LZQaVATe2ElxE+o18pKtyNlzygT2okMPRMlpygU1qobyV88R6VauYmlLx8k1eATbyERs3FSUP0TZxWxUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=d3aEOygd; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso19509255e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 00:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757317142; x=1757921942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA1N5nJE0Y2B6m6KjWxlCd1B6fND0SNZY3zp3/3Jook=;
        b=d3aEOygdJVNe4z3vFBf8gjuoG/fz4249BUwi+6/6xwnnQ4G5mpXB5UOSCGCYFbstHh
         GaSL7E59+8jxLnRnecQg6syPSMoT5j0nPhcW8Z4dLWyMSnGnrFPL3h327R9glJ50co4J
         Y1l3mtZCkBn7+6A9NvBOD3UZXXlRT5LLRKIRlfYjrRFyM+z42yRLfgXLvI6wLRtK9lHc
         dFYzOgYmf2aYVutjU1rPHaxqn0+djaKiK5wLNF0VfgI1MWxHVOqapmJH9Yg0gOae2GXQ
         eU7sojqxiGUCYFeT9kxRsc7QZoEPk9ptmQOhApLHqawVWFxJAyIz4NU2PUeluTtoXkDR
         yh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757317142; x=1757921942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VA1N5nJE0Y2B6m6KjWxlCd1B6fND0SNZY3zp3/3Jook=;
        b=D0xg/v3a37EoYfiIOCb+SBwNJaAfrCLzVERRzblxUWY4TvOvYkrQQ96DJj+cYYYOMD
         863ENo5+vb5P4igyWGl/tPVLjOICD1lBWwShW10YRuik9qObt1TrqVnXfYeYQlmqlv0j
         zEml2D5bHEL1IRlwKzzUwW2ae8GJvns7lLBY3rSfRqCJ6ElDeIGhZOoFYJyCLZnNhqz4
         VsxJpxXYJSdlGRb8kDhWkr6l3FbjuoTcCwPq3lSDtMRlbvDjUeOAXHBDntdXVKKunwlx
         O4qGV/pXcbPoQ7NXmbNU7cRN+O2LU/Q5axKsDiyga8BM4N6KpapMMjWiOMfKI7OmqxnD
         0zTw==
X-Forwarded-Encrypted: i=1; AJvYcCXG4PZNjcKXHTz474Xubm6ymFg36WxrdKQ5RANo5C91aJcAZE21DawBowdETQMRAh3CNUUcuttQ43jlHtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMqbqqO/UygqfNNA/4jrJLXCjDtQt0JzNg146UNUCZtYi/fcEP
	mYJr+PMnrcyJAfQ8GsVctFYe6d2aYRnTEwY/Gq8NT8b56jukGAAk6Bkk9Ypa4oB2Nww=
X-Gm-Gg: ASbGncutu3zt/Nw3MJWWe8wFbrV4hAKrDgSUbK3BBnG0piyn+nNzk0NRN5DtuHCan08
	i3YDF3EmtjRql80UYv5vkHtYRFiArr8Hw+aICEV5Rnza3Xbb5Iz0mYCOwytF6nd2oBDRfhDQfL3
	bGhB4EMcg3vgruRytawh+eU0YH+aKc1TbBtibd9mxe0xS2GAz5ODtMvC14KDBG5uaO8YS2jxCjt
	/54as8lNmXH4m9DQSQs4VFoUNDX+RmQz23bLio4Z3k2kygtiIIHE/2/4rJUWCdI1zaIm+Cs3IJo
	awDwvux70Cm7DxznVtj54JNYkyI+soXRuAHYrGsQCGLkxi1wbksHYcpGhnyvGUC9lx1d2XsrfoH
	YDSNda5RMu51AZ4Kc/6V9x496L2ODrxwr+1M=
X-Google-Smtp-Source: AGHT+IF1yoHE8XBNSmCWKbccFdvIceSk9MKmYJ3MajrUvEDp0LEWk3b7vAXOa2mkv3XALARmVE71Vg==
X-Received: by 2002:a05:600c:1994:b0:453:6ca:16b1 with SMTP id 5b1f17b1804b1-45dddec8c71mr59299725e9.26.1757317141785;
        Mon, 08 Sep 2025 00:39:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:5cdc:d980:b6fb:1eb3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e92a42asm429977665e9.20.2025.09.08.00.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 00:38:59 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Yinbo Zhu <zhuyinbo@loongson.cn>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Yao Zi <ziyao@disroot.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>
Subject: Re: (subset) [PATCH v3 0/3] Support GPIO controller of Loongson-2K0300 SoC
Date: Mon,  8 Sep 2025 09:38:53 +0200
Message-ID: <175731712490.48218.8429152317469745500.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250904013438.2405-1-ziyao@disroot.org>
References: <20250904013438.2405-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 04 Sep 2025 01:34:35 +0000, Yao Zi wrote:
> This series adds support for Loongson-2K0300's GPIO controller. While
> being mostly identical to previous implementation, its interrupt
> functionality hasn't been implemented in gpio-loongson-64bit.c. PATCH 2
> implements its interrupt support with an IRQCHIP, and the code could be
> reused for other Loongson SoCs with similar interrupt functionality like
> LS2K1500 and LS2K2000.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: gpio: loongson: Document GPIO controller of LS2K0300 SoC
      https://git.kernel.org/brgl/linux/c/084d01a173f5f41afd326b1dfe73085972530ca7
[2/3] gpio: loongson-64bit: Add support for Loongson-2K0300 SoC
      https://git.kernel.org/brgl/linux/c/03c146cb6cd14fdab2d2c7ab1b4e8035b54df8cc

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

