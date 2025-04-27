Return-Path: <linux-kernel+bounces-622234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A61FA9E471
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 21:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5547A5B61
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Apr 2025 19:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73225202969;
	Sun, 27 Apr 2025 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QfMwSZbw"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744D81FDE01
	for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745781925; cv=none; b=ND/lvJn+uqGRCRvhyo8uQIzxu/F8tqIuMTXjIlaIDpadIPBbDsI2ujFQv0QuarH1B+2hBFJIwSbUKjLjVC9ywwxAU+Pet2HjZhXyDe5kBk2GaDOq/deFF8EXKZrkOc0ciA34LLg3Kly++KCdGUtZuj8rM1W6KYtQF+nlSB9wxZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745781925; c=relaxed/simple;
	bh=Sg2uIs9CLRdDP1c/mamJmns3Se/NeLRnkCgerXSQj+M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=vFNfjDdHEwKeOiLxA8lGZQ7ovRdNmwGviyH4b2jjhSdDni9kRBj47Rid1JwHhsLJA1qE2TD+SMcE7jZNGjRnybt4pDsgHeXAvZY6vViXjU6oYvP4hnr443jnMlOhUEXX1rkJ9J3PnQix9GUvw3O8JGdgZaXfi3u2gezB573QCcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QfMwSZbw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5f6f3f2af91so487052a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 27 Apr 2025 12:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745781922; x=1746386722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNcCWpWkCjlURmIOiT/Xyzz/qjRhgBURVuEZyl4hvPc=;
        b=QfMwSZbwkfRntcehMEV3aM8+Scg8X4qKPHHO7+B/eHCrg++4x30eqsDYgrVW+UBn2o
         U+tR0hhjoXUd8D7CFCfTb+HSoysOh8hDfkCsYbhSXddW5Ovumby3Z/A7ACmp3MROVVmk
         zIrvkasTFWvlK6GHsSCOm+vTrHi4jbgHdFdLYyKaiMhbXbQ7Mj8Xz6RVJSFx6/s+EXa3
         LZz9LbYKTT+uasLppC2cihjWG8rgM3/VfCjHghWGxLVvbIOb0c30iTmkT2S48WsGauKL
         GO2YMA3EhSYmZ3FjYxGe4HEFRkPaDsh5gQ8s6Kue6DEM7d9Td54g2BiC91PlEsx5JOmZ
         4j6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745781922; x=1746386722;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNcCWpWkCjlURmIOiT/Xyzz/qjRhgBURVuEZyl4hvPc=;
        b=l7abocMyFlHlrwyQ0P5B01MHx5umDvIrEmi321nJjkJIlKT2svd8YpDDLnSTyHrnhX
         GHMDh+7ezGLf0/8kHFtkgtwTvDQcYMfX/USeDtIKKA/qwF5IxQudDaJrd4GVcEeHWAYQ
         FPRPHFXXjvHESKAcbzwfNyg44cj5mP7mvio05RmMEs36HyVTo+04ZS3ypokQ9Ptovepi
         XkDqyM+PHdvCfU2AVQ+q0uMg+BeFFXRUq8EV/yzRDpNXorIPL/E7IiEklDqdSIaJ0M/p
         92usDd1im08lXG74kxbczxpD6DAY8BHv+CF/mff9e8h8wQtIuyvCQqMIl+C95FYjU51i
         TBzg==
X-Forwarded-Encrypted: i=1; AJvYcCUJyA0eCNgM9wHjKONszSYH3OOApmZbb4vDgrUrcuFaNDB20Wq8zJSgz6xa1XjL63ctSRKsSmXhLlxW0hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtGuwV6ZYyDrgy5EIGnnfF3czpdzOIKpdMvMD3fvBbXiSY4Tk
	ZINUpy1dZOjglJIIPQqsfXC+vshfTRYU47r/W/ChZmq9GFr5kcXTTwxlpct060s=
X-Gm-Gg: ASbGncvahvRBeKaSQY46Jr4ctuYEpc4PSY2zt4mOeo5XWrLueb2uvONE/gjw2P1nFnj
	rg8Rh/pLn3Ebx8yoWvAYEt5bicLucDmk9Yq0MnjZSEVPmTKYJ59CPb1BzlwSFYk8HtAUeYA8KqO
	U1xnvQqyWcAk+gDibqHXJgkyA6xtLOl0cFRSzwYzqfphuvTBvegbxQgrxTI1wnKmDB5YJJt3Q1N
	hsn4N2KnJuBW/LNvuHhLSXO7EKggHDcDmqhE8zeUJTjMh6g8AwMyjHhYH3i00goYcf+78+hq5ZB
	5eO/dceq4A/tLNx77n5Q+2/xT6yjP8k33xjBY3QSqll3PUNl+q6O0Bj5ofk=
X-Google-Smtp-Source: AGHT+IHbfxdly2O1fFQ/MEQQRx0A3uENOeLc1JJa8cSN//BYdEU12hN+C6YPmm2uTekVvJeuxnfO7w==
X-Received: by 2002:a05:6402:2353:b0:5e0:a4ae:d486 with SMTP id 4fb4d7f45d1cf-5f72352ae9cmr2474742a12.7.1745781921729;
        Sun, 27 Apr 2025 12:25:21 -0700 (PDT)
Received: from [192.168.1.28] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f7016f66b7sm4650196a12.46.2025.04.27.12.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 12:25:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sunyeal Hong <sunyeal.hong@samsung.com>, 
 Shin Son <shin.son@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250423044153.1288077-4-shin.son@samsung.com>
References: <20250423044153.1288077-1-shin.son@samsung.com>
 <CGME20250423044159epcas2p4a2e844c6ab502d7d5e6e6c18ecc7ee97@epcas2p4.samsung.com>
 <20250423044153.1288077-4-shin.son@samsung.com>
Subject: Re: (subset) [PATCH v2 3/3] arm64: dts: exynosautov920: add cpucl0
 clock DT nodes
Message-Id: <174578192026.47282.1370567375954176035.b4-ty@linaro.org>
Date: Sun, 27 Apr 2025 21:25:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 23 Apr 2025 13:41:53 +0900, Shin Son wrote:
> Add cmu_cpucl0 clocks for switch, cluster, and dbg domains respectively.
> 
> 

Applied, thanks!

[3/3] arm64: dts: exynosautov920: add cpucl0 clock DT nodes
      https://git.kernel.org/krzk/linux/c/2a4067c89e4137c477ca6f367e65ace0f2132922

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


