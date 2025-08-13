Return-Path: <linux-kernel+bounces-766517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 653CDB24776
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1231B60309
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE2E139D1B;
	Wed, 13 Aug 2025 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lzYsouGN"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25D42F4A0A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081434; cv=none; b=hW2CUSN1wnZh7RvZx3motsozHrtTcpeznywhV9hPr8ASVY/pS9v8rd8hLUBfY1So4jlDNTGNmvjGpMu5w7S0CNWV31UPrHxNlEd3gZouSjiGum/0p9jqAiJxZDQRIzHMeDlQLkAy5rAPGLkwJSRIK8fLsDLjr+vVUbY6IejaxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081434; c=relaxed/simple;
	bh=+IyJltOGWI4YsBqQdWg94WDQvBdSr+uLkjBcwTJ0CWA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W7RmOuX4IaDHhvGUz0oVKe6DsJcUaHEr/p2FZb/4qXqmxD5Yn7+OQdqFTDYAz65kkr4TL8z0OFXtZzcQ5hN83RDjDuDlftQ4JD18ezTankTonQTKU7aRCiTHqpckz217GcdAOUDDKZ0vQ7Kj8iKST5KDq0Cqegwm8L0NRURPVMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lzYsouGN; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-617b526d402so933345a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755081431; x=1755686231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/I/UV4/s1jFi57l1/zTRTSQC+EHyYYP8Y1oNeYIevY=;
        b=lzYsouGN6VgXWAtp0CeYJjYZhDy3TcvZp823W9+fd3EW+pjCrV3psL6ud9JWJ9IveI
         QaneawJ1t2hacXq16v/4wp5NbHTONcK56dnj2PdeF4nLqstOsm5niWmkYfZDQyBZv1K3
         rgH2riqD7KJ97EsLfUnyQL6hgAC2aMWgkMZf+zPFN2mHAJcPVajIZd4E9zSy/VGhgod7
         vQ/HgPLig9i4/7Clbob7iZWDmiWjjFkd0FihWZ14+P3iaZZNTEQ+zBxAgUZeDErnNOdK
         oXx2X0LXZi68s9CLbllafZA3RM8mqMgMT0tf9vh+RhG5rXmKqAGc5cyzMjcWWxksy00/
         q5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755081431; x=1755686231;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/I/UV4/s1jFi57l1/zTRTSQC+EHyYYP8Y1oNeYIevY=;
        b=lrd7uUebY698D8WK+JhIPMzeDIJKk4WUZAwIqCXy5c9QOEN3ygIodgB+2COQOkb4x0
         ivHQVp99TZ6c2SX8XWFfbTUqtuWG1eE8wmrrlcvWYi/pDyyFp6+IJOZr/kRjoliKmFQH
         x3NmY2xXLMGhdjHz57fXVD82HOLLbkE3Cb4FYpnqg9eMrw2gANgCpRVfkPebloIrXmoW
         IPhSe8mzFl81lGpPlpPqB+mLgU+9IFY+bBidESEtr7itZtj2/7Vp+1MEdxLT3+kcSxU8
         faVF2b5IoX5OtwyFWX2dtdC9PZheY2coW1BqFwF4JY4hTvMBie+ADI3ZkJUs1JOkgaEK
         eXkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSdDoIoopZFZX0xba9IrNaSN5nysMt051r7G95JGh2llEPzg8sACWLdk/zjgm8adZaGRIUPI78JNudwUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWW3yPg34FL7gWOz8ydP0CubEKRo0AUBXC42eyzZOF4bS4BBwa
	k9MG1oelrKz0fsTGONP7MqlhgZlamzQ5xt64g74+9afEgjacgoholf1VSHZmrksTGrg=
X-Gm-Gg: ASbGnctp8/437dqnrQafozSA3ABwL4Bm3p2TGbNwH5kso4CoISKJX8Vhd9/vy/GtIUl
	DYfukMrSonHjsRw0FZ7lYGJhfolCGe47+gkyKiYemqcZGh+oVnzfh0hFYX/vSPUq/i++bFxxdo1
	8ptnoK+UoluwmRwZK62xCE5AHUcgTPgjI4oH6P65dCERTmRehOZYvJw0ufZxITVa/zCUxHGZ6HL
	pQKUieXjGWSXul3CNAxPnNF4irMRr7Nnb8e5YNIie5JW9AMHPiwV4O2pmpe7qt29CIpTbsVGS1C
	TSb5qr9EDknl69NML+hGQR5BbvX9751A9+wK41mbJd/ZXb6aQ4dxI0sCrCv2hfRXIXaohuEBTkD
	aqdfAVqvFjxBOr+UbJTJZHnXmRZyA0d/vPvkXNmo=
X-Google-Smtp-Source: AGHT+IGly2ZK68mNw/1W/aNJtrzffPyIHLrPFRXdd6pjFMKVKce3Kx6411EXu07l2T6GFNjgHfafyQ==
X-Received: by 2002:a05:6402:3591:b0:607:eea1:1038 with SMTP id 4fb4d7f45d1cf-6186bfe6deamr918459a12.6.1755081430915;
        Wed, 13 Aug 2025 03:37:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe7995sm21042215a12.36.2025.08.13.03.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 03:37:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250710-resends-july-exynos990-dt-v2-0-55033f73d1b0@mentallysanemainliners.org>
References: <20250710-resends-july-exynos990-dt-v2-0-55033f73d1b0@mentallysanemainliners.org>
Subject: Re: [PATCH v2 0/5] Add watchdog and USB nodes for the Exynos990
 SoC
Message-Id: <175508142927.40586.1715682122583711068.b4-ty@linaro.org>
Date: Wed, 13 Aug 2025 12:37:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 10 Jul 2025 18:50:04 +0200, Igor Belwon wrote:
> This series adds the nodes to enable the watchdog and USB support for
> the Exynos990 SoC.
> 
> The watchdog consists of two clusters (cl0 and cl2). Unsure why Samsung has
> skipped cl1 on this SoC. Both are enabled and working - tested on a
> device from the -x1s family.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: exynos990: Enable watchdog timer
      https://git.kernel.org/krzk/linux/c/ad211501fff48d0cda35dd187aa7e356a4fb5581
[2/5] arm64: dts: exynos990: Add USB nodes
      https://git.kernel.org/krzk/linux/c/d3830b5b0db59d0b8e33083462e4c0dd021ed300
[3/5] arm64: dts: exynos990-x1s-common: Enable USB
      https://git.kernel.org/krzk/linux/c/707181264badf4f82c78c18348684cd06db31ce0
[4/5] arm64: dts: exynos990-c1s: Enable USB
      https://git.kernel.org/krzk/linux/c/32532687a9ce2f1c5556e082f957200a81ba0ad7
[5/5] arm64: dts: exynos990-r8s: Enable USB
      https://git.kernel.org/krzk/linux/c/e28c1117deda5a80df14b579170c1a90fc82bf5f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


