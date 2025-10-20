Return-Path: <linux-kernel+bounces-860183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4985BBEF880
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A77E3E0E79
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893932DAFC0;
	Mon, 20 Oct 2025 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s3C7y5ti"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49442D9497
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760943354; cv=none; b=L02JN8Dwswx4GLiYJDY17UEFQjtLTZcgLKtw5D9AAFEEi1RlELxaSadIfBCvXmCEGtAuoeNvkydMZGbeLWxyL7y4qH6c8CxisII1CLWlTWzIgd94siJkTGMv0D6sMiV69+7Lp4g0HQfBIs5WBMLl/UfyN/QFUeBZy+aN/kxC/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760943354; c=relaxed/simple;
	bh=IKZ1q6LfIYFaUJY0dyFQno0dTQoazdrIq/AGAGI3qVc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QkV2RREuu4FDKOxvvRzb1K6vgDDUqpWwVNoS4RL7zGaIGdU5YLN4BrW/Kx6vkk25osOFjSHcrETUL8NLHPwPiB+YIElFJsrDPiy3G2bVWByBxCewDIhyvXCi0oVblawEFFkz/iCL7OPav/DWiyVIOg7zGNZwTpw6eHScM/x2h/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s3C7y5ti; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3f8d2180feso60788766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760943351; x=1761548151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06zgkTdvLdS4MNITPMlUpp0m9/L1LkTY9remEcOcFr4=;
        b=s3C7y5tihsoPIL89q5f/2OMvqHvqK/8wDNfPkGjWu4yawYC4cTTA6YlRFkRo9B9qEr
         rmmtd1ylbPvBpO1JatrK2Yp1DCyWGKkjbvQdguyLiy5Ft2J8L8HMb3AjYX2sYVD7ptLN
         J6QjQ52MYQPKDVOJS4KBX2ij3v+sFHL+YfynPsNY7gtT77FPEzPYmAJcu9Xcxh6eIlwg
         ++xpJBNojPz0wUIaRZZbBQKqlP3p4NsSTOKc7QzrL1KDerc0l0USM2yoWao0X9pzAiEu
         TvvcB1ODyNSm1uJ2cuymCJlERI2D5l6CvRfAbjAzvDCKe1HygsJo5lbYgSJwhpprYpvC
         AtbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760943351; x=1761548151;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=06zgkTdvLdS4MNITPMlUpp0m9/L1LkTY9remEcOcFr4=;
        b=UwrWXEWapnVjJrWePFa1PVeOyx+KjAZS9SK26t8RdRLG2z90guKa8/lLk4WisgvFOS
         7hVEk6bLJzBadqV8GAV4E/wAotczonybbA/EcE77h6QAV0UWrjnnmCkfDBu/9itPl5iw
         rLDO7bE8qz0xX4RNEshFPo31tbIanFPkeZPr1IwIlkhO9F4VggDmz8vfEzttrfykLs1S
         WTLDQimucAKcG9w85ie+vAaKTAOVwlQ04j0LnQg0FU/t9Gaekkj/JGYmdmQS4B94ewRX
         vrS9d5oXw8BwjT7YHgD4ZVE6bf1tsB1sfVUj8d6DdCl9WPT3ZdNlGUKcqnBJFxo0Q76L
         /Slw==
X-Gm-Message-State: AOJu0YxKNoJMJjtz19P2frsDm0fbaxpFfRh9zZUp0Z6F/INwq3DY+qlX
	vwK7EM6IwjLHM05iVpcqSlXfKtwPErC3znUrnwCcJveMa/zZFDc3pal6HhIavbuva38=
X-Gm-Gg: ASbGncsZt0HYqi4MDcSVSXTcAfkxijh5lwG0SMsbTn1YRFAfIJsT5SlBghuIQ7YY+j7
	nKAGMO62/Iw2OahUH+Ww6ISJn7KLigCFTTR/OY0PDmQ0G74pD5CZ7DptFZYMGRAxc+t+LcO4Yq0
	Kc0y5xHZXelrvQmvJ0PY3h0hE3YUZMdI+eoIoc5AZwud0Anly0m1CYVrJiplYKDwHKW6rn4B/xe
	6Sbd/7rG5kTY6ZFafRJxsGshSQG+f3OuhwWg9zipodfOTGGBuqkk7fExc2AHcy61+GahAZ9TRvi
	j4i2wjkoxy5e1hLz3awXOuOoWzqwfs8s6UB207Zgs8lZbGMir6GRuJ91J6cYL7ITyvDTUOjQeUI
	51qmei/3mKxoGmlAtKrSzkQjcbh6N6mvR/WwwFGYOS8O9ag6VJRFgZNfSWsCx4ZRtqR9CXaqGmE
	c+ne6OJYP1s5fbxYQobHY8tI6iMd4=
X-Google-Smtp-Source: AGHT+IHAht6KxB0Ngh4X743mU/9uv/8gNjvcOQoHdUUnr/RK7iqnks8KTRJG0OT6ymzSEGD6XZTvrw==
X-Received: by 2002:a17:907:7f8a:b0:b50:891f:66ae with SMTP id a640c23a62f3a-b6474639388mr840879066b.9.1760943351216;
        Sun, 19 Oct 2025 23:55:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036a3esm711731466b.46.2025.10.19.23.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 23:55:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com
In-Reply-To: <20251010-acpm-clk-v6-1-321ee8826fd4@linaro.org>
References: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
 <20251010-acpm-clk-v6-1-321ee8826fd4@linaro.org>
Subject: Re: (subset) [PATCH v6 1/6] dt-bindings: firmware:
 google,gs101-acpm-ipc: add ACPM clocks
Message-Id: <176094334888.18498.257368855953115301.b4-ty@linaro.org>
Date: Mon, 20 Oct 2025 08:55:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 10 Oct 2025 12:46:31 +0000, Tudor Ambarus wrote:
> The firmware exposes clocks that can be controlled via the
> Alive Clock and Power Manager (ACPM) interface.
> 
> Make the ACPM node a clock provider by adding the mandatory
> "#clock-cells" property, which allows devices to reference its
> clock outputs.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: firmware: google,gs101-acpm-ipc: add ACPM clocks
      https://git.kernel.org/krzk/linux/c/83c4e3c39b2b55afe56ed0d14b93b5f219350c81

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


