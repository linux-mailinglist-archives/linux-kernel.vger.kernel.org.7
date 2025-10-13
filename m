Return-Path: <linux-kernel+bounces-849835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81578BD109C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EF22347218
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E032010EE;
	Mon, 13 Oct 2025 01:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pAPvZrGf"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D16C1D7E4A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317329; cv=none; b=k2H0A+gOftv+4bE5WVKyCQrdbNE3EfdN6ulEM5Jpp4j3/R+8OWJVLJQnyrgVigCkAFfgGTLsNfD3gj0phloKSH81RcJ8BwFnFRXIrHky+ajXZ+gZe++N8fvNX9otp8xAU7wodvB8uKoXSMlDU4kLYXA9+C3siMvPhL/dqZRvJTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317329; c=relaxed/simple;
	bh=6M7PF3xNLpktje0EOKWg4z9Nu9yKC8jqvoHS+dTKYjo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j4K4EJ0moQMI2WcsLcFi73Zvy9n6NsSswP5/cNtvWs7H2weoU7WwkFPZL10xstRrquJEAwYz3c+kurSN9BFiLqkZGAknbkEMmevDRl8Ri9FtZvXVP0o2SSPPaS/OtB/x65+dPp6gXk0RKXMlTaWEFQC+Q78uZ5w8cGjGqnacjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pAPvZrGf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-781254d146eso236838b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317327; x=1760922127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8h7DDrA7j+9540Tqy/6NV+bqJw0DCMI3GYZXvoLWyYk=;
        b=pAPvZrGf06WxIkf+1gAxdUEmVjrAS2lXR5mK7jR+EGRi289foPcqoJ6GpuDLidDMKW
         wo2cF6M/mnn3kj9sEVwlNH7apR4oIf+Fg1gDr8WCPnpuPHiWZIIFd/eb84fTPMjDmR6z
         njyKzztl32ZwWymDbBzDtfe68aw3sCMVlV5NUJhTwp5sn/BQTgULijqNlAsVyo2L2ZhG
         UK+mFnW1go12VzJUFUpx1PjlyVqu8ckiQfT1wje+V6hThVOPbjiCYZ2/QFSYAUrktrgv
         kQqLy89UsSHcrQhE7o+gp8MkhcQjcCKumn/4U5NBasXwaEaqAtJY8z6acT/GFL+9HYK5
         P0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317327; x=1760922127;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8h7DDrA7j+9540Tqy/6NV+bqJw0DCMI3GYZXvoLWyYk=;
        b=FqUcmaZhwKdimuwvGLTxChCniRHzT2cEJaKY4oKg9sT25D78sAxKb/IYLPYuInUPC1
         jivKSae4uPl4C3BIvHKvnre0xH2Ctn0VZhwf9P3lZJ1TjfK7iN/1dIzTzz+6o9lsf0El
         dAT7Xqk+XlAVWOSqVyLTdTB45mYUoB1YHiRuZ5m3L1xSy+PFkCCc+f80aPUlQQQFyzjy
         nJqcXvINBsvCZUmfem8CrK8Lu8CxJWBM/3S6mc3j4f0cuz5T5l/xvnC+5FXc2BWHSIGG
         DZvPTyfHJ+GO7Cj509v3v1F0sFuGX5ldQxlGt2CCVccBVl8PRrd7s+QeXQR5b/eTcAsu
         A07g==
X-Forwarded-Encrypted: i=1; AJvYcCW/9bd7fSM4PbE6nhK9sFiDg4WarmJzUh10f8yIczMAMPQSD0/YJgg8MXkiCrS/PLjNzZp8dSOwSAD50g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS9bS93yJ1siDS4kPxsUVuH1sBjQKSKKK9LJER7d1oQKAg7eCy
	P8AjVhh05p3o/8UvmilTNVD0V9fMU55wARPrilN8EQtLB+afLZWUJ3mHejJ+iVSXJq4=
X-Gm-Gg: ASbGncvM0DmjHbhXTNOxcd9Sx3oP3w0expJcrnMBIpStQL+RFNw3XkFIsV2ZiIn72xZ
	axumNDIMn0o3KYaxqllVPE9wCQLlVVmmoPQaOKCAv5tsnrdVZP1D1hndQXJvABRxxa92DXWoC9F
	1LmelLGI/2mAAAeQ3hWfYEGMZzJsPaf12aP3kBUJzxRYrmthyjzezUV+fnK8gWCCrfVWAUkRpgg
	XYQINABYIzoVdSZPh/dFv8ax3MIMxraTsepzwPHXVqRVFPGuBOd12XpCrrXkv3bqcH+TWfo6Yzd
	kJwJUQCnmc1Xro8nIopmqyDZ3VCbfR5+nCxm9xu5JrcBcuH9vJSEi1dGU1DMslWX6S2ElC+Eyxf
	QAy5wNcVudIpuHkdPV9m+8HxJsIDYx6ku6qT/KfXx9wshscHf3kXOUN/eSp0tAxF33629P9s=
X-Google-Smtp-Source: AGHT+IGnD/2S9vnckWUYx+lQefO8k9+6JLQFNxeCb9U29jbHzHiJy1UtLcBAdXedqp1xT25g8Y9crw==
X-Received: by 2002:a05:6a00:1705:b0:781:229b:cf82 with SMTP id d2e1a72fcca58-7938762f1fdmr11941331b3a.3.1760317327480;
        Sun, 12 Oct 2025 18:02:07 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:02:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-serial@vger.kernel.org, 
 linux-i2c@vger.kernel.org
In-Reply-To: <20250917-perics-add-usinodes-v3-1-a3629e4666ef@gmail.com>
References: <20250917-perics-add-usinodes-v3-0-a3629e4666ef@gmail.com>
 <20250917-perics-add-usinodes-v3-1-a3629e4666ef@gmail.com>
Subject: Re: (subset) [PATCH v3 1/7] dt-bindings: soc: samsung:
 exynos-sysreg: Add Exynos990 PERIC0/1 compatibles
Message-Id: <176031732291.32330.1246219208832468083.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:02:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 17 Sep 2025 21:04:21 +0000, Denzeel Oliva wrote:
> Add compatible strings for Exynos990 PERIC0 and PERIC1 system register
> controllers.
> 
> 

Applied, thanks!

[1/7] dt-bindings: soc: samsung: exynos-sysreg: Add Exynos990 PERIC0/1 compatibles
      https://git.kernel.org/krzk/linux/c/ca4bd675ec459bb7bb008f15f5d866c9ce35f4e2

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


