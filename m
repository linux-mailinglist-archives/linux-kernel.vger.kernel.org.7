Return-Path: <linux-kernel+bounces-849833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF152BD1086
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCA981891602
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A482212564;
	Mon, 13 Oct 2025 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7xiXVKY"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC820E6F3
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317318; cv=none; b=J4eUUXPApyybh1Ddo5YqV1FzYrfpnsk6RlSKVMZoxZWtwsKmbswguuQluPu92Qf0GfA7dcGjxw8mqS0Xjcwj7Xws3ROcva+hoY6JMY8mfaMXME+RaheQArNLBtCJpfBuQZVBcvfsnlhn3H/8DNJ05plLNTQU19RyZdQUfPlrsoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317318; c=relaxed/simple;
	bh=PslsRqEzoLUH7pRkVHXqIh8BJWHmrAu7uexd7fti8CM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=up02wgIrB1R7pEAGe7640zyy0WQ+RIyVK554K/3ayJV8qLuTxHMN20JtyhBjB8ZYSLfpRNLV6ZY8jx/4xk/E/7DBM6tBC/5cTuOdLDSnG6HbdHL8u+N9DPkoiHYmxItNEl7/yBRLxzm0L+Jvbng4GhD8jKkor9Sy7Db/KDBewoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J7xiXVKY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7810af03c69so99770b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317316; x=1760922116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1TEQtBfUYYndvsc8G1MAwUYtk9BHiNm9VJYBElay+b0=;
        b=J7xiXVKYs9he+Fv7oGxRmRoyc/hOYnP7tWPI7wTXMJJfBkZz6dF6e0j01Bb6PLsXNf
         m81QIZbrfn1THHBfPQpdOFM/hwPu1Khk+s518reatYGOTVzTOHo/f8wXGoEXyz8+Wxhu
         2EVgUoqQ1GqQH/SaOITSWe0T+p0XxhJFqpoIFQFVT+FmIKDwTOLjik7OzrSHSkPYNh/3
         pgzHAMkJclFMR3ud6KzxTIHrEcPxZFwuH0uCEuj0cLoJuhYT2PnVUyXlZF/ROhx+XNDg
         Wd78oj/VKL05bC0l3FGciKrotulNmmO+G1nm4tWaDz3fgbPJ7YwOgE7BuGjKT7O7NmwS
         NSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317316; x=1760922116;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TEQtBfUYYndvsc8G1MAwUYtk9BHiNm9VJYBElay+b0=;
        b=CBLVTVYXADDJPD67l8ZG4F19llsPrDbQNIshlOH07z6/2MwLB1ujrKfO927RBO2IRu
         OUdwCUkuXbdH8QAe+k8RAg4O6s7+FsTUJDvk40MMoziQUSGQe5ykNPCZPbPQATeABveU
         WpkfNV3ns+m6hlL6Pbm+gO34RYdjus2OJFeCy8LOSsG6ekq1WKu5DBu0t5NaCKo1W+zH
         XV0+vZUh0D9rCIXn37Xbx+aFpmf9tugGtgGSC886Zz+89pStDFAeYQ7WF03D7CI2ssX5
         wm2dvC52ThNgKwkANA0/h+QT3L6U5h1P+Th7rNJRSCh/eT31hYPNTXCTd0IRckJ8tV6f
         M1qA==
X-Forwarded-Encrypted: i=1; AJvYcCX77hrqEpHipmO9bLZp6NCwMLOErC5w1uxX8omY9cmJkW2wmcuDXWuY/NI2DxrqhO0iwpGC/E0ixEYfLzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YztCQnioQQtGatpoyrTpNvdSMxoFd+jkhceJKJp3j2duATyJsub
	24HL5KYdnnwOuROf91pPX8gy+0AadGIa0utLiH8h3GgElFuMZYBgciW3NEp4up3s5+U=
X-Gm-Gg: ASbGncuUNR0fowfMR4iJswGT1JHrisQAJNww8qqM1oZwkUMIZtIj65K0SVo8hInFSQv
	Jcj3PBRIWfgjhWrdalRnd7Kw7l/h7LP1pHW2moJeW/RtbaKDQZKACU/NIPyfIYhlhLTOKnEPaLv
	8bTYVJTvvZlm9gXnMBIfvUntWGVWEjG7H5aD5/XeCnzmHcgVhryNnHJIPrkYYPtYJfhZKyDUFER
	C3OxJMmNC44LZDm9M0nKZP918M2VyFitm+OLwg3Dj8l3Z0bGTE7QWmra6weBiYxVKM/b9NAMz5j
	PxhIXhXPKL/C/pTOZgvPr7fycZkFvt0m9HtgsQ+DCoMK0HbIk6UmUIfzmCgay6sOSULdQ+HnE7C
	Z67n+hYpb6UqWrMKprNoGu6EyHQhqMbqCFk0Hekljk2ekIgFqMyIKGVlfF01r7q2ziwZjGPc=
X-Google-Smtp-Source: AGHT+IE0pV2SdSy2BtqzzreV56Z2CBh5fAGnmk9U/0caCiZx4MMe4ASrcDCjjfJh9mw5C6vsUpzf3w==
X-Received: by 2002:a05:6a00:2295:b0:781:220c:d2c8 with SMTP id d2e1a72fcca58-79387146ba5mr12386110b3a.3.1760317316323;
        Sun, 12 Oct 2025 18:01:56 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:01:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, conor+dt@kernel.org, sunyeal.hong@samsung.com, 
 shin.son@samsung.com, Raghav Sharma <raghav.s@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, chandan.vn@samsung.com, 
 dev.tailor@samsung.com, karthik.sun@samsung.com
In-Reply-To: <20250915095401.3699849-4-raghav.s@samsung.com>
References: <20250915095401.3699849-1-raghav.s@samsung.com>
 <CGME20250915094517epcas5p2186fc92cca758b6fe610c0ec91ee51bc@epcas5p2.samsung.com>
 <20250915095401.3699849-4-raghav.s@samsung.com>
Subject: Re: (subset) [PATCH v2 3/3] arm64: dts: exynosautov920: add
 CMU_M2M clock DT nodes
Message-Id: <176031731074.32330.13412044019926403871.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:01:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 15 Sep 2025 15:24:01 +0530, Raghav Sharma wrote:
> Add required dt node for CMU_M2M block, which provides
> clocks for M2M IP
> 
> 

Applied, thanks!

[3/3] arm64: dts: exynosautov920: add CMU_M2M clock DT nodes
      https://git.kernel.org/krzk/linux/c/7b0ccabb873de4b4dec3214b2a0ee3c32c326101

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


