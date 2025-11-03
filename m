Return-Path: <linux-kernel+bounces-883015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A59C2C441
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E94F188AA1B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ED42750FE;
	Mon,  3 Nov 2025 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iPqd5QE4"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798526B75B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 13:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762178041; cv=none; b=QQB5aDlUb7esvwKaNaoTBU63oD/drekreIG4BqWcGUIb/Ny0Jw0u2e9cTN9gorE6GFga8QEGY9mhfbk+nWdrMVJ7r49/nfNjGYK4dVNGpOWbNTRaoM2XUEKN7HwaPAm+lSW6gDYuDNmrF9tX/RPfslQOHpTgZ5PVnQSVQcQVmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762178041; c=relaxed/simple;
	bh=x724Nb6nEhXoOjmexUcOrQsHjcK7h+Y8uel8EraJB8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pRMZExcatAkeFpLwkPTf153Tcpkamt7HjFLD5Ygh9+ZygEbbSLfElEAKO9/FRZN/0teuMoAU9//0SLQ9BMYwFT4WzylRnQ2oC9DwjaYy83W+6KpRzbFBnx5nXkDwcQICMvcKsp1J7EjwjuLLPDV9JbzZsCFKJ4EJPXH5G9DBSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iPqd5QE4; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b70b338426fso11858566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 05:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762178038; x=1762782838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRIRnwbdNF9ZjW9ua81MwxcmBt6wB2lb2Cyijxdbhus=;
        b=iPqd5QE4mq14LJgY4v31xvAVDaF1T7r6KYZ77ifbKEB+j6lYWUziB6UmvwZ9IqjphH
         M4YXl4Iit2TUMRnIxQLFYqXUHRUMAL+B+YqaMJX6kNaEO72eKAxfx/MDHv48GaQ6ByMr
         /kHTTszrV4mwUb5/bljlztQ3tun3FOZxBELiJgR4VYLczcGpgU1ZdUyAlIsXl2iJLdId
         fpuJUzXEZRrpULxx1Zgtuhaf1wbjeoUufxeLPxRSUNVBkpCx02mRcejGrw93AKL/PH9m
         3QRXnMig2ngk5uRrAXkeQUlQSsR6J9EGWJQ6XT6qy82ATdj+ojJCD/gS5Jvv+5cptFm4
         I2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762178038; x=1762782838;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRIRnwbdNF9ZjW9ua81MwxcmBt6wB2lb2Cyijxdbhus=;
        b=Cr/sq2WEOhDXlH9GdyvrNfoF+qzu9Hm8ugWmeBZ+SwwBpffWptVfgeAEMCe5Z21GwL
         KU+BCKHWP5G5WDkL/GlaYx2Siv6v0OY+3+5x/ds3TSsAH/bTTqD2ONhb2ZFAi59aI1ko
         OH4rC7wpvlg7EYHc3E5+zLP8WJuTrWdDe0N1U+6oY91ug6OoRmy5mwf6yvWpCZllBafb
         nC5HOzGdMV0hE7pN6lbdXPKEjSDkuVsZltoQ6enXhxWiac0LEoPkGvAuLVdNiKF7/gm3
         dz9c2A4kGm1PGZByUZx7FVXosW5t9LyE59NA/kZdstitsXikpHZY3k1wR046b+dDXBGz
         6bsQ==
X-Gm-Message-State: AOJu0YzKSxkzSKxB49ee60GBZvD5jAuXBDUwHPz3bdG6GLOB5j2SkMqo
	Jf121aRLpMvruliHHZ7U50rQCUE0sWaBhsyVtBxab6lH30cSpg90kmmUr489vmiJ1Z0=
X-Gm-Gg: ASbGncuK7IVxeq3/T52EXTEjCkgigJHeQ7GUW72NbilSHp1bmnAWZ74HMszIIC0qI5X
	POTtQWvPeWrp2LKs16zmPH+41u3PuX/EYEfmd4bLUd6FRxWw3E/MqU1fl4kwbTatu7L6uZbacqI
	uGBxreJ0m/v5XA47iAGZkYwZUts9TaMYvlRo5PAXe9zv5/lo96ASNhGnx/s5NAxxwJNqDBEProq
	hL8/SwIE3WsecPBrijqvHn5gMJEy455GaVL53WX3P/GvP6AL1MGCc5AuWeT1TA6H9CcwjW68iRe
	5r+GwhOrhNzQoBHJ3BbE6imGOkDiXMkJl+SmHtWu15sx2UsAjFfXT+ccHODAFyM/ytBZdQmxuIK
	t1In90Kufw+hZaSv8NDVaOW6GWpORDFvDxGbiEf0y/qgkIfq6RD1Av1q18xJDNEDCRx1zxvSt9U
	heg1oR0g50j5XOFEGh
X-Google-Smtp-Source: AGHT+IGcohw3g6w8go43Dqq6WKUdsdhcXNK2fPK/3nXDm7ojzpory2cMU7iQJC5/TBRgrekfuFJPKw==
X-Received: by 2002:a17:907:3e03:b0:b42:1324:797b with SMTP id a640c23a62f3a-b70708ea28bmr670598166b.9.1762178037820;
        Mon, 03 Nov 2025 05:53:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70bb3f336csm392100966b.6.2025.11.03.05.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 05:53:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <webgeek1234@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
In-Reply-To: <20251027-t210-actmon-p2-v6-1-1c4bd227d676@gmail.com>
References: <20251027-t210-actmon-p2-v6-1-1c4bd227d676@gmail.com>
Subject: Re: [PATCH v6] memory: tegra210: Support interconnect framework
Message-Id: <176217803519.188953.12459486939589625513.b4-ty@linaro.org>
Date: Mon, 03 Nov 2025 14:53:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 27 Oct 2025 12:48:18 -0500, Aaron Kling wrote:
> This makes mc and emc interconnect providers and allows for dynamic
> memory clock scaling.
> 
> 

Applied, thanks!

[1/1] memory: tegra210: Support interconnect framework
      https://git.kernel.org/krzk/linux-mem-ctrl/c/b33c93babeadd04a7b1d77c3e58243f413bf2948

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


