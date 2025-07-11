Return-Path: <linux-kernel+bounces-727053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E774B0146C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3C0761D88
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D181EE03B;
	Fri, 11 Jul 2025 07:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZC73Vdyu"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046501EB1AA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752218388; cv=none; b=r7jl0M0vhHow6d30qym40EV4kvmd0elfIKPzos9Ue0/sSzr8w6cl7WcpQ9z2tyS49Dcuq5sRXhpVJXUf1Rw/OWmO7+SKeFpJZW7hZodktIFYIIJ1cDUfl2hE+pM4Smko0600QONjSTczowWW4bQHfAir9U0JCp9bNTgP21wYrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752218388; c=relaxed/simple;
	bh=7jC9RNUKCoCgH1rIVJRPYzeCQ9pbHb6UnX4L8SmyRhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWev0hobE6K9hmD5U4Hra2QS5Fm7wFvHal9K0A/4NjwkM/pLSHsTQ/3PV9cyR7mrhPwIal7foSdvDCAUtOOeV7CviGKcdko03dF26sJvH6doDztZwbuXIqzSSeHbF/Vrtkq+WIO2/oZRvgypsxGatgJ2YMIFlbvsbCHzIy/yai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZC73Vdyu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-455e6fb8057so2225135e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752218384; x=1752823184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZVedI7T7ke49tkE3TY9Ypm7IrZSRL9iRdMGglfCLqg=;
        b=ZC73Vdyuk6ndzKaR0958Mu01YSjF7jaCWQ9EvSx4bgtVPjOjF36WRZ8WyZVTFUtOs4
         HzEl7DKinxXCxTU3iAkHmxP0rrrZYu2M4FZIiLfeg0uVAR5lLJrKHcjxqZBdhGPOuWOC
         +FX84CMvJ+zz2GrmECh0eb7q2FCzUeDXCQt2eoWQl01yimVg1BDoZaRRDmgzZ8ELFOLD
         ZgUSaseIK1bMWxHjaFdHrxZwSb75Yp2+lridJXfk95tm0lVGxrPYv0wKqTGhvK8vkDPY
         X11SBTmcLFneZ/qW8oW+cYOdFhd1x2+XYhExQQE51PNmPb7rKI0oAP5tI3Ve6VxZR97P
         qDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752218384; x=1752823184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZVedI7T7ke49tkE3TY9Ypm7IrZSRL9iRdMGglfCLqg=;
        b=wE7zzw03x+mS7tKAX//9ParIOb9v8dV1xj5UDp+yW1y8o1EQ34p4h0bb2JHZ4Pbtdr
         8Omv25ebYbHEhRI/NriwyekAMUnXQ9hNVVOHqMaBKvQ7I6tGr5xTouCtUwrGHnJfwPY2
         JhuDzmcQl+So/vRx/oD76qSAUfe7N4DwCPM8W2ZBsPuKR7ErllnTLsPClY6tEmBF7qit
         IMJZmJFRoflz4oAGS6be1t8UnOPFK4GFBf0LMlTtdhOmtFthdgwu+vbIB+z3+mvt4t+t
         9ckXU8OIVvYeukkqCmxAuiDvHEr1lIPbIaaKz/LKTV7nerhZtftIJJXoRti3iULIEz8M
         ZedQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc/WOXclrUhRonBoOyfoD9kFIMhsyMYXaTQs+g2bQ2MXkV3M+zVk09Bvnn+EufQANREuBRfCKrB3tyur8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8TM4w4R2drpOL56gGu6YQjzIC9v5lDRvzBK4rFxDkzSJTPKl
	KRJnJ90SawZ1kUb0GDL2/LTpZ/QM8Mq9eM5xwzTqTmhO0mHNT4Pk4O1zWZpOiYNkwDA=
X-Gm-Gg: ASbGncs2OivMDPStLcUUJ9BQiSbvtscAYVtdQvL/CnqDsj+UURxgkYZrzZ9RjmrhQ16
	IoK55UY3mX2YFPIbC4ui1jkmkDbQ6ieN7okLImmlyKfVZpM4Z5dtqw0Qp7V0nOsngjOSUpMZmYs
	3PtmtfGuLtH7WwYVGQyY07o8YFON0PcyywUBRn3VbGsX1aoJdmbXqekaUp4bms/46zceqZezGM2
	WLZ49SO6WH/H6U7GBSManRtrrkb3kvhbWRvhKWOdHSQy72babipGYY4b8RT2GCVzfAQ9rqEthl/
	w+axjUC8ziNyPetYwfKW7H3fPerb+8sZEZd5wkUJjvqayrdlgA5n4zf4hLSn0WoOee//HHMokGF
	siP6QNU8NWwN2iQEwid5G4VbjMOn3/6QE
X-Google-Smtp-Source: AGHT+IH5zYIQ+Abjj1HwiX3tECKci1lXtCJaaUK3SCI4dh/Tn6XWzkIpQzd3wlqKGMQfYchsvHjjvQ==
X-Received: by 2002:a05:600d:e:b0:450:d61f:dd45 with SMTP id 5b1f17b1804b1-454e7b603d1mr12934695e9.4.1752218384072;
        Fri, 11 Jul 2025 00:19:44 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:4de1:8724:bdd:326e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e02csm3711184f8f.73.2025.07.11.00.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 00:19:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove bouncing address for Nandor Han
Date: Fri, 11 Jul 2025 09:19:42 +0200
Message-ID: <175221838015.8892.11227120249917200302.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250709071825.16212-1-brgl@bgdev.pl>
References: <20250709071825.16212-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 09 Jul 2025 09:18:24 +0200, Bartosz Golaszewski wrote:
> Nandor's address has been bouncing for some time now. Remove it from
> MAINTAINERS.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: remove bouncing address for Nandor Han
      https://git.kernel.org/brgl/linux/c/edb471108cf1477c44b95e87e8cec261825eb079

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

