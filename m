Return-Path: <linux-kernel+bounces-850169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC746BD221F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FBC189825E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8052FB09B;
	Mon, 13 Oct 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GVUmyLMo"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9448B2F9995
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345227; cv=none; b=NPol0qdJKfvgc/l3Y9e/uIOdaZRvU2j68MEqT5WMEabdLpAsEukxoJWH37PKSm+QFgaovUHS0/Rlw5BDoBhLvPiFchdUOX3FZ3i78fq4f7Oro3Iu8+o1xk881S8pnmIB9q7Co0Ki6GApvGTaEJBgzYPQW1cfp9cpE08gECl2qE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345227; c=relaxed/simple;
	bh=d8M+ivtADtXDYSeEzdGAHqGf256mH6bZPw61WhtBoMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjsKnHoGYmskJ0tuK1d/mePSwCxyfUOnh4FtF9/WGoYEBmpxUWM9ORapsdQ4+lvdeqxwewsD8ut0RcU0e9j1grfyfJVznxHuO5nt+20KI9NFBdBsNhot7gMexlCxEit8//MSmVigDfcGaSYpOhd9VGGONVn16ADGLLmA2YNSguY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GVUmyLMo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so16749795e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1760345224; x=1760950024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gd+pzMdPIgYVRLk+23ZpKjIPNg8psVXn3K6n4iNiROM=;
        b=GVUmyLMoaGlAXna0UDwEOi3ZDkL4LjrHyRHq1pdI60UxWe6CkSQJbdB3kYvcqQHTyE
         YCl7FBbjwVbrmp/blyi8Nkslm4ERW+NecvormMUaNToGuZL2bWyRkE2CFLi3xbM0o5YA
         f3vB3vdzoaE4vFAsupoKgibiH+vIRe2x+pBCAJs1TxrdEmPz1T2fWsTIE9U8VA0SgzcN
         gVTycnzvF0rmQklSTI+rq7Xno4WV3P7deX7cix32IEed5alqsKdcApSVNy1da4hc7xKV
         UkvF0p3U/Dbhk7Znu+wUCLX/ZZR7hdw5BozJEZelQukHBfcQZSrEJwJxrBRrJrrlJSW6
         jeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345224; x=1760950024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gd+pzMdPIgYVRLk+23ZpKjIPNg8psVXn3K6n4iNiROM=;
        b=wgmfJ2gmSc91QeSf6fdzHiSwKY1XkkVxrpsE3pZCHRyggYpZfC/xmGf70SxiC8m55q
         4PDNowsUEnUPuHgV0Fo2b6oCOP/63zTS9kZP3+oC8ngTyLca8tdADZIkHnJ/B7P8ClFg
         NE+sCxrVboJTo030LOP+NXKsgIwLW4NoX+lDLroaioE+kGOZP0vrUjemSte4apKq+gi8
         9ZUNPUq0dK0uL63zpOMksKpsfLNQl94nKimOTxNPLsY+NHiMBGEwwe/VjILC8cFKxMWF
         o48O3HqpVL5/F0etGYXq7VLlc8vBp5+XQQt44VBAyH38JnHdIaa2y+faST6AWir+84pi
         HfOg==
X-Forwarded-Encrypted: i=1; AJvYcCUt6c723lc+oWfadxPsTh//TQfK49EYxdH89GIBGwBIlGrRSbW46JsOyLk8tGzMXOU0IAjbomlHjnNbv/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRnZzoyztBeFyX3uEv/J1jbbTzm44xWOawE5GCvKaM9uz9l0G+
	zJcjur8oYI3gOTcpRxXiZWQJmQaqXt6Auky3jC9TeZrlgImotfegk9NdNvSBSbIC+1o=
X-Gm-Gg: ASbGncsPQriES3p9WepEpjkaiafAZZN6cbDxFxyIl9jLIuSECvR/EY4vNuHyvnBzEdo
	wPDSLQQB0lueBj//C+KHcdXfWjC5BUEaLHeoGY95Gb9ZCATrwlzFgjp+0TcFKofGnzqx7+h9QlK
	Qs4DU0kMNGcy5VQaFkGmtHhDdhE01E2ulmmAdNRNtUolNMoc7/CDYKGerQvkg9lGG/h9g2VvAs8
	XSQM8Ebifn4OV5D5BNAVhCjwbCwNCPaAjtGTUUkJWj0D/un0fOBKvRtdDdPeEkelnXhYwLWdLUF
	8gu2gThqZuk/AmWb7xVHKuX0bkQ2Qb2Aw7+a36qBI04KpHq/CLY+OajIugJP967FSRGmxtLEISY
	Gtr3kA+hseufMhjsNM22CEbjWb2PHig9JzX/MAvM9ONNM9wGEg/mOyexEBpqSOjBH
X-Google-Smtp-Source: AGHT+IHtVbZgFTpgAFwb6aNqBpk5v0sDXR3QkRzIBm9bTc/K4JVxZ0824W18iq7Jkgk7IKJyUkmAXg==
X-Received: by 2002:a05:6000:1445:b0:3de:b99d:d43 with SMTP id ffacd0b85a97d-42666ab8668mr13212697f8f.19.1760345223815;
        Mon, 13 Oct 2025 01:47:03 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:fc45:d50e:e755:a6e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5d0061sm17199089f8f.30.2025.10.13.01.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:47:03 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Alex Tran <alex.t.tran@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] gpio: gpio-grgpio: call request_irq after incrementing the reference count
Date: Mon, 13 Oct 2025 10:47:01 +0200
Message-ID: <176034521952.38327.12702860512610142526.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251002055727.1488237-1-alex.t.tran@gmail.com>
References: <20251002055727.1488237-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 01 Oct 2025 22:57:27 -0700, Alex Tran wrote:
> Remove extraneous dropping of the lock just to call 'request_irq'
> and locking again afterwards. Increment reference count
> before calling 'request_irq'. Rollback reference count if
> 'request_irq' fails.
> 
> 

Applied, thanks!

[1/1] gpio: gpio-grgpio: call request_irq after incrementing the reference count
      https://git.kernel.org/brgl/linux/c/3a74778dc20f692ade1227a7e73cabd2367a8b71

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

