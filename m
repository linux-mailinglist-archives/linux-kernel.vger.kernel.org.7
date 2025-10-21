Return-Path: <linux-kernel+bounces-863588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3562BF83F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88F4F4EBB44
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 19:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026A0351FCE;
	Tue, 21 Oct 2025 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RjfCV8K2"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45E1351FB7
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761074832; cv=none; b=OIQqJ0ZWo4zHd0PzNd2uCAmk4bQKLe+bmSNYKh7WFnniDDOiC4pBWgdTCThMUJN3GbXuhTcOtSfAHswwiiMAtrmD2rfOj+9TeJeDScPbFZCpMCq+BKzD0wO/PnRlq7gIddlZeSWavDIps9Q11edKN0m0yrkQ0FOF7kYTg4cRPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761074832; c=relaxed/simple;
	bh=H7mmLnyjS4IJj8j/5Cfb777523++/Yd9MxdaxBFMvi4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xt1fwYoWKoFivIHiym1e+Z+2q0yESQHtFW+sS0wkE17VuJT9WDPOqryEYGCM7U+VJiy0hr+HUqArUdguAczbSSuVihqkxu2RTEXiu8D7P/W/HEZPMobzMCmq4gIuuaHsTSglDeLe4zB5Djpn3M8OHqNUfBaTjbGehPdvq47LsTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RjfCV8K2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-427054641f0so897314f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761074827; x=1761679627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ibZxuBONFvP6tEfHo6ray/hwM+JhW2wvVnRgxqq2YE=;
        b=RjfCV8K29Df2WMDDautePGhbt4yPIGXXLemqb9cmy/qDY+kqtUaInAUH8IXOAVwNM8
         4vVC+BfmXn243+566kVfTaanfMYJR/4icPDIi9JbUzHP51+LWdHAlOkZARxGx8Ow1Lwe
         aNVUMdhDaYwxVynnhUegwo2e6k0xRK/rtTCQbUUNgb/RyPoSJHBttg96nrt2GeEBFiwd
         TGFV+QtblNI2Uq83wHfYmWFx1slMcXUFHKUP8P6n1DS+yzg+xZOOEf+I/DbWu/q2N8d2
         ei7n9iL6vZYQTB53u6lnrhjTOk2AimvAMxYH9+IVAGsNlI65to1b1ssO1HtShwo0VRRn
         HCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761074827; x=1761679627;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ibZxuBONFvP6tEfHo6ray/hwM+JhW2wvVnRgxqq2YE=;
        b=algTuKfo85dQHz325Ujh1ubGeUHlPU/SRZ7JkjYgmSxv6dsXyupkI9uZQSe9itFN89
         MT6fk/9p/oMiR2zT/b7fIXVh/PnEhUYOJplWZP1n+4qLH8LLMdGupEmIO/Eh0c0h1EG+
         PHslw45yKTids3cDVfxrVgRbzrbQrw8TMMdbsYuvEeZ4TOHjNdjQMt5RRAukS6jrVlsr
         U7jRxJV6j8VhokQ3CsuOXS1nmv8hhaJSsCAhP1xXhoFsT4KPvtlBnMovsPfm7bLPcMHF
         M699KI1FZS4zKG2URAWe2OKk19EoUpWY4Ag4bEnJ1Hq5Lx2kw7OfOhp/SjRIOWzhQ+sR
         ZtBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9fHcnPxWiAG0mXgBlD0CEaF8t91+l7eNtUsLtf/AYc7a2OSeUUJUd1N4Fv1LAxyrC0FQhqvlzFqdH0x4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGr5xt0x0drlGztSE8EhZRtj9NelCa/iMlIjhHz63RpTeXeQH7
	0ScBIfq+IK64j5h92iwaImUO+98Bh+tB9iHm4Oyx0K2o8AWChL/SNPLhJLPV8xJdOwM=
X-Gm-Gg: ASbGncu4jwIDLmuaTA8vDXnJmKDXnmAcPOwlaYWJAgBHacb3fyFv6GbQuRYQBT72Plq
	rfIhujsDPNalGOffJ8zlfbD9smwZ2Eyg+NXqK9cMyEevC412zDOcbNm9jGs9ZwHDOOL+gfvF81g
	k4l6qsTNzXuVPlNFwxbxvOyxaV6cGbR8a6Y2+B206VGxYlqAf1ZY4NPzAnnqvRRgLpQSREzSJnO
	Fndf8zsPgw8RaL9JHyxaKnK8fGa0NTwfCuTPL+mzByY2PUwKs3CTYJPyYbSg+B7GKtiIo6VQP7v
	liY5DnIfa9Nn4ZkKxMWRMOvaJHVhS4h7X1+kOX4lsucJ0qYEaW7u9PnDuZt5YTPc0wZOpJYNvL+
	3acq2HxMZynZHOcjbDAIrZtcZ958rswZ7lMGhb5fn8HoPWh3BztCsbXRAqD318/WipO9PSd5THt
	66tooOj5WgA20KTW1At+iJqY0Z0K0=
X-Google-Smtp-Source: AGHT+IFxRo7mh1kCIiwBlgFSzvscGIsov6AOIfRYcDiKlEW/2CZnKxnmXX+fOq8J1wvQblUD1sFg2A==
X-Received: by 2002:a05:600c:3106:b0:46e:31a1:c07d with SMTP id 5b1f17b1804b1-474942605damr21467615e9.2.1761074826918;
        Tue, 21 Oct 2025 12:27:06 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c42b48c9sm7839115e9.15.2025.10.21.12.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:27:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: Will McVicker <willmcvicker@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 kernel-team@android.com
In-Reply-To: <20251013-automatic-clocks-v1-1-72851ee00300@linaro.org>
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
 <20251013-automatic-clocks-v1-1-72851ee00300@linaro.org>
Subject: Re: (subset) [PATCH 1/9] dt-bindings: soc: samsung: exynos-sysreg:
 add gs101 hsi0 and misc compatibles
Message-Id: <176107482513.33931.5052547244710731509.b4-ty@linaro.org>
Date: Tue, 21 Oct 2025 21:27:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 13 Oct 2025 21:51:30 +0100, Peter Griffin wrote:
> Add dedicated compatibles for gs101 hsi0 and misc sysreg controllers to the
> documentation.
> 
> 

Applied, thanks!

[1/9] dt-bindings: soc: samsung: exynos-sysreg: add gs101 hsi0 and misc compatibles
      https://git.kernel.org/krzk/linux/c/33fd5a7103959113ea3b60389a7582ec0cc2f15e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


