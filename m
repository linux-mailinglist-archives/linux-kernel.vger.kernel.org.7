Return-Path: <linux-kernel+bounces-723861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07090AFEB85
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F7E7B9570
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFBD2E0919;
	Wed,  9 Jul 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cGcOpINC"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DC276025
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070579; cv=none; b=LW74iIMFbQbng1CYo7maiC39I8dJKg6tc8Az+4MahBCh2JGXNtbIpXxW6nMazOuDrTTQzpMMqv3kgGpn30CxdqNSkqX8WixRO/qqCneiXw+v2abNjW7CaMLqelbQUw6170oDsgNM7EK/jnZc5sEDS6XzOcGI+CkzNqT0ivRv2rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070579; c=relaxed/simple;
	bh=bCzRN8S3TCHRxDuy4CwuHetr2WFx4Yi7nSwZiTDU7Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5843rr5V9dpZewVHaKlseJ6fTCmdQAL8VTr6KnBd4n02bq5+oM9McApZCYPWzsZ/dxEX8mY/mTI+YIAiaPFOcgT394KqcTSsL5aSfTffuXlknmzGoJkJo5Jq5h7600abtDDqxIQu/S3TWMIkgZoSCzz+NRUZ+khOopCQJv7cIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cGcOpINC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso61232295e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752070574; x=1752675374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7fTZikOujWiw19ywzSbP03LTsL+RF/3zlbom3UqZwY=;
        b=cGcOpINCBOHe21pcOOWIZQHwyX2+MOMnqCtibGQij5uRl2DaOKuLSA3SzpTcXJnq6F
         unbuhaeNwQNDi2Z5Yl9X7bj/wrt3rpf61cWLvNWH4Pnm71tJ79gN81NIsZZSDJGAioKi
         wqau9lBnqa7mM5ewJ1k0+EcHB3ZNLQEN1jkEY8Lg8Y9dukpreF5u9DMJnp7mdj2KTn4P
         zKOXqXXhUOudZgzsEiZjyqdcnNUpbeitucRuHzT2o0Cm8ArvTiyGMbCthPiIjm/ZlDwN
         OvN17gR6yDjuJO5cYrOd3Z73J7BnFlETDbwQd1RGbZo3uKzPrUpZG3q6kupmO9xkLg0n
         f8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070574; x=1752675374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7fTZikOujWiw19ywzSbP03LTsL+RF/3zlbom3UqZwY=;
        b=o7LtZTLxZjaa5Dci/wJk07O8YRoSjVmryUCtGtfMBKjT53sTdakqz2Cno7xqUzZSht
         EbspiN5L7YJ2x8ipDC+oPagpCCLUbdt+/DWjnuvSL2VJyZ6t+DlCwhkeSeBf4IKY9iLD
         z5sGS1CHplHl3C5KePX7KEGdd8Q945lvvTkVfq9DdBKzFlVp1sUO0zA0FR7ZAh46DSv3
         3MK1Q3DZzDTYGl+Fm1jCJwJV7QF6Sn6VDYhPtfcNeZ+7ldV8x+xQhI2vrLCdCcW/joTI
         jkmdruJn+jSYrxxJAjSlVg5YzPjh86XddgVzruOznGb6MOnN5tOseYjjCzlDNDE3Cn6d
         kbVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoRalOyVGBXMjTqv1FWItd7PPS3Sj+wwkjJ4DIqq87aYGecN7WJZ39Io8KRdVMbP1wmRtVR1ZD8XD50SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvY2uNZxqQsW3zPiHAElAjLGylAdhEqJdMSIRhiobhaT1Dq0u
	7n76wYnL3BiMdN8PSbWtwZNzNsBrEOdWGwCRC3snHb/VkHWANjKv8Ic3WwkeSCgOkNKUTHX5gWd
	W7/PE3Fk=
X-Gm-Gg: ASbGncuOJfjP4Tf7NBqkGAPAApJDKivShwc/k51SeR+VK3trcJgsq+WrJg+lLxhCMn8
	SpfcnfDJpx9dxOlp2acMW9Isk6cWr8t4nNiGyT5g9lnDrgW+CuHnxVYzwSKsxou78R/f+tFbM6L
	2Hf97MGj8y7txLD6y60s+Y/X2MdBtFCz723aZJvYnURZ87mFaTfA7+UFF/WVP20VJmh5dGHuua+
	NqJlqqLQziqmEeM+hDGE6x3XdxwIb5vqYkhrK3/NE62hkvHAODu/r5eKhAyaqIU4iyd4l999lfh
	NwrdWPU3nso0vo0S0ozuiDZcTWivU649n1AArWP+6TmGavS5qiYKc3WekG38Xw4=
X-Google-Smtp-Source: AGHT+IE9xU0GYH+akZYYqsxYhGGNtV2upbElAuXDfPacu28ln78ZHeuNA3FnnHkhTjkuDg6yqizWdg==
X-Received: by 2002:a05:600c:4ed1:b0:441:a715:664a with SMTP id 5b1f17b1804b1-454d53a0702mr24546265e9.20.1752070574163;
        Wed, 09 Jul 2025 07:16:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:b04e:cfc4:3bd9:6180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d511b43csm24218865e9.37.2025.07.09.07.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:16:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] gpiolib: of: Initialize variable
Date: Wed,  9 Jul 2025 16:16:12 +0200
Message-ID: <175207046834.40307.8526281080348815423.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250708083829.658051-1-alexander.stein@ew.tq-group.com>
References: <20250708083829.658051-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Tue, 08 Jul 2025 10:38:29 +0200, Alexander Stein wrote:
> of_flags is passed down to GPIO chip's xlate function, so ensure this one
> is properly initialized.
> 
> 

Yeah, looks like it's a bad idea to pass an uninitialized variable several
levels up the stack. I improved the commit message a bit and queued it for
fixes. It has always been like this so there isn't really a Fixes tag.

[1/1] gpiolib: of: Initialize variable
      https://git.kernel.org/brgl/linux/c/d563e7f95c933816efe531c3a48e22bc099c0f55

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

