Return-Path: <linux-kernel+bounces-794619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BEFB3E456
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5055B17FD80
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C330D149C6F;
	Mon,  1 Sep 2025 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBvrerwZ"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D6A19F11E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732321; cv=none; b=UGIClr8vTMVVf5wrCmiONiBfAqDDQWZBxg479eIcz/fyMMYOsArrwHe+FSvXup0zu+ofkEFbpxVGWZ39OTeAOPTw+Qo/mMwKk3qJ4W98zQM/xFK3+BtmjisAuZHbqDppJaCeqEpIBF++L82yNGA3h57JeQHuU5lt1hzNjI+eBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732321; c=relaxed/simple;
	bh=sObTShEZy2OUUveLhetL927VwP7OSOCCeucbREwYZSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrUg7/TN3fG9Oc+ClFhVs1qS5P/bErbO0QSpCW28k/pipswvhnolAyw6Zo9+U6tHfjhFh06wPhq2JyWZWVxtK0QphaHcVfvXYi9LfVl1/fIoSL0/5JP1UCFuoUOLaFlaOuEsyrN/hcmjbKNlI53ic4wLe5z9FCZVnV2Y9Tk1/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aBvrerwZ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55f78e3cdf9so1515367e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756732318; x=1757337118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sObTShEZy2OUUveLhetL927VwP7OSOCCeucbREwYZSc=;
        b=aBvrerwZ+FakjbUOtMQmkU+u7hxViHpJKgi1rMIr0m+Mpzj3EvUUpDFJFpQj5QvxDi
         eyC+l2/5ss3dRPl87HGrtWFc0zeeEAzd+19syYFq1zCOXyb4JcibHcamMAh9eGmEbd6R
         5YqeeuAiozNorbWuGz+OdOSqU8vw0KRMmMiH2vnChem0c18SnB4LkEVihxHKAbo9fFkU
         LPmLoM2IB4ncDjVKEKJ2KAp6dYC45MsBO0nPL6/yfEcZy8M6Yh/LXMYtSqQ52usMptp5
         1ZQetYjDtMWc+bUXlwkVsWWXnHflC40B2pz/0HPnYTAQyTtsBliXaP5p95xtv933jEpn
         GnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756732318; x=1757337118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sObTShEZy2OUUveLhetL927VwP7OSOCCeucbREwYZSc=;
        b=PzYJuiMLk0KR6qh0b0XhI21B8TAb8gXA7GA9OxZ/2Nm1jq8BY1jzaIlga+QaScVryW
         DVmEETZG9vSADNqx0GXDeoiKf4FN6qp5RSwJ9PhBmITwXhJGIuhrF20bfg5ApKdsQwYs
         bw4+hxGjkOpGEtMDdLH2nYy96vh8tKO4gaeaNWe2sd9eu677kLMHr/FP5iM/CCmCO5MP
         vllQ8rkIbM0erPKyijmsl+OSp3NQ35ljzIHDDHjukz+G3pEh1mq7Wy9BKPsG5nRl2S9k
         31272SRCJKu3ERiQF0LwWE3xZd7uWX1TrKePi7HuRZZJ4XGH+tHxjfYXdmReTnDtA5X6
         7YmA==
X-Forwarded-Encrypted: i=1; AJvYcCVzWOMEM9nM2SnqJR/0obKCaZ9kEM5PY29Q3j/fbKb2EEYx9Fp/uGpShNmysi/rqjNbyafJwc4GE10zBxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxltwTB8X01GIjrYvvRqI1u8wnJqwwCE+oDDWl0Zy5EL/0A4R
	X1R/XfW2/9eWFnfS7TumhVJHISlCiutksAQ/279EsyQn8UKVzSgR4lQxnhZ2Yr5A6G7EANxb9zi
	rfydYx5tQA5sg5ylKUDYoh05JOHvEGlpgQwnF2xBoQuv9VdKxh162G+s=
X-Gm-Gg: ASbGncvxeFtT2HvYnqnIwn+g7SajL0xYBwt30Et4TD41txy2dxKjgkuN3h4leCq9Jqm
	VfwzU0R6BvPm2nPDGGWx7rXuYI7rUldiiC+eMmgBTcGfSeV9CDu4njK13/FKQSe1L3R+AU84PKJ
	sVnzJ8gFGFNsGCY/UuhJADYRIS62nQ47XCnVZOTLvUePregExf5C7tYEhUyV3nk84OIBBKKHL7k
	YQkLZM=
X-Google-Smtp-Source: AGHT+IFq7h1lPoF+hrBQ3kLFvKvnvZ/34QfLPL/Ze8E58RG2MM4xOIC/Bsgm8sKFufC9Ni76c/KIQO1b5SuiDKts7XA=
X-Received: by 2002:a05:6512:4017:b0:55f:63ef:b2b3 with SMTP id
 2adb3069b0e04-55f708b7024mr1931724e87.22.1756732317565; Mon, 01 Sep 2025
 06:11:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831084958.431913-1-rongqianfeng@vivo.com> <20250831084958.431913-3-rongqianfeng@vivo.com>
In-Reply-To: <20250831084958.431913-3-rongqianfeng@vivo.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 1 Sep 2025 15:11:46 +0200
X-Gm-Features: Ac12FXxIooDBTyEdgDOjs8vx_SnAk6yJV02Zl1vZBspK7El30WHuPVZOHdwTquc
Message-ID: <CACRpkdbNDCXmWZ3AZS9SVJ7qzhprNTYCVympKQN7E9jdrDDzmg@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: ma35: Use int type to store negative error codes
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
	"moderated list:ARM/NUVOTON MA35 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	"open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 31, 2025 at 10:50=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.c=
om> wrote:

> Change the 'ret' variable in ma35_pinctrl_parse_functions() from u32 to
> int, as it needs to store either negative error codes or zero returned
> by ma35_pinctrl_parse_groups().
>
> No effect on runtime.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

This patch (2/3) applied for next in the pinctrl tree.

Yours,
Linus Walleij

