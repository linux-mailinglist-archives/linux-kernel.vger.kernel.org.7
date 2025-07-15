Return-Path: <linux-kernel+bounces-731991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD562B06100
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9645A08D9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCD01EF38F;
	Tue, 15 Jul 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QvY0BD7k"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894CB1EA7CF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588096; cv=none; b=g2juJFZgDlb25lIvavpjhCcn23RhyekNPyPsOISC3o+7aWv4/vsPHfE8DhgrJHDq/BcLUFGGpTp3/Y+zHzyldvU0Vad8mCuy8T/sJRrkgYvc9CSQdzUW0U9+2J6xUacuQs1MthKaGwZ1OhneqTwL+jTQUG2L2N5b5aX3tHSs+NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588096; c=relaxed/simple;
	bh=ZehdloQEUsP88pigCl64ebfictbezAWEu62Zt8m49sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=in3738IZz3cje74Nys62a6MqZiYu7X8MYRBuipL0OiukdJrgSbaPeXedgfB6holnexpHWDrs3Ki1IovCDComo4sr4gaazD9eIHIhvAUYDg5451nbpOxuhqqytFepoxdWk0vxvLIJOAlXyXETj8nGZKGkJF+fqGCKTDxQz2kBzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QvY0BD7k; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-558fa0b2cc8so4332674e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752588092; x=1753192892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bMq+z0lTQ5uqzjIe7ORBXN+DvvALIfquyp6XwhodWKg=;
        b=QvY0BD7kEfcCud+y9Vn9la4Fhw8+G1Pj7wEoK8gDPvkl4zKp9bl7iqOzj782EBceI8
         ccReZhCWcgz0U+kk/Fz3fe1AHdpnmsgU7vg9D6uqH4g/knnOoFg/QohesoucuXWobWZE
         Jfwfkv9ACztJIR0ezHVsQKmI2K+lR5LrDCdZjl7NSSpRbbn9vfYxIHCqhMBSgUSUfE+S
         5Bu0psetYdQjfc43FYJ6ctq3aboaPPhqRn+LVVOAumjl7iXH89p73036RDWBPpKFqjX0
         A5JwvrfnOwiJYCkBU8dOenOH4BFru8Ww70tQzbkf6cNWTXcY78PSVDyOTVH6hrbviHrn
         FPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588092; x=1753192892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMq+z0lTQ5uqzjIe7ORBXN+DvvALIfquyp6XwhodWKg=;
        b=eIuqOFKZFvuog010+YntZi76DOfF90PiV5uON73XClSJyg5gzG1pMoxc8IK7TNgyG9
         YHFTS4XynzuqUBJY6NE8Aufoo0LOGTrGsbA/wefRcpSFrA/cXcivWjtxQOyTD6qBz/W7
         2liCOepX5RykYC11UP+6H8w2qA5lz58bZbOy+CIz+uP23qRL6IlXKoxTcS63qL1Isdvd
         6Z1ZyE1wdClIFHaOFKtp78VhVeeC1jtYoCYETJorXm2E211+1LSoDk9/oKIG2DpdWWUX
         pffLC2asYJnBp1WuD9Z5mfdXh5898zM3egaDc5bI/ryLJfDiGMoFb3YU8f5RGnY/KB7D
         6ziw==
X-Forwarded-Encrypted: i=1; AJvYcCX0AsDuE/TpiJM7eg7su7SS0RqXcIH0jSGRMZOcJP8xL4VyKAw1nkQLsg0DSLYcYqWL1Q4mYPpcbf/pakg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTlfNjaWPIuKbbwDDyPjTDnfPCuykh7OBJT3wBNiihxaxt0vdj
	G6/OmxdVSnT6rvQPXDfdb51b0r8JQvrlcbcfJEYA/mZ+nLhAsqApraSkORAzZzt3pR/pSXR43cg
	987nG9PjyQHM6zMrWAHmN1CSQNEh8tbnb3AvxPTFcvQ==
X-Gm-Gg: ASbGncvQgxJr5RQNrg5+DxRSFHSJxc84qqumJgfGxFKFhpwZZc1DKe1sft0E1OAZOnZ
	LNTrvcltZzRb/qryUQa2bkuqID4l2H+k4X13xilnfLVYItNQMt9Atuf0Y6KO3ja9zJGJyo2zEAe
	5F4KRzxRbRI7esSbQSsJcAEhdfihSUGKtsKjHv0b646lOF4y7JJ7PnWKwiv0AMzBkKU+v8UgTTd
	/GNiKneba58/9R4CA==
X-Google-Smtp-Source: AGHT+IF13ylGotB5yILT4bHb/RqmaS522PnGXIijvb1MELLLon8vaTv/g4ADQmp0eDqrLOLp5d2POnBSPsqQfLVeuyg=
X-Received: by 2002:a05:6512:3d0f:b0:553:2f47:ed21 with SMTP id
 2adb3069b0e04-55a0460950fmr5418782e87.41.1752588090141; Tue, 15 Jul 2025
 07:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715100415.60487-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250715100415.60487-2-krzysztof.kozlowski@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 15 Jul 2025 16:01:18 +0200
X-Gm-Features: Ac12FXxwgG17tM0pR7Wbn7eqRk8ggfOlZMUUBSReGExBS5bLfNdm4fWxeml3fXM
Message-ID: <CACRpkdZn9ePtwBnxNoy+nijc-oqu5zWoKc2O9QDe=MsgZpRdKg@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: drivers for v6.17
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 12:04=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd13544=
94:
>
>   Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tag=
s/samsung-pinctrl-6.17
>
> for you to fetch changes up to 683d532dfc9657ab8aae25204f378352ed144646:
>
>   pinctrl: samsung: Fix gs101 irq chip (2025-07-05 09:35:22 +0200)

Pulled in!

Thanks Krzysztof, excellent work as always.

Yours,
Linus Walleij

