Return-Path: <linux-kernel+bounces-802347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EABDB45155
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3043A1C221D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF45C2FF178;
	Fri,  5 Sep 2025 08:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tph8Y3dQ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8669D2EBDC7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060847; cv=none; b=SSuxGS3J8zEIhgSD5u+oIEtz9JRZJC7BPf9RR5+OYWlUmXO8A1QXSlFYYsSfql1s742ePLxBLx1+KIVBjSL9xDgAVGykVkKT2DIICY0T+B8A6algqNJbT1LnY6/0NDhaey1Cli7bkqT6zUiYM4DqaNpIWwKr1WbtZLfoQeSeay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060847; c=relaxed/simple;
	bh=d50XR8Ek68VTj9Ma+5BQ3aLpOanjEBi3fnEwSp3JWkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sng2yTe1EKkKV/eojrM2C9qJ+zT5iR/OaZDpwrq8jS80A/f+7I1hmBYdUEp5HFrOE1zNgNcGnkjFh2EEQY4x+z1+LpVF5/a/Ntaqophs2YrEgHnTiWxC1ojAgc4kUK7M9AeAxdT/7REh4anfX580mDtJvzLKiIeytAyZ+LM+wqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tph8Y3dQ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f76454f69so1782665e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757060843; x=1757665643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HT51jpt+Z9rLQOZ4eY3k4SmSZF2os0NLvUCHbQ66xmE=;
        b=Tph8Y3dQkmS46e/hCZScFw+INv+3CP9okpqXVVmSVn+Z+DlvybG+/xlLEfsHWscrIQ
         maBNKpoZqwgrbX6j2Pbjfyjt6o2bJEUuUAeZXR743O5ixmh6+KlQqzukuzNOd7kUVvnN
         TkEojreIYS1S9TAnGzM/bCMiOLOP/O+MH5fBLh8ULq1U7WZUY68MFrpL/Xf2IJAJVdCG
         hyr6l76Vz0sUIXTUYYzfcElU+zJcQ08FJTtEHVCrAq30BaJMe8Qt0zH7I+e7n8G+Pxtz
         00swWK08MM/AdZPPbmrgE+c5ZcwvkALrKzBwmMbMu9SZC6b2OO+8UDb51NqyD3NKau6q
         oQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757060843; x=1757665643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HT51jpt+Z9rLQOZ4eY3k4SmSZF2os0NLvUCHbQ66xmE=;
        b=tsZ4JBCL4/M2UvNhg9BVI6JyABQLKhWy3t2T0OF0eo5mXO+5LKcyHoaCLcB5/yHEQQ
         CC2QsD+qgh9Ps1mGqHCBAXV4gFQ/yxa91iKVPC98m/L0/Zs78dpDc+4VUkZfLPDhBdex
         DFYJ1DBrSzmTvTZ3hUfA+FjwEYrVOkTxTk0YIYfIz6v1o/2s2O+chv1PSvBDWmPDaE+T
         vKPe5P2nhrtBb1BmPce67hqWpQfYT+9R3ZgdiksGw6LhEFuEutTgTQQx4GIPmHkuBVph
         ni7oPaDsgvxMxKA7kXHKYFizorSBCvvVVQvrsftJ5l0U5Osm69mbGEMzMwWhAQFrT0Vd
         RaQg==
X-Forwarded-Encrypted: i=1; AJvYcCWX6il8VeWdEK6R4fJRqF1Iqn/IBtFE6eL+w6/+e+2l4TTZ+JYbIlrPWkVrGijPDZaliyJJL+MPCcWtOjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjw6p7+JkCHZG1TKw7f3AshgQMjEqpdCT8DBqGNmLfzj9dqw2K
	g4cxeM4Vo/2c4j2VNpiqvBDXF3ip94zXsQsfcM/0jUfkHOVoK8Rhc75l5ng2MwUCgfPqU75QlCT
	W8AR92RZ+AzZMDFeBDtvH/0iEvlHzVjn2mIIbn/WcvQ==
X-Gm-Gg: ASbGncslEYm4hQjXuT3PC4hljzij//uxUGBp+VXFE90kg0UfQvxJ2zrXLm2e3mUUkbf
	SVOZaenUlzu/DD3czz48HiwJWCi9hk0VW17k2UDl37QV7QdUc4cyaXSdo2fNqn1fAugMbNQ4sVa
	xsOag4wbOFeohbsVffyVxMzujgnxG39TkI++fOaMikr6Leis/1bGAz48e8ej5RUZRfDJgpxe6/E
	H6khhM=
X-Google-Smtp-Source: AGHT+IHgClXJUzKdm6E0qr03i75G/PjSbG8pXmI/SkiwOzOUXWPeDlRcSIjt3v/vZ2+YkFRuc2QKV+aPlIPjoSHluJM=
X-Received: by 2002:a05:651c:198a:b0:339:1b5e:17b1 with SMTP id
 38308e7fff4ca-3391b5e19femr3818851fa.38.1757060843564; Fri, 05 Sep 2025
 01:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753039612.git.dan.carpenter@linaro.org> <6f732f53-7e00-4f0d-82a3-480bc81497bd@sabinyo.mountain>
In-Reply-To: <6f732f53-7e00-4f0d-82a3-480bc81497bd@sabinyo.mountain>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 5 Sep 2025 10:27:12 +0200
X-Gm-Features: Ac12FXyee60oY8WOLdfjOHFd8MRN0v_dxWT060-4JQvkwWFEV5hFh8euv1Jxz9o
Message-ID: <CACRpkdZ9EHoHiKit+T-ur0xDKMEoN_=TydzTfoggNBQGdra2bQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 4/7] pinctrl-scmi: add PIN_CONFIG_INPUT_VALUE
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
	Michal Simek <michal.simek@amd.com>, Cristian Marussi <cristian.marussi@arm.com>, 
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 20, 2025 at 9:39=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:

> In SCMI the value of the pin is just another configuration option.  Add
> this as an option in the pin_config_param enum and creating a mapping to
> SCMI_PIN_INPUT_VALUE in pinctrl_scmi_map_pinconf_type()
>
> Since this is an RFC patch, I'm going to comment that I think the SCMI
> pinctrl driver misuses the PIN_CONFIG_OUTPUT enum.  It should be for
> enabling and disabling output on pins which can serve as both input and
> output.  Enabling it is supposed to write a 1 and disabling it is
> supposed to write a 0 but we use that side effect to write 1s and 0s.  I
> did't change this because it would break userspace but I'd like to add a
> PIN_CONFIG_OUTPUT_VALUE enum as well and use that in the GPIO driver.
> But in this patchset I just use PIN_CONFIG_OUTPUT.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

I tweaked this patch around a bit and applied: removed the second comment
in the commit message and wrote the docs to be more generic since
in the future other things than SCMI might want to use this
config option.

Yours,
Linus Walleij

