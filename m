Return-Path: <linux-kernel+bounces-877897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B33DC1F4AA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBB9404F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B14E34028F;
	Thu, 30 Oct 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="F6hQ3jA6"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1D327219
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816528; cv=none; b=NTRmWyfDCU11llY/VpR+6WWPyLdmew4ZbVdZAccmFm6wtwcysFG1yrPDq02g7vyHwI8KLjoC282mCyZqoASoPRWT1s1MZytiinJr1MnL4UgLM0bb/X/cqGToc5sLO/3URmFagBHZt3RhoZiGShjFPbbjuVsxY7TvTgBKfquWQTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816528; c=relaxed/simple;
	bh=vIAW4Zwu/W6Q8q359FT7FGmmqecIKjR30/9fruhsdh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uKhLsQoO3fFcD/abQF7WGkTgWGTLRSjuEd2fsxrpGp0Mid0oQFbubnJ36+3gVzwSAiSSMbfFhrCbFU5U1RCuM6lRDA9RXjFQyJmE8sCDSECM9PCboPvMm1OgWYa405l1ljIofU7b/iVUe34OpTSTtsU3hJi7GOR/Xoti37zUzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=F6hQ3jA6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so639120f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761816523; x=1762421323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlMCS8zFdkhzxHQpidU95re9+f+f/wicSl76SjrRjFY=;
        b=F6hQ3jA6hRpSwkwQ74K5DvPM5Y48+KqU/4HmnzwujGbZw4nmoxU4DCxYKzIuRHidnY
         pDMIhF5n4I0h7deP32V1pWbEh2oZ9PC/9H1xy4Jhr4hYGQ31r904C88t+F7n7MA8ifCU
         xmeN+gM+j2AOmVIb1iXsN6U5bXcQ807wU/rMKcFoEKHQnKDwOphEBaYJQBN0uuzEN2yq
         cLl/t7qxrkg02QN6c5Jq7uOrVpDhjtIEdTsxkfW83enklwSqi426S7zH8dIeq1UOJF81
         dJ5tfW40vWg2cw8h4MP4vhKmGN0s60Aiqa6zYI8JBb91FccSF6+yw0v3AA6gF64bSCGk
         tq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761816523; x=1762421323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QlMCS8zFdkhzxHQpidU95re9+f+f/wicSl76SjrRjFY=;
        b=wnCswH4JiibIGc3fUyTplt5z/1l11/OcbLY+JYLYhLVjp9HD7R7owVEtYgk1qvb4el
         wvy+5xO8lHUmiYqbmrCIvtF6WxwU7ZDegRZtTPPeDfCOoLzUSjOXJuZsGBRX+qzqbEvJ
         v0ntmib4xNUDfYq5OYOvMDjhOrK0WL7Prdhmd2t1ylTeSBFu3+66Mc7LnqO339s6L5PH
         5oyDvDzIKY/EOMqdlJbr+pCjW4Cm6/O/zie50/35jF9gS9xQvjHHjc5nSqgsqneb0suW
         1rfwVPxZIWdsx36YDMsgzRpzXSOjkzWcibmGoz/vEoCpR1tjhsiNGguHt3wVcEU/b35Z
         GCZw==
X-Forwarded-Encrypted: i=1; AJvYcCX1X8niF7GgxymionBSK90No+VWFNRFM3KouTb4XcjuRPGi0bM8AFg8/u61d2ZS3CESNDUwcFGBY+4XzC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz89DTjW8Lpkh3IvomR2KKJYIOG+FJLU2/gfAipI3mZcQXbd7c
	lWaTfhujJxyMbuJYn0WB/7kpA6nqRcbxCKRTQBeV9wf+E53V0KBKqVEZ0+WEn5ohcFCcCnnAFRh
	4YWcKCvk=
X-Gm-Gg: ASbGncuTCSXtzKebsL3NteKIYbI1f+g9FY6+ysjOiA0iqjMmSQQGL9IHCuhvHQHgQCc
	gTFtYT2JJJYCwZb37+79CM2BloVP8yhMj4FmcZT/dr7fctsI/1ztIqcHu9Wt2bX6oWwuS5/ZNDO
	wJaZs3557Ytu7a1yWIEHHwRDGpi2hWP5UKl4xM9DHYFbfo9PwCztxX1KH4Saf920DXBMJCjrauO
	2wbatw4NXs8/SCj3WNcvF36s/X8QW+l2iN6rzCPoJe09bTtrNwbaLA/TMKk2aNw2iQ3G8KlMyZv
	6vxIzIpGL/+RFIljXFRqUpx/jWqYi5y8VexxQLxMzuUpUSzQbsOr/9biP9XzPvwHxYyOmixmGKP
	l+U0sSj1Ieogdt6Z/EHeQ6QCdK1msUJNYC5NNQdJNslEZtp9vlC+AcXK/e9GDolFKy3EVSumnHB
	Xmhm87
X-Google-Smtp-Source: AGHT+IGlvzC6Q1tht+J5f7b6Br8g6viF2wvjUGhpKtoD8qbOydQjRzdpkyGa16FvgoLIO8huegHYQA==
X-Received: by 2002:a05:6000:178c:b0:3ee:1233:4681 with SMTP id ffacd0b85a97d-429aef828edmr4959897f8f.23.1761816523017;
        Thu, 30 Oct 2025 02:28:43 -0700 (PDT)
Received: from brgl-uxlite ([2a01:cb1d:dc:7e00:4de0:1456:94e9:3a3b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm31524134f8f.21.2025.10.30.02.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:28:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] gpio: mmio: further refactoring
Date: Thu, 30 Oct 2025 10:28:37 +0100
Message-ID: <176181651569.78037.7678074832123587651.b4-ty@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027-gpio-mmio-refactor-v1-0-b0de7cd5a4b9@linaro.org>
References: <20251027-gpio-mmio-refactor-v1-0-b0de7cd5a4b9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 27 Oct 2025 14:48:01 +0100, Bartosz Golaszewski wrote:
> After the big conversion to the new generic GPIO chip API, let's further
> refactor the gpio-mmio module by using lock-guards and dropping the -
> now obsolete - "bgpio" prefix.
> 
> 

Applied, thanks!

[1/2] gpio: mmio: use lock guards
      https://git.kernel.org/brgl/linux/c/7e061b462b3d43a1f85519f5aebdc77cbbe648c0
[2/2] gpio: mmio: drop the "bgpio" prefix
      https://git.kernel.org/brgl/linux/c/13172171f5c44df67e8882d983fb50d9b27477ad

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

