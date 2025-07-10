Return-Path: <linux-kernel+bounces-724992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 412D8AFF984
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 370651C255B9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297E28000B;
	Thu, 10 Jul 2025 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmqHRrGg"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C69C2877E8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128008; cv=none; b=Dh3E/rYHXNfki3G/x86AdfY9FgoDs64zytixzzMiV3Xu98kSGULLw52okbecvc2HN+TOj6EyTq8/TU2BSpO5tATHdrtoGQrMAn+Z6WauaK7hlJeYBc1Hxug+dTeD0zM8CaYkzKx/ATDOgyNMbE4bc78YqmJm3PBMZ5o+wDTG4zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128008; c=relaxed/simple;
	bh=qIGl3ofMZN4YGC3+hkJsdrAC35OHZlbE6ayWuOboDj4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RaqmprDU2lJCcFpO1hX2EWvffKvfSmhT88t9+jhGGAaIkOz+1L9rser4n+204S2zUs9a5Tdnc+yy6iRCBUKyR5bush2KYLmBi3kWFjhCm7z0Ke72u1yUxV+99m1XIfCR+BhqCEyAi+eoE06xtSRM7rp6tZ3ilMBao9YWrOU33gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tmqHRrGg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453634d8609so3092065e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 23:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752128005; x=1752732805; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qIGl3ofMZN4YGC3+hkJsdrAC35OHZlbE6ayWuOboDj4=;
        b=tmqHRrGgF119Ca7LrTG9ZjPOTC1QplpRbxALP32kclNpwJtAi30wUtPNbvlGDSa2s8
         4HivoM5G5GMbDrgZAJGs7FtuRtzphgEkEZ4h7BSbb2vVcL7ptZ/SH+q1xyZpbUK3iWs5
         0f0MxLd1V2v1tqPI6vrd+6NhDaDR1MQSH+psCcozHJLLs2iFCcbA7yB+n78rzuKSirhu
         gGBKPHrs3Kzv2r2KaGuBM2IyK/o22C2ktLLpEgAayainrtVVGNNoZPW1kSEgMk60Tk9M
         55iiBN7om6Vsvp0GA4IYqBPyJNyKgxCXQlBPrLSB7N9k4hl1ZpG23R49fhkdzFm9Ky11
         13nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752128005; x=1752732805;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qIGl3ofMZN4YGC3+hkJsdrAC35OHZlbE6ayWuOboDj4=;
        b=XdLEZTr3lwSylbxAN+bWgCFt3pZ5qekQP+4IIwwoB3hDuSeez0jQXAvXTfcBNYndqC
         A+x4tXtAzJQZLXiiOLcs5ZlzAGRI/Hjq8K4YKQwW0L1xhXjB4onxGHudM8tqIZNZTiDt
         LahMuXOw6E9lzGKHTPa05eqK7rat1Yw5tzzXdptsQxD/ssd6faQNL8idPdCtkqm0UeYH
         +Q6tZgEEpzZltwGzKenNQx19VsDiBq0cIFfy9zJev4KVwL5K7jEQZVwTytk9bf3VHJTX
         QaQA9VgCk+F7fIGWGCRqLec4N77nHq9en68g4RRKVO1uVeDlDZFUawBfXdu4jJpGX9a1
         jtpA==
X-Forwarded-Encrypted: i=1; AJvYcCX1k261ZxqxIVh95j78c3xeirnqfFn0FBUHNEvCg82qWreygXCdgdByGB8B6tl9qdKHkrCB6tc9qh+ba2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoQduzc0js3cpHl9dUWCnwRQZnTiAhyNOLIfTsZI+N3uc+UU/P
	YBbsus0fjq0BRyojp6qIftk0+RE4yzZDJ0LDDn8eH6OJhbU+Du1cR1kuiLaD/c5nf+4=
X-Gm-Gg: ASbGncsR3ttY2DUe/dQP1kIhsQ1DOcFZ4cez6aeQf5ZPMwXiKxcYuOe1RlMnZtXIEYs
	YPc+wfhL/r1W9G4sF0ozDDO0LAaMzRxpthN5MiJomqSuyZG47UrCrLfyEg35S685lkF0Iy3H3wW
	oJ2tNu+DiHkbmU4U8/x29WAcvri3Q2gl/PK0pZ6wxuWAEVV8mdXKQ8zRSFDCVjScrseAFFI69XE
	2MHDPLBVwahZFWjakUH40uGQ3LUq6EdaYN3ABeLd4oJJEME9FFENCobqNKSbLSMio3c6vn6BW9O
	wX9Jwuu6SijCg85yvetxK+TB0d/0W3O0OUb/Z1P2v/c6sHQ+FrJNLXUFp1YnkntJxg==
X-Google-Smtp-Source: AGHT+IGiIzBae/Gufxz9lausYNLZM0rhTyqOuwPMyv4+f1cfDIVfKWfit+8EynHpXSbDAsUNoJUfhg==
X-Received: by 2002:a05:600c:3512:b0:453:78f:fa9f with SMTP id 5b1f17b1804b1-454d52fb600mr47227905e9.11.1752128004704;
        Wed, 09 Jul 2025 23:13:24 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8bd1741sm928783f8f.18.2025.07.09.23.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:13:24 -0700 (PDT)
Message-ID: <e653f4b90422ee9ac09c62292dfb7a2af1f897d0.camel@linaro.org>
Subject: Re: [PATCH v4 02/32] dt-bindings: clock: samsung,s2mps11: add
 s2mpg10
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sylwester
 Nawrocki	 <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Alim Akhtar	 <alim.akhtar@samsung.com>, Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>, Russell King
 <linux@armlinux.org.uk>, Catalin Marinas	 <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Alexandre Belloni	 <alexandre.belloni@bootlin.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
	 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rtc@vger.kernel.org
Date: Thu, 10 Jul 2025 07:13:22 +0100
In-Reply-To: <20250409-s2mpg10-v4-2-d66d5f39b6bf@linaro.org>
References: <20250409-s2mpg10-v4-0-d66d5f39b6bf@linaro.org>
	 <20250409-s2mpg10-v4-2-d66d5f39b6bf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+build1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-04-09 at 21:37 +0100, Andr=C3=A9 Draszik wrote:
> The Samsung S2MPG10 clock controller is similar to the existing clock
> controllers supported by this binding. Register offsets / layout are
> slightly different, so it needs its own compatible.
>=20
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>

Friendly ping - can this patch be merged please?

Cheers,
Andre'

