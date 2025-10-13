Return-Path: <linux-kernel+bounces-849832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53479BD1073
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E9D58347232
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0731E5B72;
	Mon, 13 Oct 2025 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srI11DOG"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4521B203710
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317313; cv=none; b=K+R3z8aDk4BEBHYCE3UQpf3eEy/fbghwDh0/HqKiU2eitz6fQ2vi8zYFPvJNws8hPlSE8lSYOgdGogQSjteF6ip8JEC0YADWQWm2ZDhHjbjhRjAxNNxu9Zz6rteePqOEkqf0S7yZxRfn6+1BB0ojouKPasOcxRDzKLQEo+JB70U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317313; c=relaxed/simple;
	bh=uegJ+8RLoxxTRW6gNc5D5RPMM2auhwSLgi+Duc0LorQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JMUVcMBojhFuzZzVuIkGG5YLA9//A6q0FZo7vAWFjCHgY/76jjcBn5SGNkWRtWJ2VPiKq5zpsnA3rRvf5U3Cb+ZOcGLVEZv7wrXwlGF7a47IwWrbFixRf2DxYncKUEy1lZbiGOYOdsUq3ZRFRZRjm4CLHSX1w9wz96jUal2q5Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=srI11DOG; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3327130c135so506212a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317310; x=1760922110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xGmBxaIsrwhsJmTSFTSbNR3poI1XoEoSNvgqP8h3X4=;
        b=srI11DOGPmE/QUuEvkAzLf6p7bkc9aRz3JhFc3CNRFapxPd0PuYkC7YADBpTf32h2v
         1ohAggbFACpMfll7ii4z3213a4nLeClpMSvCZ/lKIn3ltXI6J+NJjddaZKBVeX9F594L
         foTJKIkX48x4Q7aUzD3UVxR7dWkmTesRnnmNtI+3kH9I8tgB31XDMvH1Axc1QWxqL2Nf
         K/n8IqRIfSpEcDU/NhS1+QuaR+VJQ4RZchW6Lp8RGx4Rg3BJrdaxCtm9/yIhEFKDO2cO
         UDFpRmGvUq7O+x2C7t9KyLKXcCv4243FeTAPmjboiU+UUDOzJWcYDHbel4tmgDAvKU4i
         tc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317310; x=1760922110;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xGmBxaIsrwhsJmTSFTSbNR3poI1XoEoSNvgqP8h3X4=;
        b=ZWPFOt0pHmO/KOQGyboCHNzxJpdESTyVXD3pNyVygWN9siaNz83jc0x/oNpragOUuU
         Ht2l7jtr9DXo8RHtShsjQcwa89XEoNmf51EOSvpXgCR2BMhc/TEOZxcy/cBXObVfs99M
         IuHhzZbaHUP41wRsYpGlUO+r0jMnoYC3hVBnEy39nv50xuXmHiSa2/I0s9T0426mIp2T
         SqhKLcWxtQ3rC46IBkP/bU0RDf9hwFfb31kuZG+4+c/KQ0tWt2OTzF/uAGqFtzlEhKqP
         StKwD+uMhrFaMhDqkoz/boQqC+rs5h6hlmCtCfh8U8w/JwR0srBE9oTBvC/otxifuWmI
         IAew==
X-Forwarded-Encrypted: i=1; AJvYcCXXYjBgtywkNO1zoJqlNjHMIAI+SUXj1gfY/YSGD6perrCDLNncmC8Fac+9kaDVfqMLhci+0eX1NMKT98k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAUc/g8cgM5eRnQp7jM6pAaC9eQBtheJ9qfopfhXvHCd492s4e
	wLAMUxjjc0rXRnhT3nCqAh1t/6l7nQel9kypPf/31MCMcXfImsucTUUKegZBnkBsAxY=
X-Gm-Gg: ASbGncvl7FbLGTZOljU1nxNrh87dSidG1H8DnZutM1pqJb61uMfypyVmsInkDgomtmt
	AhEtXjRWa7DCcOg3KlG+hylWfga0rzU/J32azG/w4CGhoRqXSZ7y92Q9vjTEA4DZo42mNhjfODR
	R8BlAHhHEtdA7JbK1ljYemi+i2meOImouEDgRkOOKHdrEYi+qCtPVrhddPFlXWTKh8+yGItVtRc
	2d4jniEtn/MzVu2WKJV2/L6y8c6de2mbOto2blqaqa/nKcG/E/ZOr7Q7/UZkBcDv+8u5ikmO7yH
	tUNXxkkF3xZyo/t97h2rMoIxhbYt2GJAWUsYP+yfhrSSFkyZsuw/+7cpG8qlvtYJm5w1ygyFL/Z
	lrPKKSNK+QitcrehgQbqQESFKWFC5lmsiawqNO1Ty1etB7Bwsyg8iCu0fr2Syy+FWNOA/fDU8Mn
	T5mn04Bw==
X-Google-Smtp-Source: AGHT+IEdNeiQ4wkmg3jWNQmCnD1QT61xdTtWd43pEBCPOTtLFYBI/MtFdeLT6J/Z75wGvx4fFSNIgw==
X-Received: by 2002:a17:90b:33d1:b0:330:6ce2:18d5 with SMTP id 98e67ed59e1d1-33b51395750mr14768734a91.6.1760317310483;
        Sun, 12 Oct 2025 18:01:50 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:01:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 robh@kernel.org, conor+dt@kernel.org, sunyeal.hong@samsung.com, 
 shin.son@samsung.com, Raghav Sharma <raghav.s@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, chandan.vn@samsung.com, 
 dev.tailor@samsung.com, karthik.sun@samsung.com
In-Reply-To: <20250925130457.3476803-3-raghav.s@samsung.com>
References: <20250925130457.3476803-1-raghav.s@samsung.com>
 <CGME20250925125620epcas5p359a6c18a13f2a2f895433e4dd241020e@epcas5p3.samsung.com>
 <20250925130457.3476803-3-raghav.s@samsung.com>
Subject: Re: (subset) [PATCH 2/3] clk: samsung: exynosautov920: add block
 mfc clock support
Message-Id: <176031730436.32330.1825346216693912031.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:01:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 25 Sep 2025 18:34:56 +0530, Raghav Sharma wrote:
> Add support for CMU_MFC which provides clocks to MFC block, and
> register the required compatible and cmu_info for the same.
> 
> 

Applied, thanks!

[2/3] clk: samsung: exynosautov920: add block mfc clock support
      https://git.kernel.org/krzk/linux/c/25e476632cf7135aba11b27e3807a2692a3e5e13

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


