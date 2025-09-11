Return-Path: <linux-kernel+bounces-811738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE752B52D45
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5A516EBB3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBC42EA47D;
	Thu, 11 Sep 2025 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZILn9q50"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E42E974D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582983; cv=none; b=pn4C8v4/UtlrVH83LV7bjM60ieI9w2qJakZpxr/Cd1UagvZ+OT49QWr85nPt/S7nPZEldaZKL6F/v4tmRb2sIbIddN2LjSVJ8dyMoOAtz1Mc/VOlGz3ihY0KOTolHzkirLvV4rRxuP8zIBaeghia6rttjzsGuYHePhHnLKqHpXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582983; c=relaxed/simple;
	bh=aD+vVYVhj1ox7WHNmXKQS68L0Zye3qkpz4fixE8sgUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K8GXQk9tGPlHojg91k6Sl2kPANCUwWeu2akrqM1XYBUSmW5FW3dLHytG+7NitWX1K5nXy3fuXvu1VmlFIfUH4fWGZ8iwQdoqGHNrot1GUJ/9oSqfVyUebSOmT4aSB5V3vfxOVMS1JSFcQwVFKYxSpT42W7tr8UgIyIVH++g2Bx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZILn9q50; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b9bc2df29so390725e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757582979; x=1758187779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC+hJQkcVSXLbc1lxRNyfmEb4byMZ95qWgYNvEiyn2w=;
        b=ZILn9q505Be7nFGFxpjI1BtMrDCsBqHeLc6shTE5h60vK/24maUDoaYTrGRmPYgUFY
         PW7C/OT/BXMnHWb4yZWkGoj17xM5AlgOQq7dzThfYexegCzo3WlV4KvuKE5diaZqjfqh
         R/Zrb2AMFvLZjjDwlcObmFHCFpVVx2RaCKiF9iun3LfywTqX/kho5/TvSDL3lYhTwas/
         sUSNKHa5iAQHswha1ptUXIOoArZ424o+fgY6RhJKbXkoOVhYndGvoNlOHCTcJS9OR+hq
         8lRAOy7nCNeeQtfr0T7TDrHwK5kdMYRyoPd2rd6w93MJZGqAEUquXVAsofrseNIhi0RF
         +9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582979; x=1758187779;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hC+hJQkcVSXLbc1lxRNyfmEb4byMZ95qWgYNvEiyn2w=;
        b=jfydAW4T4Fx7s3r+RUIszIQU5OmP2gSFi3/kB6CXd+R+UtQXonGLsBveQaxjYivsNc
         UQFV+rEfyE/Y5WqRjr5ys6XLl7r+o3Snl3xpvoTQZmQIfH+WBM2+Bek+WUb7B4sYEdcb
         8sxUxuClfXeDuqDIlUZAmRx37/Yx3KHk0djrZfhj0gi/rB2iCnkD8W1cAn3skvuZAP67
         Uqbhm2rDJBn/veCEZRY2CwisgZg/pZ06ffy6gJpTWxgOa4rCJ23KmXUwAgA/YZp9KvDD
         C9vf0kx5uFuzhCy9wim2QsOBOi7lc2vF1g0lUpz85SSkOg9bSv8DBRcggEm1cRyjef4H
         Xcgw==
X-Gm-Message-State: AOJu0YzDtZPwvefPdZBxIyOu/LijETEqesyp9cKjv/3P/zhu7dJzADZv
	dundkd/HsU/IWuR0Z8zypVP1oqL3h7tVama0ArLyS4bVTYOX526yxFeDFuy5h/L/S7c=
X-Gm-Gg: ASbGncv/t5TO/6H854D+KVnGFUqAz7OVSACFaJHwMHlmzYS6zrVdjBv5XzjSHbdg5Xj
	7JlR58yD7ZFgmRfmehD+mWLZe89mUZpqBZPZem65QGvV9gh+wAb+tvGwjlj+0+r8P9mque5vEzV
	V9TrOiZAgZrRe3G9bFMKnd+io815c0yiMWd6fpg/rUKVZubTOi4gSM5D5NYuUCLbcSSrvjNzILD
	JSKZI4tEh5m6Z3m+Zl7A9R2sf1mfEp+SjtA4xbTm627zLQZ1PfJKwLijKj+N2xiTvgb/thJ9D5T
	Jsi9MSkm2Tv6yt0sIsHL//6duHGxwUFnDZ8K6WnpXAXvPcXRVSCbOJ85vfk14eNiGZvns9dfhhi
	VI15+JyO0zxLazKQFnFBegLjtkHHxlF/6ViwtcbsDhp0DLc0XNQ==
X-Google-Smtp-Source: AGHT+IHLpivrFJJuNi2aFsQowzY2Z21CVbIySOCBNLdn/DehLTyA9Hoq5rzO7sBA4BakWwnpnraSTw==
X-Received: by 2002:a05:600c:37c7:b0:45b:71fc:75cb with SMTP id 5b1f17b1804b1-45e02a94b69mr7953895e9.5.1757582979441;
        Thu, 11 Sep 2025 02:29:39 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d75a0sm1731484f8f.44.2025.09.11.02.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:29:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org
In-Reply-To: <20250908-acpm-pmix-fix-errno-v2-1-bcc537cf3f17@linaro.org>
References: <20250908-acpm-pmix-fix-errno-v2-1-bcc537cf3f17@linaro.org>
Subject: Re: [PATCH v2] firmware: exynos-acpm: fix PMIC returned errno
Message-Id: <175758297808.29372.10913804909854615057.b4-ty@linaro.org>
Date: Thu, 11 Sep 2025 11:29:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 08 Sep 2025 14:02:00 +0000, Tudor Ambarus wrote:
> ACPM PMIC command handlers returned a u8 value when they should
> have returned either zero or negative error codes.
> Translate the APM PMIC errno to linux errno.
> 
> 

Applied, thanks!

[1/1] firmware: exynos-acpm: fix PMIC returned errno
      https://git.kernel.org/krzk/linux/c/1da4cbefed4a2e69ebad81fc9b356cd9b807f380

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


