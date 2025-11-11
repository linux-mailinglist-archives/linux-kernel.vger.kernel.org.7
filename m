Return-Path: <linux-kernel+bounces-896233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73204C4FEE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8690D4E40D8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC13352F9D;
	Tue, 11 Nov 2025 21:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJY2PtFK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEZPpJa5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285B232C95D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762898116; cv=none; b=Se1E3BUQD9LsirPos/ECY1iHAJOBPgBXhqUgpo7bnp4Mbp4Vru7EUL2JrcQG9YasD46KMZ9PRNEGlKv2UFoVTUye0VYMOy9PBqM36G3m4nOb1ADnksHQewvUfLxLVmD0AmAChdEO0N4GPTBVl47p1mC1wwAH5I2Mq/eVofeI07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762898116; c=relaxed/simple;
	bh=BqPFFvqH7BoSFpBWYudwxW6uWlGnhLlJiqWls6goZJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pnSr2EKH5qdihnQffqMxSTdd76AKUD8G3rzGDhVHGIYoJ/jrA0wTsew0T8KDQb7K/5/am7otmMlxYBtvS0wcPkYkFjTZIYnErbPleZvMBWW7E6BlYXNmz+YlDTpVFHwDLf3HJqYXR0ZlpoITFhSAFiuXsB6ZUP+ULqzvBqu6IRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJY2PtFK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEZPpJa5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762898114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ewK5P1QfPFXuq8AEptM/4r+//JlhduxVqODFxsi+6HQ=;
	b=VJY2PtFKv4NbJhk4QcxSz+Rj55aUM6lCvr2UBE3+2tEE4ea0bFLQR+KcjFGg10+KzdWGnx
	N+y2xBQixXTHOk8mbjSu2jc2qZrMLfYqgCEq4iyyRtDOmzuf5RSCYGiH7jPTeeJqnB0/to
	prvZyv0hU6ivrdPF04RAidzNgNFslRQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-tB4wTAnPNbi4pyLya2QURA-1; Tue, 11 Nov 2025 16:55:13 -0500
X-MC-Unique: tB4wTAnPNbi4pyLya2QURA-1
X-Mimecast-MFC-AGG-ID: tB4wTAnPNbi4pyLya2QURA_1762898113
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b2657cfcdaso27590485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762898113; x=1763502913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ewK5P1QfPFXuq8AEptM/4r+//JlhduxVqODFxsi+6HQ=;
        b=DEZPpJa5hN8CzmmFBLRmSv341Xq/3biOK0SVMeGaUww/qJovl2T13IFgttoUQ2fs0r
         pY4KxTjf7iCyU7btefwkChLTxEAs83lLzpp1AldwNJsjZrzuV665Bl1IXhwmyDap4QUl
         52HRXZMaMlSFuozQDdDF1szqBn3QiohdhQlqzeVpJMT0RAVUVU1VFQRNrjI3Pm22BwNA
         RQ0+AFmgn8cZI3wt/HqXrAsoBteUhmsSg58QGZHQiYAi8m2w3kY3EjPLadEd3RTus92x
         2OB59bTgPNZYCZFcA1V9yuam3tYcKabt1cl4jLnyR4cKMQt33wzcW0Z2nusjHl6Wucpw
         IOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762898113; x=1763502913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ewK5P1QfPFXuq8AEptM/4r+//JlhduxVqODFxsi+6HQ=;
        b=EPewMd9CDGMRzzZEGzvHHGET6mP4VH2h1DZFIB8190xB3wyOpmlT0xBIPvSRjPnKRC
         QozRiI1uYxqm8zrwcSKGvcOY8/imA2imA1lf+CBgy9gRsnGX8sh80BeUFv9o0ZzE0WnH
         w5jG+pWvyNi5wMPPf40DFEkSqzA5dprWPsbD+IafYMLoSB7PYG3+g7n9jt8EGiGOg6Xg
         jeD9BogWydiChqzTQfpwPCCQDSWMa3OFijpceFurLrM/4Tf/9fmt9nCEKIL0/q+qMcPa
         pbE+hmlVIdXP/dlTtdDXRNnFE+pE0XPcGHcWJ4r2oq0ATS1/gsHNkHNrv0gp11yrJ6BB
         sa6g==
X-Forwarded-Encrypted: i=1; AJvYcCVacRALYFixiQt5Du4AQkNDddQ+cOfZgnYFz8zfFd/Bk/vKSOuirvDvQqXlv2scmFNjWccS7awWXC3uNxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWm9CEykzuzypV1LseFtX68xIaE52+M5LnFZ6o4fVe15uDynJP
	6hyUnize0YHBYDpo7mf5gQ8tBjvvSF1EdxsX6oFzbOH/ba3Omc3dEgY7K74A6IBwwBqpQbC5JJj
	MXOog02WnHXTl9NgP5UeoI11R9KgxcmOPNmrdI93uUeq6NVcx8bbLCDnKlqTaExSIRA==
X-Gm-Gg: ASbGncuDpErtaUi05BkCgwEbzvoocDh2xD8CPVUcpENZb3o2ueSb1ZAGi32/Esv2q7E
	n/+xKJQ0ZDA8BLO0DnumEYEkDHmXfytSXiy12KnqTkMM456iiwnAL29jHriiShQWWBxgESp5Xcp
	DXbzJb6nBWu2x2dr8h+uUHvz+b/bcP8jr78isce4Ap3xkX5OJiHCJAHE3Ym5Co/3PDxcD+Gsbdk
	PAmKD/gyg9gtWYF9drcOZq3uPV277i+23/aVNJK+49h6xlXqjgGaps5vd2DW8Q55nrstIILNtfA
	ruAUJ50P1TPFiRU47taYaMliFVumSS3GjjrEdOpkFyIsNe36qyyRSnXZN1dcGAR7/83b1wsRqKX
	QVPoBjAEqqxdwmV9tKolhPbKpNynEzbM=
X-Received: by 2002:a05:620a:444d:b0:85d:aabb:47d4 with SMTP id af79cd13be357-8b29b7676c2mr114413985a.6.1762898112732;
        Tue, 11 Nov 2025 13:55:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpYrk8J3pc0or2M4yWds8EC3twQQrc0f0pmbdA1sma8+sKJvQpmqvKN6KSF3KtIt1M0Qh7JA==
X-Received: by 2002:a05:620a:444d:b0:85d:aabb:47d4 with SMTP id af79cd13be357-8b29b7676c2mr114411185a.6.1762898112359;
        Tue, 11 Nov 2025 13:55:12 -0800 (PST)
Received: from jkangas-thinkpadp1gen3.rmtuswa.csb ([2601:1c2:4403:8750:d964:d6a9:f204:ed2b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa032fcsm61335085a.49.2025.11.11.13.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:55:12 -0800 (PST)
From: Jared Kangas <jkangas@redhat.com>
Date: Tue, 11 Nov 2025 13:54:12 -0800
Subject: [PATCH 2/2] pinctrl: s32cc: initialize gpio_pin_config::list after
 kmalloc()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-pinctrl-s32cc-alloc-init-v1-2-071b3485b776@redhat.com>
References: <20251111-pinctrl-s32cc-alloc-init-v1-0-071b3485b776@redhat.com>
In-Reply-To: <20251111-pinctrl-s32cc-alloc-init-v1-0-071b3485b776@redhat.com>
To: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 NXP S32 Linux Team <s32@nxp.com>, Chester Lin <chester62515@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jared Kangas <jkangas@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762898106; l=1042;
 i=jkangas@redhat.com; s=20251111; h=from:subject:message-id;
 bh=BqPFFvqH7BoSFpBWYudwxW6uWlGnhLlJiqWls6goZJE=;
 b=Y4qJgOTUpZTA4incmVAXt2PUgh+wZtq/enkv3qwzmo0HKnIZRrIfXvDthp5qizHo6vEg6W89O
 JNcPu+NpNIrBP4dO8SBmGnIkId+Z03EgqR12YXVw1lviBIZBg5Oe3c8
X-Developer-Key: i=jkangas@redhat.com; a=ed25519;
 pk=eFM2Mqcfarb4qox390655bUATO0fG9gwgaw7kGmOEZQ=

s32_pmx_gpio_request_enable() does not initialize the newly-allocated
gpio_pin_config::list before adding it to s32_pinctrl::gpio_configs.
This could result in a linked list corruption.

Initialize the new list_head with INIT_LIST_HEAD() to fix this.

Fixes: fd84aaa8173d ("pinctrl: add NXP S32 SoC family support")
Signed-off-by: Jared Kangas <jkangas@redhat.com>
---
 drivers/pinctrl/nxp/pinctrl-s32cc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index 51ecb8d0fb7e8a203e10cbe965dfec308eaa5f30..35511f83d05603f5374e2d09be4b0843c7d7dc53 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -392,6 +392,7 @@ static int s32_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
 
 	gpio_pin->pin_id = offset;
 	gpio_pin->config = config;
+	INIT_LIST_HEAD(&gpio_pin->list);
 
 	spin_lock_irqsave(&ipctl->gpio_configs_lock, flags);
 	list_add(&gpio_pin->list, &ipctl->gpio_configs);

-- 
2.51.1


