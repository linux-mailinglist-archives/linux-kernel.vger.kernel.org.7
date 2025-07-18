Return-Path: <linux-kernel+bounces-736451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BB7B09D09
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F0277B3E88
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A95C293469;
	Fri, 18 Jul 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="O4HHZxcK"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CBD290DBC
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825379; cv=none; b=EEfveZZ5Cop28zCy+gAKjns1p7hU3urynjdWFi14OETHiIqxTblm7QHSndZkdEj1ynqkXWNyZAH0z7B0b622oZxyNqvNCqVAGQKN+BApFRWwCqAgrPB+RWgDkvHgOvgAUiIEHxrE3GLJUkHQjzanqaY6xocGc65Ys+CkMQdnQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825379; c=relaxed/simple;
	bh=AH8gj/lye4cjsag6tkRFASwBoNl2K/FYCAB1SRwBtOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=neDcqWPziR6V2/nIFFLwCdj+gP20kFfvbLphpC7rI07E1b3FL8SZnn+fcqz3xEX+I9XAoVyX1gS0VCqjTxTF6b8p4b1ziEgNAH7zZ7rcjy+nKBUVtvgTa0tGHTCIWoUKsvWZ4vwh3L29DA86Ml8Z93KrQeISnS7CkB/XmHO0BuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=O4HHZxcK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4560d176f97so20334025e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825375; x=1753430175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZToTQ8PW4JsaMkDi4L5ivDoGiP/EegAxDULuwZK1b20=;
        b=O4HHZxcKW/6Ee12Nk7mLV8uQ0Wn//IL6MRZmfOWMC7TSD9y/wlFZ9Lfxn8hkyTMx7E
         ly4MZS8Ck0edLC3R8nx76wPTAkqrL42wHToQkeT7fwk/+lNVJ4UqGBgnILM1ynfVFBIN
         OEZq0YpnavNyOfc6JGYnJ3outvBdsHh9EDca2g8E1yAC8sc51lpn5ixBgtjmEAF2/Esc
         wZ0/tbgB9mpkMOlMedeNHkiTuYnaUOWjsB8qxQ95rUmGSDeXgCvksF8srk8L8gqjIvja
         T1h2fQ8amNhCrkLLVfYznMt9j3YB+kYwLMsekvhari1/fY7zvqZQA9gpoPtx7wV1G8rM
         +DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825375; x=1753430175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZToTQ8PW4JsaMkDi4L5ivDoGiP/EegAxDULuwZK1b20=;
        b=ZipqvZVya5rIod6AXl5b5sn5yeHItXuONw41AzeQzj5+8QOa+VmWYjoYlJld78/GuY
         8jteQtXIj167qUEsEVBbNFKroHJ0RWnQZeqQnMm3B/j+POIwQDp+Q/vonmRehKI+6HYr
         hmW3XINJEZ3KcFU0ultbViLeaQS8wuF/HH340PJUgg8hhJhkcsv4g+k1I1Q6zh6otPDH
         SRY5CjT0xFimhliKxMYs+GDqpsbIUnw82WPJl6TrmDO1+inl6K1CnMoyFWVvoquBgWNr
         DaKHhk4S3iSiyeTuOpvM06BJrVpqWApKD5nKIstlOXYwd1BETZ5c5uh5iMLjmoM7jkhM
         mwDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2AQtNp2McJjPDESiy689FqYDTqXYEmiAQWbYoIAeBb4mIU8aDczimjOy2xC7a7YEadbmr4gVYXy9u1tI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7LMs7hc+LhlxUX67aZNFpq7Xo10d6g95jgTljyNiTLQaP0rbL
	UQe22Wwlre1q6ZR4OE8F49tZYtwB5djIZQAXyigVSaARkKQIT5JQ8xgvrzGZ0+tdeRHyeTX1GJv
	Vd5Yys64=
X-Gm-Gg: ASbGncvCQDXke2lfr0kOiBQjdjGRYnL5znk3hk4eYHFuDT8v6nh4O+XjygERIA0COjF
	YLAcAn5gkOVntAyIhQU8bbTSvRiHcS0eyronRL8pEW6mYe30fwyI9sh1YYof2vJcNdBIH4vP+ZL
	bq1N5CCQ3WenPvZXYd/0av4qYQLoOle4qXRPx1MSCtt4xcG9TmBUcNYMrV2AZYvoQuVKuGjkix3
	Op+HQiU/X2pZLDlaWIAmDDNTVeiBTLs+9DXBD7XMuu3uXlx+Le2yu5ySu3Oha/0zOmvp8w1MNGG
	Qxu4N4W98rkz66Gqxyc2YO5E93KBKOHfdoExEkPxx+dgOb+Inbhlf9Ntbbseqe0JEt7T/JmJmxb
	7EHbQhGNl7CaPspi2Kse7
X-Google-Smtp-Source: AGHT+IF63wZIgbHIjDHSteYojloqPMvMUL5Da8SVDOUi+uUHbZuSXcpOtHDDBRVodn3nB1iist0iMg==
X-Received: by 2002:a5d:64e9:0:b0:3b5:e084:283b with SMTP id ffacd0b85a97d-3b60e4c1e2fmr7838667f8f.17.1752825375521;
        Fri, 18 Jul 2025 00:56:15 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:15 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Ruppert <christian.ruppert@abilis.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert abilis,tb10x-gpio to DT schema
Date: Fri, 18 Jul 2025 09:55:47 +0200
Message-ID: <175282531514.45055.4499067354058389239.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202934.3013189-1-robh@kernel.org>
References: <20250714202934.3013189-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:29:32 -0500, Rob Herring (Arm) wrote:
> Convert the Abilis TB10x GPIO binding to DT schema format. It's a
> straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Convert abilis,tb10x-gpio to DT schema
      https://git.kernel.org/brgl/linux/c/dedb4dd925ac8ef514391adf4267cfcbd4f27ff0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

