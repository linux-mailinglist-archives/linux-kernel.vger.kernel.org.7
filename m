Return-Path: <linux-kernel+bounces-786703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AA7B363F5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943491BC5344
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 13:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12DC13FD86;
	Tue, 26 Aug 2025 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xg3UcQFe"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE31A239A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214853; cv=none; b=mkkdsZdQeA0HsSaCFdLmpc1vraNVyHz1Oy6uFBiz5uq4md/Gg0EQxdf8Klzit57bkFge2HXiswt2e7Bp6RvpB1YgUTRKWT5mvImPhjjvh+cXBfikztUCYY8um8qNSg0xLgNXoou1wpkPzuXW9fgi4bS0t9wCyx4sn5faj6TbBxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214853; c=relaxed/simple;
	bh=m6EtPj0+uVtOuoBi+kY7iqJCwfqPxHH3Tv3BeRWW1Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNFrZnCquKi/FG9aPTPM4/Y6n2KaeEM/+xYsdLpiol9slmLZ4f5IBIujv1UIDMWT5QiBFADOf2bdHDb1t70D1ImrxmlT6khoxynNjMm7orz6rsBwUUQExHXTZmv8BOMP0xqygH8A/xcbuzqUj+8oiEWFbDMJdspCVp2Wi1JGHgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xg3UcQFe; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c980bd5f48so1960927f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756214850; x=1756819650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6mCp+F+gxJpSoi77Mk8DTDXwuJqpWFSqV1XbI8Gr38=;
        b=xg3UcQFeXrYGkLEw3nvaLClVq0TphRDVK5N96G8vGDcome2N8Hq8wkZ6vwHv0iFLVs
         cGWc6MKgRyVnImgE2tCb4aED30bwnPJH9rIsqrBMkN4Rt44QCWCOytZFYVXMkdewT2pH
         fD3E2cO8vG7MZVN59fDFEZoD9RYqe+ePoi2u4lg5meANts16N+7M+QN5357RC2n5Op43
         bBYF8R4Rm7n0WQyaC8++vSu95+Y7br1Z/DFab5dEiMz/TPUTJq+hu7D8D9wBz3G5OEIp
         cph3G0pcfjTtUa+UfZtigFnxbQ33EiOBNXAqtg7GuKDd8aGkNRQxd4fL7lilZh0dGkEZ
         CIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756214850; x=1756819650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6mCp+F+gxJpSoi77Mk8DTDXwuJqpWFSqV1XbI8Gr38=;
        b=BlI4xwecqLhv6MFjRfNgW3ztWzrg1iPEun08tXqa6OZb+aQ1ETiTnPKrOyb6azrs9l
         2XGDj838+p9GpO7U9PXQ73JWIVozNnqsYZe8yTeByJuj7oj+OopxTJ1ZaTI4aAaaIvxd
         B5oVraF55OAzGpAHbHXGKls1bSYed3tHbA163HkWforHznLrH0kaMTvrzhnMKjrQQSFo
         RqMaxXpv5fymw2nmQ3pOxKFT/u9KKHXd/lo7IUSHpSLdIZH6Flb3weOuPzQPUglU/FAN
         VfB15qnaqDF2mgBbnh+t/HCv3JEG/cYhZhfNvWRZ4BlEMVIQYfo8KLAt1gUCxkF4rjCP
         0Fuw==
X-Forwarded-Encrypted: i=1; AJvYcCVoAOa6TqCSx0sfsV/Y3pq/pfR+ODDyZ4Pbw7HOG4ybkljg4Tiu4JAWC5jDfdLZUEPfnpyL/XRElNQOS8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQjK3kuST9gDYyj4+svNxayWsigzJD5S7wNuMuWh4YRYV+E4K
	UEmDp/tAbuUdDTAxnM5eAiC1ckC2FdgJ1R762yF485coXBJxUmoHLvGGo9yThAppkUA=
X-Gm-Gg: ASbGncslP64ohm1oSMwLAzvhbds1/L+X+us6CE4PVh3q+5wVrioR9ZBwUhdCPDPH6zC
	JhudbWALW6fjlaA5cbLfu3jcsAulH4+HMLnKvTICUfDOtbJro6oKUOu27jAx/KgyKAHZRiO6e0f
	YKucnQOe1omaPVOD6NptelTO+zrQVvI9NoBHHU704t3IGltboTzICoYdPV3yK2TD1Aid0yx2xcx
	0la5xTIkeM9+o9DeopXHhBSm6FV58tMzwF1nHm8Z5NYhnLg0rKbPxZBqJDp2ASuU26izJs7V5lj
	t8LmfIn1jZAfF4aexT3PwzC2Tlo5+ZNzLrDmixFIsyik8+WWw60rsi6nki0OhERyOnGRaw7M7qe
	xCTmzTGcAU9Pqk+pekC8ogjdt
X-Google-Smtp-Source: AGHT+IEtIkJUDKq6YfUH3OIVgwuCFgy5UnEG3BCV3U9Lc+PLLOQkSw1irNa69/oxZWuy1ZkYx0BZwg==
X-Received: by 2002:a05:6000:288d:b0:3c7:36f3:c352 with SMTP id ffacd0b85a97d-3c736f3c4c0mr10077934f8f.59.1756214849721;
        Tue, 26 Aug 2025 06:27:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:fed4:79fc:9440:6629])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c712178161sm16133692f8f.67.2025.08.26.06.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 06:27:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Arnd Bergmann <arnd@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation: gpio: add documentation about using software nodes
Date: Tue, 26 Aug 2025 15:27:28 +0200
Message-ID: <175621484579.32185.5463919382812315938.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <tnaaz2qlk5jpbonfle7uy7pb54qx6ixwuczfbkwtxxwpj7hwas@y7a2rwko3k6c>
References: <tnaaz2qlk5jpbonfle7uy7pb54qx6ixwuczfbkwtxxwpj7hwas@y7a2rwko3k6c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Sun, 17 Aug 2025 14:30:20 -0700, Dmitry Torokhov wrote:
> Introduce documentation regarding use of software nodes to describe
> GPIOs on legacy boards that have not been converted to device tree.
> 
> 

Applied, thanks!

[1/1] Documentation: gpio: add documentation about using software nodes
      https://git.kernel.org/brgl/linux/c/8003235b10e54c1be57374c6224751b39750f16c

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

