Return-Path: <linux-kernel+bounces-832947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667A9BA0D22
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255432A83EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039B130C60A;
	Thu, 25 Sep 2025 17:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkEBswHN"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521530CB22
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821017; cv=none; b=PgeSizUCfAeCZsID3G0oHPkUeoruK8dFDsD2F9bmfSrMZGEddq5lyD9xV+Qeq9H6PUzCHwCT3aRqTGwOylKdI2R5jTkw5ghGkGhF9pdM+wFLgwCTAW2UcrQGFVy1NRTbqJK5jQRUZEixOd4aL3gS40Sqe1zwaWNP2tWhmD+lpE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821017; c=relaxed/simple;
	bh=mIgpvG64sIBnmTtq6A62sqMEpK4YuNryBwwa9WFcehc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBGUFKWzbZbEqMkBIIzLbxzYoKREgCBAVUl95XjbK2WMZopD3C0M33Y2lGkeIEdQjEZxqUc4fxrpf05SQZEpSqxkhhK91O7S1OwGBcgwxziRSD14/R5JQ8QSGfbbH1JHc9iGea12i9EkhvCgTXI2VoOgFgHQDl7Tut49Yd2+lrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkEBswHN; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-54a86cc950dso209558e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758821015; x=1759425815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yoJlz97xuece5TQCQM1B1wkTmSuFzsKn0viaadeiiFw=;
        b=CkEBswHN+tDCujdSwwpkjKE1+6RTN9Kxe78bPHTa794zv7p0YhBJuv1ONA5EW1t+el
         Zw7OBxm6cPsELC042H2XFwrq/J88RYQlZ+g8baBkJA0SJ32srnDkYvxgYZkkRmCF1uVV
         AU5esSl3NSgXRHCfUwKNcqFKPUCocEHg/Ri4u8x+Q96mbYxJMaOKmFoOyuoozHm6DpQw
         cY8F6OoDWyX8e0p6Nc4slxemIwGUkYR+0OzYKO3/Qv8B4PxQ6GR5LUUTCZa70WchrwVo
         XuWfciaP+VdJq/7HBXF/2ngTZzrQi7VIHwgZUXACWXChBYiy2A9TqBg6NMjLNHi96cPj
         iS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758821015; x=1759425815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yoJlz97xuece5TQCQM1B1wkTmSuFzsKn0viaadeiiFw=;
        b=S4SokbtxWdiq/E0yXeemt0KOz/B0Xb4YAoBto9hxDRRLLyDM17jlFhXzxY8/YodAlw
         uAYcyXDuA5eu+jHWwZk1dMLGbln82FRKqQBhGVaLWqWdt5qexou3QM6UJeTUOfT80I2X
         zOmRiiA4JV4XzcbLyThARCow4A9dgOHDUmjjnhuuYik5oDSpnI0xB67NtQ8QUBFRfkcg
         uwJidVdIse1uGIifU/ENdph0zPiKD4dX2tmLkRDHtVQsyz0iPhtjjS/QI7eZ8KjlsPmb
         5XDpxe8J9RzvcKz4s4vxfSpYckPFYcOhy9/AA78gBRmO1lJCZ7TtUTrcaaKDnXT4b1Em
         nMwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwXymdKA5mpbPwNPJB682TYgBSZX8dlUMDfb3CK2YbI/QqMDaBrXtAvteZlY2g54Xx28W+HMDelMIuxow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRHQLYvhdQcCcSo+p3h+C0GbPadV+6ZXOtg3Q4reMskRwfDs8n
	VEhE2F3l9CI+pdJPPRmEVkaXnCtQOfigFELeJGp4a8cjfrLEmJgunNsFrOt5Q8T5gJcNf0iCVQp
	61FGP2pEq7rp/4nQBVRkiqvCZ58nyJXU=
X-Gm-Gg: ASbGnctiijBI1+qBL2Nu70DQQYrK8xWjOI+A3+/DRwp9pt0EKtaIlPN0zU2Ef8Exsby
	6vJ63Xklwhg+cINHqDDA7awqiNON+vOuv4gqBGq41wEo/XjS0rrqz+PEVxVxTgrnDt5OykhXCW4
	d9BwOfUY4a5CHvwfmmZPM04RvMSsjLmFcL/OAwk2yDttVlnfXOe4htAI+Uyxidywb+8QOtRDscs
	frPFA==
X-Google-Smtp-Source: AGHT+IGLTVyOjql1IBV+3r9vWjKPUqOMtpaaeenoCklqNxWnUWeJ8b3WEoSwccscLA90xqvIYCWGqDCvejXLyl62Ctw=
X-Received: by 2002:a05:6122:1699:b0:538:d49b:719 with SMTP id
 71dfb90a1353d-54bea0b8581mr1689486e0c.1.1758821014777; Thu, 25 Sep 2025
 10:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920-max77705_77976_charger_improvement-v5-1-aab0aef82cc4@gmail.com>
 <cctdvj7jsf5ng3ab5vyhzjn73u6wqye3kcrgfj4tugpd32zj4f@o5buyuu7mmns>
In-Reply-To: <cctdvj7jsf5ng3ab5vyhzjn73u6wqye3kcrgfj4tugpd32zj4f@o5buyuu7mmns>
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Thu, 25 Sep 2025 20:23:23 +0300
X-Gm-Features: AS18NWDBOaX_uIvZHtsH5sQvf279L13S4qpKC1Le8U86Mw6sY7N2fY0VccrGhxQ
Message-ID: <CABTCjFBhs3Wh39aiSfLbXKEbB+Hu8ERiok+ueNDRP7ypc3ARyA@mail.gmail.com>
Subject: Re: [PATCH v5] power: supply: max77705_charger: implement aicl feature
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 23 =D1=81=D0=B5=D0=BD=D1=82. 2025=E2=80=AF=D0=B3. =D0=B2 01:2=
8, Sebastian Reichel
<sebastian.reichel@collabora.com>:
>
>
> After looking at this again in this simpler version: Why do you
> need the delayed work at all? It seems you can simplify to this:
>
> static irqreturn_t max77705_aicl_irq(int irq, void *irq_drv_data)
> {
>     struct max77705_charger_data *chg =3D irq_drv_data;
>     unsigned int regval, irq_status;
>     int err;
>
>     do {
>         regmap_read(chg->regmap, MAX77705_CHG_REG_INT_OK, &irq_status);
>         if (!(irq_status & BIT(MAX77705_AICL_I))) {
>             err =3D regmap_field_read(chg->rfield[MAX77705_CHG_CHGIN_LIM]=
, &regval);
>             if (err < 0)
>                 continue;
>
>             regval--;
>
>             err =3D regmap_field_write(chg->rfield[MAX77705_CHG_CHGIN_LIM=
], regval);
>             if (err < 0)
>                 continue;
>
>             msleep(AICL_WORK_DELAY_MS);
>         }
>     } while(irq_status & BIT(MAX77705_AICL_I));
>
>     return IRQ_HANDLED;
> }
>

That long interrupt handler with sleep tricked me, because there's the
concept of
as short as possible irq handler. However, I realise now, this is a bottom
half threaded interrupt handler, so as short as possible may be ignored her=
e.

--=20
Best regards and thanks for review,
Dzmitry

