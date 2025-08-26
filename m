Return-Path: <linux-kernel+bounces-786729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E29B36625
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9532E1C2019D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE073350845;
	Tue, 26 Aug 2025 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="zbSI7+ng"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338C350843
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216012; cv=none; b=QQfCe3N4nR1xK4C0xr1ohsh59qOmwFuLbUxQKV8OM0HBNZKNXYNsrokQ2wwOhJRwTydgRFsRZtLx1sOiNssV8fRSFJQwkIelO/RUCdrb5bEoTB3DrOxEcZpGRV2nkob9KjOjGoekSpbwCViSnz8ImIursUvGbznM12jWYQsMgAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216012; c=relaxed/simple;
	bh=jJUBEbotMJc4/7tNagC7dFAxP/nGnFXGjRAa45Uyr30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PX+Tw3icoh0Fe3PJbgLZneynuWc9S7B/Yl0SQPimzlgedXXp+NsggcsMmAF8axlfQ3kix0ry8NrZnb0OMLl5VHJiw5YrOGwS0rNptq3q5a6tpsXEd+dAyZ84NV0JRPJdeGEobcPGmI7FUE2m05CR0u3vdwAa4Mu9jPnks7GyfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=zbSI7+ng; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso49739825e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756216009; x=1756820809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bgIZihST00M2CtyLVGqxcGCSa4PCOhuFDLrOFCRzds=;
        b=zbSI7+ngDgAeufBxY0YA69pZH64+vtruMVXY0fyqR9bzvirWkCfc8fpqQYgktIN6oL
         TCzAuzfYTPECbMcualgYwgOna458I1w9IE2MbLNL40qUMFv81WHluAs9VNLNP/ChKn5Y
         cFo0dQjuvvwYYa3C0zitcJgq0yQG2YTihrGUxkVrUert1jGoPehvr+JsE7w/TUi7Veg6
         zxxWKj2+/yhJ5jh5Qi9Y3x2l+ETTRFgjwLt4ZBNOEbXWHOB3lZUV1VideovXGTB+jowx
         /ExQANvRuoH3qrqrLCnD+UINhA3k5UMmLU1q7HAjsUPH9Dg7D3gDElg3hgrGpumwxT/L
         8maQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756216009; x=1756820809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bgIZihST00M2CtyLVGqxcGCSa4PCOhuFDLrOFCRzds=;
        b=HJDJOrDNG2LW1ciF5zRkvl2Zanf9fOexuEh0VhdmUS5OQCRtKFgu9JG9w5aDNcpa8n
         PcZeaT0q4YvPX0VzL6Ba4i1bQksJJVj0GBoJ06Yu0/VWm3jQtp6qFEGIy93ofH8pcnwG
         ulz9vgwBcMK/si40PrCOqDSa/3amg+tRDNpCHTBcTv+GNg1beeaxByuZT9UUJcJv6CLb
         fkWS785bbfePV06Ck4EqdUq4kxuwQB4eg84Ny17pC8BYyVdIkr3U15d5oaroA6rAj+Yx
         5dRyrZnki3/UMZwec7r7b6Y37qPNi+cszlMVq5PgCE/dDTay1c03+NEtgDAMFXxpFzJM
         THcg==
X-Forwarded-Encrypted: i=1; AJvYcCWqZNQHqhc+14vxGtvpFLloe8zEEAcisi3IrABWCN9j8Q90VLKkCu8a89cWbbCo+whzt7OEr9i8d4E2o2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze3a+DbghKRuHaRSX/i+PombQjxIewZ1m76uEE8g89MBk4qqEV
	wo5itxRVfZLzRysK77Ehd8TDSmXhgJcULWOhtkKs3RhzMJEA6HP5hgzVIwfIqsO60cs=
X-Gm-Gg: ASbGncuJ9p0TXhYyw/EzdBOb1Wign5RsksdeYBO3JnVkEHaADuXfsQF2FRU2YmC1DFx
	ucnD4qryATL9BjbH0gQA5PTVuBm7D8wCTZGi4ZvsYFpaPUDa5VJ28VUqHmxfWWrDl37G8BVAMS9
	pp+IIGVD2Y90U2QPRrT/o7wXw8HmbUWlq770DUe3pms/JJw3FR6erke0Gr4OZNiOg7nu7sdx5hb
	VIqdxvyNdOQvaKKmvrOL+FbgWmABpXg2NcxqdwYAZcWWoGyPcVKLmLkANYO/yZ73iJSB4boxhfq
	CU/RSTXwEp82QlF9dVS88VT1I97BVpRpspqihGCvlyyO1t5U4r7T/BYB6V747JVDuna0pmoXFlK
	h23oE9od8+TRoZh0h1rAU/JvK
X-Google-Smtp-Source: AGHT+IH/vtben+jS8p+rxXWOqr702i8ga9ZchZdA6ANpXGCersQKl3QS+kocMs00UNNWRezs+Fzb3w==
X-Received: by 2002:a05:600c:190e:b0:459:e3f8:9308 with SMTP id 5b1f17b1804b1-45b517ad4bbmr141075015e9.11.1756216008734;
        Tue, 26 Aug 2025 06:46:48 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm16231162f8f.47.2025.08.26.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 06:46:48 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Lukas Wunner <lukas@wunner.de>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] dt-bindings: gpio: Minor whitespace cleanup in example
Date: Tue, 26 Aug 2025 15:46:46 +0200
Message-ID: <175621600512.33327.13991412012918423626.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250821083213.46642-2-krzysztof.kozlowski@linaro.org>
References: <20250821083213.46642-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 21 Aug 2025 10:32:14 +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space around '='
> character.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Minor whitespace cleanup in example
      https://git.kernel.org/brgl/linux/c/604642fc148b5d98fbe5f55e4c2688f9ee0b5868

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

