Return-Path: <linux-kernel+bounces-736464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B23B09D39
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06559A8589D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E1729E0E0;
	Fri, 18 Jul 2025 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="taz8uFfl"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3312629CB5A
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825393; cv=none; b=OhuXPajjGoAO2DWoGyjYx4dMx3r30s5o+6hpQ7Ri0pfxvMZh9y7TEv9DNmx4U4vimNMBiefFvzlo7Tm4yu1KnhMtej0F4l52n7zEgMOLxryxNfQME4v4lpwRtgW4xr7XSUPVRwYyM/RCAnDnU2pL1qvBdd8dxAnvRXZvdFgtaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825393; c=relaxed/simple;
	bh=/IfDGxxWwH9C3Ri8YFjSmKzSi0znt79eWoGTibw5i+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3HypNYT/M1Z3WRKCgddwYPS5KLypD1pZXEpWduOWy+4u02A5yfrXmwmaXdQbuICLnQAwQdh9sPany9Z6iTFuVNomMJ43YIIwSPwHrxuefrYfpcMfpKtghoBUIfwoW5StLiWil+6GlG4Cy6gtGmyXe/gFqAZ1q0MPmrJtJzIX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=taz8uFfl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a5257748e1so1076663f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825390; x=1753430190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCaZ+WKPsEn8tCTv6g/PRmp1aflmC3F0blXp5umhp8k=;
        b=taz8uFfllFf8x8IBig0/UiL1bVdrxm+3PaIha/L47PkZVuqcen5pZFOnllSWw96UZ0
         +AaU3a7lUo4M/UIL/hV4ea954vwL/wlLZm9+lL/hOh0I47c2+Iqy565zxbIKDSyAmn0j
         RBsNgVgVM+zSyHgz86xvhqnd9c8avYqXIAf8AwwOJZnXiUFmFFt+nPbokZQ8l6pVkLCF
         5GV0aGq9vzL0QgIlAzbjWWt/fbTBP7Y87nQiyhfSKtg+kcs42EDACcRF+8FkeootCbOb
         ZWALbKVl1OeVYN5uoKK7I43IemlHGxoCwB+M0AQtmhZ9w+lJ4DpogSvHUgEEePByI7Rs
         ORAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825390; x=1753430190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCaZ+WKPsEn8tCTv6g/PRmp1aflmC3F0blXp5umhp8k=;
        b=FWv20g4acuXCUYguANz00tlfZuISTbuRZ7eCIus95aTYrLZo5sv75bsMv+3GQxVv1e
         dKec+Bo4H6XAH8rttUGDn6jOKb/oHASFNKxx2oA+D2+rZaj/asnoa6Gt1Pi/FuOFalqv
         IabIrL8BhbHfudAnwwqLal1J1dyujNtVqyNeldH3yEz7R9PBaK528bNh8kXN8fLVT0mP
         xkklwPc5xrj8l44CPNBOUXujBCs2Ys/VxTeaguM4W3jk9PHOIauCQ4M6aG1oN7QTwiYz
         g93nPBbHn5gd9j6IyBG5lNpYNA9K5PVyBflyFG3JMM9XTIVFjTgzkeA65ES7TNkEujiK
         O7AA==
X-Forwarded-Encrypted: i=1; AJvYcCWZLLeishDdWmoBKw54Wu0PHGfy6EiPv3UYd9w/bs1pWT/U12fmiOsFtw8NtuJOMQHLguehDECLVK3VCUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20NjJ0iAjq5mB2uGf60FLZls+lOyySzKzqaLNsGcL7r0/n2oL
	mYYGXGGfxH6YAwKxKtOK3qegKZmQpxKQzfxS4LqC1PRFhH60CVM/Lj6QnyLABiGzRWM=
X-Gm-Gg: ASbGnctJYrwaxCqtdDCVU5tBYmQKdJ2faDyfSywuq9qv1MdFm1PAn8N7LYqTUDo5/vZ
	6gPJ0LWsyO6pwceg/zQnAWKbefQ9ZyYKsiXhp1yhq9n2HZOtrwQtwdlFJ9sDOLMySgMPf8y+9Yj
	U+YsKYNhGFoY49C0aZOQDd7pwGk6C84wOeWhMCWh9R874GcWYlA0GqEIRnwecBrdKAgN7YyWp3t
	mYlz3fs1aZsMvTA97RX7N2WkxbtmlN7zbRUmOWAzcxH2q+NaoP/WjSC/AltTOU+zE05m4FEUspd
	RSHUXofV9u4Bqpv5ZWF83EzDECf98oFVVWiE6K1gG+mNXP62Dk9Rl35dU7ii1I4bUBaUF/xoiTK
	Nz1kYcjlTNhbhLIZr4Y3D
X-Google-Smtp-Source: AGHT+IE5asmOHY9ijht3WIRY02R518XDUE2Kx8RGeuGf24vxDpkdK3gfoDUp+3MG8ORx/gDQZyYPAQ==
X-Received: by 2002:a05:6000:2d0e:b0:3b6:164e:a059 with SMTP id ffacd0b85a97d-3b6164ea1cdmr2649609f8f.17.1752825390520;
        Fri, 18 Jul 2025 00:56:30 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:30 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert ti,twl4030-gpio to DT schema
Date: Fri, 18 Jul 2025 09:55:59 +0200
Message-ID: <175282531514.45055.3441491568286298987.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202829.3011298-1-robh@kernel.org>
References: <20250714202829.3011298-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:28:28 -0500, Rob Herring (Arm) wrote:
> Convert the TI TWL4030 PMIC GPIO binding to DT schema format. The number
> of #interrupt-cells was wrong compared to what is in use. Correct it to
> be 1.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Convert ti,twl4030-gpio to DT schema
      https://git.kernel.org/brgl/linux/c/a12b566ba571aab82f969bc3b137487e61afc976

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

