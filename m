Return-Path: <linux-kernel+bounces-838798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C5EBB02C7
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 313BB7AC90C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4BF2D0605;
	Wed,  1 Oct 2025 11:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wUMoRGWn"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD952C21C1
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759318372; cv=none; b=lI7xs6l+yPthzhjIB9jjl6DINxAgZoMaBRBkgxNkB0XgdLLafUhr/m7nU8T7cnNF0FOxSZ12PxtndarBbUyTMl4x49qBIbij82nZBxDzdUHhGPQIVV35HhBBsijFMxMj+oFpOkXcq/BANsxEvD+daCYT6UhALaYAIaVxJjzZXxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759318372; c=relaxed/simple;
	bh=GLu3dPRpHTFCbLBOlfGANYWabao11//UUh+SE0dY1DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uozJL4s1Qa7bvNcf/knR/ce7sKiogYj8eBUzh0f7ZuyTS0cpA7Wtqg+KmcIDUTHuH+gXJ7i2K+ZUqyfklLJvfMYGRqzf77SxsD+jIiX3rSn9ahxO3WjLiZtDMCJW4x+LsAvbdfj0/4WwGRQwFEigQXiMR1PiWNazmDy3ixwGudU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wUMoRGWn; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-361d175c97fso66698211fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759318368; x=1759923168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIC9pcdw4oZg8H0ciygrp21hOqxgO22+2gefSNyYbK0=;
        b=wUMoRGWnA7Gl62il+4S8Py2jzA2nZbt+9UiFnu/M+3AAggkP9wv+f3VbcWQ/NAz3bk
         FFfDHbs7LuWdS5xTymlC7SO5HhKzIp4FFHcX8OAajWTfHoQrsnn/XFiNi9dpngxV9NB2
         1Nn1LqkNF9BZU08b1ceQWiFya7JZ7PzS9bBx06T+58KKHqP+lwi2UvOYwpCevc6ERE5+
         rYc82uy+gYAaS8vUdxokbJ9iHzke4ozyrBkhE1MmxBCDoaZSruVa1xTDqkLXHWTvAseF
         cr0OTxt7k1NLdFJ4delGfokTdoWu0KZz6AMblNO78PHPqmwnxz+pPaF0f14rjH8cv6vP
         Um7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759318368; x=1759923168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIC9pcdw4oZg8H0ciygrp21hOqxgO22+2gefSNyYbK0=;
        b=SqX1nNp5+Is9Ret1DZ/gDANgrIHzzo4tQ4JHcLmjfGKJGlEO6eHNqjBvcOLQctvUF4
         9GdAwjtCIdsvAElML5UMdj/AV/JmAPNh/RKs4bOy5V7sIbtCLal0G3sEh0/ob8WYmEhX
         j61Aui8zW6ij7CgBIfvFkL5Rmo89jwM39wLBWlPOVSF5dDfO1acW5ECx/5Zo1/CZ9ezF
         x3O7wVWGyxlPy4G2Er/CLAG5UE4avLheuY8IAqpLaU/JbmcU6iFSv/pxlLA8kVRo4DrF
         GWG3tqTqU/AQXtosAfW9V25XJqJddoibMTKmtl8awwqBHrLPCIHOASsF/D/szR/jrt3g
         Palw==
X-Forwarded-Encrypted: i=1; AJvYcCVd4q7jtGIIa1MKXJjzOof4XNHoPgFmujz0Bo8b7bd/lIaDo+6KJL/CuVSFiWGD3BVoPT89WpGR1KLJ0UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmM9yooE5iwUXu5p8ZrbFiMI20fXQpUvRMqk1ew29ex9ukH9K
	NO5xPBS9gWNq8AKQCbkrOu2TK+UC23jO9lqKOqlMcqjy3VSoAXCLLTDv4ZtFq9E16bwb2GgKRAL
	PLdTN9jiMpYAzizE5VxvO3RRbopAGupv9Jx1H1MIY7g==
X-Gm-Gg: ASbGncvLA5ZCoSYxXGQHFlLJr4LcLJ4ijItHvBOnTUtYAaSCO3KqC4vYFiM31XEzzH9
	D20MG4FT5r8uvm5+tBNgL+2BOQExKyiyaDoWgaWbc1W2x78jWgqZYqvIiepVK2r0P76d7qyipJy
	EI3mBhAEGWd9ihaD0UUEuV6hBI2n4IMotl2BjYGMw7NAw31cA/wUBSkjEPtBtX1XJQr1kQxeF/X
	fzm+hbxcKZHFYj4UJI7XLkXzcC8sDCfhedCw8FjIw==
X-Google-Smtp-Source: AGHT+IH027jDeEhl23sgvUXGSnUqHZdRDfuqPAZynY7f84Ovl67bSlzlYY8n8r1piqQWJzQhGq3jPmfYbFd5MNdKTPQ=
X-Received: by 2002:a05:651c:222a:b0:336:7a9a:1b16 with SMTP id
 38308e7fff4ca-373a710aac7mr6994261fa.14.1759318368220; Wed, 01 Oct 2025
 04:32:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-manpower-glacial-e9756c82b427@spud> <20250926-gilled-muppet-6ac08937cea6@spud>
In-Reply-To: <20250926-gilled-muppet-6ac08937cea6@spud>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 13:32:37 +0200
X-Gm-Features: AS18NWAjdrfYAW2A5c-n1rHHCx2KKNe8gHs1C1gvm3el8EHSAbW4Lu-GOc0xlys
Message-ID: <CACRpkdYoECsAGwUno0b_nz-iBB=iwO0Js_6k4O5k+xhig2NYkg@mail.gmail.com>
Subject: Re: [RFC 2/5] dt-bindings: pinctrl: add pic64gx "gpio2" pinmux
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 4:33=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:

> pin     role (1/0)
> ---     ----------
> E14     MAC_0_MDC/GPIO_2_0
> E15     MAC_0_MDIO/GPIO_2_1
> F16     MAC_1_MDC/GPIO_2_2
> F17     MAC_1_MDIO/GPIO_2_3

So this is a group you can name "mac_grp" and a function
you can name "mac".

> D19     SPI_0_CLK/GPIO_2_4
> B18     SPI_0_SS0/GPIO_2_5
(...)
> E19     SPI_0_DO/GPIO_2_10
> C7      SPI_0_DI/GPIO_2_11

These pins would be "spi0_grp", function "spi0".

etc. No need for "pinmux" properties just use classix
group and function strings.

Yours,
Linus Walleij

