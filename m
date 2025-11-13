Return-Path: <linux-kernel+bounces-899431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 426AAC57B99
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 14:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E83053441F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075881F91E3;
	Thu, 13 Nov 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8GpjPHj"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31BD15ADB4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041022; cv=none; b=rR6UFvCgvDq/9uJkQp0ji6pJYLj0GUOeDZmD2IaCGhnCIH+pjZmf9IcPmCmP8Kecxyw28G+VIw42lHlxNAPwH/bKLoe+ZPF8v6DXK+4Tcl6hPfTEeKw5f8p7ITnuOxryrKZrWJJ0G1LuQRslTa+i7g2rotBrp5Qnqe2JcIzNKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041022; c=relaxed/simple;
	bh=bQ+P52mNlITuRTiW9s5XEFgomZzd9bFBs7jFB6ckx4s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HqB0CJHPOpNtCQsd9pZhhba/MHSWvy4HcIWR7m5yHJRjkgWse2oVbX+VqDqpykwScOV+UDHvv+eq6kFL9wk10nyx31tlvPe2ACdvXuD4OJ9TyuXWzve5IYyF7x3RvTwsgh/hGzKQMT8yiWEGpWgfmd/rg2xN8uRsSSp8PbvxTIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N8GpjPHj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-477632d9326so5997045e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763041018; x=1763645818; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bQ+P52mNlITuRTiW9s5XEFgomZzd9bFBs7jFB6ckx4s=;
        b=N8GpjPHjPV+MezPF3iWHG7PwPq0xv/G87Yk4awggJ9C7SsfsNmEADgJMPGwYoAAcq3
         YO/t6JxN4Yt9Z/CzOV4abzojq6rSlj4gOYspoLGbj8nHGAsfs5zG/Cjw9UyJFf6NEC69
         EDU6RQYhOs9dh4TjmX7dtKGqnV6srSGEWVBykpn592BTDym68BwgT5pWf0wA9mNgKOg1
         IF1ALuG1Oj0xdNNv+y3ICIBCK/CxzJ48sWuX0pIyXCD4BXrPoC8VswfO70H4ox5u9d6i
         DR9lGdQ4Aj7jW0f/hOFsxiKPokDQbYpDDZxpzPk/xYknvXdvXe5fUrPH2d7HqI+ebpgp
         pgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763041018; x=1763645818;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQ+P52mNlITuRTiW9s5XEFgomZzd9bFBs7jFB6ckx4s=;
        b=xCcxp4bmnLOcCtwbbBQQewa4XutZpCRYH4LwV/xLC9LcymNw3sHaa30jnklEQz6Zdh
         6qGzO74K7qqGSkR1IodxNnbVWjZed7RIiIggrNXXpzhVQf01BMIROSK2f2TqzkpnJ4/R
         yX9nulkRGvnlJop+nvZgbSVuOd7/03Hso42AQqFfYADctLrRxttaflrdMcTMGSUpwkgY
         Hn1l4y+IOxalfI1SZ6GUNLpVpnKXOLIONwyIX8PAILYLMlFvFgqiCvUZhVHeT8IHDBP7
         pkyWpGGf45hcvXgvrpL8sbWCweJQPCf06NXE7f0lDAlvBi6bUh8oaKgm8nr1YGLZbme8
         S6yw==
X-Forwarded-Encrypted: i=1; AJvYcCW2hKlFBAE9xF0dm+6lCNc2mf+yK6aK780tSriMYjn4Uw67DyGTIHLM66UA1CczSRZ+GFyaPvRcpT3MWtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQzz5OAZlDIlkbpo6CnZXPS+3VVxSPZ9ZDDdx9b44h+gRUcpC
	7KCYbQNuoHwPO0Vpgu3uZONReRCE5jmxvegto48xfVdKvCSFWyjIThmGBZ322Mb62Kw=
X-Gm-Gg: ASbGncuGDUWzd09HH5GvwVP6IdD4sCLASlcPqvN7zPspQwYypkLWKHj/5nTx9/zn7iC
	MdzGHeKeCcT69Z1KB75zuL7K5s6FaqWEpHDdsuxElSe64MYeJff4ZuZ8n6Kxa8DI0+QOx67tGmZ
	u6uU7Wjp3r3ETfrHXPMs+zP8F0oz2Of3XTLKiTWpBXsjGAdIE5QdU1n5FOLVJBiSol8CLQLUjga
	wCjc1wuTWPsW73nQP07iesryik9e8SsdO+MMoS5jolJweu7fESqjBVtdehlcVHmvuhPuSkEuk/Q
	1kEz00EpXYjn+bGhF5l/KcjDXCUDf1djdzA3SMETgNurEVxuDd9k+dN8164+fOow4kO80/Hkaaa
	H0BS/ZV4HQQQYmIVFlgswptbRXY5rmnPxo8mEYPzGk99w/vP2U6GC/dMnbQyEyUUepjfPNrdIl9
	XN1wpyLyDouF7JKa8=
X-Google-Smtp-Source: AGHT+IEkKKvXAgOUI2Gp8aNFTSnGeJkVMys49MhyLUt2uRO+8qeq7VUrFz/uoy33AXxXBmgM6zvg9Q==
X-Received: by 2002:a05:600c:6305:b0:477:79cf:89d4 with SMTP id 5b1f17b1804b1-477870a6581mr59325775e9.31.1763041017943;
        Thu, 13 Nov 2025 05:36:57 -0800 (PST)
Received: from draszik.lan ([212.129.72.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e45677sm96382115e9.8.2025.11.13.05.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 05:36:57 -0800 (PST)
Message-ID: <5e58b99bc6d1ef9169a0600f6694c0ee34758389.camel@linaro.org>
Subject: Re: [PATCH v4 00/20] Samsung S2MPG10 regulator and S2MPG11 PMIC
 drivers
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, Rob Herring <robh@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>, Lee
 Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,  Bartosz
 Golaszewski	 <brgl@bgdev.pl>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Will McVicker
	 <willmcvicker@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Date: Thu, 13 Nov 2025 13:36:53 +0000
In-Reply-To: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
References: <20251110-s2mpg1x-regulators-v4-0-94c9e726d4ba@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-10 at 19:28 +0000, Andr=C3=A9 Draszik wrote:
> This series extends the existing S2MPG10 PMIC driver to add support for
> the regulators, and adds new S2MPG11 core and regulator drivers.
>=20
> [...]
>=20
> A DT update for Oriole / Raven to enable these is required which I will
> send out separately.

https://lore.kernel.org/all/20251113-s2mpg1x-regulators-dts-v1-1-80a70ef42b=
e1@linaro.org/

Cheers,
Andre'

