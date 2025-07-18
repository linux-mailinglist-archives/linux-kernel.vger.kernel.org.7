Return-Path: <linux-kernel+bounces-736462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F15FB09D28
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F50165E5E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539A729DB7F;
	Fri, 18 Jul 2025 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="cd9Ca9UM"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3282129B23F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825391; cv=none; b=T4rAZ+VNCL5b/peTq/4ZNmljPu9f5Si/vxvrlkuu6VINtevbl5dRmC7bMWPUZlzFkhQrneVb7ZBn8Eq2EHllXd5AMoBtjVlf5+Imn7gH98sgARuX71zqRFFOzw98kTDxuXWhiN01D4g4dtlTrDNIMp8Hh41vta4Dcqt9UJ4BNNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825391; c=relaxed/simple;
	bh=C9bqcrGBhTrsWpfUjOW4kU/Mkn12SfkpmSUDhAhPK+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2V0Ldu9KsRBA7efbuPMCH6UbpEN4NqdLDeH4G7Z6VWrlCCcBLzztWzqfkH0VplHyQKiF7bas+xQ9bT8h4cNTxMTnLkf11CYk1WnvrmLv3zAOt/TtFla1Orp9vRT57zddenE9kCRyjLyZusK50GqWf6dQcZ6qcWeztvCgCm7AJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=cd9Ca9UM; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso1218956f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825388; x=1753430188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2WjJ11dRN5Gip96AGcE1HrjIgLasYoR1jtLMOpXHO0=;
        b=cd9Ca9UM/JJ9jTuwXzHFn1qxbb8pXmcWnK502LQlyY+FLGMT7OdfR/zoEXZ6zUqaeV
         edgGEA3tJTsbDoObg3JgBTmU+0ud8xQOCQWmqh6hAQi6l0tCQMu/H/Jhne3QOhJarBwR
         pZceQvTUuJbyR8xdrNmtJ7NQigHfMrMXG/9xT7OgZBGxLkvbvKn6Shp1xEeBGydTtk99
         pp408/vFGghdURM+XupTpTyXRGhKWX5DLm+dxoJzGMGR4Mgvj0C1YjJwozd7+o+szfKm
         jq2OypeDFvUDZBtUlBxVIyrADORZ9gyBr+VmjhFOO11t6BBDmaVTTTqP/e3wvpBeu0sf
         rzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825388; x=1753430188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2WjJ11dRN5Gip96AGcE1HrjIgLasYoR1jtLMOpXHO0=;
        b=YQrZKkcHeq8bjIx9bMTNjNF5Kth4DXIMRvRMXankmSDxRCIOJbUOzTcBvHLINg3xyP
         8vTQIILJSdc9GgA2GBr3wfxgfMIu2LW4yUN/rfJnaBB3v0pUmafzsbhQ9UDQxcvy7FqM
         0geIuU81put4D9hWyMOfFVfJRomnc/qdiaGnx0hv3ywqLRBSS1/coPxZdXpHFkq/qe1Q
         66gyTNKADpeckXokDKyXRF72CDNMwzAzs+qG1Dwgu9QQKUDGvH4xjDioXbvnxsWXVVFL
         0c2GULuY5YnsbJyQv0KTqBvVTcsi2rbE8rVsnKM9S/ts+pK8Dfkcu+OH9hVcDFhNMkzm
         1g7g==
X-Forwarded-Encrypted: i=1; AJvYcCW76zQtn8b5l0Bgyi+NuiZsRyTEnaDeCseifcHmDI8/UHdVtCxzluJx0bp/7dTgAiz1LNTxfkIUIQp3qQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkda7yIu1K+hbzShOkOWaw1KJ1yrTb2Ii/n0XG8LSF7fcSCs3X
	OK7/vwEE38eC0LErLN9Uc2I1l6e1d/XwnYMChvve9m5vzuwNrCJ22JedCZg+EsS+p/c=
X-Gm-Gg: ASbGncvtrJhglJLbxDHBHfn98gfYSXKBVchsl+Rrg6DQoUzyIN+r3XT8OgkC1lZcgzN
	zBQJjfsA5xmPmVjXf9o3i+2i0plp/W9jRsBiIfINBWKVUlGX0h+k0Hi8VrI8AEqkJky/uxBif76
	2ViXEFzfzG3raQag5ExdtBw0w1MaNBhUJ4rKHpkVqE24QC5zxkZo9vbjYfDyazLuNIu43oFKfS6
	sV4H6mFG8aiLeduRcbDcJmFuYH7DU9xrRoTlA9WZ8x8vbApqZByuxlQC6UHyZEN7avzZfoD3rla
	lV+J2qftwbHrLcsXPrgexGiNWnUTTXEG2BtQts4qwuSq8bNuFpcjewAxK6Q65Wilxo44ascelb3
	4O/qwfAE+lzeF4cTxDkkOYwGRSUVWamw=
X-Google-Smtp-Source: AGHT+IFzwWzItXEyAswXF2j8T2V3Jltv/4LmwN9EFBQ4BjRqOu8vs9NQK02Z8i9W2KisnoCadrxSJQ==
X-Received: by 2002:a05:6000:2209:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3b60e518cc4mr7354018f8f.42.1752825388439;
        Fri, 18 Jul 2025 00:56:28 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert st,spear-spics-gpio to DT schema
Date: Fri, 18 Jul 2025 09:55:57 +0200
Message-ID: <175282531515.45055.9916675888040268718.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202753.3010240-1-robh@kernel.org>
References: <20250714202753.3010240-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:27:52 -0500, Rob Herring (Arm) wrote:
> Convert the ST SPEAr SPI CS GPIO binding to DT schema format. It's a
> straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Convert st,spear-spics-gpio to DT schema
      https://git.kernel.org/brgl/linux/c/3a315c97fcfac3785060c1980d0a81ce76a24cc7

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

