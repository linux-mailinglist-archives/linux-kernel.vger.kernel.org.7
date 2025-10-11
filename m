Return-Path: <linux-kernel+bounces-849187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A162BCF75B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 16:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9544F4E37CA
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB52F23A99F;
	Sat, 11 Oct 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuG9WHBO"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A167519DFAB
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760193080; cv=none; b=t8/pHHg28RGzpHq8IUOkyvcEWuzoKCkuknOwkpMNQoL5TDUUh7XehEuhy2nTVOeYLkTi1Dkg7XIzYW7rohe1g6IQ0YbL5aNzuCs0B/qkleCR0vhVStwYWjLcFy3T0J/44INp/349sywz2oVy8t+MHbMlgfZ3adWCPX8Zc1z25TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760193080; c=relaxed/simple;
	bh=XpzWd88TyI/XLI7Lya1GQD+iwyqcUR7IMgGr5vh19aQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNPNufv25+MWbsqJykVcJT2XduXlpMOuAUOYJrQGlmIidytiOIjwN/KGO+XBSw534Jci9Vb7CKT0ITBUlulGiiHyQHrxlGfuMQs7whQQzxLYLRaMK8K5AjFD4seuwLwM+XZBn7T4u+7nGrG8D+6nVlM7etdDHwdPJJH2dVsjNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuG9WHBO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-634a3327ff7so6098845a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760193077; x=1760797877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVMNRIG9FUKK8HBhJ3beHD14SK0gN6MU+q62w8zRjfA=;
        b=HuG9WHBOSxFZeoW6SqTTgPLZFNJFZDiq6yQ5ScTPhBXdiEYxXatVomVXZGV8kSYU0V
         sd27AHj2+QFWq3HZToB3dtyRDMdcjWVCHNDn4ekFNGd8JUjCR4Ja8shx3NQZGNbHHv02
         sAdll3L/Ut6XHTFja96PbO0tPpvN+E3W6nT4b4GbdtsqgZYwWXENy5SuhtZU8XWDVPCj
         cMwE3z4FC820k7oKPi1qLXCY3EDvgxTOpsz6qv2p53vIYoSMrOglzWPCh+gglmeydbJ0
         6acLJouIgjSCoZ1eS8CDpojZyvfomcaNeW3RUDNkGXhoH0neiXuQeAoKkMHYa22kjItx
         XKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760193077; x=1760797877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVMNRIG9FUKK8HBhJ3beHD14SK0gN6MU+q62w8zRjfA=;
        b=QQydvL8ZMFvMa5RtazsrO80qoZJASX90iImlFRonu4uco92TzxC1qYN7Y6kmVl1OSV
         hRMZ9jfuxsS+BzKT7HTtkVOJlmHfS1jgWx0kpCd1vAuI+fC1CUCAJVb8qznLFsFNvpsZ
         8UPvHG3mMBvl6Ig6lrNcXhMwykOGupZfzF2/LmhEWIUq0ZgGdRDhGj5Zfw0zAi1PtrV/
         Lk0pa994Q8FFvxdHF0OwmHkTvNTZU2p9JKz42fOtPnaBviwjhe6DzCrgmEDMi4peDVA+
         ysk1neYEHJuVWrZ/7tdqaqHSiNWXpJRmX2GtwZ7wHuypxULdX91ogTNfnp3xl1+oB5E3
         SnhA==
X-Forwarded-Encrypted: i=1; AJvYcCXEgwOJNho5UFK06/Sdm31fjIY4XSTrzv+KVD0os3MsRcruLw/+sBSQAqvztSH0EU+vC5nt8jjaVy0eSpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPzkGe/ZqHV9zpcbFWOYoQhnhiztfpKWOtxBWf8CwGYd5WOD2l
	FIepPritzYxD1KAl+V1VEEBU/ixP+DMn9BaaEpDzr4DCw0GE3xvBHMCD6pe+Nb2qNsG7pSAeTTV
	jC5vN3TrQAVRgYiQNTO8KmP+1O+Wm5t4=
X-Gm-Gg: ASbGnctiIaBc71Cp4J6jWf8xlMWwiMH85NbXmn1yo41MoaWCzsSur14H1kXkBXa6bok
	pueDalQm9QVy3cWfDmSObLHcjAlDFTlSmcY/EQYYYmb5ju8Tym2DKJmb8kd9sdLlJc6ooJ7IRsA
	DVYn53CVGXPvnQ0CF5SPVIN9Q+7albqXczDYQyDFvQQ38Mq1wyvDNZPpn2iitqi+iuNnhXSnXLb
	fzin2xQocGPJ8IvGzKUea4OEQ==
X-Google-Smtp-Source: AGHT+IHQvYIGg8dXvD2lz4y+qIlbjzYNb68twp7Yek0JvWJpIPtcgD0w142zadNgWyCvxFKj8ZxQdlP+k13p0MDYtR4=
X-Received: by 2002:a17:907:9407:b0:b39:2424:c699 with SMTP id
 a640c23a62f3a-b50acb0cc7cmr1519173166b.58.1760193076912; Sat, 11 Oct 2025
 07:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010191055.28708-1-rodrigo.gobbi.7@gmail.com>
In-Reply-To: <20251010191055.28708-1-rodrigo.gobbi.7@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 11 Oct 2025 17:30:40 +0300
X-Gm-Features: AS18NWC_RKLNboheFfBHXqm4NJ2o3N7E8VOiWl4ZcI2QzXvoRMJ20WcAp6ctO2o
Message-ID: <CAHp75VeZuKWxocVq21PCmPdP1P=wQQ75veOzyW-YJ+WW=HAaSQ@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: bmi270: fix dev_err_probe error msg
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: lanzano.alex@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, ~lkcamp/patches@lists.sr.ht, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 10:11=E2=80=AFPM Rodrigo Gobbi
<rodrigo.gobbi.7@gmail.com> wrote:
>
> The bmi270 can be connected to I2C or a SPI interface. If it is a SPI,
> during probe, if devm_regmap_init() fails, it should print the "spi"
> term rather "i2c".

rather than

...

>         if (IS_ERR(regmap))
>                 return dev_err_probe(dev, PTR_ERR(regmap),
> -                                    "Failed to init i2c regmap");
> +                                    "Failed to init spi regmap");

While at it, add a trailing \n.

--=20
With Best Regards,
Andy Shevchenko

