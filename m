Return-Path: <linux-kernel+bounces-736457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BABFB09D17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FAE1C27EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70652295DB2;
	Fri, 18 Jul 2025 07:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xUkr4Kzu"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1B295D91
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825384; cv=none; b=WLvWbRFoLJmS4IL1kMEwkjH9g59daPDhJQFEzWSALWhOPJ6RtIBaveGhuzJUxwmUDe8lLfHJZu/qJCgyK70ECaO/TSk/EEqZppEKSkil8C2FMCJ4MU1cRcXwKCxMStWAvvqzR06k/leMDH2L2nmVzYizUnAxgNvFLzNNk+F4Lqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825384; c=relaxed/simple;
	bh=2A1loBDb854iz5IQdoH2bIEYXerlPh2Ru0ZVi8wyLEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0rwrpn1ZDjAj0DbWPWgIewHKDcyWFmmPfBCm6ctyumb6GeXhM+viVp+i2iL7+9vpT5OkUXiVS102aGbqxifsijpIZgBzb/+ZKCj9cakVkbmAuSlnsocUchcGq8zfHdtGGRGM/2XkP+POEIz/lOnKo6Vrk7gn8wCjIR70QocoMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xUkr4Kzu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso1097659f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825382; x=1753430182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjQCwSpR5lvt5YX/H/PDgTWHm660VgOlZGdE184M3is=;
        b=xUkr4Kzu6erVfpYtvEkMnYWE/Li6csvdfQiQG98HLSG63kz4ke+MX4uCM3s5ZjN1He
         nym4oVAcEK5ZwECOzrUsTdbQsVzgc2KZdSPu8ghS3gfUuyBhCyNiJBdy65dWfhZuzuji
         dG87ylqBG0fUtiXmH9iO9Jf2rnp3xTCWriAdDqotPbSzBgfnAR/g33xcW3mFyZURtytM
         Pta5LUgV3f/Or5I51EUjBWaN1XXVDwZx2kRch3TNgRpO8Vflx0LWbDrQXc9fTqxtOkA6
         fJ/56jg2FilSgKdGOme0DZakVJ4RkFiVbbuG7wQkt8T/nPL66164Zc8znoQYN/ukw0Mp
         pQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825382; x=1753430182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjQCwSpR5lvt5YX/H/PDgTWHm660VgOlZGdE184M3is=;
        b=L4VjZzvGb9P6anr57MdV9a+p28HdVdPCIwvhlldvwxM8SAf06fuswQnLfz2pVTdOEo
         +ANBOkeNCzylT5LByZxhga37ARTTahiCOTPzZxERKk/9dunW5Ge88HZfUZQlppCB4ysJ
         n5AJKYu0DK+SUmt7jcx0H3v5ASpfcrgT/aQX1fkFPaBd4J/5qDmNlU+YGcUDAqCRUCXA
         oyyAGrBCttenaeaFcz/APJukRYlsrYvm6e92NBO1v4MrwoJf6R1S2srDKdSaPQXBuodW
         Rq3D0j6Vz/RdIvAj4XxFk2dO+WqPfKWcFcPodijuOgoQxgi7U0hSzJUZ1iWhDoMDuSsC
         +CoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0jRSxeXcZkasF+zl3H0WyXa7m1vC6SkceKDSEvTsIwbrRVMwULbDHSt4oXfEbZ1s9fKNOxBYynoGC6Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0mvd1oDKvaWJS67VqMV2DiguJzWhPl1cgB3irABcehD7Gpu7D
	AmhXbD/EHAZrBsdN6OppqUaI9bfC5aDPEaHbg50NEj0aHbe5ABLEF7OgRIyjeYPfb6s=
X-Gm-Gg: ASbGncsxSQn2RbNrQVA2kwz8WUSW63Hp3+tCOkefW7HA+CPdC/17U1G5zOBGUCGIo7q
	oYlkvT4pbqNWGJCl5SnEV9mLtNklG498VM0tE/ldXU2x5DRJfgllKb1jA0pK3k80Filmx3h9dTc
	IpUEpBzMATtYee2ceQK0Lpn9W533jMOo6x/DyQFI/9cTdmyh2nai6G0ahSvSXYTxbNsfAXYyB45
	EfUHT9POGMMQsrG05sswScDF/lbYrHuKpbaBkbOe47+tq3vhzfz3EFsAyM2XKECEbMqKUgkjAIM
	E/WztcGm304xoEKUK0KLCUVB/IpZ7H0qpP/XoyjuFhTtWu6LGeC2/N5U1yyZ2rvFTnTaTtFX5oo
	VTrAfh5vgHBEc0ykRSptd
X-Google-Smtp-Source: AGHT+IGPCUEkqgHVJg6R4fbFP1ZlBiNb3elfa6RwsvXWjbk9lObILtb/LVMOrlsR5TdYqteiqsB9dQ==
X-Received: by 2002:a5d:5d11:0:b0:3a6:f2da:7fe5 with SMTP id ffacd0b85a97d-3b60ddc6571mr7969046f8f.55.1752825381613;
        Fri, 18 Jul 2025 00:56:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:21 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nandor Han <nandor.han@ge.com>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert exar,xra1403 to DT schema
Date: Fri, 18 Jul 2025 09:55:52 +0200
Message-ID: <175282531511.45055.1602529625640804266.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250714202813.3010879-1-robh@kernel.org>
References: <20250714202813.3010879-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Mon, 14 Jul 2025 15:28:12 -0500, Rob Herring (Arm) wrote:
> Convert XRA1403 16-bit GPIO Expander binding to DT schema format. It's a
> straight forward conversion.
> 
> 

Applied, thanks!

[1/1] dt-bindings: gpio: Convert exar,xra1403 to DT schema
      https://git.kernel.org/brgl/linux/c/98ce0e1c4a46049faf63bc02e1916bd219465974

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

