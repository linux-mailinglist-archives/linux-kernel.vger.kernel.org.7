Return-Path: <linux-kernel+bounces-734989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DDDB0892A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C4F1A61508
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D516128936D;
	Thu, 17 Jul 2025 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KwCM4q16"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AEE4503B;
	Thu, 17 Jul 2025 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744078; cv=none; b=Wd7ppCzZnad++klupTQN7vMGBzzXGqxnc1Gf3TMMaYSa7N1hSF7ZMXfD58jJh5bkNlR/N9p4aIwWGrUvirNRxGraCrDcUyiryjBACl2AaqJxQKIzoss7DiYB091uX3CpSFmVEDFnixbirzCzk7YryProI2Q1RTiIut4dsHhC2PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744078; c=relaxed/simple;
	bh=ghYODKwRN56ZF4az5gyzpDmfGnkll1VEDNzXJkGJV08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1dBOyxn5MNYoUJmMkBVCTxN2TUnTD1a3g9TfxrHYratEowBnsOb62em391u3fEj7+qCSss/jsUGjTQMUfQoF7ued1V946frw8UDV7CYeh7u5epvKOisQSJaajIuHcbU0XdXo1JC0Rf4cCP+Rs5oeK5P1/ru7zJkvT5fj7ixI5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KwCM4q16; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23dea2e01e4so8528805ad.1;
        Thu, 17 Jul 2025 02:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752744075; x=1753348875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghYODKwRN56ZF4az5gyzpDmfGnkll1VEDNzXJkGJV08=;
        b=KwCM4q16XwuaXyFI1NYXMnLcMmWSmOqNjCynEQW3mLeyuftMzeYvY1oMHMcXxO7fEd
         UdPnJqgSz9OMWdacJEbAg6oDBfBvqbb//ZQrYF6a8ETuw9m2r7zXf4WD+s8GBanpLRZs
         z+XZ2FJbloxKx+oI/irN+KllNpai/PDY/69xBY+sMs5OJqhPKRYr2aZvMEKOiPDQ+Ge8
         ksdj/4aRaoK0RnZ6d5zCD8rWT3Swc8kjMl6gDdOQxS4mhd1clTxQcIwP2hRXIy2rsJCo
         Mejbw7lrLWwZbt3DzpvakRcBVUNQ13maiNCDKp3CMLqoULD7gGTohvqJ6ikNfzML5F59
         uYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752744075; x=1753348875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghYODKwRN56ZF4az5gyzpDmfGnkll1VEDNzXJkGJV08=;
        b=TkabxaSAgAPgSJn3JTSSIOaQWwv6VGNVqckxiNvDWHQ6xu1agS+2NDu0F01sAaY04c
         hMZZQmXdEUIsDzLVF8xhGX05TSkMk2oOGupldVZerD+yo28iCdopLIylBhlhNOKp2yn0
         4L5dLMZ4pEL3M/CgyeMu7rP2bj7u0EPenY5SGhOqyq6wPRf+BV4LQzmxS9Z2pLQpf2DQ
         hZwKKkKw9+dD7+NEkfNXLwCFPsrTMBUUKupO8DgrOltQyntsTgcxvrxEJHxxIrfGB+tv
         C/6KUJys9x4Ztd8bWzXlV5lwGNohUhkDoUViJEDFFBdZbmVCtmPIiIa/tGyt64uUYHoD
         NDbA==
X-Forwarded-Encrypted: i=1; AJvYcCXClinLyTEQMLY+Xb0LMM+xpfVTa8Bm0jkhAQB02rdbmtKhR7NMSs8Qd9NnjNFfCcM/BdgupZ4RJbfERDxt@vger.kernel.org, AJvYcCXXuszv+8pU71HS/oMM5lfWQNB3HGFSS3MaBtcNeY65tJOHcatnOx7Zc1NibMHRULncjzrC/HejdQzr@vger.kernel.org
X-Gm-Message-State: AOJu0YxO3pkteZIujvHWOc3bT2PU+33M1iRMe1N6c+GAz6VHkAsvhuf6
	1eF0lsSP7MfamKa4W3XlBpvWffOc4A+gSYZZwYraSDI7Et630pjnwodkbpNKrLWq/BTYGfTjvqF
	aNtGvQ2okWxPiY1/2orllM3EkJzz6Bk9ZP9Ub
X-Gm-Gg: ASbGnctKeqER/cvAxMBreHzNTLlK1VNVKZdl4B+XW/GBboTG+v7C9ydRXwnNSppyXjc
	TexA15LDMxUZIwgEufUp7HYtCLeC4FAA5hLh/AUoP0suut/2hWutOWyq7rKs/nisYQ+i7c7Mues
	vhvFE7vMvWIrP/lrosvfFMFwTaa5aPtelFuqivuXNPmkIHfXy0iu92gVkUPtfM6m6M6cw2O1DKW
	bpHOVflWb/ly0WcJuv+NA==
X-Google-Smtp-Source: AGHT+IEcw73AwQCInDdk9e0fzVxi3F3aT9Uz+CuAK+CmNG9Ean6QVZRmPBfCDgf60QUEuP6JoBidzpPFe7BSToB5Gas=
X-Received: by 2002:a17:902:ea0c:b0:234:f580:9ed with SMTP id
 d9443c01a7336-23e256b4d4dmr80702645ad.21.1752744075391; Thu, 17 Jul 2025
 02:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717-fix-pwm-node-v1-1-45021777efa9@amlogic.com>
In-Reply-To: <20250717-fix-pwm-node-v1-1-45021777efa9@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 17 Jul 2025 11:21:04 +0200
X-Gm-Features: Ac12FXwP557lN0EiWARNaS9MW00Id1I7t6G7YIjyMJYQJpebiGcfQOd7_3xIoHM
Message-ID: <CAFBinCAs2Ra6GiF6y-EDPCZXoi6sM+wyPUWp0vE4UVbXByXa=g@mail.gmail.com>
Subject: Re: [PATCH] dts: arm: amlogic: fix pwm node for c3
To: xianwei.zhao@amlogic.com
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chuan Liu <chuan.liu@amlogic.com>, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jul 17, 2025 at 10:59=E2=80=AFAM Xianwei Zhao via B4 Relay
<devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
>
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>
> Fix reg address for c3 pwm node.
>
> Fixes: 431a5281e701 ("arm64: dts: amlogic: Add Amlogic C3 PWM")
Commit 431a5281e701 is "arm64: dts: amlogic: C3: Add clk-measure
controller node"
I think the correct commit hash is be90cd4bd422

The actual change itself is fine for me

