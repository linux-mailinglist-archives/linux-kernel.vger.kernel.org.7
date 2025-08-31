Return-Path: <linux-kernel+bounces-793454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37523B3D3A0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DE0189442F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 13:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F172690D5;
	Sun, 31 Aug 2025 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaNuscYa"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5B265620
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756646896; cv=none; b=mIAhWijBPYf5wleboDi8Q45UUW+IwvgkJkChj3QNhB0KoAv/+Dk7os+033pgEgcPh6Vhz2a6LsHadQK1uUY3ROaEbmJjGfwXeUXLxdLVbhvr93SGuKjg2+sB3NAjzY/iya3SwHyzw4KxX86+RCOSCO6YUinqc0JfhvzoaBE+hCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756646896; c=relaxed/simple;
	bh=4724Qznr91+tj8Y9/XUYmvNyXil/j8ZgBOQhRyA1BqQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MX9d128yEFDCquFC1L80Id+wylYcVzA4bRKWb/vqJIsdEGJNQrl1hrFfQRTMV3VltxxcN0b+57ybnAeS6QnKCEz8+MYGw6E08nT3Lzn9j99h7BGRrqSnSJ3/FwBc/DrgcBxV6UVxXVXCUk7zWOP+MO2YiSRHqPL4WPgw5agkkMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HaNuscYa; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3cd299b1833so442061f8f.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 06:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756646893; x=1757251693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mD6lZo1DYlhz45rUzy85fH782HipOjBn1uPVn9HDDvM=;
        b=HaNuscYaAfd8V7+N5pjuxFbkoakg48me+ZqYI/Jbe3/5ZX7oCiCYvCL7W0kDbxiI7S
         BIEmpdcmgyCuvrzWTE6tdkJqgS1uK+b5YlfA3sgEPbIZsUOL8TRjPl9Oh3XJL8/SQQEe
         GvgHzDwRw/BbKXj81qoKE6zXn1UH8bG2hlvGUp6wx51WZAjWzm6GfuW+VpZsh/NOQmPa
         tYbSJ085hnPQAdFUn9axpHudtVyalArUx/Mf1EEQKjqsAHTozrhz15H8TgNUOjX26H1j
         KI470sLMfNfHHd4UZg8LdxEYl+HkSgMozlav9qyI4ZS2R0M2Cw1O8Lj6DJl7ZYMioqDz
         HaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756646893; x=1757251693;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mD6lZo1DYlhz45rUzy85fH782HipOjBn1uPVn9HDDvM=;
        b=DnPOIaUa0VZCoyJB6UZpr/J1euXbC+j8IuJgFa5aTUtKLqNHc2LOx+r4Crnikkjxki
         uUzgcuBHiu5f1VxY2HSh52VxV7tiw6C9QUeGfi0KSvBV5UHDjbKli7DXyX7THZ5sOgfn
         5ZY7jmgwc7yTku17O9Fyxv+DnzBFUbMeYOh3WziI+oAN5op1VBDBVpYMOTsP9NeQprC9
         mx0aXWy5NENTNDlsgbfWve+W5I3i3hkJDu0Er5RjUQZf6ScN5msGSX4FouUmW4G8+nMc
         KfzIojW7W7XzC9GLM3coHfVDV6fzPTcwAa+ieyp4DEwJLFcMEImv50T/98sLjSGdmQYv
         ExGg==
X-Forwarded-Encrypted: i=1; AJvYcCXumGQzOnFC/l9lN8fTFmwt5MEQaJs+mPJ85X/80ghBVPv5sYar1/zezIh0oh2HNk+UcnZYPCdGR6jV1F4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweXVKGbeDqo592GJd8HDQMEZEs1C4rBlSI1y4wYaW0n5p/E4+3
	vzx78jUIsZEOaJhg0A1IN0n4g8CXoqO/AGwIDq7YiduMy7pvf6gRR2XKMti17DRXNcg=
X-Gm-Gg: ASbGncvRYybgHdy0fKfIWiYrI1/CiGkqInKOTbs8fFBpuwFqmtR20zNvetMKSlfKiPX
	8qTN0UkXZgHtwJEF70TMDJZZQQeOd6NnsMh+lW3ehbPHO6/vsBg/o8WQC3POUgIlnNJfJ0APc8V
	J6E5OiC6ZYadPcKbZEbgMjMXhFvBOD52etUOnDUcIheYsXqzOmj79xWStgWW8NT7ZqsF/ll/5XX
	Ni28levXq7mHb27yMi+FaaZ4EwCITdn8bvwu+mxLIlGVCEuupwp1UeVJpH8aa9qx4QtGcwaz7Wd
	g0YAy2EaeCTdYNb8xyGSlxLqk5YE0sI0jh9JqSkbdeMZEa5L9qZ/e+L3iFIr6RWuqmc6FpWZae4
	ES5aPs0K3tqEFXJGBGhBoCi9fmocBxovK/YRHdLkCPQGecPVIrg==
X-Google-Smtp-Source: AGHT+IENOgSWDvrR5me5DMoY53wRwsPVCOq3Mq4OdX9AjWmXw0wgs5GSbqe1NiXMSDlX3rSsquKhHQ==
X-Received: by 2002:a05:600c:4e0f:b0:458:b6b9:6df5 with SMTP id 5b1f17b1804b1-45b81eb0a80mr30834275e9.1.1756646893387;
        Sun, 31 Aug 2025 06:28:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b87b3900dsm29956925e9.0.2025.08.31.06.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 06:28:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: jesper.nilsson@axis.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org, 
 s.nawrocki@samsung.com, cw00.choi@samsung.com, alim.akhtar@samsung.com, 
 linus.walleij@linaro.org, tomasz.figa@gmail.com, catalin.marinas@arm.com, 
 will@kernel.org, arnd@arndb.de, Ravi Patel <ravi.patel@samsung.com>
Cc: ksk4725@coasia.com, kenkim@coasia.com, pjsin865@coasia.com, 
 gwk1013@coasia.com, hgkim05@coasia.com, mingyoungbo@coasia.com, 
 smn1196@coasia.com, pankaj.dubey@samsung.com, shradha.t@samsung.com, 
 inbaraj.e@samsung.com, swathi.ks@samsung.com, hrishikesh.d@samsung.com, 
 dj76.yang@samsung.com, hypmean.kim@samsung.com, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, soc@lists.linux.dev
In-Reply-To: <20250825114436.46882-3-ravi.patel@samsung.com>
References: <20250825114436.46882-1-ravi.patel@samsung.com>
 <CGME20250825120704epcas5p37385c913027d74d221012c4ae1550c73@epcas5p3.samsung.com>
 <20250825114436.46882-3-ravi.patel@samsung.com>
Subject: Re: (subset) [PATCH v3 02/10] clk: samsung: Add clock PLL support
 for ARTPEC-8 SoC
Message-Id: <175664689125.195158.15680456692339310248.b4-ty@linaro.org>
Date: Sun, 31 Aug 2025 15:28:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 25 Aug 2025 17:14:28 +0530, Ravi Patel wrote:
> Add below clock PLL support for Axis ARTPEC-8 SoC platform:
> - pll_1017x: Integer PLL with mid frequency FVCO (950 to 2400 MHz)
>              This is used in ARTPEC-8 SoC for shared PLL
> 
> - pll_1031x: Integer/Fractional PLL with mid frequency FVCO
>              (600 to 1200 MHz)
>              This is used in ARTPEC-8 SoC for Audio PLL
> 
> [...]

Applied, thanks!

[02/10] clk: samsung: Add clock PLL support for ARTPEC-8 SoC
        https://git.kernel.org/krzk/linux/c/80770fccb7f60b0bc795852c154273e511f296a0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


