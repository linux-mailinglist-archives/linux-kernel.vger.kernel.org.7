Return-Path: <linux-kernel+bounces-735509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5CEB09050
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E40A13BB808
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AFE10A1E;
	Thu, 17 Jul 2025 15:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZZs3xyPZ"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4763D2F7CEA;
	Thu, 17 Jul 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765250; cv=none; b=RdmW1vALZZjj8N8czpM8QwOpBPu6l2FTVS1/hOGRdjug0t1Ua1WyYtgDNCh+lWrTwAWh1yiF4iWYLfLkYriEezg5ij5VRA/EtIl8+f0NxLzTXpEjHcks2ixXgO7VsFnAx1x9NgpuE7EzcZn2WtuX5Mj3/rME6T3xXueDrVHVLMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765250; c=relaxed/simple;
	bh=lKGMjncX/mlUAU2zGGZERev2BTvi5rrbEiYnIUYLlPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxTcBNeP61AyHuqmY00jaEjTKRcdDTtjx2mcpdNPm8Nqi6QHUFWR5MVpfR0O9dNBqGLP6uzMOksUY9cBsrY77QLhB7XtGU5F19v2qD7Y56oudMHOcuKbLenPjH2GQuixvyqor1+JnYS4owRsYL9EjL4TcTQwItuVC7khOhdXZg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZZs3xyPZ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235a3dd4f0dso7074305ad.0;
        Thu, 17 Jul 2025 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752765248; x=1753370048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKGMjncX/mlUAU2zGGZERev2BTvi5rrbEiYnIUYLlPg=;
        b=ZZs3xyPZJGseOx+n+DV43beEkm98CTtzbGKbB4MCOqe2+I5x59MmBhDZ2O2sft6q0k
         U53VsQaYYody3wTE37eCkxvUbpEzesjVZSRni0SxHSyQ8UKay/A+FGHIs3fWvnefUL5Y
         lJ8mTPWxFXPjO0yzGVkXbikCJEfzN9D1loitRNMobljuNVMSsalcSg+yygOkfTZtucpI
         F+LOBlbYF9/7pQ0W/hxWet94MfqpsS6fnTaYt4ItqQgVfx4fLv1nhSX8vLm/DLESnxE1
         mMEBG7MDaMdetXen8LBJnDyylhA8MsAK2w+mY5+KcYo811s9aOSyQfOzq8PN6iQMnK62
         jY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765248; x=1753370048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lKGMjncX/mlUAU2zGGZERev2BTvi5rrbEiYnIUYLlPg=;
        b=NLA20D4wbtDIyiYztdBQslN2fjLdT8/dUKhKvHSLhujyJGoirkWDepCqJQOLqU8lMp
         gUYjxSV9w3ObsSXpIX/1wuXdIxeR1PZbEyz6HHS4azl8uxmi6cZzrZXZB/8AqDHwYxQA
         WaPxyOB26lP2XZEXMi23/lQIV47WXbVi2a4owQEYfKxVCaPtlGlrO4nqwE4Nn9TSaibf
         EvrLrRCcaNlTc6q/e/hsTHfRQBRGRtlEAV+Y/xF51+i4ZymbgbExk9t+DIG157T+5hGk
         f/qYlscskonK4+7LqZtUdfAq7wfFPU8KXPt4yFxaDskHBHo1Zv+diQGpl1I++cvBnKmu
         HiQA==
X-Forwarded-Encrypted: i=1; AJvYcCUcQlZKzChEGMJ7o9Zl22YiuEhugSo2wZvy7vu8W1fNDGD/2QNhEdmgNeGW1r4aVNATGOmhyD3w9qWPAKKz@vger.kernel.org, AJvYcCWs0BmAeY7FUSfwTHTvHO2mY1RxP0OBp/RaAOe/llmBS03Dc2pbaSP/CHldYGxRIlb7vl2YXx/9bO2J@vger.kernel.org
X-Gm-Message-State: AOJu0YwfXlo0FQOj7SXXr+ju3K5qti1PYOX7YZr9HFxzWaUU53viOUt+
	H6UsMVZ5JzwLyM32Hqrv3I424/hUx9/8Agea21rfYNOrRZzuvWtIwuYk/IsZLqtQGV2vrZKyc/z
	eecinSm/uu0MjgA9JaahfFYFQvcRJixE=
X-Gm-Gg: ASbGncs7itv6dY3wslHfeh3jk+wDuNWsp8sN96Nid6tAiB0KPBWb+QYIrACAVNbhuoQ
	N9/WBE6WUqvT5jA6pNkNtjYihZSmFU3Ol7RxUOT6vua/5jesy7EH6OSglZ7OOwWBc3bmpqZ7wSm
	ZJOE6PG1piw7NPuGrbYuPsZ74cbNEG2PVEyuieyT9YHl5X4tbAG9fBq9xcgKrs9HsITg7Cipvbb
	tW7ZmG7o1fNqNEbNpFdHA==
X-Google-Smtp-Source: AGHT+IGEcUpqZvjSoFcO58ZOCNsSb/LAfsi6094uuFw9Q4nipCPPgnXCkZ2zqSgvRxqzK4GGlVNxIeuhc5zwAnmu/D0=
X-Received: by 2002:a17:902:e884:b0:235:779:ede0 with SMTP id
 d9443c01a7336-23e24f56b5amr113031975ad.35.1752765248352; Thu, 17 Jul 2025
 08:14:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717-fix-pwm-node-v2-1-7365ac7d5320@amlogic.com>
In-Reply-To: <20250717-fix-pwm-node-v2-1-7365ac7d5320@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 17 Jul 2025 17:13:57 +0200
X-Gm-Features: Ac12FXyF3gZCkEVrEH7cZlh9FPBGQz5KwJYE4HsxaOf1LrcBSp1OtWqHFqnn9kk
Message-ID: <CAFBinCA+y1jLBt6G9XWQyoaZOKvPaDEGYp94hu+fPSVWzOpgkA@mail.gmail.com>
Subject: Re: [PATCH v2] dts: arm: amlogic: fix pwm node for c3
To: xianwei.zhao@amlogic.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chuan Liu <chuan.liu@amlogic.com>, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 11:29=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> Fix reg address for c3 pwm node.
>
> Fixes: be90cd4bd422 ("arm64: dts: amlogic: Add Amlogic C3 PWM")
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

