Return-Path: <linux-kernel+bounces-840806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3DBBB576C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EEB2E4E46DC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4D92264CD;
	Thu,  2 Oct 2025 21:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O+67RorE"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1952F2D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440347; cv=none; b=oX2LuAF+n3jG6tfpDgbEPzXMbB6Nu3ZruC9zjvm7Aj/JcdSwqj0EGsWAyB2jA0oOoUhDqjs7+yWmkuG5u4h+9J1ZXefHA7Xdn5Fu+7bLgzBe3rXX9K4voa07QMnveuPp9Cfm8CWfGDxO9MsdrsCLviTvM7eHKQ8DAXR/TnV7zuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440347; c=relaxed/simple;
	bh=Y2gBk5CB3GMJbnKWbC0U4OjbYTzYttD0oSvzvSM0NBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOakjUGlZAQ1gOowGujEa33ZAmUN9WgpaLkJZyoYRjNXWMBZneo+U3aIbng3Yr3H33bCfTs7+lvgzvXjw+7S2whyqw/f0hczxfFq6D8/vsMZjeyKcrIzhKRLOuS5uKbe4oT0x4EAGr1cLypz9TSlZjlEG/GGkWO4FY42p/lVkFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=O+67RorE; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1589196b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759440341; x=1760045141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/omh4dnkehdvWXPDDTiNzbxTABAKha3OuNX6oJKT2mA=;
        b=O+67RorETPhQUQKh63JhXwJXuAM7qhFrj3GNAIU4LqTntbWAlsaomDo36v6Tv5XINU
         8xExeIfYWWN90jF2YJQweIOEu2vnh69C+eu/8dfVF5Pce/JjMIFQyZ+aJg5OJNWMQOPM
         MDLBACDd0KzmNeTNyUMXXLeyh9CQEbOPTiNpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440341; x=1760045141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/omh4dnkehdvWXPDDTiNzbxTABAKha3OuNX6oJKT2mA=;
        b=N6RsH8LM4kvjtMDoiFyS+tNer224wlvo5gBTuqwW+KbEd4P7sPL3a6UCtmybpLrMWH
         k091d43b5BxoYpooIHrRsWUXj0Tl5LjTM6scQAEbQ/JRj6kt6dO32YV8c7k87KqZfnWU
         ck9/XdZl1If+ZIrH6wDjSC9fXUJJ1DKHm0pkZ9nLlvCxpl/4yiR1NdiQ4dMfk3uRHj5f
         AT0yUXM+pbZD9/YYp6PtzlHV/gxaKvqC0+rFgMLLzum3BtA7azYafNRrku2mmxbYMh6A
         BLce8S/EMAbPlwCT8ywl++qHdg1ko48BWapIF2YwYACLcauwKwh2VLoNLSOvoOYeewWp
         cG+w==
X-Forwarded-Encrypted: i=1; AJvYcCXTwyzDcZNpfff2z8t95LtD0KVb2dCU1rT0/TSbecFZU5mskJcOI62u7aIPjP9BzVp16sv9291SHNfzEAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJfESUiioeHPCqRluUnxggk96pjxk1qm/cL/YI1cmV7FcVFm8J
	rcINLKriYS1EkX1abNbbDk/Olp+CfvR5HjzwQ5/FXi9rJ8qBn24XfeHTQczbHwVcS80CGBOF1Di
	gTrc=
X-Gm-Gg: ASbGncvmN+meaNXa8RsDNJwsAOw1Np0Wd+td6XSG0IrqeDu4VZjCrrXTlmz9F117XUG
	usKUhSq/BAltfdR9LM1E0TZjnNu6N3SjlRCOa9UjgSF7Rpk7nkqNWalT23x+CIzWFgnlsGjbSc5
	B/2yPU3M259wQqYTadj+dfZue00Z9a0VevWJePKaoocvVaCWndslnt2KYvqrsNuAwuYwZjPgV/G
	cNzXYd5cz1ctMM2CSA330R4dFxfji0pwxMd8OE/LuEQiSA7JPk2eIq8QPmo0BpihPJIrg+YRGQ0
	opx3c/6q9QO8+od9jpGgf0dy9jsTvrc02u1N3v32QJdlNZ4p03/mj1VDTtKDNPUjswz+pP7zEHT
	HrggI/3DxL2A7rCcWwzqg+1jLBHbwQRk5eCebBWdAXW6WVIqUWsxLtn2m76lo+eOgxZf9v1LF2G
	4n0EYZ0rLC0ijPr+adD/2z
X-Google-Smtp-Source: AGHT+IEeXqQLcNN+uRkqkpelDA8aEbMmUg4MSL8n4SX75jS3GsPItbpZtQn44vkcSilEFy4mp08uew==
X-Received: by 2002:a05:6a20:7f8b:b0:2e3:a914:aacd with SMTP id adf61e73a8af0-32b61deea03mr983046637.2.1759440341255;
        Thu, 02 Oct 2025 14:25:41 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com. [209.85.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099ad9405sm2773836a12.10.2025.10.02.14.25.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 14:25:39 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32ec291a325so1149704a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:25:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOkhkM5Vls2QiX1DBZIPt7YNoxTD2UyErgNY4Vcklz9Q1swu61S4MTzpc5NpLzugJcvhfvb+JfmKelAj4=@vger.kernel.org
X-Received: by 2002:a17:90b:4a8f:b0:330:852e:2bcc with SMTP id
 98e67ed59e1d1-339c27b94e9mr883144a91.21.1759440338414; Thu, 02 Oct 2025
 14:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929142455.24883-1-clamor95@gmail.com> <20250929142455.24883-9-clamor95@gmail.com>
 <CAD=FV=VO2sXssuhZyz+aKvN22xH5eButHOQgKK+qEkPT3Ug2XQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VO2sXssuhZyz+aKvN22xH5eButHOQgKK+qEkPT3Ug2XQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 2 Oct 2025 14:25:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VOEDgUHG138d-_HyRX1EmeuZ=8v+2UL4cXQ0GN0e1FqQ@mail.gmail.com>
X-Gm-Features: AS18NWBl_-6A1NX6XipYEQi78zuUuxrbDfjw2_uXBU-dcpIdXNfIO_PqcqCT8kc
Message-ID: <CAD=FV=VOEDgUHG138d-_HyRX1EmeuZ=8v+2UL4cXQ0GN0e1FqQ@mail.gmail.com>
Subject: Re: [PATCH v1 8/8] gpu/drm: panel-edp: add AUO B116XAN02.0 panel entry
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 29, 2025 at 8:15=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Sep 29, 2025 at 7:25=E2=80=AFAM Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
> >
> > Add an eDP panel entry for AUO B116XAN02.0 used in Lenovo IdeaPad Yoga =
11
> > with Tegra 3 SoC.
> >
> > The raw edid of the panel is:
> >
> > 00 ff ff ff ff ff ff 00 06 af 5c 20 00 00 00 00
> > 00 16 01 04 90 1a 0e 78 02 99 85 95 55 56 92 28
> > 22 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> > 01 01 01 01 01 01 12 1b 56 5a 50 00 19 30 30 20
> > 46 00 00 90 10 00 00 18 00 00 00 0f 00 00 00 00
> > 00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41
> > 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe
> > 00 42 31 31 36 58 41 4e 30 32 2e 30 20 0a 00 f1
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed just this patch to drm-misc-next to get it out of the way,
since there are no dependencies.

[8/8] gpu/drm: panel-edp: add AUO B116XAN02.0 panel entry
      commit: 5b50bb435629ab206cfa1cca3d71847d4523f88b

