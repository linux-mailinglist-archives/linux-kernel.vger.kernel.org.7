Return-Path: <linux-kernel+bounces-849828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D7BD1056
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31678346E60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 01:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622BA1DA0E1;
	Mon, 13 Oct 2025 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5PlrC22"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EC234BA2C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317288; cv=none; b=F3TWUoOJZQuu6oOLap3UfadD/ao+09qTGQGiO/pQC70FYS/EhLWi2AOtr+Pp0CFAttCPyJ8NxILh9hbA3mVfLRu5jWAePhmrUwLo2gjTmsI4b03wiCrwJIxb05JqROxgXsizfNBLGj2M8j4zKhmpyw1i2GonsEoB4epgWWKdjZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317288; c=relaxed/simple;
	bh=hCmW5zBZE9uimTQ5vZvzqHkQrWXaCfMbVKZK0Y379fU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NzKCSFnNOa4ubVjTPMNKBtMmgV69fAMNl/ERfaq2ox0E7j40+xvowzpYuXUvXK7kVco7podw9mychMHBQ9d0jnTEX3npHHX8OBcodzCLQv2VXv/CslevjImJcaTnEfoz75ZYkwenoloLlzVoBp5ex9sV+7oTduYB5PSWOa0k4NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q5PlrC22; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-789b93e9971so286432b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760317286; x=1760922086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6Z1PIUihZ4CoSKz9QE5gP7AidgQI+jfdksvedwdF34=;
        b=Q5PlrC22f2GNThM1tOGYpC17lHt7rz1g87ia4BGWQ4cM7u9y0YJJN83Bgwqq0t8VhC
         eZBHEFu2IPTYUWzvYHaU/pTcXYTmgmjk0TnPoJ41brih2ybDjyBpVSqVniEEKbnmT1ge
         m7igMIfr1Xz0Y/Yczw8OP+C/LggxpSesv5D1b/Cbu0fnfuh+JUVzAhG+oPiw6nJJASt8
         bdNOiXWwEuOYyDx2i9EsgS2KM+tbY5AVHc+IELBUFVSmnUTfUob6i4W2HRa7j8S+mo6U
         26QK4/4Qdf+EXhqYJQfzMcaqljCKwhLu/JcmWDaCubJGcjnwdfbMFaZ6xFk28By4n2UF
         kfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760317286; x=1760922086;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6Z1PIUihZ4CoSKz9QE5gP7AidgQI+jfdksvedwdF34=;
        b=EnPg1niW5CjuBkNQvan9+BgovHQi3eL3H2iPz8FfpFw9w7qc7U6Ca7nD6LPBCqJLqR
         0FCNOs1cRY6TMHL+cN4xN67EDmVKLfKbmqAFeGeXAKF3+3MX3TCoCHFXsrM5v4rpDq3w
         CgWKlvnzhuvCpUk88ppPAY1z8eoOw4eY53mzinuC4X81m62aqGMSs7aVzfej9FAD/P/s
         FkLl5G7UQaSG0tBTU+CocZaOSpNXMGL5JAcL3vwIhQUxO9I3X/u51EwnxtmsGv87H8DU
         gPeGN/BI0dG+SO6qVRt6XIh3kUdxzqg3hhhF4ewhsiEFgV82NHXsCgN/zRduqfGv/Fmk
         yfvg==
X-Forwarded-Encrypted: i=1; AJvYcCWbZJpsg2C2NNlZFxXeGcRZkSHvVrQDCpjUKt3URzMWwaJzOqh33GLzKBHon28w4iejo8/GH7pXSdUoy4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUaywO69Vg7u4evEESnTgdLdcAJ97SuRNgBhP5dpRfXcfyCWbt
	H14p8xBfQwmPfWTwprI5Q73h8i6hQieoGeMRt1XRznau6kj4TjbkGmoasxWHNx1GZwM=
X-Gm-Gg: ASbGncuKw+2yLErWiUUxpHABtxwyPwqTNKWITuza7F4VeXlbI6GsQK2SCNqM6GlI99V
	O5UmpLdn8FkAjhg2p12GPad11tDVGLRjh6ePD2izrdjOOFnUJZiDxjz9OIMgzojJXbBVUnc9Jko
	7zNM7uv8StKVHOI5C85I8N9TGBfahfuiyIpj9THys0JovnahR0vxFopCvgCK4uhFEZieiWpiYsS
	pGSL+89FH2m3u0s7w/Cv22U3+Bk+weFXWKF1o4XiePAB0Psu7g7AnXtpfOECcPPj9qw69ydPPae
	06ys1fj6KPbBu+U5fb279OFpKF2NQ/tw6M6fWQVS9J1J/4EP8CFzaHxxilxgIZ1nsYeR1/EO1nY
	28TdL7gx6GHN/nPgZx56KMiizRD02gs1IuIEx5cd39RTzi4iVTuQru36TESWV
X-Google-Smtp-Source: AGHT+IH4f79PGF3pwTJWa+RZTaKvtY1wF99tutuYa9r5c4lDGKIA1fkdUmCffSl7ZEfXNQxSTp20Eg==
X-Received: by 2002:a05:6a00:39aa:b0:781:1f5e:8bc4 with SMTP id d2e1a72fcca58-79387a281famr10486681b3a.6.1760317286563;
        Sun, 12 Oct 2025 18:01:26 -0700 (PDT)
Received: from [127.0.1.1] ([121.134.152.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e2ab3sm9512805b3a.64.2025.10.12.18.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:01:26 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251007-power-domains-clock-google-gs101-clock-v1-1-1ee73c453ba8@linaro.org>
References: <20251007-power-domains-clock-google-gs101-clock-v1-1-1ee73c453ba8@linaro.org>
Subject: Re: [PATCH] dt-bindings: clock: google,gs101-clock: add
 power-domains
Message-Id: <176031728187.32330.16757640384726154867.b4-ty@linaro.org>
Date: Mon, 13 Oct 2025 03:01:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Tue, 07 Oct 2025 17:03:10 +0100, André Draszik wrote:
> The CMU can be part of a power domain, so we need to allow the relevant
> property 'power-domains'.
> 
> 

Applied, thanks!

[1/1] dt-bindings: clock: google,gs101-clock: add power-domains
      https://git.kernel.org/krzk/linux/c/8c644749ab6e42f51fce82e3325f58ffb70f87b3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


