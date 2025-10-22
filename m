Return-Path: <linux-kernel+bounces-864674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9905DBFB501
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500AD42269E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D85A320391;
	Wed, 22 Oct 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhFs47kf"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B6831DD82
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127679; cv=none; b=fBeEAmUr2R6rnsBxFnAWWl3SQKIEa/azwBLnE9aHgxHSmX6dNctmnnxdSkHpdp4oL8a0GfwOGNh2WSY/tpXFumiYtTVGyjWo+W6j1z6ojGslg0b0Q9CqcEGkvC1OHYEuOs6pxY3tKyStg4J0NACoRhjMpOhY+/VCLM9ugBp+goo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127679; c=relaxed/simple;
	bh=Z/VP9qyxz0Ogx+cyT0aY9YmkvjeV15cKSdyDS0qNCn8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HaCPdRlwyUtc8sSWs5LoQhU53MgT4TJs1fhICZKwDteGaC8QlDo/X4oxiJSdKKTavxy96vOa3Db2WAP6tLcf+2SKgNOIgsQihIzIe5GRaPNLQvltxAsITKEuuosipFQa7ne2r8bTF0AqvANNeN6DcDOVkgKaod75R/pfiJQxNWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OhFs47kf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4270a072a0bso746660f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761127676; x=1761732476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJg0GAAknmDdoURqaMYxb4ci3e27SCLBJB5wjnR5uFI=;
        b=OhFs47kf570UzHxQNjH6Do5b+M94Dtkx5GPfEHP9YqvU9++akK5NEqSQg4eUuh6TjK
         pvDFhh56mr4xfVKNJjm8NYHLHCw+/Sj8m/jWpIqDM/h7fOfv4Jk5NZrNpbkpnsiU9g36
         gYez6UZ2B1QlFITmmSDMN5mVLGxpdeN4Onq+NzBRatLJI6BwMPVlMwBvHmpGof+qHDKI
         p+vKZ2tkVVccT/Wa2dwABnqid6Gbrp1q9oRnGd3aFtRkwN8JlGbgKjupZb316pa4vrME
         wpQfz1xwniMtrmWKg09a3FLaweakgQ/BpWRr72ZG8GHPaeVXnMBuIn90h3xBbsSjvT1a
         u7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127676; x=1761732476;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJg0GAAknmDdoURqaMYxb4ci3e27SCLBJB5wjnR5uFI=;
        b=Ogv2hLpy2hpmFG4SLo2V7VQcczdP5KsrVCqYleo6BXQ3NgNPfUTfoSpbHz6sHpDhZm
         iMIhDInC1DT4g6S/FqY+8loDH9/PH3rb9c+0MnKMkEnCL28CCuUra8qTgzGOU+qsrB6+
         eqxqPIe85XOpLa21syH1agw02JwYKT388FSuWSn05lTurEjcugYvCzBOVpH3H/xrJB2g
         09J5v8a1s/GjwyXyQb7ddp1xAzYyT3C4HoTu8L+1QVCvxww8ng9qeaeeeFCdsjVVAjLV
         o1c7DpqrRIadZ5dO0wZI9F4qVJzMaxr1iT2bN6CuL4mR6Ix0LdcXp0oY31iJE3AB1ErU
         1YCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtI3QWIl+CucP1dCyeb/t+Y5KaHwTWemkzn3I4mQPlp/goWL+6i58fSSpNi24mZdjuoMjQyvy8fdkSU64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2YGjjoACuWix/Lb6xTrWFSRfA6bJU267hQIaVlDG1b2c65T1Z
	pYDTy4C9GV2GOWO/SOWKJxfeTlekkfQYONA/rUzMcpLrpLVMv4XEJLrMUODjPq7yP9c=
X-Gm-Gg: ASbGncsRjAz0ej7/g+WKWFnaMU0s/8k1IqMPPMq3EDdjrXg+rm/gqReb0Yw7+67axrZ
	RXfEq3iXFyMoo5THj0dcjSgvqhpIzT+C6rf7UTZIVJqn89Zc5TczD1tb3kaFWtLtAgmC9uVFvgt
	H2JEQhIvvZg7mcd9Gd0J7WeyFzVsnoklP7JCywWE1iu6D/HdAwH/9xEliV2J8yz8zzM3kz5OYHL
	Fg/es1dfp6M8BXie5o6Hp/iUC+5KsAnle3oHcBmmLRB16Cqv6y+hB1SlKj6gj8oy22hRJrt7N4n
	a/+9X672B3RWE+7X7Pwek4dkZY4QIyrbv7XS8Ymvx7IC5QvoQ+d4zkRVAZKnFDzX9AqKABuKmAa
	Gip95iQUhYOql+cEOhUSUWx/YW0p9ckl3PaH0Kt8fLw3bDTRzlg+ON1DOMnJ9vNHv12bZyZuSyT
	FEz/mwJiZEDK5ln8ZvosFoWebMYzI=
X-Google-Smtp-Source: AGHT+IEdX75qrN6US6Y5a5un6NzE8Q7BwB9wmhDu2fD1EZuWaGlaPnM2vNiBGgFCMMmy7GueZmz45A==
X-Received: by 2002:a05:6000:290e:b0:426:ff0e:b563 with SMTP id ffacd0b85a97d-4284e52d956mr2329372f8f.3.1761127676222;
        Wed, 22 Oct 2025 03:07:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce56csm24001630f8f.50.2025.10.22.03.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:07:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20251021095426.86549-2-krzysztof.kozlowski@linaro.org>
References: <20251021095426.86549-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Update Krzysztof Kozlowski's email
Message-Id: <176112767515.50428.16111691709369055810.b4-ty@linaro.org>
Date: Wed, 22 Oct 2025 12:07:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 21 Oct 2025 11:54:25 +0200, Krzysztof Kozlowski wrote:
> Update Krzysztof Kozlowski's email address in mailmap to stay reachable.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Update Krzysztof Kozlowski's email
      (no commit info)

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


