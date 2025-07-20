Return-Path: <linux-kernel+bounces-738414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08B4B0B803
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 21:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57495188B539
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 19:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D033422FE08;
	Sun, 20 Jul 2025 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8F7ju5j"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74428230BC6
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753040360; cv=none; b=P24P95FLJ9PaoPylVqjm5JZwlJ+UgEtdJ+ooB3Yl5KA7UBE05Gc1NEa52wqsXT8ud7gXOFk95d1y3WtjzSWgxejgtb2pEh98FrAxas6br4Oo+m5HC3wn7hfH7osuBwVBKn+XBKALOvVvTbKt+JTelCouJ2ftZHJes+awWT4pYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753040360; c=relaxed/simple;
	bh=pZLfQFK+iDMmtewhGnGO/1SaOgqUaWhiuxkwGFO9BrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx3Rjd0nGymk5e8KJ4dLEy5uqOaEmTKbaC/KIcWnpyhFEr81WdiBp2F+jNYZnm2fwngnVHgB7w/YlqD93yyFMJRHmaAsmfh9I2l2gHnsgzbwznmSvJptESgVpZxDr+4HGVCrUzwicqPhvCddYx556FGwOKDBjyOQCNMOpbvWCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E8F7ju5j; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-40a55314d06so1096419b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753040356; x=1753645156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qmI92MLlIBwFrbUrwXTt/2+OJ1ahYjNp50nlsYvpao=;
        b=E8F7ju5jPsBgq+NLTWbjJBo1YcC8lwER0ZNuqFA7XBH7HBtRqeKDMvy2nIxcc3WlTe
         g6EF1SYLVCtE70FFkGebGztWpHWKFZJ6oSbNUpRP2/xPUeJmWtTujlZY5s+GhYKudEP6
         w3vpbjeWj0Ux4XnSPk4BJKCJgyDGmc88y81dusWy3qAUxsUuZ8qTRkuDetO4Xt2XJkCc
         9BXOInxidoNOY1X5kCR1jjlv/CycQ2XChWUZso+KIYG9QxhuUKG2rxR1bAki7++SvwSi
         Ygf+eg03dS8NMerFdzgFYSNoyXYU4g0iWmNdPAnh4Akkez2j9EtQfH8jFWp9fdm20oVJ
         z/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753040356; x=1753645156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qmI92MLlIBwFrbUrwXTt/2+OJ1ahYjNp50nlsYvpao=;
        b=qHN56T4Zai6dTXIHcsewtb59N+RxPeqzetKWWPk+h0ULU1LEX4n9IAEErHwVPhsOfR
         XMVZ88RqhH7oP88HcdjIDyQnx2/JnPab0ZVBhjrs5LCOTFDuTXBlC0/WsEV63Kmt15zZ
         zWgx+AUhCIWC6DlPSgms2yOtkFxbv9bogscVN0DAz9jTl0ZfSt5s97yHzbKVWtCNAJg5
         bHu8nAm+rDMy14nv+6ucZ1aNWU+j+3PNv/94Nwl9jsXZFIEHrDD/Ej2rLGI7D/Sb6iow
         Y/3XJV5aSXlFPoVZ5zv4ao5Jd8ORqb6JAGzrQJbU/n90QT5D9FcPSP37HA0TPtpEKa02
         YnNw==
X-Forwarded-Encrypted: i=1; AJvYcCXqa5ERGzQv8IFesnnK4C45B01D07c+6r6rXlGSDNUWQM4+UaMQCTiUVvwpAbuHt6xNDi57NNGUayS0Was=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGoUO8EZCTmn8KKDmIMCOkYycftiMJHz1B9GyWpvJd/VLf7z8v
	STstQY9ZzPjEi50nP8CpSGMb7Q3ZydBsmsxwDZDO1qNBeuocGaSnjSIzNMH0tDDqjfM=
X-Gm-Gg: ASbGncsSsTgVihFcByy+RoH3PMwT8W1F3JRRRjBtcNieFw5gfXqxq7i2D1tgc6lyfRn
	9CBxcuJ3UqGWChHnbHqRAKikmwYDDiu2h6UhE3oojpoVIZEnYucK6iV/yxK8llbJUpqYhmcDe1g
	li6LucEE+IACxqdCsZlgQgEVZjjFLy0yCIl8X+51sUoc3iKD/ocq0lI++Y8aid3GfKy2j1GCZ5m
	Gmw3TCKoFGpMKkiN9ObyvExhp41DjE1WhvZGIkLIkIaP9W7AE4C8lxm7ErIiGoPjNrTntsxm7WC
	kRZUgYU9wmHczfSTNd3VoB4nJOGSsEdjHOfr7+WmGdHLI4sXOgRhnfjrgly+IYSmkqSJREWPJgv
	p6S30joZeyOI=
X-Google-Smtp-Source: AGHT+IHdyoPC+reGPO2928s8eY4VkIUqzrYH+Trvh6vGBElbMDvsyr9bGCnwye0zSGLIyzetZNTdGw==
X-Received: by 2002:a05:6808:10c5:b0:3f8:3eeb:1192 with SMTP id 5614622812f47-41f98e4cbc4mr6102894b6e.27.1753040356463;
        Sun, 20 Jul 2025 12:39:16 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1fec])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-41fd19b3e74sm2025039b6e.15.2025.07.20.12.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 12:39:15 -0700 (PDT)
Date: Sun, 20 Jul 2025 14:39:13 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Michal Simek <michal.simek@amd.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 7/7] pinctrl-scmi: remove unused struct member
Message-ID: <27a80ed0-65a3-4a41-994e-9c2d3bb76b54@sabinyo.mountain>
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

The ->nr_pins is not used so delete that.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/pinctrl/pinctrl-scmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-scmi.c b/drivers/pinctrl/pinctrl-scmi.c
index 9a947ced0df7..372fa67589fb 100644
--- a/drivers/pinctrl/pinctrl-scmi.c
+++ b/drivers/pinctrl/pinctrl-scmi.c
@@ -45,7 +45,6 @@ struct scmi_pinctrl {
 	struct pinfunction *functions;
 	unsigned int nr_functions;
 	struct pinctrl_pin_desc *pins;
-	unsigned int nr_pins;
 	struct gpio_chip *gc;
 };
 
-- 
2.47.2


