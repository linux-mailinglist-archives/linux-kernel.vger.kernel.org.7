Return-Path: <linux-kernel+bounces-790742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AF0B3AC77
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 23:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E432F17C6B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8E827144F;
	Thu, 28 Aug 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cyq+MfqN"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6717C21E
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756415200; cv=none; b=EZh3eBPbjV3P8BTitFMSthHwlPOxXIuv8rjP3t5APjH0qxHbnNmwGBEUzXls9bx3SWCU4N7v4oGOMqEJfJVPv+QEvgkZqgkPClEFkzKXkrT5KyNDXPX/44GUJ9W3JtJ6wcBkJhVRgmwYzedBN/k4Lu5jb0JnNEuzs4JXfCclXsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756415200; c=relaxed/simple;
	bh=7m+Z48htqbSeqaszf53BBB8XMcsMLgtn18U/+YXKB3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/65mk5X2v7a3bswpDMk045A8u3Mp6+dT8G7estnSiZxQ0ooO6w45jzYD1i+O0iJJ8PgpwANEouSNi/Z1ejSnzi8dJkSj7biPm51xFJHYhlZ01Tivr2rbSWnjUNVH5YYdbZFpJJngIsJxy0GajIOY1YqRYOTqWawlhIg8ZNBsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cyq+MfqN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f44d5e6f8so1514407e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 14:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756415197; x=1757019997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m+Z48htqbSeqaszf53BBB8XMcsMLgtn18U/+YXKB3U=;
        b=Cyq+MfqNRcRe/faS0/tIKOI0CgfcsXCbvqF8eAwjwZoRvKVVI4BKC8rvv3VjnYLEng
         VHGKk5iMfptjtvPPSPto+ZYqD5IXds0PtYzBk/5iGedPuwjQfbWVhGh5AuwezYY//7j9
         +Xfbo287y3XVAerUMMSAf069lWVM97jfxC25liWEvioCYb3c5FQBuEePbzzELI1IDM2n
         TqCOgPywqHrgtTdmcAv4HfB/Q7QCdapGG0ZbJWKSM+0BHGYQ9L3vVe1YKyXkRcWg6X7/
         SPI7BYkIlF8nan8kHEZhgOyzCuYrfMePE4yo4Xeu6Eh/U2CahORkVJ7aTSNmnQG2ZaFK
         N4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756415197; x=1757019997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7m+Z48htqbSeqaszf53BBB8XMcsMLgtn18U/+YXKB3U=;
        b=jRZWLrzbe+Vejiuyf59z/W4RP3jSp5K1mm1CgNmDNJg5xFXbqIsCtEmCOSrWgAvb3L
         DIkFeeBwNq/kwNaPhZ6xyXh67qJbxu2ZVjPmo1jaUgmFv01pKJX9YbJzPgslcO5wGJW8
         D1KIJ2xe07zLuNY10wrqBofrYwVh7mF5ykgyeTSccLAAFyTiWOfIVoTz09G0ZwKpwHlD
         JgUmpeUwYis1x7k+Juqae6E9oEP/GowYOobfbItbXus28lsmdaOAzS/LqhSW5c6VeIQc
         oIcPMc0pCRQv2XjSXzij0SiVpSlGMhRQAE8/vtdvXUZOhdPu0qIusynMmIiwMlzE5ill
         u4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUbbsMSevKEC78HISZUZPHWD9AhAENvcxGvLUjsOCqq32Pz4RxlBdrstlTcI4YGNgOtqfC8Ojpa+QifPNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeBCebTaKOhYhOwU0xDijl5TSG2qtAhHEXDHKgQOd1vXJ3brml
	/81Nl0L57XcAdYX4ykYjyjm6C7d5t+03bHXZCDQnlouO3Y8KysDfJh0zt5LdAbT2/u9KZ60cljg
	RgIMu6v6YTc/Lb0uLZ4hLwLfOc1CRQCsRLS+OBOvDfg==
X-Gm-Gg: ASbGncukCKZv8h31VDedErCfeUa0JZn4Wtqb871chjF+KTVQux06ZaTWZ0syMNw1/wl
	oxVb3wjVKb+iXAgvXDuXVPe1Kd1n6lu0+az9y/cof0fkQMhrzb3abUc5Ss2QuaPO/Jrgy4pkhzE
	/7H5Pir4dbHcLumAqptrglgXyWra7y9yx6bjEEy3UibjZPur3ULZEjJuJ+9N8DzmgIpwFtvMoq7
	05bZyLUB8NcmzxrCA==
X-Google-Smtp-Source: AGHT+IE8AFltVgez4j91MqcXLZUWY1SjsHiyvDbOchLsj0qPF+cSQKWQwUdlDcjOa51JtKhpYUq7h1LMip4AqNUm6Pk=
X-Received: by 2002:a05:6512:1356:b0:55f:3b94:2119 with SMTP id
 2adb3069b0e04-55f5f08b2aemr1135534e87.45.1756415197186; Thu, 28 Aug 2025
 14:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821233335.1707559-1-da@libre.computer>
In-Reply-To: <20250821233335.1707559-1-da@libre.computer>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 23:06:25 +0200
X-Gm-Features: Ac12FXxq8e0j1LLbbJOtWrnp5TZSIUBHLi0lcAdK8TiCnwMxmLVQkeLVBf3QIC8
Message-ID: <CACRpkdYMdF43s_hcAvzHJ+wmRGyLoHtiTaG03ULoL24WwdQCMg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson-gxl: add missing i2c_d pinmux
To: Da Xue <da@libre.computer>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring <robh@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 22, 2025 at 1:33=E2=80=AFAM Da Xue <da@libre.computer> wrote:

> Amlogic GXL has 4 I2C attached to gpio-periphs. I2C_D is on GPIOX_10/11.
>
> Add the relevant func 3 pinmux per the datasheet for S805X/S905X/S905D.
>
> Fixes: 0f15f500ff2c ("pinctrl: meson: Add GXL pinctrl definitions")
> Signed-off-by: Da Xue <da@libre.computer>

Patch applied.

Yours,
Linus Walleij

