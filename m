Return-Path: <linux-kernel+bounces-860199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A69BEF943
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2A2A3487B4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928662D7DC0;
	Mon, 20 Oct 2025 07:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiM46Q14"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240C12D063E
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943985; cv=none; b=Rmg7OyMMJdINmJeEx8+d42+HPOZDHOzM9Mg/oQSMdXQg0ol5dTZTrGWULRZzbsKZ8i15SXpXiRzKMqgqGXph0h+mB3aL+dHjNxH6wk+R3nS3jZclKMUSomu/SAPE/ekW/cTPxYH7vrQVAJCVS/YfIf2nySif01EMbPlzN3Yhv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943985; c=relaxed/simple;
	bh=rMm7BYc9re9L6JYscXwi2llMLU3UnSVoJxhS7c8RKYk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r5survd/9C9eoKBvknHNHw2T2SboVZY9628MKl+DNV14/Pb9pyF6er3S4zNQtIycqxPCxdX9bugwe2KwwjZtBbfqOkXc8u5D5mr8c2qMyx3/fadxeHwv6BLLyZ2O6j0Ci8OqBeqEoqmBY9MWGODor3jefSvMrvKkbJVqAIE/Wks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uiM46Q14; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-427087fce27so357157f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760943982; x=1761548782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL4ZYF94aOfs6GrfgQH7uz/6YUTAgWONeedgmFFItcs=;
        b=uiM46Q14qy/hoHK5gicz12T8unN8yFHSllvw4zido9me/SjUh1PbU1xSrSiFri6lha
         WV+T/r0pk9AxHt1ZaO8tWGXwWVMCUZSW6PFBFpc6gw9EWt8KKUHPUiQ0F2RXKgTUkYRz
         JddG84uC/QQ4N1wN0IbN7Ld5KJ8cpRfIiC8NPBVTmtxPKfdBKCzF+8qhcm/IEQtm4DA5
         9/0ebAMOwAUGZ8zWsYf8FAUCtoPKAR5i1kHGN4cl768n9sKQ3Myul7mvZwwidgLDyWwY
         /OWWuTKQUcxa5Q+if3eZ6qRhBMO6uZLxvH2UW3hFwzqgHTRkIZx8sFG38STFViTiO491
         OZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760943982; x=1761548782;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BL4ZYF94aOfs6GrfgQH7uz/6YUTAgWONeedgmFFItcs=;
        b=CZUrzUDT//9/q1BQEPZg+BU6W5LHeBzEhR+PG5oKQC4EVxGwblq/dKaJjLNQtxUn0Y
         NmDOeiYTVIstTQiySO+XZvh6dPXdchPdA53ncPJs5V86VB5y2QJEIn0a1BstptDxU0W6
         AE/oMZz9aQon5xAA4ZpwgHXI0YUMgFiXqpeaoXGI1cGH3z8tpi4vEXBspjE+oB7eWRcT
         si7V5aC8pvOjGVIRx0kfAR32SHU8QssnqfYD1zSw2kyqtUkjl/VBmootAkN4ST6x8CSg
         mD6fk70kMGqGr7bHv0qAvsZrajyhh2hG76ZoBho56akKvGvy9djv2v8fAy3jsObhS6DL
         +LHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/vDXsmq+ULRRKiJV8oJhDZ3zltzt0dT3ZRBJkEnR7S4h+esLaHRC/UmYkCsHZJl6qRLhdcx38323IrEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCE5RpLIAPzK+B9Is95ZtuJCrX1dUGpRvfnCZ8caJj1vWb3s6H
	/vDSgkwXCzNUr2r/JeQfzVLgMDpYHNX55N88lUF9uWBXKhqW60rPhUsin2YrQfITSQ4=
X-Gm-Gg: ASbGncspvUqbC+e9CC5ywM4yfcUignOixfuWUMO9gHcUQvo7Anois11PVpICtTOjpY0
	ZYnXQr3kAPobzeIL93xDFwweMO5GAMspbwX2jft27jFS5xoH+/TN32viZMrUQIV0S1QIIHGVc/r
	S/loqC9ZaXhNQp61hRRQdPDv6EpLla5nkYARtAdzy8MxBIPugULkVsPaQqY2C95LtX8OJdds1tq
	s18SkE05xp+wdHuo33fW126+xlb5dbCHg2/hEsz80j7pSgdxx8f+1erGNXRUbz2RjFn0/MV4kYj
	3hXnmw1NQ2buh3l2GsKndYwvMMN0U9F21ccUGz91etDdIoTuItzxE6bf1I40quqfoUmXSIOrPcA
	F5AD/047dtJ0VGKPLiPa2q5Jcxa3mr7Fg7S8IIBlSj9vlTFw9eRXpBJSSVtzj5DxozCg5oJ3SNm
	8nOiM5e9oCLL4kf1Kr
X-Google-Smtp-Source: AGHT+IGxcE1H5Tv0iSV8CsOY/ouiQBwzdpqvV8wjkhYvo0l+T5f2NGZtvR5ODn0Yr9X/Rd9I1QZNeg==
X-Received: by 2002:a05:6000:1884:b0:3fc:854:8b84 with SMTP id ffacd0b85a97d-42704d55175mr4636053f8f.3.1760943982413;
        Mon, 20 Oct 2025 00:06:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4710f28a920sm102535935e9.7.2025.10.20.00.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:06:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20250924-acpm-dvfs-dt-v4-0-3106d49e03f5@linaro.org>
References: <20250924-acpm-dvfs-dt-v4-0-3106d49e03f5@linaro.org>
Subject: Re: [PATCH v4 0/3] arm64: dts: exynos: gs101: add cpufreq support
Message-Id: <176094398077.21021.10319434896360598218.b4-ty@linaro.org>
Date: Mon, 20 Oct 2025 09:06:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 24 Sep 2025 15:14:40 +0000, Tudor Ambarus wrote:
> Define the CPU clocks and OPPs.
> 
> Patch #2 has a dependency on the ACPM clock bindings sent at:
> https://lore.kernel.org/linux-samsung-soc/20250924-acpm-clk-v5-1-4cca1fadd00d@linaro.org/T/#u
> 
> Thanks,
> ta
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: exynos: gs101: add #clock-cells to the ACPM protocol node
      https://git.kernel.org/krzk/linux/c/2e96df32009c2d7e4e210afdcce40bab17d0076e
[2/3] arm64: dts: exynos: gs101: add CPU clocks
      https://git.kernel.org/krzk/linux/c/025707fa269b0cf65fc2e10bcdf23359fd0e978b
[3/3] arm64: dts: exynos: gs101: add OPPs
      https://git.kernel.org/krzk/linux/c/bb103f6c7317bbc9cf4ee3a2482e74483876e412

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


