Return-Path: <linux-kernel+bounces-888748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B83FBC3BD24
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4F8A503EC4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC3B32E74C;
	Thu,  6 Nov 2025 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OeRC5w/9"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE522DFA4
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439792; cv=none; b=hCiPUkpFW94MJlvh1dCt7DsKWv7KZIFSh6LIDI6EgoRZQc+cI7TttdRKn+hmm68v6kiIZK1NyGJ/GaLYSDzYl9YqgaoUoHQS82Dm0FkFeGmJORuQ2cTVV3Z8a0GQC4dFCG1dcDNXQNF0YBeTVbPpbTP8DdL34ijPAq+vA+S0ZsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439792; c=relaxed/simple;
	bh=cgh3Vak6zP+Xb4sZcHY+bd8yHXC0q2hAbj8FIzk6Pjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6s3jRsZrhPlh+Rx2uTpDPon4S/45w8uEVshKU0kRWiPU1LMRDFMWzEvpQ5/J/d7LRa7L8LBsGlCyl34V842qaq8sl6mOEBYptVJHxZ2f+YxQM6qprxJFI65GvPJQLEKL7QpeDlnv3oMIhtQ+you8GmbIuzLg3ymllhxcYB3/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OeRC5w/9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4711810948aso7547035e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762439789; x=1763044589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2hlP/g32u7s3LyR5M2MyElNtRyiD5b8iMgapRQ0QHFA=;
        b=OeRC5w/9lfQiCXJrya4rOHkKGsGvk/D+X8yLEphrLRzQdHkfEAvYxT3+d9IsqUFDYF
         Rtj269jeyix9RWmIzVExzsK3GdjUhlLcZDDkwSPeKbP/lF1wj69CGUSHm2xmxUFpL1r8
         G2jrK2xyqHdNw+9r5HM/aXD3ljmvRllIPcz4gxBeosd1hvbi4i5FPkLRFI3pDr39nHvC
         0FGraEP4C3/jr8W5VBIt6zvTFh8yNISDswYENK2DUqTloN/7OitMMyGCbSmWT0NQm+1v
         2NESm6vk4peLIf3pgi/NK90HEOVyekkfDIgeQWgIbgXO/9CEpnMvhx0Z9/rqfyBEcqUm
         E6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762439789; x=1763044589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2hlP/g32u7s3LyR5M2MyElNtRyiD5b8iMgapRQ0QHFA=;
        b=ND9Nx6sSPRrJ4EQ1US5wl+wNFZQTmVjiLoOx3emJo1q29ZK6Gnj9edRfY4BRIodYf+
         qxSwZKXQlLmzCB+URrcE3WNEzmhDepp+IJZ80U3qXLU5Q7EzEGuLJ4WFLmO9Ji3nkknW
         Y/kvOPaIbAmasbjE8ZKbLR871Ydh+bFoXGadtUeJjFH07rJyjEj4Rfevg8rcuzgqueSD
         PaRG7xUfXMqBcMrJkUM1sdxlsqZ0aRLljomWyuJ+k+ZukrU4QbvLcSpJkGOgtlLyz38E
         /7aI25TFjC+9Atb3a8JbcjlfZgD/xAMZ/P2Vy9BOvAxSeTgALX4isiYIflb4C5cT/+AS
         kovA==
X-Forwarded-Encrypted: i=1; AJvYcCWbCHJlZ1hmGSFd3HxcYbTHgdVZUX42PouCZm4upKJ2Bbo4qZjMB+eAzq04EvfU5MK8qKJbjhmt4jaCoHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx8JCBq/OGUrygDECAdj3cW2lQ5mTpJxszNav+xfMI/+xqXSMu
	Mpu/zjezRMzOXhdIXcvXYf/Ek44EI8FWxGeKXyk4Wprr0YpP0sK2uJV6n6dtP8eQ1m8=
X-Gm-Gg: ASbGncvkLKnrYdLiKuIABUe2vG0prtg2Kb8JaLG3Z6Arc99zrjTEVdhmPx3+gBzsj6y
	uRxuExM8q/hGyU78kqDcn50OBJKU4J+SAFZKXp0/c9ZgXf19BpAojh3d1I5tEHMeI92PxM3ieTu
	oTcsO7HU5IBBQTu850hAnY9+sR0H5wSTUQyEdr4MKbHX5W4wupKPZGFhShBqLcdwmX2tiUA7HGH
	exIbbb/VYkax/Q8Z11ms3ffWirn4CERIC4gVZT+vKdklSeAmAAT34VqcdJJn8qwjEIaHEAj1L9y
	0EKP4yf4sGUt/LuZ1oo6jsVUegU8hvKMQysOdZwvuGRfLCrcWgM+9IuYYnFtx+2NGNi01xkgHlo
	sZJZ1dJha7Oqm64woBlFFmGGIZaUwaUOwTTVewnLynR+Pyq57+3oHSLc0XDP3Zi3lPBGtXsXflo
	Cx1SA/FgYIYFIHhCsSzji32MejXODvLPCm5V9eClwB
X-Google-Smtp-Source: AGHT+IH0S/6NocUvBBvhVFlXalk6vfmsVEte/Abd8sUlhELu8RQVK9rbCvig9oqcdCFDI4RBgNCyBg==
X-Received: by 2002:a05:600c:37c6:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-4775cdbf0eamr51383005e9.9.1762439788723;
        Thu, 06 Nov 2025 06:36:28 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce2cde0sm112185495e9.15.2025.11.06.06.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:36:28 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	p.zabel@pengutronix.de,
	yoshihiro.shimoda.uh@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	kuninori.morimoto.gx@renesas.com,
	geert+renesas@glider.be
Cc: claudiu.beznea@tuxon.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/4] usb: host: renesas: Handle reset signals on suspend/resume
Date: Thu,  6 Nov 2025 16:36:21 +0200
Message-ID: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series adds handling of reset signals during suspend and resume.
This is necessary for the Renesas RZ/G3S SoC, which has a power-saving
mode that turns off power to most SoC components (including USB).
The reset signals need to be configured accordingly during
suspend and resume.

In addition, a cleanup patch (1/4) has been included.

Thank you,
Claudiu

Claudiu Beznea (4):
  usb: host: Do not check priv->clks[clk]
  usb: host: ehci-platform: Call reset assert/deassert on suspend/resume
  usb: host: ohci-platform: Call reset assert/deassert on suspend/resume
  usb: renesas_usbhs: Assert/de-assert reset signal on suspend/resume

 drivers/usb/host/ehci-platform.c   | 25 +++++++++++++++++----
 drivers/usb/host/ohci-platform.c   | 24 ++++++++++++++++----
 drivers/usb/renesas_usbhs/common.c | 35 ++++++++++++++++++++++--------
 3 files changed, 67 insertions(+), 17 deletions(-)

-- 
2.43.0


