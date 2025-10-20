Return-Path: <linux-kernel+bounces-860574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A76EBF0713
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5743B21E5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53DA227EB9;
	Mon, 20 Oct 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2nyImVn"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4820F1FDA92
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954907; cv=none; b=PTGTKzO+g/njdA+3gaosFIHHhOwqqXgdmf/ZrynnlMEbO6Y4nTuBmV1r43fJifo0qAAS1zA7wxpSB4gzchf6gSIutqicORmPS1xIi1J6KQA+5XpRBmdkDytKyQZ2arl/R2T6geuGEe7/09+e9qxuznbUU+03YBfc3qfbSJ2Y2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954907; c=relaxed/simple;
	bh=oA2ElgPBvOiCxkFvL8m89chK28aoV4jvlA52sYjC9wU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FfK5H1zHEkgR008GZnAozhc3W1jQcf7KU3+nROY24NegGqKlEAbd2sZnb7qIBPhLxvCSLgch+v67YBEqU487Op+KP2fimwt20n2XGV5gOb6pKv5LeEUR3kYcS8Tke86FhbaguMCrxvBqwQKpV9pWeIlxLI8zHo9w1pu96oYNuHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s2nyImVn; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6a29291cebso11600666b.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760954902; x=1761559702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAIc6gY01YpxCcQ99z0flPHCre83HKOO57mvnvOjC0A=;
        b=s2nyImVnD280TQWWzMQhsaEhSTJOIZze/ISy76ApAXDn4lm3FSUvjTjmOWThR80Kry
         wwhwxkpafIjYpJHnYXSK1l9nokAADg3ogmQLoAb1Jxzzxr+4ZuaXQzZpZVseidIDR61I
         VsgkzR+NPF9+pjjvI3G67kTIEKwqPurn4m6pElsqi6MEV3ej/zQGIgoEVLIf3tGW5hyF
         kqWRZcu7oyhebTZcLQkScpJg+JAigoH1pY0p5LksLly/6SoFau3n2rWMVTZNUUg3oZOQ
         T3JRvmFbgeE0hgQffk+db81PF039m0OfC9P31cFpQa0Ukw/56EhrHoebjCay765ueeNl
         FBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954902; x=1761559702;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAIc6gY01YpxCcQ99z0flPHCre83HKOO57mvnvOjC0A=;
        b=um44a+XpJ1h0ZDXxEVgwl2rJdcUu7G/6Uhvhk5+tCaDjz9ZzLlIZVIhtDrr464q+v1
         O7ZLu5kiD2Ro5iBccIZtm3UHj33U5LJjbPAI3CFb9YE8w04Mi0tXOcs1IiIcJHY4rebH
         tuYFi2Myw0Qsv9hbz9CqXaD4iA63HZ1cN425Ivjj8EVJ0IjckZIc6dJDLx1PtLGk+SA8
         UAmy2VJsqMkq7V8F4KZvdyPy/yx0e7E59NLa64gjwF/8ajTCLcWjzgecbnP7cVfqrEyT
         ErMHmAH8lLbvKuyq1kGwoOx6PnAu9d/Vma7fv1MlRRQGsZUg/roaSzPqhzmBaaF7BM3h
         xzHA==
X-Forwarded-Encrypted: i=1; AJvYcCVsGx3oVwmVUmbRcVH6Yytw+gOGVjkfDD9/OBO8LOum5Ca8/t/J20f3Q5nlhyNT4dh8drhhH5riFZ9gcUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+2Odqvs+dsAM7WRvwMHd5CCyu1QAr2qbj9qVC7sgO/lfRkf0C
	DGY3QyrNp+MC5UUIolyy7wlW5llYQz7MU4Z9Yc9RGMsE7p672M6pkl0wjrcET7jmGLw=
X-Gm-Gg: ASbGncvq2k8EFXxIxHJJQ5oUcbx0lIT055kQN1uXr7boXOYBu/1T2wcnxw2kplRxy0t
	8wnWP+A4XK+y338OD+RbSRA5BgypQZ7rvJPSvuyxxPXkBGaQggN7qYtV0z4Snh34LBcH28ByGyu
	wZocHeKngwTlGrPE4nFeIdF+/7xrMR8oAuOzwkJ+xr0KFQPImz3fVtbEkpQpDdu8/GqOuZf5vMy
	HU+Jn9DWWMgMO5InYMNnbExaS9akOv3xKZfVVd2cDZ0S0tiIcBblLPtp11+33cZhORHMwwm6I3Q
	aPQv+Og1JzUEkUujhKBIxtB74TnApUy8G/0Xfj6jykk+QH4I+O7jWNCbuVzqzaS1yoX4o8MO3qU
	+ngGTAGlIO9ZeVIQFmgq2DDEp6HxXAkcZHayqS8Btk8tm1GNfuRcfXP516PkRwJ3tqo4K9tAozZ
	zXwJ5ambEZZxek9NzJ
X-Google-Smtp-Source: AGHT+IGbEPDs6ivtDg6VzwLTuv9vaft0NZuSPujUXbh434PC4DZqXM9ezasAKoGltsR6KlNX0oCeaA==
X-Received: by 2002:a17:906:9c83:b0:b3e:c7d5:4cb9 with SMTP id a640c23a62f3a-b647395aab0mr801507466b.5.1760954902572;
        Mon, 20 Oct 2025 03:08:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da33dcsm753414466b.12.2025.10.20.03.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:08:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251010-power-domains-dt-bindings-soc-samsung-exynos-sysreg-v2-1-552f5787a3f3@linaro.org>
References: <20251010-power-domains-dt-bindings-soc-samsung-exynos-sysreg-v2-1-552f5787a3f3@linaro.org>
Subject: Re: (subset) [PATCH v2] dt-bindings: soc: samsung: exynos-sysreg:
 add power-domains
Message-Id: <176095490095.45974.5198951258133478877.b4-ty@linaro.org>
Date: Mon, 20 Oct 2025 12:08:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Fri, 10 Oct 2025 07:29:01 +0100, André Draszik wrote:
> On gs101 only, sysreg can be part of a power domain, so we need to
> allow the relevant property 'power-domains' for the relevant
> compatibles google,gs101-*-sysreg.
> 
> 

Applied, thanks!

[1/1] dt-bindings: soc: samsung: exynos-sysreg: add power-domains
      https://git.kernel.org/krzk/linux/c/ebd2160ee6ff3e8e4c7b17b45380900307a34b6b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


