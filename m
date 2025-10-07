Return-Path: <linux-kernel+bounces-844738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1767FBC2A24
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 22:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2C63C6D30
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 20:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CBB23B61B;
	Tue,  7 Oct 2025 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEGsN72w"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3899221F1F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 20:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868547; cv=none; b=TeEWsPXE0QIHBLR3ZWOTXnpGQN3XWEm/Nqx8/pLUnidMWW1xtLJ+8lHk/sDQJ/a8ErUPP/+u3eXGQnDlcjOUDkX3dErd/53EyahnLhJBCIWz8Eu0RMhobPk767tvuKpefz3fYLftb8NXACdc6umlyVF4Md40wPcm/ml6x+G1us8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868547; c=relaxed/simple;
	bh=99kLDRNcHlgnavL66VTSyY3RE11yFNpexHuJRqTB2DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HaO4mt0vcfHBVc3prcDD6QOzVYQVytsGojeCPyn5NECdZkLMlO3CDE1L8mdunIdY48WCtY0HtV2CBbbRuC50OEE8Nt4273UqSnp5ZQip8oiDmnfLUWxqI2uyrn54Zr+5l6odycPMCvrNxE5O9SF4VyZpcd0UePtX+XMsedTcnAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jEGsN72w; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7b4f7a855baso4719707a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759868544; x=1760473344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99kLDRNcHlgnavL66VTSyY3RE11yFNpexHuJRqTB2DE=;
        b=jEGsN72wwWOYB1s9dDZGGjmxvsBoZaVh+7og/6APuboLh1rbaknQlyOxctsbGBXkVp
         uv7vebONGNKGMkZ7mREY/w/MJf4XI3hYghO3cc+zMf0vxBINOeoLB7PnWyLZzEMQUtFx
         rdvmvb8AGtaCjsi6YAoSD/LDUIW/pxZlgmN+2dQ8hOEM/obiNmiZn6rH/IO6c7lx6Bv1
         g0oj99/4xc52fFLubwL7DW8kPqj4fwy3YFD+JZ0ouuw7sfTg3odhTs8+dU+Qx44QrXwr
         /JTYSoeY9rtNYDC2fM6twa3OZfamtzMetoIH6M8Hy7VGEua4CCVp2JwztLXwXZST9L6C
         ropw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868544; x=1760473344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99kLDRNcHlgnavL66VTSyY3RE11yFNpexHuJRqTB2DE=;
        b=skODW8k8tSLljiWjFKJwJ7Bpa3U31XE6A1WGo94UjVsVb2+aeJKGziQELvVi1F+xDG
         4u5QgMGsV27XW00aatQ90G7DhI3F3Oj+vvuwjIgkEfP5aiHkCxQYRLDbT1M0HZ0aydO3
         IhRfnbakaZw8b29iundZfWI84EvHpgBNiqV3YAZ5gPTMG7NBh43BBDFAGPbv762dThBk
         IYjifyQWRi1eUMplPEjFow5aafQ5H/vBNkH164hA0yJqUFxPP3xDgyJmgFzSh03g6nUI
         4TwSfivwvht5UprLkKWSAsTNp/IU5cc9JJ0ASEi+GE8AQYn0gatePwmcR/GJ+j5R9Qux
         yXXA==
X-Forwarded-Encrypted: i=1; AJvYcCW96NwHrY20gN0ObVJfPxjta07FYDYVQjrrtjWwOrLQVxX/qdGM1FKMC41l0ZeEWbqjbtCbn/J00gEGB/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHavHVMJvnMoc13DNfikHsgVSwLMpP0IrgW3Rm1eYpM1YNhQd
	gF22SfkSm0sJHau56LzQ1kEU4E3cVlnzAfrsUV2lI2vrcQAZI/oT2n3KYP+tzv+Og41KHjbo2TX
	DLlCN6N6WEmXv+HWXL/SqOo0ZuDxO+VJCqZ/kh+XI+w==
X-Gm-Gg: ASbGnctKlBaOfEarX3b9nGPGngabo0G8O9iO01zDDi5hl+/sQnUrjWkXXApjkV6tPh1
	FZy3WbNF6kgPZ57ABCp5P7eLky896TIyeoxU1z//ts1gb49yMwLDAMNoMwRb47i1VpH3kEKobkr
	frmyYdeqq7iGkTf/bdSHiuJgqoNt//2lr2VXIKibgaS7JOzHWan1sgJhZPD2iY4ZsZuTgNSGYhh
	fWh8hjxQvMY1Arv8E+6N5+WCz3f8D52KgNQjQ==
X-Google-Smtp-Source: AGHT+IE/AGhWoEZF8eeHiwHizK+fQtU9vN562PI/VURhBYA8B0UfvYKXR081LitZs9K/HxZnjQrqasxdS5YMFPxMAew=
X-Received: by 2002:a05:6808:1586:b0:43f:2c27:b720 with SMTP id
 5614622812f47-4417b2fad79mr438719b6e.20.1759868543830; Tue, 07 Oct 2025
 13:22:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-power-domains-phy-samsung-usb3-drd-phy-v1-1-3cb5f80a72ef@linaro.org>
In-Reply-To: <20251007-power-domains-phy-samsung-usb3-drd-phy-v1-1-3cb5f80a72ef@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 7 Oct 2025 21:22:13 +0100
X-Gm-Features: AS18NWBUEeIDeP4sTK_A9MLo1ylabC6RjwGQmLe7UcknWuIT9I9jC3p7X44WHog
Message-ID: <CADrjBPokeXuKGQP1Pi6dwt46bYYTGOthfvFv=Zn3toi03wwDWA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: phy: samsung,usb3-drd-phy: add power-domains
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Oct 2025 at 17:00, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> The USB phy can be part of a power domain, so we need to allow the
> relevant property 'power-domains'.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

